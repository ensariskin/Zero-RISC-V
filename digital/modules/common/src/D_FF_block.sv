`timescale 1ns/1ns

module D_FF_block #(parameter mem_width = 16, parameter mem_depth = 16)(
    input clk,
    input reset,
    input [mem_width-1 : 0] Rin,
    input we,
    input [mem_depth-1:0] S,
    output [mem_width*mem_depth-1:0] Rout);

    genvar i;
    generate
    for(i = 0; i < mem_depth; i = i+1) begin
        D_FF_async_rst #(.mem_width(mem_width)) DFF(
        .clk(clk),
        .reset(reset),
        .Rin(Rin),
        .we(S[i] & we),
        .Rout(Rout[(i+1)*mem_width-1 :i*mem_width])
        );
    end
    endgenerate

endmodule
