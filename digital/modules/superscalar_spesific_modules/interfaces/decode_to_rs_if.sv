`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: decode_to_rs_if
//
// Description:
//     This interface defines the communication protocol between the decode stage
//     and a single reservation station in a superscalar RISC-V processor
//     implementing the Tomasulo algorithm.
//
// Features:
//     - Clean separation between decode and reservation station
//     - Tag-based dependency tracking
//     - Reduced control signals (no register addresses)
//     - Ready/valid handshaking for flow control
//////////////////////////////////////////////////////////////////////////////////

interface decode_to_rs_if #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6
);
    // Dispatch signals (decode → RS)
    logic dispatch_valid;              // Valid instruction being dispatched
    logic dispatch_ready;              // RS can accept new instruction (RS → decode)
    
    // Reduced control signals (decode → RS) - removed register address fields
    logic [10:0] control_signals;      // Bits [10:7] = func_sel, [6] = we, [5] = pc_sel, [4:0] = other control
    logic [DATA_WIDTH-1:0] pc;
    
    // Source operands with dependency info (decode → RS)
    logic [DATA_WIDTH-1:0] operand_a_data;
    logic [DATA_WIDTH-1:0] operand_b_data;    // Already muxed (reg_data OR immediate)
    logic [DATA_WIDTH-1:0] store_data;        // Data to be stored (for store instructions)
    logic [1:0] operand_a_tag;         // Which ALU will produce operand A
    logic [1:0] operand_b_tag;         // Which ALU will produce operand B (or 2'b11 if immediate)
    
    // Physical destination register (decode → RS)
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr;
    
    // Branch prediction info (decode → RS)
    logic [DATA_WIDTH-1:0] pc_value_at_prediction;
    logic [2:0] branch_sel;
    logic branch_prediction;
    
    // Modport definitions
    modport decode (
        output dispatch_valid,
        input  dispatch_ready,
        output control_signals,
        output pc,
        output operand_a_data,
        output operand_b_data,
        output store_data,
        output operand_a_tag,
        output operand_b_tag,
        output rd_phys_addr,
        output pc_value_at_prediction,
        output branch_sel,
        output branch_prediction
    );
    
    modport reservation_station (
        input  dispatch_valid,
        output dispatch_ready,
        input  control_signals,
        input  pc,
        input  operand_a_data,
        input  operand_b_data,
        input  store_data,
        input  operand_a_tag,
        input  operand_b_tag,
        input  rd_phys_addr,
        input  pc_value_at_prediction,
        input  branch_sel,
        input  branch_prediction
    );

endinterface
