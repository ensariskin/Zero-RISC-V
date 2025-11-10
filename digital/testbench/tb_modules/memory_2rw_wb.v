
module memory_2rw_wb(
input         port0_wb_cyc_i,
input         port0_wb_stb_i,
input         port0_wb_we_i,
input [31:0]  port0_wb_adr_i,
input [31:0]  port0_wb_dat_i,
input [3:0]   port0_wb_sel_i,
output        port0_wb_stall_o,
output        port0_wb_ack_o,
output reg [31:0] port0_wb_dat_o,
output        port0_wb_err_o,
input         port0_wb_rst_i,
input         port0_wb_clk_i,

input         port1_wb_cyc_i,
input         port1_wb_stb_i,
input         port1_wb_we_i,
input [31:0]  port1_wb_adr_i,
input [31:0]  port1_wb_dat_i,
input [3:0]   port1_wb_sel_i,
output        port1_wb_stall_o,
output        port1_wb_ack_o,
output reg [31:0] port1_wb_dat_o,
output        port1_wb_err_o,
input         port1_wb_rst_i,
input         port1_wb_clk_i);

parameter NUM_WMASKS = 4 ;
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 9 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

// Number of address bits for byte level addressing. DATA_WIDTH is fixed to
// 32-bit, so we need two extra address bits to address individual bytes.
localparam BYTE_ADDR_WIDTH = ADDR_WIDTH + 2;
localparam RAM_BYTE_DEPTH  = 1 << BYTE_ADDR_WIDTH;

localparam D = 1; // Delay for simulation purposes

wire clk0; // clock
wire cs0; // active low chip select
wire we0; // active low write control
wire [NUM_WMASKS-1:0] wmask0; // write mask
wire [BYTE_ADDR_WIDTH-1:0] addr0;
wire [DATA_WIDTH-1:0] din0;
wire [DATA_WIDTH-1:0] dout0;
wire clk1; // clock
wire cs1; // active low chip select
wire we1; // active low write control
wire [NUM_WMASKS-1:0] wmask1; // write mask
wire [BYTE_ADDR_WIDTH-1:0] addr1;
wire [DATA_WIDTH-1:0] din1;
wire [DATA_WIDTH-1:0] dout1;

// Byte-addressable memory to support misaligned accesses
reg [7:0] mem [0:RAM_BYTE_DEPTH-1] ;

assign clk0 = port0_wb_clk_i;
assign cs0 = ~port0_wb_stb_i;
assign we0 = ~port0_wb_we_i;
assign wmask0 = port0_wb_sel_i;
// Byte address within the memory
assign addr0 = port0_wb_adr_i[BYTE_ADDR_WIDTH-1:0];
assign din0 = port0_wb_dat_i;
assign port0_wb_stall_o = 1'b0; // todo testbench stall to check cpu behavior
reg port0_ack;
always @(posedge port0_wb_clk_i or posedge port0_wb_rst_i)
begin
    if(port0_wb_rst_i)
        port0_ack <= #D 1'b0;
    else if(port0_wb_cyc_i)
        port0_ack <= #D port0_wb_stb_i;
    else 
        port0_ack <= #D 1'b0;
end
assign port0_wb_ack_o = port0_ack;
assign port0_wb_err_o = 1'b0;

assign clk1 = port1_wb_clk_i;
assign cs1 = ~port1_wb_stb_i;
assign we1 = ~port1_wb_we_i;
assign wmask1 = port1_wb_sel_i;
assign addr1 = port1_wb_adr_i[BYTE_ADDR_WIDTH-1:0];
assign din1 = port1_wb_dat_i;
assign port1_wb_stall_o = 1'b0;
reg port1_ack;
always @(posedge port1_wb_clk_i or posedge port1_wb_rst_i)
begin
    if(port1_wb_rst_i)
        port1_ack <= #D 1'b0;
    else if(port1_wb_cyc_i)
        port1_ack <= #D port1_wb_stb_i;
end
assign port1_wb_ack_o = port1_ack;
assign port1_wb_err_o = 1'b0;



`ifdef FPGA_READMEM
initial $readmemh("reset_handler.mem",mem,7424,7487);
initial $readmemh("bootloader.mem",mem,7488,8191);
`endif

  // Memory Write Block Port 0
  // Write Operation : When we0 = 0, cs0 = 0
always @(posedge clk0)
begin
    if(port0_wb_rst_i) begin
        integer j;
        for (j = 0; j < RAM_BYTE_DEPTH; j = j + 1) begin
            mem[j] <= 8'h00;
        end
    end else
    if (!cs0 && !we0) begin
        integer i;
        for (i = 0; i < 4; i = i + 1) begin
            if (wmask0[i])
                mem[addr0 + i] <= din0[i*8 +: 8];
        end
    end
end

  // Memory Read Block Port 0
  // Read Operation : When we0 = 1, cs0 = 0
always @(posedge clk0)
begin
    if (!cs0 && we0)
        port0_wb_dat_o <= #D {mem[addr0+3], mem[addr0+2], mem[addr0+1], mem[addr0]};
end

  // Memory Write Block Port 1
  // Write Operation : When we1 = 0, cs1 = 0
always @(posedge clk1)
begin
    if (!cs1 && !we1) begin
        integer i;
        for (i = 0; i < 4; i = i + 1) begin
            if (wmask1[i])
                mem[addr1 + i] <= din1[i*8 +: 8];
        end
    end
end

  // Memory Read Block Port 1
  // Read Operation : When we1 = 1, cs1 = 0
always @(*) //(posedge clk1)
begin : MEM_READ1
    if (!cs1 && we1)
        port1_wb_dat_o = {mem[addr1+3], mem[addr1+2], mem[addr1+1], mem[addr1]};
end

endmodule
