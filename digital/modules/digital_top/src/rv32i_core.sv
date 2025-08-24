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
    input  logic              instruction_valid,

    output logic              data_mem_rw,
    output logic [size-1 : 0] data_mem_addr_o,
    output logic [size-1 : 0] data_mem_data_wr_data,
    input  logic [size-1 : 0] data_mem_data_rd_data,
    output logic [2:0]        data_mem_control,
    
    // Tracer interface output from WB stage
    tracer_interface tracer_o
    );

    // main pipeline logics

    logic [size-1:0] instruction_ID_i;
    logic [size-1:0] IMM_ID_i;
    logic [size-1:0] PCPlus_ID_i;
    logic Predicted_MPC_ID_i;

    logic Predicted_MPC_EX_i;
    logic [size-1 : 0] A_EX_i;
    logic [size-1 : 0] B_EX_i;
    logic [size-1 : 0] RAM_DATA_EX_i;
    logic [size-1 : 0] PCplus_EX_i;
    logic [25 : 0] Control_Signal_EX_i;
    logic [2:0] Branch_sel_EX_i;

    logic [size-1 : 0] FU_MEM_i;
    logic [size-1 : 0] RAM_DATA_MEM_i;
    logic [11 : 0] Control_Signal_MEM_i;

    logic [size-1 : 0] FU_WB_i;
    logic [size-1 : 0] MEM_result_WB_i;
    logic [10 : 0] Control_Signal_WB_i;

    logic [size-1 : 0] Final_Result_WB_o;
    logic [5 : 0] Control_Signal_WB_o;

    logic [4:0] rs1_id;
    logic [4:0] rs2_id;

    //
    logic misprediction;
    logic buble;
    logic [4:0] RA_DF, RB_DF, RD_MEM, RD_WB;
    logic WE_MEM, WE_WB;
    //logic isLoadMem;
    logic [1:0] A_sel_DF;
    logic [1:0] B_sel_DF;
    logic [1:0] store_sel_df; // for store data forwarding

	logic [size-1 : 0] correct_pc;

    // Tracer interfaces for pipeline stages
    tracer_interface tracer_if_fetch_decode();
    tracer_interface tracer_if_decode_execute();
    tracer_interface tracer_if_execute_mem();
    tracer_interface tracer_if_mem_wb();    

    fetch_stage IF(  // reformatting is done
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .instruction_i(instruction_i),
        .instruction_valid(instruction_valid),
        .misprediction(misprediction),
        .flush(misprediction),
        .correct_pc(correct_pc),
        .inst_addr(ins_address),
        .instruction_o(instruction_ID_i),
        .imm_o(IMM_ID_i),
        .pc_plus_o(PCPlus_ID_i),
        .branch_prediction_o(Predicted_MPC_ID_i),
        .tracer_if(tracer_if_fetch_decode)
    );

    decode_stage ID(
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .i_instruction(instruction_ID_i),
        .immediate_i(IMM_ID_i),
        .pc_plus_i(PCPlus_ID_i),
        .branch_perediction_i(Predicted_MPC_ID_i),
        .flush(misprediction),
        .control_signal_wb(Control_Signal_WB_o),
        .data_in_wb(Final_Result_WB_o),
        .branch_prediction_o(Predicted_MPC_EX_i),
        .data_a_o(A_EX_i),
        .data_b_o(B_EX_i),
        .store_data_o(RAM_DATA_EX_i),
        .pc_plus_o(PCplus_EX_i),
        .control_signal_o(Control_Signal_EX_i),
        .branch_sel_o(Branch_sel_EX_i),
        .rs1_addr(rs1_id),
        .rs2_addr(rs2_id),
        .tracer_if_i(tracer_if_fetch_decode),
        .tracer_if_o(tracer_if_decode_execute)
        );    
        
    execute_stage EX(
        .clk(clk),
        .reset(reset),

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
        .data_store_forward_sel(store_sel_df),
        .calculated_result_o(FU_MEM_i),
        .store_data_o(RAM_DATA_MEM_i),
        .control_signal_o(Control_Signal_MEM_i),

        .rs1_addr(RA_DF),
        .rs2_addr(RB_DF),
        .misprediction_o(misprediction),
        .correct_pc(correct_pc),
        .tracer_if_i(tracer_if_decode_execute),
        .tracer_if_o(tracer_if_execute_mem)
    );

    mem_stage MEM(
        .clk(clk),
        .reset(reset),
        .execute_result_i(FU_MEM_i),
        .store_data_i(RAM_DATA_MEM_i),
        .control_signal_i(Control_Signal_MEM_i),

        .store_data_o(data_mem_data_wr_data),
        .data_mem_width_sel(data_mem_control),
        .data_mem_rw(data_mem_rw),

        .execute_result_o(FU_WB_i),

        .control_signal_o(Control_Signal_WB_i),
        .mem_stage_destination(RD_MEM),
        .mem_stage_we(WE_MEM),
        .tracer_if_i(tracer_if_execute_mem),
        .tracer_if_o(tracer_if_mem_wb)
        );

    write_back_stage WB(
        .clk(clk),
        .reset(reset),
        .ex_stage_result_i(FU_WB_i),
        .load_data_i(data_mem_data_rd_data),
        .control_signal_i(Control_Signal_WB_i),

        .wb_stage_destination(RD_WB),
        .wb_stage_we(WE_WB),
        .wb_result_o(Final_Result_WB_o),
        .control_signal_o(Control_Signal_WB_o),
        .tracer_if_i(tracer_if_mem_wb),
        .tracer_if_o(tracer_o)  // No connection needed for final stage
    );

    Data_Forward DF(
        .RA(RA_DF),
        .RB(RB_DF),
		.MB(Control_Signal_EX_i[3]),
        .RD_MEM(RD_MEM),
        .RD_WB(RD_WB),
        .WE_MEM(WE_MEM),
        .WE_WB(WE_WB),
        .A_sel(A_sel_DF),
        .B_sel(B_sel_DF),
        .store_data_sel(store_sel_df));

    hazard_detection_unit HD(
        .clk(clk),
        .reset(reset),
        .RD_EX(Control_Signal_EX_i[25:21]),
        .isLoad_EX(Control_Signal_EX_i[4]),
        .RA_ID(rs1_id),
        .RB_ID(rs2_id),
        .buble(buble));

    assign data_mem_addr_o = FU_MEM_i;
endmodule
