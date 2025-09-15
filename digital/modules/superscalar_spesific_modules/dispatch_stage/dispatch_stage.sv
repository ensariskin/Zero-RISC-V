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
    rs_to_exec_if.reservation_station dispatch_to_alu_2
    
    // Common Data Bus Interface (3 channels)
    //cdb_if.dispatch cdb_interface,
    
    // Status and Debug Outputs
    //output logic [2:0] rs_occupancy,           // How many RSs are occupied
    //output logic [2:0] rs_ready_to_issue,     // Which RSs are ready to issue
    //output logic [$clog2(NUM_PHYS_REGS):0] reg_file_utilization
);

    //==========================================================================
    // INTERNAL SIGNALS
    //==========================================================================
    
    // Physical register file interface signals
    // Read ports (6 total: 2 per reservation station)
    logic [PHYS_REG_ADDR_WIDTH-1:0] reg_read_addr [5:0];
    logic [DATA_WIDTH-1:0] reg_read_data [5:0];
    logic [1:0] reg_read_tag [5:0];
    
    //==========================================================================
    // SHARED PHYSICAL REGISTER FILE (64 entries)
    //==========================================================================
    
    multi_port_register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),  // 6 bits for 64 registers
        .NUM_READ_PORTS(6),                // 2 per reservation station
        .NUM_REGISTERS(NUM_PHYS_REGS)      // 64 physical registers
    ) physical_reg_file (
        .clk(clk),
        .reset(reset),
        
        // Read ports (2 per reservation station)
        .read_addr_0(reg_read_addr[0]), .read_data_0(reg_read_data[0]), .read_tag_0(reg_read_tag[0]),  // RS0 operand A
        .read_addr_1(reg_read_addr[1]), .read_data_1(reg_read_data[1]), .read_tag_1(reg_read_tag[1]),  // RS0 operand B
        .read_addr_2(reg_read_addr[2]), .read_data_2(reg_read_data[2]), .read_tag_2(reg_read_tag[2]),  // RS1 operand A
        .read_addr_3(reg_read_addr[3]), .read_data_3(reg_read_data[3]), .read_tag_3(reg_read_tag[3]),  // RS1 operand B
        .read_addr_4(reg_read_addr[4]), .read_data_4(reg_read_data[4]), .read_tag_4(reg_read_tag[4]),  // RS2 operand A
        .read_addr_5(reg_read_addr[5]), .read_data_5(reg_read_data[5]), .read_tag_5(reg_read_tag[5]),  // RS2 operand B
        
        // Allocation ports - set tags when instructions are dispatched 
        .alloc_enable_0(issue_to_dispatch_0.dispatch_valid), .alloc_addr_0(issue_to_dispatch_0.rd_phys_addr), .alloc_tag_0(2'b00),  // ALU0 tag
        .alloc_enable_1(issue_to_dispatch_1.dispatch_valid), .alloc_addr_1(issue_to_dispatch_1.rd_phys_addr), .alloc_tag_1(2'b01),  // ALU1 tag
        .alloc_enable_2(issue_to_dispatch_2.dispatch_valid), .alloc_addr_2(issue_to_dispatch_2.rd_phys_addr), .alloc_tag_2(2'b10),  // ALU2 tag
        
        // Commit ports - write results from CDB when complete
        .commit_enable_0(cdb_interface.cdb_valid_0), .commit_addr_0(cdb_interface.cdb_dest_reg_0), .commit_data_0(cdb_interface.cdb_data_0),
        .commit_enable_1(cdb_interface.cdb_valid_1), .commit_addr_1(cdb_interface.cdb_dest_reg_1), .commit_data_1(cdb_interface.cdb_data_1),
        .commit_enable_2(cdb_interface.cdb_valid_2), .commit_addr_2(cdb_interface.cdb_dest_reg_2), .commit_data_2(cdb_interface.cdb_data_2)
    );
    
    //==========================================================================
    // COMMON DATA BUS (CDB) INTERFACE
    //==========================================================================
    
    cdb_if #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH)
    ) cdb_interface ();
    
    //==========================================================================
    // INTERFACE BRIDGE: Convert new issue_to_dispatch_if to register file access
    //==========================================================================
    
    // Connect interface addresses to register file read ports
    // RS0: Read ports 0 and 1
    assign reg_read_addr[0] = issue_to_dispatch_0.operand_a_phys_addr;  // RS0 operand A
    assign reg_read_addr[1] = issue_to_dispatch_0.operand_b_phys_addr;  // RS0 operand B
    
    // RS1: Read ports 2 and 3  
    assign reg_read_addr[2] = issue_to_dispatch_1.operand_a_phys_addr;  // RS1 operand A
    assign reg_read_addr[3] = issue_to_dispatch_1.operand_b_phys_addr;  // RS1 operand B
    
    // RS2: Read ports 4 and 5
    assign reg_read_addr[4] = issue_to_dispatch_2.operand_a_phys_addr;  // RS2 operand A
    assign reg_read_addr[5] = issue_to_dispatch_2.operand_b_phys_addr;  // RS2 operand B
    
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
    assign internal_rs_if_0.operand_a_data = reg_read_data[0];  // Data from register file
    assign internal_rs_if_0.operand_b_data = issue_to_dispatch_0.control_signals[7] ? issue_to_dispatch_0.immediate_value : reg_read_data[1]; // Immediate or register
    assign internal_rs_if_0.store_data = reg_read_data[1];      // Store data same as operand B (from rs2)
    assign internal_rs_if_0.operand_a_tag = reg_read_tag[0];    // Tag from register file
    assign internal_rs_if_0.operand_b_tag = issue_to_dispatch_0.control_signals[7] ? 2'b11 : reg_read_tag[1]; // Immediate always ready (tag 11)
    assign internal_rs_if_0.rd_phys_addr = issue_to_dispatch_0.rd_phys_addr;
    assign internal_rs_if_0.pc_value_at_prediction = issue_to_dispatch_0.pc_value_at_prediction;
    assign internal_rs_if_0.branch_sel = issue_to_dispatch_0.branch_sel;
    assign internal_rs_if_0.branch_prediction = issue_to_dispatch_0.branch_prediction;
    
    // RS1 interface
    assign internal_rs_if_1.dispatch_valid = issue_to_dispatch_1.dispatch_valid;
    assign issue_to_dispatch_1.dispatch_ready = internal_rs_if_1.dispatch_ready;
    assign internal_rs_if_1.control_signals = issue_to_dispatch_1.control_signals;
    assign internal_rs_if_1.pc = issue_to_dispatch_1.pc;
    assign internal_rs_if_1.operand_a_data = reg_read_data[2];  // Data from register file
    assign internal_rs_if_1.operand_b_data = issue_to_dispatch_1.control_signals[7] ? issue_to_dispatch_1.immediate_value : reg_read_data[3]; // Immediate or register
    assign internal_rs_if_1.store_data = reg_read_data[3];      // Store data same as operand B (from rs2)
    assign internal_rs_if_1.operand_a_tag = reg_read_tag[2];    // Tag from register file
    assign internal_rs_if_1.operand_b_tag = issue_to_dispatch_1.control_signals[7] ? 2'b11 : reg_read_tag[3]; // Immediate always ready (tag 11)
    assign internal_rs_if_1.rd_phys_addr = issue_to_dispatch_1.rd_phys_addr;
    assign internal_rs_if_1.pc_value_at_prediction = issue_to_dispatch_1.pc_value_at_prediction;
    assign internal_rs_if_1.branch_sel = issue_to_dispatch_1.branch_sel;
    assign internal_rs_if_1.branch_prediction = issue_to_dispatch_1.branch_prediction;
    
    // RS2 interface
    assign internal_rs_if_2.dispatch_valid = issue_to_dispatch_2.dispatch_valid;
    assign issue_to_dispatch_2.dispatch_ready = internal_rs_if_2.dispatch_ready;
    assign internal_rs_if_2.control_signals = issue_to_dispatch_2.control_signals;
    assign internal_rs_if_2.pc = issue_to_dispatch_2.pc;
    assign internal_rs_if_2.operand_a_data = reg_read_data[4];  // Data from register file
    assign internal_rs_if_2.operand_b_data = issue_to_dispatch_2.control_signals[7] ? issue_to_dispatch_2.immediate_value : reg_read_data[5]; // Immediate or register
    assign internal_rs_if_2.store_data = reg_read_data[5];      // Store data same as operand B (from rs2)
    assign internal_rs_if_2.operand_a_tag = reg_read_tag[4];    // Tag from register file
    assign internal_rs_if_2.operand_b_tag = issue_to_dispatch_2.control_signals[7] ? 2'b11 : reg_read_tag[5]; // Immediate always ready (tag 11)
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
        .ALU_TAG(2'b00)  // ALU0 tag
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
        .ALU_TAG(2'b01)  // ALU1 tag
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
        .ALU_TAG(2'b10)  // ALU2 tag
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