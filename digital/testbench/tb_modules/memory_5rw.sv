module memory_5rw(
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
input         port1_wb_clk_i,

input         port2_wb_cyc_i,
input         port2_wb_stb_i,
input         port2_wb_we_i,
input [31:0]  port2_wb_adr_i,
input [31:0]  port2_wb_dat_i,
input [3:0]   port2_wb_sel_i,
output        port2_wb_stall_o,
output        port2_wb_ack_o,
output reg [31:0] port2_wb_dat_o,
output        port2_wb_err_o,
input         port2_wb_rst_i,
input         port2_wb_clk_i,

input         port3_wb_cyc_i,
input         port3_wb_stb_i,
input         port3_wb_we_i,
input [31:0]  port3_wb_adr_i,
input [31:0]  port3_wb_dat_i,
input [3:0]   port3_wb_sel_i,
output        port3_wb_stall_o,
output        port3_wb_ack_o,
output reg [31:0] port3_wb_dat_o,
output        port3_wb_err_o,
input         port3_wb_rst_i,
input         port3_wb_clk_i,

input         port4_wb_cyc_i,
input         port4_wb_stb_i,
input         port4_wb_we_i,
input [31:0]  port4_wb_adr_i,
input [31:0]  port4_wb_dat_i,
input [3:0]   port4_wb_sel_i,
output        port4_wb_stall_o,
output        port4_wb_ack_o,
output reg [31:0] port4_wb_dat_o,
output        port4_wb_err_o,
input         port4_wb_rst_i,
input         port4_wb_clk_i
);

parameter NUM_WMASKS = 4 ;
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 9 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

localparam D = 1; // Delay for simulation purposes

wire clk0; // clock
wire cs0; // active low chip select
wire we0; // active low write control
wire [NUM_WMASKS-1:0] wmask0; // write mask
wire [ADDR_WIDTH-1:0] addr0;
wire [DATA_WIDTH-1:0] din0;

wire clk1; // clock
wire cs1; // active low chip select
wire we1; // active low write control
wire [NUM_WMASKS-1:0] wmask1; // write mask
wire [ADDR_WIDTH-1:0] addr1;
wire [DATA_WIDTH-1:0] din1;

wire clk2; // clock
wire cs2; // active low chip select
wire we2; // active low write control
wire [NUM_WMASKS-1:0] wmask2; // write mask
wire [ADDR_WIDTH-1:0] addr2;
wire [DATA_WIDTH-1:0] din2;

wire clk3; // clock
wire cs3; // active low chip select
wire we3; // active low write control
wire [NUM_WMASKS-1:0] wmask3; // write mask
wire [ADDR_WIDTH-1:0] addr3;
wire [DATA_WIDTH-1:0] din3;

wire clk4; // clock
wire cs4; // active low chip select
wire we4; // active low write control
wire [NUM_WMASKS-1:0] wmask4; // write mask
wire [ADDR_WIDTH-1:0] addr4;
wire [DATA_WIDTH-1:0] din4;




reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1] /*verilator public*/;

// Port 0 assignments
assign clk0 = port0_wb_clk_i;
assign cs0 = ~port0_wb_stb_i;
assign we0 = ~port0_wb_we_i;
assign wmask0 = port0_wb_sel_i;
assign addr0 = port0_wb_adr_i[ADDR_WIDTH+1 : 2];
assign din0 = port0_wb_dat_i;
assign port0_wb_stall_o = 1'b0;
reg port0_ack;
always @(posedge port0_wb_clk_i or posedge port0_wb_rst_i)
begin
    if(port0_wb_rst_i)
        port0_ack <= #D 1'b0;
    else if(port0_wb_cyc_i)
        port0_ack <= #D port0_wb_stb_i;
end
assign port0_wb_ack_o = port0_ack;
assign port0_wb_err_o = 1'b0;

// Port 1 assignments
assign clk1 = port1_wb_clk_i;
assign cs1 = ~port1_wb_stb_i;
assign we1 = ~port1_wb_we_i;
assign wmask1 = port1_wb_sel_i;
assign addr1 = port1_wb_adr_i[ADDR_WIDTH+1 : 2];
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

// Port 2 assignments
assign clk2 = port2_wb_clk_i;
assign cs2 = ~port2_wb_stb_i;
assign we2 = ~port2_wb_we_i;
assign wmask2 = port2_wb_sel_i;
assign addr2 = port2_wb_adr_i[ADDR_WIDTH+1 : 2];
assign din2 = port2_wb_dat_i;
assign port2_wb_stall_o = 1'b0;
reg port2_ack;
always @(posedge port2_wb_clk_i or posedge port2_wb_rst_i)
begin
    if(port2_wb_rst_i)
        port2_ack <= #D 1'b0;
    else if(port2_wb_cyc_i)
        port2_ack <= #D port2_wb_stb_i;
end
assign port2_wb_ack_o = port2_ack;
assign port2_wb_err_o = 1'b0;


// Port 3 assignments
assign clk3 = port3_wb_clk_i;
assign cs3 = ~port3_wb_stb_i;
assign we3 = ~port3_wb_we_i;
assign wmask3 = port3_wb_sel_i;
assign addr3 = port3_wb_adr_i[ADDR_WIDTH+1 : 2];
assign din3 = port3_wb_dat_i;
assign port3_wb_stall_o = 1'b0;
reg port3_ack;
always @(posedge port3_wb_clk_i or posedge port3_wb_rst_i)
begin
    if(port3_wb_rst_i)
        port3_ack <= #D 1'b0;
    else if(port3_wb_cyc_i)
        port3_ack <= #D port3_wb_stb_i;
end
assign port3_wb_ack_o = port3_ack;
assign port3_wb_err_o = 1'b0;

// Port 4 assignments
assign clk4 = port4_wb_clk_i;
assign cs4 = ~port4_wb_stb_i;
assign we4 = ~port4_wb_we_i;
assign wmask4 = port4_wb_sel_i;
assign addr4 = port4_wb_adr_i[ADDR_WIDTH+1 : 2];
assign din4 = port4_wb_dat_i;
assign port4_wb_stall_o = 1'b0;
reg port4_ack;
always @(posedge port4_wb_clk_i or posedge port4_wb_rst_i)begin
    if(port4_wb_rst_i)
        port4_ack <= #D 1'b0;
    else if(port4_wb_cyc_i)
        port4_ack <= #D port4_wb_stb_i;
end
assign port4_wb_ack_o = port4_ack;
assign port4_wb_err_o = 1'b0;


`ifdef FPGA_READMEM
initial $readmemh("reset_handler.mem",mem,7424,7487);
initial $readmemh("bootloader.mem",mem,7488,8191);
`endif

  // Memory Write Block Port 0
  // Write Operation : When we0 = 0, cs0 = 0
always @ (posedge clk0)
begin
    if ( !cs0 && !we0 ) begin
        if (wmask0[0])
            mem[addr0][7:0] <= din0[7:0];
        if (wmask0[1])
            mem[addr0][15:8] <= din0[15:8];
        if (wmask0[2])
            mem[addr0][23:16] <= din0[23:16];
        if (wmask0[3])
            mem[addr0][31:24] <= din0[31:24];
    end
end

  // Memory Read Block Port 0
  // Read Operation : When we0 = 1, cs0 = 0
always @ (posedge clk0)
begin
    if (!cs0 && we0)
        port0_wb_dat_o <= #D mem[addr0];
end

  // Memory Write Block Port 1
  // Write Operation : When we1 = 0, cs1 = 0
always @ (posedge clk0)
begin
    if ( !cs1 && !we1 ) begin
        if (wmask1[0])
            mem[addr1][7:0] <= din1[7:0];
        if (wmask1[1])
            mem[addr1][15:8] <= din1[15:8];
        if (wmask1[2])
            mem[addr1][23:16] <= din1[23:16];
        if (wmask1[3])
            mem[addr1][31:24] <= din1[31:24];
    end
end

  // Memory Read Block Port 1
  // Read Operation : When we1 = 1, cs1 = 0
always @(posedge clk0)
begin : MEM_READ1
    if (!cs1 && we1)
        port1_wb_dat_o <= #D mem[addr1]; // <= #D
end

  // Memory Write Block Port 2
  // Write Operation : When we2 = 0, cs2 = 0
always @ (posedge clk0)
begin
    if ( !cs2 && !we2 ) begin
        if (wmask2[0])
            mem[addr2][7:0] <= din2[7:0];
        if (wmask2[1])
            mem[addr2][15:8] <= din2[15:8];
        if (wmask2[2])
            mem[addr2][23:16] <= din2[23:16];
        if (wmask2[3])
            mem[addr2][31:24] <= din2[31:24];
    end
end

  // Memory Read Block Port 2
  // Read Operation : When we2 = 1, cs2 = 0
always @(posedge clk0)
begin : MEM_READ2
    if (!cs2 && we2)
        port2_wb_dat_o <= #D mem[addr2]; // <= #D
end

always @(posedge clk0)
begin : MEM_READ3
    if (!cs3 && we3)
        port3_wb_dat_o <= #D mem[addr3]; // <= #D
end


always @(posedge clk0)
begin : MEM_READ4
    if (!cs4 && we4)
        port4_wb_dat_o <= #D mem[addr4]; // 
end


endmodule
