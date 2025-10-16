`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: dispatch_stage
//
// Description:
//     Top-level dispatch stage module for 3-way superscalar RV32I processor.
//     Integrates 3 reservation stations with shared 64-entry physical register file.
//     Handles dependency resolution, instruction dispatch, and CDB result broadcasting.
//
// Features:
//     - 3 reservation stations (one per functional unit)
//     - Shared 64-entry physical register file (6 read + 3 write ports)
//     - Common Data Bus (CDB) for result broadcasting
//     - Tag-based dependency resolution
//     - Direct register file updates from CDB
//
// Architecture:
//     issue_stage → dispatch_stage → functional_units
//     (phys_addrs)   (data_access)    (execution)
//////////////////////////////////////////////////////////////////////////////////

module dispatch_stage #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6,
    parameter NUM_PHYS_REGS = 64
)(
    // Clock and Reset
    input logic clk,
    input logic reset,

    // Pipeline Control
    //input logic flush,
    //input logic bubble,

    // Input from Issue Stage (3 instruction streams)
    issue_to_dispatch_if.dispatch issue_to_dispatch_0,
    issue_to_dispatch_if.dispatch issue_to_dispatch_1,
    issue_to_dispatch_if.dispatch issue_to_dispatch_2,

    // Output to Functional Units (3 execution units)
    rs_to_exec_if.reservation_station dispatch_to_alu_0,
    rs_to_exec_if.reservation_station dispatch_to_alu_1,
    rs_to_exec_if.reservation_station dispatch_to_alu_2,

    cdb_if cdb_interface,  // Common Data Bus interface

    output logic [DATA_WIDTH-1:0] data_addr,
    output logic [DATA_WIDTH-1:0] data_write,
    input  logic [DATA_WIDTH-1:0] data_read,
    output logic data_we,
    output logic [3:0] data_be,
    output logic data_req,
    input  logic data_ack,

    output logic [2:0] commit_valid,
    output logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_0,
    output logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_1,
    output logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_2,
    output logic [4:0] commit_rob_idx_0,
    output logic [4:0] commit_rob_idx_1,
    output logic [4:0] commit_rob_idx_2
);

    //==========================================================================
    // INTERNAL SIGNALS
    //==========================================================================

    // Physical register file interface signals
    // Read ports (6 total: 2 per reservation station)
    logic [PHYS_REG_ADDR_WIDTH-1:0] inst_0_read_addr_a, inst_0_read_addr_b;
    logic [PHYS_REG_ADDR_WIDTH-1:0] inst_1_read_addr_a, inst_1_read_addr_b;
    logic [PHYS_REG_ADDR_WIDTH-1:0] inst_2_read_addr_a, inst_2_read_addr_b;

    // Data from ROB
    logic [DATA_WIDTH-1:0] rob_0_read_data_a, rob_0_read_data_b;
    logic [DATA_WIDTH-1:0] rob_1_read_data_a, rob_1_read_data_b;
    logic [DATA_WIDTH-1:0] rob_2_read_data_a, rob_2_read_data_b;
    logic [2:0] rob_0_read_tag_a, rob_0_read_tag_b;
    logic [2:0] rob_1_read_tag_a, rob_1_read_tag_b;
    logic [2:0] rob_2_read_tag_a, rob_2_read_tag_b;

    // Data from Register File
    logic [DATA_WIDTH-1:0] reg_file_read_data_a_0, reg_file_read_data_b_0;
    logic [DATA_WIDTH-1:0] reg_file_read_data_a_1, reg_file_read_data_b_1;
    logic [DATA_WIDTH-1:0] reg_file_read_data_a_2, reg_file_read_data_b_2;

    // Final operand data to dispatch to functional units
    logic [DATA_WIDTH-1:0] inst_0_read_data_a, inst_0_read_data_b;
    logic [DATA_WIDTH-1:0] inst_1_read_data_a, inst_1_read_data_b;
    logic [DATA_WIDTH-1:0] inst_2_read_data_a, inst_2_read_data_b;
    logic [2:0] inst_0_read_tag_a, inst_0_read_tag_b;
    logic [2:0] inst_1_read_tag_a, inst_1_read_tag_b;
    logic [2:0] inst_2_read_tag_a, inst_2_read_tag_b;

    logic commit_ready_0, commit_ready_1, commit_ready_2;
    logic [DATA_WIDTH-1:0] commit_data_0, commit_data_1, commit_data_2;

    logic [4:0] rob_head_idx;

    logic commit_exception_0, commit_exception_1, commit_exception_2;

    assign commit_rob_idx_0 = rob_head_idx;
    assign commit_rob_idx_1 = rob_head_idx + 1;
    assign commit_rob_idx_2 = rob_head_idx + 2;

    //==========================================================================
    //Reorder Buffer
    //==========================================================================

    reorder_buffer rob (
        .clk(clk),
        .reset(reset),

        .alloc_enable_0(issue_to_dispatch_0.dispatch_valid & issue_to_dispatch_0.control_signals[6] & issue_to_dispatch_0.rd_arch_addr != 5'b0), // Do not allocate for x0
        .alloc_enable_1(issue_to_dispatch_1.dispatch_valid & issue_to_dispatch_1.control_signals[6] & issue_to_dispatch_1.rd_arch_addr != 5'b0),
        .alloc_enable_2(issue_to_dispatch_2.dispatch_valid & issue_to_dispatch_2.control_signals[6] & issue_to_dispatch_2.rd_arch_addr != 5'b0),
        .alloc_addr_0(issue_to_dispatch_0.rd_arch_addr),
        .alloc_addr_1(issue_to_dispatch_1.rd_arch_addr),
        .alloc_addr_2(issue_to_dispatch_2.rd_arch_addr),
        .alloc_tag_0(issue_to_dispatch_0.alloc_tag),
        .alloc_tag_1(issue_to_dispatch_1.alloc_tag),
        .alloc_tag_2(issue_to_dispatch_2.alloc_tag),
        .cdb_valid_0(cdb_interface.cdb_valid_0 & cdb_interface.cdb_dest_reg_0[5]), // todo check for we = 0 and also load operations
        .cdb_valid_1(cdb_interface.cdb_valid_1 & cdb_interface.cdb_dest_reg_1[5]),
        .cdb_valid_2(cdb_interface.cdb_valid_2 & cdb_interface.cdb_dest_reg_2[5]),
        .cdb_valid_3(cdb_interface.cdb_valid_3 & cdb_interface.cdb_dest_reg_3[5]),
        .cdb_addr_0(cdb_interface.cdb_dest_reg_0[4:0]),
        .cdb_addr_1(cdb_interface.cdb_dest_reg_1[4:0]),
        .cdb_addr_2(cdb_interface.cdb_dest_reg_2[4:0]),
        .cdb_addr_3(cdb_interface.cdb_dest_reg_3[4:0]),
        .cdb_data_0(cdb_interface.cdb_data_0),
        .cdb_data_1(cdb_interface.cdb_data_1),
        .cdb_data_2(cdb_interface.cdb_data_2),
        .cdb_data_3(cdb_interface.cdb_data_3),
        .cdb_exception_0(1'b0),  //(cdb_interface.cdb_exception_0),
        .cdb_exception_1(1'b0),  //(cdb_interface.cdb_exception_1),
        .cdb_exception_2(1'b0),  //(cdb_interface.cdb_exception_2),
        .cdb_exception_3(1'b0),  //(cdb_interface.cdb_exception_3),

        .read_addr_0(inst_0_read_addr_a[4:0]),
        .read_addr_1(inst_0_read_addr_b[4:0]),
        .read_addr_2(inst_1_read_addr_a[4:0]),
        .read_addr_3(inst_1_read_addr_b[4:0]),
        .read_addr_4(inst_2_read_addr_a[4:0]),
        .read_addr_5(inst_2_read_addr_b[4:0]),
        .read_data_0(rob_0_read_data_a),
        .read_data_1(rob_0_read_data_b),
        .read_data_2(rob_1_read_data_a),
        .read_data_3(rob_1_read_data_b),
        .read_data_4(rob_2_read_data_a),
        .read_data_5(rob_2_read_data_b),
        .read_tag_0(rob_0_read_tag_a),
        .read_tag_1(rob_0_read_tag_b),
        .read_tag_2(rob_1_read_tag_a),
        .read_tag_3(rob_1_read_tag_b),
        .read_tag_4(rob_2_read_tag_a),
        .read_tag_5(rob_2_read_tag_b),

        .commit_ready_0(commit_ready_0),
        .commit_ready_1(commit_ready_1),
        .commit_ready_2(commit_ready_2),
        .commit_data_0(commit_data_0),
        .commit_data_1(commit_data_1),
        .commit_data_2(commit_data_2),
        .commit_addr_0(commit_addr_0),
        .commit_addr_1(commit_addr_1),
        .commit_addr_2(commit_addr_2),
        .commit_exception_0(commit_exception_0),
        .commit_exception_1(commit_exception_1),
        .commit_exception_2(commit_exception_2),
        .head_ptr(rob_head_idx)
    );

    multi_port_register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(5),  // 6 bits for 64 registers
        .NUM_REGISTERS(32)      // 64 physical registers
    ) physical_reg_file (
        .clk(clk),
        .reset(reset),

        // Read ports (descriptive naming)
        .inst_0_read_addr_a(inst_0_read_addr_a[4:0]), .inst_0_read_data_a(reg_file_read_data_a_0),   // RS0 operand A
        .inst_0_read_addr_b(inst_0_read_addr_b[4:0]), .inst_0_read_data_b(reg_file_read_data_b_0),   // RS0 operand B
        .inst_1_read_addr_a(inst_1_read_addr_a[4:0]), .inst_1_read_data_a(reg_file_read_data_a_1),   // RS1 operand A
        .inst_1_read_addr_b(inst_1_read_addr_b[4:0]), .inst_1_read_data_b(reg_file_read_data_b_1),   // RS1 operand B
        .inst_2_read_addr_a(inst_2_read_addr_a[4:0]), .inst_2_read_data_a(reg_file_read_data_a_2),   // RS2 operand A
        .inst_2_read_addr_b(inst_2_read_addr_b[4:0]), .inst_2_read_data_b(reg_file_read_data_b_2),   // RS2 operand B

        // Commit ports - write results from CDB when complete
        .commit_enable_0(commit_ready_0), .commit_addr_0(commit_addr_0), .commit_data_0(commit_data_0),
        .commit_enable_1(commit_ready_1), .commit_addr_1(commit_addr_1), .commit_data_1(commit_data_1),
        .commit_enable_2(commit_ready_2), .commit_addr_2(commit_addr_2), .commit_data_2(commit_data_2)
    );

    assign inst_0_read_data_a = inst_0_read_addr_a[5] ? rob_0_read_data_a : reg_file_read_data_a_0;
    assign inst_0_read_tag_a  = inst_0_read_addr_a[5] ? rob_0_read_tag_a  : 3'b111; // Ready if from reg file
    assign inst_0_read_data_b = inst_0_read_addr_b[5] ? rob_0_read_data_b : reg_file_read_data_b_0;
    assign inst_0_read_tag_b  = inst_0_read_addr_b[5] ? rob_0_read_tag_b  : 3'b111; // Ready if from reg file
    assign inst_1_read_data_a = inst_1_read_addr_a[5] ? rob_1_read_data_a : reg_file_read_data_a_1;
    assign inst_1_read_tag_a  = inst_1_read_addr_a[5] ? rob_1_read_tag_a  : 3'b111; // Ready if from reg file
    assign inst_1_read_data_b = inst_1_read_addr_b[5] ? rob_1_read_data_b : reg_file_read_data_b_1;
    assign inst_1_read_tag_b  = inst_1_read_addr_b[5] ? rob_1_read_tag_b  : 3'b111; // Ready if from reg file
    assign inst_2_read_data_a = inst_2_read_addr_a[5] ? rob_2_read_data_a : reg_file_read_data_a_2;
    assign inst_2_read_tag_a  = inst_2_read_addr_a[5] ? rob_2_read_tag_a  : 3'b111; // Ready if from reg file
    assign inst_2_read_data_b = inst_2_read_addr_b[5] ? rob_2_read_data_b : reg_file_read_data_b_2;
    assign inst_2_read_tag_b  = inst_2_read_addr_b[5] ? rob_2_read_tag_b  : 3'b111; // Ready if from reg file


    //==========================================================================
    // INTERFACE BRIDGE: Convert new issue_to_dispatch_if to register file access
    //==========================================================================

    // Connect interface addresses to register file read ports
    // RS0: Read ports 0 and 1
    assign inst_0_read_addr_a = issue_to_dispatch_0.operand_a_phys_addr;  // RS0 operand A
    assign inst_0_read_addr_b = issue_to_dispatch_0.operand_b_phys_addr;  // RS0 operand B

    // RS1: Read ports 2 and 3
    assign inst_1_read_addr_a = issue_to_dispatch_1.operand_a_phys_addr;  // RS1 operand A
    assign inst_1_read_addr_b = issue_to_dispatch_1.operand_b_phys_addr;  // RS1 operand B

    // RS2: Read ports 4 and 5
    assign inst_2_read_addr_a = issue_to_dispatch_2.operand_a_phys_addr;  // RS2 operand A
    assign inst_2_read_addr_b = issue_to_dispatch_2.operand_b_phys_addr;  // RS2 operand B

    //==========================================================================
    // INTERNAL INTERFACES: Create legacy interfaces for reservation stations
    //==========================================================================

    // Create internal decode_to_rs_if interfaces for each reservation station
    decode_to_rs_if internal_rs_if_0();
    decode_to_rs_if internal_rs_if_1();
    decode_to_rs_if internal_rs_if_2();

    // Connect new interfaces directly to internal interfaces
    // RS0 interface
    assign internal_rs_if_0.dispatch_valid = issue_to_dispatch_0.dispatch_valid;
    assign issue_to_dispatch_0.dispatch_ready = internal_rs_if_0.dispatch_ready;
    assign internal_rs_if_0.control_signals = issue_to_dispatch_0.control_signals;
    assign internal_rs_if_0.pc = issue_to_dispatch_0.pc;
    assign internal_rs_if_0.operand_a_data = inst_0_read_data_a;  // Data from register file
    assign internal_rs_if_0.operand_b_data = issue_to_dispatch_0.control_signals[3] ? issue_to_dispatch_0.immediate_value : inst_0_read_data_b; // Immediate or register
    assign internal_rs_if_0.store_data = inst_0_read_data_b;      // Store data same as operand B (from rs2)
    assign internal_rs_if_0.operand_a_tag = inst_0_read_tag_a;    // Tag from register file
    assign internal_rs_if_0.operand_b_tag = issue_to_dispatch_0.control_signals[3] ? 3'b111 : inst_0_read_tag_b; // Immediate always ready (tag 11)
    assign internal_rs_if_0.rd_phys_addr = issue_to_dispatch_0.rd_phys_addr;
    assign internal_rs_if_0.pc_value_at_prediction = issue_to_dispatch_0.pc_value_at_prediction;
    assign internal_rs_if_0.branch_sel = issue_to_dispatch_0.branch_sel;
    assign internal_rs_if_0.branch_prediction = issue_to_dispatch_0.branch_prediction;

    // RS1 interface
    assign internal_rs_if_1.dispatch_valid = issue_to_dispatch_1.dispatch_valid;
    assign issue_to_dispatch_1.dispatch_ready = internal_rs_if_1.dispatch_ready;
    assign internal_rs_if_1.control_signals = issue_to_dispatch_1.control_signals;
    assign internal_rs_if_1.pc = issue_to_dispatch_1.pc;
    assign internal_rs_if_1.operand_a_data = inst_1_read_data_a;  // Data from register file
    assign internal_rs_if_1.operand_b_data = issue_to_dispatch_1.control_signals[3] ? issue_to_dispatch_1.immediate_value : inst_1_read_data_b; // Immediate or register
    assign internal_rs_if_1.store_data = inst_1_read_data_b;      // Store data same as operand B (from rs2)
    assign internal_rs_if_1.operand_a_tag = inst_1_read_tag_a;    // Tag from register file
    assign internal_rs_if_1.operand_b_tag = issue_to_dispatch_1.control_signals[3] ? 3'b111 : inst_1_read_tag_b; // Immediate always ready (tag 11)
    assign internal_rs_if_1.rd_phys_addr = issue_to_dispatch_1.rd_phys_addr;
    assign internal_rs_if_1.pc_value_at_prediction = issue_to_dispatch_1.pc_value_at_prediction;
    assign internal_rs_if_1.branch_sel = issue_to_dispatch_1.branch_sel;
    assign internal_rs_if_1.branch_prediction = issue_to_dispatch_1.branch_prediction;

    // RS2 interface
    assign internal_rs_if_2.dispatch_valid = issue_to_dispatch_2.dispatch_valid;
    assign issue_to_dispatch_2.dispatch_ready = internal_rs_if_2.dispatch_ready;
    assign internal_rs_if_2.control_signals = issue_to_dispatch_2.control_signals;
    assign internal_rs_if_2.pc = issue_to_dispatch_2.pc;
    assign internal_rs_if_2.operand_a_data = inst_2_read_data_a;  // Data from register file
    assign internal_rs_if_2.operand_b_data = issue_to_dispatch_2.control_signals[3] ? issue_to_dispatch_2.immediate_value : inst_2_read_data_b; // Immediate or register
    assign internal_rs_if_2.store_data = inst_2_read_data_b;      // Store data same as operand B (from rs2)
    assign internal_rs_if_2.operand_a_tag = inst_2_read_tag_a;    // Tag from register file
    assign internal_rs_if_2.operand_b_tag = issue_to_dispatch_2.control_signals[3] ? 3'b111 : inst_2_read_tag_b; // Immediate always ready (tag 11)
    assign internal_rs_if_2.rd_phys_addr = issue_to_dispatch_2.rd_phys_addr;
    assign internal_rs_if_2.pc_value_at_prediction = issue_to_dispatch_2.pc_value_at_prediction;
    assign internal_rs_if_2.branch_sel = issue_to_dispatch_2.branch_sel;
    assign internal_rs_if_2.branch_prediction = issue_to_dispatch_2.branch_prediction;

    //==========================================================================
    // RESERVATION STATION 0 (ALU0)
    //==========================================================================

    reservation_station #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),
        .ALU_TAG(3'b000)  // ALU0 tag
    ) rs_0 (
        .clk(clk),
        .reset(reset),

        // Interface to issue stage
        .decode_if(internal_rs_if_0),

        // Interface to CDB
        .cdb_if_port(cdb_interface.rs0),  // Use rs0 modport

        // Interface to functional unit
        .exec_if(dispatch_to_alu_0)
    );

    //==========================================================================
    // RESERVATION STATION 1 (ALU1)
    //==========================================================================

    reservation_station #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),
        .ALU_TAG(3'b001)  // ALU1 tag
    ) rs_1 (
        .clk(clk),
        .reset(reset),

        // Interface to issue stage
        .decode_if(internal_rs_if_1),

        // Interface to CDB
        .cdb_if_port(cdb_interface.rs1),  // Use rs1 modport

        // Interface to functional unit
        .exec_if(dispatch_to_alu_1)
    );

    //==========================================================================
    // RESERVATION STATION 2 (ALU2)
    //==========================================================================

    reservation_station #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),
        .ALU_TAG(3'b010)  // ALU2 tag
    ) rs_2 (
        .clk(clk),
        .reset(reset),

        // Interface to issue stage
        .decode_if(internal_rs_if_2),

        // Interface to CDB
        .cdb_if_port(cdb_interface.rs2),  // Use rs2 modport

        // Interface to functional unit
        .exec_if(dispatch_to_alu_2)
    );

    logic [31:0] lsq_load_data_i;
    logic [31:0] lsq_store_data_o;
    logic [2:0]  data_organizer_type_sel;
    data_organizer #(.size(32)) load_data_organizer (
        .data_in(data_read),
        .Type_sel(data_organizer_type_sel),
        .data_out(lsq_load_data_i)
    );

    data_organizer #(.size(32)) store_data_organizer (
        .data_in(lsq_store_data_o),
        .Type_sel(data_organizer_type_sel),
        .data_out(data_write)
    );
    // LSQ instance (simple, all ports explicit, connections skipped)
    lsq_simple_top lsq (
      // Clock and reset
      .clk(clk),
      .rst_n(reset),

      // Allocation interface (from Issue Stage)
      // Allocation 0
      .alloc_valid_0_i(issue_to_dispatch_0.lsq_alloc_valid),
      .alloc_is_store_0_i(issue_to_dispatch_0.control_signals[3] & ~issue_to_dispatch_0.control_signals[6]), // Store if immediate and not writing to rd
      .alloc_phys_reg_0_i(issue_to_dispatch_0.rd_phys_addr),
      .alloc_addr_tag_0_i(3'b000),
      .alloc_data_operand_0_i(inst_0_read_data_b),
      .alloc_data_tag_0_i(inst_0_read_tag_b),
      .alloc_size_0_i(issue_to_dispatch_0.control_signals[1:0]),
      .alloc_sign_extend_0_i(issue_to_dispatch_0.control_signals[2]),
      // Allocation 1
      .alloc_valid_1_i(issue_to_dispatch_1.lsq_alloc_valid),
      .alloc_is_store_1_i(issue_to_dispatch_1.control_signals[3] & ~issue_to_dispatch_1.control_signals[6]),
      .alloc_phys_reg_1_i(issue_to_dispatch_1.rd_phys_addr),
      .alloc_addr_tag_1_i(3'b001),
      .alloc_data_operand_1_i(inst_1_read_data_b),
      .alloc_data_tag_1_i(inst_1_read_tag_b),
      .alloc_size_1_i(issue_to_dispatch_1.control_signals[1:0]),
      .alloc_sign_extend_1_i(issue_to_dispatch_1.control_signals[2]),
      // Allocation 2
      .alloc_valid_2_i(issue_to_dispatch_2.lsq_alloc_valid),
      .alloc_is_store_2_i(issue_to_dispatch_1.control_signals[3] & ~issue_to_dispatch_1.control_signals[6]),
      .alloc_phys_reg_2_i(issue_to_dispatch_1.rd_phys_addr),
      .alloc_addr_tag_2_i(3'b010),
      .alloc_data_operand_2_i(inst_2_read_data_b),
      .alloc_data_tag_2_i(inst_2_read_tag_b),
      .alloc_size_2_i(issue_to_dispatch_2.control_signals[1:0]),
      .alloc_sign_extend_2_i(issue_to_dispatch_2.control_signals[2]),
      // Allocation output
      .alloc_ready_o(),

      // CDB interface
      .cdb_interface(cdb_interface.lsq),  

      // Memory interface
      .mem_req_addr_o(data_addr),    // data_addr
      .mem_req_data_o(lsq_store_data_o),    // data_write
      .mem_resp_data_i(lsq_load_data_i),   // data_read
      .mem_req_is_store_o(data_we), // data_we
      .mem_req_be_o(data_be),       // data_be
      .mem_req_valid_o(data_req), // data_req
      .mem_resp_valid_i(data_ack), //data_ack
      .mem_req_ready_i(1'b1), //mem_ready
     
      .mem_req_size_o(data_organizer_type_sel[1:0]),
      .mem_req_sign_extend_o(data_organizer_type_sel[2]),
      
     
      // Status outputs
      .lsq_count_o(),
      .lsq_full_o(),
      .lsq_empty_o()
    );
    
    

    logic [1:0] active_rs_number;
    assign active_rs_number = cdb_interface.cdb_valid_0 +
                              cdb_interface.cdb_valid_1 +
                              cdb_interface.cdb_valid_2;

    assign commit_valid = {commit_ready_2, commit_ready_1, commit_ready_0};


    //==========================================================================
    // STATUS AND DEBUG OUTPUTS
    //==========================================================================
    /*
    // Track reservation station occupancy
    assign rs_occupancy[0] = issue_to_dispatch_0.dispatch_valid && issue_to_dispatch_0.dispatch_ready;
    assign rs_occupancy[1] = issue_to_dispatch_1.dispatch_valid && issue_to_dispatch_1.dispatch_ready;
    assign rs_occupancy[2] = issue_to_dispatch_2.dispatch_valid && issue_to_dispatch_2.dispatch_ready;

    // Track which reservation stations are ready to issue
    assign rs_ready_to_issue[0] = dispatch_to_alu_0.issue_valid;
    assign rs_ready_to_issue[1] = dispatch_to_alu_1.issue_valid;
    assign rs_ready_to_issue[2] = dispatch_to_alu_2.issue_valid;

    // Register file utilization (placeholder - can be enhanced)
    assign reg_file_utilization = NUM_PHYS_REGS; // TODO: Implement actual utilization counting
    */
endmodule
