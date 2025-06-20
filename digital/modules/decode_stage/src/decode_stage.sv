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
    input logic [size-1 : 0] IMM_i,
    input logic [size-1 : 0] PCplus_i,
    input logic Predicted_MPC_i,
    input logic [5:0] Control_Signal_WB,
    input logic [size-1:0] DATA_in_WB,

    output logic Predicted_MPC_o,
    output logic [size-1 : 0] A,
    output logic [size-1 : 0] B,
    output logic [size-1 : 0] RAM_DATA,
    output logic [size-1 : 0] PCplus_o,
    output logic [25 : 0] Control_Signal,
    output logic [2:0] Branch_sel);



    wire [size-1 : 0] B_data;
    wire [4:0] RD, RB, RA;
    wire [3:0] FS;
    wire [2:0] Mem_Type_Sel;
    wire WE;
    wire MR;
    wire MD;
    wire MB;


    defparam RegFile.mem_width = size;
    defparam RegFile.mem_depth = size;

    defparam Mux_B.mem_width = size;
    defparam Mux_B.mem_depth = 2;

    defparam Hazard.mem_width = 26;
    defparam Hazard.mem_depth = 2;

    rv32i_decoder #(.size(size)) decoder(
        .instruction(i_instruction),
        .IMM_sel(),
        .Branch_sel(Branch_sel),
        .Mem_type_sel(Mem_Type_Sel),
        .A_select(RA),
        .B_select(RB),
        .D_addr(RD),
        .we(WE),
        .MR(MR),
        .MD(MD),
        .MB(MB),
        .FS(FS));

    RegisterFile RegFile(
        .clk(clk),
        .reset(reset),
        .we(Control_Signal_WB[0]),
        .Rin(DATA_in_WB),
        .A_select(RA),
        .B_select(RB),
        .D_addr(Control_Signal_WB[5:1]),
        .A_out(A),
        .B_out(B_data));

    parametric_mux Mux_B(
        .addr(MB),
        .data_in({IMM_i,B_data}),
        .data_out(B));

    parametric_mux Hazard(
        .addr(buble),
        .data_in({26'd0,{{RD,RB,RA,FS,WE,MR,MD,MB,Mem_Type_Sel} & {26{i_instruction[0]}}}}),
        .data_out(Control_Signal));


    assign Predicted_MPC_o = Predicted_MPC_i;
    assign RAM_DATA = B_data;
    assign PCplus_o = PCplus_i;
endmodule
