`timescale 1ns/1ns

module Parametric_mux#(parameter mem_width = 16, parameter mem_depth = 16)(
    input [$clog2(mem_depth)-1 : 0] addr,
    input [mem_width*mem_depth-1 : 0] data_in,
    output [mem_width-1 : 0] data_out );

    logic [mem_width-1:0] inner_data [0:mem_depth-1] ;
    genvar i ;

    generate
        for(i = 0; i < mem_depth; i=i+1) begin
             assign inner_data[i] = data_in[(i+1)*mem_width-1 : i*mem_width];
        end
    endgenerate

    assign data_out = inner_data[addr];
endmodule
