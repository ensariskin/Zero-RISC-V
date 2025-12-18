`timescale 1ns/1ns
// ------------------------------------------------------------
// Tournament predictor (GShare + Bimodal) with a 2-bit chooser
//
// Predict: run both predictors in parallel; chooser selects.
// Train:
//   - Both direction predictors get trained (for best accuracy)
//   - Chooser trained ONLY when predictors disagree, toward the
//     predictor that matched the actual outcome
//
// Integration requirement:
//   global_history_*_o and update_global_history_* are widened.
//   You must store/return them per-branch in your BRAT/ROB.
//
// Layout of global_history bus (MSB..LSB):
//   [INDEX_WIDTH+2:3] = GHR_before   (INDEX_WIDTH bits, from gshare)
//   [2]               = gshare_pred
//   [1]               = bimodal_pred
//   [0]               = chooser_sel  (1 => gshare, 0 => bimodal)
// ------------------------------------------------------------
module tournament_predictor #(
      parameter ENTRIES     = 32,
      parameter INDEX_WIDTH = $clog2(ENTRIES),
      parameter ADDR_WIDTH  = 32
   )(
      input  logic clk,
      input  logic reset,
      input  logic base_valid,

      // Prediction interface (fetch group)
      input  logic [ADDR_WIDTH-1:0] current_pc_0,
      input  logic is_branch_i_0,

      input  logic [ADDR_WIDTH-1:0] current_pc_1,
      input  logic is_branch_i_1,
      input  logic ignore_inst_1,

      input  logic [ADDR_WIDTH-1:0] current_pc_2,
      input  logic is_branch_i_2,
      input  logic ignore_inst_2,

      input  logic [ADDR_WIDTH-1:0] current_pc_3,
      input  logic is_branch_i_3,
      input  logic ignore_inst_3,

      input  logic [ADDR_WIDTH-1:0] current_pc_4,
      input  logic is_branch_i_4,
      input  logic ignore_inst_4,

      // Prediction outputs
      output logic branch_taken_o_0,
      output logic branch_taken_o_1,
      output logic branch_taken_o_2,
      output logic branch_taken_o_3,
      output logic branch_taken_o_4,

      output logic [INDEX_WIDTH+2:0] global_history_0_o,
      output logic [INDEX_WIDTH+2:0] global_history_1_o,
      output logic [INDEX_WIDTH+2:0] global_history_2_o,
      output logic [INDEX_WIDTH+2:0] global_history_3_o,
      output logic [INDEX_WIDTH+2:0] global_history_4_o,

      // Update interface (resolve/retire)
      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_0,
      input  logic update_prediction_valid_i_0,
      input  logic misprediction_0, // relative to FINAL tournament prediction
      input  logic [INDEX_WIDTH+2:0] update_global_history_0,

      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_1,
      input  logic update_prediction_valid_i_1,
      input  logic misprediction_1,
      input  logic [INDEX_WIDTH+2:0] update_global_history_1,

      input  logic [ADDR_WIDTH-1:0] update_prediction_pc_2,
      input  logic update_prediction_valid_i_2,
      input  logic misprediction_2,
      input  logic [INDEX_WIDTH+2:0] update_global_history_2
   );

   localparam D = 1;

   // ------------------------------------------------------------
   // Chooser table: 2-bit saturating
   //   00/01 => prefer bimodal
   //   10/11 => prefer gshare
   // ------------------------------------------------------------
   typedef enum logic [1:0] {
      STRONG_BIMODAL = 2'b00,
      WEAK_BIMODAL   = 2'b01,
      WEAK_GSHARE    = 2'b10,
      STRONG_GSHARE  = 2'b11
   } chooser_state_e;

   typedef struct packed { chooser_state_e counter; } chooser_entry_t;
   chooser_entry_t chooser_table [ENTRIES-1:0];

   function automatic chooser_state_e sat_inc(input chooser_state_e s);
      case (s)
         STRONG_BIMODAL: sat_inc = WEAK_BIMODAL;
         WEAK_BIMODAL:   sat_inc = WEAK_GSHARE;
         WEAK_GSHARE:    sat_inc = STRONG_GSHARE;
         default:        sat_inc = STRONG_GSHARE;
      endcase
   endfunction

   function automatic chooser_state_e sat_dec(input chooser_state_e s);
      case (s)
         STRONG_GSHARE: sat_dec = WEAK_GSHARE;
         WEAK_GSHARE:   sat_dec = WEAK_BIMODAL;
         WEAK_BIMODAL:  sat_dec = STRONG_BIMODAL;
         default:       sat_dec = STRONG_BIMODAL;
      endcase
   endfunction

   // Indices (chooser indexed by PC[INDEX_WIDTH+1:2])
   logic [INDEX_WIDTH-1:0] predict_index_0, predict_index_1, predict_index_2, predict_index_3, predict_index_4;
   logic [INDEX_WIDTH-1:0] update_index_0,  update_index_1,  update_index_2;

   assign predict_index_0 = current_pc_0[INDEX_WIDTH+1:2];
   assign predict_index_1 = current_pc_1[INDEX_WIDTH+1:2];
   assign predict_index_2 = current_pc_2[INDEX_WIDTH+1:2];
   assign predict_index_3 = current_pc_3[INDEX_WIDTH+1:2];
   assign predict_index_4 = current_pc_4[INDEX_WIDTH+1:2];

   assign update_index_0  = update_prediction_pc_0[INDEX_WIDTH+1:2];
   assign update_index_1  = update_prediction_pc_1[INDEX_WIDTH+1:2];
   assign update_index_2  = update_prediction_pc_2[INDEX_WIDTH+1:2];

   // ------------------------------------------------------------
   // Run BOTH predictors in parallel (predict side)
   // ------------------------------------------------------------
   logic gshare_branch_taken_0, gshare_branch_taken_1, gshare_branch_taken_2, gshare_branch_taken_3, gshare_branch_taken_4;
   logic bimodal_branch_taken_0, bimodal_branch_taken_1, bimodal_branch_taken_2, bimodal_branch_taken_3, bimodal_branch_taken_4;

   // gshare's packed history {GHR_before, gshare_pred} (old width)
   logic [INDEX_WIDTH:0] gshare_hist_0, gshare_hist_1, gshare_hist_2, gshare_hist_3, gshare_hist_4;

   // Mask ignored slots for bimodal so it matches gshare’s slot_branch qualifiers
   logic is_branch_m1, is_branch_m2, is_branch_m3, is_branch_m4;
   assign is_branch_m1 = is_branch_i_1 & ~ignore_inst_1;
   assign is_branch_m2 = is_branch_i_2 & ~ignore_inst_2;
   assign is_branch_m3 = is_branch_i_3 & ~ignore_inst_3;
   assign is_branch_m4 = is_branch_i_4 & ~ignore_inst_4;

   // ------------------------------------------------------------
   // Update-side meta extraction (needed BEFORE we instantiate, for wiring)
   // ------------------------------------------------------------
   logic [INDEX_WIDTH-1:0] ughr0, ughr1, ughr2;
   logic ugp0, ugp1, ugp2; // gshare pred @fetch
   logic ubp0, ubp1, ubp2; // bimodal pred @fetch
   logic usel0, usel1, usel2;

   assign ughr0  = update_global_history_0[INDEX_WIDTH+2:3];
   assign ugp0   = update_global_history_0[2];
   assign ubp0   = update_global_history_0[1];
   assign usel0  = update_global_history_0[0];

   assign ughr1  = update_global_history_1[INDEX_WIDTH+2:3];
   assign ugp1   = update_global_history_1[2];
   assign ubp1   = update_global_history_1[1];
   assign usel1  = update_global_history_1[0];

   assign ughr2  = update_global_history_2[INDEX_WIDTH+2:3];
   assign ugp2   = update_global_history_2[2];
   assign ubp2   = update_global_history_2[1];
   assign usel2  = update_global_history_2[0];

   // final pred at fetch (reconstruct) and actual outcome
   logic upred0, upred1, upred2;
   logic uact0,  uact1,  uact2;

   assign upred0 = usel0 ? ugp0 : ubp0;
   assign upred1 = usel1 ? ugp1 : ubp1;
   assign upred2 = usel2 ? ugp2 : ubp2;

   assign uact0  = upred0 ^ misprediction_0;
   assign uact1  = upred1 ^ misprediction_1;
   assign uact2  = upred2 ^ misprediction_2;

   // component mispredicts (relative to each predictor's own prediction)

   // ------------------------------------------------------------
   // Per-slot update decode
   // update_prediction_valid_i_k == 1 : this slot is a *conditional branch*
   // update_prediction_valid_i_k == 0 : external redirect (e.g., JALR), but misprediction_k may still pulse
   // ------------------------------------------------------------
   logic is_br_u0, is_br_u1, is_br_u2;
   assign is_br_u0 = update_prediction_valid_i_0;
   assign is_br_u1 = update_prediction_valid_i_1;
   assign is_br_u2 = update_prediction_valid_i_2;

   // Final predicted direction (the one the frontend actually used at fetch)
   logic uf0, uf1, uf2;   // final_pred
   logic ua0, ua1, ua2;   // actual (for conditional branches only)
   assign uf0 = usel0 ? ugp0 : ubp0;
   assign uf1 = usel1 ? ugp1 : ubp1;
   assign uf2 = usel2 ? ugp2 : ubp2;

   assign ua0 = uf0 ^ misprediction_0;
   assign ua1 = uf1 ^ misprediction_1;
   assign ua2 = uf2 ^ misprediction_2;

   // ------------------------------------------------------------
   // Mispred signals into sub-predictors
   //
   // Important nuance:
   //  - gshare_predictor_super uses (pred_bit ^ mispred) to reconstruct ACTUAL
   //  - We MUST sometimes force a GHR restore even when gshare was NOT the cause
   //    of the frontend mispredict (e.g. chooser picked bimodal, got it wrong).
   //
   // Strategy:
   //  - Normal branch case: mispred_g = (gshare_pred != actual)
   //  - External redirect (JALR): mispred_g = 1, update_valid=0 => restore GHR_before exactly
   //  - Chooser-caused flush where gshare_pred == actual (gshare was right but not chosen):
   //        force mispred_g = 1, BUT flip pred_bit we pass into gshare_upd_hist
   //        so that (pred_bit ^ 1) still equals 'actual'.
   // ------------------------------------------------------------
   logic mispred_g0, mispred_g1, mispred_g2;
   logic mispred_b0, mispred_b1, mispred_b2;

   logic gforce0, gforce1, gforce2;
   logic gneed0,  gneed1,  gneed2;
   logic gpredbit0, gpredbit1, gpredbit2;

   // chooser-caused flush + gshare actually correct (so we still must restore GHR)
   assign gforce0 = is_br_u0 && misprediction_0 && !usel0 && (ugp0 == ua0);
   assign gforce1 = is_br_u1 && misprediction_1 && !usel1 && (ugp1 == ua1);
   assign gforce2 = is_br_u2 && misprediction_2 && !usel2 && (ugp2 == ua2);

   // need a gshare restore when:
   //   - conditional branch and (gshare disagrees with actual) OR (forced restore case)
   //   - OR external redirect (update_valid=0 but misprediction=1)
   assign gneed0 = (is_br_u0 && ((ugp0 != ua0) || gforce0)) || (!is_br_u0 && misprediction_0);
   assign gneed1 = (is_br_u1 && ((ugp1 != ua1) || gforce1)) || (!is_br_u1 && misprediction_1);
   assign gneed2 = (is_br_u2 && ((ugp2 != ua2) || gforce2)) || (!is_br_u2 && misprediction_2);

   // pred_bit to feed gshare's update_global_history:
   //   - normally: gshare_pred
   //   - forced restore: ~actual so that (~actual ^ 1) == actual
   assign gpredbit0 = gforce0 ? ~ua0 : ugp0;
   assign gpredbit1 = gforce1 ? ~ua1 : ugp1;
   assign gpredbit2 = gforce2 ? ~ua2 : ugp2;

   assign mispred_g0 = gneed0;
   assign mispred_g1 = gneed1;
   assign mispred_g2 = gneed2;

   // bimodal mispred is always relative to bimodal_pred (ok)
   assign mispred_b0 = ubp0 ^ ua0;
   assign mispred_b1 = ubp1 ^ ua1;
   assign mispred_b2 = ubp2 ^ ua2;

   // Feed gshare update ports (old-width history {GHR_before, pred_bit_for_act})
   wire [INDEX_WIDTH:0] gshare_upd_hist0 = {ughr0, gpredbit0};
   wire [INDEX_WIDTH:0] gshare_upd_hist1 = {ughr1, gpredbit1};
   wire [INDEX_WIDTH:0] gshare_upd_hist2 = {ughr2, gpredbit2};

   // Train gshare PHT only if gshare was actually selected for that slot
   logic gtrain0, gtrain1, gtrain2;
   assign gtrain0 = is_br_u0 && usel0;
   assign gtrain1 = is_br_u1 && usel1;
   assign gtrain2 = is_br_u2 && usel2;

   // ------------------------------------------------------------
   // Predictor instances
   // ------------------------------------------------------------
   gshare_predictor_super #(
      .ADDR_WIDTH(ADDR_WIDTH),
      .ENTRIES(ENTRIES)
   ) gshare_predictor_inst (
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

      .global_history_0_o(gshare_hist_0),
      .global_history_1_o(gshare_hist_1),
      .global_history_2_o(gshare_hist_2),
      .global_history_3_o(gshare_hist_3),
      .global_history_4_o(gshare_hist_4),

      .update_prediction_pc_0(update_prediction_pc_0),
      .update_prediction_valid_i_0(update_prediction_valid_i_0),
      .update_train_en_i_0(gtrain0),
      .misprediction_0(mispred_g0),
      .update_global_history_0(gshare_upd_hist0),

      .update_prediction_pc_1(update_prediction_pc_1),
      .update_prediction_valid_i_1(update_prediction_valid_i_1),
      .update_train_en_i_1(gtrain1),
      .misprediction_1(mispred_g1),
      .update_global_history_1(gshare_upd_hist1),

      .update_prediction_pc_2(update_prediction_pc_2),
      .update_prediction_valid_i_2(update_prediction_valid_i_2),
      .update_train_en_i_2(gtrain2),
      .misprediction_2(mispred_g2),
      .update_global_history_2(gshare_upd_hist2)
   );

   branch_predictor_super #(
      .ADDR_WIDTH(ADDR_WIDTH),
      .ENTRIES(ENTRIES)
   ) bimodal_predictor_inst (
      .clk(clk),
      .reset(reset),

      .current_pc_0(current_pc_0),
      .is_branch_i_0(is_branch_i_0),

      .current_pc_1(current_pc_1),
      .is_branch_i_1(is_branch_m1),

      .current_pc_2(current_pc_2),
      .is_branch_i_2(is_branch_m2),

      .current_pc_3(current_pc_3),
      .is_branch_i_3(is_branch_m3),

      .current_pc_4(current_pc_4),
      .is_branch_i_4(is_branch_m4),

      .branch_taken_o_0(bimodal_branch_taken_0),
      .branch_taken_o_1(bimodal_branch_taken_1),
      .branch_taken_o_2(bimodal_branch_taken_2),
      .branch_taken_o_3(bimodal_branch_taken_3),
      .branch_taken_o_4(bimodal_branch_taken_4),

      .update_prediction_pc_0(update_prediction_pc_0),
      .update_prediction_valid_i_0(update_prediction_valid_i_0),
      .misprediction_0(mispred_b0),

      .update_prediction_pc_1(update_prediction_pc_1),
      .update_prediction_valid_i_1(update_prediction_valid_i_1),
      .misprediction_1(mispred_b1),

      .update_prediction_pc_2(update_prediction_pc_2),
      .update_prediction_valid_i_2(update_prediction_valid_i_2),
      .misprediction_2(mispred_b2)
   );

   // ------------------------------------------------------------
   // Chooser select (MSB of chooser counter)
   // ------------------------------------------------------------
   logic sel0, sel1, sel2, sel3, sel4;
   assign sel0 = chooser_table[predict_index_0].counter[1];
   assign sel1 = chooser_table[predict_index_1].counter[1];
   assign sel2 = chooser_table[predict_index_2].counter[1];
   assign sel3 = chooser_table[predict_index_3].counter[1];
   assign sel4 = chooser_table[predict_index_4].counter[1];

   // Final prediction (mask ignored slots)
   always_comb begin
      branch_taken_o_0 = is_branch_i_0 ? (sel0 ? gshare_branch_taken_0  : bimodal_branch_taken_0) : 1'b0;
      branch_taken_o_1 = (is_branch_i_1 & ~ignore_inst_1) ? (sel1 ? gshare_branch_taken_1 : bimodal_branch_taken_1) : 1'b0;
      branch_taken_o_2 = (is_branch_i_2 & ~ignore_inst_2) ? (sel2 ? gshare_branch_taken_2 : bimodal_branch_taken_2) : 1'b0;
      branch_taken_o_3 = (is_branch_i_3 & ~ignore_inst_3) ? (sel3 ? gshare_branch_taken_3 : bimodal_branch_taken_3) : 1'b0;
      branch_taken_o_4 = (is_branch_i_4 & ~ignore_inst_4) ? (sel4 ? gshare_branch_taken_4 : bimodal_branch_taken_4) : 1'b0;
   end

   // Export meta-history to BRAT/ROB (wider)
   // Use gshare_hist_* for GHR_before so update path can reconstruct gshare index exactly.
   assign global_history_0_o = { gshare_hist_0[INDEX_WIDTH:1], gshare_hist_0[0], bimodal_branch_taken_0, sel0 };
   assign global_history_1_o = { gshare_hist_1[INDEX_WIDTH:1], gshare_hist_1[0], bimodal_branch_taken_1, sel1 };
   assign global_history_2_o = { gshare_hist_2[INDEX_WIDTH:1], gshare_hist_2[0], bimodal_branch_taken_2, sel2 };
   assign global_history_3_o = { gshare_hist_3[INDEX_WIDTH:1], gshare_hist_3[0], bimodal_branch_taken_3, sel3 };
   assign global_history_4_o = { gshare_hist_4[INDEX_WIDTH:1], gshare_hist_4[0], bimodal_branch_taken_4, sel4 };

   // ------------------------------------------------------------
   // Chooser training (resolve/retire)
   // - Only when predictors disagree
   // - Move toward predictor that matched actual outcome
   // ------------------------------------------------------------
   always_ff @(posedge clk or negedge reset) begin
      if (!reset) begin
         for (int i=0; i<ENTRIES; i++) begin
            chooser_table[i].counter <= #D WEAK_BIMODAL;
         end
      end else begin
         if (update_prediction_valid_i_0) begin
            if (ugp0 != ubp0) begin
               if (ugp0 == uact0) chooser_table[update_index_0].counter <= #D sat_inc(chooser_table[update_index_0].counter);
               else               chooser_table[update_index_0].counter <= #D sat_dec(chooser_table[update_index_0].counter);
            end
         end
         if (update_prediction_valid_i_1) begin
            if (ugp1 != ubp1) begin
               if (ugp1 == uact1) chooser_table[update_index_1].counter <= #D sat_inc(chooser_table[update_index_1].counter);
               else               chooser_table[update_index_1].counter <= #D sat_dec(chooser_table[update_index_1].counter);
            end
         end
         if (update_prediction_valid_i_2) begin
            if (ugp2 != ubp2) begin
               if (ugp2 == uact2) chooser_table[update_index_2].counter <= #D sat_inc(chooser_table[update_index_2].counter);
               else               chooser_table[update_index_2].counter <= #D sat_dec(chooser_table[update_index_2].counter);
            end
         end
      end
   end

endmodule
