`timescale 1ns/1ns

module dff_sync_reset_negedge_write #(parameter mem_width = 8)(
    input  logic clk,
    input  logic reset,
    input  logic we,

    input  logic [mem_width-1 : 0] data_in,
    output logic [mem_width-1 : 0] data_out);

    localparam D = 1; // Delay for simulation purposes

    always @(negedge clk) begin
        if(!reset) begin
            data_out <= #D 0;
        end
        else if(we) begin
            data_out <= #D data_in;
        end
    end

endmodule
