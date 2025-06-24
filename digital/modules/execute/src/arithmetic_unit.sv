`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 18.05.2022 22:58:39
// Design Name:
// Module Name: arithmetic_unit
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


module arithmetic_unit #(parameter size = 32)(
    input logic [size-1:0] data_a,
    input logic [size-1:0] data_b,
    input logic [1:0] func_sel, // 0 : add, 1 : sub, 2 : slt, 3 : sltu
    output logic [size-1:0] data_result,
    output logic carry_out,
    output logic overflow,
    output logic negative,
    output logic zero);

    logic [size-1:0] data_b_prep;
    logic [size-1:0] add_sub_out;

    logic sub;
    logic usign;
    logic out_select;

    assign sub = (func_sel[0] | func_sel[1]);
    assign usign = func_sel[1] & func_sel[0];
    assign out_select = func_sel[1];
    assign data_b_prep = data_b ^ {size{sub}};  // if sub is 1, we need to invert B
    assign zero = add_sub_out == 'h0;

    CSA #(.size(size)) ADD_SUB(
        .A(data_a),
        .B(data_b_prep),
        .C({{(size-1){1'b0}},sub}),
        .S(add_sub_out),
        .cout(carry_out),
        .v(overflow));

    parametric_mux #(.mem_width(1), .mem_depth(2)) n_mux(   // TODO : why do we need this mux?
        .addr((data_a[size-1] ^ data_b[size-1]) & usign),
        .data_in({data_b[size-1], add_sub_out[size-1]}),
        .data_out(negative));

    /* I don't think we need this zero comparator, is it really optimizing anything? TODO check it
    Zero_comparator #(.size(size)) zero(
        .A(S),
        .Z(Z));
    */

    parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(
        .addr(out_select),
        .data_in({{size-1{1'b0}}, negative, add_sub_out}),
        .data_out(data_result));
endmodule
