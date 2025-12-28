`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 01:50:25
// Design Name:
// Module Name: PC_new
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


module pc_ctrl_super #(parameter size = 32, parameter RESET_PC = 32'h80000000)
	(
		input  logic clk,
		input  logic reset,
		input  logic buble,
		input  logic secure_mode,

		//input  logic instruction_valid_0,
		//input  logic instruction_valid_1,
		//input  logic instruction_valid_2,

		input  logic jump_0,
		input  logic jump_1,
		input  logic jump_2,
		input  logic jump_3,
		input  logic jump_4,

		input  logic jalr_0,
		input  logic jalr_1,
		input  logic jalr_2,
		input  logic jalr_3,
		input  logic jalr_4,

		input  logic jalr_prediction_valid,
		input  logic [size-1:0] jalr_prediction_target,

		input  logic [size-1 : 0] imm_i_0,
		input  logic [size-1 : 0] imm_i_1,
		input  logic [size-1 : 0] imm_i_2,
		input  logic [size-1 : 0] imm_i_3,
		input  logic [size-1 : 0] imm_i_4,

		input  logic              misprediction,
		input  logic [size-1 : 0] correct_pc,

		output logic [size-1 : 0] inst_addr_0,
		output logic [size-1 : 0] inst_addr_1,
		output logic [size-1 : 0] inst_addr_2,
		output logic [size-1 : 0] inst_addr_3,
		output logic [size-1 : 0] inst_addr_4,

		output logic [size-1 : 0] current_pc_0,
		output logic [size-1 : 0] current_pc_1,
		output logic [size-1 : 0] current_pc_2,
		output logic [size-1 : 0] current_pc_3,
		output logic [size-1 : 0] current_pc_4,

		output logic [size-1 : 0] pc_save_0,
		output logic [size-1 : 0] pc_save_1,
		output logic [size-1 : 0] pc_save_2,
		output logic [size-1 : 0] pc_save_3,
		output logic [size-1 : 0] pc_save_4,

		// TMR Fatal Error
		output logic fatal_o
	);

	localparam D = 1; // Delay for simulation purposes

	// TMR Registers for PC
	logic [size-1 : 0] pc_current_val;    // Voted Output
	logic [size-1 : 0] pc_current_val_0;  // Replica 0
	logic [size-1 : 0] pc_current_val_1;  // Replica 1
	logic [size-1 : 0] pc_current_val_2;  // Replica 2

	// Voter Signals
	logic [size-1 : 0] correct_pc_voted;
	logic mismatch_detected;
	logic error_0, error_1, error_2, fatal_error;

	// Instantiate TMR Voter
	tmr_voter #(.DATA_WIDTH(size)) pc_voter (
		.secure_mode_i(secure_mode),
		.data_0_i(pc_current_val_0),
		.data_1_i(pc_current_val_1),
		.data_2_i(pc_current_val_2),
		.data_o(correct_pc_voted),
		.mismatch_detected_o(mismatch_detected),
		.error_0_o(error_0),
		.error_1_o(error_1),
		.error_2_o(error_2),
		.fatal_error_o(fatal_error) // Can be connected to a fault handler later
	);

	// In logic, use correct_pc_voted as the effective "pc_current_val"
	assign pc_current_val = correct_pc_voted;
	logic [size-1 : 0] pc_new_val;
	logic [size-1 : 0] pc_plus_four_0;
	logic [size-1 : 0] pc_plus_four_1;
	logic [size-1 : 0] pc_plus_four_2;
	logic [size-1 : 0] pc_plus_four_3;
	logic [size-1 : 0] pc_plus_four_4;
	logic [size-1 : 0] pc_plus_incr;
	logic [size-1 : 0] pc_plus_imm;
	logic [size-1 : 0] pc_plus_imm_0;
	logic [size-1 : 0] pc_plus_imm_1;
	logic [size-1 : 0] pc_plus_imm_2;
	logic [size-1 : 0] pc_plus_imm_3;
	logic [size-1 : 0] pc_plus_imm_4;
	logic [size-1 : 0] rs1_plus_imm_prediction;
	logic [size-1 : 0] rs1_plus_imm_prediction_0;
	logic [size-1 : 0] rs1_plus_imm_prediction_1;
	logic [size-1 : 0] rs1_plus_imm_prediction_2;
	logic [size-1 : 0] rs1_plus_imm_prediction_3;
	logic [size-1 : 0] rs1_plus_imm_prediction_4;

	logic [size-1 : 0] pc_plus;
	logic [4      : 0] increment_value;
	logic              jalr;
	logic              jump;

	assign increment_value = 5'd20;
	assign jalr = jalr_0 | (!jump_0 & jalr_1) | (!jump_0 & !jump_1 & jalr_2) | (!jump_0 & !jump_1 & !jump_2 & jalr_3) | (!jump_0 & !jump_1 & !jump_2 & !jump_3 & jalr_4);
	assign jump = jump_0 | jump_1 | jump_2 | jump_3 | jump_4;

	always_comb begin
		if(jump_0) begin
			pc_plus_imm = pc_plus_imm_0;
		end
		else if(jump_1) begin
			pc_plus_imm = pc_plus_imm_1;
		end
		else if(jump_2) begin
			pc_plus_imm = pc_plus_imm_2;
		end
		else if(jump_3) begin
			pc_plus_imm = pc_plus_imm_3;
		end
		else if(jump_4) begin
			pc_plus_imm = pc_plus_imm_4;
		end
		else begin
			pc_plus_imm = 32'd0;
		end
	end

	always_comb begin
		if(jalr_0) begin
			rs1_plus_imm_prediction = rs1_plus_imm_prediction_0;
		end
		else if(jalr_1) begin
			rs1_plus_imm_prediction = rs1_plus_imm_prediction_1;
		end
		else if(jalr_2) begin
			rs1_plus_imm_prediction = rs1_plus_imm_prediction_2;
		end
		else if(jalr_3) begin
			rs1_plus_imm_prediction = rs1_plus_imm_prediction_3;
		end
		else if(jalr_4) begin
			rs1_plus_imm_prediction = rs1_plus_imm_prediction_4;
		end
		else begin
			rs1_plus_imm_prediction = 32'd0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			pc_current_val_0 <= #D RESET_PC;
			pc_current_val_1 <= #D RESET_PC;
			pc_current_val_2 <= #D RESET_PC;
		end else if (~buble) begin
			// Normal Update or Healing
			// If mismatch detected in previous cycle, the voter output (correct_pc_voted)
			// effectively "heals" the state by feeding into the calculation of pc_new_val logic
			// and then being written back to ALL copies.
			// Ideally for strict TMR, we might want independent next state logic,
			// but here the next state depends on the voted current state (pc_new_val derived from voted val).
			// So writing the same `pc_new_val` to all 3 restores sync.
			pc_current_val_0 <= #D pc_new_val;
			pc_current_val_1 <= #D pc_new_val;
			pc_current_val_2 <= #D pc_new_val;
		end else if (misprediction) begin
			pc_current_val_0 <= #D pc_new_val;
			pc_current_val_1 <= #D pc_new_val;
			pc_current_val_2 <= #D pc_new_val;
		end else if (secure_mode && mismatch_detected) begin
			// Case: Bubble is present (pipeline stalled), but we detected a mismatch.
			// We MUST correct the registers to match the voted output to prevent latent faults.
			pc_current_val_0 <= #D correct_pc_voted;
			pc_current_val_1 <= #D correct_pc_voted;
			pc_current_val_2 <= #D correct_pc_voted;
		end
	end

	assign pc_plus_four_0 = pc_current_val + 32'd4;
	assign pc_plus_four_1 = pc_current_val + 32'd8;
	assign pc_plus_four_2 = pc_current_val + 32'd12;
	assign pc_plus_four_3 = pc_current_val + 32'd16;
	assign pc_plus_four_4 = pc_current_val + 32'd20;

	assign pc_plus_incr   = pc_current_val + increment_value;
	assign pc_plus_imm_0  = current_pc_0 + {imm_i_0[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	assign pc_plus_imm_1  = current_pc_1 + {imm_i_1[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	assign pc_plus_imm_2  = current_pc_2 + {imm_i_2[31:2], 2'b00}; // prevent misalignment issues, don't use 2 L
	assign pc_plus_imm_3  = current_pc_3 + {imm_i_3[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	assign pc_plus_imm_4  = current_pc_4 + {imm_i_4[31:2], 2'b00}; // prevent misalignment issues, don't use 2

	assign rs1_plus_imm_prediction_0 = jalr_prediction_valid ? jalr_prediction_target : current_pc_0 + 4;
	assign rs1_plus_imm_prediction_1 = jalr_prediction_valid ? jalr_prediction_target : current_pc_1 + 4;
	assign rs1_plus_imm_prediction_2 = jalr_prediction_valid ? jalr_prediction_target : current_pc_2 + 4;
	assign rs1_plus_imm_prediction_3 = jalr_prediction_valid ? jalr_prediction_target : current_pc_3 + 4;
	assign rs1_plus_imm_prediction_4 = jalr_prediction_valid ? jalr_prediction_target : current_pc_4 + 4;

	// next pc value,
	parametric_mux #(.mem_width(size), .mem_depth(4)) immeadiate_mux(
		.addr({jalr, jump}),
		.data_in({rs1_plus_imm_prediction, rs1_plus_imm_prediction, pc_plus_imm, pc_plus_incr}),
		.data_out(pc_plus));

	parametric_mux #(.mem_width(size), .mem_depth(2)) correction_mux(  // correct pc value in case of branch misprediction
		.addr(misprediction),
		.data_in({correct_pc, pc_plus}),
		.data_out(pc_new_val));

	// pc value to save, if JAL or JALR save PC + 4, if auipc save PC + imm
	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(
		.addr(jump_0| jalr_0),
		.data_in({pc_plus_four_0, pc_plus_imm_0}),
		.data_out(pc_save_0));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux_1(
		.addr(jump_1| jalr_1),
		.data_in({pc_plus_four_1, pc_plus_imm_1}),
		.data_out(pc_save_1));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux_2(
		.addr(jump_2| jalr_2),
		.data_in({pc_plus_four_2, pc_plus_imm_2}),
		.data_out(pc_save_2));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux_3(
		.addr(jump_3| jalr_3),
		.data_in({pc_plus_four_3, pc_plus_imm_3}),
		.data_out(pc_save_3));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux_4(
		.addr(jump_4| jalr_4),
		.data_in({pc_plus_four_4, pc_plus_imm_4}),
		.data_out(pc_save_4));

	assign inst_addr_0 = reset ? (misprediction? pc_new_val : buble? pc_current_val : pc_new_val) : RESET_PC;
	assign inst_addr_1 = inst_addr_0 + 32'd4;
	assign inst_addr_2 = inst_addr_0 + 32'd8;
	assign inst_addr_3 = inst_addr_0 + 32'd12;
	assign inst_addr_4 = inst_addr_0 + 32'd16;
	assign current_pc_0 = pc_current_val;
	assign current_pc_1 = pc_current_val + 32'd4;
	assign current_pc_2 = pc_current_val + 32'd8;
	assign current_pc_3 = pc_current_val + 32'd12;
	assign current_pc_4 = pc_current_val + 32'd16;

	// TODO : We can store some pc values in case of JAL, JALR instruction then we can use them in case of new JALR calculation


	assign fatal_o = fatal_error;

endmodule
