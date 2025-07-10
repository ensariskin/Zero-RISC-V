`timescale 1ns/1ns

module Data_Forward(
    input [4:0] RA,
    input [4:0] RB,
	input MB,
    input [4:0] RD_MEM,
    input [4:0] RD_WB,
    input WE_MEM,
    input WE_WB,
    output [1:0] A_sel,
    output [1:0] B_sel,
    output [1:0] store_data_sel
    );
    
    
    wire RA_RD_MEM;         //1 means different, 0 means same
    wire RA_RD_WB;
    wire RB_RD_MEM;
    wire RB_RD_WB;
    
    
    wire [4:0] RA_RD_MEM_exor; 
    wire [4:0] RA_RD_WB_exor;
    wire [4:0] RB_RD_MEM_exor;
    wire [4:0] RB_RD_WB_exor;
    
    assign RA_RD_MEM_exor = RA ^ RD_MEM;
    assign RA_RD_WB_exor = RA ^ RD_WB;
    assign RB_RD_MEM_exor = RB ^ RD_MEM;
    assign RB_RD_WB_exor = RB ^ RD_WB;
    
    assign RA_RD_MEM = RA == 5'D0 ?  1'b1 : |RA_RD_MEM_exor; //exclude x0 register
    assign RA_RD_WB  = RA == 5'D0 ?  1'b1 : |RA_RD_WB_exor; 
    assign RB_RD_MEM = RB == 5'D0 ?  1'b1 : |RB_RD_MEM_exor; 
    assign RB_RD_WB  = RB == 5'D0 ?  1'b1 : |RB_RD_WB_exor;
   
    assign A_sel[0] = WE_MEM & ~RA_RD_MEM;
    assign A_sel[1] = WE_WB & ~RA_RD_WB;
   
    assign B_sel[0] = WE_MEM & ~RB_RD_MEM & ~MB;
    assign B_sel[1] = WE_WB  & ~RB_RD_WB  & ~MB;

    assign store_data_sel[0] = WE_MEM & ~RB_RD_MEM & MB;
    assign store_data_sel[1] = WE_WB  & ~RB_RD_WB  & MB;
    
endmodule
