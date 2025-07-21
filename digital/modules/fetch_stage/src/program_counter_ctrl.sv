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


module program_counter_ctrl #(parameter size = 32)(
	input  logic clk,
	input  logic reset,
	input  logic buble,
	input  logic instruction_valid, 
	input  logic jump,
	input  logic jalr,

	input  logic [size-1 : 0] imm_i,
	input  logic [size-1 : 0] correct_pc,
	input  logic 			     misprediction,
	output logic [size-1 : 0] inst_addr,
	output logic [size-1 : 0] current_pc,
	output logic [size-1 : 0] pc_save);

	localparam D = 1; // Delay for simulation purposes

   logic [size-1 : 0] pc_current_val;
   logic [size-1 : 0] pc_new_val;
	logic [size-1 : 0] pc_plus_four;
   logic [size-1 : 0] pc_plus_imm;
	logic [size-1 : 0] rs1_plus_imm_prediction;
	logic [size-1 : 0] pc_plus;


	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			pc_current_val <= #D 32'h80000000; // Reset PC to a known value, e.g., 0x80000000
		end else if (~buble) begin
			pc_current_val <= #D pc_new_val;
		end
	end

	assign pc_plus_four = pc_current_val + 32'd4; // 32'd4
	assign pc_plus_imm  = pc_current_val + {imm_i[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	// TODO : use rs1 value instead of pc_current_val, how can we predict rs1 value? or should we wait until execuete stage calculate correct result
	assign rs1_plus_imm_prediction = pc_current_val + {imm_i[31:2], 2'b00};

	// next pc value, TODO : handle jalr case
	parametric_mux #(.mem_width(size), .mem_depth(4)) immeadiate_mux(
		.addr({jalr, jump}),
		.data_in({rs1_plus_imm_prediction, rs1_plus_imm_prediction, pc_plus_imm, pc_plus_four}),
		.data_out(pc_plus));


	// pc value to save, if JAL or JALR save PC + 4, if auipc save PC + imm
	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(
		.addr(jump| jalr),
		.data_in({pc_plus_four, pc_plus_imm}),
		.data_out(pc_save));

	parametric_mux #(.mem_width(size), .mem_depth(2)) correction_mux(  // correct pc value in case of branch misprediction
		.addr(misprediction),
		.data_in({correct_pc, pc_plus}),
		.data_out(pc_new_val));

	assign inst_addr = reset ? (buble? pc_current_val : pc_new_val) : 32'h80000000;
	assign current_pc = pc_current_val;

	// TODO : We can store some pc values in case of JAL, JALR instruction then we can use them in case of new JALR calculation

endmodule
