`timescale 1 ps/1 fs

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09.06.2022 17:00:02
// Design Name:
// Module Name: Single_cycle_processor_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Pipeline_tb();

	parameter Data_initFile   = "D:/Ensar/Tez/RV32I/digital/testbench/hex/init_data.hex";
	parameter Ins_initFile    = "D:/Ensar/Tez/RV32I/digital/testbench/hex/init_addi.hex";


	parameter size = 32;
	parameter PERIOD = 30000;

	reg clk = 1'b1;
	reg reset;

	logic [size-1 : 0] instruction;
	logic [size-1 : 0] Data_in;
	logic [size-1 : 0] Data_out;
	logic [size-1 : 0] Addr_out;
	logic [size-1 : 0] PC_Addr;
	logic [2:0] Mem_type_sel;
	logic Mem_write;

	logic [size-1 : 0] Data_out_organized;
	logic [size-1 : 0] Data_in1;



	logic CE,WE,HS,HR, POR;
	logic RDY;

	logic CE_1,HS_1,HR_1, POR_1;
	logic RDY_1;

	logic dummy_clk;
	logic dummy_clk1;

	rv32i_core UUT(
		.clk(clk),
		.reset(reset),

		.ins_address(PC_Addr),
		.instruction_i(instruction),

		.data_mem_rw(Mem_write),
		.data_mem_addr_o(Addr_out),
		.data_mem_data_wr_data(Data_out),
		.data_mem_data_rd_data(Data_in),
		.data_mem_control(Mem_type_sel)
	);

	data_organizer Processor_to_Memory(	// todo : move data_organizer to into rv32i_core
		.data_in(Data_out),
		.Type_sel(Mem_type_sel),
		.data_out(Data_out_organized));

	data_organizer Memory_to_Datapath(
		.data_in(Data_in1),
		.Type_sel(Mem_type_sel),
		.data_out(Data_in));

	NVR_TOP DATA_MEM(
	    .A(Addr_out[6:0]),
	    .DIN(Data_out_organized),
	    .TM_NVCP(4'h0),
	    .CE(CE),
	    .HR(HR),
	    .HS(HS),
	    .MEM_ALLC(1'b0),
	    .NVREF_EXT(1'b0),
	    .PEIN(1'b0),
	    .POR(POR),
	    .WE(WE),
	    .MEM_SEL(4'd0),
	    .DUP(1'b0),
	    .DSCLK(1'b0),
	    .DRSTN(1'b1),
	    .DSI(1'b0),
	    .DSO(),
	    .CLK4M(),
	    .DOUT(Data_in1),
	    .RDY(RDY));

	NVR_TOP INS_MEM(
	    .A(PC_Addr[6:0]),
	    .DIN(32'd0),
	    .TM_NVCP(4'h0),
	    .CE(CE_1),
	    .HR(HR_1),
	    .HS(HS_1),
	    .MEM_ALLC(1'b0),
	    .NVREF_EXT(1'b0),
	    .PEIN(1'b0),
	    .POR(POR_1),
	    .WE(1'b0),
	    .MEM_SEL(4'd0),
	    .DUP(1'b0),
	    .DSCLK(1'b0),
	    .DRSTN(1'b1),
	    .DSI(1'b0),
	    .DSO(),
	    .CLK4M(),
	    .DOUT(instruction),
	    .RDY(RDY_1));

	always
	begin
		clk = 1'b1;
		#(PERIOD/2); clk = 1'b0;
		#(PERIOD/2);
	end

	always begin
        dummy_clk = 1'b1;
        #(500) dummy_clk = 1'b0;
        #(500);
    end

	always begin
        dummy_clk1 = 1'b1;
        #(500) dummy_clk1 = 1'b0;
        #(500);
    end

	always @(posedge dummy_clk) begin
		if (Mem_write == 1)begin
			dataMemoryWrite;
		end
		else begin
			dataMemoryRead;
		end
	end

	always @(posedge dummy_clk1) begin
		insMemoryRead;
	end

	initial begin
        reset = 1'b0;
		$timeformat(-6, 6," us", 20);

		$readmemh(Data_initFile, DATA_MEM.XNVR._SR_MEMORY, 0, 127); // --- Use this if you've written the instructions in hex
		$readmemh(Ins_initFile, INS_MEM.XNVR._SR_MEMORY, 0, 127); // --- Use this if you've written the instructions in hex
		$display("XNVR Data Memory initialized");
		$display("%.1fns XNVR %m : INFO : Loading Initial File ... %s \n", $realtime, Data_initFile);
		$display("%.1fns XNVR %m : INFO : Loading Initial File ... %s \n", $realtime, Ins_initFile);

		//----System Init And System Reset----//
		system_init;
		#PERIOD;
		sys_reset;
		#(3.8*PERIOD);
		reset = 1'b1;
		#(550*PERIOD);
        $finish();
    end


	// -- TB Tasks
	task sys_reset;
	/* Description: Apply a low-active reset pulse
	*/
		begin
			POR=0;
			POR_1 = 0;
			$display("Applying system reset at %t",$time);
			#10000;
			POR = 1;
			POR_1 = 1;
			#10000;
			POR = 0;
			POR_1 = 0;
			#(PERIOD - 20000);
		end
	endtask

	task system_init;
		begin
			CE = 1'b0;
			WE = 1'b0;
			HS = 1'b0;
			HR = 1'b0;
			POR	= 1'b0;

			CE_1 = 1'b0;
			HS_1 = 1'b0;
			HR_1 = 1'b0;
			POR_1 = 1'b0;
		end
	endtask

	task dataMemoryRead;
		begin
			WE = 1'b0;
			#2000;
			CE = 1'b1;
			#1000;
			CE = 1'b0;
			#(PERIOD-3000);
		end
	endtask

	task dataMemoryWrite;
		begin
			WE = 1'b1;
			#2000;
			CE = 1'b1;
			#1000;
			CE = 1'b0;
			#7000;
			WE = 0;
			#(PERIOD-10000);
		end
	endtask

	task insMemoryRead;
		begin
			#2000;
			CE_1 = 1'b1;
			#1000;
			CE_1 = 1'b0;
			#(PERIOD-3000);
		end
	endtask

	/*
	initial begin
		reset = 1'b0;
		$display("Simulation started");
		#(PERIOD*10000);
		reset = 1'b1;
		$display("Reset is set");
		#(PERIOD*10000);

		reset = 1'b0;
		$display("Simulation restarted");
		#(PERIOD*1000);
		reset = 1'b1;
		$display("Reset is set");
		#(PERIOD*1000);
		$finish;
	end
	*/
endmodule
