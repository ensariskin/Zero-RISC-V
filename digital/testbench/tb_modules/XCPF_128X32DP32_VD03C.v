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
// File             	: XCPF_128X32DP32_VD03C.v
// Description      	: Verilog simulation file
//                  	: Charge Pump with internal 4 MHz clock and fringe capacities, 1.8 V / 3.3 V power supply : XCPF_128X32DP32_VD03C
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
// on               	: Thu Jan 20 15:48:59 2022
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
//			in the Verilog testbench. This enables supply sensitivity information for input and output pins.
//
// 	1.3  __PATHCLK4CLK4M_ENABLE__
//
//			This define-statement can be set in the Verilog testbench.
//			This adds path delay between CLK4 and CLK4M..
//
// 2. Parameters:
// ++++++++++++++
//
//	2.1  debugMode
//			It is possible to set the model into debug mode by defining this statement in
//			the Verilog testbench and set it's value to '1'.
//			This enables getting detailed information about operations, addresses and data.
//			Default state is '0'.
//	2.2  verbose
//			It is possible to set the model into non-verbose mode by defining this statement in
//			the Verilog testbench and set it's value to '0'.
//			This disables getting warnings and error messages.
//			Default state is '1'.
//
// 3. Features:
// ++++++++++++
//
//	3.1 Simulator	This model has been tested in the XMSIM environment.
//
// --------------------------------------------------------------------------

`resetall

`default_nettype wire
`celldefine
`delay_mode_path


`timescale 1ns / 10ps

`ifdef XCPF_128X32DP32_VD03C_debugMode
`else
  `define XCPF_128X32DP32_VD03C_debugMode 0
`endif
`ifdef XCPF_128X32DP32_VD03C_verbose
`else
  `define XCPF_128X32DP32_VD03C_verbose 1
`endif

module XCPF_128X32DP32_VD03C ( CLK4, CLK4M, VCORE, VSE1, VSE2, VSEBUSY, BUSYNVC, CLKI, MEM1_ENT, MEM2_ENT, NVREF_EXT, POR, RCLT, TM_NVCPI, TRIM, VSESTART );

   parameter    debugMode      = `XCPF_128X32DP32_VD03C_debugMode,
                verbose        = `XCPF_128X32DP32_VD03C_verbose;


   inout        NVREF_EXT;

`ifdef __PATHCLK4CLK4M_ENABLE__
   inout        CLK4;
`else
   output       CLK4;
`endif

   output	VCORE, VSE1, VSE2;
   output	CLK4M, VSEBUSY;

   input [15:0] TRIM;
   input [3:0]	TM_NVCPI;
   input	BUSYNVC, CLKI, MEM1_ENT, MEM2_ENT, POR, RCLT, VSESTART;


   reg 		_CLK4, _VCORE, _VSE1, _VSE2, _VSEBUSY;
   reg 		_NOTIF;
   reg 		_RCL, _PMP, _RCL_CYCLE, _PMP_CYCLE;

   wire         _BUSY;
   wire         CLK4, CLK4M, VCORE, VSE1, VSE2, VSEBUSY, BUSYNVC, CLKI, MEM1_ENT, MEM2_ENT, NVREF_EXT, POR, RCLT, VSESTART;

   wire  [15:0] TRIM, DIN;
   wire  [3:0]  TM_NVCPI;

   buf      	(VSE1,    	_VSE1);
   buf      	(VSE2,    	_VSE2);
   buf      	(VSEBUSY, 	_VSEBUSY);
   buf      	(VCORE,   	_VCORE);
   buf      	(CLK4,    	_CLK4);

`ifdef __PATHCLK4CLK4M_ENABLE__
   buf      	(CLK4M,     CLK4);
`else
   buf      	(CLK4M,     _CLK4);
`endif

   // define busy phase

   or       	(_BUSY, 	_PMP, _RCL);

//--------------------------------------------------------------------------
// Initial Task

   initial begin
      if( verbose ) $display("%.1fns XCPF %m : WARNING : \tTHIS IS A BEHAVIORAL MODEL WITH DEFAULT WORST CASE TIMING --->", 	$realtime);
      if( verbose ) $display("%.1fns XCPF %m : WARNING : \tTO USE THE CORRECT TIMING PLEASE ANNOTATE SDF TIMING !!!\n", 	$realtime);
      _VCORE    = 1;
      _VSE1     = 0;
      _VSE2     = 0;
      _VSEBUSY	= 0;
      _RCL      = 0;
      _PMP      = 0;
   end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// General Tasks

   function valid_nvmode;
      input [3:0] TM_NVCPI;
      input       NVREF_EXT;
      begin
	 valid_nvmode = (^(TM_NVCPI) === 1'b0 && NVREF_EXT == 1'b0);
      end
   endfunction // valid_nvmode

//--------------------------------------------------------------------------

   task pumpErr;
      begin
	 _VSE1		= 1'bx;
	 _VSE2		= 1'bx;
	 _VSEBUSY	= 1'bx;
	 _PMP		= 0;
         disable doPUMP_START;
	 if( debugMode ) $display("%.1fns XCPF %m : ERROR : STORE PUMP CYCLE(s) disabled ... ", $realtime);
      end
   endtask // pumpErr

//--------------------------------------------------------------------------

   task oscMode;
      begin
         while( ~BUSYNVC ) #125 _CLK4 	= ~_CLK4;
      end
   endtask // oscMode

//--------------------------------------------------------------------------

   task pumpMode;
      begin
	 _PMP  = 0;
	 if( MEM1_ENT )	_VSE1 = 1'b0;
	 if( MEM2_ENT )	_VSE2 = 1'b0;
         if( debugMode )  $display("%.1fns XCPF %m : INFO : STORE PUMP CYCLE(s) finished ... ", $realtime);
      end
   endtask // pumpMode

   task recallMode;
      begin
	 _RCL		= @(negedge RCLT) 0;
         if( debugMode )  $display("%.1fns XCPF %m : INFO : RECALL CYCLE finished ... ", $realtime);
      end
   endtask // recallMode

//--------------------------------------------------------------------------
// OSCILLATOR

   always @( negedge BUSYNVC ) begin
      _CLK4   = 1'b0;
      #35 oscMode;
      #125 _CLK4   = ~_CLK4;
      #125 _CLK4   = ~_CLK4;
   end // always @ ( negedge BUSYNVC )

   always @( posedge BUSYNVC ) begin
      disable oscMode;
      _CLK4 	= 1'b1;
   end // always @ ( posedge BUSYNVC )

//--------------------------------------------------------------------------
// PUMP CYCLE

   always @( posedge CLKI ) begin
      if( VSESTART && ~POR ) begin
         casez({valid_nvmode(TM_NVCPI, NVREF_EXT)})
	   1'b0: begin
	      if( verbose ) $display("%.1fns XCPF %m : WARNING : TESTMODE inputs are unknown or Charge Pump is switched into TESTMODE !", $realtime);
	   end // case: 1'b0
	 endcase // casez({valid_nvmode(TM_NVCPI, NVREF_EXT)})
         if( MEM1_ENT ) _VSE1 = 1'b1;
         if( MEM2_ENT ) _VSE2 = 1'b1;
         _VSEBUSY = 1'b1;
	 _PMP     = 1;
      end // if ( VSESTART && ~POR )
   end // always @ ( posedge CLKI )

   always @( posedge _VSE1 or posedge _VSE2 ) begin : doPUMP_START
      // ... TRIMBIT Dependency is missing ...
      // ... valid for TRIMBIT[15:0] =16'b0000000000000000
      _VSEBUSY = repeat (26400) @(posedge CLKI) 1'b0;
      _VSEBUSY = repeat (160)  	@(posedge CLKI) 1'b1;
      _VSEBUSY = repeat (20480)	@(posedge CLKI) 1'b0;
      pumpMode;
   end // block: doPUMP_START

//--------------------------------------------------------------------------
// RECALL CYCLE

   always @( posedge RCLT ) begin
      if( RCLT && ~POR ) begin
         casez({valid_nvmode(TM_NVCPI, NVREF_EXT)})
	   1'b0: begin
	      if( verbose ) $display("%.1fns XCPF %m : WARNING : TESTMODE inputs are unknown or Charge Pump is switched into TESTMODE !", $realtime);
	      end // case: 1'b0
	 endcase // casez({valid_nvmode(TM_NVCPI, NVREF_EXT)})
         _RCL = 1;
         recallMode;
      end // if ( RCLT && ~POR )
   end // always @ ( posedge RCLT )

//**************************************************************************
//**************************************************************************
//**************************************************************************

//--------------------------------------------------------------------------
// necessary to do HOLD time checks

   always @( posedge _PMP or posedge _RCL ) begin
      _PMP_CYCLE = 1'b0;
      _RCL_CYCLE = 1'b0;
      if( _PMP ) _PMP_CYCLE = 1'b1;
      if( _RCL ) _RCL_CYCLE = 1'b1;
   end // always @ (posedge _PMP ...)

//--------------------------------------------------------------------------
// CHECKS

   always @( posedge POR ) begin
      if( POR === 1'bx || POR === 1'bz )		if( verbose ) $display("%.1fns XCPF %m : ERROR : POR is unknown !", $realtime);
      if( _BUSY ) begin
         if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Reset during RECALL CYCLE !",        $realtime); pumpErr; end
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Reset during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
      else begin
         _CLK4 	= 1;
      end
   end // always @ ( posedge POR )

   always @( negedge POR ) begin
      if( POR === 1'bx || POR === 1'bz )		if( verbose ) $display("%.1fns XCPF %m : ERROR : POR is unknown !", 	$realtime);
      _VCORE    = 1;
      _VSE1     = 0;
      _VSE2     = 0;
      _VSEBUSY	= 0;
      _RCL      = 0;
      _PMP      = 0;
   end // always @ ( negedge POR )

   always @( MEM1_ENT ) begin
      if( MEM1_ENT === 1'bx || MEM1_ENT === 1'bz )	if( verbose ) $display("%.1fns XCPF %m : ERROR : MEM1_ENT is unknown !", $realtime);
      if( _BUSY ) begin
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Change Memory Selection during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( MEM1_ENT )

   always @( MEM2_ENT ) begin
      if( MEM2_ENT === 1'bx || MEM2_ENT === 1'bz )	if( verbose ) $display("%.1fns XCPF %m : ERROR : MEM2_ENT is unknown !", $realtime);
      if( _BUSY ) begin
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Change Memory Selection during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( MEM2_ENT )

   always @( posedge RCLT ) begin
      if( RCLT === 1'bx || RCLT === 1'bz )        	if( verbose ) $display("%.1fns XCPF %m : ERROR : RCLT is unknown !", $realtime);
      if( _BUSY ) begin
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Start RECALL during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( posedge RCLT )

   always @( posedge VSESTART ) begin
      if( VSESTART === 1'bx || VSESTART === 1'bz )	if( verbose ) $display("%.1fns XCPF %m : ERROR : VSESTART is unknown !", $realtime);
      if( _BUSY ) begin
         if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Start STORE during RECALL CYCLE !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( posedge VSESTART )

   always @( TM_NVCPI ) begin
      if( ^(TM_NVCPI) === 1'bx || ^(TM_NVCPI) === 1'bz) if( verbose ) $display("%.1fns XCPF %m : ERROR : TM_NVCPI is unknown !", $realtime);
      if( _BUSY ) begin
         if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Set TESTMODE during RECALL CYCLE !",        $realtime); pumpErr; end
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Set Testmode during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( TM_NVCPI )

   always @( NVREF_EXT ) begin
      if( NVREF_EXT === 1'bx || NVREF_EXT === 1'bz) 	if( verbose ) $display("%.1fns XCPF %m : ERROR : NVREF_EXT is unknown !", $realtime);
      if( _BUSY ) begin
         if( _RCL_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Change TESTMODE inputs during RECALL CYCLE !",        $realtime); pumpErr; end
         if( _PMP_CYCLE ) begin if( verbose ) $display("%.1fns XCPF %m : ERROR : Change TESTMODE inputs during STORE PUMP CYCLE(s) !", $realtime); pumpErr; end
      end // if ( _BUSY )
   end // always @ ( NVREF_EXT )

//--------------------------------------------------------------------------
// Actions after setup&hold time violations

   always @( _NOTIF )	pumpErr;

//--------------------------------------------------------------------------

   specify

`ifdef DEFAULT_WORST_DELAY_OFF
// unit delay:

      // Pin-to-pin delays

      (posedge CLKI 	=> (VSEBUSY +: VSEBUSY)) = (0.02, 0.02);
      (posedge POR  	=> (VSEBUSY -: VSEBUSY)) = 0.02;
      (negedge BUSYNVC	=> (CLK4 -: CLK4)) 	 = 0.02;
      (negedge BUSYNVC	=> (CLK4M -: CLK4M)) 	 = 0.02;

`ifdef __PATHCLK4CLK4M_ENABLE__
      (posedge CLK4     => (CLK4M +: CLK4M))     = 0.02;
      (negedge CLK4     => (CLK4M -: CLK4M))     = 0.02;
`endif

      // Setup & Hold Timing Checks ----------------------------------------

      $setuphold(posedge VSESTART, posedge MEM1_ENT, 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge MEM1_ENT, 0.02, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge MEM2_ENT, 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge MEM2_ENT, 0.02, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge TRIM[0], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[0], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[1], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[1], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[2], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[2], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[3], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[3], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[4], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[4], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[5], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[5], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[6], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[6], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[7], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[7], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[8], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[8], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[9], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[9], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[10], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[10], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[11], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[11], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[12], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[12], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[13], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[13], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[14], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[14], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[15], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[15], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[0], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[0], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[1], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[1], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[2], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[2], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[3], 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[3], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[0], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[0], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[1], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[1], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[2], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[2], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[3], 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[3], 0.02, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge NVREF_EXT, 0.02, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge NVREF_EXT, 0.02, 0, _NOTIF);

      $setuphold(posedge RCLT, posedge NVREF_EXT, 0.02, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge NVREF_EXT, 0.02, 0, _NOTIF);

      // Pulse-width checks

      $width(posedge CLKI &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);
      $width(negedge CLKI &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);

      // Period Timing

      $period(posedge CLKI &&& ~BUSYNVC, 225.00:225.00:225.00, _NOTIF);

`else

// worst operating conditions according to the specification:
// PVT:          slow, 1.62V, 3.00V, 125C
// input slope:  200ps
// CLoad:        200fF

      // Pin-to-pin delays

      (posedge CLKI 	=> (VSEBUSY +: VSEBUSY)) = (8.00, 3.02);
      (posedge POR  	=> (VSEBUSY -: VSEBUSY)) = 3.99;
      (negedge BUSYNVC	=> (CLK4 -: CLK4)) 	 = 34.49;
      (negedge BUSYNVC	=> (CLK4M -: CLK4M)) 	 = 34.81;

`ifdef __PATHCLK4CLK4M_ENABLE__
      (posedge CLK4     => (CLK4M +: CLK4M))     = 0.32;
      (negedge CLK4     => (CLK4M -: CLK4M))     = 0.32;
`endif

      // Setup & Hold Timing Checks ----------------------------------------

      $setuphold(posedge VSESTART, posedge MEM1_ENT, 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge MEM1_ENT, 5.00, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge MEM2_ENT, 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge MEM2_ENT, 5.00, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge TRIM[0], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[0], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[1], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[1], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[2], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[2], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[3], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[3], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[4], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[4], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[5], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[5], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[6], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[6], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[7], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[7], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[8], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[8], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[9], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[9], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[10], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[10], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[11], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[11], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[12], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[12], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[13], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[13], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[14], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[14], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TRIM[15], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TRIM[15], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[0], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[0], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[1], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[1], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[2], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[2], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, posedge TM_NVCPI[3], 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge TM_NVCPI[3], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[0], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[0], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[1], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[1], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[2], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[2], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, posedge TM_NVCPI[3], 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge TM_NVCPI[3], 5.00, 0, _NOTIF);

      $setuphold(posedge VSESTART, posedge NVREF_EXT, 5.00, 0, _NOTIF);
      $setuphold(posedge VSESTART, negedge NVREF_EXT, 5.00, 0, _NOTIF);

      $setuphold(posedge RCLT, posedge NVREF_EXT, 5.00, 0, _NOTIF);
      $setuphold(posedge RCLT, negedge NVREF_EXT, 5.00, 0, _NOTIF);

      // Pulse-width checks

      $width(posedge CLKI &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);
      $width(negedge CLKI &&& ~BUSYNVC, 112.50:112.50:112.50, 0, _NOTIF);

      // Period Timing

      $period(posedge CLKI &&& ~BUSYNVC, 225.00:225.00:225.00, _NOTIF);

`endif

   endspecify

//--------------------------------------------------------------------------

endmodule


`endcelldefine
