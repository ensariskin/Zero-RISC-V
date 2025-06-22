`timescale 1ns/1ns


module hazard_detection_unit (
    input  logic clk,
    input  logic reset,
    input  logic [4:0] RD_EX,
    input  logic isLoad_EX,
    input  logic [4:0] RA_ID,
    input  logic [4:0] RB_ID,
    output logic buble );

    logic [4:0] RD_RA;
    logic [4:0] RD_RB;
    logic isRA;
    logic isRB;

    assign RD_RA = RD_EX ^ RA_ID;
    assign RD_RB = RD_EX ^ RB_ID;
    assign isRA = ~(RD_RA[4] | RD_RA[3] | RD_RA[2] | RD_RA[1] | RD_RA[0]);
    assign isRB = ~(RD_RB[4] | RD_RB[3] | RD_RB[2] | RD_RB[1] | RD_RB[0]);

    always@(negedge clk or negedge reset)
    begin
        if (!reset)
            buble <= 1'b0;
        else
            buble <= isLoad_EX & (isRA | isRB);
    end
endmodule
