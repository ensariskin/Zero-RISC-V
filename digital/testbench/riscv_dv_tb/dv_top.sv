//////////////////////////////////////////////////////////////////////////////////
// RV32I Core RISC-V DV Testbench Top Module
// 
// This module integrates the RV32I core with RISC-V DV verification framework
// Features:
// - Wishbone memory interface
// - Instruction and data memory models
// - Execution tracing compatible with RISC-V DV
// - Program loading from hex files
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module dv_top;

    // Parameters
    parameter CLK_PERIOD = 10;          // 100MHz clock
    parameter TIMEOUT_CYCLES = 100000;  // Simulation timeout
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 32;
    
    // Memory parameters
    parameter INST_MEM_SIZE = 32'h10000;  // 64KB instruction memory
    parameter DATA_MEM_SIZE = 32'h10000;  // 64KB data memory
    parameter INST_BASE_ADDR = 32'h00001000;
    parameter DATA_BASE_ADDR = 32'h10000000;
    localparam D = 1; // Delay for simulation purposes
    // Clock and reset
    logic clk;
    logic rst_n;
    
    // Core signals
    logic [31:0] ins_address;
    logic [31:0] instruction_i;
    logic data_mem_rw;
    logic [31:0] data_mem_addr_o;
    logic [31:0] data_mem_data_wr_data;
    logic [31:0] data_mem_data_rd_data;
    logic [2:0] data_mem_control;
    
    // Wishbone signals for instruction memory
    logic inst_wb_cyc;
    logic inst_wb_stb;
    logic inst_wb_we;
    logic [31:0] inst_wb_adr;
    logic [31:0] inst_wb_dat_o;
    logic [3:0] inst_wb_sel;
    logic inst_wb_stall;
    logic inst_wb_ack;
    logic [31:0] inst_wb_dat_i;
    logic inst_wb_err;
    
    // Wishbone signals for data memory
    logic data_wb_cyc;
    logic data_wb_stb;
    logic data_wb_we;
    logic [31:0] data_wb_adr;
    logic [31:0] data_wb_dat_o;
    logic [3:0] data_wb_sel;
    logic data_wb_stall;
    logic data_wb_ack;
    logic [31:0] data_wb_dat_i;
    logic data_wb_err;
    
    // Tracer signals
    logic tr_valid;
    logic [31:0] tr_pc;
    logic [31:0] tr_instr;
    logic [4:0] tr_reg_addr;
    logic [31:0] tr_reg_data;
    logic tr_load;
    logic tr_store;
    logic tr_is_float;
    logic [1:0] tr_mem_size;
    logic [31:0] tr_mem_addr;
    logic [31:0] tr_mem_data;
    logic [31:0] tr_fpu_flags;
    
    // Test control
    logic test_passed;
    logic test_failed;
    integer cycle_count;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Reset generation
    initial begin
        rst_n = 0;
        #(CLK_PERIOD * 5);
        rst_n = 1;
        $display("Reset released at time %t", $time);
    end
    
    // Timeout watchdog
    initial begin
        cycle_count = 0;
        forever begin
            @(posedge clk);
            cycle_count = cycle_count + 1;
            if (cycle_count >= TIMEOUT_CYCLES) begin
                $display("TIMEOUT: Simulation exceeded %d cycles", TIMEOUT_CYCLES);
                test_failed = 1;
                #10;
                $finish;
            end
        end
    end

    // Core instantiation
    rv32i_core #(.size(32)) dut (
        .clk(clk),
        .reset(rst_n),
        .ins_address(ins_address),
        .instruction_i(instruction_i),
        .data_mem_rw(data_mem_rw),
        .data_mem_addr_o(data_mem_addr_o),
        .data_mem_data_wr_data(data_mem_data_wr_data),
        .data_mem_data_rd_data(data_mem_data_rd_data),
        .data_mem_control(data_mem_control)
    );
    
    // Instruction memory wishbone adapter
    rv32i_inst_wb_adapter inst_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        // Core side
        .core_addr_i(ins_address),
        .core_data_o(instruction_i),
        // Wishbone side
        .wb_cyc_o(inst_wb_cyc),
        .wb_stb_o(inst_wb_stb),
        .wb_we_o(inst_wb_we),
        .wb_adr_o(inst_wb_adr),
        .wb_dat_o(inst_wb_dat_o),
        .wb_sel_o(inst_wb_sel),
        .wb_stall_i(inst_wb_stall),
        .wb_ack_i(inst_wb_ack),
        .wb_dat_i(inst_wb_dat_i),
        .wb_err_i(inst_wb_err)
    );
    
    // Data memory wishbone adapter
    rv32i_data_wb_adapter data_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        // Core side
        .core_addr_i(data_mem_addr_o),
        .core_data_i(data_mem_data_wr_data),
        .core_data_o(data_mem_data_rd_data),
        .core_we_i(data_mem_rw),
        .core_sel_i(data_mem_control),
        // Wishbone side
        .wb_cyc_o(data_wb_cyc),
        .wb_stb_o(data_wb_stb),
        .wb_we_o(data_wb_we),
        .wb_adr_o(data_wb_adr),
        .wb_dat_o(data_wb_dat_o),
        .wb_sel_o(data_wb_sel),
        .wb_stall_i(data_wb_stall),
        .wb_ack_i(data_wb_ack),
        .wb_dat_i(data_wb_dat_i),
        .wb_err_i(data_wb_err)
    );
    
    // Instruction memory model
    memory_2rw_wb #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14),  // 16KB memory (64K bytes / 4 bytes per word = 16K words = 2^14)
        .NUM_WMASKS(4)
    ) inst_memory (
        .port0_wb_cyc_i(inst_wb_cyc),
        .port0_wb_stb_i(inst_wb_stb),
        .port0_wb_we_i(inst_wb_we),
        .port0_wb_adr_i(inst_wb_adr),  // Word-aligned address (remove lower 2 bits)
        .port0_wb_dat_i(inst_wb_dat_o),
        .port0_wb_sel_i(inst_wb_sel),
        .port0_wb_stall_o(inst_wb_stall),
        .port0_wb_ack_o(inst_wb_ack),
        .port0_wb_dat_o(inst_wb_dat_i),
        .port0_wb_err_o(inst_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),
        // Port 1 unused for instruction memory
        .port1_wb_cyc_i(1'b0),
        .port1_wb_stb_i(1'b0),
        .port1_wb_we_i(1'b0),
        .port1_wb_adr_i(32'h0),
        .port1_wb_dat_i(32'h0),
        .port1_wb_sel_i(4'h0),
        .port1_wb_stall_o(),
        .port1_wb_ack_o(),
        .port1_wb_dat_o(),
        .port1_wb_err_o(),
        .port1_wb_rst_i(~rst_n),
        .port1_wb_clk_i(clk)
    );
    
    // Data memory model
    memory_2rw_wb #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14),  // 16KB memory
        .NUM_WMASKS(4)
    ) data_memory (
        .port0_wb_cyc_i(data_wb_cyc),
        .port0_wb_stb_i(data_wb_stb),
        .port0_wb_we_i(data_wb_we),
        .port0_wb_adr_i(data_wb_adr),  // Word-aligned address
        .port0_wb_dat_i(data_wb_dat_o),
        .port0_wb_sel_i(data_wb_sel),
        .port0_wb_stall_o(data_wb_stall),
        .port0_wb_ack_o(data_wb_ack),
        .port0_wb_dat_o(data_wb_dat_i),
        .port0_wb_err_o(data_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),
        // Port 1 unused for data memory in this simple setup
        .port1_wb_cyc_i(1'b0),
        .port1_wb_stb_i(1'b0),
        .port1_wb_we_i(1'b0),
        .port1_wb_adr_i(32'h0),
        .port1_wb_dat_i(32'h0),
        .port1_wb_sel_i(4'h0),
        .port1_wb_stall_o(),
        .port1_wb_ack_o(),
        .port1_wb_dat_o(),
        .port1_wb_err_o(),
        .port1_wb_rst_i(~rst_n),
        .port1_wb_clk_i(clk)
    );
    
    // Execution tracer (adapted for RV32I core)
    rv32i_tracer tracer_inst (
        .clk_i(clk),
        .valid(tr_valid),
        .pc(tr_pc),
        .instr(tr_instr),
        .reg_addr(tr_reg_addr),
        .reg_data(tr_reg_data),
        .is_load(tr_load),
        .is_store(tr_store),
        .is_float(tr_is_float),
        .mem_size(tr_mem_size),
        .mem_addr(tr_mem_addr),
        .mem_data(tr_mem_data),
        .fpu_flags(tr_fpu_flags)
    );
    
    // Test program loader
    initial begin
        // Wait a bit for memory to initialize
        #1;
        
        // Load test program if specified
        if ($test$plusargs("load_hex")) begin
            string hex_file;
            if ($value$plusargs("hex_file=%s", hex_file)) begin
                $display("Loading hex file: %s", hex_file);
                $readmemh(hex_file, inst_memory.mem);
                $display("Instruction memory loaded from %s", hex_file);
            end else begin
                $display("ERROR: hex_file argument required when load_hex is specified");
                $finish;
            end
        end else if ($test$plusargs("riscv_dv_test")) begin
            // For RISC-V DV generated tests, the hex file is typically passed via environment
            string dv_hex_file;
            if ($value$plusargs("test_hex=%s", dv_hex_file)) begin
                $display("Loading RISC-V DV test: %s", dv_hex_file);
                $readmemh(dv_hex_file, inst_memory.mem);
                $display("RISC-V DV test loaded from %s", dv_hex_file);
            end else begin
                $display("ERROR: test_hex argument required for RISC-V DV tests");
                $finish;
            end
        end else begin
            // Load default test program for basic verification
            $display("Loading default test program");
            // You can specify a default hex file here or load from testbench directory
            if ($fopen("../hex/init.hex", "r")) begin
                $readmemh("../hex/init.hex", inst_memory.mem);
                $display("Default test loaded from ../hex/init.hex");
            end else begin
                $display("No default test found, using NOP instructions");
                // Fill memory with NOP instructions (addi x0, x0, 0)
                for (int i = 0; i < 1024; i++) begin
                    inst_memory.mem[i] = 32'h00000013;
                end
            end
        end
        
        $display("Test program loaded at time %t", $time);

        // Clear data memory
        for (int i = 0; i < DATA_MEM_SIZE / 4; i++) begin
            data_memory.mem[i] = 32'h0;  // Initialize data memory to zero
        end
    end
    
    // Trace signal generation
    // Extract trace information from the core's available signals
    
    logic [31:0] wb_pc;
    logic [31:0] wb_instruction;
    logic [4:0] wb_reg_addr;
    logic [31:0] wb_reg_data;
    logic wb_reg_we;
    logic mem_access;
    logic mem_load, mem_store;
    
    // Create a simple PC tracking mechanism
    // We'll track the PC through the pipeline stages by delaying the fetch PC
    logic [31:0] pc_delay_1, pc_delay_2, pc_delay_3, pc_delay_4;
    logic [31:0] inst_delay_1, inst_delay_2, inst_delay_3, inst_delay_4;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_delay_1 <= #D 32'h0;
            pc_delay_2 <= #D 32'h0;
            pc_delay_3 <= #D 32'h0;
            pc_delay_4 <= #D 32'h0;
            inst_delay_1 <= #D 32'h0;
            inst_delay_2 <= #D 32'h0;
            inst_delay_3 <= #D 32'h0;
            inst_delay_4 <= #D 32'h0;
        end else begin
            // Pipeline the PC and instruction through the stages
            pc_delay_1 <= #D ins_address;
            pc_delay_2 <= #D pc_delay_1;
            pc_delay_3 <= #D pc_delay_2;
            pc_delay_4 <= #D pc_delay_3;
            
            inst_delay_1 <= #D instruction_i;
            inst_delay_2 <= #D inst_delay_1;
            inst_delay_3 <= #D inst_delay_2;
            inst_delay_4 <= #D inst_delay_3;
        end
    end
    
    // Extract writeback information from core outputs
    assign wb_pc = pc_delay_4;  // PC corresponding to WB stage
    assign wb_instruction = inst_delay_4;  // Instruction corresponding to WB stage
    assign wb_reg_addr = dut.Control_Signal_WB_o[4:0];  // Extract register address from control signals
    assign wb_reg_data = dut.Final_Result_WB_o;  // Register write data
    assign wb_reg_we = dut.Control_Signal_WB_o[5];  // Write enable
    
    // Memory access detection
    assign mem_access = data_mem_rw || (|data_mem_control);
    assign mem_load = mem_access && !data_mem_rw;
    assign mem_store = mem_access && data_mem_rw;
    
    // Connect trace signals to tracer
    assign tr_valid = wb_reg_we && (wb_reg_addr != 5'b0);  // Valid when writing to non-zero register
    assign tr_pc = wb_pc;
    assign tr_instr = wb_instruction;
    assign tr_reg_addr = wb_reg_addr;
    assign tr_reg_data = wb_reg_data;
    assign tr_load = mem_load;
    assign tr_store = mem_store;
    assign tr_is_float = 1'b0;  // RV32I has no floating point
    assign tr_mem_size = data_mem_control[1:0];
    assign tr_mem_addr = data_mem_addr_o;
    assign tr_mem_data = data_mem_rw ? data_mem_data_wr_data : data_mem_data_rd_data;
    assign tr_fpu_flags = 32'h0; // No FPU in RV32I
    
    // Test completion detection
    // Detect test completion based on various criteria
    
    logic ecall_detected;
    logic test_signature_addr_hit;
    logic [31:0] max_cycles;
    
    // ECALL instruction detection (for test termination)
    assign ecall_detected = (wb_instruction == 32'h00000073) && tr_valid;
    
    // Test signature write detection (common in RISC-V compliance tests)
    assign test_signature_addr_hit = (data_mem_addr_o == 32'hF0000000) && data_mem_rw;
    
    initial begin
        test_passed = 0;
        test_failed = 0;
        
        // Get maximum cycles from plusargs or use default
        if (!$value$plusargs("max_cycles=%d", max_cycles)) begin
            max_cycles = TIMEOUT_CYCLES;
        end
        
        // Wait for reset to be released
        wait(rst_n);
        $display("Test execution started, max_cycles = %d", max_cycles);
        
        // Wait for test completion conditions
        fork
            begin
                // Wait for ECALL instruction (normal test termination)
                wait(ecall_detected);
                $display("ECALL detected at PC=0x%08x, test completed normally", tr_pc);
                test_passed = 1;
            end
            begin
                // Wait for test signature write
                wait(test_signature_addr_hit);
                $display("Test signature write detected at 0x%08x", data_mem_addr_o);
                test_passed = 1;
            end
            begin
                // Wait for timeout
                repeat(max_cycles) @(posedge clk);
                $display("Test timeout after %d cycles", max_cycles);
                test_failed = 1;
            end
        join_any
        
        // Report test result
        if (test_passed) begin
            $display("TEST PASSED at time %t", $time);
        end else if (test_failed) begin
            $display("TEST FAILED at time %t", $time);
        end
        
        #100;
        $finish;
    end
    
    // Simulation control and monitoring
    initial begin
        $display("RV32I Core RISC-V DV Testbench");
        $display("Instruction base address: 0x%08x", INST_BASE_ADDR);
        $display("Data base address: 0x%08x", DATA_BASE_ADDR);
        $display("Simulation started at time %t", $time);
    end

    // Enhanced monitoring - direct access to fetch stage and PC module
    logic [31:0] fetch_pc;           // PC from fetch stage 
    logic [31:0] fetch_instruction;  // Current instruction being fetched
    logic [31:0] pc_ctrl_current;    // PC from program counter control module
    logic [31:0] pc_ctrl_save;       // PC save value from program counter module
    logic fetch_jump;                // Jump signal from fetch stage
    logic fetch_jalr;                // JALR signal from fetch stage
    logic [31:0] fetch_imm;          // Immediate from fetch stage
    
    // Connect to fetch stage internals
    assign fetch_pc = dut.Ins_Fetch.current_pc;
    assign fetch_instruction = dut.Ins_Fetch.instruction_i;
    assign pc_ctrl_current = dut.Ins_Fetch.PC.current_pc;
    assign pc_ctrl_save = dut.Ins_Fetch.PC.pc_save;
    assign fetch_jump = dut.Ins_Fetch.jump;
    assign fetch_jalr = dut.Ins_Fetch.jalr;
    assign fetch_imm = dut.Ins_Fetch.imm;
    
    // PC and instruction monitoring
    always @(posedge clk) begin
        if (rst_n) begin
            // Monitor PC changes
            if (fetch_pc != 32'h0) begin
                $display("[%0t] PC: 0x%08x, Instr: 0x%08x, Jump: %b, JALR: %b, IMM: 0x%08x", 
                         $time, fetch_pc, fetch_instruction, fetch_jump, fetch_jalr, fetch_imm);
            end
            
            // Monitor critical store instruction (the one that should write to array[0])
            if (fetch_pc == 32'hba0 && fetch_instruction == 32'hf8f42623) begin
                $display("[%0t] *** CRITICAL STORE DETECTED at PC=0x%08x ***", $time, fetch_pc);
                $display("    Instruction: 0x%08x (sw a5,-116(s0))", fetch_instruction);
                $display("    Data Memory Write: %b", data_mem_rw);
                $display("    Data Memory Address: 0x%08x", data_mem_addr_o);  
                $display("    Data Memory Write Data: 0x%08x", data_mem_data_wr_data);
                $display("    Data Memory Control: 0x%x", data_mem_control);
                
                // Also monitor the Wishbone adapter signals
                $display("    WB Cycle: %b, WB Strobe: %b, WB We: %b", data_wb_cyc, data_wb_stb, data_wb_we);
                $display("    WB Address: 0x%08x, WB Data: 0x%08x", data_wb_adr, data_wb_dat_o);
                $display("    WB Sel: 0x%x, WB Ack: %b", data_wb_sel, data_wb_ack);
            end
            
            // Monitor all store instructions for debugging
            if (data_mem_rw && (|data_mem_control)) begin
                $display("[%0t] STORE: PC=0x%08x, Addr=0x%08x, Data=0x%08x, Control=0x%x", 
                         $time, fetch_pc, data_mem_addr_o, data_mem_data_wr_data, data_mem_control);
            end
            
            // Monitor all load instructions for debugging  
            if (!data_mem_rw && (|data_mem_control)) begin
                $display("[%0t] LOAD: PC=0x%08x, Addr=0x%08x, Data=0x%08x, Control=0x%x", 
                         $time, fetch_pc, data_mem_addr_o, data_mem_data_rd_data, data_mem_control);
            end
        end
    end
    
    // Memory content monitoring - specifically watch array[0] location
    logic [31:0] array_base_addr;
    logic [31:0] array_0_addr;
    logic [31:0] stack_pointer;
    
    // Calculate expected addresses (based on assembly analysis)
    // s0 should be sp + 160, array[0] should be at s0 - 116
    assign stack_pointer = 32'h7ffc;  // From assembly: sp initialized to 0x7ffc
    assign array_base_addr = stack_pointer + 160 - 116;  // s0 - 116
    assign array_0_addr = array_base_addr;
    
    always @(posedge clk) begin
        if (rst_n && data_mem_rw && (data_mem_addr_o == array_0_addr)) begin
            $display("[%0t] *** ARRAY[0] WRITE DETECTED ***", $time);
            $display("    Address: 0x%08x (Expected: 0x%08x)", data_mem_addr_o, array_0_addr);
            $display("    Data: 0x%08x", data_mem_data_wr_data);
            $display("    PC: 0x%08x", fetch_pc);
        end
    end

    // Register file monitoring (for debugging)
    logic [31:0] reg_s0_value;  // Frame pointer (s0/x8)
    logic [31:0] reg_a5_value;  // Register a5 (x15) - used in the critical store
    
    // Monitor register file values (if accessible)
    // Note: You may need to adjust these paths based on your register file implementation
    assign reg_s0_value = dut.ID.RegFile.registers.s0.data_out[287:256];   // s0 register (x8)
    assign reg_a5_value = dut.ID.RegFile.registers.a5.data_out[479:448];   // a5 register (x15)
    
    // Pipeline stage monitoring
    logic [31:0] id_pc, ex_pc, mem_pc, wb_pc_internal;
    logic [31:0] id_instr, ex_instr, mem_instr, wb_instr_internal;
    
    assign id_pc = dut.PCPlus_ID_i - 4;  // ID stage PC
    assign ex_pc = dut.PCplus_EX_i - 4;  // EX stage PC  
    assign mem_pc = dut.FU_MEM_i;        // MEM stage result (might contain PC)
    assign wb_pc_internal = dut.FU_WB_i; // WB stage result
    
    assign id_instr = dut.instruction_ID_i;
    assign ex_instr = dut.A_EX_i;  // This might not be instruction, adjust if needed
    assign mem_instr = dut.RAM_DATA_MEM_i;
    assign wb_instr_internal = dut.MEM_result_WB_i;
    
    // Enhanced debugging for the critical store
    always @(posedge clk) begin
        if (rst_n && fetch_pc == 32'hba0) begin
            $display("[%0t] *** DEBUGGING PC=0x%08x ***", $time, fetch_pc);
            $display("    s0 register value: 0x%08x", reg_s0_value);
            $display("    a5 register value: 0x%08x", reg_a5_value);
            $display("    Expected store address: 0x%08x (s0-116)", reg_s0_value - 116);
            $display("    Actual store address: 0x%08x", data_mem_addr_o);
            $display("    Address match: %b", (data_mem_addr_o == (reg_s0_value - 116)));
            $display("    Pipeline - ID PC: 0x%08x, EX PC: 0x%08x", id_pc, ex_pc);
            $display("    Control signals - WB: 0x%02x, MEM: 0x%03x", dut.Control_Signal_WB_i, dut.Control_Signal_MEM_i);
        end
    end
    
    // Monitor Wishbone data memory transactions
    always @(posedge clk) begin
        if (rst_n && data_wb_cyc && data_wb_stb) begin
            $display("[%0t] WB Data Transaction: Addr=0x%08x, Data=0x%08x, We=%b, Sel=0x%x", 
                     $time, data_wb_adr, data_wb_dat_o, data_wb_we, data_wb_sel);
            if (data_wb_ack) begin
                $display("    WB ACK received, Read Data=0x%08x", data_wb_dat_i);
            end
        end
    end

    
    // End of simulation summary
    final begin
        $display("=== SIMULATION SUMMARY ===");
        $display("Total cycles: %d", cycle_count);
        $display("Final PC: 0x%08x", fetch_pc);
        $display("Test passed: %b", test_passed);
        $display("Test failed: %b", test_failed);
        
        // Check array[0] value at end of simulation
        $display("Array[0] final value: 0x%08x (at calculated addr 0x%08x)", 
                 data_memory.mem[(reg_s0_value - 116) >> 2], reg_s0_value - 116);
    end

    // Simple execution tracking - log every PC change
    logic [31:0] prev_pc;
    integer instruction_count;
    
    initial begin
        prev_pc = 0;
        instruction_count = 0;
    end
    
    always @(posedge clk) begin
        if (rst_n && fetch_pc != prev_pc && fetch_pc != 0) begin
            instruction_count = instruction_count + 1;
            $display("[%0d] PC: 0x%08x -> 0x%08x, Instr: 0x%08x", 
                     instruction_count, prev_pc, fetch_pc, fetch_instruction);
            prev_pc = fetch_pc;
            
            // Stop after reasonable number of instructions for debugging
            if (instruction_count > 100000) begin
                $display("*** STOPPING after %d instructions for debugging ***", instruction_count);
                $display("Last PC: 0x%08x, Last Instruction: 0x%08x", fetch_pc, fetch_instruction);
                $finish;
            end
        end
    end
    
    // Track if processor gets stuck
    logic [31:0] stuck_counter;
    logic [31:0] last_active_pc;
    
    initial stuck_counter = 0;
    
    always @(posedge clk) begin
        if (rst_n) begin
            if (fetch_pc == last_active_pc) begin
                stuck_counter = stuck_counter + 1;
                if (stuck_counter > 10) begin
                    $display("[%0t] *** PROCESSOR APPEARS STUCK at PC=0x%08x ***", $time, fetch_pc);
                    $display("Instruction: 0x%08x", fetch_instruction);
                    $display("Stuck for %d cycles", stuck_counter);
                    
                    // Show processor state
                    $display("Reset: %b, Bubble: %b, Misprediction: %b", 
                             rst_n, dut.buble, dut.misprediction);
                    $display("Instruction valid: %b", dut.instruction_valid);
                    
                    $finish;
                end
            end else begin
                stuck_counter = 0;
                last_active_pc = fetch_pc;
            end
        end
    end

endmodule
