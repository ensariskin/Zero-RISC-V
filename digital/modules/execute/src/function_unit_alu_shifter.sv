`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 19.05.2022 18:32:20
// Design Name:
// Module Name: FU
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


module function_unit_alu_shifter #(parameter size = 32)(

    input  logic [size-1:0] data_a,
    input  logic [size-1:0] data_b,
    input  logic [3:0] func_sel,
    output logic [size-1:0] data_result,
    output logic carry_out,
    output logic overflow,
    output logic negative,
    output logic zero,
    output logic busy);

    logic [size-1:0] alu_out;
    logic [size-1:0] shifter_out;
    logic alu_c, alu_v, alu_n, alu_z;


    assign carry_out = alu_c & ~func_sel[3];
    assign overflow  = alu_v & ~func_sel[3];
    assign negative  = alu_n & ~func_sel[3];
    assign zero      = alu_z & ~func_sel[3];
    assign busy      = 1'b0; // Combinational, always ready

    alu #(.size(size)) alu(
        .data_a(data_a),
        .data_b(data_b),
        .func_sel(func_sel[2:0]),
        .data_result(alu_out),
        .carry_out(alu_c),
        .overflow(alu_v),
        .zero(alu_z),
        .negative(alu_n));

    shifter #(.size(size)) shifter(
        .Sel(func_sel[1:0]),
        .shamt(data_b[$clog2(size)-1 :0]),
        .Data_in(data_a),
        .Data_out(shifter_out));

    parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(
        .addr(func_sel[3]),
        .data_in({shifter_out,alu_out}),
        .data_out(data_result));

endmodule
