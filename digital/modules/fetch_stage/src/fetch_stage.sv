`timescale 1ns/1ns

module fetch_stage#(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic [size-1 : 0] instruction_i,
    input  logic isValid,
	input  logic [size-1 : 0] Correct_PC,
    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] ins_address,
    output logic [size-1 : 0] IMM,
    output logic [size-1 : 0] PCplus,
    output Predicted_MPC);

    wire w_Predicted_MPC;
    wire [size-1 : 0] w_IMM;
	wire JALR;

    early_stage_immediate_decoder  early_stage_imm_dec(
        .instruction(instruction_i),
        .IMM_out(w_IMM));

    branch_predictor branch_predictor(
        .instruction(instruction_i),
        .IMM(w_IMM),
        .isValid(isValid),
        .branch_prediction(w_Predicted_MPC),
		.JALR(JALR));

    program_counter_ctrl PC(
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .MPC(w_Predicted_MPC),
		.JALR(JALR),
		.Correct_PC(Correct_PC),
		.isValid(isValid),
        .IMM(w_IMM),
        .PC_Addr(ins_address),
        .PC_save(PCplus));

    assign instruction_o = instruction_i;
    assign IMM = w_IMM;
    assign Predicted_MPC = w_Predicted_MPC;

endmodule
