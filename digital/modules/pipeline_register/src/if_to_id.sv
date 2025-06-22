`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 02:30:09
// Design Name:
// Module Name: IF_ID
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


module if_to_id #(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic flush,
    input  logic [size-1 : 0] instruction_i,
    input  logic [size-1 : 0] imm_i,
    input  logic [size-1 : 0] pc_plus_i,
    input  logic branch_prediction_i,

    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] imm_o,
    output logic [size-1 : 0] pc_plus_o,
    output logic branch_prediction_o);

    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            instruction_o <= 0;
            imm_o <= 0;
            pc_plus_o <= 0;
            branch_prediction_o <= 0;
        end else if (~buble) begin
            if(flush) begin
                instruction_o <= 0;
                imm_o <= 0;
                pc_plus_o <= 0;
                branch_prediction_o <= 0;
            end else begin
                instruction_o <= instruction_i;
                imm_o <= imm_i;
                pc_plus_o <= pc_plus_i;
                branch_prediction_o <= branch_prediction_i;
            end
        end
    end

endmodule
