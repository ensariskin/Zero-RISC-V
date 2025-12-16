
// -----------------------------------------------------------------------------
// bp_logger_multi.sv
// Single-instance, multi-port (fetch + update) branch predictor logger.
// - Logs all fetch ports (default 5) and update ports (default 3) into ONE CSV.
// - Also produces optional per-PC summary CSV.
// - Simulation-only (file I/O). Keep in TB or guard with `ifdef.
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module bp_logger_multi #(
  parameter int PC_WIDTH   = 32,
  parameter int GH_WIDTH   = 16,
  parameter int META_WIDTH = (GH_WIDTH + 3),
  parameter int NUM_FETCH  = 5,
  parameter int NUM_UPD    = 3
) (
  input  logic                      clk,
  input  logic                      rst_n,

  // =========================
  // FETCH/PREDICT (NUM_FETCH)
  // =========================
  input  logic [NUM_FETCH-1:0]      pred_valid_i,
  input  logic [PC_WIDTH-1:0]       pred_pc_i          [NUM_FETCH],
  input  logic                      pred_taken_final_i [NUM_FETCH],
  input  logic                      pred_taken_gshare_i[NUM_FETCH],
  input  logic                      pred_taken_bimodal_i[NUM_FETCH],
  input  logic                      pred_sel_gshare_i  [NUM_FETCH],
  input  logic [1:0]                pred_chooser_ctr_i [NUM_FETCH],
  input  logic [GH_WIDTH-1:0]       pred_ghr_before_i  [NUM_FETCH],
  input  logic [META_WIDTH-1:0]     pred_meta_i        [NUM_FETCH],

  // =========================
  // UPDATE/RESOLVE (NUM_UPD)
  // =========================
  input  logic [NUM_UPD-1:0]        upd_valid_i,
  input  logic [PC_WIDTH-1:0]       upd_pc_i           [NUM_UPD],
  input  logic [META_WIDTH-1:0]     upd_meta_i         [NUM_UPD],
  input  logic [NUM_UPD-1:0]        upd_mispred_i,
  input  logic [1:0]                upd_redirect_cause_i[NUM_UPD], // 0=branch,1=jalr,2=exc,3=other
  input  logic [NUM_UPD-1:0]        upd_train_gshare_i,
  input  logic [NUM_UPD-1:0]        upd_train_bimodal_i,
  input  logic [NUM_UPD-1:0]        upd_restore_ghr_i,
  input  logic [NUM_UPD-1:0]        upd_actual_taken_i,
  input  logic [NUM_UPD-1:0]        upd_actual_valid_i
);

  // -------------------------
  // Cycle counter
  // -------------------------
  longint unsigned cycle;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) cycle <= 0;
    else        cycle <= cycle + 1;
  end

  // -------------------------
  // File handles
  // -------------------------
  integer fh_log;
  integer fh_sum;
  string  log_name;
  string  sum_name;

  // -------------------------
  // Stats
  // -------------------------
  typedef struct {
    int unsigned pred_gshare;
    int unsigned pred_bimodal;
    int unsigned pred_total;
    int unsigned upd_total;
    int unsigned upd_misp;
    int unsigned train_gshare;
    int unsigned train_bimodal;
    int unsigned restore_ghr;
    int unsigned jalr_redirect;
    int unsigned branch_redirect;
    int unsigned other_redirect;
  } pc_stat_t;

  pc_stat_t stats_by_pc [longint unsigned];

  int unsigned g_pred_gshare, g_pred_bimodal, g_pred_total;
  int unsigned g_upd_total, g_upd_misp, g_train_gshare, g_train_bimodal, g_restore_ghr;
  int unsigned g_jalr_redirect, g_branch_redirect, g_other_redirect;

  function automatic longint unsigned pc_key(input logic [PC_WIDTH-1:0] pc);
    pc_key = longint unsigned'(pc);
  endfunction

  function automatic void bump_stat_pred(input logic [PC_WIDTH-1:0] pc, input logic sel_gshare);
    longint unsigned k;
    k = pc_key(pc);
    if (!stats_by_pc.exists(k)) stats_by_pc[k] = '{default:0};
    stats_by_pc[k].pred_total++;
    if (sel_gshare) stats_by_pc[k].pred_gshare++;
    else            stats_by_pc[k].pred_bimodal++;
  endfunction

  function automatic void bump_stat_upd(
    input logic [PC_WIDTH-1:0] pc,
    input logic misp,
    input logic train_gs,
    input logic train_bi,
    input logic restore,
    input logic [1:0] cause
  );
    longint unsigned k;
    k = pc_key(pc);
    if (!stats_by_pc.exists(k)) stats_by_pc[k] = '{default:0};
    stats_by_pc[k].upd_total++;
    if (misp) stats_by_pc[k].upd_misp++;
    if (train_gs) stats_by_pc[k].train_gshare++;
    if (train_bi) stats_by_pc[k].train_bimodal++;
    if (restore)  stats_by_pc[k].restore_ghr++;
    unique case (cause)
      2'd0: stats_by_pc[k].branch_redirect++;
      2'd1: stats_by_pc[k].jalr_redirect++;
      default: stats_by_pc[k].other_redirect++;
    endcase
  endfunction

  // -------------------------
  // Open files
  // -------------------------
  initial begin
    if (!$value$plusargs("BP_LOG=%s", log_name)) log_name = "bp_log.csv";
    fh_log = $fopen(log_name, "w");
    if (fh_log == 0) begin
      $display("bp_logger_multi: ERROR: cannot open log file '%s'", log_name);
      $finish;
    end

    // CSV header:
    // kind: P=predict, U=update
    // port: fetch index or update index depending on kind
    $fwrite(fh_log,
      "kind,port,cycle,time_ns,pc,sel_gshare,final_pred,gshare_pred,bimodal_pred,chooser_ctr,ghr_before,meta,"
      "misp,redirect_cause,train_gshare,train_bimodal,restore_ghr,actual_valid,actual_taken\n"
    );

    if ($value$plusargs("BP_SUMMARY=%s", sum_name)) begin
      fh_sum = $fopen(sum_name, "w");
      if (fh_sum == 0) begin
        $display("bp_logger_multi: ERROR: cannot open summary file '%s'", sum_name);
        $finish;
      end
      $fwrite(fh_sum,
        "pc_hex,pred_total,pred_gshare,pred_bimodal,upd_total,upd_misp,train_gshare,train_bimodal,restore_ghr,"
        "branch_redirect,jalr_redirect,other_redirect\n"
      );
    end else begin
      fh_sum = 0;
    end
  end

  // -------------------------
  // Predict logging (all fetch ports)
  // -------------------------
  integer i;
  always_ff @(posedge clk) begin
    if (rst_n) begin
      for (i = 0; i < NUM_FETCH; i++) begin
        if (pred_valid_i[i]) begin
          bump_stat_pred(pred_pc_i[i], pred_sel_gshare_i[i]);

          g_pred_total++;
          if (pred_sel_gshare_i[i]) g_pred_gshare++;
          else                      g_pred_bimodal++;

          $fwrite(
            fh_log,
            "P,%0d,%0d,%0t,%0h,%0d,%0d,%0d,%0d,%0d,%0h,%0h,"
            ",,,,,%0d,%0d\n",
            i,
            cycle, $time,
            pred_pc_i[i],
            pred_sel_gshare_i[i],
            pred_taken_final_i[i],
            pred_taken_gshare_i[i],
            pred_taken_bimodal_i[i],
            pred_chooser_ctr_i[i],
            pred_ghr_before_i[i],
            pred_meta_i[i],
            0, 0
          );
        end
      end
    end
  end

  // -------------------------
  // Update logging (all update ports)
  // -------------------------
  integer j;
  always_ff @(posedge clk) begin
    if (rst_n) begin
      for (j = 0; j < NUM_UPD; j++) begin
        if (upd_valid_i[j]) begin
          bump_stat_upd(upd_pc_i[j], upd_mispred_i[j], upd_train_gshare_i[j], upd_train_bimodal_i[j],
                        upd_restore_ghr_i[j], upd_redirect_cause_i[j]);

          g_upd_total++;
          if (upd_mispred_i[j]) g_upd_misp++;
          if (upd_train_gshare_i[j]) g_train_gshare++;
          if (upd_train_bimodal_i[j]) g_train_bimodal++;
          if (upd_restore_ghr_i[j]) g_restore_ghr++;

          unique case (upd_redirect_cause_i[j])
            2'd0: g_branch_redirect++;
            2'd1: g_jalr_redirect++;
            default: g_other_redirect++;
          endcase

          $fwrite(
            fh_log,
            "U,%0d,%0d,%0t,%0h,,,,,,,%0h,"
            "%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
            j,
            cycle, $time,
            upd_pc_i[j],
            upd_meta_i[j],
            upd_mispred_i[j],
            upd_redirect_cause_i[j],
            upd_train_gshare_i[j],
            upd_train_bimodal_i[j],
            upd_restore_ghr_i[j],
            upd_actual_valid_i[j],
            upd_actual_taken_i[j]
          );
        end
      end
    end
  end

  // -------------------------
  // Final summary
  // -------------------------
  final begin
    if (fh_log != 0) begin
      $fwrite(fh_log,
        "# GLOBAL,pred_total=%0d,pred_gshare=%0d,pred_bimodal=%0d,upd_total=%0d,upd_misp=%0d,train_gshare=%0d,train_bimodal=%0d,restore_ghr=%0d,branch_redirect=%0d,jalr_redirect=%0d,other_redirect=%0d\n",
        g_pred_total, g_pred_gshare, g_pred_bimodal,
        g_upd_total, g_upd_misp,
        g_train_gshare, g_train_bimodal,
        g_restore_ghr,
        g_branch_redirect, g_jalr_redirect, g_other_redirect
      );
      $fclose(fh_log);
    end

    if (fh_sum != 0) begin
      foreach (stats_by_pc[k]) begin
        pc_stat_t s;
        s = stats_by_pc[k];
        $fwrite(fh_sum,
          "%0h,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
          k[PC_WIDTH-1:0],
          s.pred_total, s.pred_gshare, s.pred_bimodal,
          s.upd_total, s.upd_misp,
          s.train_gshare, s.train_bimodal,
          s.restore_ghr,
          s.branch_redirect, s.jalr_redirect, s.other_redirect
        );
      end
      $fclose(fh_sum);
    end
  end

endmodule
