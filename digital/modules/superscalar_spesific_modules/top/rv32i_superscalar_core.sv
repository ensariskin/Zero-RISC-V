`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2025
// Design Name: RV32I Superscalar Processor Core
// Module Name: rv32i_superscalar_core
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Top-level module for the RV32I superscalar processor
//              Integrates fetch, buffer, decode, execute, and writeback stages
//              Supports 3-way superscalar execution with out-of-order capabilities
// 
// Dependencies: fetch_buffer_top.sv, multi_fetch.sv, instruction_buffer.sv,
//              decode_stage.sv, execute.sv, mem.sv, write_back.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// - 3-instruction fetch per cycle
// - Variable decode/issue width (1-3 instructions)
// - Branch prediction with fetch optimization
// - Instruction buffer for fetch/decode decoupling
// - Future: Out-of-order execution, register renaming
//////////////////////////////////////////////////////////////////////////////////

module rv32i_superscalar_core #(
    parameter DATA_WIDTH = 32,
    parameter BUFFER_DEPTH = 16,
    parameter REG_FILE_ADDR_WIDTH = 5
)(
    // Clock and Reset
    input  logic clk,
    input  logic reset,
    
    // Instruction Memory Interface (3-port for parallel fetch)
    output logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2, inst_addr_3, inst_addr_4,
    input  logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2, instruction_i_3, instruction_i_4,
    
    // Data Memory Interface (for load/store operations)
    output logic [DATA_WIDTH-1:0] data_0_addr,
    output logic [DATA_WIDTH-1:0] data_0_write,
    input  logic [DATA_WIDTH-1:0] data_0_read,
    output logic                  data_0_we,
    output logic [3:0]            data_0_be,
    output logic                  data_0_req,
    input  logic                  data_0_ack,
    input  logic                  data_0_err,

    output logic [DATA_WIDTH-1:0] data_1_addr,
    output logic [DATA_WIDTH-1:0] data_1_write,
    input  logic [DATA_WIDTH-1:0] data_1_read,
    output logic                  data_1_we,
    output logic [3:0]            data_1_be,
    output logic                  data_1_req,
    input  logic                  data_1_ack,
    input  logic                  data_1_err,

    output logic [DATA_WIDTH-1:0] data_2_addr,
    output logic [DATA_WIDTH-1:0] data_2_write,
    input  logic [DATA_WIDTH-1:0] data_2_read,
    output logic                  data_2_we,
    output logic [3:0]            data_2_be,
    output logic                  data_2_req,
    input  logic                  data_2_ack,
    input  logic                  data_2_err,

    `ifndef SYNTHESIS
    tracer_interface o_tracer_0,
    tracer_interface o_tracer_1,
    tracer_interface o_tracer_2,
    `endif
    
    // External Interrupt Interface
    input  logic external_interrupt,
    input  logic timer_interrupt,
    input  logic software_interrupt,
    
    // Debug Interface
    output logic [DATA_WIDTH-1:0] debug_pc,
    output logic [DATA_WIDTH-1:0] debug_instruction,
    output logic debug_valid,
    
    // Performance Counters
    output logic [31:0] perf_cycles,
    output logic [31:0] perf_instructions_fetched,
    output logic [31:0] perf_instructions_executed,
    output logic [31:0] perf_branch_mispredictions,
    output logic [31:0] perf_buffer_stalls,
    
    // Status Outputs
    output logic processor_halted,
    output logic [2:0] current_privilege_mode
);

    localparam D = 1; // Delay for simulation purposes

    // Internal Pipeline Control Signals
    logic pipeline_flush;
    logic pipeline_stall;
    logic decode_bubble;
    
    // Fetch Buffer Interface
    logic [2:0] decode_valid;
    logic [DATA_WIDTH-1:0] fetch_instruction_0, fetch_instruction_1, fetch_instruction_2;
    logic [DATA_WIDTH-1:0] fetch_pc_0, fetch_pc_1, fetch_pc_2;
    logic [DATA_WIDTH-1:0] fetch_imm_0, fetch_imm_1, fetch_imm_2;
    logic fetch_branch_pred_0, fetch_branch_pred_1, fetch_branch_pred_2;
    logic [2:0] decode_ready;
    logic buffer_empty, buffer_full;
    logic [$clog2(BUFFER_DEPTH):0] buffer_occupancy;
    
    // Branch Prediction Interface
    logic [DATA_WIDTH-1:0] bp_pc_0, bp_pc_1, bp_pc_2;
    
    logic bp_update_valid_0, bp_update_valid_1, bp_update_valid_2;
    logic [DATA_WIDTH-1:0] bp_update_pc_0, bp_update_pc_1, bp_update_pc_2;
    logic bp_misprediction_0, bp_misprediction_1, bp_misprediction_2;
    logic [DATA_WIDTH-1:0] bp_correct_pc;
    
    // Decode Stage Outputs (3 parallel decode units)
    logic [2:0] decode_valid_out;
    logic [DATA_WIDTH-1:0] decode_data_a_0, decode_data_a_1, decode_data_a_2;
    logic [DATA_WIDTH-1:0] decode_data_b_0, decode_data_b_1, decode_data_b_2;
    logic [DATA_WIDTH-1:0] decode_store_data_0, decode_store_data_1, decode_store_data_2;
    logic [DATA_WIDTH-1:0] decode_pc_0, decode_pc_1, decode_pc_2;
    logic [25:0] decode_control_0, decode_control_1, decode_control_2;
    logic [DATA_WIDTH-1:0] decode_pc_prediction_0, decode_pc_prediction_1, decode_pc_prediction_2;
    logic [2:0] decode_branch_sel_0, decode_branch_sel_1, decode_branch_sel_2;
    logic decode_branch_pred_0, decode_branch_pred_1, decode_branch_pred_2;
    logic [REG_FILE_ADDR_WIDTH-1:0] decode_rs1_0, decode_rs1_1, decode_rs1_2;
    logic [REG_FILE_ADDR_WIDTH-1:0] decode_rs2_0, decode_rs2_1, decode_rs2_2;
    logic [REG_FILE_ADDR_WIDTH-1:0] decode_rd_0, decode_rd_1, decode_rd_2;

    logic [2:0] commit_valid;
    logic [REG_FILE_ADDR_WIDTH-1:0] commit_addr_0;
    logic [REG_FILE_ADDR_WIDTH-1:0] commit_addr_1;
    logic [REG_FILE_ADDR_WIDTH-1:0] commit_addr_2;
    logic [4:0] commit_rob_idx_0;
    logic [4:0] commit_rob_idx_1;
    logic [4:0] commit_rob_idx_2;

    logic lsq_commit_valid_0;
    logic lsq_commit_valid_1;
    logic lsq_commit_valid_2;
    
    // Execute Stage Interface
    logic [2:0] execute_ready;
    logic [2:0] execute_valid_out;
    logic [DATA_WIDTH-1:0] execute_result_0, execute_result_1, execute_result_2;
    logic [REG_FILE_ADDR_WIDTH-1:0] execute_rd_0, execute_rd_1, execute_rd_2;
    logic execute_reg_write_0, execute_reg_write_1, execute_reg_write_2;
    
    // Memory Stage Interface
    logic mem_valid;
    logic [DATA_WIDTH-1:0] mem_result;
    logic [REG_FILE_ADDR_WIDTH-1:0] mem_rd;
    logic mem_reg_write;
    
    // Writeback Stage Interface
    logic [2:0] wb_valid;
    logic [DATA_WIDTH-1:0] wb_data_0, wb_data_1, wb_data_2;
    logic [REG_FILE_ADDR_WIDTH-1:0] wb_rd_0, wb_rd_1, wb_rd_2;
    logic wb_reg_write_0, wb_reg_write_1, wb_reg_write_2;
    
    // CSR Interface
    logic [11:0] csr_addr;
    logic [DATA_WIDTH-1:0] csr_write_data;
    logic [DATA_WIDTH-1:0] csr_read_data;
    logic csr_write_enable;
    logic csr_read_enable;
    
    // Exception and Interrupt Handling
    logic exception_occurred;
    logic [3:0] exception_cause;
    logic [DATA_WIDTH-1:0] exception_pc;
    logic interrupt_pending;
    
    // Performance Counter Registers
    logic [31:0] cycle_counter;
    logic [31:0] instruction_fetch_counter;
    logic [31:0] instruction_execute_counter;
    logic [31:0] branch_misprediction_counter;
    logic [31:0] buffer_stall_counter;
    
    // Debug and Status Registers
    logic [DATA_WIDTH-1:0] current_pc;
    logic [DATA_WIDTH-1:0] current_instruction;
    logic instruction_valid;
    logic [1:0] privilege_mode;
    logic halted;

    // misprediction signal from ROB
    logic misprediction_detected;
    logic [DATA_WIDTH-1:0] commit_correct_pc_0;
    logic commit_is_branch_0;
    logic [DATA_WIDTH-1:0] upadate_predictor_pc_0;

    logic                  ex0_misprediction_detected;
    logic [DATA_WIDTH-1:0] ex0_commit_correct_pc;
    logic                  ex0_commit_is_branch;
    logic [DATA_WIDTH-1:0] ex0_upadate_predictor_pc;

    logic                  ex1_misprediction_detected;
    logic [DATA_WIDTH-1:0] ex1_commit_correct_pc;
    logic                  ex1_commit_is_branch;
    logic [DATA_WIDTH-1:0] ex1_upadate_predictor_pc;

    logic                  ex2_misprediction_detected;
    logic [DATA_WIDTH-1:0] ex2_commit_correct_pc;
    logic                  ex2_commit_is_branch;
    logic [DATA_WIDTH-1:0] ex2_upadate_predictor_pc;

    logic [5:0] phys_reg_branch_0;
    logic [5:0] phys_reg_branch_1;
    logic [5:0] phys_reg_branch_2;

    //==========================================================================
    // BRAT v2 In-Order Branch Resolution Outputs (from issue_stage)
    //==========================================================================
    logic [2:0] brat_branch_resolved;       // In-order resolved branches
    logic [2:0] brat_branch_mispredicted;   // In-order misprediction flags
    logic [5:0] brat_resolved_phys_0;       // ROB ID of oldest resolved
    logic [5:0] brat_resolved_phys_1;       // ROB ID of 2nd oldest resolved
    logic [5:0] brat_resolved_phys_2;       // ROB ID of 3rd oldest resolved
    logic [DATA_WIDTH-1:0] brat_correct_pc_0;  // Correct PC for oldest
    logic [DATA_WIDTH-1:0] brat_correct_pc_1;  // Correct PC for 2nd oldest
    logic [DATA_WIDTH-1:0] brat_correct_pc_2;  // Correct PC for 3rd oldest
    logic brat_is_jalr_0, brat_is_jalr_1, brat_is_jalr_2;  // Is resolved branch a JALR?
    logic [DATA_WIDTH-1:0] brat_pc_at_prediction_0;  // PC at prediction for oldest
    logic [DATA_WIDTH-1:0] brat_pc_at_prediction_1;  // PC at prediction for 2nd oldest
    logic [DATA_WIDTH-1:0] brat_pc_at_prediction_2;  // PC at prediction for 3rd oldest

    // JALR detection and misprediction signals from execute stage
    logic ex0_is_jalr;
    logic ex1_is_jalr;
    logic ex2_is_jalr;
    logic ex0_jalr_misprediction;
    logic ex1_jalr_misprediction;
    logic ex2_jalr_misprediction;


    cdb_if #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(6)
    ) cdb_interface ();
    
    //==========================================================================
    // FETCH STAGE (fetch_buffer_top)
    //==========================================================================
    
    fetch_buffer_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH)
    ) fetch_buffer_unit (
        .clk(clk),
        .reset(reset),
        
        // Memory interface
        .inst_addr_0(inst_addr_0),
        .instruction_i_0(instruction_i_0),
        .inst_addr_1(inst_addr_1),
        .instruction_i_1(instruction_i_1),
        .inst_addr_2(inst_addr_2),
        .instruction_i_2(instruction_i_2),
        .inst_addr_3(inst_addr_3),
        .instruction_i_3(instruction_i_3),
        .inst_addr_4(inst_addr_4),
        .instruction_i_4(instruction_i_4),
        
        // Pipeline control
        .buble(pipeline_stall),
        
        //======================================================================
        // BRAT-based In-Order Branch Resolution (Simplified Interface)
        // All prediction updates now come from BRAT for in-order processing
        //======================================================================
        
        // Port 0 (oldest resolved branch from BRAT)
        .misprediction_i_0(brat_branch_resolved[0] & brat_branch_mispredicted[0]),
        .update_valid_i_0(brat_branch_resolved[0]),
        .is_jalr_i_0(brat_is_jalr_0),
        .pc_at_prediction_i_0(brat_pc_at_prediction_0),
        .correct_pc_i_0(brat_correct_pc_0),
        
        // Port 1 (2nd oldest resolved branch from BRAT)
        .misprediction_i_1(brat_branch_resolved[1] & brat_branch_mispredicted[1]),
        .update_valid_i_1(brat_branch_resolved[1]),
        .is_jalr_i_1(brat_is_jalr_1),
        .pc_at_prediction_i_1(brat_pc_at_prediction_1),
        .correct_pc_i_1(brat_correct_pc_1),
        
        // Port 2 (3rd oldest resolved branch from BRAT)
        .misprediction_i_2(brat_branch_resolved[2] & brat_branch_mispredicted[2]),
        .update_valid_i_2(brat_branch_resolved[2]),
        .is_jalr_i_2(brat_is_jalr_2),
        .pc_at_prediction_i_2(brat_pc_at_prediction_2),
        .correct_pc_i_2(brat_correct_pc_2),
        
        // PC at prediction time (output from fetch for issue stage to capture)
        .pc_value_at_prediction_0(bp_pc_0),
        .pc_value_at_prediction_1(bp_pc_1),
        .pc_value_at_prediction_2(bp_pc_2),
        
        // Output to decode stages
        .decode_valid_o(decode_valid),
        .instruction_o_0(fetch_instruction_0),
        .instruction_o_1(fetch_instruction_1),
        .instruction_o_2(fetch_instruction_2),
        .pc_decode_o_0(fetch_pc_0),
        .pc_decode_o_1(fetch_pc_1),
        .pc_decode_o_2(fetch_pc_2),
        .imm_decode_o_0(fetch_imm_0),
        .imm_decode_o_1(fetch_imm_1),
        .imm_decode_o_2(fetch_imm_2),
        .branch_prediction_decode_o_0(fetch_branch_pred_0),
        .branch_prediction_decode_o_1(fetch_branch_pred_1),
        .branch_prediction_decode_o_2(fetch_branch_pred_2),
        
        // Decode stage ready signals
        .decode_ready_i(decode_ready),
        
        // Status outputs
        .buffer_empty_o(buffer_empty),
        .buffer_full_o(buffer_full),
        .occupancy_o(buffer_occupancy)
        
    );

    
    //==========================================================================
    // ISSUE STAGE (3 parallel decode units with register renaming)
    //==========================================================================
    
    // Create interfaces for issue stage to dispatch stage
    issue_to_dispatch_if #(.DATA_WIDTH(DATA_WIDTH), .PHYS_REG_ADDR_WIDTH(REG_FILE_ADDR_WIDTH+1)) 
        issue_to_dispatch_0_if(), issue_to_dispatch_1_if(), issue_to_dispatch_2_if();
    
    `ifndef SYNTHESIS
    tracer_interface tracer_issue_0 ();
    tracer_interface tracer_issue_1 ();
    tracer_interface tracer_issue_2 ();
    `endif
    
    // Generate eager flush signal from BRAT in-order misprediction outputs
    logic eager_flush;
    assign eager_flush = (brat_branch_resolved[0] & brat_branch_mispredicted[0]) | 
                         (brat_branch_resolved[1] & brat_branch_mispredicted[1]) | 
                         (brat_branch_resolved[2] & brat_branch_mispredicted[2]);
    
    // Eager misprediction flush signals from dispatch (LSQ) to issue (RAT circular buffer)
    logic        lsq_flush_valid;
    logic [4:0]  first_invalid_lsq_idx;
    
    issue_stage #(
        .DATA_WIDTH(DATA_WIDTH),
        .ARCH_REG_ADDR_WIDTH(REG_FILE_ADDR_WIDTH),
        .PHYS_REG_ADDR_WIDTH(REG_FILE_ADDR_WIDTH+1)
    ) issue_stage_unit (
        .clk(clk),
        .reset(reset),
        
        // Pipeline control - use eager flush from execute stage
        .flush(eager_flush),
        .bubble(pipeline_stall),
        
        // Input from fetch/buffer stage
        .decode_valid_i(decode_valid),
        .instruction_i_0(fetch_instruction_0),
        .instruction_i_1(fetch_instruction_1),
        .instruction_i_2(fetch_instruction_2),
        .immediate_i_0(fetch_imm_0),
        .immediate_i_1(fetch_imm_1),
        .immediate_i_2(fetch_imm_2),
        .pc_i_0(fetch_pc_0),
        .pc_i_1(fetch_pc_1),
        .pc_i_2(fetch_pc_2),
        .pc_value_at_prediction_i_0(bp_pc_0), // Using PC for now
        .pc_value_at_prediction_i_1(bp_pc_1),
        .pc_value_at_prediction_i_2(bp_pc_2),
        .branch_prediction_i_0(fetch_branch_pred_0),
        .branch_prediction_i_1(fetch_branch_pred_1),
        .branch_prediction_i_2(fetch_branch_pred_2),
        
        // Ready signal to fetch/buffer stage
        .decode_ready_o(decode_ready),
        
        // ROB commit interface (placeholder for now)
        .commit_valid_i(commit_valid),
        .commit_addr_0_i(commit_addr_0),
        .commit_addr_1_i(commit_addr_1),
        .commit_addr_2_i(commit_addr_2),
        .commit_rob_idx_0(commit_rob_idx_0),
        .commit_rob_idx_1(commit_rob_idx_1),
        .commit_rob_idx_2(commit_rob_idx_2),

        //==========================================================================
        // Execute stage inputs to BRAT v2 (raw branch results)
        //==========================================================================
        .exec_branch_valid_i({ex2_commit_is_branch | ex2_is_jalr, 
                              ex1_commit_is_branch | ex1_is_jalr, 
                              ex0_commit_is_branch | ex0_is_jalr}),
        .exec_mispredicted_i({ex2_misprediction_detected, ex1_misprediction_detected, ex0_misprediction_detected}),
        .exec_rob_id_0_i(phys_reg_branch_0),
        .exec_rob_id_1_i(phys_reg_branch_1),
        .exec_rob_id_2_i(phys_reg_branch_2),
        .exec_correct_pc_0_i(ex0_commit_correct_pc),
        .exec_correct_pc_1_i(ex1_commit_correct_pc),
        .exec_correct_pc_2_i(ex2_commit_correct_pc),
        .exec_pc_at_prediction_0_i(ex0_upadate_predictor_pc),
        .exec_pc_at_prediction_1_i(ex1_upadate_predictor_pc),
        .exec_pc_at_prediction_2_i(ex2_upadate_predictor_pc),
        
        //==========================================================================
        // BRAT v2 In-Order Branch Resolution Outputs (to other modules)
        //==========================================================================
        .branch_resolved_o(brat_branch_resolved),
        .branch_mispredicted_o(brat_branch_mispredicted),
        .resolved_phys_reg_0_o(brat_resolved_phys_0),
        .resolved_phys_reg_1_o(brat_resolved_phys_1),
        .resolved_phys_reg_2_o(brat_resolved_phys_2),
        .correct_pc_0_o(brat_correct_pc_0),
        .correct_pc_1_o(brat_correct_pc_1),
        .correct_pc_2_o(brat_correct_pc_2),
        .is_jalr_0_o(brat_is_jalr_0),
        .is_jalr_1_o(brat_is_jalr_1),
        .is_jalr_2_o(brat_is_jalr_2),
        .pc_at_prediction_0_o(brat_pc_at_prediction_0),
        .pc_at_prediction_1_o(brat_pc_at_prediction_1),
        .pc_at_prediction_2_o(brat_pc_at_prediction_2),
        
        `ifndef SYNTHESIS
        .tracer_0(tracer_issue_0),
        .tracer_1(tracer_issue_1),
        .tracer_2(tracer_issue_2),
        `endif
        
        // Issue to Dispatch Stage Interfaces
        .issue_to_dispatch_0(issue_to_dispatch_0_if.issue),
        .issue_to_dispatch_1(issue_to_dispatch_1_if.issue),
        .issue_to_dispatch_2(issue_to_dispatch_2_if.issue),

        .lsq_commit_0(lsq_commit_valid_0),
        .lsq_commit_1(lsq_commit_valid_1),
        .lsq_commit_2(lsq_commit_valid_2),
        
        // Eager misprediction flush interface (from dispatch/LSQ)
        .lsq_flush_valid_i(lsq_flush_valid),
        .first_invalid_lsq_idx_i(first_invalid_lsq_idx)

    );
    
    //==========================================================================
    // DISPATCH STAGE (reservation stations + register file)
    //==========================================================================
    
    // Create interfaces for dispatch stage to functional units
    rs_to_exec_if #(.DATA_WIDTH(DATA_WIDTH), .PHYS_REG_ADDR_WIDTH(REG_FILE_ADDR_WIDTH+1)) 
        dispatch_to_alu_0_if(), dispatch_to_alu_1_if(), dispatch_to_alu_2_if();
    
    dispatch_stage #(
        .DATA_WIDTH(DATA_WIDTH),
        .PHYS_REG_ADDR_WIDTH(REG_FILE_ADDR_WIDTH+1),
        .NUM_PHYS_REGS(64)
    ) dispatch_stage_unit (
        .clk(clk),
        .reset(reset),
        
        // BRAT in-order branch resolution inputs (for RS/LSQ eager flush)
        .brat_branch_resolved_i(brat_branch_resolved),
        .brat_branch_mispredicted_i(brat_branch_mispredicted),
        .brat_resolved_phys_0_i(brat_resolved_phys_0),
        .brat_resolved_phys_1_i(brat_resolved_phys_1),
        .brat_resolved_phys_2_i(brat_resolved_phys_2),
        
        // Input from Issue Stage
        .issue_to_dispatch_0(issue_to_dispatch_0_if.dispatch),
        .issue_to_dispatch_1(issue_to_dispatch_1_if.dispatch),
        .issue_to_dispatch_2(issue_to_dispatch_2_if.dispatch),
        
        // Output to Functional Units
        .dispatch_to_alu_0(dispatch_to_alu_0_if.reservation_station),
        .dispatch_to_alu_1(dispatch_to_alu_1_if.reservation_station),
        .dispatch_to_alu_2(dispatch_to_alu_2_if.reservation_station),

        `ifndef SYNTHESIS
        .i_tracer_0(tracer_issue_0),
        .i_tracer_1(tracer_issue_1),
        .i_tracer_2(tracer_issue_2),

        .o_tracer_0(o_tracer_0),
        .o_tracer_1(o_tracer_1),
        .o_tracer_2(o_tracer_2),
        `endif

        .data_0_addr,
        .data_0_write,
        .data_0_read,
        .data_0_we,
        .data_0_be,
        .data_0_req,
        .data_0_ack,

        .data_1_addr,
        .data_1_write,
        .data_1_read,
        .data_1_we,
        .data_1_be,
        .data_1_req,
        .data_1_ack,

        .data_2_addr,
        .data_2_write,
        .data_2_read,
        .data_2_we,
        .data_2_be,
        .data_2_req,
        .data_2_ack,

        .cdb_interface(cdb_interface),

        .commit_valid(commit_valid),
        .commit_addr_0(commit_addr_0),
        .commit_addr_1(commit_addr_1),
        .commit_addr_2(commit_addr_2),
        .commit_rob_idx_0(commit_rob_idx_0),
        .commit_rob_idx_1(commit_rob_idx_1),
        .commit_rob_idx_2(commit_rob_idx_2),

        .lsq_commit_valid_0(lsq_commit_valid_0),
        .lsq_commit_valid_1(lsq_commit_valid_1),
        .lsq_commit_valid_2(lsq_commit_valid_2),

        .misprediction_detected(misprediction_detected),
        .commit_correct_pc_0(commit_correct_pc_0),
        .commit_is_branch_0(commit_is_branch_0),
        .upadate_predictor_pc_0(upadate_predictor_pc_0),
        
        // Eager misprediction flush outputs (for issue stage LSQ circular buffer)
        .lsq_flush_valid_o(lsq_flush_valid),
        .first_invalid_lsq_idx_o(first_invalid_lsq_idx)
    );
    
    //==========================================================================
    // EXECUTE STAGE
    //==========================================================================
    
    superscalar_execute_stage #(
        .DATA_WIDTH(DATA_WIDTH)
    ) execute_stage_unit (
        .clk(clk),
        .rst_n(~reset),
        
        .update_predictor_0(ex0_commit_is_branch),
        .update_predictor_1(ex1_commit_is_branch),
        .update_predictor_2(ex2_commit_is_branch),

        .misprediction_0(ex0_misprediction_detected),
        .misprediction_1(ex1_misprediction_detected),
        .misprediction_2(ex2_misprediction_detected),

        .correct_pc_0(ex0_commit_correct_pc),
        .correct_pc_1(ex1_commit_correct_pc),
        .correct_pc_2(ex2_commit_correct_pc),

        .update_pc_0(ex0_upadate_predictor_pc),
        .update_pc_1(ex1_upadate_predictor_pc),
        .update_pc_2(ex2_upadate_predictor_pc),

        // JALR detection and misprediction outputs
        .is_jalr_0(ex0_is_jalr),
        .is_jalr_1(ex1_is_jalr),
        .is_jalr_2(ex2_is_jalr),
        
        .jalr_misprediction_0(ex0_jalr_misprediction),
        .jalr_misprediction_1(ex1_jalr_misprediction),
        .jalr_misprediction_2(ex2_jalr_misprediction),

        .phys_reg_branch_0(phys_reg_branch_0),
        .phys_reg_branch_1(phys_reg_branch_1),
        .phys_reg_branch_2(phys_reg_branch_2),

        // Interface to reservation stations
        .rs_to_exec_0(dispatch_to_alu_0_if.functional_unit),
        .rs_to_exec_1(dispatch_to_alu_1_if.functional_unit),
        .rs_to_exec_2(dispatch_to_alu_2_if.functional_unit)
    );
    
    //==========================================================================
    // TEMPORARY CONNECTIONS (for backward compatibility during transition)
    //==========================================================================
    
    // Extract data from dispatch interfaces for execute stage (temporary)
    assign decode_valid_out[0] = dispatch_to_alu_0_if.issue_valid;
    assign decode_valid_out[1] = dispatch_to_alu_1_if.issue_valid;
    assign decode_valid_out[2] = dispatch_to_alu_2_if.issue_valid;
    
    assign decode_data_a_0 = dispatch_to_alu_0_if.data_a;
    assign decode_data_a_1 = dispatch_to_alu_1_if.data_a;
    assign decode_data_a_2 = dispatch_to_alu_2_if.data_a;
    
    assign decode_data_b_0 = dispatch_to_alu_0_if.data_b;
    assign decode_data_b_1 = dispatch_to_alu_1_if.data_b;
    assign decode_data_b_2 = dispatch_to_alu_2_if.data_b;
    
    assign decode_store_data_0 = dispatch_to_alu_0_if.store_data;  // Now using dedicated store_data signal
    assign decode_store_data_1 = dispatch_to_alu_1_if.store_data;  // Now using dedicated store_data signal
    assign decode_store_data_2 = dispatch_to_alu_2_if.store_data;  // Now using dedicated store_data signal
    
    assign decode_pc_0 = dispatch_to_alu_0_if.pc;                  // Now from rs_to_exec interface
    assign decode_pc_1 = dispatch_to_alu_1_if.pc;                  // Now from rs_to_exec interface
    assign decode_pc_2 = dispatch_to_alu_2_if.pc;                  // Now from rs_to_exec interface
    
    assign decode_control_0 = {15'h0, dispatch_to_alu_0_if.control_signals}; // Now from rs_to_exec interface
    assign decode_control_1 = {15'h0, dispatch_to_alu_1_if.control_signals}; // Now from rs_to_exec interface
    assign decode_control_2 = {15'h0, dispatch_to_alu_2_if.control_signals}; // Now from rs_to_exec interface
    
    assign decode_pc_prediction_0 = dispatch_to_alu_0_if.pc_value_at_prediction;
    assign decode_pc_prediction_1 = dispatch_to_alu_1_if.pc_value_at_prediction;
    assign decode_pc_prediction_2 = dispatch_to_alu_2_if.pc_value_at_prediction;
    
    assign decode_branch_sel_0 = dispatch_to_alu_0_if.branch_sel;
    assign decode_branch_sel_1 = dispatch_to_alu_1_if.branch_sel;
    assign decode_branch_sel_2 = dispatch_to_alu_2_if.branch_sel;
    
    assign decode_branch_pred_0 = dispatch_to_alu_0_if.branch_prediction;
    assign decode_branch_pred_1 = dispatch_to_alu_1_if.branch_prediction;
    assign decode_branch_pred_2 = dispatch_to_alu_2_if.branch_prediction;
    
    // Extract destination registers from rs_to_exec interfaces (convert 6-bit back to 5-bit for now)
    assign decode_rd_0 = dispatch_to_alu_0_if.rd_phys_addr[4:0];
    assign decode_rd_1 = dispatch_to_alu_1_if.rd_phys_addr[4:0];
    assign decode_rd_2 = dispatch_to_alu_2_if.rd_phys_addr[4:0];
    
    //==========================================================================
    // EXECUTE STAGE OUTPUTS (for backward compatibility)
    //==========================================================================
    
    // Extract execute results from interface for temporary compatibility
    assign execute_valid_out = decode_valid_out; // Will be replaced with proper completion signals
    assign execute_result_0 = dispatch_to_alu_0_if.data_result;
    assign execute_result_1 = dispatch_to_alu_1_if.data_result;
    assign execute_result_2 = dispatch_to_alu_2_if.data_result;
    assign execute_rd_0 = decode_rd_0;
    assign execute_rd_1 = decode_rd_1;
    assign execute_rd_2 = decode_rd_2;
    assign execute_reg_write_0 = decode_valid_out[0] & (decode_control_0[0]); // Extract write enable from control
    assign execute_reg_write_1 = decode_valid_out[1] & (decode_control_1[0]); // Extract write enable from control
    assign execute_reg_write_2 = decode_valid_out[2] & (decode_control_2[0]); // Extract write enable from control
    assign execute_ready = 3'b111; // Always ready for now
    
    //==========================================================================
    // MEMORY STAGE (placeholder)
    //==========================================================================
    
    // For now, no memory operations
    // TODO: Implement memory pipeline stage
    assign mem_valid = 1'b0;
    assign mem_result = 32'h0;
    assign mem_rd = 5'h0;
    assign mem_reg_write = 1'b0;
    
    
    //==========================================================================
    // CONTROL AND STATUS
    //==========================================================================
    
    // Pipeline Control Logic
    assign pipeline_flush = 1'b0;
    assign pipeline_stall = 1'b0;
    assign decode_bubble = 1'b0; // Placeholder
    
    // Branch Prediction Updates (placeholder)
    assign bp_update_valid_0 = 1'b0;
    assign bp_update_valid_1 = 1'b0;
    assign bp_update_valid_2 = 1'b0;
    assign bp_update_pc_0 = 32'h0;
    assign bp_update_pc_1 = 32'h0;
    assign bp_update_pc_2 = 32'h0;
    assign bp_misprediction_0 = 1'b0;
    assign bp_misprediction_1 = 1'b0;
    assign bp_misprediction_2 = 1'b0;
    assign bp_correct_pc = 32'h0;
    
    // Exception and Interrupt Handling (placeholder)
    assign exception_occurred = 1'b0;
    assign exception_cause = 4'h0;
    assign exception_pc = 32'h0;
    assign interrupt_pending = external_interrupt | timer_interrupt | software_interrupt;
    
    // CSR Interface (placeholder)
    assign csr_addr = 12'h0;
    assign csr_write_data = 32'h0;
    assign csr_read_data = 32'h0;
    assign csr_write_enable = 1'b0;
    assign csr_read_enable = 1'b0;
    
    //==========================================================================
    // PERFORMANCE COUNTERS
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            cycle_counter <= #D 32'h0;
            instruction_fetch_counter <= #D 32'h0;
            instruction_execute_counter <= #D 32'h0;
            branch_misprediction_counter <= #D 32'h0;
            buffer_stall_counter <= #D 32'h0;
        end else begin
            cycle_counter <= #D cycle_counter + 1;
            
            // Count fetched instructions
            instruction_fetch_counter <= #D instruction_fetch_counter + 
                                       decode_valid[0] + decode_valid[1] + decode_valid[2];
            
            // Count executed instructions
            instruction_execute_counter <= #D instruction_execute_counter + 
                                         execute_valid_out[0] + execute_valid_out[1] + execute_valid_out[2];
            
            // Count branch mispredictions
            if (bp_misprediction_0 | bp_misprediction_1 | bp_misprediction_2) begin
                branch_misprediction_counter <= #D branch_misprediction_counter + 1;
            end
            
            // Count buffer stalls
            if (buffer_full) begin
                buffer_stall_counter <= #D buffer_stall_counter + 1;
            end
        end
    end
    
    //==========================================================================
    // DEBUG AND STATUS OUTPUTS
    //==========================================================================
    
    // Debug interface
    assign debug_pc = inst_addr_0;
    assign debug_instruction = fetch_instruction_0;
    assign debug_valid = decode_valid[0];
    
    // Status outputs
    assign processor_halted = halted;
    assign current_privilege_mode = {1'b0, privilege_mode};
    
    // Performance counter outputs
    assign perf_cycles = cycle_counter;
    assign perf_instructions_fetched = instruction_fetch_counter;
    assign perf_instructions_executed = instruction_execute_counter;
    assign perf_branch_mispredictions = branch_misprediction_counter;
    assign perf_buffer_stalls = buffer_stall_counter;
    
    // Status registers
    assign halted = 1'b0; // Placeholder
    assign privilege_mode = 2'b11; // Machine mode
    assign current_pc = fetch_pc_0;
    assign current_instruction = fetch_instruction_0;
    assign instruction_valid = decode_valid[0];

endmodule
