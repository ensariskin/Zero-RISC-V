`timescale 1ns/1ns

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
	/*parameter sdfFile = "../synth/results/Pipelined_design.sdf";
	 parameter Data_initFile    = "/home/miskin/Desktop/ensar_iskin/Homeworks/HW8/sim/tb/init_data.hex";
	 parameter Ins_initFile    = "/home/miskin/Desktop/ensar_iskin/Homeworks/HW8/sim/tb/init_ins.hex";

	 */
	//parameter size = 32;
	parameter PERIOD = 10ns;

	reg clk = 1'b1;
	reg reset;
	/*
	wire [size-1 : 0] instruction;
	wire [size-1 : 0] Data_in;
	wire [size-1 : 0] Data_out;
	wire [size-1 : 0] Addr_out;
	wire [size-1 : 0] PC_Addr;
	wire [2:0] Mem_type_sel;
	wire Mem_write;

	wire [size-1 : 0] Data_out_organized;
	wire [size-1 : 0] Data_in1;

	reg CE,WE,HS,HR, POR;
	wire RDY;

	reg CE_1,HS_1,HR_1, POR_1;
	wire RDY_1;
	*/
	rv32i_core UUT(
		.clk(clk),
		.reset(reset),

		.ins_address(PC_Addr),
		.instruction_i(32'h0),

		.data_mem_rw(Mem_write),
		.data_mem_addr_o(Addr_out),
		.data_mem_data_wr_data(Data_out),
		.data_mem_data_rd_data(Data_in),
		.data_mem_control(Mem_type_sel)
		);
	/*
	 Data_organizer Processor_to_Memory(
	 .data_in(Data_out),
	 .Type_sel(Mem_type_sel),
	 .data_out(Data_out_organized));

	 Data_organizer Memory_to_Datapath(
	 .data_in(Data_in1),
	 .Type_sel(Mem_type_sel),
	 .data_out(Data_in));
	 */

	always
	begin
		clk = 1'b1;
		#(PERIOD/2); clk = 1'b0;
		#(PERIOD/2);
	end


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
endmodule
