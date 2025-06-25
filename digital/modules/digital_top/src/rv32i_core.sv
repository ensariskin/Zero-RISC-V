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

    output logic [size-1 : 0] ins_address,
    input  logic [size-1 : 0] instruction_i,

    output logic data_mem_rw,
    output logic [size-1 : 0] data_mem_addr_o,
    output logic [size-1 : 0] data_mem_data_wr_data,
    input  logic [size-1 : 0] data_mem_data_rd_data,
    output logic [2:0]        data_mem_control
    );

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

    logic [size-1 : 0] execution_result;
    logic [size-1 : 0] RAM_DATA_EX_o;
    logic [11 : 0] Control_Signal_EX_o;

    logic [size-1 : 0] FU_MEM_i;
    logic [size-1 : 0] RAM_DATA_MEM_i;
    logic [11 : 0] Control_Signal_MEM_i;

    logic [size-1 : 0] FU_MEM_o;
    logic [size-1 : 0] MEM_result_MEM_o;
    logic [7 : 0] Control_Signal_MEM_o;

    logic [size-1 : 0] FU_WB_i;
    logic [size-1 : 0] MEM_result_WB_i;
    logic [7 : 0] Control_Signal_WB_i;

    logic [size-1 : 0] Final_Result_WB_o;
    logic [5 : 0] Control_Signal_WB_o;

    //
    logic misprediction;
    logic buble;
    logic [4:0] RA_DF, RB_DF, RD_MEM, RD_WB;
    logic WE_MEM, WE_WB;
    //logic isLoadMem;
    logic [1:0] A_sel_DF;
    logic [1:0] B_sel_DF;

	logic [size-1 : 0] correct_pc;

    fetch_stage Ins_Fetch(  // reformatting is done
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .instruction_i(instruction_i),
        .misprediction(misprediction),
		.correct_pc(correct_pc),
        .instruction_o(instruction_IF_o),
        .current_pc(ins_address),
        .imm_o(IMM_IF_o),
        .pc_save(PCPlus_IF_o),
        .branch_prediction(Predicted_MPC_IF_o));

    if_to_id IF_ID(  // reformatting is done
        .clk(clk),
        .reset(reset),
        .buble(buble),
		.flush(misprediction),
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
		.flush(misprediction),
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

    execute_stage EX(
        //.clk(clk),
        //.reset(reset),

        .branch_prediction_i(Predicted_MPC_EX_i),
        .data_a_i(A_EX_i),
        .data_b_i(B_EX_i),
        .store_data_i(RAM_DATA_EX_i),
        .pc_plus_i(PCplus_EX_i),
        .control_signal_i(Control_Signal_EX_i),
        .branch_sel(Branch_sel_EX_i),

        .data_from_mem(FU_MEM_i),
        .data_from_wb(Final_Result_WB_o),
        .data_a_forward_sel(A_sel_DF),
        .data_b_forward_sel(B_sel_DF),

        .calculated_result_o(execution_result),
        .store_data_o(RAM_DATA_EX_o),
        .control_signal_o(Control_Signal_EX_o),

        .rs1_addr(RA_DF),
        .rs2_addr(RB_DF),
        .misprediction_o(misprediction),
		.correct_pc(correct_pc));

    ex_to_mem EX_MEM(
        .clk(clk),
        .reset(reset),
        .executed_result_i(execution_result),
        .store_data_i(RAM_DATA_EX_o),
        .control_signal_i(Control_Signal_EX_o),

        .executed_result_o(FU_MEM_i),
        .store_data_o(RAM_DATA_MEM_i),
        .control_signal_o(Control_Signal_MEM_i));

    mem_stage MEM(
        .execute_result_i(FU_MEM_i),
        .store_data_i(RAM_DATA_MEM_i),
        .control_signal_i(Control_Signal_MEM_i),

        .load_data_i(data_mem_data_rd_data),

        .store_data_o(data_mem_data_wr_data),
        .data_mem_width_sel(data_mem_control),
        .data_mem_rw(data_mem_rw),

        .execute_result_o(FU_MEM_o),
        .load_data_o(MEM_result_MEM_o),

        .control_signal_o(Control_Signal_MEM_o),
        .mem_stage_destination(RD_MEM),
        .mem_stage_we(WE_MEM)
        );

    mem_to_wb MEM_WB(
        .clk(clk),
        .reset(reset),

        .ex_stage_result_i(FU_MEM_o),
        .mem_stage_result_i(MEM_result_MEM_o),
        .control_signal_i(Control_Signal_MEM_o),

        .ex_stage_result_o(FU_WB_i),
        .mem_stage_result_o(MEM_result_WB_i),
        .control_signal_o(Control_Signal_WB_i));

    write_back_stage WB(
        .ex_stage_result_i(FU_WB_i),
        .mem_stage_result_i(MEM_result_WB_i),
        .control_signal_i(Control_Signal_WB_i),

        .wb_stage_destination(RD_WB),
        .wb_stage_we(WE_WB),
        .wb_result_o(Final_Result_WB_o),
        .control_signal_o(Control_Signal_WB_o));

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

    assign data_mem_addr_o = FU_MEM_o;
endmodule
