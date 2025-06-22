`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: decode_stage
//
// Description:
//     This module implements the Instruction Decode (ID) stage of a 5-stage RISC-V
//     pipeline processor. It handles instruction decoding, register file access,
//     immediate value selection, and hazard detection.
//
// Features:
//     - Register file read/write operations
//     - Control signal generation from instruction decoding
//     - Operand forwarding from writeback stage
//     - Pipeline bubble insertion for hazard handling
//     - Branch prediction signal propagation
//////////////////////////////////////////////////////////////////////////////////

module decode_stage #(parameter size = 32)(
    input logic clk,
    input logic reset,
    input logic buble,
    input logic [size-1 : 0] i_instruction,
    input logic [size-1 : 0] immediate_i,
    input logic [size-1 : 0] pc_plus_i,
    input logic branch_perediction_i,
    input logic [5:0] Control_Signal_WB,
    input logic [size-1:0] DATA_in_WB,

    output logic branch_prediction_o,
    output logic [size-1 : 0] data_a,
    output logic [size-1 : 0] data_b,
    output logic [size-1 : 0] store_data,
    output logic [size-1 : 0] pc_plus_o,
    output logic [25 : 0] control_signal,
    output logic [2:0] branch_sel);

    logic [size-1 : 0] reg_b_value;

    rv32i_decoder #(.size(size)) decoder(
        .instruction(i_instruction),
        .buble(buble),
        .branch_sel(branch_sel),
        .control_word(control_signal)
        );

    register_file #(.mem_width(size),.mem_depth(size)) RegFile(
        .clk(clk),
        .reset(reset),
        .we(Control_Signal_WB[0]),
        .rd_in(DATA_in_WB),
        .a_select(control_signal[15:11]),
        .b_select(control_signal[20:16]),
        .write_addr(Control_Signal_WB[5:1]),
        .a_out(data_a),
        .b_out(reg_b_value));

    parametric_mux #(.mem_width(size), .mem_depth(2)) Mux_B(
        .addr(control_signal[3]),
        .data_in({immediate_i, reg_b_value}),
        .data_out(data_b));


    assign branch_prediction_o = branch_perediction_i;
    assign store_data = reg_b_value;
    assign pc_plus_o = pc_plus_i;
endmodule
