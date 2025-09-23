`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2025
// Design Name: Fetch Buffer Integration
// Module Name: fetch_buffer_top
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Top-level module integrating multi_fetch with instruction_buffer
//              Provides a complete fetch subsystem for the superscalar processor
// 
// Dependencies: multi_fetch.sv, instruction_buffer.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// - Integrates 3-instruction fetch with variable-width buffer
// - Provides decoupling between fetch and decode stages
// - Handles backpressure and flush operations
//////////////////////////////////////////////////////////////////////////////////

module fetch_buffer_top #(
    parameter DATA_WIDTH = 32,
    parameter BUFFER_DEPTH = 16
)(
    input  logic clk,
    input  logic reset,
    
    // Memory interface (3-port for parallel fetch)
    output logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2,
    input  logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2,
    
    // Pipeline control signals
    input  logic flush,
    input  logic buble,
    
    // Branch prediction interface (from multi_fetch)
    output logic [DATA_WIDTH-1:0] pc_value_at_prediction_0, pc_value_at_prediction_1, pc_value_at_prediction_2,
    output logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2,
    input  logic update_prediction_valid_i_0, update_prediction_valid_i_1, update_prediction_valid_i_2,
    input  logic [DATA_WIDTH-1:0] update_prediction_pc_0, update_prediction_pc_1, update_prediction_pc_2,
    input  logic misprediction_0, misprediction_1, misprediction_2,
    input  logic [DATA_WIDTH-1:0] correct_pc,
    
    // Output to decode stages
    output logic [2:0] decode_valid_o,          // How many instructions are available for decode
    output logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2,
    output logic [DATA_WIDTH-1:0] pc_decode_o_0, pc_decode_o_1, pc_decode_o_2,
    output logic [DATA_WIDTH-1:0] imm_decode_o_0, imm_decode_o_1, imm_decode_o_2,
    output logic branch_prediction_decode_o_0, branch_prediction_decode_o_1, branch_prediction_decode_o_2,
    
    // Decode stage ready signals
    input  logic [2:0] decode_ready_i,          // Which decode stages are ready to accept instructions
    
    // Status outputs
    output logic buffer_empty_o,
    output logic buffer_full_o,
    output logic [$clog2(BUFFER_DEPTH):0] occupancy_o,
    
    // Legacy outputs for compatibility (until decode stages are updated)
    output logic [DATA_WIDTH-1:0] legacy_instruction_o_0, legacy_instruction_o_1, legacy_instruction_o_2,
    output logic [DATA_WIDTH-1:0] legacy_imm_o_0, legacy_imm_o_1, legacy_imm_o_2,
    output logic [DATA_WIDTH-1:0] pc_plus_o
);

    // Internal connections between multi_fetch and instruction_buffer
    logic [2:0] fetch_valid;
    logic fetch_ready;
    logic [DATA_WIDTH-1:0] fetch_pc_0, fetch_pc_1, fetch_pc_2;
    logic [DATA_WIDTH-1:0] fetch_imm_0, fetch_imm_1, fetch_imm_2;
    logic fetch_branch_pred_0, fetch_branch_pred_1, fetch_branch_pred_2;
    
    // Multi-Fetch Unit
    multi_fetch #(.size(DATA_WIDTH)) fetch_unit (
        .clk(clk),
        .reset(reset),
        
        // Memory interface
        .inst_addr_0(inst_addr_0),
        .instruction_i_0(instruction_i_0),
        .inst_addr_1(inst_addr_1),
        .instruction_i_1(instruction_i_1),
        .inst_addr_2(inst_addr_2),
        .instruction_i_2(instruction_i_2),
        
        // Pipeline control
        .flush(flush),
        .buble(buble),
        
        // Branch prediction interface
        .pc_value_at_prediction_0(pc_value_at_prediction_0),
        .branch_prediction_o_0(branch_prediction_o_0),
        .update_prediction_valid_i_0(update_prediction_valid_i_0),
        .update_prediction_pc_0(update_prediction_pc_0),
        .misprediction_0(misprediction_0),
        
        .pc_value_at_prediction_1(pc_value_at_prediction_1),
        .branch_prediction_o_1(branch_prediction_o_1),
        .update_prediction_valid_i_1(update_prediction_valid_i_1),
        .update_prediction_pc_1(update_prediction_pc_1),
        .misprediction_1(misprediction_1),
        
        .pc_value_at_prediction_2(pc_value_at_prediction_2),
        .branch_prediction_o_2(branch_prediction_o_2),
        .update_prediction_valid_i_2(update_prediction_valid_i_2),
        .update_prediction_pc_2(update_prediction_pc_2),
        .misprediction_2(misprediction_2),
        
        .correct_pc(correct_pc),
        
        // New buffer interface
        .fetch_valid_o(fetch_valid),
        .fetch_ready_i(fetch_ready),
        .pc_o_0(fetch_pc_0),
        .pc_o_1(fetch_pc_1),
        .pc_o_2(fetch_pc_2),
        
        // Legacy outputs (for compatibility)
        .instruction_o_0(legacy_instruction_o_0),
        .imm_o_0(legacy_imm_o_0),
        .instruction_o_1(legacy_instruction_o_1),
        .imm_o_1(legacy_imm_o_1),
        .instruction_o_2(legacy_instruction_o_2),
        .imm_o_2(legacy_imm_o_2),
        .pc_plus_o(pc_plus_o)
    );
    // TODO : There are one clock cycle latency from fetch to buffer due to multi_fetch internal registers
    //       : This can be optimized by removing some internal registers in multi_fetch if needed
    
    // Get immediate values from multi_fetch legacy outputs for now
    assign fetch_imm_0 = legacy_imm_o_0;
    assign fetch_imm_1 = legacy_imm_o_1;
    assign fetch_imm_2 = legacy_imm_o_2;
    
    // Get branch predictions from multi_fetch branch prediction outputs
    assign fetch_branch_pred_0 = branch_prediction_o_0;
    assign fetch_branch_pred_1 = branch_prediction_o_1;
    assign fetch_branch_pred_2 = branch_prediction_o_2;
    
    // Instruction Buffer
    instruction_buffer_new #(
        .BUFFER_DEPTH(BUFFER_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_buffer (
        .clk(clk),
        .reset(reset),
        
        // Input from multi_fetch
        .fetch_valid_i(fetch_valid),
        .instruction_i_0(legacy_instruction_o_0),
        .instruction_i_1(legacy_instruction_o_1),
        .instruction_i_2(legacy_instruction_o_2),
        .pc_i_0(fetch_pc_0),
        .pc_i_1(fetch_pc_1),
        .pc_i_2(fetch_pc_2),
        .imm_i_0(fetch_imm_0),
        .imm_i_1(fetch_imm_1),
        .imm_i_2(fetch_imm_2),
        .branch_prediction_i_0(fetch_branch_pred_0),
        .branch_prediction_i_1(fetch_branch_pred_1),
        .branch_prediction_i_2(fetch_branch_pred_2),
        
        // Output to decode stages
        .decode_valid_o(decode_valid_o),
        .instruction_o_0(instruction_o_0),
        .instruction_o_1(instruction_o_1),
        .instruction_o_2(instruction_o_2),
        .pc_o_0(pc_decode_o_0),
        .pc_o_1(pc_decode_o_1),
        .pc_o_2(pc_decode_o_2),
        .imm_o_0(imm_decode_o_0),
        .imm_o_1(imm_decode_o_1),
        .imm_o_2(imm_decode_o_2),
        .branch_prediction_o_0(branch_prediction_decode_o_0),
        .branch_prediction_o_1(branch_prediction_decode_o_1),
        .branch_prediction_o_2(branch_prediction_decode_o_2),
        
        // Control signals
        .decode_ready_i(decode_ready_i),
        .fetch_ready_o(fetch_ready),
        .flush_i(flush),
        
        // Status outputs
        .buffer_empty_o(buffer_empty_o),
        .buffer_full_o(buffer_full_o),
        .occupancy_o(occupancy_o)
    );

endmodule
