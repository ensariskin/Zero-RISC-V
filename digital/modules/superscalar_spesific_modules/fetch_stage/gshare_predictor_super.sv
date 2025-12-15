`timescale 1ns/1ns
module gshare_predictor_super #(
        parameter ENTRIES     = 32,
        parameter INDEX_WIDTH = $clog2(ENTRIES),
        parameter ADDR_WIDTH  = 32,
        // Use only GH_LEN bits of GHR for gshare (typical sweet spot for 4K: 8..10)
        parameter integer GH_LEN = 2
    )(
        input  logic clk,
        input  logic reset,          // active-low reset
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

        // Packed history for BRAT: {GHR_before, pred_bit}
        output logic [INDEX_WIDTH:0] global_history_0_o,
        output logic [INDEX_WIDTH:0] global_history_1_o,
        output logic [INDEX_WIDTH:0] global_history_2_o,
        output logic [INDEX_WIDTH:0] global_history_3_o,
        output logic [INDEX_WIDTH:0] global_history_4_o,

        // Update interface (from resolve/execute)
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

    localparam [1:0] STRONG_NOT_TAKEN = 2'b00;
    localparam [1:0] STRONG_TAKEN     = 2'b11;
    localparam D = 1;

    // clamp GH_LEN into [0, INDEX_WIDTH]
    localparam int GH_L = (GH_LEN <= 0) ? 0 :
        (GH_LEN > INDEX_WIDTH) ? INDEX_WIDTH : GH_LEN;

    typedef struct packed {
        logic [1:0] counter;
    } predictor_entry_t;

    predictor_entry_t predictor_table [ENTRIES-1:0];

    // Global history register (INDEX_WIDTH bits)
    logic [INDEX_WIDTH-1:0] global_history_reg;

    // Slot valid-branch qualifiers
    logic slot_branch_0, slot_branch_1, slot_branch_2, slot_branch_3, slot_branch_4;
    assign slot_branch_0 = is_branch_i_0;
    assign slot_branch_1 = is_branch_i_1 & ~ignore_inst_1;
    assign slot_branch_2 = is_branch_i_2 & ~ignore_inst_2;
    assign slot_branch_3 = is_branch_i_3 & ~ignore_inst_3;
    assign slot_branch_4 = is_branch_i_4 & ~ignore_inst_4;

    // Progressive histories: advance ONLY on valid branches
    logic [INDEX_WIDTH-1:0] global_history_0, global_history_1, global_history_2, global_history_3, global_history_4, global_history_5;

    // Indices
    logic [INDEX_WIDTH-1:0] predict_index_0, predict_index_1, predict_index_2, predict_index_3, predict_index_4;
    logic [INDEX_WIDTH-1:0] update_index_0,  update_index_1,  update_index_2;

    // masks (use only GH_L bits of GHR)
    logic [INDEX_WIDTH-1:0] ghm0, ghm1, ghm2, ghm3, ghm4;
    logic [INDEX_WIDTH-1:0] ughm0, ughm1, ughm2;

    generate
        if (GH_L == 0) begin : gen_no_hist
            assign ghm0  = '0;
            assign ghm1  = '0;
            assign ghm2  = '0;
            assign ghm3  = '0;
            assign ghm4  = '0;
            assign ughm0 = '0;
            assign ughm1 = '0;
            assign ughm2 = '0;
        end else begin : gen_hist
            assign ghm0 = {{(INDEX_WIDTH-GH_L){1'b0}}, global_history_0[GH_L-1:0]};
            assign ghm1 = {{(INDEX_WIDTH-GH_L){1'b0}}, global_history_1[GH_L-1:0]};
            assign ghm2 = {{(INDEX_WIDTH-GH_L){1'b0}}, global_history_2[GH_L-1:0]};
            assign ghm3 = {{(INDEX_WIDTH-GH_L){1'b0}}, global_history_3[GH_L-1:0]};
            assign ghm4 = {{(INDEX_WIDTH-GH_L){1'b0}}, global_history_4[GH_L-1:0]};

            // update_global_history_x[INDEX_WIDTH:1] = GHR_before (INDEX_WIDTH bits)
            // take only GH_L bits from that
            assign ughm0 = {{(INDEX_WIDTH-GH_L){1'b0}}, update_global_history_0[GH_L:1]};
            assign ughm1 = {{(INDEX_WIDTH-GH_L){1'b0}}, update_global_history_1[GH_L:1]};
            assign ughm2 = {{(INDEX_WIDTH-GH_L){1'b0}}, update_global_history_2[GH_L:1]};
        end
    endgenerate

    // -------------------------------
    // Prediction path
    // -------------------------------
    assign global_history_0 = global_history_reg;

    // Predictions (only meaningful when slot_branch_* is true)
    assign branch_taken_o_0 = slot_branch_0 ? predictor_table[predict_index_0].counter[1] : 1'b0;
    assign branch_taken_o_1 = slot_branch_1 ? predictor_table[predict_index_1].counter[1] : 1'b0;
    assign branch_taken_o_2 = slot_branch_2 ? predictor_table[predict_index_2].counter[1] : 1'b0;
    assign branch_taken_o_3 = slot_branch_3 ? predictor_table[predict_index_3].counter[1] : 1'b0;
    assign branch_taken_o_4 = slot_branch_4 ? predictor_table[predict_index_4].counter[1] : 1'b0;

    // Per-slot history advance uses predicted bits
    assign global_history_1 = slot_branch_0 ? {global_history_0[INDEX_WIDTH-2:0], branch_taken_o_0} : global_history_0;
    assign global_history_2 = slot_branch_1 ? {global_history_1[INDEX_WIDTH-2:0], branch_taken_o_1} : global_history_1;
    assign global_history_3 = slot_branch_2 ? {global_history_2[INDEX_WIDTH-2:0], branch_taken_o_2} : global_history_2;
    assign global_history_4 = slot_branch_3 ? {global_history_3[INDEX_WIDTH-2:0], branch_taken_o_3} : global_history_3;
    assign global_history_5 = slot_branch_4 ? {global_history_4[INDEX_WIDTH-2:0], branch_taken_o_4} : global_history_4;

    logic [INDEX_WIDTH-1:0] pc_idx0, pc_idx1, pc_idx2, pc_idx3, pc_idx4;
    logic [INDEX_WIDTH-1:0] pc_fold0, pc_fold1, pc_fold2, pc_fold3, pc_fold4;

    // düşük INDEX_WIDTH bit
    assign pc_idx0 = current_pc_0[INDEX_WIDTH+1:2];
    assign pc_idx1 = current_pc_1[INDEX_WIDTH+1:2];
    assign pc_idx2 = current_pc_2[INDEX_WIDTH+1:2];
    assign pc_idx3 = current_pc_3[INDEX_WIDTH+1:2];
    assign pc_idx4 = current_pc_4[INDEX_WIDTH+1:2];

    // bir üst INDEX_WIDTH bit’i de karıştır (ADDR_WIDTH yeterliyse)
    assign pc_fold0 = pc_idx0 ^ current_pc_0[2*INDEX_WIDTH+1:INDEX_WIDTH+2];
    assign pc_fold1 = pc_idx1 ^ current_pc_1[2*INDEX_WIDTH+1:INDEX_WIDTH+2];
    assign pc_fold2 = pc_idx2 ^ current_pc_2[2*INDEX_WIDTH+1:INDEX_WIDTH+2];
    assign pc_fold3 = pc_idx3 ^ current_pc_3[2*INDEX_WIDTH+1:INDEX_WIDTH+2];
    assign pc_fold4 = pc_idx4 ^ current_pc_4[2*INDEX_WIDTH+1:INDEX_WIDTH+2];

    // sonra gshare:
    assign predict_index_0 = pc_fold0 ^ ghm0;
    assign predict_index_1 = pc_fold1 ^ ghm1;
    assign predict_index_2 = pc_fold2 ^ ghm2;
    assign predict_index_3 = pc_fold3 ^ ghm3;
    assign predict_index_4 = pc_fold4 ^ ghm4;

    // First predicted-taken in the group (redirect boundary)
    logic slot_taken_0, slot_taken_1, slot_taken_2, slot_taken_3, slot_taken_4;
    assign slot_taken_0 = slot_branch_0 & branch_taken_o_0;
    assign slot_taken_1 = slot_branch_1 & branch_taken_o_1;
    assign slot_taken_2 = slot_branch_2 & branch_taken_o_2;
    assign slot_taken_3 = slot_branch_3 & branch_taken_o_3;
    assign slot_taken_4 = slot_branch_4 & branch_taken_o_4;

    // Pack {GHR_before, pred_bit} for BRAT
    assign global_history_0_o = {global_history_0, branch_taken_o_0};
    assign global_history_1_o = {global_history_1, branch_taken_o_1};
    assign global_history_2_o = {global_history_2, branch_taken_o_2};
    assign global_history_3_o = {global_history_3, branch_taken_o_3};
    assign global_history_4_o = {global_history_4, branch_taken_o_4};

    // -------------------------------
    // Update path (resolve/execute)
    // update_global_history_x format: {GHR_before, pred_bit}
    // -------------------------------
    assign update_index_0 = update_prediction_pc_0[INDEX_WIDTH+1:2] ^ ughm0;
    assign update_index_1 = update_prediction_pc_1[INDEX_WIDTH+1:2] ^ ughm1;
    assign update_index_2 = update_prediction_pc_2[INDEX_WIDTH+1:2] ^ ughm2;

    // actual_taken reconstruction (pred_bit from BRAT)
    logic pred0, pred1, pred2;
    logic act0,  act1,  act2;

    assign pred0 = update_global_history_0[0];
    assign pred1 = update_global_history_1[0];
    assign pred2 = update_global_history_2[0];

    assign act0  = pred0 ^ misprediction_0;
    assign act1  = pred1 ^ misprediction_1;
    assign act2  = pred2 ^ misprediction_2;

    // ------------------------------------------------------------
    // Mispredict priority select (0 > 1 > 2)
    // NOTE: misprediction_* can be asserted even if update_valid_* is 0 (jalr mispred case).
    // ------------------------------------------------------------
    logic mp0_sel, mp1_sel, mp2_sel, mp_any;
    assign mp0_sel = misprediction_0;
    assign mp1_sel = (~misprediction_0) & misprediction_1;
    assign mp2_sel = (~misprediction_0) & (~misprediction_1) & misprediction_2;
    assign mp_any  = misprediction_0 | misprediction_1 | misprediction_2;

    // -------------------------------
    // Sequential logic
    // -------------------------------
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            for (int i = 0; i < ENTRIES; i++) begin
                predictor_table[i].counter <= #D 2'b01; // WEAK_NOT_TAKEN
            end
            global_history_reg <= #D '0;
        end else begin
            // ------------------------------------------------------------
            // FETCH-side speculative GHR update
            // - If any mispredict in this cycle, DO NOT apply fetch update.
            // ------------------------------------------------------------
            if (base_valid && !mp_any) begin
                if      (slot_taken_0) global_history_reg <= #D global_history_1;
                else if (slot_taken_1) global_history_reg <= #D global_history_2;
                else if (slot_taken_2) global_history_reg <= #D global_history_3;
                else if (slot_taken_3) global_history_reg <= #D global_history_4;
                else if (slot_taken_4) global_history_reg <= #D global_history_5;
                else                   global_history_reg <= #D global_history_5; // hold if no branches
            end

            // ------------------------------------------------------------
            // PHT Training (COMBINE LOGIC)
            // - Fold same-index updates into a single write (order: 0 > 1 > 2)
            // ------------------------------------------------------------

            // group for index_0
            if (update_prediction_valid_i_0) begin
                logic [1:0] c;
                c = predictor_table[update_index_0].counter;

                // apply update 0
                if (act0) begin
                    if (c != STRONG_TAKEN)     c = c + 2'b01;
                end else begin
                    if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                end

                // fold update 1 if same index
                if (update_prediction_valid_i_1 && (update_index_1 == update_index_0)) begin
                    if (act1) begin
                        if (c != STRONG_TAKEN)     c = c + 2'b01;
                    end else begin
                        if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                    end
                end

                // fold update 2 if same index
                if (update_prediction_valid_i_2 && (update_index_2 == update_index_0)) begin
                    if (act2) begin
                        if (c != STRONG_TAKEN)     c = c + 2'b01;
                    end else begin
                        if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                    end
                end

                predictor_table[update_index_0].counter <= #D c;
            end

            // group for index_1 (only if not folded into index_0)
            if (update_prediction_valid_i_1 &&
                    !(update_prediction_valid_i_0 && (update_index_1 == update_index_0))) begin
                logic [1:0] c;
                c = predictor_table[update_index_1].counter;

                // apply update 1
                if (act1) begin
                    if (c != STRONG_TAKEN)     c = c + 2'b01;
                end else begin
                    if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                end

                // fold update 2 if same index as 1
                if (update_prediction_valid_i_2 && (update_index_2 == update_index_1)) begin
                    if (act2) begin
                        if (c != STRONG_TAKEN)     c = c + 2'b01;
                    end else begin
                        if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                    end
                end

                predictor_table[update_index_1].counter <= #D c;
            end

            // group for index_2 (only if not folded into 0 or 1)
            if (update_prediction_valid_i_2 &&
                    !(update_prediction_valid_i_0 && (update_index_2 == update_index_0)) &&
                    !(update_prediction_valid_i_1 && (update_index_2 == update_index_1))) begin
                logic [1:0] c;
                c = predictor_table[update_index_2].counter;

                // apply update 2
                if (act2) begin
                    if (c != STRONG_TAKEN)     c = c + 2'b01;
                end else begin
                    if (c != STRONG_NOT_TAKEN) c = c - 2'b01;
                end

                predictor_table[update_index_2].counter <= #D c;
            end

            // ------------------------------------------------------------
            // GHR Restore (mispredict wins over everything)
            // Priority: mispred0 > mispred1 > mispred2
            //
            // Two cases per slot k:
            //  - if update_valid_k == 1 : branch mispred => restore {GHR_before[INDEX_WIDTH-1:1], actual_taken}
            //  - if update_valid_k == 0 : jalr/external redirect => restore GHR_before EXACTLY (no append)
            // ------------------------------------------------------------
            if (mp0_sel) begin
                if (update_prediction_valid_i_0)
                    global_history_reg <= #D {update_global_history_0[INDEX_WIDTH-1:1], act0};
                else
                    global_history_reg <= #D  update_global_history_0[INDEX_WIDTH:1];
            end
            else if (mp1_sel) begin
                if (update_prediction_valid_i_1)
                    global_history_reg <= #D {update_global_history_1[INDEX_WIDTH-1:1], act1};
                else
                    global_history_reg <= #D  update_global_history_1[INDEX_WIDTH:1];
            end
            else if (mp2_sel) begin
                if (update_prediction_valid_i_2)
                    global_history_reg <= #D {update_global_history_2[INDEX_WIDTH-1:1], act2};
                else
                    global_history_reg <= #D  update_global_history_2[INDEX_WIDTH:1];
            end
        end
    end


    integer fd;
    longint unsigned cyc;

    // Basic counters
    longint unsigned pred_br_cnt;
    longint unsigned pred_ok_cnt;

    // GH pattern buckets (max GH_LEN up to 8 here for simplicity; you can raise)
    localparam int GH_MAX = 8;

    longint unsigned gh_cnt   [0:(1<<GH_MAX)-1];
    longint unsigned gh_ok    [0:(1<<GH_MAX)-1];

    // Combine collisions counters (same index in same cycle among updates)
    longint unsigned upd_same_idx_01;
    longint unsigned upd_same_idx_02;
    longint unsigned upd_same_idx_12;
    longint unsigned upd_same_idx_012;

    // Counter histogram at predict
    longint unsigned ctr_hist[0:3];

    // helper: get GH bucket index (lower GH_L bits)
    function automatic int gh_bucket(input logic [INDEX_WIDTH-1:0] ghr);
        if (GH_L == 0) gh_bucket = 0;
        else           gh_bucket = ghr[GH_L-1:0];
    endfunction

    // open file
    initial begin
        pred_br_cnt = 0;
        pred_ok_cnt = 0;
        upd_same_idx_01 = 0;
        upd_same_idx_02 = 0;
        upd_same_idx_12 = 0;
        upd_same_idx_012 = 0;

        for (int i=0;i<(1<<GH_MAX);i++) begin
            gh_cnt[i] = 0;
            gh_ok[i]  = 0;
        end
        for (int i=0;i<4;i++) ctr_hist[i] = 0;

        fd = $fopen("bp_trace.csv", "w");
        $fwrite(fd,
            "cycle,kind,slot_or_port,pc,gh_before,pred_bit,act_taken,mispred,idx,ctr_before,ctr_after,packed_gh\n");
    end

    // cycle counter
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) cyc <= 0;
        else        cyc <= cyc + 1;
    end

    // -------- PREDICT TRACE (slots 0..4) --------
    task automatic log_predict(
            input int slot,
            input logic slot_is_branch,
            input logic [ADDR_WIDTH-1:0] pc,
            input logic [INDEX_WIDTH-1:0] ghr_before,
            input logic pred_bit,
            input logic [INDEX_WIDTH-1:0] idx
        );
        int b;
        logic [1:0] ctr;
        begin
            if (slot_is_branch) begin
                ctr = predictor_table[idx].counter;
                b   = gh_bucket(ghr_before);

                // histograms
                pred_br_cnt++;
                gh_cnt[b]++;
                ctr_hist[ctr]++;

                // we don't know correctness here yet (needs update), but still log snapshot
                $fwrite(fd, "%0d,PRED,%0d,%0h,%0h,%0d,,,%0h,%0d,,%0h\n",
                    cyc, slot, pc, ghr_before, pred_bit, idx, ctr, {ghr_before,pred_bit});
            end
        end
    endtask

    always_comb begin
        // nothing
    end

    always_ff @(posedge clk) begin
        // log predict only when base_valid so slots are meaningful for this fetch group
        if (reset && base_valid) begin
            log_predict(0, slot_branch_0, current_pc_0, global_history_0, branch_taken_o_0, predict_index_0);
            log_predict(1, slot_branch_1, current_pc_1, global_history_1, branch_taken_o_1, predict_index_1);
            log_predict(2, slot_branch_2, current_pc_2, global_history_2, branch_taken_o_2, predict_index_2);
            log_predict(3, slot_branch_3, current_pc_3, global_history_3, branch_taken_o_3, predict_index_3);
            log_predict(4, slot_branch_4, current_pc_4, global_history_4, branch_taken_o_4, predict_index_4);
        end
    end

    // -------- UPDATE TRACE (ports 0..2) --------
    task automatic log_update(
            input int port,
            input logic upd_valid,
            input logic [ADDR_WIDTH-1:0] pc,
            input logic mispred,
            input logic [INDEX_WIDTH:0] upd_gh,
            input logic [INDEX_WIDTH-1:0] idx
        );
        int b;
        logic pred_bit;
        logic act;
        logic [INDEX_WIDTH-1:0] ghr_before;
        logic [1:0] ctr_before;
        logic [1:0] ctr_after_exp;
        begin
            if (upd_valid) begin
                pred_bit   = upd_gh[0];
                ghr_before = upd_gh[INDEX_WIDTH:1];
                act        = pred_bit ^ mispred;
                b          = gh_bucket(ghr_before);
                ctr_before = predictor_table[idx].counter;

                // expected after (purely for logging)
                ctr_after_exp = ctr_before;
                if (act) begin
                    if (ctr_after_exp != STRONG_TAKEN) ctr_after_exp = ctr_after_exp + 2'b01;
                end else begin
                    if (ctr_after_exp != STRONG_NOT_TAKEN) ctr_after_exp = ctr_after_exp - 2'b01;
                end

                // correctness accounting: mispred==0 => correct
                if (!mispred) begin
                    pred_ok_cnt++;
                    gh_ok[b]++;
                end

                $fwrite(fd, "%0d,UPD,%0d,%0h,%0h,%0d,%0d,%0d,%0h,%0d,%0d,%0h\n",
                    cyc, port, pc, ghr_before, pred_bit, act, mispred, idx, ctr_before, ctr_after_exp, upd_gh);
            end
        end
    endtask

    always_ff @(posedge clk) begin
        if (reset) begin
            // combine collision stats (pure info)
            if (update_prediction_valid_i_0 && update_prediction_valid_i_1 && (update_index_0 == update_index_1))
                upd_same_idx_01++;
            if (update_prediction_valid_i_0 && update_prediction_valid_i_2 && (update_index_0 == update_index_2))
                upd_same_idx_02++;
            if (update_prediction_valid_i_1 && update_prediction_valid_i_2 && (update_index_1 == update_index_2))
                upd_same_idx_12++;
            if (update_prediction_valid_i_0 && update_prediction_valid_i_1 && update_prediction_valid_i_2 &&
                    (update_index_0 == update_index_1) && (update_index_0 == update_index_2))
                upd_same_idx_012++;

            log_update(0, update_prediction_valid_i_0, update_prediction_pc_0, misprediction_0, update_global_history_0, update_index_0);
            log_update(1, update_prediction_valid_i_1, update_prediction_pc_1, misprediction_1, update_global_history_1, update_index_1);
            log_update(2, update_prediction_valid_i_2, update_prediction_pc_2, misprediction_2, update_global_history_2, update_index_2);
        end
    end

    // -------- SUMMARY at end --------
    final begin
        real acc;
        acc = (pred_br_cnt != 0) ? (100.0 * pred_ok_cnt / pred_br_cnt) : 0.0;
        $display("BP SUMMARY: total=%0d correct=%0d acc=%0.2f%%", pred_br_cnt, pred_ok_cnt, acc);
        $display("Combine collisions: 01=%0d 02=%0d 12=%0d 012=%0d",
            upd_same_idx_01, upd_same_idx_02, upd_same_idx_12, upd_same_idx_012);
        $display("Ctr hist: 00=%0d 01=%0d 10=%0d 11=%0d",
            ctr_hist[0], ctr_hist[1], ctr_hist[2], ctr_hist[3]);

        // GH bucket summary for small GH_LEN (esp GH_LEN=2)
        if (GH_L <= 6) begin
            for (int i=0; i<(1<<GH_L); i++) begin
                real a;
                a = (gh_cnt[i] != 0) ? (100.0*gh_ok[i]/gh_cnt[i]) : 0.0;
                $display("GH[%0d]=%0d cnt=%0d ok=%0d acc=%0.2f%%", i, i, gh_cnt[i], gh_ok[i], a);
            end
        end
        $fclose(fd);
    end



endmodule
