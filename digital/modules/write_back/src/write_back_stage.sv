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
    input  logic clk,
    input  logic reset,
    input  logic [size-1 : 0] ex_stage_result_i,
    input  logic [size-1 : 0] load_data_i,
    input  logic [10 : 0] control_signal_i,

    output logic [4:0] wb_stage_destination,
    output logic wb_stage_we,

    output logic [size-1 : 0] wb_result_o,
    output logic [5 : 0] control_signal_o,

    tracer_interface.sink   tracer_if_i,
    tracer_interface.source tracer_if_o
    );
    localparam D = 1;
    logic [size-1 : 0] load_data_internal;

    data_organizer load_data_organizer (
        .data_in(load_data_i),
        .Type_sel(control_signal_i[2:0]),
        .data_out(load_data_internal)
    ); 

    parametric_mux #(.mem_width(size), .mem_depth(2)) Final_mux(
        .addr(control_signal_i[3]),
        .data_in({load_data_internal, ex_stage_result_i}),
        .data_out(wb_result_o));


    assign control_signal_o = control_signal_i[10:5];
    assign wb_stage_destination = control_signal_i[10:6];
    assign wb_stage_we = control_signal_i[5];
    
    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            tracer_if_o.valid <= #D 0;
            tracer_if_o.pc        <= #D 0;
            tracer_if_o.instr     <= #D 0;
            tracer_if_o.reg_addr <= #D 0;
            tracer_if_o.reg_data <= #D 0;
            tracer_if_o.is_load <= #D 0;
            tracer_if_o.is_store <= #D 0;
            tracer_if_o.is_float <= #D 0; // Assuming no floating-point operations in MEM
            tracer_if_o.mem_size <= #D 2'b00; // Assuming no memory operations in MEM
            tracer_if_o.mem_addr <= #D 32'b0; // No memory address in MEM
            tracer_if_o.mem_data <= #D 32'b0; // No memory data in MEM
            tracer_if_o.fpu_flags <= #D 32'b0; // No FPU flags in MEM
           
        end else begin
            tracer_if_o.valid     <= #D tracer_if_i.valid; // Mark the tracer interface as valid
            tracer_if_o.pc        <= #D tracer_if_i.pc;
            tracer_if_o.instr     <= #D tracer_if_i.instr;
            tracer_if_o.reg_addr  <= #D tracer_if_i.reg_addr;
            tracer_if_o.is_load   <= #D tracer_if_i.is_load;
            tracer_if_o.is_store  <= #D tracer_if_i.is_store;
            tracer_if_o.is_float  <= #D tracer_if_i.is_float;
            tracer_if_o.mem_size  <= #D tracer_if_i.mem_size;
            tracer_if_o.mem_addr  <= #D tracer_if_i.mem_addr;
            tracer_if_o.mem_data  <= #D tracer_if_i.mem_data;
            tracer_if_o.reg_data  <= #D tracer_if_i.is_load ? load_data_internal : tracer_if_i.reg_data; 
            tracer_if_o.fpu_flags <= #D tracer_if_i.fpu_flags; // No FPU flags in EX stage
        end
    end
    
endmodule
