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


module jump_controller #(parameter size = 32)(
	input  logic clk,
	input  logic reset,
	input  logic [size-1 : 0] current_pc,
   input  logic [size-1 : 0] instruction,
   input  logic [size-1 : 0] update_prediction_pc,
	input  logic update_prediction_valid_i,
	input  logic misprediction, 
   output logic jump, // 1 : taken , 0 : not taken
	output logic jalr);

	logic j_type;
	logic b_type;
	logic branch_taken;

	assign j_type = instruction[6:0] === 7'b1101111; // JAL instruction
	assign b_type = instruction[6:0] === 7'b1100011; // B-type instructions

   assign jump = j_type | (b_type & branch_taken);
	assign jalr = instruction[6:0] === 7'b1100111; // JALR instruction

	branch_predictor #(.ADDR_WIDTH(32),.ENTRIES(32)) branch_predictor(
		.clk(clk),
		.reset(reset),
		.current_pc(current_pc),
		.is_branch_i(b_type),
		.branch_taken_o(branch_taken),
		.update_prediction_pc(update_prediction_pc),
		.update_prediction_valid_i(update_prediction_valid_i),
		.misprediction(misprediction)
	);

endmodule
