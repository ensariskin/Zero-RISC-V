`timescale 1ns/1ns

module fetch_stage#(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic misprediction,
    input  logic [size-1 : 0] instruction_i,

    // Pipeline control signals
    input  logic flush,

	input  logic [size-1 : 0] correct_pc,
    output logic [size-1 : 0] current_pc,

    // Pipeline outputs (IF/ID register outputs)
    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] imm_o,
    output logic [size-1 : 0] pc_plus_o,
    output logic branch_prediction_o);

    // Internal signals
    logic jump;
    logic [size-1 : 0] imm;
	logic jalr;
    logic [size-1 : 0] pc_plus_internal;

    // Immediate decoder
    early_stage_immediate_decoder  early_stage_imm_dec(
        .instruction(instruction_i),
        .imm_o(imm));

    // Jump controller
    jump_controller #(.size(size)) jump_controller(
        .instruction(instruction_i),
        .jump(jump),
		.jalr(jalr));

    // Program counter control
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
        .pc_save(pc_plus_internal));

    // IF/ID Pipeline Register
    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            instruction_o <= 0;
            imm_o <= 0;
            pc_plus_o <= 0;
            branch_prediction_o <= 0;
        end else if (~buble) begin
            if(flush) begin
                instruction_o <= 0;
                imm_o <= 0;
                pc_plus_o <= 0;
                branch_prediction_o <= 0;
            end else begin
                instruction_o <= instruction_i;
                imm_o <= imm;
                pc_plus_o <= pc_plus_internal;
                branch_prediction_o <= jump;
            end
        end
    end

endmodule
