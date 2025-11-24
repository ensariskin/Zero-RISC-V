`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: brat_circular_buffer
//
// Description:
//     Circular buffer implementation for Branch Register Alias Table (BRAT)
//     Stores RAT snapshots for branch misprediction recovery
//     Uses head/tail pointers for efficient FIFO operation
//
// Features:
//     - Circular FIFO with head/tail pointers
//     - 3-way parallel push/pop operations
//     - Peek interface for oldest 3 entries (non-destructive read)
//     - Restore interface with index selection (0=oldest, 1=2nd, 2=3rd)
//     - Automatic pointer wraparound
//     - O(1) push/pop operations (no data shifting)
//////////////////////////////////////////////////////////////////////////////////

module brat_circular_buffer #(
    parameter BUFFER_DEPTH = 16,
    parameter ARCH_REGS = 32,
    parameter PHYS_ADDR_WIDTH = 6
)(
    input logic clk,
    input logic rst_n,
    
    // Push interface (3-way parallel)
    input logic push_en_0,
    input logic push_en_1,
    input logic push_en_2,
    input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_0 [ARCH_REGS-1:0],
    input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_1 [ARCH_REGS-1:0],
    input logic [PHYS_ADDR_WIDTH-1:0] push_rat_snapshot_2 [ARCH_REGS-1:0],
    input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_0,
    input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_1,
    input logic [PHYS_ADDR_WIDTH-1:0] push_branch_phys_2,
    
    // Pop interface (3-way parallel) - advances head pointer
    input logic pop_en_0,
    input logic pop_en_1,
    input logic pop_en_2,
    
    // Restore interface - indexed snapshot retrieval + buffer flush
    input logic restore_en,
    input logic [1:0] restore_idx,  // 0=oldest, 1=2nd oldest, 2=3rd oldest
    output logic [PHYS_ADDR_WIDTH-1:0] restore_rat_snapshot [ARCH_REGS-1:0],
    
    // Peek interface - non-destructive read of oldest 3 branches
    output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_0,
    output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_1,
    output logic [PHYS_ADDR_WIDTH-1:0] peek_branch_phys_2,
    output logic peek_valid_0,
    output logic peek_valid_1,
    output logic peek_valid_2,
    
    // Status
    output logic buffer_empty,
    output logic buffer_full,
    output logic [$clog2(BUFFER_DEPTH):0] buffer_count
);

    localparam PTR_WIDTH = $clog2(BUFFER_DEPTH) + 1; // Extra bit for full/empty detection
    
    // Storage
    logic [PHYS_ADDR_WIDTH-1:0] buffer_mem [BUFFER_DEPTH-1:0];  // Branch physical registers
    logic [PHYS_ADDR_WIDTH-1:0] rat_snapshot_mem [BUFFER_DEPTH-1:0][ARCH_REGS-1:0];  // RAT snapshots
    
    // Pointers
    logic [PTR_WIDTH-1:0] head_ptr;  // Points to oldest entry
    logic [PTR_WIDTH-1:0] tail_ptr;  // Points to next free slot
    
    // Internal signals
    logic [PTR_WIDTH-1:0] next_head_ptr;
    logic [PTR_WIDTH-1:0] next_tail_ptr;
    logic [2:0] push_count;
    logic [2:0] pop_count;
    
    //==========================================================================
    // Buffer Status Logic
    //==========================================================================
    
    assign buffer_empty = (head_ptr == tail_ptr);
    assign buffer_full = (head_ptr[$clog2(BUFFER_DEPTH)-1:0] == tail_ptr[$clog2(BUFFER_DEPTH)-1:0]) && 
                         (head_ptr[PTR_WIDTH-1] != tail_ptr[PTR_WIDTH-1]);
    
    // Calculate buffer occupancy
    always_comb begin
        if (tail_ptr >= head_ptr) begin
            buffer_count = tail_ptr - head_ptr;
        end else begin
            buffer_count = BUFFER_DEPTH - head_ptr[$clog2(BUFFER_DEPTH)-1:0] + tail_ptr[$clog2(BUFFER_DEPTH)-1:0];
        end
    end
    
    //==========================================================================
    // Push/Pop Count Logic
    //==========================================================================
    
    always_comb begin
        push_count = {2'b00, push_en_0} + {2'b00, push_en_1} + {2'b00, push_en_2};
        pop_count = {2'b00, pop_en_0} + {2'b00, pop_en_1} + {2'b00, pop_en_2};
    end
    
    //==========================================================================
    // Pointer Update Logic
    //==========================================================================
    
    always_comb begin
        // Default: keep current values
        next_head_ptr = head_ptr;
        next_tail_ptr = tail_ptr;
        
        // Pop operations (advance head pointer)
        if (!buffer_empty && !restore_en) begin
            next_head_ptr = head_ptr + pop_count;
            if (next_head_ptr >= (BUFFER_DEPTH * 2)) begin
                next_head_ptr = next_head_ptr - (BUFFER_DEPTH * 2);
            end
        end
        
        // Push operations (advance tail pointer)
        if (!buffer_full && !restore_en) begin
            next_tail_ptr = tail_ptr + push_count;
            if (next_tail_ptr >= (BUFFER_DEPTH * 2)) begin
                next_tail_ptr = next_tail_ptr - (BUFFER_DEPTH * 2);
            end
        end
        
        // Restore operation: flush buffer (reset both pointers)
        if (restore_en) begin
            next_head_ptr = '0;
            next_tail_ptr = '0;
        end
    end
    
    //==========================================================================
    // Peek Interface - Read oldest 3 entries without modifying pointers
    //==========================================================================
    
    logic [PTR_WIDTH-1:0] peek_ptr_0, peek_ptr_1, peek_ptr_2;
    
    always_comb begin
        // Peek pointer 0: head (oldest)
        peek_ptr_0 = head_ptr;
        peek_valid_0 = (buffer_count >= 1);
        peek_branch_phys_0 = buffer_mem[peek_ptr_0[$clog2(BUFFER_DEPTH)-1:0]];
        
        // Peek pointer 1: head + 1 (second oldest)
        peek_ptr_1 = head_ptr + 1;
        if (peek_ptr_1 >= (BUFFER_DEPTH * 2)) begin
            peek_ptr_1 = peek_ptr_1 - (BUFFER_DEPTH * 2);
        end
        peek_valid_1 = (buffer_count >= 2);
        peek_branch_phys_1 = buffer_mem[peek_ptr_1[$clog2(BUFFER_DEPTH)-1:0]];
        
        // Peek pointer 2: head + 2 (third oldest)
        peek_ptr_2 = head_ptr + 2;
        if (peek_ptr_2 >= (BUFFER_DEPTH * 2)) begin
            peek_ptr_2 = peek_ptr_2 - (BUFFER_DEPTH * 2);
        end
        peek_valid_2 = (buffer_count >= 3);
        peek_branch_phys_2 = buffer_mem[peek_ptr_2[$clog2(BUFFER_DEPTH)-1:0]];
    end
    
    //==========================================================================
    // Restore Interface - Indexed snapshot retrieval
    //==========================================================================
    
    logic [PTR_WIDTH-1:0] restore_ptr;
    
    always_comb begin
        // Calculate restore pointer based on index
        restore_ptr = head_ptr + {3'b000, restore_idx};
        if (restore_ptr >= (BUFFER_DEPTH * 2)) begin
            restore_ptr = restore_ptr - (BUFFER_DEPTH * 2);
        end
        
        // Output the selected snapshot
        restore_rat_snapshot = rat_snapshot_mem[restore_ptr[$clog2(BUFFER_DEPTH)-1:0]];
    end
    
    logic [PTR_WIDTH-1:0] push_ptr_1; 
    logic [PTR_WIDTH-1:0] push_ptr_2;
    assign push_ptr_1 = tail_ptr + (push_en_0 ? 1 : 0);
    assign push_ptr_2 = tail_ptr + (push_en_0 ? 1 : 0) + (push_en_1 ? 1 : 0);
    //==========================================================================
    // Sequential Logic - Buffer Storage and Pointer Updates
    //==========================================================================
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            head_ptr <= '0;
            tail_ptr <= '0;
            
            // Clear buffer memory
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                buffer_mem[i] <= '0;
                for (int j = 0; j < ARCH_REGS; j++) begin
                    rat_snapshot_mem[i][j] <= '0;
                end
            end
        end else begin
            // Update pointers
            head_ptr <= next_head_ptr;
            tail_ptr <= next_tail_ptr;
            
            // Push operations - store data at tail position
            if (push_en_0 && !buffer_full) begin
                buffer_mem[tail_ptr[$clog2(BUFFER_DEPTH)-1:0]] <= push_branch_phys_0;
                rat_snapshot_mem[tail_ptr[$clog2(BUFFER_DEPTH)-1:0]] <= push_rat_snapshot_0;
            end
            
            if (push_en_1 && !buffer_full) begin
                buffer_mem[push_ptr_1[$clog2(BUFFER_DEPTH)-1:0]] <= push_branch_phys_1;
                rat_snapshot_mem[push_ptr_1[$clog2(BUFFER_DEPTH)-1:0]] <= push_rat_snapshot_1;
            end
            
            if (push_en_2 && !buffer_full) begin
                buffer_mem[push_ptr_2[$clog2(BUFFER_DEPTH)-1:0]] <= push_branch_phys_2;
                rat_snapshot_mem[push_ptr_2[$clog2(BUFFER_DEPTH)-1:0]] <= push_rat_snapshot_2;
            end
        end
    end
    
    //==========================================================================
    // Assertions
    //==========================================================================
    
    always_ff @(posedge clk) begin
        if (rst_n) begin
            // Check for overflow
            if ((push_en_0 || push_en_1 || push_en_2) && buffer_full) begin
                $error("BRAT Circular Buffer: Push attempted when buffer full!");
            end
            
            // Check for underflow
            if ((pop_en_0 || pop_en_1 || pop_en_2) && buffer_empty) begin
                $error("BRAT Circular Buffer: Pop attempted when buffer empty!");
            end
        end
    end

endmodule
