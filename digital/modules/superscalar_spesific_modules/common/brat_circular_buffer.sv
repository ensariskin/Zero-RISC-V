`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: brat_circular_buffer
//
// Description:
//     Enhanced Branch Register Alias Table (BRAT) Circular Buffer
//     Now acts as a Branch Resolution Buffer with execute result storage
//     Provides in-order branch resolution outputs with combinational bypass
//
// Features:
//     - Circular FIFO with head/tail pointers
//     - 3-way parallel push operations (from decode)
//     - 3-way parallel execute result write (from execute stage)
//     - 3-way parallel commit updates (keeps snapshots in sync with RF)
//     - Combinational bypass for same-cycle resolution
//     - In-order branch resolution outputs (oldest-first)
//     - Peek interface for oldest 3 entries
//     - Restore interface with index selection
//////////////////////////////////////////////////////////////////////////////////

module brat_circular_buffer #(
        parameter BUFFER_DEPTH = 16,
        parameter ARCH_REGS = 32,
        parameter PHYS_ADDR_WIDTH = 6,
        parameter DATA_WIDTH = 32,
        parameter RAS_PTR_WIDTH = 3,
        parameter ENTRIES = 32,                        // Number of predictor entries
        parameter INDEX_WIDTH = $clog2(ENTRIES)       // Auto-calculated index width
    )(
        input logic clk,
        input logic rst_n,
        input logic secure_mode,

        //==========================================================================
        // Push interface (3-way parallel) - from decode/rename stage
        //==========================================================================
        input logic push_en_0,
        input logic push_en_1,
        input logic push_en_2,
        input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_0 [ARCH_REGS-1:0],
        input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_1 [ARCH_REGS-1:0],
        input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_2 [ARCH_REGS-1:0],
        input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_0,  // ROB ID (rd_phys[4:0])
        input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_1,
        input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_2,
        input logic [INDEX_WIDTH+2:0] push_global_history_0, // Global history and prediction
        input logic [INDEX_WIDTH+2:0] push_global_history_1,
        input logic [INDEX_WIDTH+2:0] push_global_history_2,

        input logic push_is_jalr_0,  // 0=branch, 1=JALR
        input logic push_is_jalr_1,
        input logic push_is_jalr_2,

        input logic [RAS_PTR_WIDTH-1:0] push_ras_tos_0,
        input logic [RAS_PTR_WIDTH-1:0] push_ras_tos_1,
        input logic [RAS_PTR_WIDTH-1:0] push_ras_tos_2,

        //==========================================================================
        // Commit interface (3-way parallel) - from ROB commit
        // Updates ALL snapshots to reflect committed values (ROB -> RF transition)
        //==========================================================================
        input logic commit_valid_0,
        input logic commit_valid_1,
        input logic commit_valid_2,
        input logic [4:0] commit_arch_addr_0,  // Architectural register being committed
        input logic [4:0] commit_arch_addr_1,
        input logic [4:0] commit_arch_addr_2,
        input logic [4:0] commit_rob_idx_0,    // ROB index that was holding the value
        input logic [4:0] commit_rob_idx_1,
        input logic [4:0] commit_rob_idx_2,

        //==========================================================================
        // Execute result write interface (3-way parallel) - from execute stage
        //==========================================================================
        input logic exec_valid_0,
        input logic exec_valid_1,
        input logic exec_valid_2,
        input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_0,  // ROB ID to match
        input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_1,
        input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_2,
        input logic exec_mispredicted_0,
        input logic exec_mispredicted_1,
        input logic exec_mispredicted_2,
        input logic [DATA_WIDTH-1:0] exec_correct_pc_0,
        input logic [DATA_WIDTH-1:0] exec_correct_pc_1,
        input logic [DATA_WIDTH-1:0] exec_correct_pc_2,
        input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_0,  // PC at prediction time
        input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_1,
        input logic [DATA_WIDTH-1:0] exec_pc_at_prediction_2,


        //==========================================================================
        // Branch resolution outputs (in-order, oldest-first)
        // These go to all other modules (ROB, RS, LSQ, Fetch, RAT)
        //==========================================================================
        output logic branch_resolved_o_0,     // Oldest branch resolved this cycle
        output logic branch_resolved_o_1,     // 2nd oldest resolved (only if 0 is resolved)
        output logic branch_resolved_o_2,     // 3rd oldest resolved (only if 0,1 are resolved)
        output logic branch_mispredicted_o_0,
        output logic branch_mispredicted_o_1,
        output logic branch_mispredicted_o_2,
        output logic [DATA_WIDTH-1:0] correct_pc_o_0,
        output logic [DATA_WIDTH-1:0] correct_pc_o_1,
        output logic [DATA_WIDTH-1:0] correct_pc_o_2,
        output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_o_0,  // ROB ID of resolved branch
        output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_o_1,
        output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_o_2,
        output logic [INDEX_WIDTH+2:0] global_history_o_0, // Global history at resolution time
        output logic [INDEX_WIDTH+2:0] global_history_o_1,
        output logic [INDEX_WIDTH+2:0] global_history_o_2,

        output logic is_jalr_o_0,             // Is resolved branch a JALR?
        output logic is_jalr_o_1,
        output logic is_jalr_o_2,
        output logic [DATA_WIDTH-1:0] pc_at_prediction_o_0,  // PC at prediction time
        output logic [DATA_WIDTH-1:0] pc_at_prediction_o_1,
        output logic [DATA_WIDTH-1:0] pc_at_prediction_o_2,

        //==========================================================================
        // Restore interface - indexed snapshot retrieval + buffer flush
        //==========================================================================
        input logic restore_en,
        input logic [1:0] restore_idx,  // 0=oldest, 1=2nd oldest, 2=3rd oldest
        output logic [PHYS_ADDR_WIDTH-1:0] restore_rat_snapshot [ARCH_REGS-1:0],

        //==========================================================================
        // RAS restore interface
        //==========================================================================
        output logic ras_restore_valid_o,
        output logic [RAS_PTR_WIDTH-1:0] ras_restore_tos_o,

        //==========================================================================
        // Peek interface - non-destructive read of oldest 3 branches
        //==========================================================================
        output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_0,
        output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_1,
        output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_2,
        output logic peek_valid_0,
        output logic peek_valid_1,
        output logic peek_valid_2,

        //==========================================================================
        // Status
        //==========================================================================
        output logic buffer_empty,
        output logic buffer_full,
        output logic [$clog2(BUFFER_DEPTH):0] buffer_count,

        //==========================================================================
        // TMR Error Outputs
        //==========================================================================
        output logic head_ptr_fatal_o,
        output logic tail_ptr_fatal_o
    );

    localparam PTR_WIDTH = $clog2(BUFFER_DEPTH) + 1; // Extra bit for full/empty detection
    localparam IDX_WIDTH = $clog2(BUFFER_DEPTH);
    localparam D = 1;

    //==========================================================================
    // Storage - Extended entry structure
    //==========================================================================

    // Branch physical registers (ROB IDs)
    logic [PHYS_ADDR_WIDTH-1:0] buffer_phys [BUFFER_DEPTH-1:0];
    // RAT snapshots
    logic [PHYS_ADDR_WIDTH-1:0] rat_snapshot_mem [BUFFER_DEPTH-1:0][ARCH_REGS-1:0];
    // Resolution status (new!)
    logic [BUFFER_DEPTH-1:0] resolved_mem;
    logic [BUFFER_DEPTH-1:0] mispredicted_mem;
    logic [DATA_WIDTH-1:0] correct_pc_mem [BUFFER_DEPTH-1:0];
    // Is JALR flag storage
    logic [BUFFER_DEPTH-1:0] is_jalr_mem;
    // PC at prediction time storage
    logic [DATA_WIDTH-1:0] pc_at_prediction_mem [BUFFER_DEPTH-1:0];
    // Global history storage
    logic [INDEX_WIDTH+2:0] global_history_mem [BUFFER_DEPTH-1:0];
    // RAS TOS storage
    logic [RAS_PTR_WIDTH-1:0] ras_tos_mem [BUFFER_DEPTH-1:0];

    //==========================================================================
    // Pointers - TMR Protected
    //==========================================================================
    // TMR: Triplicated pointer registers
    logic [PTR_WIDTH-1:0] head_ptr_0, head_ptr_1, head_ptr_2;
    logic [PTR_WIDTH-1:0] tail_ptr_0, tail_ptr_1, tail_ptr_2;

    // TMR: Voted outputs (used in logic)
    logic [PTR_WIDTH-1:0] head_ptr;
    logic [PTR_WIDTH-1:0] tail_ptr;

    // TMR: Error signals from voters
    logic head_ptr_mismatch;
    logic head_ptr_err_0, head_ptr_err_1, head_ptr_err_2;
    logic tail_ptr_mismatch;
    logic tail_ptr_err_0, tail_ptr_err_1, tail_ptr_err_2;

    // TMR: Voter instances
    tmr_voter #(.DATA_WIDTH(PTR_WIDTH)) head_ptr_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (head_ptr_0),
        .data_1_i           (head_ptr_1),
        .data_2_i           (head_ptr_2),
        .data_o             (head_ptr),
        .mismatch_detected_o(head_ptr_mismatch),
        .error_0_o          (head_ptr_err_0),
        .error_1_o          (head_ptr_err_1),
        .error_2_o          (head_ptr_err_2),
        .fatal_error_o      (head_ptr_fatal_o)
    );

    tmr_voter #(.DATA_WIDTH(PTR_WIDTH)) tail_ptr_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (tail_ptr_0),
        .data_1_i           (tail_ptr_1),
        .data_2_i           (tail_ptr_2),
        .data_o             (tail_ptr),
        .mismatch_detected_o(tail_ptr_mismatch),
        .error_0_o          (tail_ptr_err_0),
        .error_1_o          (tail_ptr_err_1),
        .error_2_o          (tail_ptr_err_2),
        .fatal_error_o      (tail_ptr_fatal_o)
    );

    // Internal signals
    logic [PTR_WIDTH-1:0] next_head_ptr;
    logic [PTR_WIDTH-1:0] next_tail_ptr;
    logic [2:0] push_count;
    logic [2:0] pop_count;

    //==========================================================================
    // Peek indices (into buffer arrays)
    //==========================================================================
    logic [IDX_WIDTH-1:0] peek_idx_0, peek_idx_1, peek_idx_2;

    //==========================================================================
    // Buffer Status Logic
    //==========================================================================

    assign buffer_empty = (head_ptr == tail_ptr);
    assign buffer_full = (head_ptr[IDX_WIDTH-1:0] == tail_ptr[IDX_WIDTH-1:0]) &&
        (head_ptr[PTR_WIDTH-1] != tail_ptr[PTR_WIDTH-1]);

    // Calculate buffer occupancy
    always_comb begin
        if (tail_ptr >= head_ptr) begin
            buffer_count = tail_ptr - head_ptr;
        end else begin
            buffer_count = BUFFER_DEPTH - head_ptr[IDX_WIDTH-1:0] + tail_ptr[IDX_WIDTH-1:0];
        end
    end

    //==========================================================================
    // Push/Pop Count Logic
    //==========================================================================

    always_comb begin
        push_count = {2'b00, push_en_0} + {2'b00, push_en_1} + {2'b00, push_en_2};
        pop_count = {2'b00, branch_resolved_o_0 & !branch_mispredicted_o_0} +
            {2'b00, branch_resolved_o_1 & !branch_mispredicted_o_1} +
            {2'b00, branch_resolved_o_2 & !branch_mispredicted_o_2};
    end

    //==========================================================================
    // Peek Interface - Calculate indices for oldest 3 entries
    //==========================================================================

    always_comb begin
        // Peek index 0: head (oldest)
        peek_idx_0 = head_ptr[IDX_WIDTH-1:0];
        peek_valid_0 = (buffer_count >= 1);
        peek_branch_phys_0 = buffer_phys[peek_idx_0];

        // Peek index 1: head + 1 (second oldest)
        peek_idx_1 = (head_ptr[IDX_WIDTH-1:0] + 1'b1);
        peek_valid_1 = (buffer_count >= 2);
        peek_branch_phys_1 = buffer_phys[peek_idx_1];

        // Peek index 2: head + 2 (third oldest)
        peek_idx_2 = (head_ptr[IDX_WIDTH-1:0] + 2'd2);
        peek_valid_2 = (buffer_count >= 3);
        peek_branch_phys_2 = buffer_phys[peek_idx_2];
    end

    //==========================================================================
    // Execute Result Matching - Find which entries match incoming ROB IDs
    //==========================================================================

    // Match signals for each execute result with each buffer entry
    logic [BUFFER_DEPTH-1:0] exec_0_match, exec_1_match, exec_2_match;

    // Generate match signals for all entries
    genvar i;
    generate
        for (i = 0; i < BUFFER_DEPTH; i++) begin : gen_match
            assign exec_0_match[i] = exec_valid_0 && (buffer_phys[i] == exec_rob_id_0);
            assign exec_1_match[i] = exec_valid_1 && (buffer_phys[i] == exec_rob_id_1);
            assign exec_2_match[i] = exec_valid_2 && (buffer_phys[i] == exec_rob_id_2);
        end
    endgenerate

    // Specific matches for peek positions (combinational bypass)
    logic exec_0_match_peek_0, exec_0_match_peek_1, exec_0_match_peek_2;
    logic exec_1_match_peek_0, exec_1_match_peek_1, exec_1_match_peek_2;
    logic exec_2_match_peek_0, exec_2_match_peek_1, exec_2_match_peek_2;

    assign exec_0_match_peek_0 = exec_valid_0 && peek_valid_0 && (peek_branch_phys_0 == exec_rob_id_0);
    assign exec_0_match_peek_1 = exec_valid_0 && peek_valid_1 && (peek_branch_phys_1 == exec_rob_id_0);
    assign exec_0_match_peek_2 = exec_valid_0 && peek_valid_2 && (peek_branch_phys_2 == exec_rob_id_0);

    assign exec_1_match_peek_0 = exec_valid_1 && peek_valid_0 && (peek_branch_phys_0 == exec_rob_id_1);
    assign exec_1_match_peek_1 = exec_valid_1 && peek_valid_1 && (peek_branch_phys_1 == exec_rob_id_1);
    assign exec_1_match_peek_2 = exec_valid_1 && peek_valid_2 && (peek_branch_phys_2 == exec_rob_id_1);

    assign exec_2_match_peek_0 = exec_valid_2 && peek_valid_0 && (peek_branch_phys_0 == exec_rob_id_2);
    assign exec_2_match_peek_1 = exec_valid_2 && peek_valid_1 && (peek_branch_phys_1 == exec_rob_id_2);
    assign exec_2_match_peek_2 = exec_valid_2 && peek_valid_2 && (peek_branch_phys_2 == exec_rob_id_2);

    //==========================================================================
    // Combinational Bypass - Effective resolved/mispredicted for peek positions
    //==========================================================================

    // Effective resolved status (stored OR bypass)
    logic eff_resolved_0, eff_resolved_1, eff_resolved_2;
    logic eff_mispredicted_0, eff_mispredicted_1, eff_mispredicted_2;
    logic [DATA_WIDTH-1:0] eff_correct_pc_0, eff_correct_pc_1, eff_correct_pc_2;
    logic [DATA_WIDTH-1:0] eff_pc_at_prediction_0, eff_pc_at_prediction_1, eff_pc_at_prediction_2;

    always_comb begin
        // Peek 0 (oldest): check stored OR any exec match
        eff_resolved_0 = resolved_mem[peek_idx_0] ||
            exec_0_match_peek_0 || exec_1_match_peek_0 || exec_2_match_peek_0;

        // Misprediction: prioritize exec bypass, then stored
        if (exec_0_match_peek_0) begin
            eff_mispredicted_0 = exec_mispredicted_0;
            eff_correct_pc_0 = exec_correct_pc_0;
            eff_pc_at_prediction_0 = exec_pc_at_prediction_0;
        end else if (exec_1_match_peek_0) begin
            eff_mispredicted_0 = exec_mispredicted_1;
            eff_correct_pc_0 = exec_correct_pc_1;
            eff_pc_at_prediction_0 = exec_pc_at_prediction_1;
        end else if (exec_2_match_peek_0) begin
            eff_mispredicted_0 = exec_mispredicted_2;
            eff_correct_pc_0 = exec_correct_pc_2;
            eff_pc_at_prediction_0 = exec_pc_at_prediction_2;
        end else begin
            eff_mispredicted_0 = mispredicted_mem[peek_idx_0];
            eff_correct_pc_0 = correct_pc_mem[peek_idx_0];
            eff_pc_at_prediction_0 = pc_at_prediction_mem[peek_idx_0];
        end

        // Peek 1 (2nd oldest)
        eff_resolved_1 = resolved_mem[peek_idx_1] ||
            exec_0_match_peek_1 || exec_1_match_peek_1 || exec_2_match_peek_1;

        if (exec_0_match_peek_1) begin
            eff_mispredicted_1 = exec_mispredicted_0;
            eff_correct_pc_1 = exec_correct_pc_0;
            eff_pc_at_prediction_1 = exec_pc_at_prediction_0;
        end else if (exec_1_match_peek_1) begin
            eff_mispredicted_1 = exec_mispredicted_1;
            eff_correct_pc_1 = exec_correct_pc_1;
            eff_pc_at_prediction_1 = exec_pc_at_prediction_1;
        end else if (exec_2_match_peek_1) begin
            eff_mispredicted_1 = exec_mispredicted_2;
            eff_correct_pc_1 = exec_correct_pc_2;
            eff_pc_at_prediction_1 = exec_pc_at_prediction_2;
        end else begin
            eff_mispredicted_1 = mispredicted_mem[peek_idx_1];
            eff_correct_pc_1 = correct_pc_mem[peek_idx_1];
            eff_pc_at_prediction_1 = pc_at_prediction_mem[peek_idx_1];
        end

        // Peek 2 (3rd oldest)
        eff_resolved_2 = resolved_mem[peek_idx_2] ||
            exec_0_match_peek_2 || exec_1_match_peek_2 || exec_2_match_peek_2;

        if (exec_0_match_peek_2) begin
            eff_mispredicted_2 = exec_mispredicted_0;
            eff_correct_pc_2 = exec_correct_pc_0;
            eff_pc_at_prediction_2 = exec_pc_at_prediction_0;
        end else if (exec_1_match_peek_2) begin
            eff_mispredicted_2 = exec_mispredicted_1;
            eff_correct_pc_2 = exec_correct_pc_1;
            eff_pc_at_prediction_2 = exec_pc_at_prediction_1;
        end else if (exec_2_match_peek_2) begin
            eff_mispredicted_2 = exec_mispredicted_2;
            eff_correct_pc_2 = exec_correct_pc_2;
            eff_pc_at_prediction_2 = exec_pc_at_prediction_2;
        end else begin
            eff_mispredicted_2 = mispredicted_mem[peek_idx_2];
            eff_correct_pc_2 = correct_pc_mem[peek_idx_2];
            eff_pc_at_prediction_2 = pc_at_prediction_mem[peek_idx_2];
        end
    end

    //==========================================================================
    // In-Order Branch Resolution Outputs
    // Similar to ROB commit logic: 1 valid if 0 resolved, 2 valid if 0&1 resolved
    //==========================================================================

    always_comb begin
        // Default outputs
        branch_resolved_o_0 = 1'b0;
        branch_resolved_o_1 = 1'b0;
        branch_resolved_o_2 = 1'b0;
        branch_mispredicted_o_0 = 1'b0;
        branch_mispredicted_o_1 = 1'b0;
        branch_mispredicted_o_2 = 1'b0;
        correct_pc_o_0 = '0;
        correct_pc_o_1 = '0;
        correct_pc_o_2 = '0;
        global_history_o_0 = '0;
        global_history_o_1 = '0;
        global_history_o_2 = '0;
        resolved_phys_reg_o_0 = '0;
        resolved_phys_reg_o_1 = '0;
        resolved_phys_reg_o_2 = '0;
        is_jalr_o_0 = 1'b0;
        is_jalr_o_1 = 1'b0;
        is_jalr_o_2 = 1'b0;
        pc_at_prediction_o_0 = '0;
        pc_at_prediction_o_1 = '0;
        pc_at_prediction_o_2 = '0;

        // Oldest (peek_0) - always check if valid and resolved
        if (peek_valid_0 && eff_resolved_0) begin
            branch_resolved_o_0 = 1'b1;
            branch_mispredicted_o_0 = eff_mispredicted_0;
            correct_pc_o_0 = eff_correct_pc_0;
            resolved_phys_reg_o_0 = peek_branch_phys_0;
            is_jalr_o_0 = is_jalr_mem[peek_idx_0];
            pc_at_prediction_o_0 = eff_pc_at_prediction_0;
            global_history_o_0 = global_history_mem[peek_idx_0];

            // If oldest is mispredicted, don't output younger branches
            // They will be flushed anyway
            if (!eff_mispredicted_0) begin
                // 2nd oldest (peek_1) - only if oldest is resolved and NOT mispredicted
                if (peek_valid_1 && eff_resolved_1) begin
                    branch_resolved_o_1 = 1'b1;
                    branch_mispredicted_o_1 = eff_mispredicted_1;
                    correct_pc_o_1 = eff_correct_pc_1;
                    resolved_phys_reg_o_1 = peek_branch_phys_1;
                    is_jalr_o_1 = is_jalr_mem[peek_idx_1];
                    pc_at_prediction_o_1 = eff_pc_at_prediction_1;
                    global_history_o_1 = global_history_mem[peek_idx_1];

                    // 3rd oldest (peek_2) - only if 1st and 2nd are resolved and NOT mispredicted
                    if (!eff_mispredicted_1 && peek_valid_2 && eff_resolved_2) begin
                        branch_resolved_o_2 = 1'b1;
                        branch_mispredicted_o_2 = eff_mispredicted_2;
                        correct_pc_o_2 = eff_correct_pc_2;
                        resolved_phys_reg_o_2 = peek_branch_phys_2;
                        is_jalr_o_2 = is_jalr_mem[peek_idx_2];
                        pc_at_prediction_o_2 = eff_pc_at_prediction_2;
                        global_history_o_2 = global_history_mem[peek_idx_2];
                    end
                end
            end
        end
    end

    //==========================================================================
    // Pointer Update Logic
    //==========================================================================

    // Determine if we should restore (misprediction in any of the resolved outputs)
    logic do_restore;
    assign do_restore = (branch_resolved_o_0 && branch_mispredicted_o_0) ||
        (branch_resolved_o_1 && branch_mispredicted_o_1) ||
        (branch_resolved_o_2 && branch_mispredicted_o_2);

    always_comb begin
        // Default: keep current values
        next_head_ptr = head_ptr;
        next_tail_ptr = tail_ptr;

        if (do_restore || restore_en) begin
            // Misprediction: flush buffer
            next_head_ptr = '0;
            next_tail_ptr = '0;
        end else begin
            // Pop correctly resolved branches (advance head pointer)
            if (!buffer_empty) begin
                next_head_ptr = head_ptr + pop_count;
            end

            // Push new branches (advance tail pointer)
            if (!buffer_full) begin
                next_tail_ptr = tail_ptr + push_count;
            end
        end
    end

    //==========================================================================
    // Restore Interface - Indexed snapshot retrieval
    //==========================================================================

    // Select restore index based on which branch mispredicted (oldest first)
    logic [1:0] actual_restore_idx;
    always_comb begin
        if (branch_resolved_o_0 && branch_mispredicted_o_0)
            actual_restore_idx = 2'b00;
        else if (branch_resolved_o_1 && branch_mispredicted_o_1)
            actual_restore_idx = 2'b01;
        else if (branch_resolved_o_2 && branch_mispredicted_o_2)
            actual_restore_idx = 2'b10;
        else
            actual_restore_idx = restore_idx;  // External restore
    end

    logic [PTR_WIDTH-1:0] snapshot_ptr;
    assign snapshot_ptr = head_ptr + {3'b000, actual_restore_idx};

    // Output the selected snapshot
    assign restore_rat_snapshot = rat_snapshot_mem[snapshot_ptr[IDX_WIDTH-1:0]];
    // Output RAS restore info
    assign ras_restore_valid_o = do_restore;
    assign ras_restore_tos_o = ras_tos_mem[snapshot_ptr[IDX_WIDTH-1:0]]; // todo check logic

    //==========================================================================
    // Push pointers
    //==========================================================================
    logic [PTR_WIDTH-1:0] push_ptr_0, push_ptr_1, push_ptr_2;
    assign push_ptr_0 = tail_ptr;
    assign push_ptr_1 = tail_ptr + (push_en_0 ? 1 : 0);
    assign push_ptr_2 = tail_ptr + (push_en_0 ? 1 : 0) + (push_en_1 ? 1 : 0);

    //==========================================================================
    // Sequential Logic - Buffer Storage and Pointer Updates
    //==========================================================================

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all three copies of pointers
            head_ptr_0 <= #D '0;
            head_ptr_1 <= #D '0;
            head_ptr_2 <= #D '0;
            tail_ptr_0 <= #D '0;
            tail_ptr_1 <= #D '0;
            tail_ptr_2 <= #D '0;
            resolved_mem <= #D '0;
            mispredicted_mem <= #D '0;
            is_jalr_mem <= #D '0;

            // Clear buffer memory
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                buffer_phys[i] <= #D '0;
                correct_pc_mem[i] <= #D '0;
                pc_at_prediction_mem[i] <= #D '0;
                global_history_mem[i] <= #D '0;
                ras_tos_mem[i] <= #D '0;
                for (int j = 0; j < ARCH_REGS; j++) begin
                    rat_snapshot_mem[i][j] <= #D '0;
                end
            end
        end else begin
            // Update all three copies of pointers (TMR healing)
            head_ptr_0 <= #D next_head_ptr;
            head_ptr_1 <= #D next_head_ptr;
            head_ptr_2 <= #D next_head_ptr;
            tail_ptr_0 <= #D next_tail_ptr;
            tail_ptr_1 <= #D next_tail_ptr;
            tail_ptr_2 <= #D next_tail_ptr;

            // Clear resolved/mispredicted on flush
            if (do_restore || restore_en) begin
                resolved_mem <= #D '0;
                mispredicted_mem <= #D '0;
            end else begin
                //==============================================================
                // Execute result write - set resolved flags
                //==============================================================
                for (int i = 0; i < BUFFER_DEPTH; i++) begin
                    if (exec_0_match[i]) begin
                        resolved_mem[i] <= #D 1'b1;
                        mispredicted_mem[i] <= #D exec_mispredicted_0;
                        correct_pc_mem[i] <= #D exec_correct_pc_0;
                        pc_at_prediction_mem[i] <= #D exec_pc_at_prediction_0;
                    end else if (exec_1_match[i]) begin
                        resolved_mem[i] <= #D 1'b1;
                        mispredicted_mem[i] <= #D exec_mispredicted_1;
                        correct_pc_mem[i] <= #D exec_correct_pc_1;
                        pc_at_prediction_mem[i] <= #D exec_pc_at_prediction_1;
                    end else if (exec_2_match[i]) begin
                        resolved_mem[i] <= #D 1'b1;
                        mispredicted_mem[i] <= #D exec_mispredicted_2;
                        correct_pc_mem[i] <= #D exec_correct_pc_2;
                        pc_at_prediction_mem[i] <= #D exec_pc_at_prediction_2;
                    end
                end

                //==============================================================
                // Commit updates - Update ALL snapshots to reflect RF transition
                // When a value commits from ROB to RF, all BRAT snapshots that
                // still point to that ROB entry must be updated to point to RF
                //==============================================================
                for (int i = 0; i < BUFFER_DEPTH; i++) begin
                    // Commit 0: If snapshot[arch_addr] == {1'b1, rob_idx}, change to {1'b0, arch_addr}
                    if (commit_valid_0 && commit_arch_addr_0 != 0) begin
                        if (rat_snapshot_mem[i][commit_arch_addr_0][4:0] == commit_rob_idx_0 &&
                                rat_snapshot_mem[i][commit_arch_addr_0][5] == 1'b1) begin
                            rat_snapshot_mem[i][commit_arch_addr_0] <= #D {1'b0, commit_arch_addr_0};
                        end
                    end

                    // Commit 1
                    if (commit_valid_1 && commit_arch_addr_1 != 0) begin
                        if (rat_snapshot_mem[i][commit_arch_addr_1][4:0] == commit_rob_idx_1 &&
                                rat_snapshot_mem[i][commit_arch_addr_1][5] == 1'b1) begin
                            rat_snapshot_mem[i][commit_arch_addr_1] <= #D {1'b0, commit_arch_addr_1};
                        end
                    end

                    // Commit 2
                    if (commit_valid_2 && commit_arch_addr_2 != 0) begin
                        if (rat_snapshot_mem[i][commit_arch_addr_2][4:0] == commit_rob_idx_2 &&
                                rat_snapshot_mem[i][commit_arch_addr_2][5] == 1'b1) begin
                            rat_snapshot_mem[i][commit_arch_addr_2] <= #D {1'b0, commit_arch_addr_2};
                        end
                    end
                end
            end

            //==============================================================
            // Push operations - store new branches at tail position
            //==============================================================
            if (push_en_0 && !buffer_full && !do_restore && !restore_en) begin
                buffer_phys[push_ptr_0[IDX_WIDTH-1:0]] <= #D push_branch_phys_0;
                rat_snapshot_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D push_rat_snapshot_0;
                resolved_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D 1'b0;
                mispredicted_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D 1'b0;
                correct_pc_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D '0;
                is_jalr_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D push_is_jalr_0;
                pc_at_prediction_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D '0;
                global_history_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D push_global_history_0;
                ras_tos_mem[push_ptr_0[IDX_WIDTH-1:0]] <= #D push_ras_tos_0;
            end

            if (push_en_1 && !buffer_full && !do_restore && !restore_en) begin
                buffer_phys[push_ptr_1[IDX_WIDTH-1:0]] <= #D push_branch_phys_1;
                rat_snapshot_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D push_rat_snapshot_1;
                resolved_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D 1'b0;
                mispredicted_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D 1'b0;
                correct_pc_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D '0;
                is_jalr_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D push_is_jalr_1;
                pc_at_prediction_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D '0;
                global_history_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D push_global_history_1;
                ras_tos_mem[push_ptr_1[IDX_WIDTH-1:0]] <= #D push_ras_tos_1;
            end

            if (push_en_2 && !buffer_full && !do_restore && !restore_en) begin
                buffer_phys[push_ptr_2[IDX_WIDTH-1:0]] <= #D push_branch_phys_2;
                rat_snapshot_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D push_rat_snapshot_2;
                resolved_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D 1'b0;
                mispredicted_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D 1'b0;
                correct_pc_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D '0;
                is_jalr_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D push_is_jalr_2;
                pc_at_prediction_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D '0;
                global_history_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D push_global_history_2;
                ras_tos_mem[push_ptr_2[IDX_WIDTH-1:0]] <= #D push_ras_tos_2;
            end
        end
    end

    //==========================================================================
    // Assertions
    //==========================================================================

    // synthesis translate_off
    always_ff @(posedge clk) begin
        if (rst_n) begin
            // Check for overflow
            if ((push_en_0 || push_en_1 || push_en_2) && buffer_full) begin
                $warning("BRAT v2: Push attempted when buffer full!");
            end
        end
    end
    // synthesis translate_on

endmodule
