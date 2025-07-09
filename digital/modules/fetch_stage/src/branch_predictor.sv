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
    input  logic [size-1 : 0] instruction,
    //input isValid, // wil be used to update the branch predictor state
    output logic jump, // 1 : taken , 0 : not taken
	output logic jalr);

	wire j_type;
	wire b_type;

	assign j_type = instruction[6:0] === 7'b1101111; // JAL instruction
	assign b_type = instruction[6:0] === 7'b1100011; // B-type instructions

   assign jump = j_type | (b_type & 1'b1);
	assign jalr = instruction[6:0] === 7'b1100111; // JALR instruction

endmodule
