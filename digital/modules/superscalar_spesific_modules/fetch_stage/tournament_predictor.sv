`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 24.08.2025
// Design Name: Simple Branch Predictor
// Module Name: branch_predictor_simple
// Project Name: RV32I Superscalar
// Target Devices:
// Tool Versions:
// Description: Simple 2-bit branch predictor with 32 entries
//              No tags, direct-mapped for simplicity
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Optimized for simplicity and small area
//
//////////////////////////////////////////////////////////////////////////////////

module tournament_predictor #(
      parameter ENTRIES = 32,                         // Number of predictor entries
      parameter INDEX_WIDTH = $clog2(ENTRIES),       // Auto-calculated index width
      parameter ADDR_WIDTH = 32
   )(
      input  logic clk,
      input  logic reset,
      input  logic base_valid,

      // Prediction interface (from fetch stage)
      input  logic [ADDR_WIDTH-1:0] current_pc_0,
      input  logic is_branch_i_0,                       // Current instruction is branch

      input  logic [ADDR_WIDTH-1:0] current_pc_1,
      input  logic is_branch_i_1,                       // Current instruction is branch
      input  logic ignore_inst_1,

      input  logic [ADDR_WIDTH-1:0] current_pc_2,
      input  logic is_branch_i_2,                       // Current instruction is branch
      input  logic ignore_inst_2,

      input  logic [ADDR_WIDTH-1:0] current_pc_3,
      input  logic is_branch_i_3,                       // Current instruction is branch
      input  logic ignore_inst_3,

      input  logic [ADDR_WIDTH-1:0] current_pc_4,
      input  logic is_branch_i_4,                       // Current instruction is branch
      input  logic ignore_inst_4,

      // Prediction outputs
      output logic branch_taken_o_0,                    // Branch predicted taken
      output logic branch_taken_o_1,                    // Branch predicted taken
      output logic branch_taken_o_2,                    // Branch predicted taken
      output logic branch_taken_o_3,                    // Branch predicted taken
      output logic branch_taken_o_4,                    // Branch predicted taken

      output logic [INDEX_WIDTH:0] global_history_0_o, // Current global history and prediction
      output logic [INDEX_WIDTH:0] global_history_1_o,
      output logic [INDEX_WIDTH:0] global_history_2_o,
      output logic [INDEX_WIDTH:0] global_history_3_o,
      output logic [INDEX_WIDTH:0] global_history_4_o,

      // Update interface (from execute/writeback stage)
      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_0,
      input  logic update_prediction_valid_i_0,
      input  logic misprediction_0,
      input  logic [INDEX_WIDTH:0] update_global_history_0,

      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_1,
      input  logic update_prediction_valid_i_1,
      input  logic misprediction_1,
      input  logic [INDEX_WIDTH:0] update_global_history_1,

      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_2,
      input  logic update_prediction_valid_i_2,
      input  logic misprediction_2,
      input  logic [INDEX_WIDTH:0] update_global_history_2
   );

   // 2-bit saturating counter states
   localparam [1:0] STRONG_BIMODAL = 2'b00;
   localparam [1:0] WEAK_BIMODAL   = 2'b01;
   localparam [1:0] WEAK_GSHARE       = 2'b10;
   localparam [1:0] STRONG_GSHARE     = 2'b11;

   localparam D = 1; // Delay for simulation purposes

   // Predictor entry structure (simplified - direction only)
   typedef struct packed {
      logic [1:0] counter;                       // 2-bit saturating counter
   } predictor_entry_t;

   // Predictor table
   predictor_entry_t predictor_table [ENTRIES-1:0];

   // Index calculation (gshare: PC XOR Global History)
   logic [INDEX_WIDTH-1:0] predict_index_0, predict_index_1, predict_index_2, predict_index_3, predict_index_4;
   logic [INDEX_WIDTH-1:0] update_index_0, update_index_1, update_index_2;
   logic gshare_branch_taken_0, gshare_branch_taken_1, gshare_branch_taken_2, gshare_branch_taken_3, gshare_branch_taken_4;
   logic bimodal_branch_taken_0, bimodal_branch_taken_1, bimodal_branch_taken_2, bimodal_branch_taken_3, bimodal_branch_taken_4;


   assign predict_index_0 = current_pc_0[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
   assign predict_index_1 = current_pc_1[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
   assign predict_index_2 = current_pc_2[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
   assign predict_index_3 = current_pc_3[INDEX_WIDTH+1:2];
   assign predict_index_4 = current_pc_4[INDEX_WIDTH+1:2];

   assign update_index_0 = update_prediction_pc_0[INDEX_WIDTH+1:2];
   assign update_index_1 = update_prediction_pc_1[INDEX_WIDTH+1:2];
   assign update_index_2 = update_prediction_pc_2[INDEX_WIDTH+1:2];

   assign branch_taken_o_0 = predictor_table[predict_index_0].counter[1] ? gshare_branch_taken_0 : bimodal_branch_taken_0;
   assign branch_taken_o_1 = predictor_table[predict_index_1].counter[1] ? gshare_branch_taken_1 : bimodal_branch_taken_1;
   assign branch_taken_o_2 = predictor_table[predict_index_2].counter[1] ? gshare_branch_taken_2 : bimodal_branch_taken_2;
   assign branch_taken_o_3 = predictor_table[predict_index_3].counter[1] ? gshare_branch_taken_3 : bimodal_branch_taken_3;
   assign branch_taken_o_4 = predictor_table[predict_index_4].counter[1] ? gshare_branch_taken_4 : bimodal_branch_taken_4;

   // Update logic
   always_ff @(posedge clk or negedge reset) begin
      if (!reset) begin
         // Initialize all entries
         for (int i = 0; i < ENTRIES; i++) begin
            predictor_table[i].counter <= #D WEAK_GSHARE;  // Start with weak taken
         end
      end else begin

         if (update_prediction_valid_i_0) begin
            // Update 2-bit saturating counter
            case (predictor_table[update_index_0].counter)
               STRONG_BIMODAL: begin
                  if (misprediction_0)
                     predictor_table[update_index_0].counter <= #D WEAK_BIMODAL;
               end
               WEAK_BIMODAL: begin
                  if (misprediction_0)
                     predictor_table[update_index_0].counter <= #D WEAK_GSHARE;
                  else
                     predictor_table[update_index_0].counter <= #D STRONG_BIMODAL;
               end
               WEAK_GSHARE: begin
                  if (misprediction_0)
                     predictor_table[update_index_0].counter <= #D WEAK_GSHARE; //WEAK_BIMODAL;
                  else
                     predictor_table[update_index_0].counter <= #D STRONG_GSHARE;
               end
               STRONG_GSHARE: begin
                  if (misprediction_0)
                     predictor_table[update_index_0].counter <= #D WEAK_GSHARE;
               end
            endcase
         end
         if (update_prediction_valid_i_1) begin
            // Update 2-bit saturating counter
            case (predictor_table[update_index_1].counter)
               STRONG_BIMODAL: begin
                  if (misprediction_1)
                     predictor_table[update_index_1].counter <= #D WEAK_BIMODAL;
               end
               WEAK_BIMODAL: begin
                  if (misprediction_1)
                     predictor_table[update_index_1].counter <= #D WEAK_GSHARE;
                  else
                     predictor_table[update_index_1].counter <= #D STRONG_BIMODAL;
               end
               WEAK_GSHARE: begin
                  if (misprediction_1)
                     predictor_table[update_index_1].counter <= #D WEAK_BIMODAL;
                  else
                     predictor_table[update_index_1].counter <= #D STRONG_GSHARE;
               end
               STRONG_GSHARE: begin
                  if (misprediction_1)
                     predictor_table[update_index_1].counter <= #D WEAK_GSHARE;
               end
            endcase

         end
         if (update_prediction_valid_i_2) begin
            // Update 2-bit saturating counter
            case (predictor_table[update_index_2].counter)
               STRONG_BIMODAL: begin
                  if (misprediction_2)
                     predictor_table[update_index_2].counter <= #D WEAK_BIMODAL;
               end
               WEAK_BIMODAL: begin
                  if (misprediction_2)
                     predictor_table[update_index_2].counter <= #D WEAK_GSHARE;
                  else
                     predictor_table[update_index_2].counter <= #D STRONG_BIMODAL;
               end
               WEAK_GSHARE: begin
                  if (misprediction_2)
                     predictor_table[update_index_2].counter <= #D WEAK_BIMODAL;
                  else
                     predictor_table[update_index_2].counter <= #D STRONG_GSHARE;
               end
               STRONG_GSHARE: begin
                  if (misprediction_2)
                     predictor_table[update_index_2].counter <= #D WEAK_GSHARE;
               end
            endcase
         end
      end
   end

   gshare_predictor_super #(.ADDR_WIDTH(ADDR_WIDTH),.ENTRIES(ENTRIES)) gshare_predictor_inst (
      .clk(clk),
      .reset(reset),
      .base_valid(base_valid),

      .current_pc_0(current_pc_0),
      .is_branch_i_0(is_branch_i_0),

      .current_pc_1(current_pc_1),
      .is_branch_i_1(is_branch_i_1),
      .ignore_inst_1(ignore_inst_1),

      .current_pc_2(current_pc_2),
      .is_branch_i_2(is_branch_i_2),
      .ignore_inst_2(ignore_inst_2),

      .current_pc_3(current_pc_3),
      .is_branch_i_3(is_branch_i_3),
      .ignore_inst_3(ignore_inst_3),

      .current_pc_4(current_pc_4),
      .is_branch_i_4(is_branch_i_4),
      .ignore_inst_4(ignore_inst_4),

      .branch_taken_o_0(gshare_branch_taken_0),
      .branch_taken_o_1(gshare_branch_taken_1),
      .branch_taken_o_2(gshare_branch_taken_2),
      .branch_taken_o_3(gshare_branch_taken_3),
      .branch_taken_o_4(gshare_branch_taken_4),

      .global_history_0_o,
      .global_history_1_o,
      .global_history_2_o,
      .global_history_3_o,
      .global_history_4_o,

      .update_prediction_pc_0(update_prediction_pc_0),
      .update_prediction_valid_i_0(update_prediction_valid_i_0 & predictor_table[update_index_0].counter[1]),
      .misprediction_0(misprediction_0),
      .update_global_history_0,

      .update_prediction_pc_1(update_prediction_pc_1),
      .update_prediction_valid_i_1(update_prediction_valid_i_1 & predictor_table[update_index_1].counter[1]),
      .misprediction_1(misprediction_1),
      .update_global_history_1,

      .update_prediction_pc_2(update_prediction_pc_2),
      .update_prediction_valid_i_2(update_prediction_valid_i_2 & predictor_table[update_index_2].counter[1]),
      .misprediction_2(misprediction_2),
      .update_global_history_2
   );

   branch_predictor_super #(.ADDR_WIDTH(ADDR_WIDTH),.ENTRIES(ENTRIES)) branch_predictor_super (
      .clk(clk),
      .reset(reset),

      .current_pc_0(current_pc_0),
      .is_branch_i_0(is_branch_i_0),

      .current_pc_1(current_pc_1),
      .is_branch_i_1(is_branch_i_1),

      .current_pc_2(current_pc_2),
      .is_branch_i_2(is_branch_i_2),

      .current_pc_3(current_pc_3),
      .is_branch_i_3(is_branch_i_3),

      .current_pc_4(current_pc_4),
      .is_branch_i_4(is_branch_i_4),

      .branch_taken_o_0(bimodal_branch_taken_0),
      .branch_taken_o_1(bimodal_branch_taken_1),
      .branch_taken_o_2(bimodal_branch_taken_2),
      .branch_taken_o_3(bimodal_branch_taken_3),
      .branch_taken_o_4(bimodal_branch_taken_4),

      .update_prediction_pc_0(update_prediction_pc_0),
      .update_prediction_valid_i_0(update_prediction_valid_i_0 & ~predictor_table[update_index_0].counter[1]),
      .misprediction_0(misprediction_0),

      .update_prediction_pc_1(update_prediction_pc_1),
      .update_prediction_valid_i_1(update_prediction_valid_i_1 & ~predictor_table[update_index_1].counter[1]),
      .misprediction_1(misprediction_1),

      .update_prediction_pc_2(update_prediction_pc_2),
      .update_prediction_valid_i_2(update_prediction_valid_i_2 & ~predictor_table[update_index_2].counter[1]),
      .misprediction_2(misprediction_2)
   );

endmodule
