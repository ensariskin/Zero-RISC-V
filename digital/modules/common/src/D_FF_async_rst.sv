`timescale 1ns/1ns

module D_FF_async_rst#(parameter mem_width = 8)
(
    input  logic clk,
    input  logic reset,
    input  logic [mem_width-1 : 0] Rin,
    input  logic we,
    output logic [mem_width-1 : 0] Rout
);

    always @(posedge clk or negedge reset)
    begin
        if(!reset) begin
            Rout <= 0;
        end
        else if(we) begin
            Rout <= Rin;
        end
    end

endmodule
