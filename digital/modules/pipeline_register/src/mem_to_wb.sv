`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 22:10:52
// Design Name:
// Module Name: MEM_WB
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


module mem_to_wb#(parameter size = 32)(
    input  logic clk,
    input  logic reset,

    input  logic [size-1 : 0] ex_stage_result_i,
    input  logic [size-1 : 0] mem_stage_result_i,
    input  logic [7 : 0] control_signal_i,

    output logic [size-1 : 0] ex_stage_result_o,
    output logic [size-1 : 0] mem_stage_result_o,
    output logic [7 : 0] control_signal_o);



    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            ex_stage_result_o      <= 0;
            mem_stage_result_o     <= 0;
            control_signal_o <= 0;
        end
        else
        begin
            ex_stage_result_o  <= ex_stage_result_i;
            mem_stage_result_o <= mem_stage_result_i;
            control_signal_o <= control_signal_i;
        end
    end


endmodule
