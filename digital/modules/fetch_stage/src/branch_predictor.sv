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


module branch_predictor #(parameter size = 32)(
    input [size-1 : 0] instruction,
    input [size-1 : 0] IMM,
    input isValid, // wil be used to update the branch predictor state
    output branch_prediction, // 1 : taken , 0 : not taken
	output JALR);

	wire J;
	wire B;

	assign J = instruction[6] & instruction[5] & ~instruction[4] & instruction[3] & instruction[2];
	assign B = instruction[6] & instruction[5] & ~instruction[4] & ~instruction[3] & ~instruction[2];

    assign branch_prediction = J | (B & 1'b1);
	assign JALR = (instruction[6] & instruction[5] & ~instruction[4] & ~instruction[3] & instruction[2]);

endmodule
