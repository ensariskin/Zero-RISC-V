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

	input  logic [size-1 : 0] instruction_0,
	input  logic [size-1 : 0] instruction_1,
	input  logic [size-1 : 0] instruction_2,

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

	// decision interface 
   output logic jump_0, // 1 : taken , 0 : not taken
	output logic jump_1, // 1 : taken , 0 : not taken
	output logic jump_2, // 1 : taken , 0 : not taken

	output logic jalr_0,
	output logic jalr_1,
	output logic jalr_2
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
	
	// Registered jump decisions to break combinational loop
	logic jump_0_reg, jump_1_reg, jump_2_reg;
	logic jalr_0_reg, jalr_1_reg, jalr_2_reg;

	assign j_type_0 = instruction_0[6:0] === 7'b1101111; // JAL instruction
	assign b_type_0 = instruction_0[6:0] === 7'b1100011; // B-type instructions

	assign j_type_1 = instruction_1[6:0] === 7'b1101111; // JAL instruction
	assign b_type_1 = instruction_1[6:0] === 7'b1100011; // B-type instructions

	assign j_type_2 = instruction_2[6:0] === 7'b1101111; // JAL instruction
	assign b_type_2 = instruction_2[6:0] === 7'b1100011; // B-type instructions

	// Combinational logic for current cycle decisions (not used for PC calc)
	logic jump_0_next, jump_1_next, jump_2_next;
	logic jalr_0_next, jalr_1_next, jalr_2_next;
	
	assign jump_0_next = j_type_0 | (b_type_0 & branch_taken_0);
	assign jalr_0_next = instruction_0[6:0] === 7'b1100111; // JALR instruction

	assign jump_1_next = j_type_1 | (b_type_1 & branch_taken_1);
	assign jalr_1_next = instruction_1[6:0] === 7'b1100111; // JALR instruction

	assign jump_2_next = j_type_2 | (b_type_2 & branch_taken_2);
	assign jalr_2_next = instruction_2[6:0] === 7'b1100111; // JALR instruction
	
	// Register jump decisions to use in next cycle (breaks combinational loop)
	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			jump_0_reg <= 1'b0;
			jump_1_reg <= 1'b0;
			jump_2_reg <= 1'b0;
			jalr_0_reg <= 1'b0;
			jalr_1_reg <= 1'b0;
			jalr_2_reg <= 1'b0;
		end else begin
			jump_0_reg <= jump_0_next;
			jump_1_reg <= jump_1_next;
			jump_2_reg <= jump_2_next;
			jalr_0_reg <= jalr_0_next;
			jalr_1_reg <= jalr_1_next;
			jalr_2_reg <= jalr_2_next;
		end
	end

	// Use registered values for PC calculation (breaks loop)
	assign jump_0 = jump_0_reg;
	assign jalr_0 = jalr_0_reg;

	assign jump_1 = jump_1_reg;
	assign jalr_1 = jalr_1_reg;

	assign jump_2 = jump_2_reg;
	assign jalr_2 = jalr_2_reg;

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
		
		.branch_taken_o_0(branch_taken_0),
		.branch_taken_o_1(branch_taken_1),
		.branch_taken_o_2(branch_taken_2),

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
	
endmodule
