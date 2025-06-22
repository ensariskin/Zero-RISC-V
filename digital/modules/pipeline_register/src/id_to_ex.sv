`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 03:44:38
// Design Name:
// Module Name: ID_EX
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


module id_to_ex #(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic flush,
    input  logic Predicted_MPC_i,
    input  logic [size-1 : 0] A_i,
    input  logic [size-1 : 0] B_i,
    input  logic [size-1 : 0] RAM_DATA_i,
    input  logic [size-1 : 0] PCplus_i,
    input  logic [25 : 0] Control_Signal_i,
    input  logic [2:0] Branch_sel_i,

    output logic Predicted_MPC_o,
    output logic [size-1 : 0] A_o,
    output logic [size-1 : 0] B_o,
    output logic [size-1 : 0] RAM_DATA_o,
    output logic [size-1 : 0] PCplus_o,
    output logic [25 : 0] Control_Signal_o,
    output logic [2:0] Branch_sel_o);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            Predicted_MPC_o <= 1'b0;
            A_o <= {size{1'b0}};
            B_o <= {size{1'b0}};
            RAM_DATA_o <= {size{1'b0}};
            PCplus_o <= {size{1'b0}};
            Control_Signal_o <= {26{1'b0}};
            Branch_sel_o <= 3'b000;
        end
        else
        begin
            if(flush)
            begin
                Predicted_MPC_o <= 1'b0;
                A_o <= {size{1'b0}};
                B_o <= {size{1'b0}};
                RAM_DATA_o <= {size{1'b0}};
                PCplus_o <= {size{1'b0}};
                Control_Signal_o <= {26{1'b0}};
                Branch_sel_o <= 3'b000;
            end
            else    begin
            Predicted_MPC_o <= Predicted_MPC_i;
            A_o <= A_i;
            B_o <= B_i;
            RAM_DATA_o <= RAM_DATA_i;
            PCplus_o <= PCplus_i;
            Control_Signal_o <= Control_Signal_i;
            Branch_sel_o <= Branch_sel_i;
            end
        end
    end
endmodule
