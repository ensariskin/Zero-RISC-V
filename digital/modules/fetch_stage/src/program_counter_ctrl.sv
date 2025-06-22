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
	input  logic jump,
	input  logic jalr,
	input  logic [size-1 : 0] imm_i,
	input  logic [size-1 : 0] correct_pc,
	input  logic 			  misprediction,
	output logic [size-1 : 0] pc_addr,
	output logic [size-1 : 0] pc_save);

    logic [size-1 : 0] pc_current_val;
    logic [size-1 : 0] pc_new_val;
	logic [size-1 : 0] pc_plus_four;
   	logic [size-1 : 0] pc_plus_imm;
	logic [size-1 : 0] pc_plus;

	// TODO : what shhould be the value of pc_new_val when jalr is 1?
	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			pc_current_val <= {size{1'b0}};
		end else if (!buble) begin
			pc_current_val <= pc_new_val;
		end
	end

	assign pc_plus_four = pc_current_val + 32'd1; // 32'd4
	assign pc_plus_imm  = pc_current_val + imm_i; // TODO : What if pc + imm is not fit in size bits?

	parametric_mux #(.mem_width(size), .mem_depth(2)) immeadiate_mux(  // next pc value
		.addr(jump),
		.data_in({pc_plus_imm, pc_plus_four}),
		.data_out(pc_plus));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(         // pc value to save
		.addr(jump| jalr),
		.data_in({pc_plus_four, pc_plus_imm}),
		.data_out(pc_save));

	parametric_mux #(.mem_width(size), .mem_depth(2)) correction_mux(  // correct pc value in case of branch misprediction
		.addr(misprediction),
		.data_in({correct_pc, pc_plus}),
		.data_out(pc_new_val));

	assign pc_addr = pc_current_val;

endmodule
