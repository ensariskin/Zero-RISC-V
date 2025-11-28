`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: register_alias_table
//
// Description:
//     Register Alias Table (RAT) for Tomasulo-based superscalar processor.
//     Maps architectural registers (x0-x31) to physical registers (0-63).
//     Handles 3-way superscalar rename operations per cycle.
//
// Features:
//     - 32 architectural → 64 physical register mapping (32 in Register File, 32 in ROB)
//     - 3-way parallel rename for superscalar decode
//     - Free list management for available physical registers (using circular buffer)
//     - Commit interface for freeing old physical registers
//     - x0 always maps to physical register 0 (hardwired zero)
//     - BRAT v2: In-order branch resolution with combinational bypass
//
// Branch Resolution Flow:
//     Execute Stage → BRAT (resolution buffer) → Other modules (ROB, RS, LSQ, Fetch)
//     BRAT ensures in-order branch resolution outputs
//////////////////////////////////////////////////////////////////////////////////

module register_alias_table #(
    parameter ARCH_REGS = 32,
    parameter PHYS_REGS = 64,
    parameter ARCH_ADDR_WIDTH = $clog2(ARCH_REGS),
    parameter PHYS_ADDR_WIDTH = $clog2(PHYS_REGS),
    parameter BRAT_STACK_DEPTH = 16,
    parameter DATA_WIDTH = 32
)(
    input logic clk,
    input logic reset,
    input logic flush,

    // 3-way decode interface (architectural register addresses from decoders)
    input logic [ARCH_ADDR_WIDTH-1:0] rs1_arch_0, rs1_arch_1, rs1_arch_2,
    input logic [ARCH_ADDR_WIDTH-1:0] rs2_arch_0, rs2_arch_1, rs2_arch_2,
    input logic [ARCH_ADDR_WIDTH-1:0] rd_arch_0, rd_arch_1, rd_arch_2,
    input logic [2:0] decode_valid,
    input logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2,
    input logic branch_0, branch_1, branch_2,
    
    // Rename outputs (physical register addresses)
    output logic [PHYS_ADDR_WIDTH-1:0] rs1_phys_0, rs1_phys_1, rs1_phys_2,
    output logic [PHYS_ADDR_WIDTH-1:0] rs2_phys_0, rs2_phys_1, rs2_phys_2,
    output logic [PHYS_ADDR_WIDTH-1:0] rd_phys_0, rd_phys_1, rd_phys_2,
    output logic [2:0] alloc_tag_0, alloc_tag_1, alloc_tag_2, 
    output logic [PHYS_ADDR_WIDTH-1:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2,
    output logic [2:0] rename_valid,
    output logic [2:0] rename_ready, // Indicates RAT can allocate physical registers
    

    // Commit interface (from ROB - frees old physical registers)
    input logic [4:0] commit_addr_0,
    input logic [4:0] commit_addr_1,
    input logic [4:0] commit_addr_2,
    input logic [4:0] commit_rob_idx_0,
    input logic [4:0] commit_rob_idx_1,
    input logic [4:0] commit_rob_idx_2,
    input logic [2:0] commit_valid,

    input logic load_store_0, load_store_1, load_store_2, // Indicates if instruction is load/store (for LSQ allocation)
    output logic [2:0] lsq_alloc_ready,
    output logic lsq_alloc_0_valid, lsq_alloc_1_valid, lsq_alloc_2_valid,
    input logic lsq_commit_0,
    input logic lsq_commit_1,
    input logic lsq_commit_2,
    
    // Eager misprediction flush interface (for LSQ circular buffer)
    input logic lsq_flush_valid_i,                      // LSQ flush is needed
    input logic [4:0] first_invalid_lsq_idx_i,          // First invalid LSQ index (new tail)

    //==========================================================================
    // Execute stage inputs (raw branch results - go into BRAT)
    //==========================================================================
    input logic [2:0] exec_branch_valid_i,              // Branch executed on FU 0/1/2
    input logic [2:0] exec_mispredicted_i,              // Misprediction flag from FU 0/1/2
    input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_0_i,  // ROB ID (phys_reg) of branch on FU0
    input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_1_i,  // ROB ID (phys_reg) of branch on FU1
    input logic [PHYS_ADDR_WIDTH-1:0] exec_rob_id_2_i,  // ROB ID (phys_reg) of branch on FU2
    input logic [DATA_WIDTH-1:0] exec_correct_pc_0_i,   // Correct PC from FU0
    input logic [DATA_WIDTH-1:0] exec_correct_pc_1_i,   // Correct PC from FU1
    input logic [DATA_WIDTH-1:0] exec_correct_pc_2_i,   // Correct PC from FU2
    
    //==========================================================================
    // Branch resolution outputs (in-order, from BRAT - go to other modules)
    //==========================================================================
    output logic [2:0] branch_resolved_o,               // In-order resolved branches
    output logic [2:0] branch_mispredicted_o,           // In-order misprediction flags
    output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_0_o,  // ROB ID of oldest resolved
    output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_1_o,  // ROB ID of 2nd oldest resolved
    output logic [PHYS_ADDR_WIDTH-1:0] resolved_phys_reg_2_o,  // ROB ID of 3rd oldest resolved
    output logic [DATA_WIDTH-1:0] correct_pc_0_o,       // Correct PC for oldest
    output logic [DATA_WIDTH-1:0] correct_pc_1_o,       // Correct PC for 2nd oldest
    output logic [DATA_WIDTH-1:0] correct_pc_2_o        // Correct PC for 3rd oldest
);

    localparam D = 1;

    // Register Alias Table - maps arch reg to current physical reg
    logic [PHYS_ADDR_WIDTH-1:0] rat_table [ARCH_REGS-1:0];

    //==========================================================================
    // BRAT v2 Signals
    //==========================================================================
    
    // Push interface signals
    logic [2:0] brat_push_en;
    logic [PHYS_ADDR_WIDTH-1:0] brat_push_snapshot_0 [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] brat_push_snapshot_1 [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] brat_push_snapshot_2 [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] brat_push_phys_0, brat_push_phys_1, brat_push_phys_2;
    
    // BRAT output signals (in-order resolution)
    logic brat_resolved_0, brat_resolved_1, brat_resolved_2;
    logic brat_mispredicted_0, brat_mispredicted_1, brat_mispredicted_2;
    logic [DATA_WIDTH-1:0] brat_correct_pc_0, brat_correct_pc_1, brat_correct_pc_2;
    logic [PHYS_ADDR_WIDTH-1:0] brat_resolved_phys_0, brat_resolved_phys_1, brat_resolved_phys_2;
    
    // Restore interface
    logic [PHYS_ADDR_WIDTH-1:0] brat_restore_snapshot [ARCH_REGS-1:0];
    
    // Status
    logic brat_empty, brat_full;

    // Free List - available physical registers
    logic [5:0] free_count;
    logic [5:0] lsq_free_count;

    // Internal allocation signals
    logic [PHYS_ADDR_WIDTH-1:0] allocated_phys_reg [2:0];
    logic [2:0] allocation_success;

    // Find available physical registers
    logic [5:0] first_free, second_free, third_free;
    logic found_first, found_second, found_third;

    logic lsq_found_first, lsq_found_second, lsq_found_third;

    // Allocation requirement signals
    logic need_alloc_0, need_alloc_1, need_alloc_2;
    logic need_lsq_alloc_0, need_lsq_alloc_1, need_lsq_alloc_2;

    //==========================================================================
    // Connect BRAT outputs to module outputs
    //==========================================================================
    assign branch_resolved_o = {brat_resolved_2, brat_resolved_1, brat_resolved_0};
    assign branch_mispredicted_o = {brat_mispredicted_2, brat_mispredicted_1, brat_mispredicted_0};
    assign resolved_phys_reg_0_o = brat_resolved_phys_0;
    assign resolved_phys_reg_1_o = brat_resolved_phys_1;
    assign resolved_phys_reg_2_o = brat_resolved_phys_2;
    assign correct_pc_0_o = brat_correct_pc_0;
    assign correct_pc_1_o = brat_correct_pc_1;
    assign correct_pc_2_o = brat_correct_pc_2;

    //==========================================================================
    // Free address buffer set logic - now uses BRAT outputs (in-order!)
    //==========================================================================
    logic free_addr_set_en;
    logic [PHYS_ADDR_WIDTH-1:0] free_addr_set_value;

    always_comb begin
        // Use BRAT's in-order outputs for free address buffer reset
        // Priority: oldest mispredicted branch first
        if (brat_resolved_0 && brat_mispredicted_0) begin
            free_addr_set_en = 1'b1;
            free_addr_set_value = brat_resolved_phys_0;
        end else if (brat_resolved_1 && brat_mispredicted_1) begin
            free_addr_set_en = 1'b1;
            free_addr_set_value = brat_resolved_phys_1;
        end else if (brat_resolved_2 && brat_mispredicted_2) begin
            free_addr_set_en = 1'b1;
            free_addr_set_value = brat_resolved_phys_2;
        end else begin
            free_addr_set_en = 1'b0;
            free_addr_set_value = '0;
        end
    end

    circular_buffer_3port free_address_buffer(
        .clk(clk),
        .rst_n(reset),
        .read_en_0(need_alloc_0),
        .read_en_1(need_alloc_1),
        .read_en_2(need_alloc_2),
        .read_data_0(first_free),
        .read_data_1(second_free),
        .read_data_2(third_free),
        .read_valid_0(found_first),
        .read_valid_1(found_second),
        .read_valid_2(found_third),
        .write_en_0(commit_valid[0]),
        .write_en_1(commit_valid[1]),
        .write_en_2(commit_valid[2]),
        .buffer_empty(),
        .buffer_full(),
        .buffer_count(free_count),
        .set_read_ptr_en(free_addr_set_en),
        .set_read_ptr_value(free_addr_set_value)
    );
    
    circular_buffer_3port #(.BUFFER_DEPTH(32)) lsq_address_buffer(
        .clk(clk),
        .rst_n(reset),
        .read_en_0(need_lsq_alloc_0),
        .read_en_1(need_lsq_alloc_1),
        .read_en_2(need_lsq_alloc_2),
        .read_data_0(),  // Not used externally
        .read_data_1(),  // Not used externally
        .read_data_2(),  // Not used externally
        .read_valid_0(lsq_found_first),
        .read_valid_1(lsq_found_second),
        .read_valid_2(lsq_found_third),
        .write_en_0(lsq_commit_0),
        .write_en_1(lsq_commit_1),
        .write_en_2(lsq_commit_2),
        .buffer_empty(),
        .buffer_full(),
        .buffer_count(lsq_free_count),
        // Eager misprediction flush - set read pointer to first invalid LSQ index
        .set_read_ptr_en(lsq_flush_valid_i),
        .set_read_ptr_value(first_invalid_lsq_idx_i)
    );
    
    // Count free registers
    assign rename_ready = (free_count >= 3) ? 3'b111 :
                          (free_count == 2) ? 3'b011 :
                          (free_count == 1) ? 3'b001 : 3'b000;

    assign lsq_alloc_ready = (lsq_free_count >= 3) ? 3'b111 :
                             (lsq_free_count == 2) ? 3'b011 :
                             (lsq_free_count == 1) ? 3'b001 : 3'b000;

    // Pre-compute allocation requirements (separate combinational logic)
    always_comb begin
        need_alloc_0 = decode_valid[0];
        need_alloc_1 = decode_valid[1]; 
        need_alloc_2 = decode_valid[2]; 
        
        need_lsq_alloc_0 = decode_valid[0] && load_store_0;
        need_lsq_alloc_1 = decode_valid[1] && load_store_1;
        need_lsq_alloc_2 = decode_valid[2] && load_store_2;

        alloc_tag_0 = need_lsq_alloc_0 ? 3'b011: 3'b000;
        alloc_tag_1 = need_lsq_alloc_1 ? 3'b011: 3'b001;
        alloc_tag_2 = need_lsq_alloc_2 ? 3'b011: 3'b010;
    end

    logic [PHYS_ADDR_WIDTH-1:0] rat_with_commits [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] rat_after_inst0 [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] rat_after_inst1 [ARCH_REGS-1:0];
    logic [PHYS_ADDR_WIDTH-1:0] rat_after_inst2 [ARCH_REGS-1:0];
  
    // First: Apply commits to rat_table (same-cycle commit forwarding)
    // Commits happen when ROB retires - they restore arch reg to RF mapping
    always_comb begin
        rat_with_commits = rat_table;
        
        // Apply commit 0: If committing reg still points to this ROB entry, restore to RF
        if (commit_valid[0] && commit_addr_0 != 0) begin
            if (commit_rob_idx_0 == rat_table[commit_addr_0][4:0]) begin
                rat_with_commits[commit_addr_0] = {1'b0, commit_addr_0};
            end
        end
        
        // Apply commit 1
        if (commit_valid[1] && commit_addr_1 != 0) begin
            if (commit_rob_idx_1 == rat_with_commits[commit_addr_1][4:0]) begin
                rat_with_commits[commit_addr_1] = {1'b0, commit_addr_1};
            end
        end
        
        // Apply commit 2
        if (commit_valid[2] && commit_addr_2 != 0) begin
            if (commit_rob_idx_2 == rat_with_commits[commit_addr_2][4:0]) begin
                rat_with_commits[commit_addr_2] = {1'b0, commit_addr_2};
            end
        end
    end
    
    // Then: Apply new allocations on top of committed RAT
    always_comb begin
        rat_after_inst0 = rat_with_commits;
        if (need_alloc_0 && allocation_success[0] && rd_arch_0 != 0) begin
            rat_after_inst0[rd_arch_0] = allocated_phys_reg[0];
        end

        rat_after_inst1 = rat_after_inst0;
        if (need_alloc_1 && allocation_success[1] && rd_arch_1 != 0) begin
            rat_after_inst1[rd_arch_1] = allocated_phys_reg[1];
        end

        rat_after_inst2 = rat_after_inst1;
        if (need_alloc_2 && allocation_success[2] && rd_arch_2 != 0) begin
            rat_after_inst2[rd_arch_2] = allocated_phys_reg[2];
        end
    end

    //==========================================================================
    // BRAT v2 CIRCULAR BUFFER INSTANCE
    //==========================================================================
    
    // Restore enable from BRAT misprediction detection
    logic brat_restore_en;
    assign brat_restore_en = (brat_resolved_0 && brat_mispredicted_0) ||
                             (brat_resolved_1 && brat_mispredicted_1) ||
                             (brat_resolved_2 && brat_mispredicted_2);
    
    // Restore index (which snapshot to use)
    logic [1:0] brat_restore_idx;
    always_comb begin
        if (brat_resolved_0 && brat_mispredicted_0)
            brat_restore_idx = 2'b00;
        else if (brat_resolved_1 && brat_mispredicted_1)
            brat_restore_idx = 2'b01;
        else
            brat_restore_idx = 2'b10;
    end
    
    brat_circular_buffer #(
        .BUFFER_DEPTH(BRAT_STACK_DEPTH),
        .ARCH_REGS(ARCH_REGS),
        .PHYS_ADDR_WIDTH(PHYS_ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) brat_buffer (
        .clk(clk),
        .rst_n(reset),
        
        // Push interface (from decode/rename)
        .push_en_0(brat_push_en[0]),
        .push_en_1(brat_push_en[1]),
        .push_en_2(brat_push_en[2]),
        .push_rat_snapshot_0(brat_push_snapshot_0),
        .push_rat_snapshot_1(brat_push_snapshot_1),
        .push_rat_snapshot_2(brat_push_snapshot_2),
        .push_branch_phys_0(brat_push_phys_0),
        .push_branch_phys_1(brat_push_phys_1),
        .push_branch_phys_2(brat_push_phys_2),
        
        // Execute result write interface (from execute stage)
        .exec_valid_0(exec_branch_valid_i[0]),
        .exec_valid_1(exec_branch_valid_i[1]),
        .exec_valid_2(exec_branch_valid_i[2]),
        .exec_rob_id_0(exec_rob_id_0_i),
        .exec_rob_id_1(exec_rob_id_1_i),
        .exec_rob_id_2(exec_rob_id_2_i),
        .exec_mispredicted_0(exec_mispredicted_i[0]),
        .exec_mispredicted_1(exec_mispredicted_i[1]),
        .exec_mispredicted_2(exec_mispredicted_i[2]),
        .exec_correct_pc_0(exec_correct_pc_0_i),
        .exec_correct_pc_1(exec_correct_pc_1_i),
        .exec_correct_pc_2(exec_correct_pc_2_i),
        
        // Branch resolution outputs (in-order)
        .branch_resolved_o_0(brat_resolved_0),
        .branch_resolved_o_1(brat_resolved_1),
        .branch_resolved_o_2(brat_resolved_2),
        .branch_mispredicted_o_0(brat_mispredicted_0),
        .branch_mispredicted_o_1(brat_mispredicted_1),
        .branch_mispredicted_o_2(brat_mispredicted_2),
        .correct_pc_o_0(brat_correct_pc_0),
        .correct_pc_o_1(brat_correct_pc_1),
        .correct_pc_o_2(brat_correct_pc_2),
        .resolved_phys_reg_o_0(brat_resolved_phys_0),
        .resolved_phys_reg_o_1(brat_resolved_phys_1),
        .resolved_phys_reg_o_2(brat_resolved_phys_2),
        
        // Restore interface
        .restore_en(1'b0),  // Internal restore handled by BRAT
        .restore_idx(brat_restore_idx),
        .restore_rat_snapshot(brat_restore_snapshot),
        
        // Peek interface (not used, connect to open)
        .peek_branch_phys_0(),
        .peek_branch_phys_1(),
        .peek_branch_phys_2(),
        .peek_valid_0(),
        .peek_valid_1(),
        .peek_valid_2(),
        
        // Status
        .buffer_empty(brat_empty),
        .buffer_full(brat_full),
        .buffer_count()
    );

    //==========================================================================
    // BRAT PUSH CONTROL LOGIC
    //==========================================================================
    
    always_comb begin
        // Push: Add new branch to BRAT
        brat_push_en[0] = decode_valid[0] && branch_0 && !brat_full && !brat_restore_en;
        brat_push_en[1] = decode_valid[1] && branch_1 && !brat_full && !brat_restore_en;
        brat_push_en[2] = decode_valid[2] && branch_2 && !brat_full && !brat_restore_en;
        
        // Push snapshots - Store RAT state AFTER the branch instruction
        // This includes same-cycle commits + the branch's own allocation
        // On misprediction restore, instructions after this branch are flushed
        // but the branch itself and older instructions keep their mappings
        // rat_with_commits = base state with commits applied
        // rat_after_inst0  = after inst0's allocation (includes commits)
        // rat_after_inst1  = after inst1's allocation
        // rat_after_inst2  = after inst2's allocation
        brat_push_snapshot_0 = rat_after_inst0;  // Branch 0: state after branch 0
        brat_push_snapshot_1 = rat_after_inst1;  // Branch 1: state after branch 1
        brat_push_snapshot_2 = rat_after_inst2;  // Branch 2: state after branch 2
        
        brat_push_phys_0 = allocated_phys_reg[0];
        brat_push_phys_1 = allocated_phys_reg[1];
        brat_push_phys_2 = allocated_phys_reg[2];
    end

    // Allocate physical registers for new destinations
    always_comb begin
        // Initialize
        allocated_phys_reg[0] = 6'h0;
        allocated_phys_reg[1] = 6'h0;
        allocated_phys_reg[2] = 6'h0;
        allocation_success = 3'b000;

        // Allocation logic with explicit ordering (no self-dependencies)
        if (need_alloc_0 && found_first) begin
            allocated_phys_reg[0] = first_free;
            allocation_success[0] = 1'b1;
        end

        if (need_alloc_1 && found_second) begin
            allocated_phys_reg[1] = second_free;
            allocation_success[1] = 1'b1;
        end

        if (need_alloc_2 && found_third) begin
            allocated_phys_reg[2] = third_free;
            allocation_success[2] = 1'b1;
        end
    end 

    always_comb begin
        // LSQ Allocation logic
        lsq_alloc_0_valid = need_lsq_alloc_0 && lsq_found_first;
        lsq_alloc_1_valid = need_lsq_alloc_1 && lsq_found_second;
        lsq_alloc_2_valid = need_lsq_alloc_2 && lsq_found_third;
    end

    //==========================================================================
    // RAT LOOKUP (COMBINATIONAL)
    //==========================================================================

    logic rs1_arch_1_equal_rd_arch_0;
    logic rs2_arch_1_equal_rd_arch_0;

    logic rs1_arch_2_equal_rd_arch_0;
    logic rs2_arch_2_equal_rd_arch_0;

    logic rs1_arch_2_equal_rd_arch_1;
    logic rs2_arch_2_equal_rd_arch_1;

    assign rs1_arch_1_equal_rd_arch_0 = (rs1_arch_1 == rd_arch_0) && (rd_arch_0 != 5'h0) && decode_valid[0] && rd_write_enable_0;
    assign rs2_arch_1_equal_rd_arch_0 = (rs2_arch_1 == rd_arch_0) && (rd_arch_0 != 5'h0) && decode_valid[0] && rd_write_enable_0;

    assign rs1_arch_2_equal_rd_arch_0 = (rs1_arch_2 == rd_arch_0) && (rd_arch_0 != 5'h0) && decode_valid[0] && rd_write_enable_0;
    assign rs2_arch_2_equal_rd_arch_0 = (rs2_arch_2 == rd_arch_0) && (rd_arch_0 != 5'h0) && decode_valid[0] && rd_write_enable_0;
    assign rs1_arch_2_equal_rd_arch_1 = (rs1_arch_2 == rd_arch_1) && (rd_arch_1 != 5'h0) && decode_valid[1] && rd_write_enable_1;
    assign rs2_arch_2_equal_rd_arch_1 = (rs2_arch_2 == rd_arch_1) && (rd_arch_1 != 5'h0) && decode_valid[1] && rd_write_enable_1;

    // Source register lookups (always use current RAT mapping)
    assign rs1_phys_0 = rat_table[rs1_arch_0];
    assign rs2_phys_0 = rat_table[rs2_arch_0];

    assign rs1_phys_1 = rs1_arch_1_equal_rd_arch_0 ? rd_phys_0 : rat_table[rs1_arch_1];
    assign rs2_phys_1 = rs2_arch_1_equal_rd_arch_0 ? rd_phys_0 : rat_table[rs2_arch_1];

    assign rs1_phys_2 = rs1_arch_2_equal_rd_arch_1 ? rd_phys_1 : rs1_arch_2_equal_rd_arch_0 ? rd_phys_0 : rat_table[rs1_arch_2];
    assign rs2_phys_2 = rs2_arch_2_equal_rd_arch_1 ? rd_phys_1 : rs2_arch_2_equal_rd_arch_0 ? rd_phys_0 : rat_table[rs2_arch_2];

    // Destination register handling
    always_comb begin
        // Instruction 0
        if (need_alloc_0) begin
            rd_phys_0 = allocated_phys_reg[0];
            old_rd_phys_0 = rat_table[rd_arch_0];
            rename_valid[0] = allocation_success[0];
        end else begin
            rd_phys_0 = 6'h0;
            old_rd_phys_0 = 6'h0;
            rename_valid[0] = 1'b0;
        end

        // Instruction 1
        if (need_alloc_1) begin
            rd_phys_1 = allocated_phys_reg[1];
            old_rd_phys_1 = rat_table[rd_arch_1];
            rename_valid[1] = allocation_success[1];
        end else begin
            rd_phys_1 = 6'h0;
            old_rd_phys_1 = 6'h0;
            rename_valid[1] = 1'b0;
        end

        // Instruction 2
        if (need_alloc_2) begin
            rd_phys_2 = allocated_phys_reg[2];
            old_rd_phys_2 = rat_table[rd_arch_2];
            rename_valid[2] = allocation_success[2];
        end else begin
            rd_phys_2 = 6'h0;
            old_rd_phys_2 = 6'h0;
            rename_valid[2] = 1'b0;
        end
    end

    //==========================================================================
    // RAT UPDATES (SEQUENTIAL)
    //==========================================================================

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Initialize RAT - each architectural register maps to itself initially
            for (int i = 0; i < ARCH_REGS; i++) begin
                rat_table[i] <= #D i[PHYS_ADDR_WIDTH-1:0];
            end
        end else begin
            // Misprediction: Restore RAT from BRAT snapshot
            if (brat_restore_en) begin
                for (int i = 0; i < ARCH_REGS; i++) begin
                    rat_table[i] <= #D brat_restore_snapshot[i];
                end
            end else begin
                // Normal operation: Update RAT for commits and new allocations
                
                // Commit: Restore architectural register to RF mapping when ROB commits
                if(commit_valid[0] && commit_addr_0 != 0) begin
                    if(commit_rob_idx_0 == rat_table[commit_addr_0][4:0]) begin
                        rat_table[commit_addr_0] <= #D {1'b0, commit_addr_0};
                    end
                end
                if(commit_valid[1] && commit_addr_1 != 0) begin
                    if(commit_rob_idx_1 == rat_table[commit_addr_1][4:0]) begin
                        rat_table[commit_addr_1] <= #D {1'b0, commit_addr_1};
                    end
                end
                if(commit_valid[2] && commit_addr_2 != 0) begin
                    if(commit_rob_idx_2 == rat_table[commit_addr_2][4:0]) begin
                        rat_table[commit_addr_2] <= #D {1'b0, commit_addr_2};
                    end
                end

                // Rename: Update RAT for new allocations
                if (need_alloc_0 && rd_arch_0 != 0) begin
                    rat_table[rd_arch_0] <= #D allocated_phys_reg[0];
                end

                if (need_alloc_1 && rd_arch_1 != 0) begin
                    rat_table[rd_arch_1] <= #D allocated_phys_reg[1];
                end

                if (need_alloc_2 && rd_arch_2 != 0) begin
                    rat_table[rd_arch_2] <= #D allocated_phys_reg[2];
                end
            end

            // Global flush: Reset RAT to identity mapping
            if (flush) begin
                for (int i = 0; i < ARCH_REGS; i++) begin
                    rat_table[i] <= #D i[PHYS_ADDR_WIDTH-1:0];
                end
            end
        end
    end

    //==========================================================================
    // ASSERTIONS FOR DEBUGGING
    //==========================================================================

    // synthesis translate_off
    // Ensure x0 always maps to physical register 0
    always_ff @(posedge clk) begin
        assert(rat_table[0] == 6'h0) else $error("RAT: x0 must always map to physical register 0");
    end

    // Check for free list underflow
    always_ff @(posedge clk) begin
        if (decode_valid != 3'b000) begin
            automatic int needed = 0;
            if (decode_valid[0] && rd_write_enable_0 && rd_arch_0 != 5'h0) needed++;
            if (decode_valid[1] && rd_write_enable_1 && rd_arch_1 != 5'h0) needed++;
            if (decode_valid[2] && rd_write_enable_2 && rd_arch_2 != 5'h0) needed++;
            assert(free_count >= needed) else $error("RAT: Not enough free physical registers");
        end
    end

    always_ff @(posedge clk) begin
        if (|brat_push_en && brat_full) begin
            $error("RAT: BRAT buffer overflow!");
        end
    end

    always_ff @(posedge clk) begin
        if (brat_restore_en && brat_empty) begin
            $error("RAT: BRAT buffer underflow!");
        end
    end
    // synthesis translate_on

endmodule
