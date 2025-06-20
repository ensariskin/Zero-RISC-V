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
	input  logic MPC,
	input  logic JALR,
	input  logic [size-1 : 0] IMM,
	input  logic [size-1 : 0] Correct_PC,
	input  logic isValid,
	output logic [size-1 : 0] PC_Addr,
	output logic [size-1 : 0] PC_save);

    wire [size-1 : 0] PC_current_val;
    wire [size-1 : 0] PC_new_val;
	wire [size-1 : 0] PC_plus_four;
   	wire [size-1 : 0] PC_plus_imm;
	wire [size-1 : 0] PC_plus;

	D_FF_async_rst #(.mem_width(size)) pc_reg(
		.clk(clk),
        .reset(reset),
        .Rin(PC_new_val),
        .we(~buble),
        .Rout(PC_current_val));


	assign PC_plus_four = PC_current_val + 32'd1; // 32'd4
	assign PC_plus_imm  = PC_current_val + IMM;


	parametric_mux #(.mem_width(size), .mem_depth(2)) immeadiate_mux(  // next pc value
		.addr(MPC),
		.data_in({PC_plus_imm, PC_plus_four}),
		.data_out(PC_plus));

	parametric_mux #(.mem_width(size), .mem_depth(2)) out_mux(         // pc value to save
		.addr(MPC|JALR),
		.data_in({PC_plus_four, PC_plus_imm}),
		.data_out(PC_save));

	parametric_mux #(.mem_width(size), .mem_depth(2)) correction_mux(  // correct pc value in case of branch misprediction
		.addr(isValid),
		.data_in({PC_plus, Correct_PC}),
		.data_out(PC_new_val));

	assign PC_Addr = PC_current_val;

endmodule
