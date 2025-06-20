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


module arithmetic_unit#(parameter size = 32)(
    input logic [size-1:0] A,
    input logic [size-1:0] B,
    input logic [1:0] Sel,
    output logic [size-1:0] S,
    output logic C,
    output logic V,
    output logic N,
    output logic Z);

    logic [size-1:0] B1;
    logic [size-1:0] add_sub_out;
    logic sub;
    logic usign;
    logic out_select;

    assign sub = (Sel[0] | Sel[1]);
    assign usign = Sel[1] & Sel[0];
    assign out_select = Sel[1];
    assign B1 = {size{sub}} ^ B;


    defparam ADD_SUB.size = size;
    defparam N_mux.mem_width = 1;
    defparam N_mux.mem_depth = 2;
    defparam zero.size = size;
    defparam out_mux.mem_width = size;
    defparam out_mux.mem_depth = 2;

    CSA ADD_SUB(
        .A(A),
        .B(B1),
        .C({{(size-1){1'b0}},sub}),
        .S(add_sub_out),
        .cout(C),
        .v(V));

    parametric_mux N_mux(
        .addr((A[size-1] ^ B[size-1]) & usign),
        .data_in({B[size-1],add_sub_out[size-1]}),
        .data_out(N));

    Zero_comparator zero(
        .A(S),
        .Z(Z));

    parametric_mux out_mux(
        .addr(out_select),
        .data_in({{size-1{1'b0}},N,add_sub_out}),
        .data_out(S));
endmodule
