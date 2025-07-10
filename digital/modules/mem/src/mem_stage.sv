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
    input logic clk,
    input logic reset,

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

    localparam D = 1; // Delay for simulation purposes
    
    // Internal signals for MEM/WB pipeline register
    logic [size-1 : 0] execute_result_internal;
    logic [size-1 : 0] load_data_internal;
    logic [7 : 0] control_signal_internal;

    // Combinational memory control outputs (not registered)
    assign store_data_o = store_data_i;
    assign data_mem_width_sel = control_signal_i[2:0];
    assign data_mem_rw      = control_signal_i[3] & ~control_signal_i[6]; // todo check the logic for read/write

    // Combinational outputs to hazard/forwarding logic (not registered) 
    assign mem_stage_destination = control_signal_i[11:7];
    assign mem_stage_we          = control_signal_i[6];

    // Internal assignments for pipeline register
    assign execute_result_internal = execute_result_i;
    assign load_data_internal = load_data_i;
    assign control_signal_internal = control_signal_i[11:4];

    // MEM/WB Pipeline Register
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            execute_result_o <= #D {size{1'b0}};
            load_data_o <= #D {size{1'b0}};
            control_signal_o <= #D 8'b0;
        end else begin
            execute_result_o <= #D execute_result_internal;
            load_data_o <= #D load_data_internal;
            control_signal_o <= #D control_signal_internal;
        end
    end


endmodule
