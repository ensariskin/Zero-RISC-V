`timescale 1ns/1ns

module new_DFF#(parameter mem_width = 8)(
    input clk,
    input reset,
    input [mem_width-1 : 0] Rin,
    input we,
    output reg [mem_width-1 : 0] Rout);
    
    always @(negedge clk) begin 
        if(!reset) begin
            Rout <= 0;
        end
        else if(we) begin
            Rout <= Rin;
        end
    end
    
endmodule
