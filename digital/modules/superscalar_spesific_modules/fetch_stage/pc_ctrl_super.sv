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


module pc_ctrl_super #(parameter size = 32)(
	input  logic clk,
	input  logic reset,
	input  logic buble,
	input  logic parallel_mode,

	//input  logic instruction_valid_0,
	//input  logic instruction_valid_1,
	//input  logic instruction_valid_2,

	input  logic jump_0,
	input  logic jump_1,
	input  logic jump_2,

	input  logic jalr_0,	
	input  logic jalr_1,
	input  logic jalr_2,

	input  logic [size-1 : 0] imm_i_0,
	input  logic [size-1 : 0] imm_i_1,
	input  logic [size-1 : 0] imm_i_2,

	input  logic 			     misprediction,
	input  logic [size-1 : 0] correct_pc,

	output logic [size-1 : 0] inst_addr_0,
	output logic [size-1 : 0] inst_addr_1,
	output logic [size-1 : 0] inst_addr_2,

	output logic [size-1 : 0] current_pc_0,
	output logic [size-1 : 0] current_pc_1,
	output logic [size-1 : 0] current_pc_2,

	output logic [size-1 : 0] pc_save_0,
	output logic [size-1 : 0] pc_save_1,
	output logic [size-1 : 0] pc_save_2);

	localparam D = 1; // Delay for simulation purposes

   logic [size-1 : 0] pc_current_val;
   logic [size-1 : 0] pc_new_val;
	logic [size-1 : 0] pc_plus_four_0;
	logic [size-1 : 0] pc_plus_four_1;
	logic [size-1 : 0] pc_plus_four_2;
	logic [size-1 : 0] pc_plus_incr;
	logic [size-1 : 0] pc_plus_imm;
   logic [size-1 : 0] pc_plus_imm_0;
	logic [size-1 : 0] pc_plus_imm_1;
	logic [size-1 : 0] pc_plus_imm_2;
	logic [size-1 : 0] rs1_plus_imm_prediction;
	logic [size-1 : 0] rs1_plus_imm_prediction_0;
	logic [size-1 : 0] rs1_plus_imm_prediction_1;
	logic [size-1 : 0] rs1_plus_imm_prediction_2;
	logic [size-1 : 0] pc_plus;
	logic [3      : 0] increment_value;
	logic					 jalr;
	logic              jump;

   assign increment_value = parallel_mode ? 4'd12 : 4'd4;  
	assign jalr = jalr_0 | (!jump_0 & jalr_1) | (!jump_0 & !jump_1 & jalr_2);
	assign jump = jump_0 | jump_1 | jump_2;  

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
		else begin
			rs1_plus_imm_prediction = 32'd0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			pc_current_val <= #D 32'h00000000; // Reset PC to a known value, e.g., 0x80000000
		end else if (~buble) begin
			pc_current_val <= #D pc_new_val;
		end else if (misprediction) begin
			pc_current_val <= #D pc_new_val;
		end
	end

	assign pc_plus_four_0 = pc_current_val + 32'd4; 
	assign pc_plus_four_1 = parallel_mode ? pc_current_val + 32'd8 : pc_plus_four_0;
	assign pc_plus_four_2 = parallel_mode ? pc_current_val + 32'd12 : pc_plus_four_0;

	assign pc_plus_incr = pc_current_val + increment_value; 
	assign pc_plus_imm_0  = current_pc_0 + {imm_i_0[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	assign pc_plus_imm_1  = current_pc_1 + {imm_i_1[31:2], 2'b00}; // prevent misalignment issues, don't use 2 LSBs
	assign pc_plus_imm_2  = current_pc_2 + {imm_i_2[31:2], 2'b00}; // prevent misalignment issues, don't use 2 L
	
	// TODO : use rs1 value instead of pc_current_val, how can we predict rs1 value? or should we wait until execuete stage calculate correct result
	assign rs1_plus_imm_prediction_0 = current_pc_0 + {imm_i_0[31:2], 2'b00};
	assign rs1_plus_imm_prediction_1 = current_pc_1 + {imm_i_1[31:2], 2'b00};
	assign rs1_plus_imm_prediction_2 = current_pc_2 + {imm_i_2[31:2], 2'b00};

	// next pc value, 
	// TODO : handle jalr case
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
	
	assign inst_addr_0 = reset ? (misprediction? pc_new_val : buble? pc_current_val : pc_new_val) : 32'h00000000;
	assign inst_addr_1 = parallel_mode ? inst_addr_0 + 32'd4 : inst_addr_0;
	assign inst_addr_2 = parallel_mode ? inst_addr_0 + 32'd8 : inst_addr_0;
	assign current_pc_0 = pc_current_val;
	assign current_pc_1 = parallel_mode ? pc_current_val + 32'd4 : current_pc_0;
	assign current_pc_2 = parallel_mode ? pc_current_val + 32'd8 : current_pc_0;

	// TODO : We can store some pc values in case of JAL, JALR instruction then we can use them in case of new JALR calculation

endmodule
