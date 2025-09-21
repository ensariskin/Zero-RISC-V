//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Core RISC-V DV Testbench Top Module
// 
// This module integrates the RV32I superscalar core with verification framework
// Features:
// - 3-port instruction memory for parallel fetch
// - Wishbone data memory interface
// - Execution tracing and performance monitoring
// - Program loading from hex files
// - Comprehensive assertions and checks
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module dv_top_superscalar;

    // Parameters
    parameter CLK_PERIOD = 10;          // 100MHz clock
    parameter TIMEOUT_CYCLES = 1000000; // Simulation timeout
    parameter DATA_WIDTH = 32;
    parameter REG_FILE_ADDR_WIDTH = 5;
    parameter INST_BASE_ADDR = 32'h80000000;
    
    // Default region base addresses (can be overridden via plusargs)
    parameter REGION0_BASE_ADDR_DEFAULT = 32'h80000000;  // Default Region 0 start address
    parameter REGION1_BASE_ADDR_DEFAULT = 32'h80001000;  // Default Region 1 start address
    
    // Runtime configurable region base addresses
    logic [31:0] region0_base_addr;
    logic [31:0] region1_base_addr;
    
    localparam D = 1; // Delay for simulation purposes
    
    // Clock and reset
    logic clk;
    logic rst_n;
    
    // Superscalar core signals (3-port instruction interface)
    logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2;
    logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2;
    
    // Data memory interface
    logic [DATA_WIDTH-1:0] data_addr;
    logic [DATA_WIDTH-1:0] data_write;
    logic [DATA_WIDTH-1:0] data_read;
    logic data_we;
    logic [3:0] data_be;
    logic data_req;
    logic data_ack;
    logic data_err;
    
    // External interrupt interface
    logic external_interrupt;
    logic timer_interrupt;
    logic software_interrupt;
    
    // Debug interface
    logic [DATA_WIDTH-1:0] debug_pc;
    logic [DATA_WIDTH-1:0] debug_instruction;
    logic debug_valid;
    
    // Performance counters
    logic [31:0] perf_cycles;
    logic [31:0] perf_instructions_fetched;
    logic [31:0] perf_instructions_executed;
    logic [31:0] perf_branch_mispredictions;
    logic [31:0] perf_buffer_stalls;
    
    // Status outputs (unused in testbench but required by interface)
    logic processor_halted; // Connected to DUT but not used
    logic [2:0] current_privilege_mode; // Connected to DUT but not used
    
    // Wishbone signals for instruction memory (3 ports)
    logic inst0_wb_cyc, inst0_wb_stb, inst0_wb_we;
    logic [31:0] inst0_wb_adr, inst0_wb_dat_o, inst0_wb_dat_i;
    logic [3:0] inst0_wb_sel;
    logic inst0_wb_stall, inst0_wb_ack, inst0_wb_err;
    
    logic inst1_wb_cyc, inst1_wb_stb, inst1_wb_we;
    logic [31:0] inst1_wb_adr, inst1_wb_dat_o, inst1_wb_dat_i;
    logic [3:0] inst1_wb_sel;
    logic inst1_wb_stall, inst1_wb_ack, inst1_wb_err;
    
    logic inst2_wb_cyc, inst2_wb_stb, inst2_wb_we;
    logic [31:0] inst2_wb_adr, inst2_wb_dat_o, inst2_wb_dat_i;
    logic [3:0] inst2_wb_sel;
    logic inst2_wb_stall, inst2_wb_ack, inst2_wb_err;
    
    // Wishbone signals for data memory
    logic data_wb_cyc, data_wb_stb, data_wb_we;
    logic [31:0] data_wb_adr, data_wb_dat_o, data_wb_dat_i;
    logic [3:0] data_wb_sel;
    logic data_wb_stall, data_wb_ack, data_wb_err;
    
    // Region memory signals
    logic region0_wb_cyc, region0_wb_stb, region0_wb_we;
    logic [31:0] region0_wb_adr, region0_wb_dat_o, region0_wb_dat_i;
    logic [3:0] region0_wb_sel;
    logic region0_wb_stall, region0_wb_ack, region0_wb_err;
    
    logic region1_wb_cyc, region1_wb_stb, region1_wb_we;
    logic [31:0] region1_wb_adr, region1_wb_dat_o, region1_wb_dat_i;
    logic [3:0] region1_wb_sel;
    logic region1_wb_stall, region1_wb_ack, region1_wb_err;
    
    // Test control
    logic test_failed;
    integer cycle_count;
    
    // Previous values for change detection
    logic [31:0] prev_debug_pc;
    logic [31:0] prev_perf_instructions_executed;
    
    //==========================================================================
    // SIMULATION CONTROL AND MONITORING
    //==========================================================================
    
    initial begin
        $display("=================================================================");
        $display("RV32I Superscalar Core RISC-V DV Testbench");
        $display("=================================================================");
        $display("Instruction base address: 0x%08x", INST_BASE_ADDR);
        $display("3-way superscalar configuration");
        $display("Simulation started at time %t", $time);
        $display("=================================================================");
    end

    // Initialize region base addresses from plusargs or use defaults
    initial begin
        if (!$value$plusargs("region0_base=%h", region0_base_addr)) begin
            region0_base_addr = REGION0_BASE_ADDR_DEFAULT;
            $display("Using default Region 0 base address: 0x%08x", region0_base_addr);
        end
        if (!$value$plusargs("region1_base=%h", region1_base_addr)) begin
            region1_base_addr = REGION1_BASE_ADDR_DEFAULT;
            $display("Using default Region 1 base address: 0x%08x", region1_base_addr);
        end
    end
    
    //==========================================================================
    // CLOCK AND RESET GENERATION
    //==========================================================================
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Reset generation
    initial begin
        rst_n = 0;
        external_interrupt = 0;
        timer_interrupt = 0;
        software_interrupt = 0;
        
        #(CLK_PERIOD * 5);
        rst_n = 1;
        $display("[%t] Reset released", $time);
    end
    
    //==========================================================================
    // SUPERSCALAR CORE INSTANTIATION
    //==========================================================================
    
    rv32i_superscalar_core #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(8),
        .REG_FILE_ADDR_WIDTH(REG_FILE_ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .reset(rst_n),
        
        // Instruction Memory Interface (3-port for parallel fetch)
        .inst_addr_0(inst_addr_0),
        .inst_addr_1(inst_addr_1), 
        .inst_addr_2(inst_addr_2),
        .instruction_i_0(instruction_i_0),
        .instruction_i_1(instruction_i_1),
        .instruction_i_2(instruction_i_2),
        
        // Data Memory Interface
        .data_addr(data_addr),
        .data_write(data_write),
        .data_read(data_read),
        .data_we(data_we),
        .data_be(data_be),
        .data_req(data_req),
        .data_ack(data_ack),
        .data_err(data_err),
        
        // External Interrupt Interface
        .external_interrupt(external_interrupt),
        .timer_interrupt(timer_interrupt),
        .software_interrupt(software_interrupt),
        
        // Debug Interface
        .debug_pc(debug_pc),
        .debug_instruction(debug_instruction),
        .debug_valid(debug_valid),
        
        // Performance Counters
        .perf_cycles(perf_cycles),
        .perf_instructions_fetched(perf_instructions_fetched),
        .perf_instructions_executed(perf_instructions_executed),
        .perf_branch_mispredictions(perf_branch_mispredictions),
        .perf_buffer_stalls(perf_buffer_stalls),
        
        // Status Outputs
        .processor_halted(processor_halted),
        .current_privilege_mode(current_privilege_mode)
    );
    
    //==========================================================================
    // INSTRUCTION MEMORY ADAPTERS (3 ports)
    //==========================================================================
    
    // Port 0 instruction memory adapter
    rv32i_inst_wb_adapter inst0_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(inst_addr_0),
        .core_data_o(instruction_i_0),
        .wb_cyc_o(inst0_wb_cyc),
        .wb_stb_o(inst0_wb_stb),
        .wb_we_o(inst0_wb_we),
        .wb_adr_o(inst0_wb_adr),
        .wb_dat_o(inst0_wb_dat_o),
        .wb_sel_o(inst0_wb_sel),
        .wb_stall_i(inst0_wb_stall),
        .wb_ack_i(inst0_wb_ack),
        .wb_dat_i(inst0_wb_dat_i),
        .wb_err_i(inst0_wb_err)
    );
    
    // Port 1 instruction memory adapter
    rv32i_inst_wb_adapter inst1_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(inst_addr_1),
        .core_data_o(instruction_i_1),
        .wb_cyc_o(inst1_wb_cyc),
        .wb_stb_o(inst1_wb_stb),
        .wb_we_o(inst1_wb_we),
        .wb_adr_o(inst1_wb_adr),
        .wb_dat_o(inst1_wb_dat_o),
        .wb_sel_o(inst1_wb_sel),
        .wb_stall_i(inst1_wb_stall),
        .wb_ack_i(inst1_wb_ack),
        .wb_dat_i(inst1_wb_dat_i),
        .wb_err_i(inst1_wb_err)
    );
    
    // Port 2 instruction memory adapter
    rv32i_inst_wb_adapter inst2_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(inst_addr_2),
        .core_data_o(instruction_i_2),
        .wb_cyc_o(inst2_wb_cyc),
        .wb_stb_o(inst2_wb_stb),
        .wb_we_o(inst2_wb_we),
        .wb_adr_o(inst2_wb_adr),
        .wb_dat_o(inst2_wb_dat_o),
        .wb_sel_o(inst2_wb_sel),
        .wb_stall_i(inst2_wb_stall),
        .wb_ack_i(inst2_wb_ack),
        .wb_dat_i(inst2_wb_dat_i),
        .wb_err_i(inst2_wb_err)
    );
    
    //==========================================================================
    // DATA MEMORY ADAPTER
    //==========================================================================
    
    rv32i_superscalar_data_wb_adapter data_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(data_addr),
        .core_data_i(data_write),
        .core_data_o(data_read),
        .core_we_i(data_we),
        .core_be_i(data_be),
        .core_req_i(data_req),
        .core_ack_o(data_ack),
        .core_err_o(data_err),
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
    
    //==========================================================================
    // MEMORY SUBSYSTEM (3-PORT INSTRUCTION + DATA)
    //==========================================================================
    
    // 3-port instruction memory (64KB = 16K words)
    memory_3rw #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14), // 16K words = 64KB memory (2^14 = 16384 words)
        .NUM_WMASKS(4)
    ) instruction_memory (
        // Port 0 (fetch 0)
        .port0_wb_cyc_i(inst0_wb_cyc),
        .port0_wb_stb_i(inst0_wb_stb),
        .port0_wb_we_i(inst0_wb_we),
        .port0_wb_adr_i(inst0_wb_adr),
        .port0_wb_dat_i(inst0_wb_dat_o),
        .port0_wb_sel_i(inst0_wb_sel),
        .port0_wb_stall_o(inst0_wb_stall),
        .port0_wb_ack_o(inst0_wb_ack),
        .port0_wb_dat_o(inst0_wb_dat_i),
        .port0_wb_err_o(inst0_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),
        
        // Port 1 (fetch 1)
        .port1_wb_cyc_i(inst1_wb_cyc),
        .port1_wb_stb_i(inst1_wb_stb),
        .port1_wb_we_i(inst1_wb_we),
        .port1_wb_adr_i(inst1_wb_adr),
        .port1_wb_dat_i(inst1_wb_dat_o),
        .port1_wb_sel_i(inst1_wb_sel),
        .port1_wb_stall_o(inst1_wb_stall),
        .port1_wb_ack_o(inst1_wb_ack),
        .port1_wb_dat_o(inst1_wb_dat_i),
        .port1_wb_err_o(inst1_wb_err),
        .port1_wb_rst_i(~rst_n),
        .port1_wb_clk_i(clk),
        
        // Port 2 (fetch 2)
        .port2_wb_cyc_i(inst2_wb_cyc),
        .port2_wb_stb_i(inst2_wb_stb),
        .port2_wb_we_i(inst2_wb_we),
        .port2_wb_adr_i(inst2_wb_adr),
        .port2_wb_dat_i(inst2_wb_dat_o),
        .port2_wb_sel_i(inst2_wb_sel),
        .port2_wb_stall_o(inst2_wb_stall),
        .port2_wb_ack_o(inst2_wb_ack),
        .port2_wb_dat_o(inst2_wb_dat_i),
        .port2_wb_err_o(inst2_wb_err),
        .port2_wb_rst_i(~rst_n),
        .port2_wb_clk_i(clk)
    );
    
    // Data memory selector/router
    data_memory_selector data_mem_selector (
        .clk(clk),
        .rst_n(rst_n),
        
        // Core interface (from data wb adapter)
        .core_wb_cyc_i(data_wb_cyc),
        .core_wb_stb_i(data_wb_stb),
        .core_wb_we_i(data_wb_we),
        .core_wb_adr_i(data_wb_adr),
        .core_wb_dat_i(data_wb_dat_o),
        .core_wb_sel_i(data_wb_sel),
        .core_wb_stall_o(data_wb_stall),
        .core_wb_ack_o(data_wb_ack),
        .core_wb_dat_o(data_wb_dat_i),
        .core_wb_err_o(data_wb_err),
        
        // Region 0 memory interface  
        .region0_wb_cyc_o(region0_wb_cyc),
        .region0_wb_stb_o(region0_wb_stb),
        .region0_wb_we_o(region0_wb_we),
        .region0_wb_adr_o(region0_wb_adr),
        .region0_wb_dat_o(region0_wb_dat_o),
        .region0_wb_sel_o(region0_wb_sel),
        .region0_wb_stall_i(region0_wb_stall),
        .region0_wb_ack_i(region0_wb_ack),
        .region0_wb_dat_i(region0_wb_dat_i),
        .region0_wb_err_i(region0_wb_err),
        
        // Region 1 memory interface
        .region1_wb_cyc_o(region1_wb_cyc),
        .region1_wb_stb_o(region1_wb_stb),
        .region1_wb_we_o(region1_wb_we),
        .region1_wb_adr_o(region1_wb_adr),
        .region1_wb_dat_o(region1_wb_dat_o),
        .region1_wb_sel_o(region1_wb_sel),
        .region1_wb_stall_i(region1_wb_stall),
        .region1_wb_ack_i(region1_wb_ack),
        .region1_wb_dat_i(region1_wb_dat_i),
        .region1_wb_err_i(region1_wb_err),

        .REGION0_BASE(region0_base_addr),
        .REGION1_BASE(region1_base_addr)
    );
    
    // Region 0 data memory (4KB = 1K words)
    memory_2rw_wb #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(10),  // 1K words = 4KB memory (2^10 = 1024 words)
        .NUM_WMASKS(4)
    ) region0_data_memory (
        .port0_wb_cyc_i(region0_wb_cyc),
        .port0_wb_stb_i(region0_wb_stb),
        .port0_wb_we_i(region0_wb_we),
        .port0_wb_adr_i(region0_wb_adr),
        .port0_wb_dat_i(region0_wb_dat_o),
        .port0_wb_sel_i(region0_wb_sel),
        .port0_wb_stall_o(region0_wb_stall),
        .port0_wb_ack_o(region0_wb_ack),
        .port0_wb_dat_o(region0_wb_dat_i),
        .port0_wb_err_o(region0_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),
        
        // Port 1 unused for region 0
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
    
    // Region 1 data memory (64KB = 16K words)
    memory_2rw_wb #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14),  // 16K words = 64KB memory (2^14 = 16384 words)
        .NUM_WMASKS(4)
    ) region1_data_memory (
        .port0_wb_cyc_i(region1_wb_cyc),
        .port0_wb_stb_i(region1_wb_stb),
        .port0_wb_we_i(region1_wb_we),
        .port0_wb_adr_i(region1_wb_adr),
        .port0_wb_dat_i(region1_wb_dat_o),
        .port0_wb_sel_i(region1_wb_sel),
        .port0_wb_stall_o(region1_wb_stall),
        .port0_wb_ack_o(region1_wb_ack),
        .port0_wb_dat_o(region1_wb_dat_i),
        .port0_wb_err_o(region1_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),
        
        // Port 1 unused for region 1
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
    

    //==========================================================================
    // PERFORMANCE MONITORING
    //==========================================================================
    
    // Monitor performance counters and detect progress
    always_ff @(posedge clk) begin
        if (rst_n) begin
            // Detect instruction execution
            if (perf_instructions_executed != prev_perf_instructions_executed) begin
                $display("[%t] Instructions executed: %d (total: %d)", 
                    $time, perf_instructions_executed - prev_perf_instructions_executed, perf_instructions_executed);
            end
            
            // Periodic performance reports
            if (cycle_count % 10000 == 0 && cycle_count > 0) begin
                if (perf_cycles > 0) begin
                    // Use temporary local variables for display only
                    automatic real temp_ipc = real'(perf_instructions_executed) / real'(perf_cycles);
                    automatic real temp_fetch_eff = real'(perf_instructions_fetched) / real'(perf_cycles);
                    $display("[%t] Performance Report (Cycle %d):", $time, cycle_count);
                    $display("  Instructions executed: %d", perf_instructions_executed);
                    $display("  Instructions fetched: %d", perf_instructions_fetched);
                    $display("  Branch mispredictions: %d", perf_branch_mispredictions);
                    $display("  Buffer stalls: %d", perf_buffer_stalls);
                    $display("  IPC: %.2f", temp_ipc);
                    $display("  Fetch efficiency: %.2f instructions/cycle", temp_fetch_eff);
                end
            end
        end
    end
    
    //==========================================================================
    // PROGRAM LOADING
    //==========================================================================
    
    // Load program from hex file
    initial begin
        string hex_file;
        if ($value$plusargs("hex_file=%s", hex_file)) begin
            $display("[%t] Loading program from %s", $time, hex_file);
            $readmemh(hex_file, instruction_memory.mem);
            $display("[%t] Program loaded successfully", $time);
        end else begin
            $display("[%t] No hex file specified, using default test program", $time);
            // Load a simple test program
            load_default_test_program();
        end
    end
    
    // Default test program for basic functionality
    task load_default_test_program();
        begin
            $display("[%t] Loading comprehensive test program", $time);
            
            // =====================================================================
            // COMPREHENSIVE SUPERSCALAR TEST PROGRAM
            // Tests: Register loading, arithmetic, and logical operations
            // =====================================================================
            
            for (int i = 0; i < 16384; i++) begin
                instruction_memory.mem[i] = 32'h00000013; // NOP (ADDI x0, x0, 0)
            end

            // Phase 1: Load integer values into first 6 registers (x1-x6)
            instruction_memory.mem[0] = 32'h00100093;  // ADDI x1, x0, 1       -> x1 = 1 
            instruction_memory.mem[1] = 32'h00200113;  // ADDI x2, x0, 2       -> x2 = 2 
            instruction_memory.mem[2] = 32'h00300193;  // ADDI x3, x0, 3       -> x3 = 3 
            instruction_memory.mem[3] = 32'h00400213;  // ADDI x4, x0, 4       -> x4 = 4 
            instruction_memory.mem[4] = 32'h00500293;  // ADDI x5, x0, 5       -> x5 = 5
            instruction_memory.mem[5] = 32'h00600313;  // ADDI x6, x0, 6       -> x6 = 6
            
            //Phase 2: Arithmetic Operations
            instruction_memory.mem[6]  = 32'h005203b3; // ADD  x7, x4, x5      -> x7 = 4 + 5 = 9 
            instruction_memory.mem[7]  = 32'h40438433; // SUB  x8, x7, x4      -> x8 = 9 - 4 = 5
            instruction_memory.mem[8]  = 32'h005303b3; // ADD  x7, x6, x5      -> x7 = 6 + 5 = 11
            instruction_memory.mem[9]  = 32'h40138533; // SUB x10, x7, x1      -> x10 = 11 - 1 = 10
            instruction_memory.mem[10] = 32'h006505b3; // ADD x11, x10, x6     -> x11 = 10 + 6 = 16 -- only this is missing!!
            instruction_memory.mem[11] = 32'h40538633; // SUB x12, x7, x5      -> x12 = 11 - 5 = 6

            // Phase 2: Arithmetic Operations
            //instruction_memory.mem[6]  = 32'h002083b3; // ADD  x7, x1, x2      -> x7 = 1 + 2 = 3 -
            //instruction_memory.mem[7]  = 32'h40208433; // SUB  x8, x1, x2      -> x8 = 1 - 2 = -1
            //instruction_memory.mem[8]  = 32'h003104b3; // ADD  x9, x2, x3      -> x9 = 2 + 3 = 5
            //instruction_memory.mem[9]  = 32'h40310533; // SUB x10, x2, x3      -> x10 = 2 - 3 = -1 -
            //instruction_memory.mem[10] = 32'h004185b3; // ADD x11, x3, x4      -> x11 = 3 + 4 = 7
            //instruction_memory.mem[11] = 32'h40418633; // SUB x12, x3, x4      -> x12 = 3 - 4 = -1

            /*   
            // Phase 3: Logical Operations  
            instruction_memory.mem[12] = 32'h0020c6b3; // XOR x13, x1, x2      -> x13 = 1 ^ 2 = 3
            instruction_memory.mem[13] = 32'h0020e733; // OR  x14, x1, x2      -> x14 = 1 | 2 = 3
            instruction_memory.mem[14] = 32'h0020f7b3; // AND x15, x1, x2      -> x15 = 1 & 2 = 0
            instruction_memory.mem[15] = 32'h00314833; // XOR x16, x2, x3      -> x16 = 2 ^ 3 = 1
            instruction_memory.mem[16] = 32'h003168b3; // OR  x17, x2, x3      -> x17 = 2 | 3 = 3
            instruction_memory.mem[17] = 32'h00317933; // AND x18, x2, x3      -> x18 = 2 & 3 = 2
            
            // Phase 4: Shift Operations
            instruction_memory.mem[18] = 32'h002099b3; // SLL x19, x1, x2      -> x19 = 1 << 2 = 4
            instruction_memory.mem[19] = 32'h0021da33; // SRL x20, x3, x2      -> x20 = 3 >> 2 = 0
            instruction_memory.mem[20] = 32'h40215a33; // SRA x20, x2, x2      -> x20 = 2 >>> 2 = 0 (overwrite x20)
            
            // Phase 5: Immediate Operations  
            instruction_memory.mem[21] = 32'h00a08a93; // ADDI x21, x1, 10     -> x21 = 1 + 10 = 11
            instruction_memory.mem[22] = 32'h00f0cb13; // XORI x22, x1, 15     -> x22 = 1 ^ 15 = 14
            instruction_memory.mem[23] = 32'h00f0eb93; // ORI  x23, x1, 15     -> x23 = 1 | 15 = 15
            instruction_memory.mem[24] = 32'h00f0fc13; // ANDI x24, x1, 15     -> x24 = 1 & 15 = 1
            
            // Phase 6: Complex arithmetic using multiple registers
            instruction_memory.mem[25] = 32'h00520cb3; // ADD x25, x4, x5      -> x25 = 4 + 5 = 9
            instruction_memory.mem[26] = 32'h00628d33; // ADD x26, x5, x6      -> x26 = 5 + 6 = 11
            instruction_memory.mem[27] = 32'h01ac8db3; // ADD x27, x25, x26    -> x27 = 9 + 11 = 20
            
            // Phase 7: Set Less Than operations
            instruction_memory.mem[28] = 32'h0020ae33; // SLT x28, x1, x2      -> x28 = (1 < 2) = 1
            instruction_memory.mem[29] = 32'h00103eb3; // SLTU x29, x0, x1     -> x29 = (0 < 1) = 1  
            instruction_memory.mem[30] = 32'h0010af33; // SLT x30, x1, x1      -> x30 = (1 < 1) = 0
            */
            
            $display("[%t] Comprehensive test program loaded:", $time);
            $display("  Phase 1: Load x1=1, x2=2, x3=3, x4=4, x5=5, x6=6");
            $display("  Phase 2: Arithmetic operations (ADD/SUB)");
            $display("  Phase 3: Logical operations (XOR/OR/AND)");  
            $display("  Phase 4: Shift operations (SLL/SRL/SRA)");
            $display("  Phase 5: Immediate operations");
            $display("  Phase 6: Complex multi-register arithmetic");
            $display("  Phase 7: Set Less Than operations");
            $display("  Phase 8: Pipeline flush NOPs");
        end
    endtask
    
    

 
    /* 
    // Performance coverage
    covergroup performance_coverage @(posedge clk);
        option.at_least = 1;
        
        ipc_bins: coverpoint (perf_cycles > 0 ? real'(perf_instructions_executed) / real'(perf_cycles) : 0.0) {
            bins low_ipc = {[0.0:0.5]};
            bins medium_ipc = {[0.5:1.5]};
            bins high_ipc = {[1.5:3.0]};
        }
        
        fetch_efficiency_bins: coverpoint (perf_cycles > 0 ? real'(perf_instructions_fetched) / real'(perf_cycles) : 0.0) {
            bins low_fetch = {[0.0:1.0]};
            bins medium_fetch = {[1.0:2.0]};
            bins high_fetch = {[2.0:3.0]};
        }
    endgroup
    */
    //==========================================================================
    // TEST COMPLETION DETECTION
    //==========================================================================
    
    
    // Final cleanup
    final begin
        if (test_failed) begin
            $display("=================================================================");
            $display("TEST FAILED");
            $display("=================================================================");
        end else begin
            $display("=================================================================");
            $display("TEST INCOMPLETE");
            $display("=================================================================");
        end
    end

endmodule
