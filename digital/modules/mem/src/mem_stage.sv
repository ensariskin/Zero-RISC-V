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

    output logic [size-1 : 0] store_data_o,
    output logic [2:0] data_mem_width_sel, // to memory
    output logic data_mem_rw,

    output logic [size-1 : 0] execute_result_o,

    output logic [10 : 0] control_signal_o,

    output logic [4:0] mem_stage_destination,
    output logic       mem_stage_we,

    tracer_interface.sink tracer_if_i,
    tracer_interface.source tracer_if_o
    );

    localparam D = 1; // Delay for simulation purposes
    
    // Internal signals for MEM/WB pipeline register
    logic [size-1 : 0] execute_result_internal;
    logic [10 : 0] control_signal_internal;

    // Combinational memory control outputs (not registered)
    //assign store_data_o       = store_data_i;
    assign data_mem_width_sel = control_signal_i[2:0];
    assign data_mem_rw        = control_signal_i[3] & ~control_signal_i[6]; // todo check the logic for read/write

    // Combinational outputs to hazard/forwarding logic (not registered) 
    assign mem_stage_destination = control_signal_i[11:7];
    assign mem_stage_we          = control_signal_i[6];

    // Internal assignments for pipeline register
    assign execute_result_internal = execute_result_i;
    assign control_signal_internal = {control_signal_i[11:4], control_signal_i[2:0]}; 

    // MEM/WB Pipeline Register
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            execute_result_o <= #D {size{1'b0}};
            control_signal_o <= #D 8'b0;
        end else begin
            execute_result_o <= #D execute_result_internal;
            control_signal_o <= #D control_signal_internal;
        end
    end

    data_organizer store_data_organizer (
        .data_in(store_data_i),
        .Type_sel(data_mem_width_sel),
        .data_out(store_data_o)
    ); 

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            tracer_if_o.valid <= #D 0;
            tracer_if_o.pc      <= #D 0;
            tracer_if_o.instr    <= #D 0;
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
            tracer_if_o.valid    <= #D tracer_if_i.valid;
            tracer_if_o.pc       <= #D tracer_if_i.pc;
            tracer_if_o.instr    <= #D tracer_if_i.instr;
            tracer_if_o.reg_addr <= #D tracer_if_i.reg_addr;
            tracer_if_o.reg_data <= #D tracer_if_i.reg_data;
            tracer_if_o.is_load  <= #D tracer_if_i.is_load;
            tracer_if_o.is_store <= #D tracer_if_i.is_store;
            tracer_if_o.is_float <= #D tracer_if_i.is_float;
            tracer_if_o.mem_size <= #D tracer_if_i.mem_size;
            tracer_if_o.mem_addr <= #D tracer_if_i.mem_addr;
            tracer_if_o.mem_data <= #D tracer_if_i.is_store ? store_data_o : tracer_if_i.mem_data;
            tracer_if_o.fpu_flags <= #D tracer_if_i.fpu_flags;
        end
    end

endmodule
