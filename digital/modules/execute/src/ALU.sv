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

module ALU#(parameter size = 32)(
    input logic [size-1:0] A,
    input logic [size-1:0] B,
    input logic [2:0] Sel,
    output logic [size-1:0] S,
    output logic C,
    output logic V,
    output logic Z,
    output logic N);

    logic [size-1:0] arithmetic_out;
    logic [size-1:0] logical_out;

    arithmetic_unit #(.size(size)) arithmetic(
        .A(A),
        .B(B),
        .Sel(Sel[1:0]),
        .S(arithmetic_out),
        .C(C),
        .V(V),
        .Z(Z),
        .N(N));

    logical_unit #(.size(size)) logical(
        .A(A),
        .B(B),
        .Sel(Sel[1:0]),
        .S(logical_out));

    Parametric_mux # (.mem_width(size), .mem_depth(2)) out_mux(
        .addr(Sel[2]),
        .data_in({logical_out, arithmetic_out}),
        .data_out(S));


endmodule
