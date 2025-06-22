`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 18:17:25
// Design Name:
// Module Name: EX_MEM
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


module ex_to_mem #(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic [size-1 : 0] FU_i,
    input  logic [size-1 : 0] RAM_DATA_i,
    input  logic [size-1 : 0] PCplus_i,
    input  logic [11 : 0] Control_Signal_i,

    output logic [size-1 : 0] FU_o,
    output logic [size-1 : 0] RAM_DATA_o,
    output logic [size-1 : 0] PCplus_o,
    output logic [11 : 0] Control_Signal_o);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            FU_o <= {size{1'b0}};
            RAM_DATA_o <= {size{1'b0}};
            PCplus_o <= {size{1'b0}};
            Control_Signal_o <= {12{1'b0}};
        end
        else begin
            FU_o <= FU_i;
            RAM_DATA_o <= RAM_DATA_i;
            PCplus_o <= PCplus_i;
            Control_Signal_o <= Control_Signal_i;
        end
    end

endmodule
