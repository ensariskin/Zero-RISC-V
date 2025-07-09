`timescale 1ns/1ns

module barebones_top_tb();

reg reset_i, clk_i;

integer i;
barebones_wb_top uut(.reset_i(reset_i), .clk_i(clk_i));

//100 MHz clock
always begin
clk_i = 1'b0; #12.5; clk_i = 1'b1; #12.5;
end

initial begin
//uncomment the program you want to simulate
//remove the " ../../test/memory_contents/ " parts if you are using Vivado.
//$readmemh("../../test/memory_contents/bubble_sort_irq.data",uut.memory.mem);
//$readmemh("../../test/memory_contents/bubble_sort.data",uut.memory.mem);
//$readmemh("../../test/memory_contents/aes_test.data",uut.memory.mem);
//$readmemh("soft_float.data",uut.memory.mem);
reset_i = 1'b0; 
for (i = 0; i < uut.memory.RAM_DEPTH; i = i + 1) begin
    uut.memory.mem[i] = {uut.memory.DATA_WIDTH{1'b0}};  // Initialize to 0
end
#200;
$readmemh("../hex/init.hex",uut.memory.mem); //read data after reset, because reset initializes memory to 0

#25;
reset_i = 1'b1; //Wait a cycle so that the instruction memory is ready
#5000;
$finish;
//interrupt signals, arbitrarily generated. uncomment if you need to.
/*
#2100; meip_i=1'b1; 
#400;  meip_i=1'b1;
#400;  meip_i=1'b1; 
#400;  meip_i=1'b1;
#850;  meip_i=1'b1;
#316;  meip_i=1'b1;
#763;  meip_i=1'b1;
#152;  meip_i=1'b1;
#761;  meip_i=1'b1;
#252;  meip_i=1'b1;*/
end

//this always block imitates an interrupt controller. uncomment if you are using machine external interrupt.
/*
always @(posedge clk_i)
begin
	if(irq_ack_o)
		meip_i = 1'b0;
end*/

endmodule

