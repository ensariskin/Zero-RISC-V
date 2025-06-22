`timescale 1ns/1ns

module parametric_decoder #(parameter mem_depth = 8)(
    input  logic [$clog2(mem_depth)-1 : 0] addr,
    output logic [mem_depth-1:0] dec_out );

    genvar i;

	generate
	  for (i = 0; i < mem_depth; i = i + 1)  begin
		assign dec_out[i] = addr==i ? 1'b1 : 1'b0;
	  end
	endgenerate


endmodule
