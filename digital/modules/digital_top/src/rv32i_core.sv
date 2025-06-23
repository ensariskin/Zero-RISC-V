`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 22:50:43
// Design Name:
// Module Name: Pipelined_design
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


module rv32i_core #(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic [size-1 : 0] instruction_i,
    input  logic [size-1 : 0] MEM_result_i,
    output logic [size-1 : 0] ins_address,
    output logic [size-1 : 0] RAM_DATA_o,
    output logic [size-1 : 0] RAM_Addr_o,
    output logic [2:0] RAM_DATA_control,
    output logic RAM_rw);

    // main pipeline logics

    logic [size-1:0] instruction_IF_o;
    logic [size-1:0] IMM_IF_o;
    logic [size-1:0] PCPlus_IF_o;
    logic Predicted_MPC_IF_o;

    logic [size-1:0] instruction_ID_i;
    logic [size-1:0] IMM_ID_i;
    logic [size-1:0] PCPlus_ID_i;
    logic Predicted_MPC_ID_i;

    logic Predicted_MPC_ID_o;
    logic [size-1 : 0] A_ID_o;
    logic [size-1 : 0] B_ID_o;
    logic [size-1 : 0] RAM_DATA_ID_o;
    logic [size-1 : 0] PCplus_ID_o;
    logic [25 : 0] Control_Signal_ID_o;
    logic [2:0] Branch_sel_ID_o;

    logic Predicted_MPC_EX_i;
    logic [size-1 : 0] A_EX_i;
    logic [size-1 : 0] B_EX_i;
    logic [size-1 : 0] RAM_DATA_EX_i;
    logic [size-1 : 0] PCplus_EX_i;
    logic [25 : 0] Control_Signal_EX_i;
    logic [2:0] Branch_sel_EX_i;


    logic [size-1 : 0] FU_EX_o;
    logic [size-1 : 0] RAM_DATA_EX_o;
    logic [size-1 : 0] PCplus_EX_o;
    logic [11 : 0] Control_Signal_EX_o;

    logic [size-1 : 0] FU_MEM_i;
    logic [size-1 : 0] RAM_DATA_MEM_i;
    logic [size-1 : 0] PCplus_MEM_i;
    logic [11 : 0] Control_Signal_MEM_i;


    logic [size-1 : 0] FU_MEM_o;
    logic [size-1 : 0] MEM_result_MEM_o;
    logic [size-1 : 0] PCplus_MEM_o;
    logic [7 : 0] Control_Signal_MEM_o;

    logic [size-1 : 0] FU_WB_i;
    logic [size-1 : 0] MEM_result_WB_i;
    logic [size-1 : 0] PCplus_WB_i;
    logic [7 : 0] Control_Signal_WB_i;

    logic [size-1 : 0] Final_Result_WB_o;
    logic [5 : 0] Control_Signal_WB_o;

    //
    logic isValid;
    logic buble;
    logic [4:0] RA_DF, RB_DF, RD_MEM, RD_WB;
    logic WE_MEM, WE_WB;
    //logic isLoadMem;
    logic [1:0] A_sel_DF;
    logic [1:0] B_sel_DF;

	logic [size-1 : 0] PC_EX_o;


    fetch_stage Ins_Fetch(  // reformatting is done
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .instruction_i(instruction_i),
        .misprediction(isValid),
		.correct_pc(PC_EX_o),
        .instruction_o(instruction_IF_o),
        .current_pc(ins_address),
        .imm_o(IMM_IF_o),
        .pc_save(PCPlus_IF_o),
        .branch_prediction(Predicted_MPC_IF_o));

    if_to_id IF_ID(  // reformatting is done
        .clk(clk),
        .reset(reset),
        .buble(buble),
		.flush(~isValid),
        .instruction_i(instruction_IF_o),
        .imm_i(IMM_IF_o),
        .pc_plus_i(PCPlus_IF_o),
        .branch_prediction_i(Predicted_MPC_IF_o),
        .instruction_o(instruction_ID_i),
        .imm_o(IMM_ID_i),
        .pc_plus_o(PCPlus_ID_i),
        .branch_prediction_o(Predicted_MPC_ID_i));

    decode_stage ID(
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .i_instruction(instruction_ID_i),
        .immediate_i(IMM_ID_i),
        .pc_plus_i(PCPlus_ID_i),
        .branch_perediction_i(Predicted_MPC_ID_i),
        .control_signal_wb(Control_Signal_WB_o),
        .data_in_wb(Final_Result_WB_o),
        .branch_prediction_o(Predicted_MPC_ID_o),
        .data_a(A_ID_o),
        .data_b(B_ID_o),
        .store_data(RAM_DATA_ID_o),
        .pc_plus_o(PCplus_ID_o),
        .control_signal(Control_Signal_ID_o),
        .branch_sel(Branch_sel_ID_o));

    id_to_ex ID_EX(
        .clk(clk),
        .reset(reset),
		.flush(~isValid),
        .branch_prediction_i(Predicted_MPC_ID_o),
        .data_a_i(A_ID_o),
        .data_b_i(B_ID_o),
        .store_data_i(RAM_DATA_ID_o),
        .pc_plus_i(PCplus_ID_o),
        .control_signal_i(Control_Signal_ID_o),
        .branch_sel_i(Branch_sel_ID_o),

        .branch_prediction_o(Predicted_MPC_EX_i),
        .data_a_o(A_EX_i),
        .data_b_o(B_EX_i),
        .store_data_o(RAM_DATA_EX_i),
        .pc_plus_o(PCplus_EX_i),
        .control_signal_o(Control_Signal_EX_i),
        .branch_sel_o(Branch_sel_EX_i));

    EX EX(
        //.clk(clk),
        //.reset(reset),

        .Predicted_MPC_i(Predicted_MPC_EX_i),
        .A_i(A_EX_i),
        .B_i(B_EX_i),
        .RAM_DATA_i(RAM_DATA_EX_i),
        .PCplus_i(PCplus_EX_i),
        .Control_Signal_i(Control_Signal_EX_i),
        .Branch_sel(Branch_sel_EX_i),
        .Data_MEM(FU_MEM_i),
        .Data_WB(Final_Result_WB_o),
        .A_sel(A_sel_DF),
        .B_sel(B_sel_DF),

        .FU_o(FU_EX_o),
        .RAM_DATA_o(RAM_DATA_EX_o),
        .PCplus_o(PCplus_EX_o),
        .Control_Signal_o(Control_Signal_EX_o),
        .RA(RA_DF),
        .RB(RB_DF),
        .isValid(isValid),
		.Correct_PC(PC_EX_o));

    ex_to_mem EX_MEM(
        .clk(clk),
        .reset(reset),
        .FU_i(FU_EX_o),
        .RAM_DATA_i(RAM_DATA_EX_o),
        .PCplus_i(PCplus_EX_o),
        .Control_Signal_i(Control_Signal_EX_o),

        .FU_o(FU_MEM_i),
        .RAM_DATA_o(RAM_DATA_MEM_i),
        .PCplus_o(PCplus_MEM_i),
        .Control_Signal_o(Control_Signal_MEM_i));

    MEM MEM(
        .FU_i(FU_MEM_i),
        .RAM_DATA_i(RAM_DATA_MEM_i),
        .PCplus_i(PCplus_MEM_i),
        .MEM_result_i(MEM_result_i),
        .Control_Signal_i(Control_Signal_MEM_i),

        .RAM_DATA_o(RAM_DATA_o),
        .RAM_DATA_control(RAM_DATA_control),
        .RAM_rw(RAM_rw),

        .RD_MEM(RD_MEM),
        .WE_MEM(WE_MEM),

        .FU_o(FU_MEM_o),
        .MEM_result_o(MEM_result_MEM_o),
        .PCplus_o(PCplus_MEM_o),
        .Control_Signal_o(Control_Signal_MEM_o));

    mem_to_wb MEM_WB(
        .clk(clk),
        .reset(reset),

        .func_unit_i(FU_MEM_o),
        .mem_result_i(MEM_result_MEM_o),
        .pc_plus_i(PCplus_MEM_o),
        .control_signal_i(Control_Signal_MEM_o),

        .func_unit_o(FU_WB_i),
        .mem_result_o(MEM_result_WB_i),
        .pc_plus_o(PCplus_WB_i),
        .control_signal_o(Control_Signal_WB_i));


    WB WB(
        .FU_i(FU_WB_i),
        .MEM_result_i(MEM_result_WB_i),
        .PCplus_i(PCplus_WB_i),
        .Control_Signal_i(Control_Signal_WB_i),


        .RD_WB(RD_WB),
        .WE_WB(WE_WB),
        .Final_Result(Final_Result_WB_o),
        .Control_Signal_o(Control_Signal_WB_o));


    Data_Forward DF(
        .RA(RA_DF),
        .RB(RB_DF),
		.MB(Control_Signal_EX_i[3]),
        .RD_MEM(RD_MEM),
        .RD_WB(RD_WB),
        .WE_MEM(WE_MEM),
        .WE_WB(WE_WB),
        .A_sel(A_sel_DF),
        .B_sel(B_sel_DF));

    hazard_detection_unit HD(
        .clk(clk),
        .reset(reset),
        .RD_EX(Control_Signal_EX_o[11:7]),
        .isLoad_EX(Control_Signal_EX_o[4]),
        .RA_ID(Control_Signal_ID_o[15:11]),
        .RB_ID(Control_Signal_ID_o[20:16]),
        .buble(buble));

    assign RAM_Addr_o = FU_MEM_o;
endmodule
