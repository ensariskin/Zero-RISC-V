`timescale 1ns/1ns

module register_file #(parameter mem_width = 32, parameter mem_depth = 32)(
    input  logic clk,
    input  logic reset,
    input  logic we,

    input  logic [$clog2(mem_depth)-1 : 0] a_select,
	input  logic [$clog2(mem_depth)-1 : 0] b_select,
	input  logic [$clog2(mem_depth)-1 : 0] write_addr,

    input  logic [mem_width-1 : 0] rd_in,
    output logic [mem_width-1 : 0] a_out,
	output logic [mem_width-1 : 0] b_out);

    logic [mem_depth-1:0] wr_sel;
    logic [mem_width*mem_depth-1:0] reg_out;

    parametric_decoder #(.mem_depth(mem_depth)) decoder_in(
        .addr(write_addr),
        .dec_out(wr_sel));

    dff_block_negedge_write #(.mem_depth(mem_depth), .mem_width(mem_width)) registers(
        .clk      (clk),
        .reset    (reset),
        .data_in  (rd_in),
        .we       (we),
        .wr_sel   (wr_sel),
        .data_out (reg_out));

    // TODO : Add read enable for a and b
    parametric_mux #(.mem_depth(mem_depth), .mem_width(mem_width)) a_mux_out(
        .addr     (a_select),
        .data_in  (reg_out),
        .data_out (a_out));

    parametric_mux #(.mem_depth(mem_depth), .mem_width(mem_width)) b_mux_out(
        .addr     (b_select),
        .data_in  (reg_out),
        .data_out (b_out));

endmodule
