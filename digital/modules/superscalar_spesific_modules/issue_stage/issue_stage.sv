`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: issue_stage
//
// Description:
//     This module implements 3 parallel decode units with register renaming
//     for superscalar execution. Each decode unit processes one instruction 
//     independently, performing register alias table (RAT) lookup for renaming.
//     Outputs physical register addresses to dispatch stage.
//
// Features:
//     - 3 independent decode units using rv32i_decoder
//     - Register Alias Table (RAT) for register renaming
//     - Pipeline control with flush and bubble support
//     - Physical register address generation
//     - Critical path optimization (no register file access)
//////////////////////////////////////////////////////////////////////////////////

module issue_stage #(
    parameter DATA_WIDTH = 32,
    parameter ARCH_REG_ADDR_WIDTH = 5,
    parameter PHYS_REG_ADDR_WIDTH = 6,
    parameter ENTRIES = 32,                        // Number of predictor entries
    parameter INDEX_WIDTH = $clog2(ENTRIES)       // Auto-calculated index width
)(
    // Clock and Reset
    input logic clk,
    input logic reset,
    
    // Input from Fetch/Buffer Stage
    input logic [2:0] decode_valid_i,
    input logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2,
    input logic [DATA_WIDTH-1:0] immediate_i_0, immediate_i_1, immediate_i_2,
    input logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2,
    input logic [DATA_WIDTH-1:0] pc_value_at_prediction_i_0, pc_value_at_prediction_i_1, pc_value_at_prediction_i_2,
    input logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2,
    input logic [INDEX_WIDTH:0] global_history_0_i, // Current global history and prediction
    input logic [INDEX_WIDTH:0] global_history_1_i, // Current global history and prediction
    input logic [INDEX_WIDTH:0] global_history_2_i, // Current global history and prediction
    
    // Ready signal to previous stage
    output logic [2:0] decode_ready_o,
    
    // ROB commit interface (for freeing physical registers)
    input logic [2:0] commit_valid_i,
    input logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_0_i, 
    input logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_1_i,
    input logic [PHYS_REG_ADDR_WIDTH-2:0] commit_addr_2_i,
    input logic [4:0] commit_rob_idx_0, 
    input logic [4:0] commit_rob_idx_1, 
    input logic [4:0] commit_rob_idx_2,

    input logic lsq_commit_0, lsq_commit_1, lsq_commit_2, 
    
    // Eager misprediction flush interface (from LSQ for circular buffer update)
    input logic lsq_flush_valid_i,                      // LSQ flush is needed
    input logic [4:0] first_invalid_lsq_idx_i,          // First invalid LSQ index (new tail)

    //==========================================================================
    // Execute stage inputs (raw branch results - go into BRAT inside RAT)
    //==========================================================================
    input logic [2:0] exec_branch_valid_i,              // Branch executed on FU 0/1/2
    input logic [2:0] exec_mispredicted_i,              // Misprediction flag from FU 0/1/2
    input logic [PHYS_REG_ADDR_WIDTH-1:0] exec_rob_id_0_i,  // ROB ID (phys_reg) of branch on FU0
    input logic [PHYS_REG_ADDR_WIDTH-1:0] exec_rob_id_1_i,  // ROB ID (phys_reg) of branch on FU1
    input logic [PHYS_REG_ADDR_WIDTH-1:0] exec_rob_id_2_i,  // ROB ID (phys_reg) of branch on FU2
    input logic [DATA_WIDTH-1:0] exec_correct_pc_0_i,   // Correct PC from FU0
    input logic [DATA_WIDTH-1:0] exec_correct_pc_1_i,   // Correct PC from FU1
    input logic [DATA_WIDTH-1:0] exec_correct_pc_2_i,   // Correct PC from FU2
    input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_0_i,  // PC at prediction time
    input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_1_i,
    input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_2_i,
    
    //==========================================================================
    // Branch resolution outputs (in-order, from BRAT - go to other modules)
    //==========================================================================
    output logic [2:0] branch_resolved_o,               // In-order resolved branches
    output logic [2:0] branch_mispredicted_o,           // In-order misprediction flags
    output logic [PHYS_REG_ADDR_WIDTH-1:0] resolved_phys_reg_0_o,  // ROB ID of oldest resolved
    output logic [PHYS_REG_ADDR_WIDTH-1:0] resolved_phys_reg_1_o,  // ROB ID of 2nd oldest resolved
    output logic [PHYS_REG_ADDR_WIDTH-1:0] resolved_phys_reg_2_o,  // ROB ID of 3rd oldest resolved
    output logic [DATA_WIDTH-1:0] correct_pc_0_o,       // Correct PC for oldest
    output logic [DATA_WIDTH-1:0] correct_pc_1_o,       // Correct PC for 2nd oldest
    output logic [DATA_WIDTH-1:0] correct_pc_2_o,       // Correct PC for 3rd oldest
    output logic is_jalr_0_o,                           // Is oldest resolved a JALR?
    output logic is_jalr_1_o,                           // Is 2nd oldest a JALR?
    output logic is_jalr_2_o,                           // Is 3rd oldest a JALR?
    output logic [DATA_WIDTH-1:0] pc_at_prediction_0_o, // PC at prediction for oldest
    output logic [DATA_WIDTH-1:0] pc_at_prediction_1_o, // PC at prediction for 2nd oldest
    output logic [DATA_WIDTH-1:0] pc_at_prediction_2_o, // PC at prediction for 3rd oldest
    output logic [INDEX_WIDTH:0] update_global_history_0_o,
    output logic [INDEX_WIDTH:0] update_global_history_1_o,
    output logic [INDEX_WIDTH:0] update_global_history_2_o,

    // RAS checkpoint interface
    input  logic [2:0] push_ras_tos_i,
    output logic ras_restore_valid_o,
    output logic [2:0] ras_restore_tos_o,

    `ifndef SYNTHESIS
    // Debug Tracer Interfaces
    tracer_interface.source tracer_0,
    tracer_interface.source tracer_1,
    tracer_interface.source tracer_2,
    `endif
   
    // Dispatch Stage Interfaces 
    issue_to_dispatch_if.issue issue_to_dispatch_0,
    issue_to_dispatch_if.issue issue_to_dispatch_1,
    issue_to_dispatch_if.issue issue_to_dispatch_2
);

    localparam D = 1; // Delay for simulation
    
    // Internal signals for decode units - REMOVED register file data signals
    logic [25:0] control_signal_internal_0, control_signal_internal_1, control_signal_internal_2;
    logic [2:0] branch_sel_internal_0, branch_sel_internal_1, branch_sel_internal_2;
    
    // Architectural register addresses (from decoders)
    logic [ARCH_REG_ADDR_WIDTH-1:0] rs1_arch_0, rs1_arch_1, rs1_arch_2;
    logic [ARCH_REG_ADDR_WIDTH-1:0] rs2_arch_0, rs2_arch_1, rs2_arch_2;
    logic [ARCH_REG_ADDR_WIDTH-1:0] rd_arch_0, rd_arch_1, rd_arch_2;
    
    // Physical register addresses (from RAT)
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs1_phys_0, rs1_phys_1, rs1_phys_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs2_phys_0, rs2_phys_1, rs2_phys_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_0, rd_phys_1, rd_phys_2;
    logic [2:0] alloc_tag_0, alloc_tag_1, alloc_tag_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2; 
    logic [2:0] rename_valid_internal;
    logic [2:0] rename_ready;
    
    // Write enable signals for destinations
    logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2;
    // Load store
    logic load_store_0, load_store_1, load_store_2; 
    logic [2:0] lsq_alloc_ready;
    logic lsq_alloc_0_valid, lsq_alloc_1_valid, lsq_alloc_2_valid;

    // logic branch signals
    logic branch_0, branch_1, branch_2;
    
    // Pipeline registers - SIMPLIFIED (no data, only control and addresses)
    logic [2:0] decode_valid_reg;
    logic [DATA_WIDTH-1:0] pc_reg_0, pc_reg_1, pc_reg_2;
    logic [25:0] control_signal_reg_0, control_signal_reg_1, control_signal_reg_2;
    logic [DATA_WIDTH-1:0] pc_prediction_reg_0, pc_prediction_reg_1, pc_prediction_reg_2;
    logic [2:0] branch_sel_reg_0, branch_sel_reg_1, branch_sel_reg_2;
    logic branch_prediction_reg_0, branch_prediction_reg_1, branch_prediction_reg_2;
    logic [DATA_WIDTH-1:0] immediate_reg_0, immediate_reg_1, immediate_reg_2;
    
    // Physical register address pipeline registers
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs1_phys_reg_0, rs1_phys_reg_1, rs1_phys_reg_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs2_phys_reg_0, rs2_phys_reg_1, rs2_phys_reg_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_reg_0, rd_phys_reg_1, rd_phys_reg_2;
    logic [ARCH_REG_ADDR_WIDTH-1:0] rd_arch_reg_0, rd_arch_reg_1, rd_arch_reg_2;
    logic [2:0] alloc_tag_reg_0, alloc_tag_reg_1, alloc_tag_reg_2;
    logic lsq_alloc_0_valid_reg, lsq_alloc_1_valid_reg, lsq_alloc_2_valid_reg;

    logic internal_flush;
    assign internal_flush = |branch_mispredicted_o;

    //==========================================================================
    // DECODER UNITS (3 independent decoders)
    //==========================================================================
    `ifndef SYNTHESIS
    tracer_interface tracer_in_0();
    tracer_interface tracer_in_1();
    tracer_interface tracer_in_2();

    tracer_interface tracer_internal_0();
    tracer_interface tracer_internal_1();
    tracer_interface tracer_internal_2();
    `endif
    
    // Decoder 0
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_0 (
        .instruction(instruction_i_0),
        .control_word(control_signal_internal_0),
        .branch_sel(branch_sel_internal_0),
        .tracer_if_i(tracer_in_0.sink),
        .tracer_if_o(tracer_internal_0.source)
    );
    
    // Decoder 1
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_1 (
        .instruction(instruction_i_1),
        .control_word(control_signal_internal_1),
        .branch_sel(branch_sel_internal_1),
        .tracer_if_i(tracer_in_1.sink),
        .tracer_if_o(tracer_internal_1.source)
    );
    
    // Decoder 2
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_2 (
        .instruction(instruction_i_2),
        .control_word(control_signal_internal_2),
        .branch_sel(branch_sel_internal_2),
        .tracer_if_i(tracer_in_2.sink),
        .tracer_if_o(tracer_internal_2.source)
    );
    
    // Extract architectural register addresses from control signals
    assign rs1_arch_0 = control_signal_internal_0[15:11];
    assign rs2_arch_0 = control_signal_internal_0[20:16];
    assign rd_arch_0 = control_signal_internal_0[25:21];
    
    assign rs1_arch_1 = control_signal_internal_1[15:11];
    assign rs2_arch_1 = control_signal_internal_1[20:16];
    assign rd_arch_1 = control_signal_internal_1[25:21];
    
    assign rs1_arch_2 = control_signal_internal_2[15:11];
    assign rs2_arch_2 = control_signal_internal_2[20:16];
    assign rd_arch_2 = control_signal_internal_2[25:21];
    
    // Determine if instruction writes to destination register
    assign rd_write_enable_0 = control_signal_internal_0[6]; // we bit from control word
    assign rd_write_enable_1 = control_signal_internal_1[6];
    assign rd_write_enable_2 = control_signal_internal_2[6];
    // Load Store
    assign load_store_0 = control_signal_internal_0[4] || (control_signal_internal_0[3] & ~control_signal_internal_0[6]); 
    assign load_store_1 = control_signal_internal_1[4] || (control_signal_internal_1[3] & ~control_signal_internal_1[6]);
    assign load_store_2 = control_signal_internal_2[4] || (control_signal_internal_2[3] & ~control_signal_internal_2[6]);
    
    assign branch_0 = branch_sel_internal_0 != 3'b000 & branch_sel_internal_0 != 3'b110;
    assign branch_1 = branch_sel_internal_1 != 3'b000 & branch_sel_internal_1 != 3'b110;
    assign branch_2 = branch_sel_internal_2 != 3'b000 & branch_sel_internal_2 != 3'b110;
    //==========================================================================
    // REGISTER ALIAS TABLE v2 (RAT) - RENAME LOGIC with BRAT v2
    //==========================================================================
    
    register_alias_table #(
        .ARCH_REGS(32),
        .PHYS_REGS(64),
        .ARCH_ADDR_WIDTH(ARCH_REG_ADDR_WIDTH),
        .PHYS_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),
        .ENTRIES(ENTRIES)
    ) rat_inst (
        .clk(clk),
        .reset(reset),
        .flush(1'b0),

        // Execute stage inputs (raw branch results - go into BRAT)
        .exec_branch_valid_i(exec_branch_valid_i),
        .exec_mispredicted_i(exec_mispredicted_i),
        .exec_rob_id_0_i(exec_rob_id_0_i),
        .exec_rob_id_1_i(exec_rob_id_1_i),
        .exec_rob_id_2_i(exec_rob_id_2_i),
        .exec_correct_pc_0_i(exec_correct_pc_0_i),
        .exec_correct_pc_1_i(exec_correct_pc_1_i),
        .exec_correct_pc_2_i(exec_correct_pc_2_i),
        .exec_pc_at_prediction_0_i(exec_pc_at_prediction_0_i),
        .exec_pc_at_prediction_1_i(exec_pc_at_prediction_1_i),
        .exec_pc_at_prediction_2_i(exec_pc_at_prediction_2_i),
        
        
        // Branch resolution outputs (in-order, from BRAT)
        .branch_resolved_o(branch_resolved_o),
        .branch_mispredicted_o(branch_mispredicted_o),
        .resolved_phys_reg_0_o(resolved_phys_reg_0_o),
        .resolved_phys_reg_1_o(resolved_phys_reg_1_o),
        .resolved_phys_reg_2_o(resolved_phys_reg_2_o),
        .correct_pc_0_o(correct_pc_0_o),
        .correct_pc_1_o(correct_pc_1_o),
        .correct_pc_2_o(correct_pc_2_o),
        .update_global_history_0_o(update_global_history_0_o),
        .update_global_history_1_o(update_global_history_1_o),
        .update_global_history_2_o(update_global_history_2_o),
        
        .is_jalr_0_o(is_jalr_0_o),
        .is_jalr_1_o(is_jalr_1_o),
        .is_jalr_2_o(is_jalr_2_o),
        .pc_at_prediction_0_o(pc_at_prediction_0_o),
        .pc_at_prediction_1_o(pc_at_prediction_1_o),
        .pc_at_prediction_2_o(pc_at_prediction_2_o),
        
        // Push inputs for is_jalr and pc_at_prediction (from decode)
        .push_is_jalr_0_i(branch_sel_internal_0 == 3'b111),  // JALR has branch_sel = 110
        .push_is_jalr_1_i(branch_sel_internal_1 == 3'b111),
        .push_is_jalr_2_i(branch_sel_internal_2 == 3'b111),

        // RAS checkpoint interface
        .push_ras_tos_i(push_ras_tos_i),
        .ras_restore_valid_o(ras_restore_valid_o),
        .ras_restore_tos_o(ras_restore_tos_o),
        
        // Decode interface - separated signals
        .rs1_arch_0(rs1_arch_0), .rs1_arch_1(rs1_arch_1), .rs1_arch_2(rs1_arch_2),
        .rs2_arch_0(rs2_arch_0), .rs2_arch_1(rs2_arch_1), .rs2_arch_2(rs2_arch_2),
        .rd_arch_0(rd_arch_0), .rd_arch_1(rd_arch_1), .rd_arch_2(rd_arch_2),
        .decode_valid(decode_valid_i),
        .rd_write_enable_0(rd_write_enable_0), .rd_write_enable_1(rd_write_enable_1), .rd_write_enable_2(rd_write_enable_2),
        .branch_0(branch_0), .branch_1(branch_1), .branch_2(branch_2),
        .global_history_0_i(global_history_0_i),
        .global_history_1_i(global_history_1_i),
        .global_history_2_i(global_history_2_i),
        
        // Rename outputs - separated signals
        .rs1_phys_0(rs1_phys_0), .rs1_phys_1(rs1_phys_1), .rs1_phys_2(rs1_phys_2),
        .rs2_phys_0(rs2_phys_0), .rs2_phys_1(rs2_phys_1), .rs2_phys_2(rs2_phys_2),
        .rd_phys_0(rd_phys_0),   .rd_phys_1(rd_phys_1),   .rd_phys_2(rd_phys_2),
        .alloc_tag_0(alloc_tag_0), .alloc_tag_1(alloc_tag_1), .alloc_tag_2(alloc_tag_2),
        .old_rd_phys_0(old_rd_phys_0), .old_rd_phys_1(old_rd_phys_1), .old_rd_phys_2(old_rd_phys_2),
        .rename_valid(rename_valid_internal),
        .rename_ready(rename_ready), // Indicates RAT can allocate physical registers

        // Commit interface (from ROB) - separated signals  
        .commit_valid(commit_valid_i),
        .commit_addr_0(commit_addr_0_i), 
        .commit_addr_1(commit_addr_1_i), 
        .commit_addr_2(commit_addr_2_i),
        .commit_rob_idx_0(commit_rob_idx_0),
        .commit_rob_idx_1(commit_rob_idx_1),
        .commit_rob_idx_2(commit_rob_idx_2),

        .load_store_0(load_store_0),
        .load_store_1(load_store_1),
        .load_store_2(load_store_2),
        .lsq_alloc_0_valid(lsq_alloc_0_valid),
        .lsq_alloc_1_valid(lsq_alloc_1_valid),
        .lsq_alloc_2_valid(lsq_alloc_2_valid),
        .lsq_alloc_ready(lsq_alloc_ready),
        .lsq_commit_0(lsq_commit_0),
        .lsq_commit_1(lsq_commit_1),
        .lsq_commit_2(lsq_commit_2),
        
        // Eager misprediction flush interface (for LSQ circular buffer)
        .lsq_flush_valid_i(lsq_flush_valid_i),
        .first_invalid_lsq_idx_i(first_invalid_lsq_idx_i)
    );
    
    //==========================================================================
    // IMMEDIATE VALUE EXTRACTION
    //==========================================================================
    
    // Extract immediate values from instructions (no muxing needed here)
    // Immediate values will be passed directly to dispatch stage
    
    //==========================================================================
    // PIPELINE CONTROL (SIMPLIFIED - no data dependencies)
    //==========================================================================
    
    // Ready signal indicates RAT can allocate physical registers and dispatch stage can accept
    logic [1:0] valid_rob_entry;
    logic [1:0] valid_lsq_entry;
    logic [1:0] max_available_entries;
    logic [1:0] dispatch_request;

    assign valid_rob_entry = rename_ready[0] + rename_ready[1] + rename_ready[2];
    assign valid_lsq_entry = lsq_alloc_ready[0] + lsq_alloc_ready[1] + lsq_alloc_ready[2];
    assign dispatch_request = issue_to_dispatch_0.dispatch_ready + issue_to_dispatch_1.dispatch_ready + issue_to_dispatch_2.dispatch_ready;
    assign max_available_entries = (valid_rob_entry < valid_lsq_entry) ? valid_rob_entry : valid_lsq_entry;

    // giving priority to pipe 0, then pipe 1, then pipe 2
    always_comb begin
        decode_ready_o = 3'b000;
        if(max_available_entries >= dispatch_request) begin
            decode_ready_o = {issue_to_dispatch_2.dispatch_ready, issue_to_dispatch_1.dispatch_ready, issue_to_dispatch_0.dispatch_ready};
        end else begin
            case (max_available_entries)
                2'b00: decode_ready_o = 3'b000;
                2'b01: begin
                    if(issue_to_dispatch_0.dispatch_ready)
                        decode_ready_o = 3'b001;
                    else if(issue_to_dispatch_1.dispatch_ready)
                        decode_ready_o = 3'b010;
                    else if(issue_to_dispatch_2.dispatch_ready)
                        decode_ready_o = 3'b100;
                    else
                        decode_ready_o = 3'b000;
                end
                2'b10: begin
                    decode_ready_o = 3'b011;
                end
                default: decode_ready_o = 3'b000;
            endcase
        end
    end
   
    //==========================================================================
    // ISSUE STAGE PIPELINE REGISTERS (CONTROL AND ADDRESSES ONLY)
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            decode_valid_reg <= #D 3'b000;
            pc_reg_0 <= #D {DATA_WIDTH{1'b0}};
            pc_reg_1 <= #D {DATA_WIDTH{1'b0}};
            pc_reg_2 <= #D {DATA_WIDTH{1'b0}};
            control_signal_reg_0 <= #D 26'h0;
            control_signal_reg_1 <= #D 26'h0;
            control_signal_reg_2 <= #D 26'h0;
            pc_prediction_reg_0 <= #D {DATA_WIDTH{1'b0}};
            pc_prediction_reg_1 <= #D {DATA_WIDTH{1'b0}};
            pc_prediction_reg_2 <= #D {DATA_WIDTH{1'b0}};
            branch_sel_reg_0 <= #D 3'b000;
            branch_sel_reg_1 <= #D 3'b000;
            branch_sel_reg_2 <= #D 3'b000;
            branch_prediction_reg_0 <= #D 1'b0;
            branch_prediction_reg_1 <= #D 1'b0;
            branch_prediction_reg_2 <= #D 1'b0;
            immediate_reg_0 <= #D {DATA_WIDTH{1'b0}};
            immediate_reg_1 <= #D {DATA_WIDTH{1'b0}};
            immediate_reg_2 <= #D {DATA_WIDTH{1'b0}};
            rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs1_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs1_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs1_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs2_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs2_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rs2_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            alloc_tag_reg_0 <= #D 3'b000;
            alloc_tag_reg_1 <= #D 3'b000;
            alloc_tag_reg_2 <= #D 3'b000;
            rd_arch_reg_0 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};
            rd_arch_reg_1 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};
            rd_arch_reg_2 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};

            lsq_alloc_0_valid_reg <= #D 1'b0;
            lsq_alloc_1_valid_reg <= #D 1'b0;
            lsq_alloc_2_valid_reg <= #D 1'b0;
        end else begin
            if (internal_flush) begin
                // Insert NOPs on flush for all channels
                decode_valid_reg <= #D 3'b000;
                pc_reg_0 <= #D {DATA_WIDTH{1'b0}};
                pc_reg_1 <= #D {DATA_WIDTH{1'b0}};
                pc_reg_2 <= #D {DATA_WIDTH{1'b0}};
                control_signal_reg_0 <= #D 26'h0;
                control_signal_reg_1 <= #D 26'h0;
                control_signal_reg_2 <= #D 26'h0;
                pc_prediction_reg_0 <= #D {DATA_WIDTH{1'b0}};
                pc_prediction_reg_1 <= #D {DATA_WIDTH{1'b0}};
                pc_prediction_reg_2 <= #D {DATA_WIDTH{1'b0}};
                branch_sel_reg_0 <= #D 3'b000;
                branch_sel_reg_1 <= #D 3'b000;
                branch_sel_reg_2 <= #D 3'b000;
                branch_prediction_reg_0 <= #D 1'b0;
                branch_prediction_reg_1 <= #D 1'b0;
                branch_prediction_reg_2 <= #D 1'b0;
                immediate_reg_0 <= #D {DATA_WIDTH{1'b0}};
                immediate_reg_1 <= #D {DATA_WIDTH{1'b0}};
                immediate_reg_2 <= #D {DATA_WIDTH{1'b0}};
                rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs1_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs1_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs1_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs2_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs2_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rs2_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                alloc_tag_reg_0 <= #D 3'b000;
                alloc_tag_reg_1 <= #D 3'b000;
                alloc_tag_reg_2 <= #D 3'b000;
                rd_arch_reg_0 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};
                rd_arch_reg_1 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};
                rd_arch_reg_2 <= #D {ARCH_REG_ADDR_WIDTH{1'b0}};

                lsq_alloc_0_valid_reg <= #D 1'b0;
                lsq_alloc_1_valid_reg <= #D 1'b0;
                lsq_alloc_2_valid_reg <= #D 1'b0;
            end else begin
                // Channel 0: Update only when dispatch_ready[0] is high
                if (issue_to_dispatch_0.dispatch_ready) begin
                
                    decode_valid_reg[0] <= #D decode_valid_i[0];
                    pc_reg_0 <= #D decode_valid_i[0] ? pc_i_0 : {DATA_WIDTH{1'b0}};
                    control_signal_reg_0 <= #D decode_valid_i[0] ? control_signal_internal_0 : 26'h0;
                    pc_prediction_reg_0 <= #D decode_valid_i[0] ? pc_value_at_prediction_i_0 : {DATA_WIDTH{1'b0}};
                    branch_sel_reg_0 <= #D decode_valid_i[0] ? branch_sel_internal_0 : 3'b000;
                    branch_prediction_reg_0 <= #D decode_valid_i[0] ? branch_prediction_i_0 : 1'b0;
                    immediate_reg_0 <= #D decode_valid_i[0] ? immediate_i_0 : {DATA_WIDTH{1'b0}};
                    rd_phys_reg_0 <= #D decode_valid_i[0] ? rd_phys_0 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs1_phys_reg_0 <= #D decode_valid_i[0] ? rs1_phys_0 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs2_phys_reg_0 <= #D decode_valid_i[0] ? rs2_phys_0 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    alloc_tag_reg_0 <= #D decode_valid_i[0] ? alloc_tag_0 : 3'b000;
                    rd_arch_reg_0 <= #D decode_valid_i[0] ? rd_arch_0 : {ARCH_REG_ADDR_WIDTH{1'b0}};
                    lsq_alloc_0_valid_reg <= #D decode_valid_i[0] ? lsq_alloc_0_valid : 1'b0;
                end
                else 
                    decode_valid_reg[0] <= #D 0;
                // If dispatch_ready[0] is 0, channel 0 registers maintain their values (no update)
                
                // Channel 1: Update only when dispatch_ready[1] is high
                if (issue_to_dispatch_1.dispatch_ready) begin
                    
                    decode_valid_reg[1] <= #D decode_valid_i[1];
                    pc_reg_1 <= #D decode_valid_i[1] ? pc_i_1 : {DATA_WIDTH{1'b0}};
                    control_signal_reg_1 <= #D decode_valid_i[1] ? control_signal_internal_1 : 26'h0;
                    pc_prediction_reg_1 <= #D decode_valid_i[1] ? pc_value_at_prediction_i_1 : {DATA_WIDTH{1'b0}};
                    branch_sel_reg_1 <= #D decode_valid_i[1] ? branch_sel_internal_1 : 3'b000;
                    branch_prediction_reg_1 <= #D decode_valid_i[1] ? branch_prediction_i_1 : 1'b0;
                    immediate_reg_1 <= #D decode_valid_i[1] ? immediate_i_1 : {DATA_WIDTH{1'b0}};
                    rd_phys_reg_1 <= #D decode_valid_i[1] ? rd_phys_1 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs1_phys_reg_1 <= #D decode_valid_i[1] ? rs1_phys_1 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs2_phys_reg_1 <= #D decode_valid_i[1] ? rs2_phys_1 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    alloc_tag_reg_1 <= #D decode_valid_i[1] ? alloc_tag_1 : 3'b000;
                    rd_arch_reg_1 <= #D decode_valid_i[1] ? rd_arch_1 : {ARCH_REG_ADDR_WIDTH{1'b0}};
                    lsq_alloc_1_valid_reg <= #D decode_valid_i[1] ? lsq_alloc_1_valid : 1'b0;
                end
                else 
                    decode_valid_reg[1] <= #D 0;
                // If dispatch_ready[1] is 0, channel 1 registers maintain their values (no update)
                
                // Channel 2: Update only when dispatch_ready[2] is high
                if (issue_to_dispatch_2.dispatch_ready) begin
                   
                    decode_valid_reg[2] <= #D decode_valid_i[2];
                    pc_reg_2 <= #D decode_valid_i[2] ? pc_i_2 : {DATA_WIDTH{1'b0}};
                    control_signal_reg_2 <= #D decode_valid_i[2] ? control_signal_internal_2 : 26'h0;
                    pc_prediction_reg_2 <= #D decode_valid_i[2] ? pc_value_at_prediction_i_2 : {DATA_WIDTH{1'b0}};
                    branch_sel_reg_2 <= #D decode_valid_i[2] ? branch_sel_internal_2 : 3'b000;
                    branch_prediction_reg_2 <= #D decode_valid_i[2] ? branch_prediction_i_2 : 1'b0;
                    immediate_reg_2 <= #D decode_valid_i[2] ? immediate_i_2 : {DATA_WIDTH{1'b0}};
                    rd_phys_reg_2 <= #D decode_valid_i[2] ? rd_phys_2 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs1_phys_reg_2 <= #D decode_valid_i[2] ? rs1_phys_2 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    rs2_phys_reg_2 <= #D decode_valid_i[2] ? rs2_phys_2 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                    alloc_tag_reg_2 <= #D decode_valid_i[2] ? alloc_tag_2 : 3'b000;
                    rd_arch_reg_2 <= #D decode_valid_i[2] ? rd_arch_2 : {ARCH_REG_ADDR_WIDTH{1'b0}};
                    lsq_alloc_2_valid_reg <= #D decode_valid_i[2] ? lsq_alloc_2_valid : 1'b0;
                end
                else 
                    decode_valid_reg[2] <= #D 0;
                // If dispatch_ready[2] is 0, channel 2 registers maintain their values (no update)
            end
        end
    end
    
    //==========================================================================
    // RESERVATION STATION INTERFACE CONNECTIONS
    //==========================================================================
    
    //==========================================================================
    // OUTPUT ASSIGNMENTS TO NEW ISSUE_TO_DISPATCH INTERFACE
    //==========================================================================
    
    // Issue to Dispatch Channel 0
    assign issue_to_dispatch_0.dispatch_valid = !internal_flush & decode_valid_reg[0];
    assign issue_to_dispatch_0.control_signals = control_signal_reg_0[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_0.pc = pc_reg_0;
    assign issue_to_dispatch_0.operand_a_phys_addr = rs1_phys_reg_0; // Use registered physical address
    assign issue_to_dispatch_0.operand_b_phys_addr = rs2_phys_reg_0; // Use registered physical address
    assign issue_to_dispatch_0.immediate_value = immediate_reg_0; // Immediate value for dispatch stage
    assign issue_to_dispatch_0.rd_phys_addr = rd_phys_reg_0;
    assign issue_to_dispatch_0.pc_value_at_prediction = pc_prediction_reg_0;
    assign issue_to_dispatch_0.branch_sel = branch_sel_reg_0;
    assign issue_to_dispatch_0.branch_prediction = branch_prediction_reg_0;
    assign issue_to_dispatch_0.rd_arch_addr = rd_arch_reg_0;
    assign issue_to_dispatch_0.alloc_tag = alloc_tag_reg_0;
    assign issue_to_dispatch_0.lsq_alloc_valid = lsq_alloc_0_valid_reg;
    // Issue to Dispatch Channel 1
    assign issue_to_dispatch_1.dispatch_valid = !internal_flush & decode_valid_reg[1];
    assign issue_to_dispatch_1.control_signals = control_signal_reg_1[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_1.pc = pc_reg_1;
    assign issue_to_dispatch_1.operand_a_phys_addr = rs1_phys_reg_1; // Use registered physical address
    assign issue_to_dispatch_1.operand_b_phys_addr = rs2_phys_reg_1; // Use registered physical address
    assign issue_to_dispatch_1.immediate_value = immediate_reg_1; // Immediate value for dispatch stage
    assign issue_to_dispatch_1.rd_phys_addr = rd_phys_reg_1;
    assign issue_to_dispatch_1.pc_value_at_prediction = pc_prediction_reg_1;
    assign issue_to_dispatch_1.branch_sel = branch_sel_reg_1;
    assign issue_to_dispatch_1.branch_prediction = branch_prediction_reg_1;
    assign issue_to_dispatch_1.rd_arch_addr = rd_arch_reg_1;
    assign issue_to_dispatch_1.alloc_tag = alloc_tag_reg_1;
    assign issue_to_dispatch_1.lsq_alloc_valid = lsq_alloc_1_valid_reg;
    // Issue to Dispatch Channel 2
    assign issue_to_dispatch_2.dispatch_valid = !internal_flush & decode_valid_reg[2];
    assign issue_to_dispatch_2.control_signals = control_signal_reg_2[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_2.pc = pc_reg_2;
    assign issue_to_dispatch_2.operand_a_phys_addr = rs1_phys_reg_2; // Use registered physical address
    assign issue_to_dispatch_2.operand_b_phys_addr = rs2_phys_reg_2; // Use registered physical address
    assign issue_to_dispatch_2.immediate_value = immediate_reg_2; // Immediate value for dispatch stage
    assign issue_to_dispatch_2.rd_phys_addr = rd_phys_reg_2;
    assign issue_to_dispatch_2.pc_value_at_prediction = pc_prediction_reg_2;
    assign issue_to_dispatch_2.branch_sel = branch_sel_reg_2;
    assign issue_to_dispatch_2.branch_prediction = branch_prediction_reg_2;
    assign issue_to_dispatch_2.rd_arch_addr = rd_arch_reg_2;
    assign issue_to_dispatch_2.alloc_tag = alloc_tag_reg_2;
    assign issue_to_dispatch_2.lsq_alloc_valid = lsq_alloc_2_valid_reg;
    //==========================================================================
    // DUMMY TRACER INTERFACES (for future tracing support)
    //==========================================================================
    
   `ifndef SYNTHESIS
    assign tracer_in_0.valid = decode_valid_i[0];
    assign tracer_in_1.valid = decode_valid_i[1];
    assign tracer_in_2.valid = decode_valid_i[2];   

    assign tracer_in_0.instr = instruction_i_0;
    assign tracer_in_1.instr = instruction_i_1;
    assign tracer_in_2.instr = instruction_i_2;

    assign tracer_in_0.pc = pc_value_at_prediction_i_0; // todo check
    assign tracer_in_1.pc = pc_value_at_prediction_i_1; 
    assign tracer_in_2.pc = pc_value_at_prediction_i_2;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset tracer interface
                tracer_0.valid     <= #D 0;
                tracer_0.pc        <= #D 0;
                tracer_0.instr     <= #D 32'h00000013; // NOP instruction
                tracer_0.reg_addr  <= #D 0;
                tracer_0.reg_data  <= #D 0;
                tracer_0.is_load   <= #D 0;
                tracer_0.is_store  <= #D 0;
                tracer_0.is_float  <= #D 0;
                tracer_0.mem_size  <= #D 2'b00; // No memory operation
                tracer_0.mem_addr  <= #D 32'b0; // No memory address
                tracer_0.mem_data  <= #D 32'b0; // No memory data
                tracer_0.fpu_flags <= #D 32'b0; // No FPU flags
        end else begin  
            if(internal_flush | !issue_to_dispatch_0.dispatch_ready && decode_valid_i[0]) begin
                // Reset tracer interface on flush or bubble
                tracer_0.valid     <= #D 0;
                //tracer_if_o.pc        <= #D 0;
                tracer_0.instr     <= #D 32'h00000013; // NOP instruction
                tracer_0.reg_addr  <= #D 0;
                tracer_0.reg_data  <= #D 0;
                tracer_0.is_load   <= #D 0;
                tracer_0.is_store  <= #D 0;
                tracer_0.is_float  <= #D 0;
                tracer_0.mem_size  <= #D 2'b00; // No memory operation
                tracer_0.mem_addr  <= #D 32'b0; // No memory address
                tracer_0.mem_data  <= #D 32'b0; // No memory data
                tracer_0.fpu_flags <= #D 32'b0; // No FPU flags
            end else begin
                // Update tracer interface
                if(tracer_internal_0.valid) begin
                    tracer_0.valid    <= #D 1;
                    tracer_0.pc       <= #D tracer_internal_0.pc;
                    tracer_0.instr    <= #D tracer_internal_0.instr;
                    tracer_0.reg_addr <= #D tracer_internal_0.reg_addr;
                    tracer_0.is_load  <= #D tracer_internal_0.is_load;
                    tracer_0.is_store <= #D tracer_internal_0.is_store;
                    tracer_0.is_float <= #D tracer_internal_0.is_float;
                    tracer_0.mem_size <= #D tracer_internal_0.mem_size;
                    tracer_0.reg_data <= #D 0; 
                    tracer_0.mem_addr <= #D 0;
                    tracer_0.mem_data <= #D 0;
                    tracer_0.fpu_flags <= #D tracer_internal_0.fpu_flags;
                end
                else 
                    tracer_0.valid    <= #D 0;
            end
        end
    end 

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset tracer interface
                tracer_1.valid     <= #D 0;
                tracer_1.pc        <= #D 0;
                tracer_1.instr     <= #D 32'h00000013; // NOP instruction
                tracer_1.reg_addr  <= #D 0;
                tracer_1.reg_data  <= #D 0;
                tracer_1.is_load   <= #D 0;
                tracer_1.is_store  <= #D 0;
                tracer_1.is_float  <= #D 0;
                tracer_1.mem_size  <= #D 2'b00; // No memory operation
                tracer_1.mem_addr  <= #D 32'b0; // No memory address
                tracer_1.mem_data  <= #D 32'b0; // No memory data
                tracer_1.fpu_flags <= #D 32'b0; // No FPU flags
        end else begin  
            if(internal_flush | !issue_to_dispatch_1.dispatch_ready && decode_valid_i[1]) begin
                // Reset tracer interface on flush or bubble
                tracer_1.valid     <= #D 0;
                //tracer_if_o.pc        <= #D 0;
                tracer_1.instr     <= #D 32'h00000013; // NOP instruction
                tracer_1.reg_addr  <= #D 0;
                tracer_1.reg_data  <= #D 0;
                tracer_1.is_load   <= #D 0;
                tracer_1.is_store  <= #D 0;
                tracer_1.is_float  <= #D 0;
                tracer_1.mem_size  <= #D 2'b00; // No memory operation
                tracer_1.mem_addr  <= #D 32'b0; // No memory address
                tracer_1.mem_data  <= #D 32'b0; // No memory data
                tracer_1.fpu_flags <= #D 32'b0; // No FPU flags
            end else begin
                // Update tracer interface
                if(tracer_internal_1.valid) begin
                    tracer_1.valid    <= #D 1;
                    tracer_1.pc       <= #D tracer_internal_1.pc;
                    tracer_1.instr    <= #D tracer_internal_1.instr;
                    tracer_1.reg_addr <= #D tracer_internal_1.reg_addr;
                    tracer_1.is_load  <= #D tracer_internal_1.is_load;
                    tracer_1.is_store <= #D tracer_internal_1.is_store;
                    tracer_1.is_float <= #D tracer_internal_1.is_float;
                    tracer_1.mem_size <= #D tracer_internal_1.mem_size;
                    tracer_1.reg_data <= #D 0; 
                    tracer_1.mem_addr <= #D 0;
                    tracer_1.mem_data <= #D 0;
                    tracer_1.fpu_flags <= #D tracer_internal_1.fpu_flags;
                end
                else 
                    tracer_1.valid    <= #D 0;
            end
        end
    end

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset tracer interface
                tracer_2.valid     <= #D 0;
                tracer_2.pc        <= #D 0;
                tracer_2.instr     <= #D 32'h00000013; // NOP instruction
                tracer_2.reg_addr  <= #D 0;
                tracer_2.reg_data  <= #D 0;
                tracer_2.is_load   <= #D 0;
                tracer_2.is_store  <= #D 0;
                tracer_2.is_float  <= #D 0;
                tracer_2.mem_size  <= #D 2'b00; // No memory operation
                tracer_2.mem_addr  <= #D 32'b0; // No memory address
                tracer_2.mem_data  <= #D 32'b0; // No memory data
                tracer_2.fpu_flags <= #D 32'b0; // No FPU flags
        end else begin  
            if(internal_flush| !issue_to_dispatch_2.dispatch_ready && decode_valid_i[2]) begin
                // Reset tracer interface on flush or bubble
                tracer_2.valid     <= #D 0;
                //tracer_if_o.pc        <= #D 0;
                tracer_2.instr     <= #D 32'h00000013; // NOP instruction
                tracer_2.reg_addr  <= #D 0;
                tracer_2.reg_data  <= #D 0;
                tracer_2.is_load   <= #D 0;
                tracer_2.is_store  <= #D 0;
                tracer_2.is_float  <= #D 0;
                tracer_2.mem_size  <= #D 2'b00; // No memory operation
                tracer_2.mem_addr  <= #D 32'b0; // No memory address
                tracer_2.mem_data  <= #D 32'b0; // No memory data
                tracer_2.fpu_flags <= #D 32'b0; // No FPU flags
            end else begin
                // Update tracer interface
                if(tracer_internal_2.valid) begin
                    tracer_2.valid    <= #D 1;
                    tracer_2.pc       <= #D tracer_internal_2.pc;
                    tracer_2.instr    <= #D tracer_internal_2.instr;
                    tracer_2.reg_addr <= #D tracer_internal_2.reg_addr;
                    tracer_2.is_load  <= #D tracer_internal_2.is_load;
                    tracer_2.is_store <= #D tracer_internal_2.is_store;
                    tracer_2.is_float <= #D tracer_internal_2.is_float;
                    tracer_2.mem_size <= #D tracer_internal_2.mem_size;
                    tracer_2.reg_data <= #D 0; 
                    tracer_2.mem_addr <= #D 0;
                    tracer_2.mem_data <= #D 0;
                    tracer_2.fpu_flags <= #D tracer_internal_2.fpu_flags;
                end
                else 
                    tracer_2.valid    <= #D 0;
            end
        end
    end

   `endif
    
endmodule
