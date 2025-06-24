`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 18.05.2022 22:56:50
// Design Name:
// Module Name: logical_unit
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


module logical_unit #(parameter size = 32)(

    input  logic [size-1:0] data_a,
    input  logic [size-1:0] data_b,
    input  logic [1:0] func_sel,   // 0 : xor, 1 : or, 2 : and, 3 : reserved
    output logic [size-1:0] data_result);

    logic [size-1:0] xor_result;
    logic [size-1:0] or_result;
    logic [size-1:0] and_result;

    assign xor_result = data_a ^ data_b;
    assign or_result  = data_a | data_b;
    assign and_result = data_a & data_b;

    parametric_mux #(.mem_width(size), .mem_depth(4)) out_mux(
        .addr(func_sel),
        .data_in({{size{1'b0}}, and_result, or_result, xor_result}),
        .data_out(data_result));

endmodule
