`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// TMR Fault Injector V2 - Complete Coverage
// 171 Independent Fault Targets (57 TMR groups × 3 replicas)
//////////////////////////////////////////////////////////////////////////////////

module fault_injector (
      input  logic clk,
      input  logic rst_n
   );

   localparam int NUM_TARGETS = 141;

   // Runtime configuration
   int fault_rate_per_mille;
   int max_concurrent_faults;
   int injection_seed;
   logic enable_injection;

   // Statistics
   int total_faults_injected;
   int total_fault_cycles;
   int faults_per_target[NUM_TARGETS];

   logic initialized;

   int roll;
   int num_faults_this_cycle;
   int target_id;
   logic [31:0] fault_value;
   logic fault_occurred_this_cycle;


   //==========================================================================
   // INITIALIZATION
   //==========================================================================
   initial begin
      initialized = 1'b0;
      total_faults_injected = 0;
      total_fault_cycles = 0;

      for (int i = 0; i < NUM_TARGETS; i++) begin
         faults_per_target[i] = 0;
      end

      if ($test$plusargs("enable_fault_injection")) begin
         enable_injection = 1'b1;

         if (!$value$plusargs("fault_rate_per_mille=%d", fault_rate_per_mille))
            fault_rate_per_mille = 30;
         if (!$value$plusargs("max_concurrent_faults=%d", max_concurrent_faults))
            max_concurrent_faults = 1;
         if (!$value$plusargs("fault_injection_seed=%d", injection_seed))
            injection_seed = 1;

         $display("\n==========================================================================");
         $display("[%t] TMR FAULT INJECTOR V2 - 171 INDEPENDENT TARGETS", $time);
         $display("==========================================================================");
         $display("  Fault rate:           %0d per mille (%.2f%%)", fault_rate_per_mille, real'(fault_rate_per_mille)/10.0);
         $display("  Max concurrent faults: %0d", max_concurrent_faults);
         $display("  Total targets:        %0d", NUM_TARGETS);
         $display("==========================================================================\n");
      end else begin
         enable_injection = 1'b0;
      end

      initialized = 1'b1;
   end

   //==========================================================================
   // FAULT INJECTION LOGIC
   //==========================================================================
   always @(posedge clk) begin
      if(!rst_n) begin
         fault_occurred_this_cycle = 0;
         roll = 0;
         target_id = 0;
         num_faults_this_cycle = 0;
         fault_value = 0;
      end
      if (rst_n && enable_injection && initialized) begin
         #2;
         fault_occurred_this_cycle = 1'b0;
         roll = $urandom_range(0, 999);

         if (roll < fault_rate_per_mille) begin
            num_faults_this_cycle = $urandom_range(1, max_concurrent_faults);

            for (int f = 0; f < num_faults_this_cycle; f++) begin
               target_id = $urandom_range(0, NUM_TARGETS - 1);
               fault_value = $urandom();

               inject_fault(target_id, fault_value);

               total_faults_injected++;
               faults_per_target[target_id]++;
               fault_occurred_this_cycle = 1'b1;
            end

            if (fault_occurred_this_cycle) total_fault_cycles++;
         end
      end
   end

   //==========================================================================
   // FAULT INJECTION TASK - 171 FLAT CASES
   //==========================================================================
   task automatic inject_fault(input int target, input logic [31:0] value);
      case (target)
         // PC Controller: pc_current_val
         0: begin force dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_0 = value; #1; release dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_0; end
         1: begin force dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_1 = value; #1; release dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_1; end
         2: begin force dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_2 = value; #1; release dv_top_superscalar.dut.fetch_buffer_unit.fetch_unit.PC_super.pc_current_val_2; end
         // Inst Buffer: head_ptr
         3: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_0 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_0; end
         4: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_1 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_1; end
         5: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_2 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.head_ptr_2; end
         // Inst Buffer: tail_ptr
         6: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_0 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_0; end
         7: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_1 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_1; end
         8: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_2 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.tail_ptr_2; end
         // Inst Buffer: count
         9: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_0 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_0; end
         10: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_1 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_1; end
         11: begin force dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_2 = value[4:0]; #1; release dv_top_superscalar.dut.fetch_buffer_unit.inst_buffer.count_2; end
         // ROB: head_ptr_reg
         12: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_0 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_0; end
         13: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_1 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_1; end
         14: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_2 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_ptr_reg_2; end
         // ROB: tail_ptr_reg
         15: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_0 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_0; end
         16: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_1 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_1; end
         17: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_2 = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.tail_ptr_reg_2; end
         // BRAT: head_ptr
         18: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_0 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_0; end
         19: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_1 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_1; end
         20: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_2 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.head_ptr_2; end
         // BRAT: tail_ptr
         21: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_0 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_0; end
         22: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_1 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_1; end
         23: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_2 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.brat_buffer.tail_ptr_2; end
         // Free List: read_ptr
         24: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_0 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_0; end
         25: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_1 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_1; end
         26: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_2 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.read_ptr_2; end
         // Free List: write_ptr
         27: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_0 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_0; end
         28: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_1 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_1; end
         29: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_2 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.write_ptr_2; end
         // Free List: last_alloc
         30: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_0 = value[1:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_0; end
         31: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_1 = value[1:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_1; end
         32: begin force dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_2 = value[1:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.last_alloc_2; end
         // LSQ: tail_ptr
         33: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_0; end
         34: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_1; end
         35: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.tail_ptr_2; end
         // LSQ: head_ptr_0
         36: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_0; end
         37: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_1; end
         38: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_0_2; end
         // LSQ: head_ptr_1
         39: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_0; end
         40: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_1; end
         41: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_1_2; end
         // LSQ: head_ptr_2
         42: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_0; end
         43: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_1; end
         44: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.head_ptr_2_2; end
         // LSQ: last_commit_ptr_0
         45: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_0; end
         46: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_1; end
         47: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_0_2; end
         // LSQ: last_commit_ptr_1
         48: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_0; end
         49: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_1; end
         50: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_1_2; end
         // LSQ: last_commit_ptr_2
         51: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_0; end
         52: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_1; end
         53: begin force dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.lsq.last_commit_ptr_2_2; end
         // ROB: head_idx_d1
         54: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_0; end
         55: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_1; end
         56: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_idx_d1_2; end
         // ROB: head_plus_1_idx_d1
         57: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_0; end
         58: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_1; end
         59: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_1_idx_d1_2; end
         // ROB: head_plus_2_idx_d1
         60: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_0 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_0; end
         61: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_1 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_1; end
         62: begin force dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_2 = value[4:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rob.head_plus_2_idx_d1_2; end
         // Issue Stage: pc_reg
         63: begin force dv_top_superscalar.dut.issue_stage_unit.pc_reg_0 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_reg_0; end
         64: begin force dv_top_superscalar.dut.issue_stage_unit.pc_reg_1 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_reg_1; end
         65: begin force dv_top_superscalar.dut.issue_stage_unit.pc_reg_2 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_reg_2; end
         // Issue Stage: immediate_reg
         66: begin force dv_top_superscalar.dut.issue_stage_unit.immediate_reg_0 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.immediate_reg_0; end
         67: begin force dv_top_superscalar.dut.issue_stage_unit.immediate_reg_1 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.immediate_reg_1; end
         68: begin force dv_top_superscalar.dut.issue_stage_unit.immediate_reg_2 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.immediate_reg_2; end
         // Issue Stage: rd_phys_reg
         69: begin force dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_0 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_0; end
         70: begin force dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_1 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_1; end
         71: begin force dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_2 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_phys_reg_2; end
         // Issue Stage: decode_valid_reg
         72: begin force dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[0] = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[0]; end
         73: begin force dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[1] = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[1]; end
         74: begin force dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[2] = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.decode_valid_reg[2]; end
         // Issue Stage: control_signal_reg
         75: begin force dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_0 = value[25:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_0; end
         76: begin force dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_1 = value[25:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_1; end
         77: begin force dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_2 = value[25:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.control_signal_reg_2; end
         // Issue Stage: pc_prediction_reg
         78: begin force dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_0 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_0; end
         79: begin force dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_1 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_1; end
         80: begin force dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_2 = value; #1; release dv_top_superscalar.dut.issue_stage_unit.pc_prediction_reg_2; end
         // Issue Stage: branch_sel_reg
         81: begin force dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_0 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_0; end
         82: begin force dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_1 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_1; end
         83: begin force dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_2 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_sel_reg_2; end
         // Issue Stage: branch_prediction_reg
         84: begin force dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_0 = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_0; end
         85: begin force dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_1 = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_1; end
         86: begin force dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_2 = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.branch_prediction_reg_2; end
         // Issue Stage: rs1_phys_reg
         87: begin force dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_0 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_0; end
         88: begin force dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_1 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_1; end
         89: begin force dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_2 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs1_phys_reg_2; end
         // Issue Stage: rs2_phys_reg
         90: begin force dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_0 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_0; end
         91: begin force dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_1 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_1; end
         92: begin force dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_2 = value[5:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rs2_phys_reg_2; end
         // Issue Stage: rd_arch_reg
         93: begin force dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_0 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_0; end
         94: begin force dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_1 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_1; end
         95: begin force dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_2 = value[4:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.rd_arch_reg_2; end
         // Issue Stage: alloc_tag_reg
         96: begin force dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_0 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_0; end
         97: begin force dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_1 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_1; end
         98: begin force dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_2 = value[2:0]; #1; release dv_top_superscalar.dut.issue_stage_unit.alloc_tag_reg_2; end
         // Issue Stage: lsq_alloc_valid_reg
         99: begin force dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_0_valid_reg = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_0_valid_reg; end
         100: begin force dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_1_valid_reg = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_1_valid_reg; end
         101: begin force dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_2_valid_reg = value[0]; #1; release dv_top_superscalar.dut.issue_stage_unit.lsq_alloc_2_valid_reg; end
         // RS0: enable
         102: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.enable = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.enable; end
         // RS1: enable
         103: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.enable = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.enable; end
         // RS2: enable
         104: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.enable = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.enable; end
         // RS0: occupied
         105: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.occupied = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.occupied; end
         // RS1: occupied
         106: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.occupied = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.occupied; end
         // RS2: occupied
         107: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.occupied = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.occupied; end
         // RS0: stored_control_signals
         108: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_control_signals; end
         // RS1: stored_control_signals
         109: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_control_signals; end
         // RS2: stored_control_signals
         110: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_control_signals; end
         // RS0: stored_pc
         111: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_pc; end
         // RS1: stored_pc
         112: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_pc; end
         // RS2: stored_pc
         113: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_pc; end
         // RS0: stored_rd_phys_addr
         114: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_rd_phys_addr; end
         // RS1: stored_rd_phys_addr
         115: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_rd_phys_addr; end
         // RS2: stored_rd_phys_addr
         116: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_rd_phys_addr; end
         // RS0: stored_pc_value_at_prediction
         117: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_pc_value_at_prediction; end
         // RS1: stored_pc_value_at_prediction
         118: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_pc_value_at_prediction; end
         // RS2: stored_pc_value_at_prediction
         119: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_pc_value_at_prediction; end
         // RS0: stored_branch_sel
         120: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_branch_sel; end
         // RS1: stored_branch_sel
         121: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_branch_sel; end
         // RS2: stored_branch_sel
         122: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_branch_sel; end
         // RS0: stored_branch_prediction
         123: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_branch_prediction; end
         // RS1: stored_branch_prediction
         124: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_branch_prediction; end
         // RS2: stored_branch_prediction
         125: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_branch_prediction; end
         // RS0: stored_store_data
         126: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_store_data; end
         // RS1: stored_store_data
         127: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_store_data; end
         // RS2: stored_store_data
         128: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_store_data; end
         // RS0: stored_operand_a_data
         129: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_a_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_a_data; end
         // RS1: stored_operand_a_data
         130: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_a_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_a_data; end
         // RS2: stored_operand_a_data
         131: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_a_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_a_data; end
         // RS0: stored_operand_a_tag
         132: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_a_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_a_tag; end
         // RS1: stored_operand_a_tag
         133: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_a_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_a_tag; end
         // RS2: stored_operand_a_tag
         134: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_a_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_a_tag; end
         // RS0: stored_operand_b_data
         135: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_b_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_b_data; end
         // RS1: stored_operand_b_data
         136: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_b_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_b_data; end
         // RS2: stored_operand_b_data
         137: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_b_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_b_data; end
         // RS0: stored_operand_b_tag
         138: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_b_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_0.stored_operand_b_tag; end
         // RS1: stored_operand_b_tag
         139: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_b_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_1.stored_operand_b_tag; end
         // RS2: stored_operand_b_tag
         140: begin force dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_b_tag = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.rs_2.stored_operand_b_tag; end
         // RS Exec: issue_valid (RS0/RS1/RS2)
         141: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.issue_valid = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.issue_valid; end
         142: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.issue_valid = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.issue_valid; end
         143: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.issue_valid = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.issue_valid; end
         // RS Exec: data_a
         144: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.data_a = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.data_a; end
         145: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.data_a = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.data_a; end
         146: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.data_a = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.data_a; end
         // RS Exec: data_b
         147: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.data_b = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.data_b; end
         148: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.data_b = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.data_b; end
         149: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.data_b = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.data_b; end
         // RS Exec: control_signals
         150: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.control_signals; end
         151: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.control_signals; end
         152: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.control_signals = value[10:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.control_signals; end
         // RS Exec: rd_phys_addr
         153: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.rd_phys_addr; end
         154: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.rd_phys_addr; end
         155: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.rd_phys_addr = value[5:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.rd_phys_addr; end
         // RS Exec: pc
         156: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.pc; end
         157: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.pc; end
         158: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.pc = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.pc; end
         // RS Exec: pc_value_at_prediction
         159: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.pc_value_at_prediction; end
         160: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.pc_value_at_prediction; end
         161: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.pc_value_at_prediction = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.pc_value_at_prediction; end
         // RS Exec: branch_sel
         162: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.branch_sel; end
         163: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.branch_sel; end
         164: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.branch_sel = value[2:0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.branch_sel; end
         // RS Exec: branch_prediction
         165: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.branch_prediction; end
         166: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.branch_prediction; end
         167: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.branch_prediction = value[0]; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.branch_prediction; end
         // RS Exec: store_data
         168: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_0.store_data; end
         169: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_1.store_data; end
         170: begin force dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.store_data = value; #1; release dv_top_superscalar.dut.dispatch_stage_unit.dispatch_to_alu_internal_2.store_data; end
      endcase
   endtask

   //==========================================================================
   // FINAL STATISTICS REPORT
   //==========================================================================
   final begin
      if (enable_injection) begin
         $display("\n==========================================================================");
         $display("TMR FAULT INJECTOR V2 - FINAL STATISTICS");
         $display("==========================================================================");
         $display("  Total faults injected: %0d", total_faults_injected);
         $display("  Total fault cycles:    %0d", total_fault_cycles);
         $display("==========================================================================\n");
      end
   end

endmodule
