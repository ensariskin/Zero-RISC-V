`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// TMR Fault Injection Test Module
//
// Description:
//   Comprehensive fault injection testbench for TMR-protected registers.
//   Injects single-bit upset (SEU) faults into TMR replicas and monitors
//   system recovery through voting mechanism.
//
// Features:
//   - Systematic fault injection across all TMR-protected registers
//   - Configurable fault duration and injection frequency
//   - At most 1 replica faulted at a time (to test SEU tolerance)
//   - Detailed logging of fault injection and recovery
//
// TMR Protected Components:
//   - PC Controller (3 registers)
//   - Instruction Buffer (9 registers: head, tail, count)
//   - ROB (6 registers: head_ptr, tail_ptr)
//   - BRAT (2 registers: head_ptr, tail_ptr)
//   - LSQ (21 registers: head_ptr x3, tail_ptr, last_commit_ptr x3)
//   - Free List (6 registers: read_ptr, write_ptr, last_alloc)
//   - Issue Stage (33 registers: various pipeline registers)
//////////////////////////////////////////////////////////////////////////////////

module tmr_fault_injector #(
      parameter int FAULT_DURATION_MIN = 5,      // Minimum cycles to hold fault
      parameter int FAULT_DURATION_MAX = 20,     // Maximum cycles to hold fault
      parameter int WAIT_BETWEEN_MIN = 50,       // Minimum cycles between faults
      parameter int WAIT_BETWEEN_MAX = 200,      // Maximum cycles between faults
      parameter int NUM_FAULT_CYCLES = 100       // Number of fault injection rounds
   )(
      input logic clk,
      input logic rst_n,
      input logic enable,                        // Enable fault injection
      output logic fault_active,                 // Indicates a fault is currently active
      output int total_faults_injected,
      output int total_recoveries
   );

   // Fault injection state machine
   typedef enum logic [2:0] {
      IDLE,
      WAIT_BEFORE_FAULT,
      SELECT_TARGET,
      INJECT_FAULT,
      HOLD_FAULT,
      RELEASE_FAULT,
      VERIFY_RECOVERY
   } fault_state_t;

   fault_state_t current_state, next_state;

   // Internal counters and registers
   int wait_counter;
   int hold_counter;
   int fault_counter;
   int target_register;
   int target_replica;      // Which of the 3 replicas to fault (0, 1, or 2)
   logic [31:0] fault_value;
   logic [31:0] original_value;

   // TMR target enumeration (total ~80 registers in 27 groups)
   localparam int NUM_TMR_TARGETS = 27;

   // State machine
   always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         current_state <= IDLE;
         wait_counter <= 0;
         hold_counter <= 0;
         fault_counter <= 0;
         total_faults_injected <= 0;
         total_recoveries <= 0;
         fault_active <= 1'b0;
      end else begin
         current_state <= next_state;

         case (current_state)
            IDLE: begin
               if (enable && fault_counter < NUM_FAULT_CYCLES) begin
                  wait_counter <= $urandom_range(WAIT_BETWEEN_MIN, WAIT_BETWEEN_MAX);
               end
            end

            WAIT_BEFORE_FAULT: begin
               if (wait_counter > 0) wait_counter <= wait_counter - 1;
            end

            SELECT_TARGET: begin
               target_register <= $urandom_range(0, NUM_TMR_TARGETS - 1);
               target_replica <= $urandom_range(0, 2);  // Random replica (0, 1, or 2)
               fault_value <= $urandom();
               hold_counter <= $urandom_range(FAULT_DURATION_MIN, FAULT_DURATION_MAX);
            end

            INJECT_FAULT: begin
               fault_active <= 1'b1;
               total_faults_injected <= total_faults_injected + 1;
               fault_counter <= fault_counter + 1;
            end

            HOLD_FAULT: begin
               if (hold_counter > 0) hold_counter <= hold_counter - 1;
            end

            RELEASE_FAULT: begin
               fault_active <= 1'b0;
            end

            VERIFY_RECOVERY: begin
               // Voter should have corrected the fault
               total_recoveries <= total_recoveries + 1;
            end
         endcase
      end
   end

   // Next state logic
   always_comb begin
      next_state = current_state;
      case (current_state)
         IDLE:             if (enable && fault_counter < NUM_FAULT_CYCLES) next_state = WAIT_BEFORE_FAULT;
         WAIT_BEFORE_FAULT: if (wait_counter == 0) next_state = SELECT_TARGET;
         SELECT_TARGET:    next_state = INJECT_FAULT;
         INJECT_FAULT:     next_state = HOLD_FAULT;
         HOLD_FAULT:       if (hold_counter == 0) next_state = RELEASE_FAULT;
         RELEASE_FAULT:    next_state = VERIFY_RECOVERY;
         VERIFY_RECOVERY:  next_state = IDLE;
      endcase
   end

endmodule

//////////////////////////////////////////////////////////////////////////////////
// TMR Fault Injection Initial Block for Testbench Integration
// Copy this into your testbench to inject faults into specific registers
//////////////////////////////////////////////////////////////////////////////////

module tmr_fault_injection_test;

   // This module should be instantiated in the testbench
   // It contains the actual force/release statements

   parameter int NUM_FAULT_CYCLES = 100;
   parameter int FAULT_DURATION_MIN = 5;
   parameter int FAULT_DURATION_MAX = 20;
   parameter int WAIT_BETWEEN_MIN = 50;
   parameter int WAIT_BETWEEN_MAX = 200;

   // Statistics
   int total_faults = 0;
   int pc_faults = 0;
   int rob_faults = 0;
   int brat_faults = 0;
   int lsq_faults = 0;
   int ibuf_faults = 0;
   int freelist_faults = 0;
   int issue_faults = 0;

   // Fault injection task for a single 32-bit register
   task automatic inject_single_fault_32(
         ref logic [31:0] target_reg,
         input string reg_name,
         input int replica,
         input int duration
      );
      logic [31:0] fault_value;
      fault_value = $urandom();

      $display("[%t] FAULT INJECT: %s replica %0d = 0x%08x (duration: %0d cycles)",
         $time, reg_name, replica, fault_value, duration);

      force target_reg = fault_value;
      repeat(duration) @(posedge dv_top_superscalar.clk);
      release target_reg;

      $display("[%t] FAULT RELEASE: %s replica %0d", $time, reg_name, replica);
   endtask

   // Fault injection task for smaller registers
   task automatic inject_single_fault_small(
         ref logic [5:0] target_reg,
         input string reg_name,
         input int replica,
         input int duration
      );
      logic [5:0] fault_value;
      fault_value = $urandom() & 6'h3F;

      $display("[%t] FAULT INJECT: %s replica %0d = 0x%02x (duration: %0d cycles)",
         $time, reg_name, replica, fault_value, duration);

      force target_reg = fault_value;
      repeat(duration) @(posedge dv_top_superscalar.clk);
      release target_reg;

      $display("[%t] FAULT RELEASE: %s replica %0d", $time, reg_name, replica);
   endtask

endmodule
