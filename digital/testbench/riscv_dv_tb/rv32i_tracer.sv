//////////////////////////////////////////////////////////////////////////////////
// RV32I Core Tracer
// 
// This module adapts the generic tracer for the RV32I core by extracting
// the necessary signals and formatting them for RISC-V DV compatibility
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module rv32i_tracer (
    input logic clk_i,
    input logic valid,
    input logic [31:0] pc,
    input logic [31:0] instr,
    input logic [4:0] reg_addr,
    input logic [31:0] reg_data,
    input logic is_load,
    input logic is_store,
    input logic is_float,
    input logic [1:0] mem_size,
    input logic [31:0] mem_addr,
    input logic [31:0] mem_data,
    input logic [31:0] fpu_flags
);

    // Instantiate the generic tracer
    tracer tracer_inst (
        .clk_i(clk_i),
        .valid(valid),
        .pc(pc),
        .instr(instr),
        .reg_addr(reg_addr),
        .reg_data(reg_data),
        .is_load(is_load),
        .is_store(is_store),
        .is_float(is_float),
        .mem_size(mem_size),
        .mem_addr(mem_addr),
        .mem_data(mem_data),
        .fpu_flags(fpu_flags)
    );

endmodule
