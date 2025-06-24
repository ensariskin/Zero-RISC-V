`timescale 1ns/1ns

module fetch_stage#(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic misprediction,
    input  logic [size-1 : 0] instruction_i,

	input  logic [size-1 : 0] correct_pc,
    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] current_pc,
    output logic [size-1 : 0] imm_o,
    output logic [size-1 : 0] pc_save,
    output branch_prediction);

    logic jump;
    logic [size-1 : 0] imm;
	logic jalr;

    early_stage_immediate_decoder  early_stage_imm_dec(
        .instruction(instruction_i),
        .imm_o(imm));

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
		.correct_pc(correct_pc),
		.misprediction(misprediction),
        .imm_i(imm),
        .current_pc(current_pc),
        .pc_save(pc_save));

    assign instruction_o = instruction_i;  // to avoid warning feedtrough, consider moving pipeline stage into modules
    assign imm_o = imm;
    assign branch_prediction = jump;

endmodule
