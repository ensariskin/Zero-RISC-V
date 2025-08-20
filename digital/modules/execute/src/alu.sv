`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 18.05.2022 22:54:32
// Design Name:
// Module Name: ALU
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu #(parameter size = 32)(
    input logic [size-1:0] data_a,
    input logic [size-1:0] data_b,
    input logic [2:0] func_sel,   // 0 : add, 1 : sub, 2 : slt, 3 : sltu, 4 : xor, 5 : or, 6 : and, 7 : reserved
    output logic [size-1:0] data_result,
    output logic carry_out,
    output logic overflow,
    output logic zero,
    output logic negative);

    logic [size-1:0] arithmetic_out;
    logic [size-1:0] logical_out;

    arithmetic_unit #(.size(size)) arithmetic(
        .data_a(data_a),
        .data_b(data_b),
        .func_sel(func_sel[1:0]),         // 0 : add, 1 : sub, 2 : slt, 3 : sltu
        .data_result(arithmetic_out),
        .carry_out(carry_out),               // TODO se them 0 in case of logical operation
        .overflow(overflow),
        .zero(zero),
        .negative(negative));

    logical_unit #(.size(size)) logical(
        .data_a(data_a),
        .data_b(data_b),
        .func_sel(func_sel[1:0]),
        .data_result(logical_out));

    parametric_mux # (.mem_width(size), .mem_depth(2)) out_mux(
        .addr(func_sel[2]),
        .data_in({logical_out, arithmetic_out}),
        .data_out(data_result));


endmodule
