`timescale 1ns/1ns

module fetch_stage#(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic isValid,
    input  logic [size-1 : 0] instruction_i,

	input  logic [size-1 : 0] Correct_PC,
    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] ins_address,
    output logic [size-1 : 0] imm_o,
    output logic [size-1 : 0] PCplus,
    output Predicted_MPC);

    logic jump;
    logic [size-1 : 0] imm;
	logic jalr;

    early_stage_immediate_decoder  early_stage_imm_dec(
        .instruction(instruction_i),
        .IMM_out(imm));

    jump_controller #(.size(size)) jump_controller(
        .instruction(instruction_i),
        //.isValid(isValid),
        .jump(jump),
		.jalr(jalr));

    program_counter_ctrl PC(
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .jump(jump),
		.jalr(jalr),
		.correct_pc(Correct_PC),
		.misprediction(isValid),
        .imm_i(imm),
        .pc_addr(ins_address),
        .pc_save(PCplus));

    assign instruction_o = instruction_i;
    assign imm_o = imm;
    assign Predicted_MPC = jump;

endmodule
