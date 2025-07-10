module barebones_wb_top(input clk_i,
                        input reset_i);

parameter NUM_SLAVES = 2;
parameter reset_vector = 32'h0000_0000; //The starting address for the program counter

//Wishbone master interface signals for core
wire data_wb_cyc_o;
wire data_wb_stb_o;
wire data_wb_we_o;
wire [31:0] data_wb_adr_o;
wire [31:0] data_wb_dat_o;
wire [3:0] data_wb_sel_o;
wire data_wb_stall_i;
wire data_wb_ack_i;
wire [31:0] data_wb_dat_i;
wire data_wb_err_i;
wire data_wb_rst_i;
wire data_wb_clk_i;

wire inst_wb_cyc_o;
wire inst_wb_stb_o;
wire inst_wb_we_o;
wire [31:0] inst_wb_adr_o;
wire [31:0] inst_wb_dat_o;
wire [3:0] inst_wb_sel_o;
//wire inst_wb_stall_i;
//wire inst_wb_ack_i;
wire [31:0] inst_wb_dat_i;
wire inst_wb_err_i;
//wire inst_wb_rst_i;
//wire inst_wb_clk_i;

//Wishbone slave signals for peripherals
wire [NUM_SLAVES-1 : 0] wb_cyc_i;
wire [NUM_SLAVES-1 : 0] wb_stb_i;
wire [NUM_SLAVES-1 : 0] wb_we_i;
wire [31:0] wb_adr_i [NUM_SLAVES-1 : 0];
wire [31:0] wb_dat_i [NUM_SLAVES-1 : 0];
wire [3:0] wb_sel_i [NUM_SLAVES-1 : 0];
wire [NUM_SLAVES-1 : 0] wb_stall_o;
wire [NUM_SLAVES-1 : 0] wb_ack_o;
wire [31:0] wb_dat_o [NUM_SLAVES-1 : 0];
wire [NUM_SLAVES-1 : 0] wb_err_o;
wire [NUM_SLAVES-1 : 0] wb_rst_i;
wire [NUM_SLAVES-1 : 0] wb_clk_i;
reg [NUM_SLAVES-1 : 0] r_stb;

wire [31:0] slave_adr_begin [NUM_SLAVES-1 : 0];
wire [31:0] slave_adr_end [NUM_SLAVES-1 : 0];

assign slave_adr_begin[0] = 32'h0000_0000 + reset_vector;
assign slave_adr_end[0] = 32'h0000_6FFF + reset_vector;

assign slave_adr_begin[1] = 32'h0000_0000 + reset_vector;
assign slave_adr_end[1] = 32'h0000_7FFF + reset_vector;

assign wb_cyc_i[0] = inst_wb_cyc_o;
assign wb_stb_i[0] = inst_wb_stb_o && ((slave_adr_begin[0] <= wb_adr_i[0]) && (wb_adr_i[0] <= slave_adr_end[0])); //0 if out of instruction address range
assign wb_we_i[0] = inst_wb_we_o;
assign wb_adr_i[0] = inst_wb_adr_o;
assign wb_dat_i[0] = inst_wb_dat_o;
assign wb_sel_i[0] = inst_wb_sel_o;
assign wb_rst_i[0] = ~reset_i;
assign wb_clk_i[0] = clk_i;
assign inst_wb_dat_i = wb_dat_o[0];
//assign inst_wb_ack_i = wb_ack_o[0];
//assign inst_wb_stall_i = wb_stall_o[0];
assign inst_wb_err_i = wb_err_o[0];

genvar i;
generate
    for (i = 1; i<NUM_SLAVES ;i=i+1)
    begin
        assign wb_cyc_i[i] = data_wb_cyc_o;
        assign wb_stb_i[i] = data_wb_stb_o && ((slave_adr_begin[i] <= wb_adr_i[i]) && (wb_adr_i[i] <= slave_adr_end[i]));
        assign wb_we_i[i] = data_wb_we_o;
        assign wb_adr_i[i] = data_wb_adr_o;
        assign wb_dat_i[i] = data_wb_dat_o;
        assign wb_sel_i[i] = data_wb_sel_o;
        assign wb_rst_i[i] = ~reset_i;
        assign wb_clk_i[i] = clk_i;
    end
endgenerate

//Register strobe signals
always @(posedge wb_clk_i[0] or posedge wb_rst_i[0])
begin
    if(wb_rst_i[0])
        r_stb <= 0;
    else
        r_stb <= wb_stb_i;
end

reg [31:0] r_data_wb_dat_i;
reg r_data_wb_err_i;
reg r_data_wb_stall_i;
reg r_data_wb_ack_i;
//reg valid;
reg Break;
integer k;
always @(*)
begin
	Break = 1'b0;
    for (k = 1; k < NUM_SLAVES; k = k+1)
    begin
        if(Break != 1'b1) begin
            if(r_stb[k])
            begin
                r_data_wb_dat_i = wb_dat_o[k];
                r_data_wb_stall_i = wb_stall_o[k];
                r_data_wb_err_i = wb_err_o[k];
                r_data_wb_ack_i = wb_ack_o[k];
                Break = 1;
            end
            else
            begin
                r_data_wb_dat_i = 32'b0;
                r_data_wb_stall_i = 1'b0;
                r_data_wb_err_i = 1'b0;
                r_data_wb_ack_i = 1'b0;
            end
        end
    end
end

assign data_wb_dat_i = r_data_wb_dat_i;
assign data_wb_ack_i = r_data_wb_ack_i;
assign data_wb_stall_i = r_data_wb_stall_i;
assign data_wb_err_i = r_data_wb_err_i;
assign data_wb_clk_i = clk_i;
assign data_wb_rst_i = ~reset_i;


rv32i_core_wb core0  (.reset_i(reset_i),
               .clk_i(clk_i),

               //Wishbone interface for data memory
               .data_wb_cyc_o(data_wb_cyc_o),
               .data_wb_stb_o(data_wb_stb_o),
               .data_wb_we_o(data_wb_we_o),
               .data_wb_adr_o(data_wb_adr_o),
               .data_wb_dat_o(data_wb_dat_o),
               .data_wb_sel_o(data_wb_sel_o),
               .data_wb_stall_i(data_wb_stall_i),
               .data_wb_ack_i(data_wb_ack_i),
               .data_wb_dat_i(data_wb_dat_i),
               .data_wb_err_i(data_wb_err_i),
               .data_wb_rst_i(data_wb_rst_i),
               .data_wb_clk_i(data_wb_clk_i),

               //Wishbone interface for instruction memory
               .inst_wb_cyc_o(inst_wb_cyc_o),
               .inst_wb_stb_o(inst_wb_stb_o),
               .inst_wb_we_o(inst_wb_we_o),
               .inst_wb_adr_o(inst_wb_adr_o),
               .inst_wb_dat_o(inst_wb_dat_o),
               .inst_wb_sel_o(inst_wb_sel_o),
               //.inst_wb_stall_i(inst_wb_stall_i),
               //.inst_wb_ack_i(inst_wb_ack_i),
               .inst_wb_dat_i(inst_wb_dat_i),
               .inst_wb_err_i(inst_wb_err_i)
               //.inst_wb_rst_i(inst_wb_rst_i),
               //.inst_wb_clk_i(inst_wb_clk_i)
               );


memory_2rw_wb #(.ADDR_WIDTH(13)) memory(.port0_wb_cyc_i(wb_cyc_i[0]),
                                        .port0_wb_stb_i(wb_stb_i[0]),
                                        .port0_wb_we_i(wb_we_i[0]),
                                        .port0_wb_adr_i(wb_adr_i[0]),
                                        .port0_wb_dat_i(wb_dat_i[0]),
                                        .port0_wb_sel_i(wb_sel_i[0]),
                                        .port0_wb_stall_o(wb_stall_o[0]),
                                        .port0_wb_ack_o(wb_ack_o[0]),
                                        .port0_wb_dat_o(wb_dat_o[0]),
                                        .port0_wb_err_o(wb_err_o[0]),
                                        .port0_wb_rst_i(wb_rst_i[0]),
                                        .port0_wb_clk_i(wb_clk_i[0]),

                                        .port1_wb_cyc_i(wb_cyc_i[1]),
                                        .port1_wb_stb_i(wb_stb_i[1]),
                                        .port1_wb_we_i(wb_we_i[1]),
                                        .port1_wb_adr_i(wb_adr_i[1]),
                                        .port1_wb_dat_i(wb_dat_i[1]),
                                        .port1_wb_sel_i(wb_sel_i[1]),
                                        .port1_wb_stall_o(wb_stall_o[1]),
                                        .port1_wb_ack_o(wb_ack_o[1]),
                                        .port1_wb_dat_o(wb_dat_o[1]),
                                        .port1_wb_err_o(wb_err_o[1]),
                                        .port1_wb_rst_i(wb_rst_i[1]),
                                        .port1_wb_clk_i(wb_clk_i[1]));

endmodule
