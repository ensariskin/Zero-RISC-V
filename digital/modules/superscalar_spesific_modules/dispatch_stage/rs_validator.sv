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
   logic issue_valid_mismatch, issue_valid_fatal;
   logic data_a_mismatch, data_a_fatal;
   logic data_b_mismatch, data_b_fatal;
   logic control_signals_mismatch, control_signals_fatal;
   logic rd_phys_addr_mismatch, rd_phys_addr_fatal;
   logic pc_mismatch, pc_fatal;
   logic pc_value_at_prediction_mismatch, pc_value_at_prediction_fatal;
   logic branch_sel_mismatch, branch_sel_fatal;
   logic branch_prediction_mismatch, branch_prediction_fatal;
   logic store_data_mismatch, store_data_fatal;

   // Mismatch flags for internal registers
   logic enable_mismatch, enable_fatal;
   logic occupied_mismatch, occupied_fatal;
   logic stored_control_signals_mismatch, stored_control_signals_fatal;
   logic stored_pc_mismatch, stored_pc_fatal;
   logic stored_rd_phys_addr_mismatch, stored_rd_phys_addr_fatal;
   logic stored_pc_value_at_prediction_mismatch, stored_pc_value_at_prediction_fatal;
   logic stored_branch_sel_mismatch, stored_branch_sel_fatal;
   logic stored_branch_prediction_mismatch, stored_branch_prediction_fatal;
   logic stored_store_data_mismatch, stored_store_data_fatal;
   logic operand_a_data_mismatch, operand_a_data_fatal;
   logic operand_a_tag_mismatch, operand_a_tag_fatal;
   logic operand_b_data_mismatch, operand_b_data_fatal;
   logic operand_b_tag_mismatch, operand_b_tag_fatal;

   //==========================================================================
   // TMR VOTERS FOR EXEC SIGNALS
   //==========================================================================

   tmr_voter #(.DATA_WIDTH(1)) issue_valid_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.issue_valid), .data_1_i(exec_in_1.issue_valid), .data_2_i(exec_in_2.issue_valid),
      .data_o(voted_issue_valid), .mismatch_detected_o(issue_valid_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(issue_valid_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) data_a_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.data_a), .data_1_i(exec_in_1.data_a), .data_2_i(exec_in_2.data_a),
      .data_o(voted_data_a), .mismatch_detected_o(data_a_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(data_a_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) data_b_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.data_b), .data_1_i(exec_in_1.data_b), .data_2_i(exec_in_2.data_b),
      .data_o(voted_data_b), .mismatch_detected_o(data_b_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(data_b_fatal)
   );

   tmr_voter #(.DATA_WIDTH(11)) control_signals_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.control_signals), .data_1_i(exec_in_1.control_signals), .data_2_i(exec_in_2.control_signals),
      .data_o(voted_exec_ctrl), .mismatch_detected_o(control_signals_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(control_signals_fatal)
   );

   tmr_voter #(.DATA_WIDTH(PHYS_REG_ADDR_WIDTH)) rd_phys_addr_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.rd_phys_addr), .data_1_i(exec_in_1.rd_phys_addr), .data_2_i(exec_in_2.rd_phys_addr),
      .data_o(voted_exec_rd), .mismatch_detected_o(rd_phys_addr_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(rd_phys_addr_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.pc), .data_1_i(exec_in_1.pc), .data_2_i(exec_in_2.pc),
      .data_o(voted_exec_pc), .mismatch_detected_o(pc_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) pc_value_at_prediction_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.pc_value_at_prediction), .data_1_i(exec_in_1.pc_value_at_prediction), .data_2_i(exec_in_2.pc_value_at_prediction),
      .data_o(voted_exec_pc_pred), .mismatch_detected_o(pc_value_at_prediction_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(pc_value_at_prediction_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) branch_sel_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.branch_sel), .data_1_i(exec_in_1.branch_sel), .data_2_i(exec_in_2.branch_sel),
      .data_o(voted_exec_branch_sel), .mismatch_detected_o(branch_sel_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(branch_sel_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) branch_prediction_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.branch_prediction), .data_1_i(exec_in_1.branch_prediction), .data_2_i(exec_in_2.branch_prediction),
      .data_o(voted_exec_branch_pred), .mismatch_detected_o(branch_prediction_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(branch_prediction_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) store_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(exec_in_0.store_data), .data_1_i(exec_in_1.store_data), .data_2_i(exec_in_2.store_data),
      .data_o(voted_exec_store_data), .mismatch_detected_o(store_data_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(store_data_fatal)
   );

   //==========================================================================
   // TMR VOTERS FOR INTERNAL REGISTERS (using interface signals)
   //==========================================================================

   tmr_voter #(.DATA_WIDTH(1)) enable_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.enable), .data_1_i(rs_1_internal.enable), .data_2_i(rs_2_internal.enable),
      .data_o(voted_enable), .mismatch_detected_o(enable_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(enable_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) occupied_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.occupied), .data_1_i(rs_1_internal.occupied), .data_2_i(rs_2_internal.occupied),
      .data_o(voted_occupied), .mismatch_detected_o(occupied_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(occupied_fatal)
   );

   tmr_voter #(.DATA_WIDTH(11)) stored_control_signals_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.control_signals), .data_1_i(rs_1_internal.control_signals), .data_2_i(rs_2_internal.control_signals),
      .data_o(voted_control_signals), .mismatch_detected_o(stored_control_signals_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_control_signals_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) stored_pc_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.pc), .data_1_i(rs_1_internal.pc), .data_2_i(rs_2_internal.pc),
      .data_o(voted_pc), .mismatch_detected_o(stored_pc_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_pc_fatal)
   );

   tmr_voter #(.DATA_WIDTH(PHYS_REG_ADDR_WIDTH)) stored_rd_phys_addr_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.rd_phys_addr), .data_1_i(rs_1_internal.rd_phys_addr), .data_2_i(rs_2_internal.rd_phys_addr),
      .data_o(voted_rd_phys_addr), .mismatch_detected_o(stored_rd_phys_addr_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_rd_phys_addr_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) stored_pc_value_at_prediction_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.pc_value_at_prediction), .data_1_i(rs_1_internal.pc_value_at_prediction), .data_2_i(rs_2_internal.pc_value_at_prediction),
      .data_o(voted_pc_value_at_prediction), .mismatch_detected_o(stored_pc_value_at_prediction_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_pc_value_at_prediction_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) stored_branch_sel_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.branch_sel), .data_1_i(rs_1_internal.branch_sel), .data_2_i(rs_2_internal.branch_sel),
      .data_o(voted_branch_sel), .mismatch_detected_o(stored_branch_sel_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_branch_sel_fatal)
   );

   tmr_voter #(.DATA_WIDTH(1)) stored_branch_prediction_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.branch_prediction), .data_1_i(rs_1_internal.branch_prediction), .data_2_i(rs_2_internal.branch_prediction),
      .data_o(voted_branch_prediction), .mismatch_detected_o(stored_branch_prediction_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_branch_prediction_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) stored_store_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.store_data), .data_1_i(rs_1_internal.store_data), .data_2_i(rs_2_internal.store_data),
      .data_o(voted_store_data), .mismatch_detected_o(stored_store_data_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(stored_store_data_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) operand_a_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_a_data), .data_1_i(rs_1_internal.operand_a_data), .data_2_i(rs_2_internal.operand_a_data),
      .data_o(voted_operand_a_data), .mismatch_detected_o(operand_a_data_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(operand_a_data_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) operand_a_tag_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_a_tag), .data_1_i(rs_1_internal.operand_a_tag), .data_2_i(rs_2_internal.operand_a_tag),
      .data_o(voted_operand_a_tag), .mismatch_detected_o(operand_a_tag_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(operand_a_tag_fatal)
   );

   tmr_voter #(.DATA_WIDTH(DATA_WIDTH)) operand_b_data_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_b_data), .data_1_i(rs_1_internal.operand_b_data), .data_2_i(rs_2_internal.operand_b_data),
      .data_o(voted_operand_b_data), .mismatch_detected_o(operand_b_data_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(operand_b_data_fatal)
   );

   tmr_voter #(.DATA_WIDTH(3)) operand_b_tag_voter (
      .secure_mode_i(secure_mode),
      .data_0_i(rs_0_internal.operand_b_tag), .data_1_i(rs_1_internal.operand_b_tag), .data_2_i(rs_2_internal.operand_b_tag),
      .data_o(voted_operand_b_tag), .mismatch_detected_o(operand_b_tag_mismatch), .error_0_o(), .error_1_o(), .error_2_o(), .fatal_error_o(operand_b_tag_fatal)
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

   // Output 1 - in secure mode, issue_valid=0 so only RS0 executes and writes to CDB
   assign exec_out_1.issue_valid     = secure_mode ? 1'b0                   : exec_in_1.issue_valid;
   assign exec_out_1.data_a          = secure_mode ? voted_data_a           : exec_in_1.data_a;
   assign exec_out_1.data_b          = secure_mode ? voted_data_b           : exec_in_1.data_b;
   assign exec_out_1.control_signals = secure_mode ? voted_exec_ctrl        : exec_in_1.control_signals;
   assign exec_out_1.rd_phys_addr    = secure_mode ? voted_exec_rd          : exec_in_1.rd_phys_addr;
   assign exec_out_1.pc              = secure_mode ? voted_exec_pc          : exec_in_1.pc;
   assign exec_out_1.pc_value_at_prediction = secure_mode ? voted_exec_pc_pred : exec_in_1.pc_value_at_prediction;
   assign exec_out_1.branch_sel      = secure_mode ? voted_exec_branch_sel  : exec_in_1.branch_sel;
   assign exec_out_1.branch_prediction = secure_mode ? voted_exec_branch_pred : exec_in_1.branch_prediction;
   assign exec_out_1.store_data      = secure_mode ? voted_exec_store_data  : exec_in_1.store_data;

   // Output 2 - in secure mode, issue_valid=0 so only RS0 executes and writes to CDB
   assign exec_out_2.issue_valid     = secure_mode ? 1'b0                   : exec_in_2.issue_valid;
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
   assign exec_mismatch_o = issue_valid_mismatch | data_a_mismatch | data_b_mismatch |
      control_signals_mismatch | rd_phys_addr_mismatch | pc_mismatch |
      pc_value_at_prediction_mismatch | branch_sel_mismatch | branch_prediction_mismatch | store_data_mismatch;

   assign exec_fatal_o = issue_valid_fatal | data_a_fatal | data_b_fatal |
      control_signals_fatal | rd_phys_addr_fatal | pc_fatal |
      pc_value_at_prediction_fatal | branch_sel_fatal | branch_prediction_fatal | store_data_fatal;

   assign internal_mismatch_o = occupied_mismatch | stored_control_signals_mismatch | stored_pc_mismatch |
      stored_rd_phys_addr_mismatch | stored_pc_value_at_prediction_mismatch |
      stored_branch_sel_mismatch | stored_branch_prediction_mismatch | stored_store_data_mismatch |
      operand_a_data_mismatch | operand_a_tag_mismatch | operand_b_data_mismatch | operand_b_tag_mismatch;

   assign internal_fatal_o = occupied_fatal | stored_control_signals_fatal | stored_pc_fatal |
      stored_rd_phys_addr_fatal | stored_pc_value_at_prediction_fatal |
      stored_branch_sel_fatal | stored_branch_prediction_fatal | stored_store_data_fatal |
      operand_a_data_fatal | operand_a_tag_fatal | operand_b_data_fatal | operand_b_tag_fatal;

endmodule
