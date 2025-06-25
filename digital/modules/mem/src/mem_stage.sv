`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 17.06.2022 18:13:38
// Design Name:
// Module Name: MEM
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


module mem_stage #(parameter size = 32)(

    input  logic [size-1 : 0] execute_result_i,
    input  logic [size-1 : 0] store_data_i,
    input  logic [11 : 0] control_signal_i,

    input  logic [size-1 : 0] load_data_i,  // from memory

    output logic [size-1 : 0] store_data_o,
    output logic [2:0] data_mem_width_sel, // to memory
    output logic data_mem_rw,

    output logic [size-1 : 0] execute_result_o,
    output logic [size-1 : 0] load_data_o,    // to write back stage

    output logic [7 : 0] control_signal_o,

    output logic [4:0] mem_stage_destination,
    output logic       mem_stage_we
    );



    assign store_data_o = store_data_i;

    assign data_mem_width_sel = control_signal_i[2:0];
    assign data_mem_rw      = control_signal_i[3] & ~control_signal_i[6]; // todo check the logic for read/write
    assign execute_result_o = execute_result_i;
    assign load_data_o = load_data_i;

    assign control_signal_o = control_signal_i[11:4];


    assign mem_stage_destination = control_signal_i[11:7];
    assign mem_stage_we          = control_signal_i[6];


endmodule
