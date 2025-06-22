`timescale 1ns/1ns

module dff_block_negedge_write #(parameter mem_width = 16, parameter mem_depth = 16)(
    input  logic clk,
    input  logic reset,
    input  logic we,

    input  logic [mem_width-1 : 0] data_in,
    input  logic [mem_depth-1 : 0] wr_sel,
    output logic [mem_width*mem_depth-1 : 0] data_out);

    genvar i;
    generate
    for(i = 0; i < mem_depth; i = i+1) begin

        dff_sync_reset_negedge_write #(.mem_width(mem_width)) dff(
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .we(wr_sel[i] & we),
        .data_out(data_out[(i+1)*mem_width-1 :i*mem_width])
        );
    end
    endgenerate

endmodule
