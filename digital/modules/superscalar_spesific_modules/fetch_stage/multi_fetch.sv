`timescale 1ns/1ns

module multi_fetch #(
      parameter size = 32,
      parameter ENTRIES = 32,                        // Number of predictor entries
      parameter INDEX_WIDTH = $clog2(ENTRIES)       // Auto-calculated index width
   )(
      input  logic clk,
      input  logic reset,

      output logic [size-1 : 0] inst_addr_0,
      input  logic [size-1 : 0] instruction_i_0,

      output logic [size-1 : 0] inst_addr_1,
      input  logic [size-1 : 0] instruction_i_1,

      output logic [size-1 : 0] inst_addr_2,
      input  logic [size-1 : 0] instruction_i_2,

      output logic [size-1 : 0] inst_addr_3,
      input  logic [size-1 : 0] instruction_i_3,

      output logic [size-1 : 0] inst_addr_4,
      input  logic [size-1 : 0] instruction_i_4,

      // Pipeline control signals
      input  logic buble,

      //==========================================================================
      // BRAT Interface (Simplified - all branch/JALR info comes from BRAT in-order)
      //==========================================================================
      // 1. Misprediction signals (for PC redirect - eager flush)
      input  logic misprediction_i_0,
      input  logic misprediction_i_1,
      input  logic misprediction_i_2,

      // 2. Update valid signals (for predictor update - resolved OR mispredicted)
      input  logic update_valid_i_0,
      input  logic update_valid_i_1,
      input  logic update_valid_i_2,

      // 3. Is JALR flags (0=branch, 1=JALR - determines which predictor to update)
      input  logic is_jalr_i_0,
      input  logic is_jalr_i_1,
      input  logic is_jalr_i_2,

      // 4. PC at prediction (for predictor table lookup during update)
      input  logic [size-1 : 0] pc_at_prediction_i_0,
      input  logic [size-1 : 0] pc_at_prediction_i_1,
      input  logic [size-1 : 0] pc_at_prediction_i_2,

      // 5. Correct PC (for misprediction redirect and predictor update)
      input  logic [size-1 : 0] correct_pc_i_0,
      input  logic [size-1 : 0] correct_pc_i_1,
      input  logic [size-1 : 0] correct_pc_i_2,

      input  logic [INDEX_WIDTH+2:0] update_global_history_0,
      input  logic [INDEX_WIDTH+2:0] update_global_history_1,
      input  logic [INDEX_WIDTH+2:0] update_global_history_2,

      // New interface for instruction buffer integration
      output logic [4:0] fetch_valid_o,        // Which of the 3 instructions are valid
      input  logic fetch_ready_i,              // Instruction buffer can accept instructions
      output logic [size-1 : 0] pc_o_0, pc_o_1, pc_o_2, pc_o_3, pc_o_4,  // PC values for each instruction

      // Legacy pipeline outputs (will be removed when buffer is integrated)
      output logic [size-1 : 0] instruction_o_0,
      output logic [size-1 : 0] imm_o_0,
      output logic [size-1 : 0] pc_value_at_prediction_0, // PC value used for prediction
      output logic branch_prediction_o_0,
      output logic [INDEX_WIDTH+2:0] global_history_0_o, // Current global history and prediction

      output logic [size-1 : 0] instruction_o_1,
      output logic [size-1 : 0] imm_o_1,
      output logic [size-1 : 0] pc_value_at_prediction_1, // PC value used for prediction
      output logic branch_prediction_o_1,
      output logic [INDEX_WIDTH+2:0] global_history_1_o,

      output logic [size-1 : 0] instruction_o_2,
      output logic [size-1 : 0] imm_o_2,
      output logic [size-1 : 0] pc_value_at_prediction_2, // PC value used for prediction
      output logic branch_prediction_o_2,
      output logic [INDEX_WIDTH+2:0] global_history_2_o,

      output logic [size-1 : 0] instruction_o_3,
      output logic [size-1 : 0] imm_o_3,
      output logic [size-1 : 0] pc_value_at_prediction_3, // PC value used for prediction
      output logic branch_prediction_o_3,
      output logic [INDEX_WIDTH+2:0] global_history_3_o,

      output logic [size-1 : 0] instruction_o_4,
      output logic [size-1 : 0] imm_o_4,
      output logic [size-1 : 0] pc_value_at_prediction_4, // PC value used for prediction
      output logic branch_prediction_o_4,
      output logic [INDEX_WIDTH+2:0] global_history_4_o,


      // RAS checkpoint/restore interface
      output logic [2:0] ras_tos_checkpoint_o, // RAS TOS pointers at fetch time for each instruction
      input  logic ras_restore_en_i,
      input  logic [2:0] ras_restore_tos_i

   );

   //localparam D = 1; // Delay for simulation purposes

   // Add parallel_mode control signal for pc_ctrl_super
   logic parallel_mode;
   assign parallel_mode = 1'b1; // Always enable 3-instruction parallel mode

   //==========================================================================
   // Misprediction handling: flush on any misprediction from BRAT (in-order)
   // Priority: slot 0 > slot 1 > slot 2 (oldest first from BRAT)
   //==========================================================================
   logic eager_flush;
   logic [size-1:0] eager_flush_target_pc;

   always_comb begin
      if (misprediction_i_0) begin
         eager_flush = 1'b1;
         eager_flush_target_pc = correct_pc_i_0;
      end else if (misprediction_i_1) begin
         eager_flush = 1'b1;
         eager_flush_target_pc = correct_pc_i_1;
      end else if (misprediction_i_2) begin
         eager_flush = 1'b1;
         eager_flush_target_pc = correct_pc_i_2;
      end else begin
         eager_flush = 1'b0;
         eager_flush_target_pc = {size{1'b0}};
      end
   end

   //==========================================================================
   // Predictor update signal derivation from BRAT interface
   // Branch predictor: update when update_valid & !is_jalr
   // JALR predictor: update when update_valid & is_jalr
   //==========================================================================
   logic branch_update_valid_0, branch_update_valid_1, branch_update_valid_2;
   logic jalr_update_valid_0, jalr_update_valid_1, jalr_update_valid_2;

   assign branch_update_valid_0 = update_valid_i_0 & ~is_jalr_i_0;
   assign branch_update_valid_1 = update_valid_i_1 & ~is_jalr_i_1 & !misprediction_i_0;
   assign branch_update_valid_2 = update_valid_i_2 & ~is_jalr_i_2 & !misprediction_i_0 & !misprediction_i_1;

   assign jalr_update_valid_0 = update_valid_i_0 & is_jalr_i_0;
   assign jalr_update_valid_1 = update_valid_i_1 & is_jalr_i_1 & !misprediction_i_0;
   assign jalr_update_valid_2 = update_valid_i_2 & is_jalr_i_2 & !misprediction_i_0 & !misprediction_i_1;

   // For now inst addr 1 is inst addr 0 + 4
   // inst addr 2 is inst addr 1 + 4

   // Internal signals
   logic [size-1 : 0] current_pc_0;
   logic jump_0;
   logic [size-1 : 0] imm_0;
   logic jalr_0;

   logic [size-1 : 0] current_pc_1;
   logic jump_1;
   logic [size-1 : 0] imm_1;
   logic jalr_1;

   logic [size-1 : 0] current_pc_2;
   logic jump_2;
   logic [size-1 : 0] imm_2;
   logic jalr_2;

   logic [size-1 : 0] current_pc_3;
   logic jump_3;
   logic [size-1 : 0] imm_3;
   logic jalr_3;

   logic [size-1 : 0] current_pc_4;
   logic jump_4;
   logic [size-1 : 0] imm_4;
   logic jalr_4;

   logic jalr_prediction_valid;
   logic [size-1:0] jalr_predicition_target;

   // New buffer interface signals
   logic internal_bubble; // Combine bubble with buffer backpressure


   // Smart fetch valid signals based on branch prediction
   // If a branch is predicted taken, don't fetch instructions after it
   logic base_valid;
   logic block_0;  // Invalidate inst_1 and inst_2 if inst_0 branches
   logic block_1;    // Invalidate inst_2 if inst_1 branches
   logic block_2;
   logic block_3;

   // Base validity: instruction is valid if not flushed, buffer ready, and in reset
   assign base_valid = ~eager_flush & fetch_ready_i & reset;

   // Branch prediction invalidation logic
   assign block_0 = jump_0 | jalr_0;  // If inst_0 is predicted taken, invalidate inst_1 and inst_2
   assign block_1 = jump_1 | jalr_1;    // If inst_1 is predicted taken, invalidate inst_2
   assign block_2 = jump_2 | jalr_2;
   assign block_3 = jump_3 | jalr_3;

   // Final fetch valid signals
   assign fetch_valid_o[0] = base_valid;                                    // inst_0 always valid (if base conditions met)
   assign fetch_valid_o[1] = base_valid & ~block_0;                 // inst_1 invalid if inst_0 branches
   assign fetch_valid_o[2] = base_valid & ~block_0 & ~block_1; // inst_2 invalid if inst_0 or inst_1 branches
   assign fetch_valid_o[3] = base_valid & ~block_0 & ~block_1 & ~block_2; // inst_3 invalid if inst_0, inst_1, or inst_2 branches
   assign fetch_valid_o[4] = base_valid & ~block_0 & ~block_1 & ~block_2 & ~block_3; // inst_4 invalid if any prior instruction branches

   // Combine pipeline bubble with buffer backpressure
   assign internal_bubble = buble | ~fetch_ready_i;
   // Immediate decoders
   early_stage_immediate_decoder  early_stage_imm_dec_0(
      .instruction(instruction_i_0),
      .imm_o(imm_0));

   early_stage_immediate_decoder  early_stage_imm_dec_1(
      .instruction(instruction_i_1),
      .imm_o(imm_1));

   early_stage_immediate_decoder  early_stage_imm_dec_2(
      .instruction(instruction_i_2),
      .imm_o(imm_2));

   early_stage_immediate_decoder  early_stage_imm_dec_3(
      .instruction(instruction_i_3),
      .imm_o(imm_3));

   early_stage_immediate_decoder  early_stage_imm_dec_4(
      .instruction(instruction_i_4),
      .imm_o(imm_4));

   // Jump controller
   jump_controller_super #(.size(size), .ENTRIES(ENTRIES)) jump_ctrl(
      .clk(clk),
      .reset(reset),

      .base_valid_i(base_valid),

      .current_pc_0(current_pc_0),
      .current_pc_1(current_pc_1),
      .current_pc_2(current_pc_2),
      .current_pc_3(current_pc_3),
      .current_pc_4(current_pc_4),

      .instruction_0(instruction_i_0),
      .instruction_1(instruction_i_1),
      .instruction_2(instruction_i_2),
      .instruction_3(instruction_i_3),
      .instruction_4(instruction_i_4),

      //==========================================================================
      // Branch predictor update (from BRAT - when update_valid & !is_jalr)
      //==========================================================================
      .update_prediction_pc_0(pc_at_prediction_i_0),
      .update_prediction_pc_1(pc_at_prediction_i_1),
      .update_prediction_pc_2(pc_at_prediction_i_2),

      .update_prediction_valid_i_0(branch_update_valid_0),
      .update_prediction_valid_i_1(branch_update_valid_1),
      .update_prediction_valid_i_2(branch_update_valid_2),

      // Misprediction signals for branch predictor
      .misprediction_0(misprediction_i_0),
      .misprediction_1(misprediction_i_1),
      .misprediction_2(misprediction_i_2),

      .correct_pc_0(correct_pc_i_0),
      .correct_pc_1(correct_pc_i_1),
      .correct_pc_2(correct_pc_i_2),

      .update_global_history_0,
      .update_global_history_1,
      .update_global_history_2,

      //==========================================================================
      // JALR predictor update (from BRAT - when update_valid & is_jalr)
      //=========================================================================
      .jalr_update_valid_0(jalr_update_valid_0),
      .jalr_update_prediction_pc_0(pc_at_prediction_i_0),

      .jalr_update_valid_1(jalr_update_valid_1),
      .jalr_update_prediction_pc_1(pc_at_prediction_i_1),

      .jalr_update_valid_2(jalr_update_valid_2),
      .jalr_update_prediction_pc_2(pc_at_prediction_i_2),

      .jump_0(jump_0),
      .jump_1(jump_1),
      .jump_2(jump_2),
      .jump_3(jump_3),
      .jump_4(jump_4),

      .jalr_0(jalr_0),
      .jalr_1(jalr_1),
      .jalr_2(jalr_2),
      .jalr_3(jalr_3),
      .jalr_4(jalr_4),

      .global_history_0_o,
      .global_history_1_o,
      .global_history_2_o,
      .global_history_3_o,
      .global_history_4_o,

      .jalr_prediction_valid(jalr_prediction_valid),
      .jalr_prediction_target(jalr_predicition_target),

      .ras_restore_en_i(ras_restore_en_i),
      .ras_restore_tos_i(ras_restore_tos_i),
      .ras_tos_checkpoint_o(ras_tos_checkpoint_o)

   );

   // PC Control Super Module
   pc_ctrl_super #(.size(size)) PC_super (
      .clk(clk),
      .reset(reset),
      .buble(internal_bubble),  // Use combined bubble signal
      .parallel_mode(parallel_mode),

      .jump_0(jump_0),
      .jump_1(jump_1),
      .jump_2(jump_2),
      .jump_3(jump_3),
      .jump_4(jump_4),

      .jalr_0(jalr_0),
      .jalr_1(jalr_1),
      .jalr_2(jalr_2),
      .jalr_3(jalr_3),
      .jalr_4(jalr_4),

      .jalr_prediction_valid(jalr_prediction_valid),
      .jalr_prediction_target(jalr_predicition_target),

      .imm_i_0(imm_0),
      .imm_i_1(imm_1),
      .imm_i_2(imm_2),
      .imm_i_3(imm_3),
      .imm_i_4(imm_4),

      .misprediction(eager_flush),
      .correct_pc(eager_flush_target_pc),

      .inst_addr_0(inst_addr_0),
      .inst_addr_1(inst_addr_1),
      .inst_addr_2(inst_addr_2),
      .inst_addr_3(inst_addr_3),
      .inst_addr_4(inst_addr_4),

      .current_pc_0(current_pc_0),
      .current_pc_1(current_pc_1),
      .current_pc_2(current_pc_2),
      .current_pc_3(current_pc_3),
      .current_pc_4(current_pc_4),

      .pc_save_0(pc_o_0),
      .pc_save_1(pc_o_1),
      .pc_save_2(pc_o_2),
      .pc_save_3(pc_o_3),
      .pc_save_4(pc_o_4)
   );

   assign instruction_o_0 =  instruction_i_0;
   assign instruction_o_1 =  instruction_i_1;
   assign instruction_o_2 =  instruction_i_2;
   assign instruction_o_3 =  instruction_i_3;
   assign instruction_o_4 =  instruction_i_4;

   assign imm_o_0 = imm_0;
   assign imm_o_1 = imm_1;
   assign imm_o_2 = imm_2;
   assign imm_o_3 = imm_3;
   assign imm_o_4 = imm_4;

   assign pc_value_at_prediction_0 = jalr_0 & jalr_prediction_valid ? jalr_predicition_target : current_pc_0;
   assign pc_value_at_prediction_1 = jalr_1 & jalr_prediction_valid ? jalr_predicition_target : current_pc_1;
   assign pc_value_at_prediction_2 = jalr_2 & jalr_prediction_valid ? jalr_predicition_target : current_pc_2;
   assign pc_value_at_prediction_3 = jalr_3 & jalr_prediction_valid ? jalr_predicition_target : current_pc_3;
   assign pc_value_at_prediction_4 = jalr_4 & jalr_prediction_valid ? jalr_predicition_target : current_pc_4;

   assign branch_prediction_o_0 = jump_0 | jalr_0;
   assign branch_prediction_o_1 = jump_1 | jalr_1;
   assign branch_prediction_o_2 = jump_2 | jalr_2;
   assign branch_prediction_o_3 = jump_3 | jalr_3;
   assign branch_prediction_o_4 = jump_4 | jalr_4;
   //assign pc_plus_o = pc_save;

endmodule