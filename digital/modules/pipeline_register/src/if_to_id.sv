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

    localparam D = 1; // Delay for simulation purposes
    
    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            instruction_o <= #D 0;
            imm_o <= #D 0;
            pc_plus_o <= #D 0;
            branch_prediction_o <= #D 0;
        end else if (~buble) begin
            if(flush) begin
                instruction_o <= #D 0;
                imm_o <= #D 0;
                pc_plus_o <= #D 0;
                branch_prediction_o <= #D 0;
            end else begin
                instruction_o <= #D instruction_i;
                imm_o <= #D imm_i;
                pc_plus_o <= #D pc_plus_i;
                branch_prediction_o <= #D branch_prediction_i;
            end
        end
    end

endmodule
