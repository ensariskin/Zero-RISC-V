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


module jump_controller_super #( 
	 parameter size = 32,
	 parameter ENTRIES = 32,                        // Number of predictor entries
    parameter INDEX_WIDTH = $clog2(ENTRIES)       // Auto-calculated index width
)(
	input  logic clk,
	input  logic reset,
	input  logic base_valid_i,
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

   // update prediction interface 
   input  logic [size-1 : 0] update_prediction_pc_0,
	input  logic [size-1 : 0] update_prediction_pc_1,
	input  logic [size-1 : 0] update_prediction_pc_2,

	input  logic update_prediction_valid_i_0,
	input  logic update_prediction_valid_i_1,
	input  logic update_prediction_valid_i_2,

	input  logic misprediction_0, 
	input  logic misprediction_1,
	input  logic misprediction_2,

	input  logic [INDEX_WIDTH:0] update_global_history_0,
	input  logic [INDEX_WIDTH:0] update_global_history_1,
	input  logic [INDEX_WIDTH:0] update_global_history_2,

	// Correct PC interface (for branch predictor updates)
	input  logic [size-1 : 0] correct_pc_0,
	input  logic [size-1 : 0] correct_pc_1,
	input  logic [size-1 : 0] correct_pc_2,

	// JALR predictor update signals for FU0
	input logic jalr_update_valid_0,
	input logic [size-1 : 0] jalr_update_prediction_pc_0,

	// JALR predictor update signals for FU1
	input logic jalr_update_valid_1,
	input logic [size-1 : 0] jalr_update_prediction_pc_1,

	// JALR predictor update signals for FU2
	input logic jalr_update_valid_2,
	input logic [size-1 : 0] jalr_update_prediction_pc_2,

	//RAS restore interface
	input logic ras_restore_en_i,
	input logic [2:0] ras_restore_tos_i,
	output logic [2:0] ras_tos_checkpoint_o,

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

	output logic [INDEX_WIDTH:0] global_history_0_o, // Current global history and prediction
	output logic [INDEX_WIDTH:0] global_history_1_o, 
	output logic [INDEX_WIDTH:0] global_history_2_o, 
	output logic [INDEX_WIDTH:0] global_history_3_o, 
	output logic [INDEX_WIDTH:0] global_history_4_o, 

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

	logic block_0;  // Invalidate inst_1 and inst_2 if inst_0 branches
   logic block_1;    // Invalidate inst_2 if inst_1 branches
   logic block_2;    
   logic block_3;  

	// Branch prediction invalidation logic
   assign block_0 = jump_0 | jalr_0 | ~base_valid_i;  // If inst_0 is predicted taken, invalidate inst_1 and inst_2
   assign block_1 = jump_1 | jalr_1 | ~base_valid_i;    // If inst_1 is predicted taken, invalidate inst_2
   assign block_2 = jump_2 | jalr_2 | ~base_valid_i;
   assign block_3 = jump_3 | jalr_3 | ~base_valid_i;


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

	// CALL RETURN Detection for RAS
	logic is_call_0, is_call_1, is_call_2, is_call_3, is_call_4;
	logic is_return_0, is_return_1, is_return_2, is_return_3, is_return_4;

	assign is_call_0 = (j_type_0 || jalr_0) && (instruction_0[11:7] == 5'd1 || instruction_0[11:7] == 5'd5) & base_valid_i; // rd == x1 or x5
	assign is_call_1 = (j_type_1 || jalr_1) && (instruction_1[11:7] == 5'd1 || instruction_1[11:7] == 5'd5) & ~block_0;                 
	assign is_call_2 = (j_type_2 || jalr_2) && (instruction_2[11:7] == 5'd1 || instruction_2[11:7] == 5'd5) & ~block_0 & ~block_1;  
	assign is_call_3 = (j_type_3 || jalr_3) && (instruction_3[11:7] == 5'd1 || instruction_3[11:7] == 5'd5) & ~block_0 & ~block_1 & ~block_2;
	assign is_call_4 = (j_type_4 || jalr_4) && (instruction_4[11:7] == 5'd1 || instruction_4[11:7] == 5'd5) & ~block_0 & ~block_1 & ~block_2 & ~block_3;

	assign is_return_0 = jalr_0 && (instruction_0[19:15] == 5'd1 || instruction_0[19:15] == 5'd5) && (instruction_0[11:7] == 5'd0) & base_valid_i; // rs1 == x1 or x5 and rd == x0
	assign is_return_1 = jalr_1 && (instruction_1[19:15] == 5'd1 || instruction_1[19:15] == 5'd5) && (instruction_1[11:7] == 5'd0) & ~block_0;
	assign is_return_2 = jalr_2 && (instruction_2[19:15] == 5'd1 || instruction_2[19:15] == 5'd5) && (instruction_2[11:7] == 5'd0) & ~block_0 & ~block_1;  
	assign is_return_3 = jalr_3 && (instruction_3[19:15] == 5'd1 || instruction_3[19:15] == 5'd5) && (instruction_3[11:7] == 5'd0) & ~block_0 & ~block_1 & ~block_2;
	assign is_return_4 = jalr_4 && (instruction_4[19:15] == 5'd1 || instruction_4[19:15] == 5'd5) && (instruction_4[11:7] == 5'd0) & ~block_0 & ~block_1 & ~block_2 & ~block_3;

	logic [size-1:0] call_return_addr_0;
	logic [size-1:0] call_return_addr_1;
	logic [size-1:0] call_return_addr_2;
	logic [size-1:0] call_return_addr_3;
	logic [size-1:0] call_return_addr_4;

	assign call_return_addr_0 = current_pc_0 + 32'd4;
	assign call_return_addr_1 = current_pc_1 + 32'd4;
	assign call_return_addr_2 = current_pc_2 + 32'd4;
	assign call_return_addr_3 = current_pc_3 + 32'd4;
	assign call_return_addr_4 = current_pc_4 + 32'd4;

	// Instantiate branch predictor
	//branch_predictor_super #(.ADDR_WIDTH(32),.ENTRIES(8192)) branch_predictor_inst (
	gshare_predictor_super #(.ADDR_WIDTH(size),.ENTRIES(ENTRIES)) gshare_predictor_inst (
		.clk(clk),
		.reset(reset),
		.base_valid(base_valid_i),

		.current_pc_0(current_pc_0),
		.is_branch_i_0(b_type_0),

		.current_pc_1(current_pc_1),
		.is_branch_i_1(b_type_1),
		.ignore_inst_1(b_type_1 & (j_type_0 | jalr_0)),

		.current_pc_2(current_pc_2),
		.is_branch_i_2(b_type_2),
		.ignore_inst_2(b_type_2 & (j_type_1 | jalr_1)),

		.current_pc_3(current_pc_3),
		.is_branch_i_3(b_type_3),
		.ignore_inst_3(b_type_3 & (j_type_2 | jalr_2)),

		.current_pc_4(current_pc_4),
		.is_branch_i_4(b_type_4),
		.ignore_inst_4(b_type_4 & (j_type_3 | jalr_3)),

		.branch_taken_o_0(branch_taken_0),
		.branch_taken_o_1(branch_taken_1),
		.branch_taken_o_2(branch_taken_2),
		.branch_taken_o_3(branch_taken_3),
		.branch_taken_o_4(branch_taken_4),

		.global_history_0_o,
		.global_history_1_o,
		.global_history_2_o,
		.global_history_3_o,
		.global_history_4_o,

		.update_prediction_pc_0(update_prediction_pc_0),
		.update_prediction_valid_i_0(update_prediction_valid_i_0),
		.misprediction_0(misprediction_0),
		.update_global_history_0, 

		.update_prediction_pc_1(update_prediction_pc_1),
		.update_prediction_valid_i_1(update_prediction_valid_i_1),
		.misprediction_1(misprediction_1),
		.update_global_history_1,
		
		.update_prediction_pc_2(update_prediction_pc_2),
		.update_prediction_valid_i_2(update_prediction_valid_i_2),
		.misprediction_2(misprediction_2),
		.update_global_history_2
	);

	// Instantiate JALR predictor

	jalr_predictor #(
		.ADDR_WIDTH(32),
		.CACHE_ENTRIES(32),
		.RAS_DEPTH(8)
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

		.is_call_0(is_call_0),
		.is_call_1(is_call_1),
		.is_call_2(is_call_2),
		.is_call_3(is_call_3),
		.is_call_4(is_call_4),

		.is_return_i_0(is_return_0),
		.is_return_i_1(is_return_1),
		.is_return_i_2(is_return_2),
		.is_return_i_3(is_return_3),
		.is_return_i_4(is_return_4),

		.call_return_addr_0(call_return_addr_0),
		.call_return_addr_1(call_return_addr_1),
		.call_return_addr_2(call_return_addr_2),
		.call_return_addr_3(call_return_addr_3),
		.call_return_addr_4(call_return_addr_4),

		.ras_restore_en_i(ras_restore_en_i),
		.ras_restore_tos_i(ras_restore_tos_i),
		.ras_tos_checkpoint_o(ras_tos_checkpoint_o),

		// Prediction output
		.jalr_prediction_valid_o(jalr_prediction_valid),
		.jalr_prediction_target_o(jalr_prediction_target),

		// Update interface - FU0
		.update_prediction_pc_0(jalr_update_prediction_pc_0),
		.update_prediction_valid_i_0(jalr_update_valid_0),
		.misprediction_0(misprediction_0),
		.correct_pc_0(correct_pc_0),

		// Update interface - FU1
		.update_prediction_pc_1(jalr_update_prediction_pc_1),
		.update_prediction_valid_i_1(jalr_update_valid_1),
		.misprediction_1(misprediction_1),
		.correct_pc_1(correct_pc_1),

		// Update interface - FU2
		.update_prediction_pc_2(jalr_update_prediction_pc_2),
		.update_prediction_valid_i_2(jalr_update_valid_2),
		.misprediction_2(misprediction_2),
		.correct_pc_2(correct_pc_2)
	);
	
endmodule
