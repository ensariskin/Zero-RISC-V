`timescale 1ns/1ns

module HA(
    input x,
    input y,
    output cout,
    output s);
    
    assign cout = x & y;
    assign s = x ^ y;
endmodule