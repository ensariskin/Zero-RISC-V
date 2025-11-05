`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 02:07:03
// Design Name:
// Module Name: Branch_predictor
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


module jump_controller_super #(parameter size = 32)(
	input  logic clk,
	input  logic reset,

	// instruction and pc interface
	input  logic [size-1 : 0] current_pc_0,
	input  logic [size-1 : 0] current_pc_1,
	input  logic [size-1 : 0] current_pc_2,
	input  logic [size-1 : 0] current_pc_3,
	input  logic [size-1 : 0] current_pc_4,

	input  logic [size-1 : 0] instruction_0,
	input  logic [size-1 : 0] instruction_1,
	input  logic [size-1 : 0] instruction_2,
	input  logic [size-1 : 0] instruction_3,
	input  logic [size-1 : 0] instruction_4,

   // update prediction interface TODO : I am not sure if we need 3 ports here. Maybe less will be enough
   input  logic [size-1 : 0] update_prediction_pc_0,
	input  logic [size-1 : 0] update_prediction_pc_1,
	input  logic [size-1 : 0] update_prediction_pc_2,

	input  logic update_prediction_valid_i_0,
	input  logic update_prediction_valid_i_1,
	input  logic update_prediction_valid_i_2,

	input  logic misprediction_0, 
	input  logic misprediction_1,
	input  logic misprediction_2,

	// Correct PC interface (for JALR predictor updates)
	input  logic [size-1 : 0] correct_pc_0,
	input  logic [size-1 : 0] correct_pc_1,
	input  logic [size-1 : 0] correct_pc_2,

	// decision interface 
   output logic jump_0, // 1 : taken , 0 : not taken
	output logic jump_1, // 1 : taken , 0 : not taken
	output logic jump_2, // 1 : taken , 0 : not taken
	output logic jump_3, // 1 : taken , 0 : not taken
	output logic jump_4, // 1 : taken , 0 : not taken

	output logic jalr_0,
	output logic jalr_1,
	output logic jalr_2,
	output logic jalr_3,
	output logic jalr_4,

	output logic jalr_prediction_valid,
	output logic [size-1:0] jalr_prediction_target

	);
	
	logic j_type_0;
	logic b_type_0;
	logic branch_taken_0;
	logic j_type_1;
	logic b_type_1;
	logic branch_taken_1;
	logic j_type_2;
	logic b_type_2;
	logic branch_taken_2;
	logic j_type_3;
	logic b_type_3;
	logic branch_taken_3;
	logic j_type_4;
	logic b_type_4;
	logic branch_taken_4;


	assign j_type_0 = instruction_0[6:0] === 7'b1101111; // JAL instruction
	assign b_type_0 = instruction_0[6:0] === 7'b1100011; // B-type instructions

	assign j_type_1 = instruction_1[6:0] === 7'b1101111; // JAL instruction
	assign b_type_1 = instruction_1[6:0] === 7'b1100011; // B-type instructions

	assign j_type_2 = instruction_2[6:0] === 7'b1101111; // JAL instruction
	assign b_type_2 = instruction_2[6:0] === 7'b1100011; // B-type instructions

	assign j_type_3 = instruction_3[6:0] === 7'b1101111; // JAL instruction
	assign b_type_3 = instruction_3[6:0] === 7'b1100011; // B-type instructions

	assign j_type_4 = instruction_4[6:0] === 7'b1101111; // JAL instruction
	assign b_type_4 = instruction_4[6:0] === 7'b1100011; // B-type instructions


	assign jump_0 = j_type_0 | (b_type_0 & branch_taken_0);
	assign jalr_0 = instruction_0[6:0] === 7'b1100111; // JALR instruction

	assign jump_1 = j_type_1 | (b_type_1 & branch_taken_1);
	assign jalr_1 = instruction_1[6:0] === 7'b1100111; // JALR instruction

	assign jump_2= j_type_2 | (b_type_2 & branch_taken_2);
	assign jalr_2 = instruction_2[6:0] === 7'b1100111; // JALR instruction

	assign jump_3 = j_type_3 | (b_type_3 & branch_taken_3);
	assign jalr_3 = instruction_3[6:0] === 7'b1100111; // JALR instruction

	assign jump_4 = j_type_4 | (b_type_4 & branch_taken_4);
	assign jalr_4 = instruction_4[6:0] === 7'b1100111; // JALR instruction

	// Instantiate branch predictor
	branch_predictor_super #(.ADDR_WIDTH(32),.ENTRIES(32)) branch_predictor_inst (
		.clk(clk),
		.reset(reset),

		.current_pc_0(current_pc_0),
		.is_branch_i_0(b_type_0),
		.current_pc_1(current_pc_1),
		.is_branch_i_1(b_type_1),
		.current_pc_2(current_pc_2),
		.is_branch_i_2(b_type_2),
		.current_pc_3(current_pc_3),
		.is_branch_i_3(b_type_3),
		.current_pc_4(current_pc_4),
		.is_branch_i_4(b_type_4),
		
		.branch_taken_o_0(branch_taken_0),
		.branch_taken_o_1(branch_taken_1),
		.branch_taken_o_2(branch_taken_2),
		.branch_taken_o_3(branch_taken_3),
		.branch_taken_o_4(branch_taken_4),

		.update_prediction_pc_0(update_prediction_pc_0),
		.update_prediction_valid_i_0(update_prediction_valid_i_0),
		.misprediction_0(misprediction_0),
		.update_prediction_pc_1(update_prediction_pc_1),
		.update_prediction_valid_i_1(update_prediction_valid_i_1),
		.misprediction_1(misprediction_1),
		.update_prediction_pc_2(update_prediction_pc_2),
		.update_prediction_valid_i_2(update_prediction_valid_i_2),
		.misprediction_2(misprediction_2)
	);

	// Instantiate JALR predictor

	jalr_predictor #(
		.ADDR_WIDTH(32),
		.ENTRIES(16)
	) jalr_predictor_inst (
		.clk(clk),
		.reset(reset),

		// Lookup interface
		.current_pc_0(current_pc_0),
		.current_pc_1(current_pc_1),
		.current_pc_2(current_pc_2),
		.current_pc_3(current_pc_3),
		.current_pc_4(current_pc_4),

		.is_jalr_i_0(jalr_0),
		.is_jalr_i_1(jalr_1),
		.is_jalr_i_2(jalr_2),
		.is_jalr_i_3(jalr_3),
		.is_jalr_i_4(jalr_4),

		// Prediction output
		.jalr_prediction_valid_o(jalr_prediction_valid),
		.jalr_prediction_target_o(jalr_prediction_target),

		// Update interface
		.update_prediction_pc_0(update_prediction_pc_0),
		.update_prediction_valid_i_0(update_prediction_valid_i_0),
		.misprediction_0(misprediction_0),
		.correct_pc_0(correct_pc_0),

		.update_prediction_pc_1(update_prediction_pc_1),
		.update_prediction_valid_i_1(update_prediction_valid_i_1),
		.misprediction_1(misprediction_1),
		.correct_pc_1(correct_pc_1),

		.update_prediction_pc_2(update_prediction_pc_2),
		.update_prediction_valid_i_2(update_prediction_valid_i_2),
		.misprediction_2(misprediction_2),
		.correct_pc_2(correct_pc_2)
	);
	
endmodule
