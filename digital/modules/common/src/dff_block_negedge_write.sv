`timescale 1ns/1ns

module dff_block_negedge_write #(parameter mem_width = 16, parameter mem_depth = 16)(
    input  logic clk,
    input  logic reset,
    input  logic we,

    input  logic [mem_width-1 : 0] data_in,
    input  logic [mem_depth-1 : 0] wr_sel,
    output logic [mem_width*mem_depth-1 : 0] data_out);

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) zero(
    .clk(clk), .reset(1'b0), .data_in(32'h0), .we(wr_sel[0] & we),
    .data_out(data_out[31:0]));
    
    dff_sync_reset_negedge_write #(.mem_width(mem_width)) ra(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[1] & we),
    .data_out(data_out[63:32]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) sp(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[2] & we),
    .data_out(data_out[95:64]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) gp(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[3] & we),
    .data_out(data_out[127:96]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) tp(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[4] & we),
    .data_out(data_out[159:128]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t0(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[5] & we),
    .data_out(data_out[191:160]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t1(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[6] & we),
    .data_out(data_out[223:192]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t2(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[7] & we),
    .data_out(data_out[255:224]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s0(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[8] & we),
    .data_out(data_out[287:256]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s1(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[9] & we),
    .data_out(data_out[319:288]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a0(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[10] & we),
    .data_out(data_out[351:320]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a1(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[11] & we),
    .data_out(data_out[383:352]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a2(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[12] & we),
    .data_out(data_out[415:384]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a3(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[13] & we),
    .data_out(data_out[447:416]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a4(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[14] & we),
    .data_out(data_out[479:448]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a5(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[15] & we),
    .data_out(data_out[511:480]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a6(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[16] & we),
    .data_out(data_out[543:512]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) a7(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[17] & we),
    .data_out(data_out[575:544]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s2(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[18] & we),
    .data_out(data_out[607:576]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s3(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[19] & we),
    .data_out(data_out[639:608]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s4(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[20] & we),
    .data_out(data_out[671:640]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s5(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[21] & we),
    .data_out(data_out[703:672]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s6(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[22] & we),
    .data_out(data_out[735:704]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s7(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[23] & we),
    .data_out(data_out[767:736]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s8(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[24] & we),
    .data_out(data_out[799:768]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s9(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[25] & we),
    .data_out(data_out[831:800]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s10(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[26] & we),
    .data_out(data_out[863:832]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) s11(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[27] & we),
    .data_out(data_out[895:864]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t3(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[28] & we),
    .data_out(data_out[927:896]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t4(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[29] & we),
    .data_out(data_out[959:928]));

    dff_sync_reset_negedge_write #(.mem_width(mem_width)) t5(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[30] & we),
    .data_out(data_out[991:960]));

     dff_sync_reset_negedge_write #(.mem_width(mem_width)) t6(
    .clk(clk), .reset(reset), .data_in(data_in), .we(wr_sel[31] & we),
    .data_out(data_out[1023:992]));

endmodule
