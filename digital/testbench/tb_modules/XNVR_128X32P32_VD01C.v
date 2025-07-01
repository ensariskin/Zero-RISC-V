// ------------------------------------------------------------------------------------
//
// Copyright        	: (c) All Rights Reserved
// Company          	: X-FAB Global Services GmbH
// Address          	: Haarbergstr. 67,  D-99097 Erfurt, Germany
//
// --------------------------------------------------------------------------
//
// DISCLAIMER
//
// The information furnished herein by X-FAB Global Services GmbH (X-FAB) is substantially correct and accurate.
// However, X-FAB shall not be liable to licensee or any third party for any damages, including but not limited
// to property damage, loss of profits, loss of use, interruption of business or indirect, special, incidental
// or consequential damages, of any kind, in connection with or arising out of the furnishing, performance or
// use of the technical data. No obligation or liability to licensee or any third party shall arise or flow out
// of X-FAB rendering technical or other services.
//
// X-FAB makes no warranty, express, implied, statutory, or descriptive of the information contained herein or
// of warranties of merchantability, fitness for a particular purpose, or non-infringement.
// X-FAB reserves the right to change specifications and prices at any time and without notice.
// Therefore, prior to designing this product into a system, it is necessary to check with X-FAB for current information.
// The products listed herein are intended for use in standard commercial applications.
// Applications requiring extended temperature range, unusual environmental requirements, or high reliability applications,
// such as military, medical life-support or life-sustaining equipment are specifically not recommended without additional
// processing by X-FAB for each application.
//
// --------------------------------------------------------------------------
//
// File             	: XNVR_128X32P32_VD01C.v
// Description      	: Verilog simulation file
//                  	: NVRAM with DWSP Module, no ECC module : XNVR_128X32P32_VD01C
//
// Technology       	: XH018	( 0.18 um modular mixed signal HV CMOS process )
// Process          	: LPMOS 	( 1.8 V / 3.3 V low power CMOS module, single polysilicon, metal1, metal2 )
//
// PDK Core Module  	: 1 	( LP - Low Power 1.8 V )
// PDK MOS Module   	: 1 	( MOS3 - 3.3 Volt MOS )
// PDK Setup Code   	: 11XX
//
// Number of Word   	: 128
// Number of Bit    	: 32
//
// Memory Core Size 	: 128	word(s)
//
// Model version    	: v5.8.1
// Created by       	: X-FAB NON-VOLATILE MEMORY COMPILER
//                  	: XNVMC - XH018 - NVRAM v5.8.1
// on               	: Thu Jan 20 15:48:58 2022
//
// --------------------------------------------------------------------------
//
// NOTES:
//
// 1. Defines:
// +++++++++++
//
// 	1.1  DEFAULT_WORST_DELAY_OFF
//
//			The Default delay in this Verilog model is initialized according to the
//			specified WORST SPEED operating conditions of the IP block.
//			This supports worst case system simulations on Register-Transfer-Level (RTL)
//			to prevent system development iterations because of simulations with not
//			detected unrealistic fast IP block unit delay values.
//			But this could feign an executed backannotation step.
//			With the compiler directive
//
//			`define DEFAULT_WORST_DELAY_OFF
//
//			the IP block Default delays can be set to unit delays (0.02ns).
//
//			Important:
//			The Default(!) delays in a Verilog model are only formally initialized
//			timing place holder values.
//			A Backannotation step must be executed before timing simulations resp.
//			timing analysis to replace these default timing values with the
//			netlist dependent IP block timing values.
//
// 	1.2  __VAMS_ENABLE__
//
//			This define-statement is implemented in the VAMS model version only and can be set
//			in Verilog testbench. This enables supply sensitivity information for input and output pins.
//
// 2. Parameters:
// ++++++++++++++
//
//	2.1  initFile
//			It is possible to initialize (pre-load) the XNVR_128X32P32_VD01C content without
//			a modification of this Verilog model file.
//			The following statement section shows a Verilog testbench example.
//			The file name "init_file" can be defined in the testbench.
//			The NVRAM instance XNVR has to be adapted according to the
//			netlist hierarchy of the chip project.
//
//			------------------------------------------------------
//			initial begin
//			  $readmemb(initFile, XNVR.mem, 0, 127);      // bin format
//			  $readmemh(initFile, XNVR.mem, 0, 127);      // hex format
//			  $display("%.1fns XNVR %m : INFO : Loading Initial File ... %s \n", $realtime, initFile);
//			end
//			------------------------------------------------------
//
//			This initFile is NOT part of the frontend package.
//
//	2.2  debugMode
//			It is possible to set the model into debug mode by defining this statement in
//			the Verilog testbench and set it's value to '1'.
//			This enables getting detailed information about operations, addresses and data.
//			Default state is '0'.
//	2.3  verbose
//			It is possible to set the model into non-verbose mode by defining this statement in
//			the Verilog testbench and set it's value to '0'.
//			This disables getting warnings and error messages.
//			Default state is '1'.
//	2.4  extWidth
//			This parameter corresponds to the number of bits given by customer.
//	2.5  intWidth
//			This parameter corresponds to the number of bits used for memory matrix.
//			In case of any ECC logic implemented in the design this value contains sum of
//			customer bits and additional bits for ECC correction. Otherwise it is equal to 'extWidth'.
//	2.6  addrSize
//			This parameter corresponds to number of address bits required for addressing whole memory.
//	2.7  memSize
//			This parameter corresponds to the number of words given by customer.
//	2.8  coreSize
//			This parameter corresponds to maximum number of words implemented in memory.
//			Core size parameter represents the maximum number of words (memory capacity) which is implemented in the memory.
//			Core size parameter and number of words parameter can be different in case of memory sizes not equal to power of 2!
//	2.9  start_MEM
//			This parameter correspond to the lowest memory address.
//	2.10 stop_MEM
//			This parameter corresponds to the highest memory address.
//
// 3. Features:
// ++++++++++++
//
//	3.1 Simulator	This model has been tested in the XMSIM environment.
//
// 4. Notes for simulation:
// ++++++++++++++++++++++++
//
// 	 		General          : - POR pulse is always necessary after system startup
// 	 		Functional Mode  : - is set after reset pulse (positive POR or negative DRSTN)
// 			Diagnostic Mode  : - started with the first positive edge of DSCLK pulse
//
// 5.  Wrapper Chain:
// ++++++++++++++++++
//
//                    	CAPTURE_SH		-> NV_CTRL
//                    	XBUSE_SH		-> NV_CTRL
//                    	XBUS[0:5]		-> NV_CTRL
//                    	HR_SH			-> NV_CTRL
//                    	HS_SH			-> NV_CTRL
//		      	TM_NVCP[3:0]		-> CP_CTRL
//                    	CLK			-> CK_CTRL
//                    	MEM_ALLC		-> ST_CTRL
//                    	MEM_SEL			-> ST_CTRL
//                    	A[ADDRSIZE-1:0]		-> ...<addr>...
//                    	CE			-> SR_CTRL
//                    	WE			-> SR_CTRL
//                    	DIN[extWidth-1:0]	-> ...<extWidth>...
//                    	DOUT[0:extWidth-1]	-> ...<extWidth>...
//                    	RDY			-> XX_CTRL
//                    	POR			-> XX_CTRL
//
// --------------------------------------------------------------------------

`resetall

`default_nettype wire
`celldefine
`delay_mode_path


`timescale 1ns / 10ps

`ifdef XNVR_128X32P32_VD01C_debugMode
`else
  `define XNVR_128X32P32_VD01C_debugMode 0
`endif
`ifdef XNVR_128X32P32_VD01C_verbose
`else
  `define XNVR_128X32P32_VD01C_verbose 1
`endif

module XNVR_128X32P32_VD01C (BUSYNVC, CLKI, DOUT, DSO, MEM1_ENT, MEM2_ENT, RCLT, RDY, TM_NVCPI, TRIM, VSESTART, A, CE, CLK, DIN, DRSTN, DSCLK, DSI, DUP, HR, HS, MEM_ALLC, MEM_SEL, PEIN, POR, TM_NVCP, VCORE, VSE1, VSE2, VSEBUSY, WE );

   parameter   debugMode      	= `XNVR_128X32P32_VD01C_debugMode,
	       verbose        	= `XNVR_128X32P32_VD01C_verbose,
               extWidth		= 32,
	       intWidth		= 32,
      	       addrSize		= 7,
	       memSize		= 128,
	       coreSize		= 128,
	       start_MEM1	= 0,
	       stop_MEM1	= 31,
	       start_MEM2	= 32,
	       stop_MEM2	= 127,
	       wrpLength   	= 92,
               wrpHR		= 83,
               wrpHS		= 82,
	       wrpTM_NVCP_msb	= 81,
	       wrpTM_NVCP_lsb	= 78,
	       wrpCLK         	= 77,
	       wrpMEM_ALLC	= 76,
	       wrpMEM_SEL	= 75,
	       wrpA_msb       	= 74,
	       wrpA_lsb       	= 68,
	       wrpCE          	= 67,
	       wrpWE          	= 66,
	       wrpDIN_msb       = 65,
	       wrpDIN_lsb       = 34,
	       wrpDOUT_msb	= 33,
	       wrpDOUT_lsb	= 2;

   integer  	i, j;


   output   	[extWidth-1:0]	DOUT;
   output   	[31:0] 		TRIM;
   output   	[3:0]		TM_NVCPI;
   output 			BUSYNVC, CLKI, MEM1_ENT, MEM2_ENT, RCLT, RDY, VSESTART, DSO;
   input    	[addrSize-1:0]	A;
   input    	[extWidth-1:0]	DIN;
   input    	[3:0]		TM_NVCP;
   input			CE, CLK, HR, HS, MEM_ALLC, MEM_SEL, PEIN, POR, VCORE, VSE1, VSE2, VSEBUSY, WE, DSCLK, DRSTN, DSI;

   input 			DUP;

   reg      [intWidth-1:0] 	_SR_MEMORY[stop_MEM2:start_MEM1];
   reg      [intWidth-1:0] 	_NV_MEMORY[stop_MEM2:start_MEM1];
   reg      [extWidth-1:0] 	_DOUT;
   reg      [3:0]		_TM_NVCP;
   reg      [wrpLength-1:0] 	_WRP;
   reg 				_RCLT, _RDY, _VSESTART, _DSO_WRP;
   reg 				_FUNC_MODE;
   reg 				_RCL, _STR, _RDY_CORE;
   reg				_RD, _WR, _HR, _HS, _PEND, _CE;
   reg 				_CAPTURE_SH;
   reg 	                        _RD_CYCLE, _WR_CYCLE, _STR_CYCLE, _RCL_CYCLE;
   reg 				_NOTIF, _NOTIF_A, _NOTIF_DIN, _NOTIF_PEIN, _NOTIF_POR, _NOTIF_DSI;
   reg				_BUSYNVC;

   wire     [extWidth-1:0] 	DOUT, DIN;
   wire     [addrSize-1:0] 	_A, A;
   wire     [31:0] 		_TRIM, TRIM;
   wire     [3:0]		_TM_NVCPI, TM_NVCPI, TM_NVCP;
   wire 			_RDY_INT, _MEM_ALLC, _MEM_SEL, _WE, _CLKI, _DIRES, _DSO;
   wire                         CE, CLK, HR, HS, MEM_ALLC, MEM_SEL, PEIN, POR, VCORE, VSE1, VSE2, VSEBUSY, WE, DSCLK, DRSTN, DSI;
   wire                         BUSYNVC, CLKI, MEM1_ENT, MEM2_ENT, RCLT, RDY, VSESTART, DSO;
   wire                         _WEPORq, _CE_RDYq, _HR_RDYq, _HS_RDYq, _RDY_FM, _RDY_DM, _BUSY, _CLK, _DSCLK, _DSCLKN, _IDSCLKN, _MEM1_ENT, _MEM2_ENT, _MEM1_SEL, _MEM2_SEL;

   wire                         DUP;

   reg 	    [extWidth-1:0] 	_DOUT_CORE;
   wire     [extWidth-1:0] 	_DIN, _DOUT_INT, _MEM;


   buf      (_CLK,	CLK);
   buf      (_DSCLK,	DSCLK);
   not      (_DSCLKN,	DSCLK);
   buf      (_IDSCLKN,	_DSCLKN);

   buf      (DSO,	_DSO);

   buf      (RDY,	_RDY_INT);
   buf      (RCLT,	_RCLT);
   buf      (VSESTART,	_VSESTART);
   buf      (MEM1_ENT,	_MEM1_ENT);
   buf      (MEM2_ENT,	_MEM2_ENT);

   buf      (CLKI,	_CLKI);
   buf	    (BUSYNVC,	_BUSYNVC);

   buf      (TRIM[0],	_TRIM[0]);
   buf      (TRIM[1],	_TRIM[1]);
   buf      (TRIM[2],	_TRIM[2]);
   buf      (TRIM[3],	_TRIM[3]);
   buf      (TRIM[4],	_TRIM[4]);
   buf      (TRIM[5],	_TRIM[5]);
   buf      (TRIM[6],	_TRIM[6]);
   buf      (TRIM[7],	_TRIM[7]);
   buf      (TRIM[8],	_TRIM[8]);
   buf      (TRIM[9],	_TRIM[9]);
   buf      (TRIM[10],	_TRIM[10]);
   buf      (TRIM[11],	_TRIM[11]);
   buf      (TRIM[12],	_TRIM[12]);
   buf      (TRIM[13],	_TRIM[13]);
   buf      (TRIM[14],	_TRIM[14]);
   buf      (TRIM[15],	_TRIM[15]);
   buf      (DOUT[0],	_DOUT_INT[0]);
   buf      (DOUT[1],	_DOUT_INT[1]);
   buf      (DOUT[2],	_DOUT_INT[2]);
   buf      (DOUT[3],	_DOUT_INT[3]);
   buf      (DOUT[4],	_DOUT_INT[4]);
   buf      (DOUT[5],	_DOUT_INT[5]);
   buf      (DOUT[6],	_DOUT_INT[6]);
   buf      (DOUT[7],	_DOUT_INT[7]);
   buf      (DOUT[8],	_DOUT_INT[8]);
   buf      (DOUT[9],	_DOUT_INT[9]);
   buf      (DOUT[10],	_DOUT_INT[10]);
   buf      (DOUT[11],	_DOUT_INT[11]);
   buf      (DOUT[12],	_DOUT_INT[12]);
   buf      (DOUT[13],	_DOUT_INT[13]);
   buf      (DOUT[14],	_DOUT_INT[14]);
   buf      (DOUT[15],	_DOUT_INT[15]);
   buf      (DOUT[16],	_DOUT_INT[16]);
   buf      (DOUT[17],	_DOUT_INT[17]);
   buf      (DOUT[18],	_DOUT_INT[18]);
   buf      (DOUT[19],	_DOUT_INT[19]);
   buf      (DOUT[20],	_DOUT_INT[20]);
   buf      (DOUT[21],	_DOUT_INT[21]);
   buf      (DOUT[22],	_DOUT_INT[22]);
   buf      (DOUT[23],	_DOUT_INT[23]);
   buf      (DOUT[24],	_DOUT_INT[24]);
   buf      (DOUT[25],	_DOUT_INT[25]);
   buf      (DOUT[26],	_DOUT_INT[26]);
   buf      (DOUT[27],	_DOUT_INT[27]);
   buf      (DOUT[28],	_DOUT_INT[28]);
   buf      (DOUT[29],	_DOUT_INT[29]);
   buf      (DOUT[30],	_DOUT_INT[30]);
   buf      (DOUT[31],	_DOUT_INT[31]);
   buf      (TM_NVCPI[0],	_TM_NVCPI[0]);
   buf      (TM_NVCPI[1],	_TM_NVCPI[1]);
   buf      (TM_NVCPI[2],	_TM_NVCPI[2]);
   buf      (TM_NVCPI[3],	_TM_NVCPI[3]);

   assign   _CLKI 	= _FUNC_MODE 	? _CLK : _IDSCLKN;
   assign   _TM_NVCPI	= _FUNC_MODE	? _WRP[wrpTM_NVCP_msb:wrpTM_NVCP_lsb] : _TM_NVCP;

   assign   _RDY_INT    = _DIRES	? 1'b0 : _RDY;
   assign   _DIRES	= POR | ~DRSTN;

   assign   _A          = _WRP[wrpA_msb:wrpA_lsb];
   assign   _DIN        = _WRP[wrpDIN_msb:wrpDIN_lsb];
   assign   _MEM        = _SR_MEMORY[_A];
   assign   _MEM_ALLC   = _WRP[wrpMEM_ALLC];
   assign   _MEM_SEL    = _WRP[wrpMEM_SEL];
   assign   _WE         = _WRP[wrpWE];

   assign   _DSO	= _TM_NVCPI == 4'b1000 ? CLK  : _DSO_WRP;
   assign   _DOUT_INT[0]	= _DIRES ? 1'b0 : _DOUT[0];
   assign   _DOUT_INT[1]	= _DIRES ? 1'b0 : _DOUT[1];
   assign   _DOUT_INT[2]	= _DIRES ? 1'b0 : _DOUT[2];
   assign   _DOUT_INT[3]	= _DIRES ? 1'b0 : _DOUT[3];
   assign   _DOUT_INT[4]	= _DIRES ? 1'b0 : _DOUT[4];
   assign   _DOUT_INT[5]	= _DIRES ? 1'b0 : _DOUT[5];
   assign   _DOUT_INT[6]	= _DIRES ? 1'b0 : _DOUT[6];
   assign   _DOUT_INT[7]	= _DIRES ? 1'b0 : _DOUT[7];
   assign   _DOUT_INT[8]	= _DIRES ? 1'b0 : _DOUT[8];
   assign   _DOUT_INT[9]	= _DIRES ? 1'b0 : _DOUT[9];
   assign   _DOUT_INT[10]	= _DIRES ? 1'b0 : _DOUT[10];
   assign   _DOUT_INT[11]	= _DIRES ? 1'b0 : _DOUT[11];
   assign   _DOUT_INT[12]	= _DIRES ? 1'b0 : _DOUT[12];
   assign   _DOUT_INT[13]	= _DIRES ? 1'b0 : _DOUT[13];
   assign   _DOUT_INT[14]	= _DIRES ? 1'b0 : _DOUT[14];
   assign   _DOUT_INT[15]	= _DIRES ? 1'b0 : _DOUT[15];
   assign   _DOUT_INT[16]	= _DIRES ? 1'b0 : _DOUT[16];
   assign   _DOUT_INT[17]	= _DIRES ? 1'b0 : _DOUT[17];
   assign   _DOUT_INT[18]	= _DIRES ? 1'b0 : _DOUT[18];
   assign   _DOUT_INT[19]	= _DIRES ? 1'b0 : _DOUT[19];
   assign   _DOUT_INT[20]	= _DIRES ? 1'b0 : _DOUT[20];
   assign   _DOUT_INT[21]	= _DIRES ? 1'b0 : _DOUT[21];
   assign   _DOUT_INT[22]	= _DIRES ? 1'b0 : _DOUT[22];
   assign   _DOUT_INT[23]	= _DIRES ? 1'b0 : _DOUT[23];
   assign   _DOUT_INT[24]	= _DIRES ? 1'b0 : _DOUT[24];
   assign   _DOUT_INT[25]	= _DIRES ? 1'b0 : _DOUT[25];
   assign   _DOUT_INT[26]	= _DIRES ? 1'b0 : _DOUT[26];
   assign   _DOUT_INT[27]	= _DIRES ? 1'b0 : _DOUT[27];
   assign   _DOUT_INT[28]	= _DIRES ? 1'b0 : _DOUT[28];
   assign   _DOUT_INT[29]	= _DIRES ? 1'b0 : _DOUT[29];
   assign   _DOUT_INT[30]	= _DIRES ? 1'b0 : _DOUT[30];
   assign   _DOUT_INT[31]	= _DIRES ? 1'b0 : _DOUT[31];
   assign   _TRIM[31:0] = _SR_MEMORY[127];

   // define busy phases

   and      (_CE_RDYq, CE, ~_RDY, _FUNC_MODE);                       	// SR access RD, WR [functional mode]
   and      (_HR_RDYq, HR, ~_RDY, _FUNC_MODE);                       	// NV access RCL    [functional mode]
   and      (_HS_RDYq, HS, ~_RDY, _FUNC_MODE);                       	// NV access STR    [functional mode]

   and      (_RDY_FM, ~RDY, _FUNC_MODE);                             	// general access   [functional mode]
   and      (_RDY_DM, ~_RDY_CORE, ~_FUNC_MODE);                       	// general access   [diagnostic mode]

   or       (_BUSY, _RDY_FM, _RDY_DM); 					// general NVRAM BUSY signal

   and      (_WEPORq, WE, ~POR, DRSTN);

   // define memory select modes

   and      (_MEM1_SEL, _MEM_ALLC, ~_MEM_SEL);
   and      (_MEM2_SEL, _MEM_ALLC,  _MEM_SEL);

   or       (_MEM1_ENT, _MEM1_SEL, ~_MEM_ALLC);
   or       (_MEM2_ENT, _MEM2_SEL, ~_MEM_ALLC);


//--------------------------------------------------------------------------
// Initial Task

   initial begin
      if( verbose ) $display("%.1fns XNVR %m : WARNING : \tTHIS IS A BEHAVIORAL MODEL WITH DEFAULT WORST CASE TIMING --->", 	$realtime);
      if( verbose ) $display("%.1fns XNVR %m : WARNING : \tTO USE THE CORRECT TIMING PLEASE ANNOTATE SDF TIMING !!!\n", 	$realtime);
      i           = 0;
      _RD	  = 0;
      _WR	  = 0;
      _RCL        = 0;
      _STR        = 0;
      _PEND	  = 0;
   end

//--------------------------------------------------------------------------
// General Tasks

   function valid_address;
      input [addrSize-1:0] A;
      begin
	 valid_address = (^(A) !== 1'bx && ^(A) !== 1'bz);
      end
   endfunction // valid_address

   function valid_data;
      input [extWidth-1:0] DIN;
      begin
	 valid_data = (^(DIN) !== 1'bx && ^(DIN) !== 1'bz);
      end
   endfunction // valid_data

//--------------------------------------------------------------------------

   task readErr;
      begin
	 _RD		= 0;
	 _RDY_CORE	= 1'bx;

	 _DOUT_CORE	= {extWidth {1'bx}};

	 disable readMode.doREAD;
	 if( debugMode ) $display("%.1fns XNVR %m : ERROR : READ CYCLE disabled ... address 'h%h", $realtime, _A);
      end
   endtask // readErr

   task writeErr;
      begin
	 _WR		= 0;
	 _RDY_CORE	= 1'bx;
	 _SR_MEMORY[_A]	= {intWidth {1'bx}};

	 _DOUT_CORE	= {extWidth {1'bx}};

	 disable writeMode.doWRITE;
	 if( debugMode ) $display("%.1fns XNVR %m : ERROR : WRITE CYCLE disabled ... sr_memory['h%h]", $realtime, _A);
      end
   endtask // writeErr

   task writeMemoryErr;
      begin
	 _WR		= 0;
	 _RDY_CORE	= 1'bx;
	 for(j = 0; j < coreSize; j = j + 1) _SR_MEMORY[j] = {intWidth {1'bx}};

	 _DOUT_CORE	= {extWidth {1'bx}};

	 disable writeMode.doWRITE;
	 if( debugMode ) $display("%.1fns XNVR %m : ERROR : WRITE CYCLE disabled ... sr_memory['h%h...'h%h]", $realtime, stop_MEM2, start_MEM1);
      end
   endtask // writeMemoryErr

   task storeErr;
      begin
	 if( _MEM1_ENT ) begin
	    for(j = start_MEM1; j <= stop_MEM1; j = j + 1) _NV_MEMORY[j] = {intWidth {1'bx}};
	    if( debugMode ) $display("%.1fns XNVR %m : ERROR : STORE CYCLE disabled ... nv_memory['h%h...'h%h]", $realtime, stop_MEM1, start_MEM1);
	 end // if ( _MEM1_ENT )
	 if( _MEM2_ENT ) begin
	    for(j = start_MEM2; j <= stop_MEM2; j = j + 1) _NV_MEMORY[j] = {intWidth {1'bx}};
	    if( debugMode ) $display("%.1fns XNVR %m : ERROR : STORE CYCLE disabled ... nv_memory['h%h...'h%h]", $realtime, stop_MEM2, start_MEM2);
	 end // if ( _MEM2_ENT )
         _BUSYNVC	= 1'bx;
	 _RDY_CORE	= 1'bx;
	 _STR		= 0;
	 i		= 0;
	 disable storeMode.doSTORE;
      end
   endtask // storeErr

   task recallErr;
      begin
	 for(j = 0; j < coreSize; j = j + 1) _SR_MEMORY[j] = {intWidth {1'bx}};
         _BUSYNVC	= 1'bx;
	 _RDY_CORE	= 1'bx;
	 _RCL		= 0;
	 i		= 0;
	 disable recallMode.doRECALL;
	 if( debugMode ) $display("%.1fns XNVR %m : ERROR : RECALL CYCLE disabled ... sr_memory['h%h...'h%h]", $realtime, stop_MEM2, start_MEM1);
      end
   endtask // recallErr

   task shiftErr;
      begin
	 _WRP			= {wrpLength {1'bx}};
	 _DSO_WRP	= 1'bx;
	 disable shiftMode.doSHIFT;
	 if( debugMode ) $display("%.1fns XNVR %m : ERROR : SHIFT CYCLE failed ...", $realtime);
      end
   endtask // shiftErr

//--------------------------------------------------------------------------

   task readMode;
      begin : doREAD
	 _RD		= 0;
	 _RDY_CORE	= 1'b1;

	 _DOUT_CORE	= _SR_MEMORY[_A];

         if( debugMode )  $display("%.1fns XNVR %m : INFO : READ CYCLE ... data = _SR_MEMORY['h%h] = %b ('h%h)", $realtime, _A, _MEM[extWidth-1:0], _MEM[extWidth-1:0]);
      end // block: doREAD
   endtask // readMode

   task writeMode;
      begin : doWRITE
	 _WR		= 0;
	 _RDY_CORE	= 1'b1;

	 _SR_MEMORY[_A]	= _DIN;
	 _DOUT_CORE	= _DIN;

	 if( _A >= 127 ) if( verbose ) $display("%.1fns XNVR %m : !!! ATTENTION !!! : TRIM BITS ARE CHANGED !!!", $realtime);
         if( debugMode ) $display("%.1fns XNVR %m : INFO : WRITE CYCLE ... _SR_MEMORY['h%h] = data = %b ('h%h)", $realtime, _A, _DIN, _DIN);
      end // block: doWRITE
   endtask // writeMode

   task storeMode;
      begin : doSTORE
	 _RDY_CORE     <= repeat(3) @(posedge _CLKI) 1'b1;
         _BUSYNVC      <= repeat(3) @(posedge _CLKI) 1'b1;
	 i		= 0;
	 if( _MEM1_ENT ) begin
	    for(j = start_MEM1; j <= stop_MEM1; j = j + 1) _NV_MEMORY[j] = _SR_MEMORY[j];
	    if( debugMode ) $display("%.1fns XNVR %m : INFO : STORE CYCLE ... _NV_MEMORY['h%h...'h%h]", $realtime, stop_MEM1, start_MEM1);
	 end // if ( _MEM1_ENT )
	 if( _MEM2_ENT ) begin
	    for(j = start_MEM2; j <= stop_MEM2; j = j + 1) _NV_MEMORY[j] = _SR_MEMORY[j];
	    if( debugMode ) $display("%.1fns XNVR %m : INFO : STORE CYCLE ... _NV_MEMORY['h%h...'h%h]", $realtime, stop_MEM2, start_MEM2);
	 end // if ( _MEM2_ENT )
      end // block: doSTORE
   endtask // storeMode

   task recallMode;
      begin : doRECALL
	 for(j = 0; j < coreSize; j = j + 1) _SR_MEMORY[j] = _NV_MEMORY[j];
	 _RDY_CORE	= 1'b1;
      #1 _BUSYNVC	= 1'b1;
	 _RCL		= 0;
	 _RCLT		= 1'b0;
	 i		= 0;
	 if( debugMode ) $display("%.1fns XNVR %m : INFO : RECALL CYCLE ... _SR_MEMORY['h%h...'h%h]", $realtime, stop_MEM2, start_MEM1);
      end // block: doRECALL
   endtask // recallMode

   task shiftMode;
      begin : doSHIFT
         for(j = 0; j < wrpLength; j = j + 1) _WRP[j] = _WRP[j+1];
	 _WRP[wrpLength-1] = DSI;

	   _DSO_WRP	= _WRP[0];

	 if( debugMode ) $display("%.1fns XNVR %m : INFO : SHIFT CYCLE ... _WRP[%g:0] = %b (%h) / DSO_WRP = %b", $realtime, wrpLength-1, _WRP, _WRP, _WRP[0]);
      end // block: doSHIFT
   endtask // shiftMode


//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//----- FUNCTIONAL MODE ----------------------------------------------------

   always @( posedge CE ) begin
      if(  WE && _FUNC_MODE ) 	_WR = 1;
      if( ~WE && _FUNC_MODE ) 	_RD = 1;
   end // always @ (posedge CE)

   always @( posedge HS ) begin
      if( _CLK && _FUNC_MODE ) 	_HS = 1;
   end // always @ (posedge HS)

   always @( posedge HR ) begin
      if( _CLK && _FUNC_MODE ) 	_HR = 1;
   end // always @ (posedge HR)

   always @( _DOUT_CORE ) begin
      if( _FUNC_MODE ) begin
         for(j = 0; j < wrpDOUT_msb - wrpDOUT_lsb + 1; j = j + 1) _WRP[wrpDOUT_msb-j] = _DOUT_CORE[j];
	 _DOUT   = _DOUT_CORE;
      end // if ( _FUNC_MODE )
   end // always @ ( _DOUT_CORE )

   always @( _RDY_CORE ) begin
      if( _FUNC_MODE ) begin
         _WRP[1] = _RDY_CORE;
	 _RDY    = _RDY_CORE;
      end // if ( _FUNC_MODE )
   end // always @ ( _RDY_CORE )


//--------------------------------------------------------------------------
// READ CYCLE (start)

   always @( posedge _RD ) begin
      if( _RD ) begin
         casez({valid_address(_A)})
	   1'b0: begin
	      if( verbose ) $display("%.1fns XNVR %m : ERROR : Address 'h%h is unknown !", $realtime, _A);
	      readErr;
	      end // case: 1'b0
	   1'b1: begin
             _DOUT_CORE   <= {extWidth {1'bx}};
	      _RDY_CORE 	<= 1'b0;
	      end // case: 1'b1
         endcase // casez({valid_address(_A)})
      end
   end // always @ ( posedge _RD )

//--------------------------------------------------------------------------
// WRITE CYCLE (start)

   always @( posedge _WR ) begin
      if( _WR ) begin
         casez({valid_address(_A)})
	   1'b0: begin
	      if( verbose ) $display("%.1fns XNVR %m : ERROR : Address 'h%h is unknown !", $realtime, _A);
	      writeMemoryErr;
	      end // case: 1'b0
	   1'b1: begin
	      casez({valid_data(_DIN)})
	        1'b0: begin
		   if( verbose ) $display("%.1fns XNVR %m : ERROR : Data 'h%h is unknown !", $realtime, _DIN);
		   writeErr;
	        end // case: 1'b0
	        1'b1: begin
                  _DOUT_CORE      <= {extWidth {1'bx}};
	           _RDY_CORE	<= 1'b0;
	        end // case: 1'b1
	      endcase // casez({valid_data(_DIN)})
	   end // case: 1'b1
         endcase // casez({valid_address(_A)})
      end
   end // always @ ( posedge _WR )

//--------------------------------------------------------------------------
// STORE CYCLE (start)

   always @( posedge _HS ) begin
      if( _HS ) begin : doSTORE_START
         _BUSYNVC   = 1'b0;
         _RDY_CORE  = 1'b0;
         _STR      <= @(posedge _CLKI) 1;
         _VSESTART <= repeat (3) @(negedge _CLKI) 1'b1;
      end
   end // always @ ( posedge _HS )

//--------------------------------------------------------------------------
// RECALL CYCLE (start)

   always @( posedge _HR ) begin
      if( _HR ) begin : doRECALL_START
         _BUSYNVC   = 1'b0;
         _RDY_CORE  = 1'b0;
         _RCL      <= @(posedge _CLKI) 1;
         _RCLT     <= @(posedge _CLKI) 1'b1;
      end
   end // always @ ( posedge _HR )

//--------------------------------------------------------------------------
// STORE CYCLE (cancel caused by hazard)

   always @( negedge HS ) begin
      _HS       = 0;
      if( ~_STR ) begin
         disable doSTORE_START;
         _RDY_CORE = 1'b1;
      end // if ( ~_STR )
   end // always @ ( negedge HS )

//--------------------------------------------------------------------------
// RECALL CYCLE (cancel caused by hazard)

   always @( negedge HR ) begin
      _HR       = 0;
      if( ~_RCL ) begin
         disable doRECALL_START;
         _RDY_CORE = 1'b1;
      end // if ( ~_RCL )
   end // always @ ( negedge HR )

//--------------------------------------------------------------------------
// READ/WRITE CYCLE (finished normally)

   always @( posedge _RDY_FM ) begin
      if( _RD  && _RDY_CORE !== 1'bx ) readMode;
      if( _WR  && _RDY_CORE !== 1'bx ) writeMode;
   end // always @ ( posedge _RDY_FM )

   always @( posedge _RDY_DM ) begin
      if( _RD  && _RDY_CORE !== 1'bx ) #1 readMode;
      if( _WR  && _RDY_CORE !== 1'bx ) #1 writeMode;
   end // always @ ( posedge _RDY_DM )

//--------------------------------------------------------------------------
// STORE CYCLE (finished normally)

   always @( posedge _STR ) begin
      _STR    = repeat(2) @(negedge VSEBUSY) 0;
   end // always @ ( posedge _STR )

   always @( negedge _STR ) begin
      if( ~_RDY_CORE ) storeMode;
   end // always @ ( negedge _STR )

//--------------------------------------------------------------------------
// RECALL CYCLE (finished normally)

   always @( posedge _CLKI ) begin
      if( _RCL ) begin
         i = i + 1;
         if( i == 9 ) recallMode;
      end // if ( _RCL )
   end // always @ ( posedge _CLKI )

   always @( negedge _CLKI ) begin
      if( _STR ) begin
	 i = i + 1;
	 if( i == 3 ) _VSESTART = 1'b0;
      end // if ( _STR )
   end // always @ ( negedge _CLKI )

//**************************************************************************
//***** DIAGNOSTIC MODE ****************************************************
//**************************************************************************

   always @( posedge _CE ) begin
      if(  _WE && ~_FUNC_MODE )   _WR = 1;
      if( ~_WE && ~_FUNC_MODE )   _RD = 1;
   end // always @ (posedge _CE)


//--------------------------------------------------------------------------
// WRAPPER SHIFT/CAPTURE CYCLE

   always @( posedge _DSCLK ) begin
      if( _DSCLK ) begin
         if( _FUNC_MODE ) begin
            if( verbose ) $display("%.1fns XNVR %m : INFO : Start DIAGNOSTIC MODE ...", $realtime);
	    _FUNC_MODE = 0;
         end // if( _FUNC_MODE )
         if( ~_CAPTURE_SH && _RDY_CORE ) begin
	    shiftMode;
         end // if ( ~_CAPTURE_SH && _RDY_CORE )
         if( _CAPTURE_SH ) begin
	    _WRP[wrpHR] 				= HR;
	    _WRP[wrpHS] 				= HS;
	    _WRP[wrpCLK]                 = 1'b0;
            _WRP[wrpTM_NVCP_msb:wrpTM_NVCP_lsb]	= TM_NVCP;
	    _WRP[wrpMEM_ALLC]            		= MEM_ALLC;
	    _WRP[wrpMEM_SEL]             		= MEM_SEL;
	    _WRP[wrpA_msb:wrpA_lsb]      		= A;
	    _WRP[wrpCE]                  		= CE;
	    _WRP[wrpWE]                  		= WE;
	    _WRP[wrpDIN_msb:wrpDIN_lsb]  		= DIN;
	    for(j = 0; j < wrpDOUT_msb - wrpDOUT_lsb + 1; j = j + 1) _WRP[wrpDOUT_msb-j] = _DOUT_CORE[j];
	    _WRP[1]                      		= _RDY_CORE;
	    _WRP[0]                      		= POR;
	    _DSO_WRP			      		= _WRP[0];


	    if( debugMode ) $display("%.1fns XNVR %m : INFO : CAPTURE CYCLE ...", $realtime);
	    if( debugMode ) $display("%.1fns XNVR %m : INFO :               ... HR = %h, HS = %h, CLK = %h, A = %h", $realtime, HR, HS, CLK, A);
	    if( debugMode ) $display("%.1fns XNVR %m : INFO :               ... TM_NVCP = %h", $realtime, TM_NVCP);
	    if( debugMode ) $display("%.1fns XNVR %m : INFO :               ... CE = %h, WE = %h, DIN = %h, DOUT = %h", $realtime, CE, WE, DIN, _DOUT_CORE);
	    if( debugMode ) $display("%.1fns XNVR %m : INFO :               ... RDY = %h, POR = %h", $realtime, _RDY_CORE, POR);
	    if( debugMode ) $display("%.1fns XNVR %m : INFO :               ... _WRP[%g:0] = %b (%h)", $realtime, wrpLength-1, _WRP, _WRP);


         end // if ( _CAPTURE_SH )
      end
   end // always @ ( posedge _DSCLK )

//--------------------------------------------------------------------------
// WRAPPER SHIFT/UPDATE CYCLE

   always @( posedge DUP ) begin
      if( DUP ) begin
         if ( _WRP[wrpCE] ==  1'b0 ) begin
            _CE		= 0;
            if (_WRP[91:82] == 10'b0000000010) begin
	       if ( ~_HR && ~_HS ) begin
                  #1 _HR	= 1;
                  if( debugMode ) $display("%.1fns XNVR %m : INFO : Start NV RECALL Cycle !", $realtime);
	       end
	       _HS		= 0;
            end
            if (_WRP[91:82] == 10'b0000000001) begin
	       if ( ~_HR && ~_HS ) begin
                  #1 _HS	= 1;
	          if( debugMode ) $display("%.1fns XNVR %m : INFO : Start normal NV STORE Cycle !", $realtime);
	       end
	       _HR		= 0;
            end
         end
         else begin
	    _CE		= 1;
         end
         if (_WRP[91:82] == 10'b0000000000) begin
            #1 _HS		= 0;
	    _HR		= 0;
         end
         if (_WRP[91:82] == 10'b1000000000) _CAPTURE_SH = 1;
         if( ~_FUNC_MODE ) begin
	    for(j = 0; j < wrpTM_NVCP_msb - wrpTM_NVCP_lsb + 1; j = j + 1)	_TM_NVCP[j]	= _WRP[wrpTM_NVCP_lsb+j];
	    for(j = 0; j < wrpDOUT_msb - wrpDOUT_lsb + 1;       j = j + 1)	_DOUT[j]	= _WRP[wrpDOUT_msb-j];
	    _RDY 		= _WRP[1];
         end
      end
   end // always @ ( posedge DUP )

   always @( posedge DUP ) begin
      if( DUP ) begin
         if (_WRP[90] == 1'b1) begin
            if (_WRP[91:82] 		== 10'b0100010100) _PEND       =  1;
            else if (_WRP[91:82] 	== 10'b0100010101) _PEND       =  1'bx;
            else if (_WRP[91:82] 	== 10'b0100010110) _PEND       =  1'bx;
            else if (_WRP[91:84] 	== 8'b01111111) 		  _PEND       =  0;
            else begin
               if( verbose ) $display("%.1fns XNVR %m : WARNING : XBUS-Configuration not allowed, after correction newstart of simulation !", $realtime);
               _PEND 	= 1'bx;
               _RDY_CORE 	= 1'bx;
               _BUSYNVC 	= 1'bx;
            end
         end
      end
   end

   always @( posedge _HS) begin
       if( _HS && _PEND === 1'bx ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : StoreError _PEND is unknown  during NV Store Cycle !", $realtime); storeErr; end
   end

   always @( negedge _DSCLK ) begin
      if( ~_DSCLK ) _CAPTURE_SH 	= 0;
   end // always @ ( negedge _DSCLK )


//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//----- GENERAL CHECKS AND SETTINGS ----------------------------------------

//--------------------------------------------------------------------------
// necessary to do HOLD time checks after posedge RDY

   always @( posedge _RD or posedge _WR or posedge _HS or posedge _HR or posedge _DIRES ) begin
      _RD_CYCLE  = 1'b0;
      _WR_CYCLE  = 1'b0;
      _STR_CYCLE = 1'b0;
      _RCL_CYCLE = 1'b0;
      if( _RD )  _RD_CYCLE = 1'b1;
      if( _WR )  _WR_CYCLE = 1'b1;
      if( _HS ) _STR_CYCLE = 1'b1;
      if( _HR ) _RCL_CYCLE = 1'b1;
   end // always @ (posedge _RD ...)

//--------------------------------------------------------------------------
// CHECKS

   always @( posedge POR ) begin
      if( POR === 1'bx || POR === 1'bz )		if( verbose ) $display("%.1fns XNVR %m : ERROR : POR is unknown !", 	$realtime);
      if( _FUNC_MODE ) 					_WRP[0] = POR;
      if( _BUSY && _WR_CYCLE ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : Global Reset during SRAM Write Cycle !", $realtime); writeErr;  end
      else begin
         if( _BUSY && _RD_CYCLE ) begin
	    if( verbose ) $display("%.1fns XNVR %m : ERROR : Global Reset during SRAM Read Cycle !",  $realtime); readErr;   end
	 else begin
	    if( _BUSY && _RCL_CYCLE ) begin
	       if( verbose ) $display("%.1fns XNVR %m : ERROR : Global Reset during NV Recall Cycle !",  $realtime); recallErr; end
	    else begin
	       if( _BUSY && _STR_CYCLE ) begin
	          if( verbose ) $display("%.1fns XNVR %m : ERROR : Global Reset during NV Store Cycle !",   $realtime); storeErr;  end
               else begin
                  if( verbose ) $display("%.1fns XNVR %m : INFO : Global Reset to FUNCTIONAL MODE ...", $realtime);
                  _WRP[91:82] = 10'b0;
	          _HS	= 0;
	          _HR	= 0;
	          _CE	= 0;
	          _WRP[wrpCLK]                 = 1'b0;
                  _WRP[wrpTM_NVCP_msb:wrpTM_NVCP_lsb]		= TM_NVCP;
	          _WRP[wrpMEM_ALLC]                        	= MEM_ALLC;
	          _WRP[wrpMEM_SEL]                         	= MEM_SEL;
	          _WRP[wrpA_msb:wrpA_lsb]                  	= A;


	          _WRP[wrpCE]                              	= CE;
	          _WRP[wrpWE]                              	= WE;
	          _WRP[wrpDIN_msb:wrpDIN_lsb]              	= DIN;
	          _FUNC_MODE                               	= 1;
                  _RDY_CORE                                	= 0;
	          _RCLT                                    	= 0;
	          _VSESTART                                	= 0;
	          _BUSYNVC					= 1;
	          _TM_NVCP					= TM_NVCP;
	       end
	    end
	 end
      end // if( _BUSY )
   end // always @ ( posedge POR )

   always @( negedge POR ) begin
      if( POR === 1'bx || POR === 1'bz )		if( verbose ) $display("%.1fns XNVR %m : ERROR : POR is unknown !", 	$realtime);
      if( _FUNC_MODE ) 					_WRP[0] = POR;
      _RDY_CORE 					= 1;
      _RD						= 0;
      _WR						= 0;
      _STR 						= 0;
      _RCL 						= 0;
      _PEND	  					= 0;
      i    						= 0;
   end // always @ ( negedge POR )

   always @( negedge DRSTN ) begin
      if( DRSTN === 1'bx || DRSTN === 1'bz )	if( verbose ) $display("%.1fns XNVR %m : ERROR : DRSTN is unknown !", 	$realtime);
      if( _BUSY && _FUNC_MODE ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Wrapper Reset during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Wrapper Reset during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Wrapper Reset during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Wrapper Reset during NV Store Cycle !",   $realtime); storeErr;  end
      end // if (_BUSY)
      else begin
         if( verbose ) $display("%.1fns XNVR %m : INFO : Wrapper Reset to FUNCTIONAL MODE ...", $realtime);
         _WRP[91:82] = 10'b0;
	 _HS	= 0;
	 _HR	= 0;
	 _CE	= 0;
	 _WRP[wrpCLK]                 = 1'b0;
         _WRP[wrpTM_NVCP_msb:wrpTM_NVCP_lsb]		= TM_NVCP;
	 _WRP[wrpMEM_ALLC]                        	= MEM_ALLC;
	 _WRP[wrpMEM_SEL]                         	= MEM_SEL;
	 _WRP[wrpA_msb:wrpA_lsb]                  	= A;


	 _WRP[wrpCE]                              	= CE;
	 _WRP[wrpWE]                              	= WE;
	 _WRP[wrpDIN_msb:wrpDIN_lsb]              	= DIN;
	 _FUNC_MODE                               	= 1;
         _DSO_WRP				= 0;
	 _TM_NVCP					= TM_NVCP;


      end // if( _BUSY )
   end // always @ ( negedge DRSTN )

   always @( posedge DRSTN ) begin
      if( DRSTN === 1'bx || DRSTN === 1'bz )	if( verbose ) $display("%.1fns XNVR %m : ERROR : DRSTN is unknown !", 	$realtime);
      _RDY_CORE 					= 1;
   end // always @ ( posedge DRSTN )

   always @( A ) begin
      if( _FUNC_MODE ) 					_WRP[wrpA_msb:wrpA_lsb] = A;
      if( _BUSY ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Addresse(s) are changed during SRAM Write Cycle !",  $realtime); writeMemoryErr; end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : Addresse(s) are changed during SRAM Read Cycle !",   $realtime); readErr; end
      end // if ( _BUSY )
   end // always @ ( A )

   always @( CE ) begin
      if( _FUNC_MODE ) 					_WRP[wrpCE] = CE;
      if( CE === 1'bx || CE === 1'bz ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : ACCESS while CE is unknown !", $realtime);
	 if( ~WE ) readErr;
	 if(  WE ) writeErr;
      end // if ( CE === 1'bx && CE === 1'bz )
      if( CE === 1'b1 && DSCLK === 1'b1 ) begin
	 if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK must be hold at LOW while nvRAM is busy !", $realtime);
	 if( ~WE ) writeErr;
	 if(  WE ) readErr;
      end // if ( CE === 1'b1 && DSCLK === 1'b1 )
      if( CE === 1'b1 && ( POR === 1'b1 || DRSTN === 1'b0 )) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : ACCESS while RESET is active !", $realtime);
	 if( ~WE ) readErr;
	 if(  WE ) writeErr;
      end // if ( CE === 1'b1 && ( POR === 1'b1 || DRSTN === 1'b0 ))
      if( _BUSY && CE === 1'b1 ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : CE is changed during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : CE is changed during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : CE is changed during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : CE is changed during NV Store Cycle !",   $realtime); storeErr;  end
      end // if ( _BUSY && CE === 1'b1 )
   end // always @ ( CE )

   always @( CLK ) begin
      if( _FUNC_MODE ) 					_WRP[wrpCLK] = CLK;
      if( CLK === 1'bx || CLK === 1'bz ) begin
         if( _BUSY ) begin
            if( verbose ) $display("%.1fns XNVR %m : ERROR : CLK is unknown !", $realtime);
	    if( _STR_CYCLE ) storeErr;
	    if( _RCL_CYCLE ) recallErr;
         end // if ( _BUSY )
      end // if( CLK === 1'bx || CLK === 1'bz )
   end // always @ ( CLK )

   always @( DIN ) begin
      if( _FUNC_MODE ) 					_WRP[wrpDIN_msb:wrpDIN_lsb] = DIN;
   end // always @ (DIN )

   always @( HR ) begin
      if( HR === 1'bx || HR === 1'bz )			if( verbose ) $display("%.1fns XNVR %m : ERROR : HR is unknown !", 	$realtime);
      if( _BUSY && HR === 1'b1 ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HR is changed during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HR is changed during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HR is changed during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HR is changed during NV Store Cycle !",   $realtime); storeErr;  end
      end // if ( _BUSY && HR === 1'b1 )
   end // always @ ( HR )

   always @( HS ) begin
      if( HS === 1'bx || HS === 1'bz )			if( verbose ) $display("%.1fns XNVR %m : ERROR : HS is unknown !", 		$realtime);
      if( _BUSY && HS === 1'b1 ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HS is changed during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HS is changed during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HS is changed during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : HS is changed during NV Store Cycle !",   $realtime); storeErr;  end
      end // if ( _BUSY && HS === 1'b1 )
   end // always @ ( HS )

   always @( TM_NVCP ) begin
      if( _FUNC_MODE ) 					_WRP[wrpTM_NVCP_msb:wrpTM_NVCP_lsb] = TM_NVCP;
      if( _BUSY ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : TM_NVCP is changed during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : TM_NVCP is changed during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : TM_NVCP is changed during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : TM_NVCP is changed during NV Store Cycle !",   $realtime); storeErr;  end
      end // if ( _BUSY )
   end // always @ ( TM_NVCP )

   always @( MEM_ALLC ) begin
      if( _FUNC_MODE ) 					_WRP[wrpMEM_ALLC] = MEM_ALLC;
      if( MEM_ALLC === 1'bx || MEM_ALLC === 1'bz )	if( verbose ) $display("%.1fns XNVR %m : ERROR : MEM_ALLC is unknown !", 	$realtime);
   end // always @ ( MEM_ALLC )

   always @( MEM_SEL ) begin
      if( _FUNC_MODE ) 					_WRP[wrpMEM_SEL] = MEM_SEL;
      if( MEM_SEL === 1'bx || MEM_SEL === 1'bz )	if( verbose ) $display("%.1fns XNVR %m : ERROR : MEM_SEL is unknown !", 	$realtime);
   end // always @ ( MEM_SEL )

   always @( PEIN ) begin
      if( PEIN === 1'bx || PEIN === 1'bz )		if( verbose ) $display("%.1fns XNVR %m : ERROR : PEIN is unknown !", 	$realtime);
      if( PEIN === 1'b1 )   				if( verbose ) $display("%.1fns XNVR %m : INFO : Switch On Parallel Endurance Mode !", $realtime);
      if( PEIN === 1'b0 )   				if( verbose ) $display("%.1fns XNVR %m : INFO : Switch Off Parallel Endurance Mode !", $realtime);
   end // always @ ( PEIN )

   always @( DSCLK ) begin
      if( DSCLK === 1'bx || DSCLK === 1'bz ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK is unknown !", $realtime);
         //shiftErr;
      end
      if( _BUSY && _FUNC_MODE ) begin
	 if( _WR_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK is changed during SRAM Write Cycle !", $realtime); writeErr;  end
	 if( _RD_CYCLE  ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK is changed during SRAM Read Cycle !",  $realtime); readErr;   end
	 if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK is changed during NV Recall Cycle !",  $realtime); recallErr; end
	 if( _STR_CYCLE ) begin if( verbose ) $display("%.1fns XNVR %m : ERROR : DSCLK is changed during NV Store Cycle !",   $realtime); storeErr;  end
      end // if ( _BUSY && _FUNC_MODE )
   end // always @ ( DSCLK )

   always @( VSEBUSY ) begin
      if( VSEBUSY === 1'bx || VSEBUSY === 1'bz ) 	if( verbose ) $display("%.1fns XNVR %m : ERROR : VSEBUSY is unknown !", 	$realtime);
   end // always @ ( VSEBUSY )

   always @( WE ) begin
      if( _FUNC_MODE ) 					_WRP[wrpWE] = WE;
      if( WE === 1'bx || WE === 1'bz )			if( verbose ) $display("%.1fns XNVR %m : ERROR : WE is unknown !", 		$realtime);
   end // always @ ( WE )


   always @( VSE1 ) begin
      if( VSE1 === 1'bx || VSE1 === 1'bz ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : VSE1 is unknown !", $realtime);
      end
   end // always @ ( VSE1 )

   always @( VSE2 ) begin
      if( VSE2 === 1'bx || VSE2 === 1'bz ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : VSE2 is unknown !", $realtime);
      end
   end // always @ ( VSE2 )

   always @( DSI ) begin
      if( ~_FUNC_MODE && ( DSI === 1'bx || DSI === 1'bz ) ) begin
         if( verbose ) $display("%.1fns XNVR %m : ERROR : DSI is unknown !", $realtime);
      end
   end // always @ ( DSI )

//--------------------------------------------------------------------------
// Actions after setup&hold time violations

   always @( _NOTIF ) begin
      if( _RD_CYCLE  ) readErr;
      if( _WR_CYCLE  ) writeErr;
      if( _RCL_CYCLE ) recallErr;
      if( _STR_CYCLE ) storeErr;
   end // always @ ( _NOTIF )

   always @( _NOTIF_A ) begin
      if( _RD_CYCLE  ) readErr;
      if( _WR_CYCLE  ) writeMemoryErr;
      if( _STR_CYCLE ) storeErr;
      if( _RCL_CYCLE ) recallErr;
   end // always @ ( _NOTIF_A )

   always @( _NOTIF_PEIN ) begin
      if( _STR_CYCLE  ) storeErr;
   end // always @ ( _NOTIF_PEIN )

   always @( _NOTIF_DIN ) begin
      if( _WR_CYCLE  ) writeErr;
   end // always @ ( _NOTIF_DIN )

   always @( _NOTIF_DSI ) begin
      shiftErr;
   end // always @ ( _NOTIF_DSI )

   always @( _NOTIF_POR ) begin
      if( _BUSY === 1'b1 ) begin // no error if ciruit is cleared
         if( _RD_CYCLE  ) readErr;
         if( _WR_CYCLE  ) writeErr;
	 if( _STR_CYCLE ) storeErr;
	 if( _RCL_CYCLE ) recallErr;
      end // if ( _BUSY === 1'b1 )
   end // always @ ( _NOTIF_POR )

//--------------------------------------------------------------------------

   specify

`ifdef DEFAULT_WORST_DELAY_OFF
// unit delay:

      // Pin-to-pin delays

      // READ / WRITE CYCLE --------------------------------------------------------

      if (((WE==1'b0))) (posedge CE => (RDY +: RDY)) = (0.04, 0.02);
      if (((WE==1'b1))) (posedge CE => (RDY +: RDY)) = (0.04, 0.02);

      if (((WE==1'b0))) (posedge CE => (DOUT[0]	+: _MEM[0])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[0]	+: DIN[0])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[1]	+: _MEM[1])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[1]	+: DIN[1])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[2]	+: _MEM[2])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[2]	+: DIN[2])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[3]	+: _MEM[3])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[3]	+: DIN[3])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[4]	+: _MEM[4])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[4]	+: DIN[4])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[5]	+: _MEM[5])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[5]	+: DIN[5])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[6]	+: _MEM[6])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[6]	+: DIN[6])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[7]	+: _MEM[7])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[7]	+: DIN[7])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[8]	+: _MEM[8])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[8]	+: DIN[8])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[9]	+: _MEM[9])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[9]	+: DIN[9])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[10]	+: _MEM[10])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[10]	+: DIN[10])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[11]	+: _MEM[11])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[11]	+: DIN[11])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[12]	+: _MEM[12])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[12]	+: DIN[12])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[13]	+: _MEM[13])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[13]	+: DIN[13])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[14]	+: _MEM[14])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[14]	+: DIN[14])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[15]	+: _MEM[15])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[15]	+: DIN[15])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[16]	+: _MEM[16])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[16]	+: DIN[16])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[17]	+: _MEM[17])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[17]	+: DIN[17])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[18]	+: _MEM[18])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[18]	+: DIN[18])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[19]	+: _MEM[19])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[19]	+: DIN[19])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[20]	+: _MEM[20])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[20]	+: DIN[20])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[21]	+: _MEM[21])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[21]	+: DIN[21])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[22]	+: _MEM[22])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[22]	+: DIN[22])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[23]	+: _MEM[23])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[23]	+: DIN[23])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[24]	+: _MEM[24])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[24]	+: DIN[24])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[25]	+: _MEM[25])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[25]	+: DIN[25])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[26]	+: _MEM[26])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[26]	+: DIN[26])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[27]	+: _MEM[27])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[27]	+: DIN[27])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[28]	+: _MEM[28])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[28]	+: DIN[28])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[29]	+: _MEM[29])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[29]	+: DIN[29])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[30]	+: _MEM[30])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[30]	+: DIN[30])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[31]	+: _MEM[31])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[31]	+: DIN[31])) 	= (0.02, 0.02, 0.01);
      if (((WE==1'b1))) (posedge CE => (TRIM[0]	+: TRIM[0])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[1]	+: TRIM[1])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[2]	+: TRIM[2])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[3]	+: TRIM[3])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[4]	+: TRIM[4])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[5]	+: TRIM[5])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[6]	+: TRIM[6])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[7]	+: TRIM[7])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[8]	+: TRIM[8])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[9]	+: TRIM[9])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[10]	+: TRIM[10])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[11]	+: TRIM[11])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[12]	+: TRIM[12])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[13]	+: TRIM[13])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[14]	+: TRIM[14])) 	= (0.02, 0.02);
      if (((WE==1'b1))) (posedge CE => (TRIM[15]	+: TRIM[15])) 	= (0.02, 0.02);

      // STORE / RECALL CYCLE ----------------------------------------------

      (posedge HR   	=> (RDY      -: RDY))      = 0.02;
      (posedge HS   	=> (RDY      -: RDY))      = 0.02;

      if (((BUSYNVC==1'b0))) (posedge CLK  	=> (RDY      +: RDY))      = 0.02;


      (posedge CLK  	=> (BUSYNVC  +: BUSYNVC))     = (0.02, 0.02);

      (posedge CLK  	=> (RCLT     +: RCLT))     = (0.02, 0.02);
      (negedge CLK  	=> (VSESTART +: VSESTART)) = (0.02, 0.02);
      (posedge CLK  	=> (CLKI     +: CLKI))     = 0.02;
      (negedge CLK  	=> (CLKI     -: CLKI))     = 0.02;

      (posedge MEM_ALLC => (MEM1_ENT -: MEM1_ENT)) = 0.02;
      (posedge MEM_ALLC => (MEM2_ENT -: MEM2_ENT)) = 0.02;
      (negedge MEM_ALLC => (MEM1_ENT +: MEM1_ENT)) = 0.02;
      (negedge MEM_ALLC => (MEM2_ENT +: MEM2_ENT)) = 0.02;

      (posedge MEM_SEL  => (MEM1_ENT -: MEM1_ENT)) = 0.02;
      (posedge MEM_SEL  => (MEM2_ENT +: MEM2_ENT)) = 0.02;
      (negedge MEM_SEL  => (MEM1_ENT +: MEM1_ENT)) = 0.02;
      (negedge MEM_SEL  => (MEM2_ENT -: MEM2_ENT)) = 0.02;

      // ALL CYCLE ---------------------------------------------------------

      (posedge POR  	=> (RDY      -: RDY))      = 0.02;
      (negedge POR  	=> (RDY      +: RDY))      = 0.02;
      (posedge POR  	=> (VSESTART -: VSESTART)) = 0.02;
      (posedge POR  	=> (RCLT     -: RCLT))     = 0.02;

      (negedge DRSTN  	=> (RDY      -: RDY))      = 0.02;
      (posedge DRSTN  	=> (RDY      +: RDY))      = 0.02;

      (posedge POR  	=> (DOUT[0] -: DOUT[0])) = 0.02;
      (negedge POR  	=> (DOUT[0] +: DOUT[0])) = 0.02;
      (posedge POR  	=> (DOUT[1] -: DOUT[1])) = 0.02;
      (negedge POR  	=> (DOUT[1] +: DOUT[1])) = 0.02;
      (posedge POR  	=> (DOUT[2] -: DOUT[2])) = 0.02;
      (negedge POR  	=> (DOUT[2] +: DOUT[2])) = 0.02;
      (posedge POR  	=> (DOUT[3] -: DOUT[3])) = 0.02;
      (negedge POR  	=> (DOUT[3] +: DOUT[3])) = 0.02;
      (posedge POR  	=> (DOUT[4] -: DOUT[4])) = 0.02;
      (negedge POR  	=> (DOUT[4] +: DOUT[4])) = 0.02;
      (posedge POR  	=> (DOUT[5] -: DOUT[5])) = 0.02;
      (negedge POR  	=> (DOUT[5] +: DOUT[5])) = 0.02;
      (posedge POR  	=> (DOUT[6] -: DOUT[6])) = 0.02;
      (negedge POR  	=> (DOUT[6] +: DOUT[6])) = 0.02;
      (posedge POR  	=> (DOUT[7] -: DOUT[7])) = 0.02;
      (negedge POR  	=> (DOUT[7] +: DOUT[7])) = 0.02;
      (posedge POR  	=> (DOUT[8] -: DOUT[8])) = 0.02;
      (negedge POR  	=> (DOUT[8] +: DOUT[8])) = 0.02;
      (posedge POR  	=> (DOUT[9] -: DOUT[9])) = 0.02;
      (negedge POR  	=> (DOUT[9] +: DOUT[9])) = 0.02;
      (posedge POR  	=> (DOUT[10] -: DOUT[10])) = 0.02;
      (negedge POR  	=> (DOUT[10] +: DOUT[10])) = 0.02;
      (posedge POR  	=> (DOUT[11] -: DOUT[11])) = 0.02;
      (negedge POR  	=> (DOUT[11] +: DOUT[11])) = 0.02;
      (posedge POR  	=> (DOUT[12] -: DOUT[12])) = 0.02;
      (negedge POR  	=> (DOUT[12] +: DOUT[12])) = 0.02;
      (posedge POR  	=> (DOUT[13] -: DOUT[13])) = 0.02;
      (negedge POR  	=> (DOUT[13] +: DOUT[13])) = 0.02;
      (posedge POR  	=> (DOUT[14] -: DOUT[14])) = 0.02;
      (negedge POR  	=> (DOUT[14] +: DOUT[14])) = 0.02;
      (posedge POR  	=> (DOUT[15] -: DOUT[15])) = 0.02;
      (negedge POR  	=> (DOUT[15] +: DOUT[15])) = 0.02;
      (posedge POR  	=> (DOUT[16] -: DOUT[16])) = 0.02;
      (negedge POR  	=> (DOUT[16] +: DOUT[16])) = 0.02;
      (posedge POR  	=> (DOUT[17] -: DOUT[17])) = 0.02;
      (negedge POR  	=> (DOUT[17] +: DOUT[17])) = 0.02;
      (posedge POR  	=> (DOUT[18] -: DOUT[18])) = 0.02;
      (negedge POR  	=> (DOUT[18] +: DOUT[18])) = 0.02;
      (posedge POR  	=> (DOUT[19] -: DOUT[19])) = 0.02;
      (negedge POR  	=> (DOUT[19] +: DOUT[19])) = 0.02;
      (posedge POR  	=> (DOUT[20] -: DOUT[20])) = 0.02;
      (negedge POR  	=> (DOUT[20] +: DOUT[20])) = 0.02;
      (posedge POR  	=> (DOUT[21] -: DOUT[21])) = 0.02;
      (negedge POR  	=> (DOUT[21] +: DOUT[21])) = 0.02;
      (posedge POR  	=> (DOUT[22] -: DOUT[22])) = 0.02;
      (negedge POR  	=> (DOUT[22] +: DOUT[22])) = 0.02;
      (posedge POR  	=> (DOUT[23] -: DOUT[23])) = 0.02;
      (negedge POR  	=> (DOUT[23] +: DOUT[23])) = 0.02;
      (posedge POR  	=> (DOUT[24] -: DOUT[24])) = 0.02;
      (negedge POR  	=> (DOUT[24] +: DOUT[24])) = 0.02;
      (posedge POR  	=> (DOUT[25] -: DOUT[25])) = 0.02;
      (negedge POR  	=> (DOUT[25] +: DOUT[25])) = 0.02;
      (posedge POR  	=> (DOUT[26] -: DOUT[26])) = 0.02;
      (negedge POR  	=> (DOUT[26] +: DOUT[26])) = 0.02;
      (posedge POR  	=> (DOUT[27] -: DOUT[27])) = 0.02;
      (negedge POR  	=> (DOUT[27] +: DOUT[27])) = 0.02;
      (posedge POR  	=> (DOUT[28] -: DOUT[28])) = 0.02;
      (negedge POR  	=> (DOUT[28] +: DOUT[28])) = 0.02;
      (posedge POR  	=> (DOUT[29] -: DOUT[29])) = 0.02;
      (negedge POR  	=> (DOUT[29] +: DOUT[29])) = 0.02;
      (posedge POR  	=> (DOUT[30] -: DOUT[30])) = 0.02;
      (negedge POR  	=> (DOUT[30] +: DOUT[30])) = 0.02;
      (posedge POR  	=> (DOUT[31] -: DOUT[31])) = 0.02;
      (negedge POR  	=> (DOUT[31] +: DOUT[31])) = 0.02;
      (negedge DRSTN  	=> (DOUT[0] -: DOUT[0])) = 0.02;
      (posedge DRSTN  	=> (DOUT[0] +: DOUT[0])) = 0.02;
      (negedge DRSTN  	=> (DOUT[1] -: DOUT[1])) = 0.02;
      (posedge DRSTN  	=> (DOUT[1] +: DOUT[1])) = 0.02;
      (negedge DRSTN  	=> (DOUT[2] -: DOUT[2])) = 0.02;
      (posedge DRSTN  	=> (DOUT[2] +: DOUT[2])) = 0.02;
      (negedge DRSTN  	=> (DOUT[3] -: DOUT[3])) = 0.02;
      (posedge DRSTN  	=> (DOUT[3] +: DOUT[3])) = 0.02;
      (negedge DRSTN  	=> (DOUT[4] -: DOUT[4])) = 0.02;
      (posedge DRSTN  	=> (DOUT[4] +: DOUT[4])) = 0.02;
      (negedge DRSTN  	=> (DOUT[5] -: DOUT[5])) = 0.02;
      (posedge DRSTN  	=> (DOUT[5] +: DOUT[5])) = 0.02;
      (negedge DRSTN  	=> (DOUT[6] -: DOUT[6])) = 0.02;
      (posedge DRSTN  	=> (DOUT[6] +: DOUT[6])) = 0.02;
      (negedge DRSTN  	=> (DOUT[7] -: DOUT[7])) = 0.02;
      (posedge DRSTN  	=> (DOUT[7] +: DOUT[7])) = 0.02;
      (negedge DRSTN  	=> (DOUT[8] -: DOUT[8])) = 0.02;
      (posedge DRSTN  	=> (DOUT[8] +: DOUT[8])) = 0.02;
      (negedge DRSTN  	=> (DOUT[9] -: DOUT[9])) = 0.02;
      (posedge DRSTN  	=> (DOUT[9] +: DOUT[9])) = 0.02;
      (negedge DRSTN  	=> (DOUT[10] -: DOUT[10])) = 0.02;
      (posedge DRSTN  	=> (DOUT[10] +: DOUT[10])) = 0.02;
      (negedge DRSTN  	=> (DOUT[11] -: DOUT[11])) = 0.02;
      (posedge DRSTN  	=> (DOUT[11] +: DOUT[11])) = 0.02;
      (negedge DRSTN  	=> (DOUT[12] -: DOUT[12])) = 0.02;
      (posedge DRSTN  	=> (DOUT[12] +: DOUT[12])) = 0.02;
      (negedge DRSTN  	=> (DOUT[13] -: DOUT[13])) = 0.02;
      (posedge DRSTN  	=> (DOUT[13] +: DOUT[13])) = 0.02;
      (negedge DRSTN  	=> (DOUT[14] -: DOUT[14])) = 0.02;
      (posedge DRSTN  	=> (DOUT[14] +: DOUT[14])) = 0.02;
      (negedge DRSTN  	=> (DOUT[15] -: DOUT[15])) = 0.02;
      (posedge DRSTN  	=> (DOUT[15] +: DOUT[15])) = 0.02;
      (negedge DRSTN  	=> (DOUT[16] -: DOUT[16])) = 0.02;
      (posedge DRSTN  	=> (DOUT[16] +: DOUT[16])) = 0.02;
      (negedge DRSTN  	=> (DOUT[17] -: DOUT[17])) = 0.02;
      (posedge DRSTN  	=> (DOUT[17] +: DOUT[17])) = 0.02;
      (negedge DRSTN  	=> (DOUT[18] -: DOUT[18])) = 0.02;
      (posedge DRSTN  	=> (DOUT[18] +: DOUT[18])) = 0.02;
      (negedge DRSTN  	=> (DOUT[19] -: DOUT[19])) = 0.02;
      (posedge DRSTN  	=> (DOUT[19] +: DOUT[19])) = 0.02;
      (negedge DRSTN  	=> (DOUT[20] -: DOUT[20])) = 0.02;
      (posedge DRSTN  	=> (DOUT[20] +: DOUT[20])) = 0.02;
      (negedge DRSTN  	=> (DOUT[21] -: DOUT[21])) = 0.02;
      (posedge DRSTN  	=> (DOUT[21] +: DOUT[21])) = 0.02;
      (negedge DRSTN  	=> (DOUT[22] -: DOUT[22])) = 0.02;
      (posedge DRSTN  	=> (DOUT[22] +: DOUT[22])) = 0.02;
      (negedge DRSTN  	=> (DOUT[23] -: DOUT[23])) = 0.02;
      (posedge DRSTN  	=> (DOUT[23] +: DOUT[23])) = 0.02;
      (negedge DRSTN  	=> (DOUT[24] -: DOUT[24])) = 0.02;
      (posedge DRSTN  	=> (DOUT[24] +: DOUT[24])) = 0.02;
      (negedge DRSTN  	=> (DOUT[25] -: DOUT[25])) = 0.02;
      (posedge DRSTN  	=> (DOUT[25] +: DOUT[25])) = 0.02;
      (negedge DRSTN  	=> (DOUT[26] -: DOUT[26])) = 0.02;
      (posedge DRSTN  	=> (DOUT[26] +: DOUT[26])) = 0.02;
      (negedge DRSTN  	=> (DOUT[27] -: DOUT[27])) = 0.02;
      (posedge DRSTN  	=> (DOUT[27] +: DOUT[27])) = 0.02;
      (negedge DRSTN  	=> (DOUT[28] -: DOUT[28])) = 0.02;
      (posedge DRSTN  	=> (DOUT[28] +: DOUT[28])) = 0.02;
      (negedge DRSTN  	=> (DOUT[29] -: DOUT[29])) = 0.02;
      (posedge DRSTN  	=> (DOUT[29] +: DOUT[29])) = 0.02;
      (negedge DRSTN  	=> (DOUT[30] -: DOUT[30])) = 0.02;
      (posedge DRSTN  	=> (DOUT[30] +: DOUT[30])) = 0.02;
      (negedge DRSTN  	=> (DOUT[31] -: DOUT[31])) = 0.02;
      (posedge DRSTN  	=> (DOUT[31] +: DOUT[31])) = 0.02;
      (posedge TM_NVCP[0]  	=> (TM_NVCPI[0] +: TM_NVCPI[0])) = 0.02;
      (negedge TM_NVCP[0]  	=> (TM_NVCPI[0] -: TM_NVCPI[0])) = 0.02;
      (posedge TM_NVCP[1]  	=> (TM_NVCPI[1] +: TM_NVCPI[1])) = 0.02;
      (negedge TM_NVCP[1]  	=> (TM_NVCPI[1] -: TM_NVCPI[1])) = 0.02;
      (posedge TM_NVCP[2]  	=> (TM_NVCPI[2] +: TM_NVCPI[2])) = 0.02;
      (negedge TM_NVCP[2]  	=> (TM_NVCPI[2] -: TM_NVCPI[2])) = 0.02;
      (posedge TM_NVCP[3]  	=> (TM_NVCPI[3] +: TM_NVCPI[3])) = 0.02;
      (negedge TM_NVCP[3]  	=> (TM_NVCPI[3] -: TM_NVCPI[3])) = 0.02;

      // SHIFT CYCLE -------------------------------------------------------

      if (((BUSYNVC==1'b1))) (posedge DSCLK 	=> (DSO		+: DSO))		= (0.02, 0.02);
      (negedge DRSTN	=> (DSO		-: DSO))		= 0.02;

      // Setup & Hold Timing Checks ----------------------------------------

      $setuphold(posedge CE &&& ~POR,  posedge A[0], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[0], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[0], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[0], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[1], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[1], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[1], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[1], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[2], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[2], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[2], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[2], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[3], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[3], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[3], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[3], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[4], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[4], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[4], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[4], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[5], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[5], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[5], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[5], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  posedge A[6], 0.02, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR,  negedge A[6], 0.02, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[6], 0, 0.02, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[6], 0, 0.02, _NOTIF_A);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[0], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[0], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[0], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[0], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[1], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[1], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[1], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[1], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[2], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[2], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[2], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[2], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[3], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[3], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[3], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[3], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[4], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[4], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[4], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[4], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[5], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[5], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[5], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[5], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[6], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[6], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[6], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[6], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[7], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[7], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[7], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[7], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[8], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[8], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[8], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[8], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[9], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[9], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[9], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[9], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[10], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[10], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[10], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[10], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[11], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[11], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[11], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[11], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[12], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[12], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[12], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[12], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[13], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[13], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[13], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[13], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[14], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[14], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[14], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[14], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[15], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[15], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[15], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[15], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[16], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[16], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[16], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[16], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[17], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[17], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[17], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[17], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[18], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[18], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[18], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[18], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[19], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[19], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[19], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[19], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[20], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[20], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[20], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[20], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[21], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[21], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[21], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[21], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[22], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[22], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[22], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[22], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[23], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[23], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[23], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[23], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[24], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[24], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[24], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[24], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[25], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[25], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[25], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[25], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[26], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[26], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[26], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[26], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[27], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[27], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[27], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[27], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[28], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[28], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[28], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[28], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[29], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[29], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[29], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[29], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[30], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[30], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[30], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[30], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[31], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[31], 0.02, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[31], 0, 0.02, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[31], 0, 0.02, _NOTIF_DIN);

      $setuphold(posedge DSCLK &&& ~POR, posedge DUP, 0.02, 0.02, _NOTIF);
      $setuphold(posedge DSCLK &&& ~POR, negedge DUP, 0.02, 0.02, _NOTIF);


      $setuphold(posedge DSCLK &&& ~POR, posedge DSI, 0.02, 0.02, _NOTIF_DSI);
      $setuphold(posedge DSCLK &&& ~POR, negedge DSI, 0.02, 0.02, _NOTIF_DSI);

      $setuphold(posedge CE &&& ~POR, posedge WE, 0.02, 0, _NOTIF);
      $setuphold(posedge CE &&& ~POR, negedge WE, 0.02, 0, _NOTIF);


      $setuphold(posedge CE &&& ~POR, posedge WE, 0, 0.02, _NOTIF);
      $setuphold(posedge CE &&& ~POR, negedge WE, 0, 0.02, _NOTIF);


      $setuphold(posedge HS,  posedge MEM_ALLC, 0.02, 0, _NOTIF);
      $setuphold(posedge HS,  negedge MEM_ALLC, 0.02, 0, _NOTIF);
      $setuphold(posedge RDY, posedge MEM_ALLC, 0, 0.02, _NOTIF);
      $setuphold(posedge RDY, negedge MEM_ALLC, 0, 0.02, _NOTIF);

      $setuphold(posedge HS,  posedge MEM_SEL, 0.02, 0, _NOTIF);
      $setuphold(posedge HS,  negedge MEM_SEL, 0.02, 0, _NOTIF);
      $setuphold(posedge RDY, posedge MEM_SEL, 0, 0.02, _NOTIF);
      $setuphold(posedge RDY, negedge MEM_SEL, 0, 0.02, _NOTIF);

      $setuphold(posedge RDY,     posedge CE, 0, 0.02, _NOTIF);
      $setuphold(posedge BUSYNVC, posedge HR, 0, 0.02, _NOTIF);
      $setuphold(posedge BUSYNVC, posedge HS, 0, 0.02, _NOTIF);

      $setuphold(posedge HS &&& ~POR,  posedge PEIN, 0.02, 0, _NOTIF_PEIN);
      $setuphold(posedge HS &&& ~POR,  negedge PEIN, 0.02, 0, _NOTIF_PEIN);
      $setuphold(posedge RDY &&& ~POR, posedge PEIN, 0, 0.02, _NOTIF_PEIN);
      $setuphold(posedge RDY &&& ~POR, negedge PEIN, 0, 0.02, _NOTIF_PEIN);

      // Recovery checks

      $recrem(negedge POR, posedge CE, 0.42, 0, _NOTIF);
      $recrem(negedge POR, posedge HR, 10.00, 0, _NOTIF);
      $recrem(negedge POR, posedge HS, 10.00, 0, _NOTIF);

      // Pulse-width checks

      $width(posedge POR, 3.15:4.63:8.01, 0, _NOTIF_POR);
      $width(posedge CE,  0.57:0.88:1.64, 0, _NOTIF);
      $width(posedge CLK  &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);
      $width(negedge CLK  &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);

      $width(posedge HR,  337.50, 0, _NOTIF);
      $width(posedge HS,  337.50, 0, _NOTIF);

      $width(negedge HR,  337.50, 0, _NOTIF);
      $width(negedge HS,  337.50, 0, _NOTIF);
      $width(negedge DRSTN, 3.07:4.49:7.76, 0, _NOTIF_POR);

      $width(posedge DSCLK, 50.00:50.00:50.00, 0, _NOTIF);
      $width(negedge DSCLK, 50.00:50.00:50.00, 0, _NOTIF);
      // Period checks

      $period(posedge CE,  7.49:11.71:20.99, _NOTIF);
      $period(posedge CLK  &&& ~BUSYNVC, 225.00:225.00:225.00, _NOTIF);

      $period(posedge DSCLK,  100:100:100, _NOTIF);

`else

// worst operating conditions according to the specification:
// PVT:          slow, 1.62V, 3.00V, 125C
// input slope:  200ps
// CLoad:        200fF

      // Pin-to-pin delays

      // READ / WRITE CYCLE --------------------------------------------------------

      if (((WE==1'b0))) (posedge CE => (RDY +: RDY)) = (16.61, 6.02);
      if (((WE==1'b1))) (posedge CE => (RDY +: RDY)) = (18.29, 6.02);

      if (((WE==1'b0))) (posedge CE => (DOUT[0]	+: _MEM[0])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[0]	+: DIN[0])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[1]	+: _MEM[1])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[1]	+: DIN[1])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[2]	+: _MEM[2])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[2]	+: DIN[2])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[3]	+: _MEM[3])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[3]	+: DIN[3])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[4]	+: _MEM[4])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[4]	+: DIN[4])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[5]	+: _MEM[5])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[5]	+: DIN[5])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[6]	+: _MEM[6])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[6]	+: DIN[6])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[7]	+: _MEM[7])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[7]	+: DIN[7])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[8]	+: _MEM[8])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[8]	+: DIN[8])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[9]	+: _MEM[9])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[9]	+: DIN[9])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[10]	+: _MEM[10])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[10]	+: DIN[10])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[11]	+: _MEM[11])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[11]	+: DIN[11])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[12]	+: _MEM[12])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[12]	+: DIN[12])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[13]	+: _MEM[13])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[13]	+: DIN[13])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[14]	+: _MEM[14])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[14]	+: DIN[14])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[15]	+: _MEM[15])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[15]	+: DIN[15])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[16]	+: _MEM[16])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[16]	+: DIN[16])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[17]	+: _MEM[17])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[17]	+: DIN[17])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[18]	+: _MEM[18])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[18]	+: DIN[18])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[19]	+: _MEM[19])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[19]	+: DIN[19])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[20]	+: _MEM[20])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[20]	+: DIN[20])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[21]	+: _MEM[21])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[21]	+: DIN[21])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[22]	+: _MEM[22])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[22]	+: DIN[22])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[23]	+: _MEM[23])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[23]	+: DIN[23])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[24]	+: _MEM[24])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[24]	+: DIN[24])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[25]	+: _MEM[25])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[25]	+: DIN[25])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[26]	+: _MEM[26])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[26]	+: DIN[26])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[27]	+: _MEM[27])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[27]	+: DIN[27])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[28]	+: _MEM[28])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[28]	+: DIN[28])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[29]	+: _MEM[29])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[29]	+: DIN[29])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[30]	+: _MEM[30])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[30]	+: DIN[30])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b0))) (posedge CE => (DOUT[31]	+: _MEM[31])) 	= (13.08, 12.46, 0.01);
      if (((WE==1'b1))) (posedge CE => (DOUT[31]	+: DIN[31])) 	= (8.69, 9.14, 0.01);
      if (((WE==1'b1))) (posedge CE => (TRIM[0]	+: TRIM[0])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[1]	+: TRIM[1])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[2]	+: TRIM[2])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[3]	+: TRIM[3])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[4]	+: TRIM[4])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[5]	+: TRIM[5])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[6]	+: TRIM[6])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[7]	+: TRIM[7])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[8]	+: TRIM[8])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[9]	+: TRIM[9])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[10]	+: TRIM[10])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[11]	+: TRIM[11])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[12]	+: TRIM[12])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[13]	+: TRIM[13])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[14]	+: TRIM[14])) 	= (15.81, 12.77);
      if (((WE==1'b1))) (posedge CE => (TRIM[15]	+: TRIM[15])) 	= (15.81, 12.77);

      // STORE / RECALL CYCLE ----------------------------------------------

      (posedge HR   	=> (RDY      -: RDY))      = 8.51;
      (posedge HS   	=> (RDY      -: RDY))      = 8.48;

      if (((BUSYNVC==1'b0))) (posedge CLK  	=> (RDY      +: RDY))      = 8.00;

      (posedge CLK  	=> (BUSYNVC  +: BUSYNVC))  = (9.15, 9.15);

      (posedge CLK  	=> (RCLT     +: RCLT))     = (11.21, 7.13);
      (negedge CLK  	=> (VSESTART +: VSESTART)) = (10.32, 7.39);
      (posedge CLK  	=> (CLKI     +: CLKI))     = 2.61;
      (negedge CLK  	=> (CLKI     -: CLKI))     = 2.10;

      (posedge MEM_ALLC => (MEM1_ENT -: MEM1_ENT)) = 4.02;
      (posedge MEM_ALLC => (MEM2_ENT -: MEM2_ENT)) = 4.02;
      (negedge MEM_ALLC => (MEM1_ENT +: MEM1_ENT)) = 3.95;
      (negedge MEM_ALLC => (MEM2_ENT +: MEM2_ENT)) = 3.95;

      (posedge MEM_SEL  => (MEM1_ENT -: MEM1_ENT)) = 4.32;
      (posedge MEM_SEL  => (MEM2_ENT +: MEM2_ENT)) = 4.72;
      (negedge MEM_SEL  => (MEM1_ENT +: MEM1_ENT)) = 4.19;
      (negedge MEM_SEL  => (MEM2_ENT -: MEM2_ENT)) = 3.03;

      // ALL CYCLE ---------------------------------------------------------

      (posedge POR  	=> (RDY      -: RDY))      = 8.01;
      (negedge POR  	=> (RDY      +: RDY))      = 7.94;
      (posedge POR  	=> (VSESTART -: VSESTART)) = 4.89;
      (posedge POR  	=> (RCLT     -: RCLT))     = 5.52;

      (negedge DRSTN  	=> (RDY      -: RDY))      = 7.60;
      (posedge DRSTN  	=> (RDY      +: RDY))      = 7.63;
      (posedge POR  	=> (DOUT[0] -: DOUT[0])) = 8.01;
      (negedge POR  	=> (DOUT[0] +: DOUT[0])) = 7.99;
      (posedge POR  	=> (DOUT[1] -: DOUT[1])) = 8.01;
      (negedge POR  	=> (DOUT[1] +: DOUT[1])) = 7.99;
      (posedge POR  	=> (DOUT[2] -: DOUT[2])) = 8.01;
      (negedge POR  	=> (DOUT[2] +: DOUT[2])) = 7.99;
      (posedge POR  	=> (DOUT[3] -: DOUT[3])) = 8.01;
      (negedge POR  	=> (DOUT[3] +: DOUT[3])) = 7.99;
      (posedge POR  	=> (DOUT[4] -: DOUT[4])) = 8.01;
      (negedge POR  	=> (DOUT[4] +: DOUT[4])) = 7.99;
      (posedge POR  	=> (DOUT[5] -: DOUT[5])) = 8.01;
      (negedge POR  	=> (DOUT[5] +: DOUT[5])) = 7.99;
      (posedge POR  	=> (DOUT[6] -: DOUT[6])) = 8.01;
      (negedge POR  	=> (DOUT[6] +: DOUT[6])) = 7.99;
      (posedge POR  	=> (DOUT[7] -: DOUT[7])) = 8.01;
      (negedge POR  	=> (DOUT[7] +: DOUT[7])) = 7.99;
      (posedge POR  	=> (DOUT[8] -: DOUT[8])) = 8.01;
      (negedge POR  	=> (DOUT[8] +: DOUT[8])) = 7.99;
      (posedge POR  	=> (DOUT[9] -: DOUT[9])) = 8.01;
      (negedge POR  	=> (DOUT[9] +: DOUT[9])) = 7.99;
      (posedge POR  	=> (DOUT[10] -: DOUT[10])) = 8.01;
      (negedge POR  	=> (DOUT[10] +: DOUT[10])) = 7.99;
      (posedge POR  	=> (DOUT[11] -: DOUT[11])) = 8.01;
      (negedge POR  	=> (DOUT[11] +: DOUT[11])) = 7.99;
      (posedge POR  	=> (DOUT[12] -: DOUT[12])) = 8.01;
      (negedge POR  	=> (DOUT[12] +: DOUT[12])) = 7.99;
      (posedge POR  	=> (DOUT[13] -: DOUT[13])) = 8.01;
      (negedge POR  	=> (DOUT[13] +: DOUT[13])) = 7.99;
      (posedge POR  	=> (DOUT[14] -: DOUT[14])) = 8.01;
      (negedge POR  	=> (DOUT[14] +: DOUT[14])) = 7.99;
      (posedge POR  	=> (DOUT[15] -: DOUT[15])) = 8.01;
      (negedge POR  	=> (DOUT[15] +: DOUT[15])) = 7.99;
      (posedge POR  	=> (DOUT[16] -: DOUT[16])) = 8.01;
      (negedge POR  	=> (DOUT[16] +: DOUT[16])) = 7.99;
      (posedge POR  	=> (DOUT[17] -: DOUT[17])) = 8.01;
      (negedge POR  	=> (DOUT[17] +: DOUT[17])) = 7.99;
      (posedge POR  	=> (DOUT[18] -: DOUT[18])) = 8.01;
      (negedge POR  	=> (DOUT[18] +: DOUT[18])) = 7.99;
      (posedge POR  	=> (DOUT[19] -: DOUT[19])) = 8.01;
      (negedge POR  	=> (DOUT[19] +: DOUT[19])) = 7.99;
      (posedge POR  	=> (DOUT[20] -: DOUT[20])) = 8.01;
      (negedge POR  	=> (DOUT[20] +: DOUT[20])) = 7.99;
      (posedge POR  	=> (DOUT[21] -: DOUT[21])) = 8.01;
      (negedge POR  	=> (DOUT[21] +: DOUT[21])) = 7.99;
      (posedge POR  	=> (DOUT[22] -: DOUT[22])) = 8.01;
      (negedge POR  	=> (DOUT[22] +: DOUT[22])) = 7.99;
      (posedge POR  	=> (DOUT[23] -: DOUT[23])) = 8.01;
      (negedge POR  	=> (DOUT[23] +: DOUT[23])) = 7.99;
      (posedge POR  	=> (DOUT[24] -: DOUT[24])) = 8.01;
      (negedge POR  	=> (DOUT[24] +: DOUT[24])) = 7.99;
      (posedge POR  	=> (DOUT[25] -: DOUT[25])) = 8.01;
      (negedge POR  	=> (DOUT[25] +: DOUT[25])) = 7.99;
      (posedge POR  	=> (DOUT[26] -: DOUT[26])) = 8.01;
      (negedge POR  	=> (DOUT[26] +: DOUT[26])) = 7.99;
      (posedge POR  	=> (DOUT[27] -: DOUT[27])) = 8.01;
      (negedge POR  	=> (DOUT[27] +: DOUT[27])) = 7.99;
      (posedge POR  	=> (DOUT[28] -: DOUT[28])) = 8.01;
      (negedge POR  	=> (DOUT[28] +: DOUT[28])) = 7.99;
      (posedge POR  	=> (DOUT[29] -: DOUT[29])) = 8.01;
      (negedge POR  	=> (DOUT[29] +: DOUT[29])) = 7.99;
      (posedge POR  	=> (DOUT[30] -: DOUT[30])) = 8.01;
      (negedge POR  	=> (DOUT[30] +: DOUT[30])) = 7.99;
      (posedge POR  	=> (DOUT[31] -: DOUT[31])) = 8.01;
      (negedge POR  	=> (DOUT[31] +: DOUT[31])) = 7.99;
      (negedge DRSTN  	=> (DOUT[0] -: DOUT[0])) = 7.60;
      (posedge DRSTN  	=> (DOUT[0] +: DOUT[0])) = 7.63;
      (negedge DRSTN  	=> (DOUT[1] -: DOUT[1])) = 7.60;
      (posedge DRSTN  	=> (DOUT[1] +: DOUT[1])) = 7.63;
      (negedge DRSTN  	=> (DOUT[2] -: DOUT[2])) = 7.60;
      (posedge DRSTN  	=> (DOUT[2] +: DOUT[2])) = 7.63;
      (negedge DRSTN  	=> (DOUT[3] -: DOUT[3])) = 7.60;
      (posedge DRSTN  	=> (DOUT[3] +: DOUT[3])) = 7.63;
      (negedge DRSTN  	=> (DOUT[4] -: DOUT[4])) = 7.60;
      (posedge DRSTN  	=> (DOUT[4] +: DOUT[4])) = 7.63;
      (negedge DRSTN  	=> (DOUT[5] -: DOUT[5])) = 7.60;
      (posedge DRSTN  	=> (DOUT[5] +: DOUT[5])) = 7.63;
      (negedge DRSTN  	=> (DOUT[6] -: DOUT[6])) = 7.60;
      (posedge DRSTN  	=> (DOUT[6] +: DOUT[6])) = 7.63;
      (negedge DRSTN  	=> (DOUT[7] -: DOUT[7])) = 7.60;
      (posedge DRSTN  	=> (DOUT[7] +: DOUT[7])) = 7.63;
      (negedge DRSTN  	=> (DOUT[8] -: DOUT[8])) = 7.60;
      (posedge DRSTN  	=> (DOUT[8] +: DOUT[8])) = 7.63;
      (negedge DRSTN  	=> (DOUT[9] -: DOUT[9])) = 7.60;
      (posedge DRSTN  	=> (DOUT[9] +: DOUT[9])) = 7.63;
      (negedge DRSTN  	=> (DOUT[10] -: DOUT[10])) = 7.60;
      (posedge DRSTN  	=> (DOUT[10] +: DOUT[10])) = 7.63;
      (negedge DRSTN  	=> (DOUT[11] -: DOUT[11])) = 7.60;
      (posedge DRSTN  	=> (DOUT[11] +: DOUT[11])) = 7.63;
      (negedge DRSTN  	=> (DOUT[12] -: DOUT[12])) = 7.60;
      (posedge DRSTN  	=> (DOUT[12] +: DOUT[12])) = 7.63;
      (negedge DRSTN  	=> (DOUT[13] -: DOUT[13])) = 7.60;
      (posedge DRSTN  	=> (DOUT[13] +: DOUT[13])) = 7.63;
      (negedge DRSTN  	=> (DOUT[14] -: DOUT[14])) = 7.60;
      (posedge DRSTN  	=> (DOUT[14] +: DOUT[14])) = 7.63;
      (negedge DRSTN  	=> (DOUT[15] -: DOUT[15])) = 7.60;
      (posedge DRSTN  	=> (DOUT[15] +: DOUT[15])) = 7.63;
      (negedge DRSTN  	=> (DOUT[16] -: DOUT[16])) = 7.60;
      (posedge DRSTN  	=> (DOUT[16] +: DOUT[16])) = 7.63;
      (negedge DRSTN  	=> (DOUT[17] -: DOUT[17])) = 7.60;
      (posedge DRSTN  	=> (DOUT[17] +: DOUT[17])) = 7.63;
      (negedge DRSTN  	=> (DOUT[18] -: DOUT[18])) = 7.60;
      (posedge DRSTN  	=> (DOUT[18] +: DOUT[18])) = 7.63;
      (negedge DRSTN  	=> (DOUT[19] -: DOUT[19])) = 7.60;
      (posedge DRSTN  	=> (DOUT[19] +: DOUT[19])) = 7.63;
      (negedge DRSTN  	=> (DOUT[20] -: DOUT[20])) = 7.60;
      (posedge DRSTN  	=> (DOUT[20] +: DOUT[20])) = 7.63;
      (negedge DRSTN  	=> (DOUT[21] -: DOUT[21])) = 7.60;
      (posedge DRSTN  	=> (DOUT[21] +: DOUT[21])) = 7.63;
      (negedge DRSTN  	=> (DOUT[22] -: DOUT[22])) = 7.60;
      (posedge DRSTN  	=> (DOUT[22] +: DOUT[22])) = 7.63;
      (negedge DRSTN  	=> (DOUT[23] -: DOUT[23])) = 7.60;
      (posedge DRSTN  	=> (DOUT[23] +: DOUT[23])) = 7.63;
      (negedge DRSTN  	=> (DOUT[24] -: DOUT[24])) = 7.60;
      (posedge DRSTN  	=> (DOUT[24] +: DOUT[24])) = 7.63;
      (negedge DRSTN  	=> (DOUT[25] -: DOUT[25])) = 7.60;
      (posedge DRSTN  	=> (DOUT[25] +: DOUT[25])) = 7.63;
      (negedge DRSTN  	=> (DOUT[26] -: DOUT[26])) = 7.60;
      (posedge DRSTN  	=> (DOUT[26] +: DOUT[26])) = 7.63;
      (negedge DRSTN  	=> (DOUT[27] -: DOUT[27])) = 7.60;
      (posedge DRSTN  	=> (DOUT[27] +: DOUT[27])) = 7.63;
      (negedge DRSTN  	=> (DOUT[28] -: DOUT[28])) = 7.60;
      (posedge DRSTN  	=> (DOUT[28] +: DOUT[28])) = 7.63;
      (negedge DRSTN  	=> (DOUT[29] -: DOUT[29])) = 7.60;
      (posedge DRSTN  	=> (DOUT[29] +: DOUT[29])) = 7.63;
      (negedge DRSTN  	=> (DOUT[30] -: DOUT[30])) = 7.60;
      (posedge DRSTN  	=> (DOUT[30] +: DOUT[30])) = 7.63;
      (negedge DRSTN  	=> (DOUT[31] -: DOUT[31])) = 7.60;
      (posedge DRSTN  	=> (DOUT[31] +: DOUT[31])) = 7.63;
      (posedge TM_NVCP[0]  	=> (TM_NVCPI[0] +: TM_NVCPI[0])) = 5.00;
      (negedge TM_NVCP[0]  	=> (TM_NVCPI[0] -: TM_NVCPI[0])) = 5.00;
      (posedge TM_NVCP[1]  	=> (TM_NVCPI[1] +: TM_NVCPI[1])) = 5.00;
      (negedge TM_NVCP[1]  	=> (TM_NVCPI[1] -: TM_NVCPI[1])) = 5.00;
      (posedge TM_NVCP[2]  	=> (TM_NVCPI[2] +: TM_NVCPI[2])) = 5.00;
      (negedge TM_NVCP[2]  	=> (TM_NVCPI[2] -: TM_NVCPI[2])) = 5.00;
      (posedge TM_NVCP[3]  	=> (TM_NVCPI[3] +: TM_NVCPI[3])) = 5.00;
      (negedge TM_NVCP[3]  	=> (TM_NVCPI[3] -: TM_NVCPI[3])) = 5.00;

      // SHIFT CYCLE -------------------------------------------------------

      if (((BUSYNVC==1'b1))) (posedge DSCLK 	=> (DSO		+: DSO))		= (7.08, 5.68);
      (negedge DRSTN	=> (DSO		-: DSO))		= 7.50;

      // Setup & Hold Timing Checks ----------------------------------------

      $setuphold(posedge CE &&& ~POR, posedge A[0], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[0], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[0], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[0], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[1], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[1], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[1], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[1], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[2], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[2], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[2], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[2], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[3], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[3], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[3], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[3], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[4], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[4], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[4], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[4], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[5], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[5], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[5], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[5], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, posedge A[6], 0.00, 0, _NOTIF_A);
      $setuphold(posedge CE &&& ~POR, negedge A[6], 0.00, 0, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, posedge A[6], 0, 0.00, _NOTIF_A);
      $setuphold(posedge RDY &&& ~POR, negedge A[6], 0, 0.00, _NOTIF_A);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[0], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[0], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[0], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[0], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[1], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[1], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[1], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[1], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[2], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[2], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[2], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[2], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[3], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[3], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[3], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[3], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[4], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[4], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[4], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[4], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[5], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[5], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[5], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[5], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[6], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[6], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[6], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[6], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[7], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[7], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[7], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[7], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[8], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[8], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[8], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[8], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[9], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[9], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[9], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[9], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[10], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[10], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[10], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[10], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[11], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[11], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[11], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[11], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[12], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[12], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[12], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[12], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[13], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[13], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[13], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[13], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[14], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[14], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[14], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[14], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[15], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[15], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[15], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[15], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[16], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[16], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[16], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[16], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[17], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[17], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[17], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[17], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[18], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[18], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[18], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[18], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[19], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[19], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[19], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[19], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[20], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[20], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[20], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[20], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[21], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[21], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[21], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[21], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[22], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[22], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[22], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[22], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[23], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[23], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[23], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[23], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[24], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[24], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[24], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[24], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[25], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[25], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[25], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[25], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[26], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[26], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[26], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[26], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[27], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[27], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[27], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[27], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[28], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[28], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[28], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[28], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[29], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[29], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[29], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[29], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[30], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[30], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[30], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[30], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, posedge DIN[31], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq, negedge DIN[31], 0.00, 0, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  posedge DIN[31], 0, 16.39, _NOTIF_DIN);
      $setuphold(posedge CE &&& _WEPORq,  negedge DIN[31], 0, 16.39, _NOTIF_DIN);

      $setuphold(posedge DSCLK &&& ~POR, posedge DUP, 5.00, 5.00, _NOTIF);
      $setuphold(posedge DSCLK &&& ~POR, negedge DUP, 5.00, 5.00, _NOTIF);


      $setuphold(posedge DSCLK &&& ~POR, posedge DSI, 5.00, 5.00, _NOTIF_DSI);
      $setuphold(posedge DSCLK &&& ~POR, negedge DSI, 5.00, 5.00, _NOTIF_DSI);

      $setuphold(posedge CE &&& ~POR, posedge WE, 1.64, 0, _NOTIF);
      $setuphold(posedge CE &&& ~POR, negedge WE, 1.64, 0, _NOTIF);


      $setuphold(posedge CE &&& ~POR,  posedge WE, 0, 0.00, _NOTIF);
      $setuphold(posedge CE &&& ~POR,  negedge WE, 0, 0.00, _NOTIF);


      $setuphold(posedge HS,  posedge MEM_ALLC, 5.00, 0, _NOTIF);
      $setuphold(posedge HS,  negedge MEM_ALLC, 5.00, 0, _NOTIF);
      $setuphold(posedge RDY, posedge MEM_ALLC, 0, 5.00, _NOTIF);
      $setuphold(posedge RDY, negedge MEM_ALLC, 0, 5.00, _NOTIF);

      $setuphold(posedge HS,  posedge MEM_SEL, 5.00, 0, _NOTIF);
      $setuphold(posedge HS,  negedge MEM_SEL, 5.00, 0, _NOTIF);
      $setuphold(posedge RDY, posedge MEM_SEL, 0, 5.00, _NOTIF);
      $setuphold(posedge RDY, negedge MEM_SEL, 0, 5.00, _NOTIF);

      $setuphold(posedge RDY,     posedge CE, 0, 7.23, _NOTIF);
      $setuphold(posedge BUSYNVC, posedge HR, 0, 300.00, _NOTIF);
      $setuphold(posedge BUSYNVC, posedge HS, 0, 300.00, _NOTIF);

      $setuphold(posedge HS &&& ~POR,  posedge PEIN, 5.00, 0, _NOTIF_PEIN);
      $setuphold(posedge HS &&& ~POR,  negedge PEIN, 5.00, 0, _NOTIF_PEIN);
      $setuphold(posedge RDY &&& ~POR, posedge PEIN, 0, 5.00, _NOTIF_PEIN);
      $setuphold(posedge RDY &&& ~POR, negedge PEIN, 0, 5.00, _NOTIF_PEIN);

      // Recovery checks

      $recrem(negedge POR, posedge CE, 0.42, 0, _NOTIF);
      $recrem(negedge POR, posedge HR, 10.00, 0, _NOTIF);
      $recrem(negedge POR, posedge HS, 10.00, 0, _NOTIF);

      // Pulse-width checks

      $width(posedge POR, 3.15:4.63:8.01, 0, _NOTIF_POR);
      $width(posedge CE,  0.57:0.88:1.64, 0, _NOTIF);
      $width(posedge CLK  &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);
      $width(negedge CLK  &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);

      $width(posedge HR,  337.50, 0, _NOTIF);
      $width(posedge HS,  337.50, 0, _NOTIF);

      $width(negedge HR,  337.50, 0, _NOTIF);
      $width(negedge HS,  337.50, 0, _NOTIF);
      $width(negedge DRSTN, 3.07:4.49:7.76, 0, _NOTIF_POR);

      $width(posedge DSCLK, 50.00:50.00:50.00, 0, _NOTIF);
      $width(negedge DSCLK, 50.00:50.00:50.00, 0, _NOTIF);

      // Period checks

      $period(posedge CE,  7.49:11.71:20.99, _NOTIF);
      $period(posedge CLK  &&& ~BUSYNVC, 225.00:225.00:225.00, _NOTIF);

      $period(posedge DSCLK,  100:100:100, _NOTIF);

`endif

   endspecify

//--------------------------------------------------------------------------

endmodule


`endcelldefine
