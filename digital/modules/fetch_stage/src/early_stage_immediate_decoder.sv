`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 01:35:44
// Design Name:
// Module Name: ES_IMM_Decoder
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

module early_stage_immediate_decoder #(parameter size = 32)(
    input  logic [size-1 : 0] instruction,
    output logic [size-1 : 0] imm_o);

    logic [size-1: 0] i_imm;
    logic [size-1: 0] s_imm;
    logic [size-1: 0] b_imm;
    logic [size-1: 0] u_imm;
    logic [size-1: 0] j_imm;
    logic [2:0] imm_sel;
    logic s;
    logic b;
    logic u;
    logic j;

    // TODO : Update type checking
    assign s = ~instruction[6] & instruction[5] & ~instruction[4] & ~instruction[3] & ~instruction[2];
    assign b =  instruction[6] & instruction[5] & ~instruction[4] & ~instruction[3] & ~instruction[2];
    assign j =  instruction[6] & instruction[5] & ~instruction[4] &  instruction[3] &  instruction[2];
    assign u = ~instruction[6] & instruction[4] & ~instruction[3] &  instruction[2];

    assign imm_sel[2] = j;
    assign imm_sel[1] = u | b;
    assign imm_sel[0] = u | s;

    assign i_imm = {{20{instruction[31]}},instruction[31:20]};
    assign s_imm = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
    assign b_imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8], 1'b0};
    assign u_imm = {instruction[31:12], {12{1'b0}}};
    assign j_imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0};

    parametric_mux #(.mem_width(size), .mem_depth(8)) MUX(
        .data_in({96'd0,j_imm,u_imm,b_imm,s_imm,i_imm}),
        .addr(imm_sel),
        .data_out(imm_o));

endmodule
