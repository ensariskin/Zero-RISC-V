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
    input  logic branch_prediction_i,
    input  logic [size-1 : 0] data_a_i,
    input  logic [size-1 : 0] data_b_i,
    input  logic [size-1 : 0] store_data_i,
    input  logic [size-1 : 0] pc_plus_i,
    input  logic [25 : 0] control_signal_i,
    input  logic [2:0] branch_sel_i,

    output logic branch_prediction_o,
    output logic [size-1 : 0] data_a_o,
    output logic [size-1 : 0] data_b_o,
    output logic [size-1 : 0] store_data_o,
    output logic [size-1 : 0] pc_plus_o,
    output logic [25 : 0] control_signal_o,
    output logic [2:0] branch_sel_o);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            branch_prediction_o <= 1'b0;
            data_a_o <= {size{1'b0}};
            data_b_o <= {size{1'b0}};
            store_data_o <= {size{1'b0}};
            pc_plus_o <= {size{1'b0}};
            control_signal_o <= {26{1'b0}};
            branch_sel_o <= 3'b000;
        end
        else
        begin
            if(flush)
            begin
                branch_prediction_o <= 1'b0;
                data_a_o <= {size{1'b0}};
                data_b_o <= {size{1'b0}};
                store_data_o <= {size{1'b0}};
                pc_plus_o <= {size{1'b0}};
                control_signal_o <= {26{1'b0}};
                branch_sel_o <= 3'b000;
            end
            else    begin
            branch_prediction_o <= branch_prediction_i;
            data_a_o <= data_a_i;
            data_b_o <= data_b_i;
            store_data_o <= store_data_i;
            pc_plus_o <= pc_plus_i;
            control_signal_o <= control_signal_i;
            branch_sel_o <= branch_sel_i;
            end
        end
    end
endmodule
