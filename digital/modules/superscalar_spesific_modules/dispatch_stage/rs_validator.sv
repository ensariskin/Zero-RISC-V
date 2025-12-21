`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: rs_validator
//
// Description:
//     RS Validator uses tmr_voter modules to validate:
//     1. All exec output signals from 3 RS units
//     2. All internal registers from 3 RS units
//
//     Secure mode OFF: Passthrough (each RS exec_out = exec_in)
//     Secure mode ON:  All 3 RS exec_out = voted values
//////////////////////////////////////////////////////////////////////////////////

module rs_validator #(
      parameter DATA_WIDTH = 32,
      parameter PHYS_REG_ADDR_WIDTH = 6
   )(
      input  logic secure_mode,

      //==========================================================================
      // EXEC INTERFACES FROM 3 RS (passthrough input side)
      //==========================================================================
      rs_to_exec_if.functional_unit exec_in_0,
      rs_to_exec_if.functional_unit exec_in_1,
      rs_to_exec_if.functional_unit exec_in_2,

      //==========================================================================
      // EXEC INTERFACES TO EXECUTE STAGE (3 outputs)
      //==========================================================================
      rs_to_exec_if.reservation_station exec_out_0,
      rs_to_exec_if.reservation_station exec_out_1,
      rs_to_exec_if.reservation_station exec_out_2,

      //==========================================================================
      // INTERNAL REGISTER INTERFACES FROM 3 RS (using rs_internal_if)
      //==========================================================================
      rs_internal_if.validator rs_0_internal,
      rs_internal_if.validator rs_1_internal,
      rs_internal_if.validator rs_2_internal,

      //==========================================================================
      // ERROR FLAGS
      //==========================================================================
      output logic exec_mismatch_o,
      output logic exec_fatal_o,
      output logic internal_mismatch_o,
      output logic internal_fatal_o
   );

   //==========================================================================
   // VOTED EXEC SIGNALS (internal wires)
   //==========================================================================
   logic        voted_issue_valid;
   logic [DATA_WIDTH-1:0] voted_data_a;
   logic [DATA_WIDTH-1:0] voted_data_b;
   logic [10:0] voted_exec_ctrl;
   logic [PHYS_REG_ADDR_WIDTH-1:0] voted_exec_rd;
   logic [DATA_WIDTH-1:0] voted_exec_pc;
   logic [DATA_WIDTH-1:0] voted_exec_pc_pred;
   logic [2:0]  voted_exec_branch_sel;
   logic        voted_exec_branch_pred;
   logic [DATA_WIDTH-1:0] voted_exec_store_data;

   // Voted internal register values (shared to all 3 RS)
   logic        voted_enable;
   logic        voted_occupied;
   logic [10:0] voted_control_signals;
   logic [DATA_WIDTH-1:0] voted_pc;
   logic [PHYS_REG_ADDR_WIDTH-1:0] voted_rd_phys_addr;
   logic [DATA_WIDTH-1:0] voted_pc_value_at_prediction;
   logic [2:0]  voted_branch_sel;
   logic        voted_branch_prediction;
   logic [DATA_WIDTH-1:0] voted_store_data;
   logic [DATA_WIDTH-1:0] voted_operand_a_data;
   logic [2:0]  voted_operand_a_tag;
   logic [DATA_WIDTH-1:0] voted_operand_b_data;
   logic [2:0]  voted_operand_b_tag;

   // Mismatch flags for exec signals
   logic iv_mm, iv_fatal, da_mm, da_fatal, db_mm, db_fatal;
   logic ctrl_mm, ctrl_fatal, rd_mm, rd_fatal, pc_mm, pc_fatal;
   logic pc_pred_mm, pc_pred_fatal, bs_mm, bs_fatal, bp_mm, bp_fatal, sd_mm, sd_fatal;

   // Mismatch flags for internal registers
   logic en_mm, en_fatal;
   logic occ_mm, occ_fatal, ctrl_int_mm, ctrl_int_fatal, pc_int_mm, pc_int_fatal;
   logic rd_int_mm, rd_int_fatal, pc_pred_int_mm, pc_pred_int_fatal;
   logic bs_int_mm, bs_int_fatal, bp_int_mm, bp_int_fatal, sd_int_mm, sd_int_fatal;
   logic oa_data_mm, oa_data_fatal, oa_tag_mm, oa_tag_fatal;
   logic ob_data_mm, ob_data_fatal, ob_tag_mm, ob_tag_fatal;

   //==========================================================================
   // TMR VOTERS FOR EXEC SIGNALS
   //==========================================================================

   tmr_voter #(.DATA_WIDTH(1)) issue_valid_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.issue_valid), .data_1_i(exec_in_1.issue_valid), .data_2_i(exec_in_2.issue_valid),
      .data_o(voted_issue_valid), .mismatch_detected_o(iv_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(iv_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) data_a_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.data_a), .data_1_i(exec_in_1.data_a), .data_2_i(exec_in_2.data_a),
      .data_o(voted_data_a), .mismatch_detected_o(da_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(da_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) data_b_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.data_b), .data_1_i(exec_in_1.data_b), .data_2_i(exec_in_2.data_b),
      .data_o(voted_data_b), .mismatch_detected_o(db_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(db_fatal)
   );

   tmr_voter #(.DATA_WIDTH(11)) ctrl_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.control_signals), .data_1_i(exec_in_1.control_signals), .data_2_i(exec_in_2.control_signals),
      .data_o(voted_exec_ctrl), .mismatch_detected_o(ctrl_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(ctrl_fatal)
   );

   tmr_voter #(.DATA_WIDTH(PHYS_REG_ADDR_WIDTH)) rd_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.rd_phys_addr), .data_1_i(exec_in_1.rd_phys_addr), .data_2_i(exec_in_2.rd_phys_addr),
      .data_o(voted_exec_rd), .mismatch_detected_o(rd_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(rd_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.pc), .data_1_i(exec_in_1.pc), .data_2_i(exec_in_2.pc),
      .data_o(voted_exec_pc), .mismatch_detected_o(pc_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_pred_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.pc_value_at_prediction), .data_1_i(exec_in_1.pc_value_at_prediction), .data_2_i(exec_in_2.pc_value_at_prediction),
      .data_o(voted_exec_pc_pred), .mismatch_detected_o(pc_pred_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_pred_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) branch_sel_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.branch_sel), .data_1_i(exec_in_1.branch_sel), .data_2_i(exec_in_2.branch_sel),
      .data_o(voted_exec_branch_sel), .mismatch_detected_o(bs_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(bs_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) branch_pred_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.branch_prediction), .data_1_i(exec_in_1.branch_prediction), .data_2_i(exec_in_2.branch_prediction),
      .data_o(voted_exec_branch_pred), .mismatch_detected_o(bp_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(bp_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) store_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.store_data), .data_1_i(exec_in_1.store_data), .data_2_i(exec_in_2.store_data),
      .data_o(voted_exec_store_data), .mismatch_detected_o(sd_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(sd_fatal)
   );

   //==========================================================================
   // TMR VOTERS FOR INTERNAL REGISTERS (using interface signals)
   //==========================================================================

   tmr_voter #(.DATA_WIDTH(1)) enable_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.enable), .data_1_i(rs_1_internal.enable), .data_2_i(rs_2_internal.enable),
      .data_o(voted_enable), .mismatch_detected_o(en_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(en_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) occupied_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.occupied), .data_1_i(rs_1_internal.occupied), .data_2_i(rs_2_internal.occupied),
      .data_o(voted_occupied), .mismatch_detected_o(occ_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(occ_fatal)
   );

   tmr_voter #(.DATA_WIDTH(11)) ctrl_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.control_signals), .data_1_i(rs_1_internal.control_signals), .data_2_i(rs_2_internal.control_signals),
      .data_o(voted_control_signals), .mismatch_detected_o(ctrl_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(ctrl_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.pc), .data_1_i(rs_1_internal.pc), .data_2_i(rs_2_internal.pc),
      .data_o(voted_pc), .mismatch_detected_o(pc_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(PHYS_REG_ADDR_WIDTH)) rd_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.rd_phys_addr), .data_1_i(rs_1_internal.rd_phys_addr), .data_2_i(rs_2_internal.rd_phys_addr),
      .data_o(voted_rd_phys_addr), .mismatch_detected_o(rd_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(rd_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_pred_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.pc_value_at_prediction), .data_1_i(rs_1_internal.pc_value_at_prediction), .data_2_i(rs_2_internal.pc_value_at_prediction),
      .data_o(voted_pc_value_at_prediction), .mismatch_detected_o(pc_pred_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_pred_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) bs_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.branch_sel), .data_1_i(rs_1_internal.branch_sel), .data_2_i(rs_2_internal.branch_sel),
      .data_o(voted_branch_sel), .mismatch_detected_o(bs_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(bs_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) bp_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.branch_prediction), .data_1_i(rs_1_internal.branch_prediction), .data_2_i(rs_2_internal.branch_prediction),
      .data_o(voted_branch_prediction), .mismatch_detected_o(bp_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(bp_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) sd_int_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.store_data), .data_1_i(rs_1_internal.store_data), .data_2_i(rs_2_internal.store_data),
      .data_o(voted_store_data), .mismatch_detected_o(sd_int_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(sd_int_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) oa_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_a_data), .data_1_i(rs_1_internal.operand_a_data), .data_2_i(rs_2_internal.operand_a_data),
      .data_o(voted_operand_a_data), .mismatch_detected_o(oa_data_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(oa_data_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) oa_tag_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_a_tag), .data_1_i(rs_1_internal.operand_a_tag), .data_2_i(rs_2_internal.operand_a_tag),
      .data_o(voted_operand_a_tag), .mismatch_detected_o(oa_tag_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(oa_tag_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) ob_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_b_data), .data_1_i(rs_1_internal.operand_b_data), .data_2_i(rs_2_internal.operand_b_data),
      .data_o(voted_operand_b_data), .mismatch_detected_o(ob_data_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(ob_data_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) ob_tag_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_b_tag), .data_1_i(rs_1_internal.operand_b_tag), .data_2_i(rs_2_internal.operand_b_tag),
      .data_o(voted_operand_b_tag), .mismatch_detected_o(ob_tag_mm), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(ob_tag_fatal)
   );

   //==========================================================================
   // VALIDATED OUTPUTS BACK TO RS (via interface)
   //==========================================================================
   // All 3 RS get the same validated values

   // RS 0
   assign rs_0_internal.validated_enable = voted_enable;
   assign rs_0_internal.validated_occupied = voted_occupied;
   assign rs_0_internal.validated_control_signals = voted_control_signals;
   assign rs_0_internal.validated_pc = voted_pc;
   assign rs_0_internal.validated_rd_phys_addr = voted_rd_phys_addr;
   assign rs_0_internal.validated_pc_value_at_prediction = voted_pc_value_at_prediction;
   assign rs_0_internal.validated_branch_sel = voted_branch_sel;
   assign rs_0_internal.validated_branch_prediction = voted_branch_prediction;
   assign rs_0_internal.validated_store_data = voted_store_data;
   assign rs_0_internal.validated_operand_a_data = voted_operand_a_data;
   assign rs_0_internal.validated_operand_a_tag = voted_operand_a_tag;
   assign rs_0_internal.validated_operand_b_data = voted_operand_b_data;
   assign rs_0_internal.validated_operand_b_tag = voted_operand_b_tag;

   // RS 1
   assign rs_1_internal.validated_enable = voted_enable;
   assign rs_1_internal.validated_occupied = voted_occupied;
   assign rs_1_internal.validated_control_signals = voted_control_signals;
   assign rs_1_internal.validated_pc = voted_pc;
   assign rs_1_internal.validated_rd_phys_addr = voted_rd_phys_addr;
   assign rs_1_internal.validated_pc_value_at_prediction = voted_pc_value_at_prediction;
   assign rs_1_internal.validated_branch_sel = voted_branch_sel;
   assign rs_1_internal.validated_branch_prediction = voted_branch_prediction;
   assign rs_1_internal.validated_store_data = voted_store_data;
   assign rs_1_internal.validated_operand_a_data = voted_operand_a_data;
   assign rs_1_internal.validated_operand_a_tag = voted_operand_a_tag;
   assign rs_1_internal.validated_operand_b_data = voted_operand_b_data;
   assign rs_1_internal.validated_operand_b_tag = voted_operand_b_tag;

   // RS 2
   assign rs_2_internal.validated_enable = voted_enable;
   assign rs_2_internal.validated_occupied = voted_occupied;
   assign rs_2_internal.validated_control_signals = voted_control_signals;
   assign rs_2_internal.validated_pc = voted_pc;
   assign rs_2_internal.validated_rd_phys_addr = voted_rd_phys_addr;
   assign rs_2_internal.validated_pc_value_at_prediction = voted_pc_value_at_prediction;
   assign rs_2_internal.validated_branch_sel = voted_branch_sel;
   assign rs_2_internal.validated_branch_prediction = voted_branch_prediction;
   assign rs_2_internal.validated_store_data = voted_store_data;
   assign rs_2_internal.validated_operand_a_data = voted_operand_a_data;
   assign rs_2_internal.validated_operand_a_tag = voted_operand_a_tag;
   assign rs_2_internal.validated_operand_b_data = voted_operand_b_data;
   assign rs_2_internal.validated_operand_b_tag = voted_operand_b_tag;

   //==========================================================================
   // EXEC OUTPUT ROUTING (secure_mode: all voted, normal: passthrough)
   //==========================================================================

   // Output 0
   assign exec_out_0.issue_valid     = secure_mode ? voted_issue_valid      : exec_in_0.issue_valid;
   assign exec_out_0.data_a          = secure_mode ? voted_data_a           : exec_in_0.data_a;
   assign exec_out_0.data_b          = secure_mode ? voted_data_b           : exec_in_0.data_b;
   assign exec_out_0.control_signals = secure_mode ? voted_exec_ctrl        : exec_in_0.control_signals;
   assign exec_out_0.rd_phys_addr    = secure_mode ? voted_exec_rd          : exec_in_0.rd_phys_addr;
   assign exec_out_0.pc              = secure_mode ? voted_exec_pc          : exec_in_0.pc;
   assign exec_out_0.pc_value_at_prediction = secure_mode ? voted_exec_pc_pred : exec_in_0.pc_value_at_prediction;
   assign exec_out_0.branch_sel      = secure_mode ? voted_exec_branch_sel  : exec_in_0.branch_sel;
   assign exec_out_0.branch_prediction = secure_mode ? voted_exec_branch_pred : exec_in_0.branch_prediction;
   assign exec_out_0.store_data      = secure_mode ? voted_exec_store_data  : exec_in_0.store_data;

   // Output 1
   assign exec_out_1.issue_valid     = secure_mode ? voted_issue_valid      : exec_in_1.issue_valid;
   assign exec_out_1.data_a          = secure_mode ? voted_data_a           : exec_in_1.data_a;
   assign exec_out_1.data_b          = secure_mode ? voted_data_b           : exec_in_1.data_b;
   assign exec_out_1.control_signals = secure_mode ? voted_exec_ctrl        : exec_in_1.control_signals;
   assign exec_out_1.rd_phys_addr    = secure_mode ? voted_exec_rd          : exec_in_1.rd_phys_addr;
   assign exec_out_1.pc              = secure_mode ? voted_exec_pc          : exec_in_1.pc;
   assign exec_out_1.pc_value_at_prediction = secure_mode ? voted_exec_pc_pred : exec_in_1.pc_value_at_prediction;
   assign exec_out_1.branch_sel      = secure_mode ? voted_exec_branch_sel  : exec_in_1.branch_sel;
   assign exec_out_1.branch_prediction = secure_mode ? voted_exec_branch_pred : exec_in_1.branch_prediction;
   assign exec_out_1.store_data      = secure_mode ? voted_exec_store_data  : exec_in_1.store_data;

   // Output 2
   assign exec_out_2.issue_valid     = secure_mode ? voted_issue_valid      : exec_in_2.issue_valid;
   assign exec_out_2.data_a          = secure_mode ? voted_data_a           : exec_in_2.data_a;
   assign exec_out_2.data_b          = secure_mode ? voted_data_b           : exec_in_2.data_b;
   assign exec_out_2.control_signals = secure_mode ? voted_exec_ctrl        : exec_in_2.control_signals;
   assign exec_out_2.rd_phys_addr    = secure_mode ? voted_exec_rd          : exec_in_2.rd_phys_addr;
   assign exec_out_2.pc              = secure_mode ? voted_exec_pc          : exec_in_2.pc;
   assign exec_out_2.pc_value_at_prediction = secure_mode ? voted_exec_pc_pred : exec_in_2.pc_value_at_prediction;
   assign exec_out_2.branch_sel      = secure_mode ? voted_exec_branch_sel  : exec_in_2.branch_sel;
   assign exec_out_2.branch_prediction = secure_mode ? voted_exec_branch_pred : exec_in_2.branch_prediction;
   assign exec_out_2.store_data      = secure_mode ? voted_exec_store_data  : exec_in_2.store_data;

   // Route issue_ready back to inputs (from exec stage)
   assign exec_in_0.issue_ready = exec_out_0.issue_ready;
   assign exec_in_1.issue_ready = exec_out_1.issue_ready;
   assign exec_in_2.issue_ready = exec_out_2.issue_ready;

   // Route results back from exec stage to RS (passthrough always)
   assign exec_in_0.data_result = exec_out_0.data_result;
   assign exec_in_1.data_result = exec_out_1.data_result;
   assign exec_in_2.data_result = exec_out_2.data_result;

   assign exec_in_0.mem_addr_calculation = exec_out_0.mem_addr_calculation;
   assign exec_in_1.mem_addr_calculation = exec_out_1.mem_addr_calculation;
   assign exec_in_2.mem_addr_calculation = exec_out_2.mem_addr_calculation;

   assign exec_in_0.misprediction = exec_out_0.misprediction;
   assign exec_in_1.misprediction = exec_out_1.misprediction;
   assign exec_in_2.misprediction = exec_out_2.misprediction;

   assign exec_in_0.is_branch = exec_out_0.is_branch;
   assign exec_in_1.is_branch = exec_out_1.is_branch;
   assign exec_in_2.is_branch = exec_out_2.is_branch;

   assign exec_in_0.correct_pc = exec_out_0.correct_pc;
   assign exec_in_1.correct_pc = exec_out_1.correct_pc;
   assign exec_in_2.correct_pc = exec_out_2.correct_pc;

   //==========================================================================
   // COMBINED ERROR FLAGS
   //==========================================================================
   assign exec_mismatch_o = iv_mm | da_mm | db_mm | ctrl_mm | rd_mm | pc_mm | pc_pred_mm | bs_mm | bp_mm | sd_mm;
   assign exec_fatal_o = iv_fatal | da_fatal | db_fatal | ctrl_fatal | rd_fatal | pc_fatal | pc_pred_fatal | bs_fatal | bp_fatal | sd_fatal;

   assign internal_mismatch_o = occ_mm | ctrl_int_mm | pc_int_mm | rd_int_mm | pc_pred_int_mm |
      bs_int_mm | bp_int_mm | sd_int_mm | oa_data_mm | oa_tag_mm | ob_data_mm | ob_tag_mm;
   assign internal_fatal_o = occ_fatal | ctrl_int_fatal | pc_int_fatal | rd_int_fatal | pc_pred_int_fatal |
      bs_int_fatal | bp_int_fatal | sd_int_fatal | oa_data_fatal | oa_tag_fatal | ob_data_fatal | ob_tag_fatal;

endmodule
