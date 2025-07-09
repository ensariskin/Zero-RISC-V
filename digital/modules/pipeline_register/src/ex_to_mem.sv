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

    input  logic [size-1 : 0] executed_result_i,
    input  logic [size-1 : 0] store_data_i,
    input  logic [11 : 0] control_signal_i,

    output logic [size-1 : 0] executed_result_o,
    output logic [size-1 : 0] store_data_o,
    output logic [11 : 0] control_signal_o);

    localparam D = 1; // Delay for simulation purposes
    
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            executed_result_o <= #D {size{1'b0}};
            store_data_o <= #D {size{1'b0}};
            control_signal_o <= #D {12{1'b0}};
        end
        else begin
            executed_result_o <= #D executed_result_i;
            store_data_o <= #D store_data_i;
            control_signal_o <= #D control_signal_i;
        end
    end

endmodule
