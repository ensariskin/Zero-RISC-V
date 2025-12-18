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
    parameter INST_BASE_addR = 32'h80000000;

    // Default region base addresses (can be overridden via plusargs)
    parameter REGION0_BASE_addR_DEFAULT = 32'h80010000;  // Default Region 0 start address (data/stack)
    parameter REGION1_BASE_addR_DEFAULT = 32'h80011000;  // Default Region 1 start address

    // Runtime configurable region base addresses
    logic [31:0] region0_base_addr;
    logic [31:0] region1_base_addr;

    localparam D = 1; // Delay for simulation purposes

    // Clock and reset
    logic clk;
    logic rst_n;

    // Superscalar core signals (3-port instruction interface)
    logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2, inst_addr_3, inst_addr_4;
    logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2, instruction_i_3, instruction_i_4;

    // Data memory interface
    logic [DATA_WIDTH-1:0] data_0_addr;
    logic [DATA_WIDTH-1:0] data_0_write;
    logic [DATA_WIDTH-1:0] data_0_read;
    logic                  data_0_we;
    logic [3:0]            data_0_be;
    logic                  data_0_req;
    logic                  data_0_ack;
    logic                  data_0_err;

    logic [DATA_WIDTH-1:0] data_1_addr;
    logic [DATA_WIDTH-1:0] data_1_write;
    logic [DATA_WIDTH-1:0] data_1_read;
    logic                  data_1_we;
    logic [3:0]            data_1_be;
    logic                  data_1_req;
    logic                  data_1_ack;
    logic                  data_1_err;

    logic [DATA_WIDTH-1:0] data_2_addr;
    logic [DATA_WIDTH-1:0] data_2_write;
    logic [DATA_WIDTH-1:0] data_2_read;
    logic                  data_2_we;
    logic [3:0]            data_2_be;
    logic                  data_2_req;
    logic                  data_2_ack;
    logic                  data_2_err;

    // External interrupt interface
    logic external_interrupt;
    logic timer_interrupt;
    logic software_interrupt;

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

    logic inst3_wb_cyc, inst3_wb_stb, inst3_wb_we;
    logic [31:0] inst3_wb_adr, inst3_wb_dat_o, inst3_wb_dat_i;
    logic [3:0] inst3_wb_sel;
    logic inst3_wb_stall, inst3_wb_ack, inst3_wb_err;

    logic inst4_wb_cyc, inst4_wb_stb, inst4_wb_we;
    logic [31:0] inst4_wb_adr, inst4_wb_dat_o, inst4_wb_dat_i;
    logic [3:0] inst4_wb_sel;
    logic inst4_wb_stall, inst4_wb_ack, inst4_wb_err;

    // Wishbone signals for data memory
    logic data_0_wb_cyc, data_0_wb_stb, data_0_wb_we;
    logic [31:0] data_0_wb_adr, data_0_wb_dat_o, data_0_wb_dat_i;
    logic [3:0] data_0_wb_sel;
    logic data_0_wb_stall, data_0_wb_ack, data_0_wb_err;

    logic data_1_wb_cyc, data_1_wb_stb, data_1_wb_we;
    logic [31:0] data_1_wb_adr, data_1_wb_dat_o, data_1_wb_dat_i;
    logic [3:0] data_1_wb_sel;
    logic data_1_wb_stall, data_1_wb_ack, data_1_wb_err;

    logic data_2_wb_cyc, data_2_wb_stb, data_2_wb_we;
    logic [31:0] data_2_wb_adr, data_2_wb_dat_o, data_2_wb_dat_i;
    logic [3:0] data_2_wb_sel;
    logic data_2_wb_stall, data_2_wb_ack, data_2_wb_err;

    // Region memory signals
    logic region0_0_wb_cyc, region0_0_wb_stb, region0_0_wb_we;
    logic [31:0] region0_0_wb_adr, region0_0_wb_dat_o, region0_0_wb_dat_i;
    logic [3:0] region0_0_wb_sel;
    logic region0_0_wb_stall, region0_0_wb_ack, region0_0_wb_err;

    logic region0_1_wb_cyc, region0_1_wb_stb, region0_1_wb_we;
    logic [31:0] region0_1_wb_adr, region0_1_wb_dat_o, region0_1_wb_dat_i;
    logic [3:0] region0_1_wb_sel;
    logic region0_1_wb_stall, region0_1_wb_ack, region0_1_wb_err;

    logic region0_2_wb_cyc, region0_2_wb_stb, region0_2_wb_we;
    logic [31:0] region0_2_wb_adr, region0_2_wb_dat_o, region0_2_wb_dat_i;
    logic [3:0] region0_2_wb_sel;
    logic region0_2_wb_stall, region0_2_wb_ack, region0_2_wb_err;


    logic region1_0_wb_cyc, region1_0_wb_stb, region1_0_wb_we;
    logic [31:0] region1_0_wb_adr, region1_0_wb_dat_o, region1_0_wb_dat_i;
    logic [3:0] region1_0_wb_sel;
    logic region1_0_wb_stall, region1_0_wb_ack, region1_0_wb_err;

    logic region1_1_wb_cyc, region1_1_wb_stb, region1_1_wb_we;
    logic [31:0] region1_1_wb_adr, region1_1_wb_dat_o, region1_1_wb_dat_i;
    logic [3:0] region1_1_wb_sel;
    logic region1_1_wb_stall, region1_1_wb_ack, region1_1_wb_err;

    logic region1_2_wb_cyc, region1_2_wb_stb, region1_2_wb_we;
    logic [31:0] region1_2_wb_adr, region1_2_wb_dat_o, region1_2_wb_dat_i;
    logic [3:0] region1_2_wb_sel;
    logic region1_2_wb_stall, region1_2_wb_ack, region1_2_wb_err;

    tracer_interface tracer_0();
    tracer_interface tracer_1();
    tracer_interface tracer_2();


    // Test control
    logic test_passed;
    logic test_failed;
    integer cycle_count;

    logic ecall_detected;
    assign ecall_detected = (tracer_0.valid && (tracer_0.instr == 32'h00000073)) | (tracer_1.valid && (tracer_1.instr == 32'h73)) | (tracer_2.valid && (tracer_2.instr == 32'h00000073)); //ECALL instruction
    logic [31:0] max_cycles;

    //==========================================================================
    // SIMULATION CONTROL and MONITorING
    //==========================================================================

    initial begin
        $display("=================================================================");
        $display("RV32I Superscalar Core RISC-V DV Testbench");
        $display("=================================================================");
        $display("Instruction base address: 0x%08x", INST_BASE_addR);
        $display("3-way superscalar configuration");
        $display("Simulation started at time %t", $time);
        $display("=================================================================");
        `ifdef SECURE_UNALIGN_LSQ
        $display("SECURE UNALIGN_LSQ is defined");
        `else
        $display("SECURE UNALIGN_LSQ is NOT defined");
        `endif

        `ifdef DEBUG_MEMORY_SELECTOR
        $display("DEBUG_MEMORY_SELECTOR is defined");
        `else
        $display("DEBUG_MEMORY_SELECTOR is NOT defined");
        `endif

    end


    //==========================================================================
    // CLOCK and RESET GENERATION
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
    // SUPERSCALAR CorE INSTANTIATION
    //==========================================================================

    rv32i_superscalar_core #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(16),
        .REG_FILE_ADDR_WIDTH(REG_FILE_ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .reset(rst_n),

        // Instruction Memory Interface (3-port for parallel fetch)
        .inst_addr_0(inst_addr_0),
        .inst_addr_1(inst_addr_1),
        .inst_addr_2(inst_addr_2),
        .inst_addr_3(inst_addr_3),
        .inst_addr_4(inst_addr_4),
        .instruction_i_0(instruction_i_0),
        .instruction_i_1(instruction_i_1),
        .instruction_i_2(instruction_i_2),
        .instruction_i_3(instruction_i_3),
        .instruction_i_4(instruction_i_4),

        .o_tracer_0(tracer_0),
        .o_tracer_1(tracer_1),
        .o_tracer_2(tracer_2),
        // Data Memory Interface
        .data_0_addr (data_0_addr),
        .data_0_write(data_0_write),
        .data_0_read (data_0_read),
        .data_0_we   (data_0_we),
        .data_0_be   (data_0_be),
        .data_0_req  (data_0_req),
        .data_0_ack  (data_0_ack),
        .data_0_err  (data_0_err),

        .data_1_addr (data_1_addr),
        .data_1_write(data_1_write),
        .data_1_read (data_1_read),
        .data_1_we   (data_1_we),
        .data_1_be   (data_1_be),
        .data_1_req  (data_1_req),
        .data_1_ack  (data_1_ack),
        .data_1_err  (data_1_err),

        .data_2_addr (data_2_addr),
        .data_2_write(data_2_write),
        .data_2_read (data_2_read),
        .data_2_we   (data_2_we),
        .data_2_be   (data_2_be),
        .data_2_req  (data_2_req),
        .data_2_ack  (data_2_ack),
        .data_2_err  (data_2_err),

        // External Interrupt Interface
        .external_interrupt(external_interrupt),
        .timer_interrupt(timer_interrupt),
        .software_interrupt(software_interrupt)
    );

    //==========================================================================
    // INSTRUCTION MEMorY ADAPTERS (3 ports)
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

    // Port 3 instruction memory adapter
    rv32i_inst_wb_adapter inst3_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(inst_addr_3),
        .core_data_o(instruction_i_3),
        .wb_cyc_o(inst3_wb_cyc),
        .wb_stb_o(inst3_wb_stb),
        .wb_we_o(inst3_wb_we),
        .wb_adr_o(inst3_wb_adr),
        .wb_dat_o(inst3_wb_dat_o),
        .wb_sel_o(inst3_wb_sel),
        .wb_stall_i(inst3_wb_stall),
        .wb_ack_i(inst3_wb_ack),
        .wb_dat_i(inst3_wb_dat_i),
        .wb_err_i(inst3_wb_err)
    );

    // Port 4 instruction memory adapter
    rv32i_inst_wb_adapter inst4_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(inst_addr_4),
        .core_data_o(instruction_i_4),
        .wb_cyc_o(inst4_wb_cyc),
        .wb_stb_o(inst4_wb_stb),
        .wb_we_o(inst4_wb_we),
        .wb_adr_o(inst4_wb_adr),
        .wb_dat_o(inst4_wb_dat_o),
        .wb_sel_o(inst4_wb_sel),
        .wb_stall_i(inst4_wb_stall),
        .wb_ack_i(inst4_wb_ack),
        .wb_dat_i(inst4_wb_dat_i),
        .wb_err_i(inst4_wb_err)
    );

    // 5-port instruction memory (64KB = 16K words)
    memory_5rw #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(17),  // 16K words = 64KB memory (2^14 = 16384 words)
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
        .port2_wb_clk_i(clk),

        // Port 3 (fetch 3)
        .port3_wb_cyc_i(inst3_wb_cyc),
        .port3_wb_stb_i(inst3_wb_stb),
        .port3_wb_we_i(inst3_wb_we),
        .port3_wb_adr_i(inst3_wb_adr),
        .port3_wb_dat_i(inst3_wb_dat_o),
        .port3_wb_sel_i(inst3_wb_sel),
        .port3_wb_stall_o(inst3_wb_stall),
        .port3_wb_ack_o(inst3_wb_ack),
        .port3_wb_dat_o(inst3_wb_dat_i),
        .port3_wb_err_o(inst3_wb_err),
        .port3_wb_rst_i(~rst_n),
        .port3_wb_clk_i(clk),

        // Port 4 (fetch 4)
        .port4_wb_cyc_i(inst4_wb_cyc),
        .port4_wb_stb_i(inst4_wb_stb),
        .port4_wb_we_i(inst4_wb_we),
        .port4_wb_adr_i(inst4_wb_adr),
        .port4_wb_dat_i(inst4_wb_dat_o),
        .port4_wb_sel_i(inst4_wb_sel),
        .port4_wb_stall_o(inst4_wb_stall),
        .port4_wb_ack_o(inst4_wb_ack),
        .port4_wb_dat_o(inst4_wb_dat_i),
        .port4_wb_err_o(inst4_wb_err),
        .port4_wb_rst_i(~rst_n),
        .port4_wb_clk_i(clk)
    );
    //==========================================================================
    // DATA MEMorY ADAPTER
    //==========================================================================

    rv32i_superscalar_data_wb_adapter data_0_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(data_0_addr),
        .core_data_i(data_0_write),
        .core_data_o(data_0_read),
        .core_we_i  (data_0_we),
        .core_be_i  (data_0_be),
        .core_req_i (data_0_req),
        .core_ack_o (data_0_ack),
        .core_err_o (data_0_err),
        .wb_cyc_o   (data_0_wb_cyc),
        .wb_stb_o   (data_0_wb_stb),
        .wb_we_o    (data_0_wb_we),
        .wb_adr_o   (data_0_wb_adr),
        .wb_dat_o   (data_0_wb_dat_o),
        .wb_sel_o   (data_0_wb_sel),
        .wb_stall_i (data_0_wb_stall),
        .wb_ack_i   (data_0_wb_ack),
        .wb_dat_i   (data_0_wb_dat_i),
        .wb_err_i   (data_0_wb_err)
    );

    rv32i_superscalar_data_wb_adapter data_1_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(data_1_addr),
        .core_data_i(data_1_write),
        .core_data_o(data_1_read),
        .core_we_i  (data_1_we),
        .core_be_i  (data_1_be),
        .core_req_i (data_1_req),
        .core_ack_o (data_1_ack),
        .core_err_o (data_1_err),
        .wb_cyc_o   (data_1_wb_cyc),
        .wb_stb_o   (data_1_wb_stb),
        .wb_we_o    (data_1_wb_we),
        .wb_adr_o   (data_1_wb_adr),
        .wb_dat_o   (data_1_wb_dat_o),
        .wb_sel_o   (data_1_wb_sel),
        .wb_stall_i (data_1_wb_stall),
        .wb_ack_i   (data_1_wb_ack),
        .wb_dat_i   (data_1_wb_dat_i),
        .wb_err_i   (data_1_wb_err)
    );

    rv32i_superscalar_data_wb_adapter data_2_wb_adapter (
        .clk(clk),
        .rst_n(rst_n),
        .core_addr_i(data_2_addr),
        .core_data_i(data_2_write),
        .core_data_o(data_2_read),
        .core_we_i  (data_2_we),
        .core_be_i  (data_2_be),
        .core_req_i (data_2_req),
        .core_ack_o (data_2_ack),
        .core_err_o (data_2_err),
        .wb_cyc_o   (data_2_wb_cyc),
        .wb_stb_o   (data_2_wb_stb),
        .wb_we_o    (data_2_wb_we),
        .wb_adr_o   (data_2_wb_adr),
        .wb_dat_o   (data_2_wb_dat_o),
        .wb_sel_o   (data_2_wb_sel),
        .wb_stall_i (data_2_wb_stall),
        .wb_ack_i   (data_2_wb_ack),
        .wb_dat_i   (data_2_wb_dat_i),
        .wb_err_i   (data_2_wb_err)
    );

    //==========================================================================
    // MEMorY subSYSTEM (3-PorT INSTRUCTION + DATA)
    //==========================================================================


    // Data memory selector/router
    data_memory_selector data_0_mem_selector (
        .clk(clk),
        .rst_n(rst_n),

        // Core interface (from data wb adapter)
        .core_wb_cyc_i  (data_0_wb_cyc),
        .core_wb_stb_i  (data_0_wb_stb),
        .core_wb_we_i   (data_0_wb_we),
        .core_wb_adr_i  (data_0_wb_adr),
        .core_wb_dat_i  (data_0_wb_dat_o),
        .core_wb_sel_i  (data_0_wb_sel),
        .core_wb_stall_o(data_0_wb_stall),
        .core_wb_ack_o  (data_0_wb_ack),
        .core_wb_dat_o  (data_0_wb_dat_i),
        .core_wb_err_o  (data_0_wb_err),

        // Region 0 memory interface
        .region0_wb_cyc_o  (region0_0_wb_cyc),
        .region0_wb_stb_o  (region0_0_wb_stb),
        .region0_wb_we_o   (region0_0_wb_we),
        .region0_wb_adr_o  (region0_0_wb_adr),
        .region0_wb_dat_o  (region0_0_wb_dat_o),
        .region0_wb_sel_o  (region0_0_wb_sel),
        .region0_wb_stall_i(region0_0_wb_stall),
        .region0_wb_ack_i  (region0_0_wb_ack),
        .region0_wb_dat_i  (region0_0_wb_dat_i),
        .region0_wb_err_i  (region0_0_wb_err),

        // Region 1 memory interface
        .region1_wb_cyc_o  (region1_0_wb_cyc),
        .region1_wb_stb_o  (region1_0_wb_stb),
        .region1_wb_we_o   (region1_0_wb_we),
        .region1_wb_adr_o  (region1_0_wb_adr),
        .region1_wb_dat_o  (region1_0_wb_dat_o),
        .region1_wb_sel_o  (region1_0_wb_sel),
        .region1_wb_stall_i(region1_0_wb_stall),
        .region1_wb_ack_i  (region1_0_wb_ack),
        .region1_wb_dat_i  (region1_0_wb_dat_i),
        .region1_wb_err_i  (region1_0_wb_err),

        .REGION0_BASE(region0_base_addr),
        .REGION1_BASE(region1_base_addr)
    );

    data_memory_selector data_1_mem_selector (
        .clk(clk),
        .rst_n(rst_n),

        // Core interface (from data wb adapter)
        .core_wb_cyc_i  (data_1_wb_cyc),
        .core_wb_stb_i  (data_1_wb_stb),
        .core_wb_we_i   (data_1_wb_we),
        .core_wb_adr_i  (data_1_wb_adr),
        .core_wb_dat_i  (data_1_wb_dat_o),
        .core_wb_sel_i  (data_1_wb_sel),
        .core_wb_stall_o(data_1_wb_stall),
        .core_wb_ack_o  (data_1_wb_ack),
        .core_wb_dat_o  (data_1_wb_dat_i),
        .core_wb_err_o  (data_1_wb_err),

        // Region 0 memory interface
        .region0_wb_cyc_o  (region0_1_wb_cyc),
        .region0_wb_stb_o  (region0_1_wb_stb),
        .region0_wb_we_o   (region0_1_wb_we),
        .region0_wb_adr_o  (region0_1_wb_adr),
        .region0_wb_dat_o  (region0_1_wb_dat_o),
        .region0_wb_sel_o  (region0_1_wb_sel),
        .region0_wb_stall_i(region0_1_wb_stall),
        .region0_wb_ack_i  (region0_1_wb_ack),
        .region0_wb_dat_i  (region0_1_wb_dat_i),
        .region0_wb_err_i  (region0_1_wb_err),

        // Region 1 memory interface
        .region1_wb_cyc_o  (region1_1_wb_cyc),
        .region1_wb_stb_o  (region1_1_wb_stb),
        .region1_wb_we_o   (region1_1_wb_we),
        .region1_wb_adr_o  (region1_1_wb_adr),
        .region1_wb_dat_o  (region1_1_wb_dat_o),
        .region1_wb_sel_o  (region1_1_wb_sel),
        .region1_wb_stall_i(region1_1_wb_stall),
        .region1_wb_ack_i  (region1_1_wb_ack),
        .region1_wb_dat_i  (region1_1_wb_dat_i),
        .region1_wb_err_i  (region1_1_wb_err),

        .REGION0_BASE(region0_base_addr),
        .REGION1_BASE(region1_base_addr)
    );

    data_memory_selector data_2_mem_selector (
        .clk(clk),
        .rst_n(rst_n),

        // Core interface (from data wb adapter)
        .core_wb_cyc_i  (data_2_wb_cyc),
        .core_wb_stb_i  (data_2_wb_stb),
        .core_wb_we_i   (data_2_wb_we),
        .core_wb_adr_i  (data_2_wb_adr),
        .core_wb_dat_i  (data_2_wb_dat_o),
        .core_wb_sel_i  (data_2_wb_sel),
        .core_wb_stall_o(data_2_wb_stall),
        .core_wb_ack_o  (data_2_wb_ack),
        .core_wb_dat_o  (data_2_wb_dat_i),
        .core_wb_err_o  (data_2_wb_err),

        // Region 0 memory interface
        .region0_wb_cyc_o  (region0_2_wb_cyc),
        .region0_wb_stb_o  (region0_2_wb_stb),
        .region0_wb_we_o   (region0_2_wb_we),
        .region0_wb_adr_o  (region0_2_wb_adr),
        .region0_wb_dat_o  (region0_2_wb_dat_o),
        .region0_wb_sel_o  (region0_2_wb_sel),
        .region0_wb_stall_i(region0_2_wb_stall),
        .region0_wb_ack_i  (region0_2_wb_ack),
        .region0_wb_dat_i  (region0_2_wb_dat_i),
        .region0_wb_err_i  (region0_2_wb_err),

        // Region 1 memory interface
        .region1_wb_cyc_o  (region1_2_wb_cyc),
        .region1_wb_stb_o  (region1_2_wb_stb),
        .region1_wb_we_o   (region1_2_wb_we),
        .region1_wb_adr_o  (region1_2_wb_adr),
        .region1_wb_dat_o  (region1_2_wb_dat_o),
        .region1_wb_sel_o  (region1_2_wb_sel),
        .region1_wb_stall_i(region1_2_wb_stall),
        .region1_wb_ack_i  (region1_2_wb_ack),
        .region1_wb_dat_i  (region1_2_wb_dat_i),
        .region1_wb_err_i  (region1_2_wb_err),

        .REGION0_BASE(region0_base_addr),
        .REGION1_BASE(region1_base_addr)
    );

    // Region 0 data memory (64KB = 16K words)
    memory_3rw_unaligned #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14),  // 16K words = 64KB memory (2^14 = 16384 words)
        .NUM_WMASKS(4)
    ) region0_data_memory (
        .port0_wb_cyc_i  (region0_0_wb_cyc),
        .port0_wb_stb_i  (region0_0_wb_stb),
        .port0_wb_we_i   (region0_0_wb_we),
        .port0_wb_adr_i  (region0_0_wb_adr),
        .port0_wb_dat_i  (region0_0_wb_dat_o),
        .port0_wb_sel_i  (region0_0_wb_sel),
        .port0_wb_stall_o(region0_0_wb_stall),
        .port0_wb_ack_o  (region0_0_wb_ack),
        .port0_wb_dat_o  (region0_0_wb_dat_i),
        .port0_wb_err_o  (region0_0_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),

        // Port 1 unused for region 0
        .port1_wb_cyc_i  (region0_1_wb_cyc),
        .port1_wb_stb_i  (region0_1_wb_stb),
        .port1_wb_we_i   (region0_1_wb_we),
        .port1_wb_adr_i  (region0_1_wb_adr),
        .port1_wb_dat_i  (region0_1_wb_dat_o),
        .port1_wb_sel_i  (region0_1_wb_sel),
        .port1_wb_stall_o(region0_1_wb_stall),
        .port1_wb_ack_o  (region0_1_wb_ack),
        .port1_wb_dat_o  (region0_1_wb_dat_i),
        .port1_wb_err_o  (region0_1_wb_err),
        .port1_wb_rst_i(~rst_n),
        .port1_wb_clk_i(clk),

        // Port 2 unused for region 0
        .port2_wb_cyc_i  (region0_2_wb_cyc),
        .port2_wb_stb_i  (region0_2_wb_stb),
        .port2_wb_we_i   (region0_2_wb_we),
        .port2_wb_adr_i  (region0_2_wb_adr),
        .port2_wb_dat_i  (region0_2_wb_dat_o),
        .port2_wb_sel_i  (region0_2_wb_sel),
        .port2_wb_stall_o(region0_2_wb_stall),
        .port2_wb_ack_o  (region0_2_wb_ack),
        .port2_wb_dat_o  (region0_2_wb_dat_i),
        .port2_wb_err_o  (region0_2_wb_err),
        .port2_wb_rst_i(~rst_n),
        .port2_wb_clk_i(clk)
    );

    // Region 1 data memory (64KB = 16K words)
    memory_3rw_unaligned #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(14),  // 16K words = 64KB memory (2^14 = 16384 words)
        .NUM_WMASKS(4)
    ) region1_data_memory (
        .port0_wb_cyc_i  (region1_0_wb_cyc),
        .port0_wb_stb_i  (region1_0_wb_stb),
        .port0_wb_we_i   (region1_0_wb_we),
        .port0_wb_adr_i  (region1_0_wb_adr),
        .port0_wb_dat_i  (region1_0_wb_dat_o),
        .port0_wb_sel_i  (region1_0_wb_sel),
        .port0_wb_stall_o(region1_0_wb_stall),
        .port0_wb_ack_o  (region1_0_wb_ack),
        .port0_wb_dat_o  (region1_0_wb_dat_i),
        .port0_wb_err_o  (region1_0_wb_err),
        .port0_wb_rst_i(~rst_n),
        .port0_wb_clk_i(clk),

        // Port 1 unused for region 0
        .port1_wb_cyc_i  (region1_1_wb_cyc),
        .port1_wb_stb_i  (region1_1_wb_stb),
        .port1_wb_we_i   (region1_1_wb_we),
        .port1_wb_adr_i  (region1_1_wb_adr),
        .port1_wb_dat_i  (region1_1_wb_dat_o),
        .port1_wb_sel_i  (region1_1_wb_sel),
        .port1_wb_stall_o(region1_1_wb_stall),
        .port1_wb_ack_o  (region1_1_wb_ack),
        .port1_wb_dat_o  (region1_1_wb_dat_i),
        .port1_wb_err_o  (region1_1_wb_err),
        .port1_wb_rst_i(~rst_n),
        .port1_wb_clk_i(clk),

        // Port 2 unused for region 0
        .port2_wb_cyc_i  (region1_2_wb_cyc),
        .port2_wb_stb_i  (region1_2_wb_stb),
        .port2_wb_we_i   (region1_2_wb_we),
        .port2_wb_adr_i  (region1_2_wb_adr),
        .port2_wb_dat_i  (region1_2_wb_dat_o),
        .port2_wb_sel_i  (region1_2_wb_sel),
        .port2_wb_stall_o(region1_2_wb_stall),
        .port2_wb_ack_o  (region1_2_wb_ack),
        .port2_wb_dat_o  (region1_2_wb_dat_i),
        .port2_wb_err_o  (region1_2_wb_err),
        .port2_wb_rst_i(~rst_n),
        .port2_wb_clk_i(clk)
    );


    //==========================================================================
    // Tracer Module
    //==========================================================================
    tracer_3port tracer (
        .clk_i      (clk),
        .valid_0    (tracer_0.valid),
        .pc_0       (tracer_0.pc),
        .instr_0    (tracer_0.instr),
        .reg_addr_0 (tracer_0.reg_addr),
        .reg_data_0 (tracer_0.reg_data),
        .is_load_0  (tracer_0.is_load),
        .is_store_0 (tracer_0.is_store),
        .is_float_0 (tracer_0.is_float),
        .mem_size_0 (tracer_0.mem_size),
        .mem_addr_0 (tracer_0.mem_addr),
        .mem_data_0 (tracer_0.mem_data),
        .fpu_flags_0(tracer_0.fpu_flags),

        .valid_1    (tracer_1.valid),
        .pc_1       (tracer_1.pc),
        .instr_1    (tracer_1.instr),
        .reg_addr_1 (tracer_1.reg_addr),
        .reg_data_1 (tracer_1.reg_data),
        .is_load_1  (tracer_1.is_load),
        .is_store_1 (tracer_1.is_store),
        .is_float_1 (tracer_1.is_float),
        .mem_size_1 (tracer_1.mem_size),
        .mem_addr_1 (tracer_1.mem_addr),
        .mem_data_1 (tracer_1.mem_data),
        .fpu_flags_1(tracer_1.fpu_flags),

        .valid_2    (tracer_2.valid),
        .pc_2       (tracer_2.pc),
        .instr_2    (tracer_2.instr),
        .reg_addr_2 (tracer_2.reg_addr),
        .reg_data_2 (tracer_2.reg_data),
        .is_load_2  (tracer_2.is_load),
        .is_store_2 (tracer_2.is_store),
        .is_float_2 (tracer_2.is_float),
        .mem_size_2 (tracer_2.mem_size),
        .mem_addr_2 (tracer_2.mem_addr),
        .mem_data_2 (tracer_2.mem_data),
        .fpu_flags_2(tracer_2.fpu_flags)


    );

    logic lsq_buffer_error;
    always_comb begin
        lsq_buffer_error = 1'b0;
        if(dut.issue_stage_unit.rat_inst.lsq_address_buffer.buffer_count < dv_top_superscalar.dut.issue_stage_unit.rat_inst.free_address_buffer.buffer_count) begin
            lsq_buffer_error = 1'b1;
        end
    end

    logic [5:0] lsq_check_count;
    logic lsq_check_error;
    logic lsq_check_error_2;

    logic [5:0] rob_active_load_store_count;
    logic [5:0] rob_head_idx;
    logic [5:0] rob_tail_idx;
    logic [5:0] rob_idx;

    // ROB'daki aktif load/store instruction sayısını hesaplayan fonksiyon
    // Circular buffer mantığıyla head'den tail'e kadar olan entry'leri tarar
    always_comb begin

        rob_active_load_store_count = 0;
        rob_head_idx = dut.dispatch_stage_unit.rob.head_ptr_reg;
        rob_tail_idx = dut.dispatch_stage_unit.rob.tail_ptr_reg;

        // Circular buffer: head'den tail'e kadar tara (tail dahil değil)
        // Örnek 1: head=2, tail=10 => 2,3,4,5,6,7,8,9 (8 entry)
        // Örnek 2: head=23, tail=2 => 23,24,25,...,31,0,1 (11 entry)
        if (rob_head_idx != rob_tail_idx) begin
            rob_idx = rob_head_idx;
            // Tüm valid entry'leri tara
            while (rob_idx != rob_tail_idx) begin
                // tracer_buffer'dan is_load veya is_store kontrolü
                if (dut.dispatch_stage_unit.rob.tracer_buffer[rob_idx[4:0]].is_load ||
                        dut.dispatch_stage_unit.rob.tracer_buffer[rob_idx[4:0]].is_store) begin
                    rob_active_load_store_count = rob_active_load_store_count + 1;
                end
                // Circular artırma (32 entry için mod 32)
                rob_idx = (rob_idx + 1) % 64;
            end
        end
    end

    assign lsq_check_count = dut.issue_stage_unit.rat_inst.lsq_address_buffer.buffer_count + rob_active_load_store_count;
    always_ff @(posedge clk) begin
        lsq_check_error <= #D 0;
        lsq_check_error_2 <= #D 0;
        if(dut.eager_flush) begin
            #2ns;
            if(lsq_check_count != 32) begin
                lsq_check_error <= 1;
            end
        end
        if(dut.dispatch_stage_unit.lsq.count_2 > rob_active_load_store_count) begin
            lsq_check_error_2 <= 1;
        end
    end

    logic [5:0] rob_check_count;
    logic rob_check_error;
    assign rob_check_count = dut.dispatch_stage_unit.rob.buffer_count + dut.issue_stage_unit.rat_inst.free_address_buffer.buffer_count;
    always_ff @(posedge clk) begin
        rob_check_error <= #D 0;

        if(dut.eager_flush) begin
            #2ns;
            if(rob_check_count != 32) begin
                rob_check_error <= 1;
            end
        end
    end

    //==========================================================================
    // PERForMANCE MONITorING
    //==========================================================================
    /*
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
     */

    //==========================================================================
    // INSTRUCTION DECODE ACTIVITY MONITORING
    //==========================================================================

    // Decode activity counters
    integer decode_ready_count;
    integer decode_valid_count;
    integer decode_sample_cycles;

    integer rs_0_ready_count;
    integer rs_1_ready_count;
    integer rs_2_ready_count;
    integer rename_ready_count;
    integer lsq_ready_count;

    integer cdb_0_valid_count;
    integer cdb_1_valid_count;
    integer cdb_2_valid_count;
    integer cdb_3_0_valid_count;
    integer cdb_3_1_valid_count;
    integer cdb_3_2_valid_count;
    integer cdb_all_valid_count;

    integer commit_count;


    real avg_decode_ready;
    real avg_decode_valid;
    real avg_rs_0_ready;
    real avg_rs_1_ready;
    real avg_rs_2_ready;
    real avg_rename_ready;
    real avg_lsq_ready;
    real avg_cdb_0_valid;
    real avg_cdb_1_valid;
    real avg_cdb_2_valid;
    real avg_cdb_3_0_valid;
    real avg_cdb_3_1_valid;
    real avg_cdb_3_2_valid;
    real avg_cdb_all_valid;
    real avg_commit_rate;

    integer total_branches;          // Total predicted branches (update_prediction_valid)
    integer mispredicted_branches;   // Mispredicted branches
    integer jalr_count;              // JALR instructions (misprediction without prediction_valid)
    integer total_rob_entries_on_mispred; // Total ROB entries when mispredictions occur
    integer total_mispredictions;         // Total mispredictions (branches + JALR)



    // Periodic decode activity sampling
    always @(posedge clk) begin
        if (rst_n) begin
            decode_ready_count =  decode_ready_count +
                dut.issue_stage_unit.decode_ready_o[2] +
                dut.issue_stage_unit.decode_ready_o[1] +
                dut.issue_stage_unit.decode_ready_o[0];
            decode_valid_count =  decode_valid_count +
                dut.issue_stage_unit.decode_valid_i[2] +
                dut.issue_stage_unit.decode_valid_i[1] +
                dut.issue_stage_unit.decode_valid_i[0];

            rs_0_ready_count =  rs_0_ready_count + dut.issue_to_dispatch_0_if.dispatch_ready;
            rs_1_ready_count =  rs_1_ready_count + dut.issue_to_dispatch_1_if.dispatch_ready;
            rs_2_ready_count =  rs_2_ready_count + dut.issue_to_dispatch_2_if.dispatch_ready;

            rename_ready_count =  rename_ready_count + dut.issue_stage_unit.rename_ready[2] +
                dut.issue_stage_unit.rename_ready[1] +
                dut.issue_stage_unit.rename_ready[0];

            lsq_ready_count =  lsq_ready_count + dut.issue_stage_unit.lsq_alloc_ready[2] +
                dut.issue_stage_unit.lsq_alloc_ready[1] +
                dut.issue_stage_unit.lsq_alloc_ready[0];


            cdb_0_valid_count =  cdb_0_valid_count + (dut.cdb_interface.cdb_valid_0 & !dut.cdb_interface.cdb_mem_addr_calculation_0);
            cdb_1_valid_count =  cdb_1_valid_count + (dut.cdb_interface.cdb_valid_1 & !dut.cdb_interface.cdb_mem_addr_calculation_1);
            cdb_2_valid_count =  cdb_2_valid_count + (dut.cdb_interface.cdb_valid_2 & !dut.cdb_interface.cdb_mem_addr_calculation_2);
            cdb_3_0_valid_count =  cdb_3_0_valid_count + dut.cdb_interface.cdb_valid_3_0;
            cdb_3_1_valid_count =  cdb_3_1_valid_count + dut.cdb_interface.cdb_valid_3_1;
            cdb_3_2_valid_count =  cdb_3_2_valid_count + dut.cdb_interface.cdb_valid_3_2;
            cdb_all_valid_count =  cdb_all_valid_count +
                (dut.cdb_interface.cdb_valid_0 & !dut.cdb_interface.cdb_mem_addr_calculation_0)  +
                (dut.cdb_interface.cdb_valid_1 & !dut.cdb_interface.cdb_mem_addr_calculation_1) +
                (dut.cdb_interface.cdb_valid_2 & !dut.cdb_interface.cdb_mem_addr_calculation_2) +
                dut.cdb_interface.cdb_valid_3_0 +
                dut.cdb_interface.cdb_valid_3_1 +
                dut.cdb_interface.cdb_valid_3_2;

            commit_count = commit_count + dut.dispatch_stage_unit.rob.commit_valid_0 +
                dut.dispatch_stage_unit.rob.commit_valid_1 +
                dut.dispatch_stage_unit.rob.commit_valid_2;

            decode_sample_cycles++;
            cycle_count++;

            // Report every 10000 cycles
            if (cycle_count % 100 == 0 && cycle_count > 0) begin
                automatic real current_prediction_accuracy;
                automatic real current_jalr_ratio;
                automatic real current_avg_rob_on_mispred;

                avg_decode_ready =  decode_ready_count / real'(cycle_count);
                avg_decode_valid =  decode_valid_count / real'(cycle_count);
                avg_rs_0_ready  =  rs_0_ready_count / real'(cycle_count);
                avg_rs_1_ready  =  rs_1_ready_count / real'(cycle_count);
                avg_rs_2_ready  =  rs_2_ready_count / real'(cycle_count);
                avg_rename_ready =  rename_ready_count / real'(cycle_count);
                avg_lsq_ready   =  lsq_ready_count / real'(cycle_count);


                avg_cdb_0_valid  =  cdb_0_valid_count / real'(cycle_count);
                avg_cdb_1_valid  =  cdb_1_valid_count / real'(cycle_count);
                avg_cdb_2_valid  =  cdb_2_valid_count / real'(cycle_count);
                avg_cdb_3_0_valid  =  cdb_3_0_valid_count / real'(cycle_count);
                avg_cdb_3_1_valid  =  cdb_3_1_valid_count / real'(cycle_count);
                avg_cdb_3_2_valid  =  cdb_3_2_valid_count / real'(cycle_count);
                avg_cdb_all_valid =  cdb_all_valid_count / real'(cycle_count);

                avg_commit_rate = commit_count / real'(cycle_count);

                // Calculate current branch prediction stats
                if (total_branches > 0) begin
                    current_prediction_accuracy = 100.0 * (1.0 - (real'(mispredicted_branches) / real'(total_branches)));
                    current_jalr_ratio = 100.0 * (real'(jalr_count) / real'(total_branches));
                end else begin
                    current_prediction_accuracy = 0.0;
                    current_jalr_ratio = 0.0;
                end

                // Calculate average ROB occupancy on misprediction
                if (total_mispredictions > 0) begin
                    current_avg_rob_on_mispred = real'(total_rob_entries_on_mispred) / real'(total_mispredictions);
                end else begin
                    current_avg_rob_on_mispred = 0.0;
                end

                $display("[%t]\n Activity Report (last %0d cycles):", $time, cycle_count);
                $display("  Avg decode_ready_o: %.2f instructions/cycle", avg_decode_ready);
                $display("  Avg decode_valid_i: %.2f instructions/cycle", avg_decode_valid);
                $display("  Avg RS0 ready: %.2f instructions/cycle", avg_rs_0_ready);
                $display("  Avg RS1 ready: %.2f instructions/cycle", avg_rs_1_ready);
                $display("  Avg RS2 ready: %.2f instructions/cycle", avg_rs_2_ready);
                $display("  Avg rename ready: %.2f instructions/cycle", avg_rename_ready);
                $display("  Avg LSQ ready: %.2f instructions/cycle", avg_lsq_ready);
                $display("  Avg CDB0 valid: %.2f broadcasts/cycle", avg_cdb_0_valid);
                $display("  Avg CDB1 valid: %.2f broadcasts/cycle", avg_cdb_1_valid);
                $display("  Avg CDB2 valid: %.2f broadcasts/cycle", avg_cdb_2_valid);
                $display("  Avg CDB3_0 valid: %.2f broadcasts/cycle", avg_cdb_3_0_valid);
                $display("  Avg CDB3_1 valid: %.2f broadcasts/cycle", avg_cdb_3_1_valid);
                $display("  Avg CDB3_2 valid: %.2f broadcasts/cycle", avg_cdb_3_2_valid);
                $display("  Avg CDB all valid: %.2f broadcasts/cycle", avg_cdb_all_valid);
                $display("  Avg Commit rate: %.2f instructions/cycle", avg_commit_rate);
                $display("  --- Branch Prediction Stats ---");
                $display("  Total branches: %0d", total_branches);
                $display("  Mispredicted: %0d", mispredicted_branches);
                $display("  JALR count: %0d", jalr_count);
                $display("  Total mispredictions: %0d", total_mispredictions);
                $display("  Prediction accuracy: %.2f%%", current_prediction_accuracy);
                $display("  JALR/Branch ratio: %.2f%%", current_jalr_ratio);
                $display("  Avg ROB entries on misprediction: %.2f entries", current_avg_rob_on_mispred);
                $display("---------------------------------------------------------------------" );
            end


        end else begin
            decode_ready_count <= #D 0;
            decode_valid_count <= #D 0;
            decode_sample_cycles <= #D 0;
            cdb_0_valid_count <= #D 0;
            cdb_1_valid_count <= #D 0;
            cdb_2_valid_count <= #D 0;
            cdb_3_0_valid_count <= #D 0;
            cdb_3_1_valid_count <= #D 0;
            cdb_3_2_valid_count <= #D 0;
            cdb_all_valid_count <= #D 0;
            rs_0_ready_count <= #D 0;
            rs_1_ready_count <= #D 0;
            rs_2_ready_count <= #D 0;
            rename_ready_count <= #D 0;
            lsq_ready_count <= #D 0;
            commit_count <= #D 0;
            cycle_count <= #D 0;
        end
    end

    //==========================================================================
    // CDB_3 LOGGING
    //==========================================================================

    integer cdb_3_log_file;

    initial begin
        cdb_3_log_file = $fopen("cdb_3_trace.log", "w");
        if (cdb_3_log_file == 0) begin
            $display("ERROR: Could not open cdb_3_trace.log");
            $finish;
        end
    end

    // Monitor CDB_3 channels and log valid transactions (sorted by dest_reg)
    always @(posedge clk) begin
        if (rst_n) begin
            automatic logic [5:0] dest_regs[3];
            automatic logic [31:0] datas[3];
            automatic logic valids[3];
            automatic integer valid_count;
            automatic logic [5:0] min_dest;
            automatic integer min_idx;

            // Collect all CDB_3 entries
            valids[0] = dut.cdb_interface.cdb_valid_3_0;
            datas[0] = dut.cdb_interface.cdb_data_3_0;
            dest_regs[0] = dut.cdb_interface.cdb_dest_reg_3_0;

            valids[1] = dut.cdb_interface.cdb_valid_3_1;
            datas[1] = dut.cdb_interface.cdb_data_3_1;
            dest_regs[1] = dut.cdb_interface.cdb_dest_reg_3_1;

            valids[2] = dut.cdb_interface.cdb_valid_3_2;
            datas[2] = dut.cdb_interface.cdb_data_3_2;
            dest_regs[2] = dut.cdb_interface.cdb_dest_reg_3_2;

            // Count valid entries
            valid_count = 0;
            for (int i = 0; i < 3; i++) begin
                if (valids[i]) valid_count++;
            end

            // Write to file if any valid entry exists
            if (valid_count > 0) begin
                // Selection sort: write in dest_reg order
                for (int sorted = 0; sorted < 3; sorted++) begin
                    min_dest = 6'h3F; // Max value
                    min_idx = -1;

                    // Find minimum dest_reg among remaining valid entries
                    for (int i = 0; i < 3; i++) begin
                        if (valids[i] && dest_regs[i] < min_dest) begin
                            min_dest = dest_regs[i];
                            min_idx = i;
                        end
                    end

                    // Write to file and mark as used
                    if (min_idx >= 0) begin
                        $fwrite(cdb_3_log_file, "%t - dest_reg=p%0d, data=0x%08x\n", $time,
                            dest_regs[min_idx], datas[min_idx]);
                        valids[min_idx] = 1'b0; // Mark as processed
                    end
                end
            end
        end
    end

    // Close file at end of simulation
    final begin
        $fclose(cdb_3_log_file);
    end

    //==========================================================================
    // COMMIT LOGGING
    //==========================================================================

    integer commit_log_file;

    initial begin
        commit_log_file = $fopen("commit_trace.log", "w");
        if (commit_log_file == 0) begin
            $display("ERROR: Could not open commit_trace.log");
            $finish;
        end
    end

    // Monitor commit channels and log valid commits (sorted by commit_0 first)
    always @(posedge clk) begin
        if (rst_n) begin
            automatic logic [4:0] addrs[3];
            automatic logic [31:0] datas[3];
            automatic logic valids[3];

            // Collect all commit entries
            valids[0] = dut.dispatch_stage_unit.rob.commit_valid_0;
            datas[0] = dut.dispatch_stage_unit.rob.commit_data_0;
            addrs[0] = dut.dispatch_stage_unit.rob.commit_addr_0;

            valids[1] = dut.dispatch_stage_unit.rob.commit_valid_1;
            datas[1] = dut.dispatch_stage_unit.rob.commit_data_1;
            addrs[1] = dut.dispatch_stage_unit.rob.commit_addr_1;

            valids[2] = dut.dispatch_stage_unit.rob.commit_valid_2;
            datas[2] = dut.dispatch_stage_unit.rob.commit_data_2;
            addrs[2] = dut.dispatch_stage_unit.rob.commit_addr_2;

            // Write commits in order: commit_0, commit_1, commit_2
            // Only write if valid and addr != 0
            for (int i = 0; i < 3; i++) begin
                if (valids[i] && addrs[i] != 5'b0) begin
                    $fwrite(commit_log_file, "%t - addr=x%0d, data=0x%08x\n", $time,
                        addrs[i], datas[i]);
                end
            end
        end
    end

    // Close file at end of simulation
    final begin
        $fclose(commit_log_file);
    end

    //==========================================================================
    // LSQ ALLOCATION/DEALLOCATION CHECKER
    //==========================================================================
    // Tracks which physical registers are allocated for LSQ operations
    // and verifies that CDB_3 only writes to allocated registers

    logic [63:0] lsq_allocated_regs; // Bitmap of allocated LSQ registers (64 physical regs)
    integer lsq_error_count;
    integer lsq_alloc_count;
    integer lsq_dealloc_count;
    integer lsq_mispred_flush_count;


    initial begin
        lsq_allocated_regs = 64'h0;
        lsq_error_count = 0;
        lsq_alloc_count = 0;
        lsq_dealloc_count = 0;
        lsq_mispred_flush_count = 0;
    end
    /*
     // Monitor LSQ allocations and deallocations
     always @(posedge clk) begin
     if (!rst_n) begin
     // Reset on system reset
     lsq_allocated_regs = 64'h0;
     end else if (dut.misprediction_detected) begin
     // Flush all LSQ allocations on misprediction
     lsq_allocated_regs = 64'h0;
     lsq_mispred_flush_count++;
     //$display("[%t] LSQ FLUSH: Misprediction detected, clearing all LSQ allocations", $time);
     end else begin
     // Check for allocations (when need_lsq_alloc_* is high)
     if (dut.issue_stage_unit.rat_inst.need_lsq_alloc_0) begin
     if (lsq_allocated_regs[dut.issue_stage_unit.rat_inst.first_free]) begin
     $error("[%t] LSQ ALLOCATION ERROR: Attempting to allocate already-allocated register p%0d (alloc_0)",
     $time, dut.issue_stage_unit.rat_inst.first_free);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.issue_stage_unit.rat_inst.first_free] = 1'b1;
     lsq_alloc_count++;
     // $display("[%t] LSQ ALLOC: p%0d allocated (alloc_0)", $time, dut.issue_stage_unit.rat_inst.first_free);
     end
     end

     if (dut.issue_stage_unit.rat_inst.need_lsq_alloc_1) begin
     if (lsq_allocated_regs[dut.issue_stage_unit.rat_inst.second_free]) begin
     $error("[%t] LSQ ALLOCATION ERROR: Attempting to allocate already-allocated register p%0d (alloc_1)",
     $time, dut.issue_stage_unit.rat_inst.lsq_second_free);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.issue_stage_unit.rat_inst.second_free] = 1'b1;
     lsq_alloc_count++;
     //$display("[%t] LSQ ALLOC: p%0d allocated (alloc_1)", $time, dut.issue_stage_unit.rat_inst.second_free);
     end
     end

     if (dut.issue_stage_unit.rat_inst.need_lsq_alloc_2) begin
     if (lsq_allocated_regs[dut.issue_stage_unit.rat_inst.third_free]) begin
     $error("[%t] LSQ ALLOCATION ERROR: Attempting to allocate already-allocated register p%0d (alloc_2)",
     $time, dut.issue_stage_unit.rat_inst.third_free);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.issue_stage_unit.rat_inst.third_free] = 1'b1;
     lsq_alloc_count++;
     //$display("[%t] LSQ ALLOC: p%0d allocated (alloc_2)",  $time, dut.issue_stage_unit.rat_inst.third_free);
     end
     end

     // Check for deallocations (when CDB_3 writes complete)
     if (dut.cdb_interface.cdb_valid_3_0) begin
     if (!lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_0]) begin
     $error("[%t] LSQ DEALLOCATION ERROR: CDB_3_0 writing to non-allocated register p%0d (data=0x%08x)",
     $time, dut.cdb_interface.cdb_dest_reg_3_0, dut.cdb_interface.cdb_data_3_0);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_0] = 1'b0;
     lsq_dealloc_count++;
     //$display("[%t] LSQ DEALLOC: p%0d deallocated via CDB_3_0 (data=0x%08x)", $time, dut.cdb_interface.cdb_dest_reg_3_0, dut.cdb_interface.cdb_data_3_0);
     end
     end

     if (dut.cdb_interface.cdb_valid_3_1) begin
     if (!lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_1]) begin
     $error("[%t] LSQ DEALLOCATION ERROR: CDB_3_1 writing to non-allocated register p%0d (data=0x%08x)",
     $time, dut.cdb_interface.cdb_dest_reg_3_1, dut.cdb_interface.cdb_data_3_1);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_1] = 1'b0;
     lsq_dealloc_count++;
     //$display("[%t] LSQ DEALLOC: p%0d deallocated via CDB_3_1 (data=0x%08x)", $time, dut.cdb_interface.cdb_dest_reg_3_1, dut.cdb_interface.cdb_data_3_1);
     end
     end

     if (dut.cdb_interface.cdb_valid_3_2) begin
     if (!lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_2]) begin
     $error("[%t] LSQ DEALLOCATION ERROR: CDB_3_2 writing to non-allocated register p%0d (data=0x%08x)",
     $time, dut.cdb_interface.cdb_dest_reg_3_2, dut.cdb_interface.cdb_data_3_2);
     lsq_error_count++;
     end else begin
     lsq_allocated_regs[dut.cdb_interface.cdb_dest_reg_3_2] = 1'b0;
     lsq_dealloc_count++;
     //$display("[%t] LSQ DEALLOC: p%0d deallocated via CDB_3_2 (data=0x%08x)", $time, dut.cdb_interface.cdb_dest_reg_3_2, dut.cdb_interface.cdb_data_3_2);
     end
     end
     end
     end
     */
    // Check for register leaks at end of simulation
    final begin
        if(!test_passed) begin
            automatic int leaked_count = 0;
            $display("\n========== LSQ ALLOCATION CHECKER SUMMARY ==========");
            $display("Total allocations:        %0d", lsq_alloc_count);
            $display("Total deallocations:      %0d", lsq_dealloc_count);
            $display("Misprediction flushes:    %0d", lsq_mispred_flush_count);
            $display("Total errors:             %0d", lsq_error_count);

            // Check for leaked registers
            for (int i = 0; i < 64; i++) begin
                if (lsq_allocated_regs[i]) begin
                    $warning("LSQ LEAK WARNING: Register p%0d still allocated at end of simulation", i);
                    leaked_count++;
                end
            end

            if (leaked_count > 0) begin
                $display("Leaked registers:         %0d", leaked_count);
            end

            if (lsq_error_count > 0) begin
                $error("LSQ CHECKER FAILED with %0d errors!", lsq_error_count);
            end else begin
                $display("LSQ CHECKER PASSED - No allocation/deallocation errors detected");
            end
            $display("====================================================\n");
        end
    end

    initial begin
        automatic int leaked_count = 0;
        wait(ecall_detected);
        $display("\n========== LSQ ALLOCATION CHECKER SUMMARY ==========");
        $display("Total allocations:        %0d", lsq_alloc_count);
        $display("Total deallocations:      %0d", lsq_dealloc_count);
        $display("Misprediction flushes:    %0d", lsq_mispred_flush_count);
        $display("Total errors:             %0d", lsq_error_count);

        // Check for leaked registers
        for (int i = 0; i < 64; i++) begin
            if (lsq_allocated_regs[i]) begin
                $warning("LSQ LEAK WARNING: Register p%0d still allocated at end of simulation", i);
                leaked_count++;
            end
        end

        if (leaked_count > 0) begin
            $display("Leaked registers:         %0d", leaked_count);
        end

        if (lsq_error_count > 0) begin
            $error("LSQ CHECKER FAILED with %0d errors!", lsq_error_count);
        end else begin
            $display("LSQ CHECKER PASSED - No allocation/deallocation errors detected");
        end
        $display("====================================================\n");
    end

    //==========================================================================
    // BRANCH PREDICTION & JALR STATISTICS
    //==========================================================================
    // Tracks branch prediction accuracy and JALR ratio
    integer brat_branches;
    initial begin
        total_branches = 0;
        mispredicted_branches = 0;
        jalr_count = 0;
        total_rob_entries_on_mispred = 0;
        total_mispredictions = 0;
        brat_branches = 0;
    end

    // Monitor branch predictions and mispredictions
    always @(posedge clk) begin
        if (rst_n) begin
            // Count total branches (when update_prediction_valid is high)
            if(dv_top_superscalar.dut.dispatch_stage_unit.brat_eager_misprediction) begin
                brat_branches++;
            end
            if (dut.dispatch_stage_unit.rob.commit_is_branch_0) begin
                total_branches++;

                // Check if this branch was mispredicted
                if (dut.dispatch_stage_unit.rob.commit_exception_0) begin
                    mispredicted_branches++;
                    total_mispredictions++;
                end
            end
            if (dut.dispatch_stage_unit.rob.commit_is_branch_1) begin
                total_branches++;
                // Check if this branch was mispredicted
                if (dut.dispatch_stage_unit.rob.commit_exception_1) begin
                    mispredicted_branches++;
                    total_mispredictions++;
                end
            end
            if (dut.dispatch_stage_unit.rob.commit_is_branch_2) begin
                total_branches++;
                // Check if this branch was mispredicted
                if (dut.dispatch_stage_unit.rob.commit_exception_2) begin
                    mispredicted_branches++;
                    total_mispredictions++;
                end
            end
            if (dut.dispatch_stage_unit.rob.commit_exception_0 &&
                    !dut.dispatch_stage_unit.rob.commit_is_branch_0) begin
                // Misprediction without prediction_valid = JALR
                jalr_count++;
                total_mispredictions++;

            end
            if (dut.dispatch_stage_unit.rob.commit_exception_1 &&
                    !dut.dispatch_stage_unit.rob.commit_is_branch_1) begin
                // Misprediction without prediction_valid = JALR
                jalr_count++;
                total_mispredictions++;

            end
            if (dut.dispatch_stage_unit.rob.commit_exception_2 &&
                    !dut.dispatch_stage_unit.rob.commit_is_branch_2) begin
                // Misprediction without prediction_valid = JALR
                jalr_count++;
                total_mispredictions++;
            end

        end
    end

    // Display statistics at end of simulation
    final begin
        automatic real prediction_accuracy;
        automatic real jalr_ratio;
        automatic real avg_rob_on_mispred;

        $display("\n========== BRANCH PREDICTION STATISTICS ==========");
        $display("Total branches:           %0d", total_branches);
        $display("Mispredicted branches:    %0d", mispredicted_branches);
        $display("JALR instructions:        %0d", jalr_count);
        $display("Total mispredictions:     %0d", total_mispredictions);

        $display("BRAT predicted branches:   %0d", brat_branches);

        if (total_branches > 0) begin
            prediction_accuracy = 100.0 * (1.0 - (real'(mispredicted_branches) / real'(total_branches)));
            $display("Branch prediction accuracy: %.2f%%", prediction_accuracy);
        end else begin
            $display("Branch prediction accuracy: N/A (no branches)");
        end

        if (total_branches > 0) begin
            jalr_ratio = 100.0 * (real'(jalr_count) / real'(total_branches));
            $display("JALR/Branch ratio:        %.2f%%", jalr_ratio);
        end else begin
            $display("JALR/Branch ratio:        N/A");
        end

        if (total_mispredictions > 0) begin
            avg_rob_on_mispred = real'(total_rob_entries_on_mispred) / real'(total_mispredictions);
            $display("Avg ROB entries on misprediction: %.2f entries", avg_rob_on_mispred);
            $display("Total ROB entries flushed: %0d entries", total_rob_entries_on_mispred);
        end else begin
            $display("Avg ROB entries on misprediction: N/A (no mispredictions)");
        end

        $display("==================================================\n");
    end

    //==========================================================================
    // PROGRAM LOADING
    //==========================================================================

    // Load program from hex file
    initial begin
        string hex_file;

        for (int i = 0; i < 16384; i++) begin
            instruction_memory.mem[i] = 32'h00000013; // NOP (addi x0, x0, 0)
        end

        if ($value$plusargs("hex_file=%s", hex_file)) begin
            $display("[%t] Loading program from %s", $time, hex_file);
            $readmemh(hex_file, instruction_memory.mem);
            $display("[%t] Program loaded successfully", $time);
        end else begin

            if ($fopen("inst_init.hex", "r")) begin
                $display("Loading inst_init.hex");
                $readmemh("inst_init.hex", instruction_memory.mem);
            end else begin
                $display("[%t] No hex file specified, using default test program", $time);
                load_default_test_program();
            end
        end

    end

    // Initialize region base addresses from plusargs or use defaults
    initial begin
        if (!$value$plusargs("region0_base=%h", region0_base_addr)) begin
            region0_base_addr = REGION0_BASE_addR_DEFAULT;
            $display("Using default Region 0 base address: 0x%08x", region0_base_addr);
        end
        if (!$value$plusargs("region1_base=%h", region1_base_addr)) begin
            region1_base_addr = REGION1_BASE_addR_DEFAULT;
            $display("Using default Region 1 base address: 0x%08x", region1_base_addr);
        end
        wait(rst_n);
        // Load region data if specified
        if ($test$plusargs("load_region_data")) begin
            string region0_file, region1_file;
            if ($value$plusargs("region0_hex=%s", region0_file)) begin
                $display("Loading region 0 data from: %s", region0_file);
                $readmemh(region0_file, region0_data_memory.mem);
                $display("Region 0 data loaded from %s", region0_file);
            end
            else if ($fopen("region_0.hex", "r")) begin
                $display("Loading default region 0 data");
                $readmemh("region_0.hex", region0_data_memory.mem);
            end

            if ($value$plusargs("region1_hex=%s", region1_file)) begin
                $display("Loading region 1 data from: %s", region1_file);
                $readmemh(region1_file, region1_data_memory.mem);
                $display("Region 1 data loaded from %s", region1_file);
            end
            else if ($fopen("region_1.hex", "r")) begin
                $display("Loading default region 1 data");
                $readmemh("region_1.hex", region1_data_memory.mem);
            end
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

            instruction_memory.mem[0] = 32'h00a00093;
            instruction_memory.mem[1] = 32'h00110113;
            instruction_memory.mem[2] = 32'hfe114ce3;
            instruction_memory.mem[3] = 32'h06410113;
            /*instruction_memory.mem[4] = 32'h00590913;
             instruction_memory.mem[5] = 32'h00590913;
             instruction_memory.mem[6] = 32'h00590913;
             instruction_memory.mem[7] = 32'h00590913;
             instruction_memory.mem[8] = 32'h00590913;
             instruction_memory.mem[9] = 32'h00590913;
             instruction_memory.mem[10] = 32'h00590913;
             instruction_memory.mem[11] = 32'h00590913;
             instruction_memory.mem[12] = 32'h00590913;
             instruction_memory.mem[13] = 32'h00590913;
             instruction_memory.mem[14] = 32'h00590913;
             instruction_memory.mem[15] = 32'h00590913;
             instruction_memory.mem[16] = 32'h00590913;
             instruction_memory.mem[17] = 32'h00590913;
             instruction_memory.mem[18] = 32'h00590913;
             instruction_memory.mem[19] = 32'h00590913;
             instruction_memory.mem[20] = 32'h00590913;
             instruction_memory.mem[21] = 32'h00590913;
             instruction_memory.mem[22] = 32'h00590913;
             instruction_memory.mem[23] = 32'h00590913;
             instruction_memory.mem[24] = 32'h00590913;
             instruction_memory.mem[25] = 32'h00590913;
             instruction_memory.mem[26] = 32'h00590913;
             instruction_memory.mem[27] = 32'h00590913;
             instruction_memory.mem[28] = 32'h00590913;
             instruction_memory.mem[29] = 32'h00590913;
             instruction_memory.mem[30] = 32'h00590913;
             instruction_memory.mem[31] = 32'h00590913;
             instruction_memory.mem[32] = 32'h00590913;
             instruction_memory.mem[33] = 32'h00590913;
             instruction_memory.mem[34] = 32'h00590913;
             instruction_memory.mem[35] = 32'h00590913;
             instruction_memory.mem[36] = 32'h00590913;
             instruction_memory.mem[37] = 32'h00590913;
             instruction_memory.mem[38] = 32'h00590913;
             instruction_memory.mem[39] = 32'h00590913;
             instruction_memory.mem[40] = 32'h00590913;
             instruction_memory.mem[41] = 32'h00590913;
             instruction_memory.mem[42] = 32'h00590913;
             instruction_memory.mem[43] = 32'h00590913;
             instruction_memory.mem[44] = 32'h00590913;
             instruction_memory.mem[45] = 32'h00590913;
             instruction_memory.mem[46] = 32'h00590913;
             instruction_memory.mem[47] = 32'h00590913;
             instruction_memory.mem[48] = 32'h00590913;
             instruction_memory.mem[49] = 32'h00590913;
             */
            /*
             // Phase 1: Load integer values into first 6 registers (x1-x6)
             instruction_memory.mem[0] = 32'h00108093;  // addi x1, x1, 1       -> x1 = 1 //0
             instruction_memory.mem[1] = 32'h00200113;  // addi x2, x0, 2       -> x2 = 2 //1
             instruction_memory.mem[2] = 32'h00300193;  // addi x3, x0, 3       -> x3 = 3 //2
             instruction_memory.mem[3] = 32'h00400213;  // addi x4, x0, 4       -> x4 = 4 //3
             instruction_memory.mem[4] = 32'h00500293;  // addi x5, x0, 5       -> x5 = 5 //4
             instruction_memory.mem[5] = 32'h00600313;  // addi x6, x0, 6       -> x6 = 6 //5

             //Phase 2: Arithmetic Operations
             instruction_memory.mem[6]  = 32'h005203b3; // add  x7, x4, x5      -> x7 = 4 + 5 = 9 //6
             instruction_memory.mem[7]  = 32'h40438433; // sub  x8, x7, x4      -> x8 = 9 - 4 = 5 //7
             instruction_memory.mem[8]  = 32'h005303b3; // add  x7, x6, x5      -> x7 = 6 + 5 = 11 //8
             instruction_memory.mem[9]  = 32'h40138533; // sub x10, x7, x1      -> x10 = 11 - 1 = 10 //9
             instruction_memory.mem[10] = 32'h006505b3; // add x11, x10, x6     -> x11 = 10 + 6 = 16 //10
             instruction_memory.mem[11] = 32'h40538633; // sub x12, x7, x5      -> x12 = 11 - 5 = 6  //11

             // Phase 3: Logical Operations
             instruction_memory.mem[12] = 32'h0020c6b3; // xor x13, x1, x2      -> x13 = 1 ^ 2 = 3  //12
             instruction_memory.mem[13] = 32'h0020e733; // or  x14, x1, x2      -> x14 = 1 | 2 = 3  //13
             instruction_memory.mem[14] = 32'h0020f7b3; // and x15, x1, x2      -> x15 = 1 & 2 = 0  //14
             instruction_memory.mem[15] = 32'h18b22823; // sw x11, 400(x4)        -> mem[404] = 16
             instruction_memory.mem[16] = 32'h00324833; // xor x16, x4, x3      -> x16 = 4 ^ 3 = 7  //15
             instruction_memory.mem[17] = 32'h003268b3; // or  x17, x4, x3      -> x17 = 4 | 3 = 7  //16
             instruction_memory.mem[18] = 32'h00327933; // and x18, x4, x3      -> x18 = 4 & 3 = 0  //17

             instruction_memory.mem[19] = 32'h0108c933; // xor x18, x17, x16      -> x18 = 7 ^ 7 = 0  //18
             instruction_memory.mem[20] = 32'h011949b3; // xor x19, x18, x17      -> x19 = 0 ^ 7 = 7  //19
             instruction_memory.mem[21] = 32'h01397a33; // and x20, x18, x19      -> x20 = 0 & 7 = 0  //20
             instruction_memory.mem[22] = 32'h01394ab3; // xor x21, x18, x19      -> x21 = 0 ^ 7 = 7  //21
             instruction_memory.mem[23] = 32'h01396b33; // or  x22, x18, x19      -> x22 = 0 | 7 = 7  //22
             instruction_memory.mem[24] = 32'h0128fbb3; // and x23, x17, x18      -> x23 = 7 & 0 = 0  //23
             instruction_memory.mem[25] = 32'h0170cc33; // xor x24, x1, x23       -> x24 = 1 ^ 0 = 1  //24
             instruction_memory.mem[26] = 32'h01896cb3; // or  x25, x18, x24      -> x25 = 0 | 1 = 1  //25 **
             instruction_memory.mem[27] = 32'h019b7d33; // and x26, x22, x25      -> x26 = 7 & 1 = 1  //26 **
             instruction_memory.mem[28] = 32'h017ccdb3; // xor x27, x25, x23      -> x27 = 1 ^ 0 = 1  //27 **
             instruction_memory.mem[29] = 32'h01adee33; // or  x28, x27, x26      -> x28 = 1 | 1 = 1  //28 **
             instruction_memory.mem[30] = 32'h00317eb3; // and x29, x2, x3        -> x29 = 2 & 3 = 2  //29

             instruction_memory.mem[31] = 32'h19022f03; // lw x30, 400(x4)        -> x30 = mem[404] (16)
             instruction_memory.mem[32] = 32'hf8bf00e3;
             */

            // Phase 2: Arithmetic Operations
            //instruction_memory.mem[6]  = 32'h002083b3; // add  x7, x1, x2      -> x7 = 1 + 2 = 3 -
            //instruction_memory.mem[7]  = 32'h40208433; // sub  x8, x1, x2      -> x8 = 1 - 2 = -1
            //instruction_memory.mem[8]  = 32'h003104b3; // add  x9, x2, x3      -> x9 = 2 + 3 = 5
            //instruction_memory.mem[9]  = 32'h40310533; // sub x10, x2, x3      -> x10 = 2 - 3 = -1 -
            //instruction_memory.mem[10] = 32'h004185b3; // add x11, x3, x4      -> x11 = 3 + 4 = 7
            //instruction_memory.mem[11] = 32'h40418633; // sub x12, x3, x4      -> x12 = 3 - 4 = -1

            /*
             // Phase 4: Shift Operations
             instruction_memory.mem[18] = 32'h002099b3; // SLL x19, x1, x2      -> x19 = 1 << 2 = 4
             instruction_memory.mem[19] = 32'h0021da33; // SRL x20, x3, x2      -> x20 = 3 >> 2 = 0
             instruction_memory.mem[20] = 32'h40215a33; // SRA x20, x2, x2      -> x20 = 2 >>> 2 = 0 (overwrite x20)

             // Phase 5: Immediate Operations
             instruction_memory.mem[21] = 32'h00a08a93; // addi x21, x1, 10     -> x21 = 1 + 10 = 11
             instruction_memory.mem[22] = 32'h00f0cb13; // xorI x22, x1, 15     -> x22 = 1 ^ 15 = 14
             instruction_memory.mem[23] = 32'h00f0eb93; // orI  x23, x1, 15     -> x23 = 1 | 15 = 15
             instruction_memory.mem[24] = 32'h00f0fc13; // andI x24, x1, 15     -> x24 = 1 & 15 = 1

             // Phase 6: Complex arithmetic using multiple registers
             instruction_memory.mem[25] = 32'h00520cb3; // add x25, x4, x5      -> x25 = 4 + 5 = 9
             instruction_memory.mem[26] = 32'h00628d33; // add x26, x5, x6      -> x26 = 5 + 6 = 11
             instruction_memory.mem[27] = 32'h01ac8db3; // add x27, x25, x26    -> x27 = 9 + 11 = 20

             // Phase 7: Set Less Than operations
             instruction_memory.mem[28] = 32'h0020ae33; // SLT x28, x1, x2      -> x28 = (1 < 2) = 1
             instruction_memory.mem[29] = 32'h00103eb3; // SLTU x29, x0, x1     -> x29 = (0 < 1) = 1
             instruction_memory.mem[30] = 32'h0010af33; // SLT x30, x1, x1      -> x30 = (1 < 1) = 0
             */

            $display("[%t] Comprehensive test program loaded:", $time);
            $display("  Phase 1: Load x1=1, x2=2, x3=3, x4=4, x5=5, x6=6");
            $display("  Phase 2: Arithmetic operations (add/sub)");
            $display("  Phase 3: Logical operations (xor/or/and)");
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
    // CDB SILENCE DETECTION (Pipeline Stall / Deadlock Detection)
    //==========================================================================

    parameter CDB_SILENCE_THRESHOLD = 10;  // Number of cycles to wait before declaring deadlock
    integer cdb_silence_counter;
    logic cdb_any_valid;
    logic cdb_silence_detected;

    // Combine all CDB valid signals
    assign cdb_any_valid = dut.cdb_interface.cdb_valid_0 |
        dut.cdb_interface.cdb_valid_1 |
        dut.cdb_interface.cdb_valid_2 |
        dut.cdb_interface.cdb_valid_3_0 |
        dut.cdb_interface.cdb_valid_3_1 |
        dut.cdb_interface.cdb_valid_3_2;

    // CDB silence counter logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cdb_silence_counter <= 0;
            cdb_silence_detected <= 1'b0;
        end else begin
            if (cdb_any_valid) begin
                // Reset counter when any CDB is valid
                cdb_silence_counter <= 0;
            end else begin
                // Increment counter when all CDBs are silent
                cdb_silence_counter <= cdb_silence_counter + 1;
            end

            // Detect silence threshold exceeded
            if (cdb_silence_counter >= CDB_SILENCE_THRESHOLD && !cdb_silence_detected) begin
                cdb_silence_detected <= 1'b1;
                $display("[%t] WARNING: CDB silence detected for %0d cycles!", $time, CDB_SILENCE_THRESHOLD);
                $display("  CDB_0: %b, CDB_1: %b, CDB_2: %b",
                    dut.cdb_interface.cdb_valid_0,
                    dut.cdb_interface.cdb_valid_1,
                    dut.cdb_interface.cdb_valid_2);
                $display("  CDB_3_0: %b, CDB_3_1: %b, CDB_3_2: %b",
                    dut.cdb_interface.cdb_valid_3_0,
                    dut.cdb_interface.cdb_valid_3_1,
                    dut.cdb_interface.cdb_valid_3_2);
                $display("  Possible pipeline stall or deadlock detected!");
            end
        end
    end

    //==========================================================================
    // TEST COMPLETION DETECTION
    //==========================================================================

    // Test completion detection
    // Detect test completion based on various criteria

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
                $display("ECALL detected, test completed normally");
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

    //==========================================================================
    // PIPELINE PERFORMANCE ANALYZER V2 INSTANTIATION
    //==========================================================================

    pipeline_performance_analyzer perf_analyzer (
        .clk(clk),
        .reset(~rst_n),

        // RS0 signals
        .rs0_occupied(dut.dispatch_stage_unit.rs_0.occupied),
        .rs0_issue_valid(dut.dispatch_to_alu_0_if.issue_valid),
        .rs0_operand_a_tag(dut.dispatch_stage_unit.rs_0.stored_operand_a_tag),
        .rs0_operand_b_tag(dut.dispatch_stage_unit.rs_0.stored_operand_b_tag),

        // RS1 signals
        .rs1_occupied(dut.dispatch_stage_unit.rs_1.occupied),
        .rs1_issue_valid(dut.dispatch_to_alu_1_if.issue_valid),
        .rs1_operand_a_tag(dut.dispatch_stage_unit.rs_1.stored_operand_a_tag),
        .rs1_operand_b_tag(dut.dispatch_stage_unit.rs_1.stored_operand_b_tag),

        // RS2 signals
        .rs2_occupied(dut.dispatch_stage_unit.rs_2.occupied),
        .rs2_issue_valid(dut.dispatch_to_alu_2_if.issue_valid),
        .rs2_operand_a_tag(dut.dispatch_stage_unit.rs_2.stored_operand_a_tag),
        .rs2_operand_b_tag(dut.dispatch_stage_unit.rs_2.stored_operand_b_tag),

        // Misprediction signal
        .misprediction_detected(dut.dispatch_stage_unit.brat_eager_misprediction),

        // Issue stage signals for previous stage bottleneck analysis
        .decode_valid_i(dut.issue_stage_unit.decode_valid_i),
        .decode_ready_o(dut.issue_stage_unit.decode_ready_o),
        .rename_ready(dut.issue_stage_unit.rename_ready),
        .lsq_alloc_ready(dut.issue_stage_unit.lsq_alloc_ready),

        // New signals for Commit/Branch/LS analysis
        .commit_valid(dut.commit_valid),
        .lsq_commit_valid({dut.lsq_commit_valid_2, dut.lsq_commit_valid_1, dut.lsq_commit_valid_0}),
        .brat_branch_resolved(dut.brat_branch_resolved),
        .brat_branch_mispredicted(dut.brat_branch_mispredicted)
    );

    // RAS Monitor Instantiation (Direct Hierarchical Access)
    ras_monitor #(
        .ADDR_WIDTH(32),
        .RAS_DEPTH(8)
    ) ras_mon_inst (
        .clk(clk),
        .reset(rst_n),
        .is_call_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_call_0),
        .is_call_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_call_1),
        .is_call_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_call_2),
        .is_call_3(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_call_3),
        .is_call_4(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_call_4),
        .is_return_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_return_i_0),
        .is_return_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_return_i_1),
        .is_return_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_return_i_2),
        .is_return_3(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_return_i_3),
        .is_return_4(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.is_return_i_4),
        .current_pc_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.current_pc_0),
        .current_pc_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.current_pc_1),
        .current_pc_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.current_pc_2),
        .current_pc_3(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.current_pc_3),
        .current_pc_4(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.current_pc_4),
        .call_return_addr_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.call_return_addr_0),
        .call_return_addr_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.call_return_addr_1),
        .call_return_addr_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.call_return_addr_2),
        .call_return_addr_3(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.call_return_addr_3),
        .call_return_addr_4(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.call_return_addr_4),
        .jalr_prediction_valid_o(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.jalr_prediction_valid_o),
        .jalr_prediction_target_o(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.jalr_prediction_target_o),
        .update_prediction_valid_i_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.update_prediction_valid_i_0),
        .update_prediction_valid_i_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.update_prediction_valid_i_1),
        .update_prediction_valid_i_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.update_prediction_valid_i_2),
        .misprediction_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.misprediction_0),
        .misprediction_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.misprediction_1),
        .misprediction_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.misprediction_2),
        .correct_pc_0(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.correct_pc_0),
        .correct_pc_1(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.correct_pc_1),
        .correct_pc_2(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.correct_pc_2),
        .ras_restore_en_i(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.ras_restore_en_i),
        .ras_restore_tos_i(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.ras_restore_tos_i),
        .ras_tos_checkpoint_o(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.ras_tos_checkpoint_o),
        .ras_stack(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.ras_stack),
        .ras_tos(dut.fetch_buffer_unit.fetch_unit.jump_ctrl.jalr_predictor_inst.ras_tos)
    );

    /*
     `define BP dut.fetch_buffer_unit.fetch_unit.jump_ctrl.branch_predictor

     localparam int META_W = $bits(`BP.global_history_0_o);
     localparam int GH_W   = META_W - 3;

     bp_logger_multi #(
     .PC_WIDTH(32),
     .GH_WIDTH(GH_W),
     .META_WIDTH(META_W),
     .NUM_FETCH(5),
     .NUM_UPD(3)
     ) bp_log (
     .clk  (`BP.clk),
     .rst_n(`BP.reset),

     // ---------------- FETCH (0..4) ----------------
     .pred_valid_i('{
     (`BP.base_valid & `BP.is_branch_i_0),
     (`BP.base_valid & `BP.is_branch_i_1 & ~`BP.ignore_inst_1),
     (`BP.base_valid & `BP.is_branch_i_2 & ~`BP.ignore_inst_2),
     (`BP.base_valid & `BP.is_branch_i_3 & ~`BP.ignore_inst_3),
     (`BP.base_valid & `BP.is_branch_i_4 & ~`BP.ignore_inst_4)
     }),

     .pred_pc_i('{
     `BP.current_pc_0, `BP.current_pc_1, `BP.current_pc_2, `BP.current_pc_3, `BP.current_pc_4
     }),

     .pred_taken_final_i('{
     `BP.branch_taken_o_0, `BP.branch_taken_o_1, `BP.branch_taken_o_2, `BP.branch_taken_o_3, `BP.branch_taken_o_4
     }),

     // meta layout: {ghr_before[...], gshare_pred, bimodal_pred, chooser_sel}
     .pred_taken_gshare_i('{
     `BP.global_history_0_o[2], `BP.global_history_1_o[2], `BP.global_history_2_o[2], `BP.global_history_3_o[2], `BP.global_history_4_o[2]
     }),
     .pred_taken_bimodal_i('{
     `BP.global_history_0_o[1], `BP.global_history_1_o[1], `BP.global_history_2_o[1], `BP.global_history_3_o[1], `BP.global_history_4_o[1]
     }),
     .pred_sel_gshare_i('{
     `BP.global_history_0_o[0], `BP.global_history_1_o[0], `BP.global_history_2_o[0], `BP.global_history_3_o[0], `BP.global_history_4_o[0]
     }),

     // chooser counter snapshot portun yoksa 0 ver (istersen debug port ekleriz)
     .pred_chooser_ctr_i('{2'b00,2'b00,2'b00,2'b00,2'b00}),

     .pred_ghr_before_i('{
     `BP.global_history_0_o[META_W-1:3], `BP.global_history_1_o[META_W-1:3],
     `BP.global_history_2_o[META_W-1:3], `BP.global_history_3_o[META_W-1:3],
     `BP.global_history_4_o[META_W-1:3]
     }),

     .pred_meta_i('{
     `BP.global_history_0_o, `BP.global_history_1_o, `BP.global_history_2_o, `BP.global_history_3_o, `BP.global_history_4_o
     }),

     // ---------------- UPDATE (0..2) ----------------
     // JALR redirect gibi update_valid=0 durumları da loglansın diye: valid = update_prediction_valid OR mispred
     .upd_valid_i('{
     (`BP.update_prediction_valid_i_0 | `BP.misprediction_0),
     (`BP.update_prediction_valid_i_1 | `BP.misprediction_1),
     (`BP.update_prediction_valid_i_2 | `BP.misprediction_2)
     }),

     .upd_pc_i('{
     `BP.update_prediction_pc_0, `BP.update_prediction_pc_1, `BP.update_prediction_pc_2
     }),

     .upd_meta_i('{
     `BP.update_global_history_0, `BP.update_global_history_1, `BP.update_global_history_2
     }),

     .upd_mispred_i('{
     `BP.misprediction_0, `BP.misprediction_1, `BP.misprediction_2
     }),

     // redirect cause sinyalin yoksa 0 ver; varsa burada jalr=1 vs bağlarız
     .upd_redirect_cause_i('{2'd0,2'd0,2'd0}),

     // Train sadece "o predictor seçildiyse" ve update_prediction_valid=1 ise
     .upd_train_gshare_i('{
     (`BP.update_prediction_valid_i_0 &  `BP.update_global_history_0[0]),
     (`BP.update_prediction_valid_i_1 &  `BP.update_global_history_1[0]),
     (`BP.update_prediction_valid_i_2 &  `BP.update_global_history_2[0])
     }),
     .upd_train_bimodal_i('{
     (`BP.update_prediction_valid_i_0 & ~`BP.update_global_history_0[0]),
     (`BP.update_prediction_valid_i_1 & ~`BP.update_global_history_1[0]),
     (`BP.update_prediction_valid_i_2 & ~`BP.update_global_history_2[0])
     }),

     // Restore: redirect olduğunda (mispred pulse) 1
     .upd_restore_ghr_i('{
     `BP.misprediction_0, `BP.misprediction_1, `BP.misprediction_2
     }),

     // actual outcome’un yoksa 0 bağla
     .upd_actual_taken_i('{1'b0,1'b0,1'b0}),
     .upd_actual_valid_i('{1'b0,1'b0,1'b0})
     );

     `undef BP
     */
endmodule
