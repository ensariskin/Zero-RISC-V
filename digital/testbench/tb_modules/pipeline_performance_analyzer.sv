// Pipeline Performance Analyzer
// Focused analysis: Why is issue_valid = 0?
// Methodology: Track sequential dependencies correctly

module pipeline_performance_analyzer(
    input logic clk,
    input logic reset,

    // RS0 signals
    input logic rs0_occupied,
    input logic rs0_issue_valid,
    input logic [2:0] rs0_operand_a_tag,
    input logic [2:0] rs0_operand_b_tag,

    // RS1 signals
    input logic rs1_occupied,
    input logic rs1_issue_valid,
    input logic [2:0] rs1_operand_a_tag,
    input logic [2:0] rs1_operand_b_tag,

    // RS2 signals
    input logic rs2_occupied,
    input logic rs2_issue_valid,
    input logic [2:0] rs2_operand_a_tag,
    input logic [2:0] rs2_operand_b_tag,

    // Misprediction signal
    input logic misprediction_detected,

    // Issue stage signals for previous stage bottleneck analysis
    input logic [2:0] decode_valid_i,    // Valid instructions from buffer
    input logic [2:0] decode_ready_o,    // Ready signal to buffer
    input logic [2:0] rename_ready,      // RAT can allocate (ROB not full)
    input logic [2:0] lsq_alloc_ready,   // LSQ can allocate (LSQ not full)

    // New signals for Commit/Branch/LS analysis
    input logic [2:0] commit_valid,
    input logic [2:0] lsq_commit_valid,
    input logic [2:0] brat_branch_resolved,
    input logic [2:0] brat_branch_mispredicted
);

    localparam TAG_READY = 3'b111;

    // Cycle counter
    integer cycle_count = 0;
    integer file_ptr;

    //==========================================================================
    // ANALYSIS 2: Commit & Instruction Mix Analysis
    //==========================================================================
    integer commit_count_window = 0;
    integer branch_count_window = 0;
    integer mispred_count_window = 0;
    integer ls_count_window = 0;
    
    integer commit_count_total = 0;
    integer branch_count_total = 0;
    integer mispred_count_total = 0;
    integer ls_count_total = 0;

    //==========================================================================
    // ANALYSIS 1: Why is issue_valid = 0?
    //==========================================================================
    
    // RS0 Counters
    integer rs0_not_occupied = 0;           // Case 1: RS boş
    integer rs0_not_occupied_mispred = 0;   // RS boş - misprediction penalty
    integer rs0_not_occupied_prev_stage = 0; // RS boş - previous stage bottleneck
    // Previous stage bottleneck subcategories
    integer rs0_prev_stage_decode_not_ready = 0;    // decode_ready = 0
    integer rs0_prev_stage_rob_full = 0;            // ROB full (rename_ready = 0)
    integer rs0_prev_stage_lsq_full = 0;            // LSQ full (lsq_alloc_ready != 111)
    integer rs0_prev_stage_buffer_empty = 0;        // Instruction buffer empty
    integer rs0_operands_not_ready = 0;     // Case 2: RS dolu ama operandlar hazır değil
    
    // RS0 Operand waiting breakdown (when not ready)
    integer rs0_waiting_a_cdb0 = 0;
    integer rs0_waiting_a_cdb1 = 0;
    integer rs0_waiting_a_cdb2 = 0;
    integer rs0_waiting_a_cdb3 = 0;
    
    integer rs0_waiting_b_cdb0 = 0;
    integer rs0_waiting_b_cdb1 = 0;
    integer rs0_waiting_b_cdb2 = 0;
    integer rs0_waiting_b_cdb3 = 0;
    
    integer rs0_waiting_both = 0;           // Both operands waiting
    integer rs0_waiting_only_a = 0;         // Only A waiting
    integer rs0_waiting_only_b = 0;         // Only B waiting

    // RS1 Counters
    integer rs1_not_occupied = 0;
    integer rs1_not_occupied_mispred = 0;
    integer rs1_not_occupied_prev_stage = 0;
    // Previous stage bottleneck subcategories
    integer rs1_prev_stage_decode_not_ready = 0;    // decode_ready = 0
    integer rs1_prev_stage_rob_full = 0;            // ROB full (rename_ready = 0)
    integer rs1_prev_stage_lsq_full = 0;            // LSQ full (lsq_alloc_ready != 111)
    integer rs1_prev_stage_buffer_empty = 0;        // Instruction buffer empty
    integer rs1_operands_not_ready = 0;
    
    integer rs1_waiting_a_cdb0 = 0;
    integer rs1_waiting_a_cdb1 = 0;
    integer rs1_waiting_a_cdb2 = 0;
    integer rs1_waiting_a_cdb3 = 0;
    
    integer rs1_waiting_b_cdb0 = 0;
    integer rs1_waiting_b_cdb1 = 0;
    integer rs1_waiting_b_cdb2 = 0;
    integer rs1_waiting_b_cdb3 = 0;
    
    integer rs1_waiting_both = 0;
    integer rs1_waiting_only_a = 0;
    integer rs1_waiting_only_b = 0;

    // RS2 Counters
    integer rs2_not_occupied = 0;
    integer rs2_not_occupied_mispred = 0;
    integer rs2_not_occupied_prev_stage = 0;
    // Previous stage bottleneck subcategories
    integer rs2_prev_stage_decode_not_ready = 0;    // decode_ready = 0
    integer rs2_prev_stage_rob_full = 0;            // ROB full (rename_ready = 0)
    integer rs2_prev_stage_lsq_full = 0;            // LSQ full (lsq_alloc_ready != 111)
    integer rs2_prev_stage_buffer_empty = 0;        // Instruction buffer empty
    integer rs2_operands_not_ready = 0;
    
    integer rs2_waiting_a_cdb0 = 0;
    integer rs2_waiting_a_cdb1 = 0;
    integer rs2_waiting_a_cdb2 = 0;
    integer rs2_waiting_a_cdb3 = 0;
    
    integer rs2_waiting_b_cdb0 = 0;
    integer rs2_waiting_b_cdb1 = 0;
    integer rs2_waiting_b_cdb2 = 0;
    integer rs2_waiting_b_cdb3 = 0;
    
    integer rs2_waiting_both = 0;
    integer rs2_waiting_only_a = 0;
    integer rs2_waiting_only_b = 0;

    //==========================================================================
    // MISPREDICTION PENALTY TRACKING
    //==========================================================================
    
    // State tracking: Are we currently in misprediction penalty?
    logic rs0_in_penalty = 0;
    logic rs1_in_penalty = 0;
    logic rs2_in_penalty = 0;

    // Pipeline registers for issue stage signals (2 clock delay to match decode_valid_reg)
    logic [2:0] decode_valid_i_d1 = 0, decode_valid_i_d2 = 0;
    logic [2:0] decode_ready_o_d1 = 0, decode_ready_o_d2 = 0;
    logic [2:0] rename_ready_d1 = 0, rename_ready_d2 = 0;
    logic [2:0] lsq_alloc_ready_d1 = 0, lsq_alloc_ready_d2 = 0;

    // Helper signals for readability
    logic rs0_a_ready, rs0_b_ready;
    logic rs1_a_ready, rs1_b_ready;
    logic rs2_a_ready, rs2_b_ready;

    integer i;
    integer c_commits, c_branches, c_mispreds, c_ls;

    assign rs0_a_ready = (rs0_operand_a_tag == TAG_READY);
    assign rs0_b_ready = (rs0_operand_b_tag == TAG_READY);
    assign rs1_a_ready = (rs1_operand_a_tag == TAG_READY);
    assign rs1_b_ready = (rs1_operand_b_tag == TAG_READY);
    assign rs2_a_ready = (rs2_operand_a_tag == TAG_READY);
    assign rs2_b_ready = (rs2_operand_b_tag == TAG_READY);

    //==========================================================================
    // FILE INITIALIZATION
    //==========================================================================
    initial begin
        file_ptr = $fopen("performance_analysis.log", "w");
        $fwrite(file_ptr, "========================================\n");
        $fwrite(file_ptr, "Pipeline Performance Analyzer\n");
        $fwrite(file_ptr, "Focus: Why is issue_valid = 0?\n");
        $fwrite(file_ptr, "========================================\n\n");
    end

    //==========================================================================
    // ANALYSIS LOGIC
    //==========================================================================
    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 0;
            
            // Reset all counters
            rs0_not_occupied <= 0;
            rs0_not_occupied_mispred <= 0;
            rs0_not_occupied_prev_stage <= 0;
            rs0_prev_stage_decode_not_ready <= 0;
            rs0_prev_stage_rob_full <= 0;
            rs0_prev_stage_lsq_full <= 0;
            rs0_prev_stage_buffer_empty <= 0;
            rs0_operands_not_ready <= 0;
            rs0_waiting_a_cdb0 <= 0;
            rs0_waiting_a_cdb1 <= 0;
            rs0_waiting_a_cdb2 <= 0;
            rs0_waiting_a_cdb3 <= 0;
            rs0_waiting_b_cdb0 <= 0;
            rs0_waiting_b_cdb1 <= 0;
            rs0_waiting_b_cdb2 <= 0;
            rs0_waiting_b_cdb3 <= 0;
            rs0_waiting_both <= 0;
            rs0_waiting_only_a <= 0;
            rs0_waiting_only_b <= 0;

            rs1_not_occupied <= 0;
            rs1_not_occupied_mispred <= 0;
            rs1_not_occupied_prev_stage <= 0;
            rs1_prev_stage_decode_not_ready <= 0;
            rs1_prev_stage_rob_full <= 0;
            rs1_prev_stage_lsq_full <= 0;
            rs1_prev_stage_buffer_empty <= 0;
            rs1_operands_not_ready <= 0;
            rs1_waiting_a_cdb0 <= 0;
            rs1_waiting_a_cdb1 <= 0;
            rs1_waiting_a_cdb2 <= 0;
            rs1_waiting_a_cdb3 <= 0;
            rs1_waiting_b_cdb0 <= 0;
            rs1_waiting_b_cdb1 <= 0;
            rs1_waiting_b_cdb2 <= 0;
            rs1_waiting_b_cdb3 <= 0;
            rs1_waiting_both <= 0;
            rs1_waiting_only_a <= 0;
            rs1_waiting_only_b <= 0;

            rs2_not_occupied <= 0;
            rs2_not_occupied_mispred <= 0;
            rs2_not_occupied_prev_stage <= 0;
            rs2_prev_stage_decode_not_ready <= 0;
            rs2_prev_stage_rob_full <= 0;
            rs2_prev_stage_lsq_full <= 0;
            rs2_prev_stage_buffer_empty <= 0;
            rs2_operands_not_ready <= 0;
            rs2_waiting_a_cdb0 <= 0;
            rs2_waiting_a_cdb1 <= 0;
            rs2_waiting_a_cdb2 <= 0;
            rs2_waiting_a_cdb3 <= 0;
            rs2_waiting_b_cdb0 <= 0;
            rs2_waiting_b_cdb1 <= 0;
            rs2_waiting_b_cdb2 <= 0;
            rs2_waiting_b_cdb3 <= 0;
            rs2_waiting_both <= 0;
            rs2_waiting_only_a <= 0;
            rs2_waiting_only_b <= 0;

            rs0_in_penalty <= 0;
            rs1_in_penalty <= 0;
            rs2_in_penalty <= 0;
            
            // Reset pipeline registers for issue stage signals
            decode_valid_i_d1 <= 0;
            decode_valid_i_d2 <= 0;
            decode_ready_o_d1 <= 0;
            decode_ready_o_d2 <= 0;
            rename_ready_d1 <= 0;
            rename_ready_d2 <= 0;
            lsq_alloc_ready_d1 <= 0;
            lsq_alloc_ready_d2 <= 0;
        end else begin
            cycle_count <= cycle_count + 1;

            //==================================================================
            // PIPELINE ISSUE STAGE SIGNALS (2 clock delay)
            //==================================================================
            decode_valid_i_d1 <= decode_valid_i;
            decode_valid_i_d2 <= decode_valid_i_d1;
            
            decode_ready_o_d1 <= decode_ready_o;
            decode_ready_o_d2 <= decode_ready_o_d1;
            
            rename_ready_d1 <= rename_ready;
            rename_ready_d2 <= rename_ready_d1;
            
            lsq_alloc_ready_d1 <= lsq_alloc_ready;
            lsq_alloc_ready_d2 <= lsq_alloc_ready_d1;

            //==================================================================
            // COMMIT & INSTRUCTION MIX TRACKING
            //==================================================================
            // Count set bits for this cycle
           
            
            c_commits = 0;
            c_branches = 0;
            c_mispreds = 0;
            c_ls = 0;

            for (i = 0; i < 3; i++) begin
                if (commit_valid[i]) c_commits++;
                if (brat_branch_resolved[i]) c_branches++;
                if (brat_branch_resolved[i] && brat_branch_mispredicted[i]) c_mispreds++;
                if (lsq_commit_valid[i]) c_ls++;
            end

            commit_count_window += c_commits;
            branch_count_window += c_branches;
            mispred_count_window += c_mispreds;
            ls_count_window += c_ls;

            commit_count_total += c_commits;
            branch_count_total += c_branches;
            mispred_count_total += c_mispreds;
            ls_count_total += c_ls;

            //==================================================================
            // MISPREDICTION PENALTY TRACKING
            //==================================================================
            
            // RS0 Misprediction Penalty
            if (misprediction_detected) begin
                // Start penalty tracking
                rs0_in_penalty <= 1'b1;
            end else if (rs0_in_penalty && (rs0_issue_valid || rs0_occupied)) begin
                // Recovered: issue_valid=1 or occupied=1
                rs0_in_penalty <= 1'b0;
            end

            // RS1 Misprediction Penalty
            if (misprediction_detected) begin
                rs1_in_penalty <= 1'b1;
            end else if (rs1_in_penalty && (rs1_issue_valid || rs1_occupied)) begin
                rs1_in_penalty <= 1'b0;
            end

            // RS2 Misprediction Penalty
            if (misprediction_detected) begin
                rs2_in_penalty <= 1'b1;
            end else if (rs2_in_penalty && (rs2_issue_valid || rs2_occupied)) begin
                rs2_in_penalty <= 1'b0;
            end

            //==================================================================
            // RS0 ANALYSIS
            //==================================================================
            if (!rs0_issue_valid) begin
                if (!rs0_occupied) begin
                    // Case 1: RS not occupied
                    rs0_not_occupied <= rs0_not_occupied + 1;
                    
                    // Subdivide: misprediction penalty vs previous stage bottleneck
                    if (rs0_in_penalty | misprediction_detected) begin
                        rs0_not_occupied_mispred <= rs0_not_occupied_mispred + 1;
                    end else begin
                        rs0_not_occupied_prev_stage <= rs0_not_occupied_prev_stage + 1;
                        
                        // Further subdivide previous stage bottleneck
                        // Logic from issue_stage: decode_ready = (lsq_alloc_ready == 3'b111) ? (dispatch_ready & rename_ready) : 3'b000
                        if (!decode_ready_o_d2[0]) begin
                            rs0_prev_stage_decode_not_ready <= rs0_prev_stage_decode_not_ready + 1;
                            
                            // Why is decode_ready = 0?
                            if (lsq_alloc_ready_d2 != 3'b111) begin
                                rs0_prev_stage_lsq_full <= rs0_prev_stage_lsq_full + 1;
                            end else if (!rename_ready_d2[0]) begin
                                rs0_prev_stage_rob_full <= rs0_prev_stage_rob_full + 1;
                            end
                            // Note: dispatch_ready is already covered by operands_not_ready tracking
                        end else if (!decode_valid_i_d2[0]) begin
                            // decode_ready = 1 but decode_valid = 0 means buffer is empty
                            rs0_prev_stage_buffer_empty <= rs0_prev_stage_buffer_empty + 1;
                        end
                    end
                end else begin
                    // Case 2: RS occupied but operands not ready
                    rs0_operands_not_ready <= rs0_operands_not_ready + 1;

                    // Track which operands are waiting
                    if (!rs0_a_ready && !rs0_b_ready) begin
                        rs0_waiting_both <= rs0_waiting_both + 1;
                    end else if (!rs0_a_ready) begin
                        rs0_waiting_only_a <= rs0_waiting_only_a + 1;
                    end else if (!rs0_b_ready) begin
                        rs0_waiting_only_b <= rs0_waiting_only_b + 1;
                    end

                    // Track what A is waiting for
                    if (!rs0_a_ready) begin
                        case (rs0_operand_a_tag)
                            3'b000: rs0_waiting_a_cdb0 <= rs0_waiting_a_cdb0 + 1;
                            3'b001: rs0_waiting_a_cdb1 <= rs0_waiting_a_cdb1 + 1;
                            3'b010: rs0_waiting_a_cdb2 <= rs0_waiting_a_cdb2 + 1;
                            3'b011: rs0_waiting_a_cdb3 <= rs0_waiting_a_cdb3 + 1;
                        endcase
                    end

                    // Track what B is waiting for
                    if (!rs0_b_ready) begin
                        case (rs0_operand_b_tag)
                            3'b000: rs0_waiting_b_cdb0 <= rs0_waiting_b_cdb0 + 1;
                            3'b001: rs0_waiting_b_cdb1 <= rs0_waiting_b_cdb1 + 1;
                            3'b010: rs0_waiting_b_cdb2 <= rs0_waiting_b_cdb2 + 1;
                            3'b011: rs0_waiting_b_cdb3 <= rs0_waiting_b_cdb3 + 1;
                        endcase
                    end
                end
            end

            //==================================================================
            // RS1 ANALYSIS
            //==================================================================
            if (!rs1_issue_valid) begin
                if (!rs1_occupied) begin
                    rs1_not_occupied <= rs1_not_occupied + 1;
                    
                    if (rs1_in_penalty | misprediction_detected) begin
                        rs1_not_occupied_mispred <= rs1_not_occupied_mispred + 1;
                    end else begin
                        rs1_not_occupied_prev_stage <= rs1_not_occupied_prev_stage + 1;
                        
                        // Further subdivide previous stage bottleneck
                        if (!decode_ready_o_d2[1]) begin
                            rs1_prev_stage_decode_not_ready <= rs1_prev_stage_decode_not_ready + 1;
                            
                            if (lsq_alloc_ready_d2 != 3'b111) begin
                                rs1_prev_stage_lsq_full <= rs1_prev_stage_lsq_full + 1;
                            end else if (!rename_ready_d2[1]) begin
                                rs1_prev_stage_rob_full <= rs1_prev_stage_rob_full + 1;
                            end
                        end else if (!decode_valid_i_d2[1]) begin
                            rs1_prev_stage_buffer_empty <= rs1_prev_stage_buffer_empty + 1;
                        end
                    end
                end else begin
                    rs1_operands_not_ready <= rs1_operands_not_ready + 1;

                    if (!rs1_a_ready && !rs1_b_ready) begin
                        rs1_waiting_both <= rs1_waiting_both + 1;
                    end else if (!rs1_a_ready) begin
                        rs1_waiting_only_a <= rs1_waiting_only_a + 1;
                    end else if (!rs1_b_ready) begin
                        rs1_waiting_only_b <= rs1_waiting_only_b + 1;
                    end

                    if (!rs1_a_ready) begin
                        case (rs1_operand_a_tag)
                            3'b000: rs1_waiting_a_cdb0 <= rs1_waiting_a_cdb0 + 1;
                            3'b001: rs1_waiting_a_cdb1 <= rs1_waiting_a_cdb1 + 1;
                            3'b010: rs1_waiting_a_cdb2 <= rs1_waiting_a_cdb2 + 1;
                            3'b011: rs1_waiting_a_cdb3 <= rs1_waiting_a_cdb3 + 1;
                        endcase
                    end

                    if (!rs1_b_ready) begin
                        case (rs1_operand_b_tag)
                            3'b000: rs1_waiting_b_cdb0 <= rs1_waiting_b_cdb0 + 1;
                            3'b001: rs1_waiting_b_cdb1 <= rs1_waiting_b_cdb1 + 1;
                            3'b010: rs1_waiting_b_cdb2 <= rs1_waiting_b_cdb2 + 1;
                            3'b011: rs1_waiting_b_cdb3 <= rs1_waiting_b_cdb3 + 1;
                        endcase
                    end
                end
            end

            //==================================================================
            // RS2 ANALYSIS
            //==================================================================
            if (!rs2_issue_valid) begin
                if (!rs2_occupied) begin
                    rs2_not_occupied <= rs2_not_occupied + 1;
                    
                    if (rs2_in_penalty | misprediction_detected) begin
                        rs2_not_occupied_mispred <= rs2_not_occupied_mispred + 1;
                    end else begin
                        rs2_not_occupied_prev_stage <= rs2_not_occupied_prev_stage + 1;
                        
                        // Further subdivide previous stage bottleneck
                        if (!decode_ready_o_d2[2]) begin
                            rs2_prev_stage_decode_not_ready <= rs2_prev_stage_decode_not_ready + 1;
                            
                            if (lsq_alloc_ready_d2 != 3'b111) begin
                                rs2_prev_stage_lsq_full <= rs2_prev_stage_lsq_full + 1;
                            end else if (!rename_ready_d2[2]) begin
                                rs2_prev_stage_rob_full <= rs2_prev_stage_rob_full + 1;
                            end
                        end else if (!decode_valid_i_d2[2]) begin
                            rs2_prev_stage_buffer_empty <= rs2_prev_stage_buffer_empty + 1;
                        end
                    end
                end else begin
                    rs2_operands_not_ready <= rs2_operands_not_ready + 1;

                    if (!rs2_a_ready && !rs2_b_ready) begin
                        rs2_waiting_both <= rs2_waiting_both + 1;
                    end else if (!rs2_a_ready) begin
                        rs2_waiting_only_a <= rs2_waiting_only_a + 1;
                    end else if (!rs2_b_ready) begin
                        rs2_waiting_only_b <= rs2_waiting_only_b + 1;
                    end

                    if (!rs2_a_ready) begin
                        case (rs2_operand_a_tag)
                            3'b000: rs2_waiting_a_cdb0 <= rs2_waiting_a_cdb0 + 1;
                            3'b001: rs2_waiting_a_cdb1 <= rs2_waiting_a_cdb1 + 1;
                            3'b010: rs2_waiting_a_cdb2 <= rs2_waiting_a_cdb2 + 1;
                            3'b011: rs2_waiting_a_cdb3 <= rs2_waiting_a_cdb3 + 1;
                        endcase
                    end

                    if (!rs2_b_ready) begin
                        case (rs2_operand_b_tag)
                            3'b000: rs2_waiting_b_cdb0 <= rs2_waiting_b_cdb0 + 1;
                            3'b001: rs2_waiting_b_cdb1 <= rs2_waiting_b_cdb1 + 1;
                            3'b010: rs2_waiting_b_cdb2 <= rs2_waiting_b_cdb2 + 1;
                            3'b011: rs2_waiting_b_cdb3 <= rs2_waiting_b_cdb3 + 1;
                        endcase
                    end
                end
            end

            //==================================================================
            // PERIODIC REPORT (Every 1000 cycles)
            //==================================================================
            if (cycle_count % 1000 == 0 && cycle_count > 0) begin
                $fwrite(file_ptr, "\n========================================\n");
                $fwrite(file_ptr, "CYCLE %0d REPORT\n", cycle_count);
                $fwrite(file_ptr, "========================================\n\n");

                // Instruction Mix Analysis
                $fwrite(file_ptr, "Instruction Mix Analysis (Last 1000 cycles):\n");
                $fwrite(file_ptr, "  Commits:       %0d\n", commit_count_window);
                $fwrite(file_ptr, "  Branches:      %0d\n", branch_count_window);
                $fwrite(file_ptr, "  Mispredicts:   %0d\n", mispred_count_window);
                $fwrite(file_ptr, "  Load/Stores:   %0d\n", ls_count_window);
                $fwrite(file_ptr, "\n");

                // Reset window counters
                commit_count_window = 0;
                branch_count_window = 0;
                mispred_count_window = 0;
                ls_count_window = 0;

                // RS0 Report
                $fwrite(file_ptr, "RS0 (Pipeline 0) Analysis:\n");
                $fwrite(file_ptr, "RS0 Stall:      %0d cycles (%.1f%%)\n", 
                    rs0_not_occupied + rs0_operands_not_ready, 
                    ((rs0_not_occupied + rs0_operands_not_ready) * 100.0) / cycle_count);
                $fwrite(file_ptr, "  Not Occupied:      %0d cycles (%.1f%%)\n", 
                    rs0_not_occupied, (rs0_not_occupied * 100.0) / (rs0_not_occupied + rs0_operands_not_ready));
                
                if (rs0_not_occupied > 0) begin
                    $fwrite(file_ptr, "    Misprediction Penalty: %0d (%.1f%%)\n",
                        rs0_not_occupied_mispred, (rs0_not_occupied_mispred * 100.0) / rs0_not_occupied);
                    $fwrite(file_ptr, "    Previous Stage Bottleneck: %0d (%.1f%%)\n",
                        rs0_not_occupied_prev_stage, (rs0_not_occupied_prev_stage * 100.0) / rs0_not_occupied);
                    
                    // Further breakdown of previous stage bottleneck
                    if (rs0_not_occupied_prev_stage > 0) begin
                        $fwrite(file_ptr, "      Decode Not Ready: %0d (%.1f%%)\n",
                            rs0_prev_stage_decode_not_ready, 
                            (rs0_prev_stage_decode_not_ready * 100.0) / rs0_not_occupied_prev_stage);
                        
                        if (rs0_prev_stage_decode_not_ready > 0) begin
                            $fwrite(file_ptr, "        ROB Full: %0d (%.1f%%)\n",
                                rs0_prev_stage_rob_full,
                                (rs0_prev_stage_rob_full * 100.0) / rs0_prev_stage_decode_not_ready);
                            $fwrite(file_ptr, "        LSQ Full: %0d (%.1f%%)\n",
                                rs0_prev_stage_lsq_full,
                                (rs0_prev_stage_lsq_full * 100.0) / rs0_prev_stage_decode_not_ready);
                        end
                        
                        $fwrite(file_ptr, "      Instruction Buffer Empty: %0d (%.1f%%)\n",
                            rs0_prev_stage_buffer_empty,
                            (rs0_prev_stage_buffer_empty * 100.0) / rs0_not_occupied_prev_stage);
                    end
                end
                
                $fwrite(file_ptr, "  Operands Not Ready: %0d cycles (%.1f%%)\n", 
                    rs0_operands_not_ready, (rs0_operands_not_ready * 100.0) / (rs0_not_occupied + rs0_operands_not_ready));
                
                if (rs0_operands_not_ready > 0) begin
                    $fwrite(file_ptr, "    Dependency Pattern:\n");
                    $fwrite(file_ptr, "      Both waiting:   %0d (%.1f%%)\n", 
                        rs0_waiting_both, (rs0_waiting_both * 100.0) / rs0_operands_not_ready);
                    $fwrite(file_ptr, "      Only A waiting: %0d (%.1f%%)\n", 
                        rs0_waiting_only_a, (rs0_waiting_only_a * 100.0) / rs0_operands_not_ready);
                    $fwrite(file_ptr, "      Only B waiting: %0d (%.1f%%)\n", 
                        rs0_waiting_only_b, (rs0_waiting_only_b * 100.0) / rs0_operands_not_ready);
                    
                    $fwrite(file_ptr, "    Operand A waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs0_waiting_a_cdb0, 
                        (rs0_waiting_a_cdb0 * 100.0) / (rs0_waiting_only_a + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs0_waiting_a_cdb1, 
                        (rs0_waiting_a_cdb1 * 100.0) / (rs0_waiting_only_a + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs0_waiting_a_cdb2, 
                        (rs0_waiting_a_cdb2 * 100.0) / (rs0_waiting_only_a + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs0_waiting_a_cdb3, 
                        (rs0_waiting_a_cdb3 * 100.0) / (rs0_waiting_only_a + rs0_waiting_both));
                    
                    $fwrite(file_ptr, "    Operand B waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs0_waiting_b_cdb0, 
                        (rs0_waiting_b_cdb0 * 100.0) / (rs0_waiting_only_b + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs0_waiting_b_cdb1, 
                        (rs0_waiting_b_cdb1 * 100.0) / (rs0_waiting_only_b + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs0_waiting_b_cdb2, 
                        (rs0_waiting_b_cdb2 * 100.0) / (rs0_waiting_only_b + rs0_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs0_waiting_b_cdb3, 
                        (rs0_waiting_b_cdb3 * 100.0) / (rs0_waiting_only_b + rs0_waiting_both));
                end
                $fwrite(file_ptr, "\n");

                // RS1 Report
                $fwrite(file_ptr, "RS1 (Pipeline 1) Analysis:\n");
                $fwrite(file_ptr, "RS1 Stall:      %0d cycles (%.1f%%)\n", 
                     rs1_not_occupied + rs1_operands_not_ready, 
                     ((rs1_not_occupied + rs1_operands_not_ready) * 100.0) / cycle_count);
                $fwrite(file_ptr, "  Not Occupied:      %0d cycles (%.1f%%)\n", 
                    rs1_not_occupied, (rs1_not_occupied * 100.0) / (rs1_not_occupied + rs1_operands_not_ready));
                
                if (rs1_not_occupied > 0) begin
                    $fwrite(file_ptr, "    Misprediction Penalty: %0d (%.1f%%)\n",
                        rs1_not_occupied_mispred, (rs1_not_occupied_mispred * 100.0) / rs1_not_occupied);
                    $fwrite(file_ptr, "    Previous Stage Bottleneck: %0d (%.1f%%)\n",
                        rs1_not_occupied_prev_stage, (rs1_not_occupied_prev_stage * 100.0) / rs1_not_occupied);
                    
                    if (rs1_not_occupied_prev_stage > 0) begin
                        $fwrite(file_ptr, "      Decode Not Ready: %0d (%.1f%%)\n",
                            rs1_prev_stage_decode_not_ready, 
                            (rs1_prev_stage_decode_not_ready * 100.0) / rs1_not_occupied_prev_stage);
                        
                        if (rs1_prev_stage_decode_not_ready > 0) begin
                            $fwrite(file_ptr, "        ROB Full: %0d (%.1f%%)\n",
                                rs1_prev_stage_rob_full,
                                (rs1_prev_stage_rob_full * 100.0) / rs1_prev_stage_decode_not_ready);
                            $fwrite(file_ptr, "        LSQ Full: %0d (%.1f%%)\n",
                                rs1_prev_stage_lsq_full,
                                (rs1_prev_stage_lsq_full * 100.0) / rs1_prev_stage_decode_not_ready);
                        end
                        
                        $fwrite(file_ptr, "      Instruction Buffer Empty: %0d (%.1f%%)\n",
                            rs1_prev_stage_buffer_empty,
                            (rs1_prev_stage_buffer_empty * 100.0) / rs1_not_occupied_prev_stage);
                    end
                end
                
                $fwrite(file_ptr, "  Operands Not Ready: %0d cycles (%.1f%%)\n", 
                    rs1_operands_not_ready, (rs1_operands_not_ready * 100.0) / (rs1_not_occupied + rs1_operands_not_ready));
                
                if (rs1_operands_not_ready > 0) begin
                    $fwrite(file_ptr, "    Dependency Pattern:\n");
                    $fwrite(file_ptr, "      Both waiting:   %0d (%.1f%%)\n", 
                        rs1_waiting_both, (rs1_waiting_both * 100.0) / rs1_operands_not_ready);
                    $fwrite(file_ptr, "      Only A waiting: %0d (%.1f%%)\n", 
                        rs1_waiting_only_a, (rs1_waiting_only_a * 100.0) / rs1_operands_not_ready);
                    $fwrite(file_ptr, "      Only B waiting: %0d (%.1f%%)\n", 
                        rs1_waiting_only_b, (rs1_waiting_only_b * 100.0) / rs1_operands_not_ready);
                    
                    $fwrite(file_ptr, "    Operand A waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs1_waiting_a_cdb0, 
                        (rs1_waiting_a_cdb0 * 100.0) / (rs1_waiting_only_a + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs1_waiting_a_cdb1, 
                        (rs1_waiting_a_cdb1 * 100.0) / (rs1_waiting_only_a + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs1_waiting_a_cdb2, 
                        (rs1_waiting_a_cdb2 * 100.0) / (rs1_waiting_only_a + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs1_waiting_a_cdb3, 
                        (rs1_waiting_a_cdb3 * 100.0) / (rs1_waiting_only_a + rs1_waiting_both));
                    
                    $fwrite(file_ptr, "    Operand B waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs1_waiting_b_cdb0, 
                        (rs1_waiting_b_cdb0 * 100.0) / (rs1_waiting_only_b + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs1_waiting_b_cdb1, 
                        (rs1_waiting_b_cdb1 * 100.0) / (rs1_waiting_only_b + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs1_waiting_b_cdb2, 
                        (rs1_waiting_b_cdb2 * 100.0) / (rs1_waiting_only_b + rs1_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs1_waiting_b_cdb3, 
                        (rs1_waiting_b_cdb3 * 100.0) / (rs1_waiting_only_b + rs1_waiting_both));
                end
                $fwrite(file_ptr, "\n");

                // RS2 Report
                $fwrite(file_ptr, "RS2 (Pipeline 2) Analysis:\n");
                $fwrite(file_ptr, "RS2 Stall:      %0d cycles (%.1f%%)\n", 
                        rs2_not_occupied + rs2_operands_not_ready, 
                        ((rs2_not_occupied + rs2_operands_not_ready) * 100.0) / cycle_count);
                $fwrite(file_ptr, "  Not Occupied:      %0d cycles (%.1f%%)\n", 
                    rs2_not_occupied, (rs2_not_occupied * 100.0) / (rs2_not_occupied + rs2_operands_not_ready));
                
                if (rs2_not_occupied > 0) begin
                    $fwrite(file_ptr, "    Misprediction Penalty: %0d (%.1f%%)\n",
                        rs2_not_occupied_mispred, (rs2_not_occupied_mispred * 100.0) / rs2_not_occupied);
                    $fwrite(file_ptr, "    Previous Stage Bottleneck: %0d (%.1f%%)\n",
                        rs2_not_occupied_prev_stage, (rs2_not_occupied_prev_stage * 100.0) / rs2_not_occupied);
                    
                    if (rs2_not_occupied_prev_stage > 0) begin
                        $fwrite(file_ptr, "      Decode Not Ready: %0d (%.1f%%)\n",
                            rs2_prev_stage_decode_not_ready, 
                            (rs2_prev_stage_decode_not_ready * 100.0) / rs2_not_occupied_prev_stage);
                        
                        if (rs2_prev_stage_decode_not_ready > 0) begin
                            $fwrite(file_ptr, "        ROB Full: %0d (%.1f%%)\n",
                                rs2_prev_stage_rob_full,
                                (rs2_prev_stage_rob_full * 100.0) / rs2_prev_stage_decode_not_ready);
                            $fwrite(file_ptr, "        LSQ Full: %0d (%.1f%%)\n",
                                rs2_prev_stage_lsq_full,
                                (rs2_prev_stage_lsq_full * 100.0) / rs2_prev_stage_decode_not_ready);
                        end
                        
                        $fwrite(file_ptr, "      Instruction Buffer Empty: %0d (%.1f%%)\n",
                            rs2_prev_stage_buffer_empty,
                            (rs2_prev_stage_buffer_empty * 100.0) / rs2_not_occupied_prev_stage);
                    end
                end
                
                $fwrite(file_ptr, "  Operands Not Ready: %0d cycles (%.1f%%)\n", 
                    rs2_operands_not_ready, (rs2_operands_not_ready * 100.0) / (rs2_not_occupied + rs2_operands_not_ready));
                
                if (rs2_operands_not_ready > 0) begin
                    $fwrite(file_ptr, "    Dependency Pattern:\n");
                    $fwrite(file_ptr, "      Both waiting:   %0d (%.1f%%)\n", 
                        rs2_waiting_both, (rs2_waiting_both * 100.0) / rs2_operands_not_ready);
                    $fwrite(file_ptr, "      Only A waiting: %0d (%.1f%%)\n", 
                        rs2_waiting_only_a, (rs2_waiting_only_a * 100.0) / rs2_operands_not_ready);
                    $fwrite(file_ptr, "      Only B waiting: %0d (%.1f%%)\n", 
                        rs2_waiting_only_b, (rs2_waiting_only_b * 100.0) / rs2_operands_not_ready);
                    
                    $fwrite(file_ptr, "    Operand A waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs2_waiting_a_cdb0, 
                        (rs2_waiting_a_cdb0 * 100.0) / (rs2_waiting_only_a + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs2_waiting_a_cdb1, 
                        (rs2_waiting_a_cdb1 * 100.0) / (rs2_waiting_only_a + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs2_waiting_a_cdb2, 
                        (rs2_waiting_a_cdb2 * 100.0) / (rs2_waiting_only_a + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs2_waiting_a_cdb3, 
                        (rs2_waiting_a_cdb3 * 100.0) / (rs2_waiting_only_a + rs2_waiting_both));
                    
                    $fwrite(file_ptr, "    Operand B waiting for:\n");
                    $fwrite(file_ptr, "      CDB0: %0d (%.1f%%)\n", rs2_waiting_b_cdb0, 
                        (rs2_waiting_b_cdb0 * 100.0) / (rs2_waiting_only_b + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB1: %0d (%.1f%%)\n", rs2_waiting_b_cdb1, 
                        (rs2_waiting_b_cdb1 * 100.0) / (rs2_waiting_only_b + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB2: %0d (%.1f%%)\n", rs2_waiting_b_cdb2, 
                        (rs2_waiting_b_cdb2 * 100.0) / (rs2_waiting_only_b + rs2_waiting_both));
                    $fwrite(file_ptr, "      CDB3: %0d (%.1f%%)\n", rs2_waiting_b_cdb3, 
                        (rs2_waiting_b_cdb3 * 100.0) / (rs2_waiting_only_b + rs2_waiting_both));
                end
                
                $fwrite(file_ptr, "\n");
                $fflush(file_ptr);
            end
        end
    end

    // Close file on finish
    final begin
        $fwrite(file_ptr, "\n========================================\n");
        $fwrite(file_ptr, "FINAL REPORT\n");
        $fwrite(file_ptr, "========================================\n\n");
        
        $fwrite(file_ptr, "Total Instruction Mix:\n");
        $fwrite(file_ptr, "  Commits:       %0d\n", commit_count_total);
        $fwrite(file_ptr, "  Branches:      %0d\n", branch_count_total);
        $fwrite(file_ptr, "  Mispredicts:   %0d\n", mispred_count_total);
        $fwrite(file_ptr, "  Load/Stores:   %0d\n", ls_count_total);

        $fclose(file_ptr);
    end

endmodule
