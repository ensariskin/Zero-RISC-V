`timescale 1ns / 1ps

module NVR_TOP
#(parameter addrSize = 7,
  parameter width = 32)
(
    input [addrSize-1:0] 	A,
    input [width-1:0]    	DIN,
    input [3:0] 		TM_NVCP,
    input 			CE, HR, HS, MEM_ALLC, NVREF_EXT, PEIN, POR, WE,
    input [3:0]			MEM_SEL,
    input  			DUP, DSCLK, DRSTN, DSI,
    
    output [width-1:0]  DOUT,
    output RDY,
    output DSO,
    output CLK4M
);
    
   wire [15:0] 	 TRIM;
   wire [3:0]	TM_NVCPI;
   wire		BUSYNVC, RCLT, VSESTART, CLKI, CLK, VCORE, VSEBUSY;
   wire 	MEM1_ENT, MEM2_ENT, VSE1,VSE2;
 
//--------------------------------------------------------------------------
  
   XNVR_128X32P32_VD01C	XNVR 	(
 	// Outputs
	.DOUT(DOUT), 
	.TRIM(TRIM), 
	.TM_NVCPI(TM_NVCPI), 
	.BUSYNVC(BUSYNVC), 
	.CLKI(CLKI),
	.RCLT(RCLT), 
	.RDY(RDY), 
	.DSO(DSO), 
	.VSESTART(VSESTART),
	.MEM1_ENT(MEM1_ENT), 
	.MEM2_ENT(MEM2_ENT), 
	// Inputs
	.A(A), 
	.DIN(DIN), 
	.TM_NVCP(TM_NVCP), 
	.CE(CE), 
	.CLK(CLK), 
	.HR(HR), 
	.HS(HS), 
	.MEM_ALLC(MEM_ALLC), 
	.PEIN(PEIN), 
	.POR(POR), 
	.VCORE(VCORE), 
	.VSEBUSY(VSEBUSY), 
	.WE(WE),
	.DSCLK(DSCLK), 
	.DRSTN(DRSTN), 
	.DSI(DSI), 
	.DUP(DUP), 
	.MEM_SEL(MEM_SEL), 
	.VSE1(VSE1), 
	.VSE2(VSE2) 
	);
   
   XCPF_128X32DP32_VD03C 	XCPF	(
	// Outputs
	.CLK4(CLK),
	.CLK4M(CLK4M), 
	.VCORE(VCORE), 
	.VSE1(VSE1), 
	.VSE2(VSE2), 
	.VSEBUSY(VSEBUSY),
	// Inputs
  	.BUSYNVC(BUSYNVC), 
	.CLKI(CLKI), 
	.MEM1_ENT(MEM1_ENT), 
	.MEM2_ENT(MEM2_ENT), 
	.NVREF_EXT(NVREF_EXT), 
	.POR(POR), 
	.RCLT(RCLT), 
	.TM_NVCPI(TM_NVCPI), 
	.TRIM(TRIM), 
	.VSESTART(VSESTART) 
	);

    
endmodule

