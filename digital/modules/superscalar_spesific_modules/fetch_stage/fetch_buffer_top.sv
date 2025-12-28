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
        parameter BUFFER_DEPTH = 16,
        parameter ENTRIES = 32,                        // Number of predictor entries
        parameter INDEX_WIDTH = $clog2(ENTRIES)       // Auto-calculated index width
    )(
        input  logic clk,
        input  logic reset,
        input  logic buble,
        input  logic secure_mode,

        // Memory interface (3-port for parallel fetch)
        output logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2, inst_addr_3, inst_addr_4,
        input  logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2, instruction_i_3, instruction_i_4,

        //==========================================================================
        // BRAT Interface (Simplified - all branch/JALR info comes from BRAT in-order)
        //==========================================================================
        // 1. Misprediction signals (for PC redirect - eager flush)
        input  logic misprediction_i_0, misprediction_i_1, misprediction_i_2,

        // 2. Update valid signals (for predictor update - resolved OR mispredicted)
        input  logic update_valid_i_0, update_valid_i_1, update_valid_i_2,

        // 3. Is JALR flags (0=branch, 1=JALR - determines which predictor to update)
        input  logic is_jalr_i_0, is_jalr_i_1, is_jalr_i_2,

        // 4. PC at prediction (for predictor table lookup during update)
        input  logic [DATA_WIDTH-1:0] pc_at_prediction_i_0, pc_at_prediction_i_1, pc_at_prediction_i_2,

        // 5. Correct PC (for misprediction redirect and predictor update)
        input  logic [DATA_WIDTH-1:0] correct_pc_i_0, correct_pc_i_1, correct_pc_i_2,

        input  logic [INDEX_WIDTH+2:0] update_global_history_0,
        input  logic [INDEX_WIDTH+2:0] update_global_history_1,
        input  logic [INDEX_WIDTH+2:0] update_global_history_2,

        // Output to decode stages
        output logic [2:0] decode_valid_o,          // How many instructions are available for decode
        output logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2,
        output logic [DATA_WIDTH-1:0] pc_decode_o_0, pc_decode_o_1, pc_decode_o_2,
        output logic [DATA_WIDTH-1:0] imm_decode_o_0, imm_decode_o_1, imm_decode_o_2,
        output logic branch_prediction_decode_o_0, branch_prediction_decode_o_1, branch_prediction_decode_o_2,
        output logic [DATA_WIDTH-1:0] pc_value_at_prediction_0, pc_value_at_prediction_1, pc_value_at_prediction_2,
        output logic [INDEX_WIDTH+2:0] global_history_0_o, // Current global history and prediction
        output logic [INDEX_WIDTH+2:0] global_history_1_o, // Current global history and prediction
        output logic [INDEX_WIDTH+2:0] global_history_2_o, // Current global history and prediction

        // Decode stage ready signals
        input  logic [2:0] decode_ready_i,          // Which decode stages are ready to accept instructions

        //RAS checkpoint/restore interface
        output logic [2:0] ras_tos_checkpoint_o, // RAS TOS pointers at fetch time for each instruction
        input  logic ras_restore_en_i,              // Signal to restore RAS from BRAT on misprediction
        input  logic [2:0] ras_restore_tos_i,

        // Status outputs
        output logic buffer_empty_o,
        output logic buffer_full_o,
        output logic [$clog2(BUFFER_DEPTH):0] occupancy_o,

        // TMR Fatal Error
        output logic fatal_o
    );

    // Internal connections between multi_fetch and instruction_buffer
    logic [4:0] fetch_valid;
    logic fetch_ready; // todo : I am not sure about using indpendent ready signals for each instruction, if there  is not enough spaace to store all three instructions we can wait I think
    logic [DATA_WIDTH-1:0] fetch_pc_0, fetch_pc_1, fetch_pc_2, fetch_pc_3, fetch_pc_4;
    logic [DATA_WIDTH-1:0] fetch_imm_0, fetch_imm_1, fetch_imm_2, fetch_imm_3, fetch_imm_4;
    logic [DATA_WIDTH-1:0] fetch_inst_0, fetch_inst_1, fetch_inst_2, fetch_inst_3, fetch_inst_4;
    logic [DATA_WIDTH-1:0] fetch_pc_value_at_prediction_0, fetch_pc_value_at_prediction_1, fetch_pc_value_at_prediction_2, fetch_pc_value_at_prediction_3, fetch_pc_value_at_prediction_4;
    logic fetch_branch_pred_0, fetch_branch_pred_1, fetch_branch_pred_2, fetch_branch_pred_3, fetch_branch_pred_4;
    logic [2:0] ras_tos_checkpoint;
    logic [INDEX_WIDTH+2:0] global_history_0, global_history_1, global_history_2, global_history_3, global_history_4;
    logic multi_fetch_fatal;
    logic inst_buffer_fatal;

    assign fatal_o = multi_fetch_fatal | inst_buffer_fatal;

    // Multi-Fetch Unit
    multi_fetch #(.size(DATA_WIDTH), .ENTRIES(ENTRIES)) fetch_unit (
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .secure_mode(secure_mode),
        // Memory interface
        .inst_addr_0(inst_addr_0),
        .inst_addr_1(inst_addr_1),
        .inst_addr_2(inst_addr_2),
        .inst_addr_3(inst_addr_3),
        .inst_addr_4(inst_addr_4),

        .instruction_i_0(instruction_i_0),
        .instruction_i_1(instruction_i_1),
        .instruction_i_2(instruction_i_2),
        .instruction_i_3(instruction_i_3),
        .instruction_i_4(instruction_i_4),

        //==========================================================================
        // BRAT Interface (Simplified)
        //==========================================================================
        // 1. Misprediction signals
        .misprediction_i_0(misprediction_i_0),
        .misprediction_i_1(misprediction_i_1),
        .misprediction_i_2(misprediction_i_2),

        // 2. Update valid signals
        .update_valid_i_0(update_valid_i_0),
        .update_valid_i_1(update_valid_i_1),
        .update_valid_i_2(update_valid_i_2),

        // 3. Is JALR flags
        .is_jalr_i_0(is_jalr_i_0),
        .is_jalr_i_1(is_jalr_i_1),
        .is_jalr_i_2(is_jalr_i_2),

        // 4. PC at prediction
        .pc_at_prediction_i_0(pc_at_prediction_i_0),
        .pc_at_prediction_i_1(pc_at_prediction_i_1),
        .pc_at_prediction_i_2(pc_at_prediction_i_2),

        // 5. Correct PC
        .correct_pc_i_0(correct_pc_i_0),
        .correct_pc_i_1(correct_pc_i_1),
        .correct_pc_i_2(correct_pc_i_2),

        .update_global_history_0,
        .update_global_history_1,
        .update_global_history_2,

        // Legacy outputs (fetch-stage predictions)
        .pc_value_at_prediction_0(fetch_pc_value_at_prediction_0),
        .branch_prediction_o_0(fetch_branch_pred_0),
        .global_history_0_o(global_history_0),

        .pc_value_at_prediction_1(fetch_pc_value_at_prediction_1),
        .branch_prediction_o_1(fetch_branch_pred_1),
        .global_history_1_o(global_history_1),

        .pc_value_at_prediction_2(fetch_pc_value_at_prediction_2),
        .branch_prediction_o_2(fetch_branch_pred_2),
        .global_history_2_o(global_history_2),

        .pc_value_at_prediction_3(fetch_pc_value_at_prediction_3),
        .branch_prediction_o_3(fetch_branch_pred_3),
        .global_history_3_o(global_history_3),

        .pc_value_at_prediction_4(fetch_pc_value_at_prediction_4),
        .branch_prediction_o_4(fetch_branch_pred_4),
        .global_history_4_o(global_history_4),

        // New buffer interface
        .fetch_valid_o(fetch_valid),
        .fetch_ready_i(fetch_ready),
        .pc_o_0(fetch_pc_0),
        .pc_o_1(fetch_pc_1),
        .pc_o_2(fetch_pc_2),
        .pc_o_3(fetch_pc_3),
        .pc_o_4(fetch_pc_4),
        // Legacy outputs (for compatibility) // todo consider removing immediate outputs, sending them probably more costly than recalculating in decode
        .instruction_o_0(fetch_inst_0),
        .instruction_o_1(fetch_inst_1),
        .instruction_o_2(fetch_inst_2),
        .instruction_o_3(fetch_inst_3),
        .instruction_o_4(fetch_inst_4),
        .imm_o_0(fetch_imm_0),
        .imm_o_1(fetch_imm_1),
        .imm_o_2(fetch_imm_2),
        .imm_o_3(fetch_imm_3),
        .imm_o_4(fetch_imm_4),

        //RAS checkpoint/restore interface
        .ras_tos_checkpoint_o(ras_tos_checkpoint),
        .ras_restore_en_i(ras_restore_en_i),
        .ras_restore_tos_i(ras_restore_tos_i),
        .fatal_o(multi_fetch_fatal)
    );

    // Generate combined eager flush signal (any misprediction triggers flush)
    logic eager_flush;
    assign eager_flush = misprediction_i_0 | misprediction_i_1 | misprediction_i_2;

    // Instruction Buffer
    instruction_buffer_new #(
        .BUFFER_DEPTH(BUFFER_DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ENTRIES(ENTRIES)
    ) inst_buffer (
        .clk(clk),
        .reset(reset),
        .flush_i(eager_flush),
        .secure_mode(secure_mode),
        .fatal_error_o(inst_buffer_fatal),
        // Input from multi_fetch
        .fetch_valid_i(fetch_valid),
        .fetch_ready_o(fetch_ready),

        .instruction_i_0(fetch_inst_0),
        .instruction_i_1(fetch_inst_1),
        .instruction_i_2(fetch_inst_2),
        .instruction_i_3(fetch_inst_3),
        .instruction_i_4(fetch_inst_4),

        .pc_i_0(fetch_pc_0),
        .pc_i_1(fetch_pc_1),
        .pc_i_2(fetch_pc_2),
        .pc_i_3(fetch_pc_3),
        .pc_i_4(fetch_pc_4),

        .imm_i_0(fetch_imm_0),
        .imm_i_1(fetch_imm_1),
        .imm_i_2(fetch_imm_2),
        .imm_i_3(fetch_imm_3),
        .imm_i_4(fetch_imm_4),

        .branch_prediction_i_0(fetch_branch_pred_0),
        .branch_prediction_i_1(fetch_branch_pred_1),
        .branch_prediction_i_2(fetch_branch_pred_2),
        .branch_prediction_i_3(fetch_branch_pred_3),
        .branch_prediction_i_4(fetch_branch_pred_4),

        .pc_at_prediction_i_0(fetch_pc_value_at_prediction_0),
        .pc_at_prediction_i_1(fetch_pc_value_at_prediction_1),
        .pc_at_prediction_i_2(fetch_pc_value_at_prediction_2),
        .pc_at_prediction_i_3(fetch_pc_value_at_prediction_3),
        .pc_at_prediction_i_4(fetch_pc_value_at_prediction_4),

        .global_history_0_i(global_history_0),
        .global_history_1_i(global_history_1),
        .global_history_2_i(global_history_2),
        .global_history_3_i(global_history_3),
        .global_history_4_i(global_history_4),

        .ras_tos_checkpoint_i(ras_tos_checkpoint),
        // Output to decode stages
        .decode_ready_i(decode_ready_i),
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
        .pc_value_at_prediction_o_0(pc_value_at_prediction_0),
        .pc_value_at_prediction_o_1(pc_value_at_prediction_1),
        .pc_value_at_prediction_o_2(pc_value_at_prediction_2),
        .global_history_0_o(global_history_0_o),
        .global_history_1_o(global_history_1_o),
        .global_history_2_o(global_history_2_o),

        .ras_tos_checkpoint_o(ras_tos_checkpoint_o),

        // Status outputs
        .buffer_empty_o(buffer_empty_o),
        .buffer_full_o(buffer_full_o),
        .occupancy_o(occupancy_o)
    );

endmodule
