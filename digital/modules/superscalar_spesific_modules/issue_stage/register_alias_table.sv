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
//////////////////////////////////////////////////////////////////////////////////

module register_alias_table #(
    parameter ARCH_REGS = 32,
    parameter PHYS_REGS = 64,
    parameter ARCH_ADDR_WIDTH = $clog2(ARCH_REGS),
    parameter PHYS_ADDR_WIDTH = $clog2(PHYS_REGS)
)(
    input logic clk,
    input logic reset,
    
    // 3-way decode interface (architectural register addresses from decoders)
    input logic [ARCH_ADDR_WIDTH-1:0] rs1_arch_0, rs1_arch_1, rs1_arch_2,
    input logic [ARCH_ADDR_WIDTH-1:0] rs2_arch_0, rs2_arch_1, rs2_arch_2,
    input logic [ARCH_ADDR_WIDTH-1:0] rd_arch_0, rd_arch_1, rd_arch_2,
    input logic [2:0] decode_valid,
    input logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2,
    
    // Rename outputs (physical register addresses)
    output logic [PHYS_ADDR_WIDTH-1:0] rs1_phys_0, rs1_phys_1, rs1_phys_2,
    output logic [PHYS_ADDR_WIDTH-1:0] rs2_phys_0, rs2_phys_1, rs2_phys_2,
    output logic [PHYS_ADDR_WIDTH-1:0] rd_phys_0, rd_phys_1, rd_phys_2,
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
    input logic [2:0] commit_valid
    //input logic [PHYS_ADDR_WIDTH-1:0] free_phys_reg_0, free_phys_reg_1, free_phys_reg_2
    
);
    localparam D = 1; // Delay for non-blocking assignments (for simulation purposes)

    // Register Alias Table - maps arch reg to current physical reg
    logic [PHYS_ADDR_WIDTH-1:0] rat_table [ARCH_REGS-1:0];
    
    // Free List - available physical registers
    logic [5:0] free_count;
    
    // Internal allocation signals
    logic [PHYS_ADDR_WIDTH-1:0] allocated_phys_reg [2:0];
    logic [2:0] allocation_success;
    
    // Find available physical registers - SYNTHESIZABLE: Use proper triple priority encoder
    logic [5:0] first_free, second_free, third_free;
    logic found_first, found_second, found_third;
    
    // Allocation requirement signals
    logic need_alloc_0, need_alloc_1, need_alloc_2;
    
   /*  // Instantiate triple priority encoder
    triple_priority_encoder_ver3 #(
        .WIDTH(PHYS_REGS),
        .INDEX_WIDTH(PHYS_ADDR_WIDTH)
    ) priority_enc (
        .data_in(free_list),
        .first_enable(need_alloc_0),
        .second_enable(need_alloc_1),
        .third_enable(need_alloc_2),
        .first_index(first_free),
        .second_index(second_free),
        .third_index(third_free),
        .first_valid(found_first),
        .second_valid(found_second),
        .third_valid(found_third)
    );
    */

    
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
        //.write_data_0(free_phys_reg_0),
        //.write_data_1(free_phys_reg_1),
        //.write_data_2(free_phys_reg_2),
        .buffer_empty(),
        .buffer_full(),
        .buffer_count(free_count)
    );

    // Count free registers
    assign rename_ready = (free_count >= 3) ? 3'b111 :
                          (free_count == 2) ? 3'b011 :
                          (free_count == 1) ? 3'b001 : 3'b000;


    // Pre-compute allocation requirements (separate combinational logic)
    always_comb begin
        need_alloc_0 = decode_valid[0] && rd_write_enable_0 && rd_arch_0 != 5'h0;
        need_alloc_1 = decode_valid[1] && rd_write_enable_1 && rd_arch_1 != 5'h0;
        need_alloc_2 = decode_valid[2] && rd_write_enable_2 && rd_arch_2 != 5'h0;
    end
    
    // Allocate physical registers for new destinations - FIXED: No combinational loops
    always_comb begin
        // Initialize
        allocated_phys_reg[0] = 6'h0;
        allocated_phys_reg[1] = 6'h0;
        allocated_phys_reg[2] = 6'h0;
        allocation_success = 3'b000;
        
        // Allocation logic with explicit ordering (no self-dependencies)
        // Instruction 0: Gets first available register if needed
        if (need_alloc_0 && found_first) begin
            allocated_phys_reg[0] = first_free;
            allocation_success[0] = 1'b1;
        end
        
        // Instruction 1: Gets next available register based on inst 0's allocation
        if (need_alloc_1 && found_second) begin
            allocated_phys_reg[1] = second_free;
            allocation_success[1] = 1'b1;
        end

        // Instruction 1: Gets next available register based on inst 0's allocation
        if (need_alloc_2 && found_third) begin
            allocated_phys_reg[2] = third_free;
            allocation_success[2] = 1'b1;
        end
        
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
        if (decode_valid[0] && rd_write_enable_0 && rd_arch_0 != 5'h0) begin
            rd_phys_0 = allocated_phys_reg[0];
            old_rd_phys_0 = rat_table[rd_arch_0];
            rename_valid[0] = allocation_success[0];
        end else begin
            rd_phys_0 = 6'h0;
            old_rd_phys_0 = 6'h0;
            rename_valid[0] = 1'b0;
        end
        
        // Instruction 1
        if (decode_valid[1] && rd_write_enable_1 && rd_arch_1 != 5'h0) begin
            rd_phys_1 = allocated_phys_reg[1];
            old_rd_phys_1 = rat_table[rd_arch_1];
            rename_valid[1] = allocation_success[1];
        end else begin
            rd_phys_1 = 6'h0;
            old_rd_phys_1 = 6'h0;
            rename_valid[1] = 1'b0;
        end
        
        // Instruction 2
        if (decode_valid[2] && rd_write_enable_2 && rd_arch_2 != 5'h0) begin
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
            // Update RAT for new allocations
            if(commit_valid[0] && commit_addr_0 != 0) begin
                if(commit_rob_idx_0 == rat_table[commit_addr_0][4:0]) begin // Only free if the mapping matches
                    rat_table[commit_addr_0] <= #D {1'b0, commit_addr_0};
                end
            end
            if(commit_valid[1] && commit_addr_1 != 0) begin
                if(commit_rob_idx_1 == rat_table[commit_addr_1][4:0]) begin // Only free if the mapping matches
                    rat_table[commit_addr_1] <= #D {1'b0, commit_addr_1};
                end
            end
            if(commit_valid[2] && commit_addr_2 != 0) begin
                if(commit_rob_idx_2 == rat_table[commit_addr_2][4:0]) begin // Only free if the mapping matches
                    rat_table[commit_addr_2] <= #D {1'b0, commit_addr_2};
                end
            end

            if (decode_valid[0] && rd_write_enable_0 && rd_arch_0 != 5'h0 && allocation_success[0]) begin
                rat_table[rd_arch_0] <= #D allocated_phys_reg[0];
            end
            
            if (decode_valid[1] && rd_write_enable_1 && rd_arch_1 != 5'h0 && allocation_success[1]) begin
                rat_table[rd_arch_1] <= #D allocated_phys_reg[1];
            end
            
            if (decode_valid[2] && rd_write_enable_2 && rd_arch_2 != 5'h0 && allocation_success[2]) begin
                rat_table[rd_arch_2] <= #D allocated_phys_reg[2];
            end
            
            
        end
    end
    
    //==========================================================================
    // ASSERTIONS FOR DEBUGGING
    //==========================================================================
    
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

endmodule
