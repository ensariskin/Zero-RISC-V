//////////////////////////////////////////////////////////////////////////////////
// RV32I Data Memory Wishbone Adapter
// 
// This module adapts the RV32I core's data memory interface
// to the Wishbone bus standard for compatibility with memory models.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module rv32i_data_wb_adapter (
    input logic clk,
    input logic rst_n,
    
    // Core side interface
    input  logic [31:0] core_addr_i,
    input  logic [31:0] core_data_i,
    output logic [31:0] core_data_o,
    input  logic        core_we_i,
    input  logic [2:0]  core_sel_i,  // RV32I memory control
    
    // Wishbone master interface
    output logic        wb_cyc_o,
    output logic        wb_stb_o,
    output logic        wb_we_o,
    output logic [31:0] wb_adr_o,
    output logic [31:0] wb_dat_o,
    output logic [3:0]  wb_sel_o,
    input  logic        wb_stall_i,
    input  logic        wb_ack_i,
    input  logic [31:0] wb_dat_i,
    input  logic        wb_err_i
);
    localparam D = 1; // Delay for simulation purposes
    
    // Convert RV32I memory control to wishbone byte enables
    // core_sel_i[1:0]: 00=byte, 01=halfword, 10=word
    // core_sel_i[2]: 0=signed, 1=unsigned (for loads)
    logic [3:0] byte_sel;
    always_comb begin
        case (core_sel_i[1:0])
            2'b00: byte_sel = 4'b0001;  // Byte
            2'b01: byte_sel = 4'b0011;  // Half word  
            2'b10: byte_sel = 4'b1111;  // Word
            default: byte_sel = 4'b0000;
        endcase
        // Shift based on byte address to align with memory
        wb_sel_o = byte_sel;
    end
    
    // Wishbone outputs
    assign wb_cyc_o = 1'b1;
    assign wb_stb_o = 1'b1;
    assign wb_we_o  = core_we_i;
    assign wb_adr_o = core_addr_i;
    assign wb_dat_o = core_data_i;
    
    // Core output with data organization
    data_organizer #(.size(32)) data_org (
        .data_in(wb_dat_i),
        .Type_sel(core_sel_i),
        .data_out(core_data_o)
    );

endmodule
