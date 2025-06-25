`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 22:15:17
// Design Name:
// Module Name: WB
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


module write_back_stage #(parameter size = 32)(
    input  logic [size-1 : 0] ex_stage_result_i,
    input  logic [size-1 : 0] mem_stage_result_i,
    input  logic [7 : 0] control_signal_i,

    output logic [4:0] wb_stage_destination,
    output logic wb_stage_we,

    output logic [size-1 : 0] wb_result_o,
    output logic [5 : 0] control_signal_o);

    parametric_mux #(.mem_width(size), .mem_depth(2)) Final_mux(
        .addr(control_signal_i[0]),
        .data_in({mem_stage_result_i, ex_stage_result_i}),
        .data_out(wb_result_o));


    assign control_signal_o = control_signal_i[7:2];
    assign wb_stage_destination = control_signal_i[7:3];
    assign wb_stage_we = control_signal_i[2];
endmodule
