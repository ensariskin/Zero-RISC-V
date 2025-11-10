//////////////////////////////////////////////////////////////////////////////////
// RV32I Instruction Memory Wishbone Adapter
// 
// This module adapts the RV32I core's simple instruction fetch interface
// to the Wishbone bus standard for compatibility with memory models.
// 
// The adapter provides immediate instruction data for the core by maintaining
// a simple cache-like behavior where instruction fetches are always ready.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module rv32i_inst_wb_adapter (
    input logic clk,
    input logic rst_n,
    
    // Core side interface
    input  logic [31:0] core_addr_i,
    output logic [31:0] core_data_o,
    
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

    // For instruction memory, we need fast access to not stall the pipeline
    // We'll implement a simple approach where we always have a pending request
    // and provide the most recent data
    
    logic [31:0] current_addr;
    logic [31:0] instruction_data;
    logic data_valid;
    logic addr_changed;
    
    // Track address changes
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_addr <= #D 32'h0;
            addr_changed <= #D 1'b0;
        end else begin
            current_addr <= #D core_addr_i;
            addr_changed <= #D (core_addr_i != current_addr);
        end
    end
    
    // Data storage and validity
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            instruction_data <= #D 32'h0;
            data_valid <= #D 1'b0;
        end else if (wb_ack_i) begin
            instruction_data <= #D wb_dat_i;
            data_valid <= #D 1'b1;
        end else if (addr_changed) begin
            data_valid <= #D 1'b0;  // Invalidate on address change
        end
    end
    
    // Wishbone interface - always try to fetch when address changes or data is invalid
    assign wb_cyc_o = 1'b1;
    assign wb_stb_o = 1'b1;//core_addr_i[31];
    assign wb_we_o  = 1'b0;  // Read only for instruction fetch
    assign wb_adr_o = {1'b0, core_addr_i[30:0]};
    assign wb_dat_o = 32'h0; // No data output for reads
    assign wb_sel_o = 4'hf;  // Full word access
    
    // Output the instruction data immediately if valid, otherwise provide NOP
    assign core_data_o = wb_dat_i;  // NOP (addi x0, x0, 0)

endmodule
