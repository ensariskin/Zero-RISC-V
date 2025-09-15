`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Module: tb_register_alias_table
//
// Description:
//     Comprehensive testbench for the Register Alias Table (RAT) module.
//     Tests all major functionality including:
//     - Single and multi-way register allocation
//     - Source register renaming
//     - Free list management
//     - Commit and deallocation
//     - Edge cases and error conditions
//////////////////////////////////////////////////////////////////////////////////

module tb_register_alias_table;

    // Parameters
    localparam ARCH_REGS = 32;
    localparam PHYS_REGS = 64;
    localparam ARCH_ADDR_WIDTH = 5;
    localparam PHYS_ADDR_WIDTH = 6;
    localparam CLK_PERIOD = 10; // 10ns = 100MHz

    // Testbench signals
    logic clk;
    logic reset;
    
    // DUT interface signals
    logic [ARCH_ADDR_WIDTH-1:0] rs1_arch_0, rs1_arch_1, rs1_arch_2;
    logic [ARCH_ADDR_WIDTH-1:0] rs2_arch_0, rs2_arch_1, rs2_arch_2;
    logic [ARCH_ADDR_WIDTH-1:0] rd_arch_0, rd_arch_1, rd_arch_2;
    logic [2:0] decode_valid;
    logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2;
    
    logic [PHYS_ADDR_WIDTH-1:0] rs1_phys_0, rs1_phys_1, rs1_phys_2;
    logic [PHYS_ADDR_WIDTH-1:0] rs2_phys_0, rs2_phys_1, rs2_phys_2;
    logic [PHYS_ADDR_WIDTH-1:0] rd_phys_0, rd_phys_1, rd_phys_2;
    logic [PHYS_ADDR_WIDTH-1:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2;
    logic [2:0] rename_valid;
    
    logic [2:0] commit_valid;
    logic [PHYS_ADDR_WIDTH-1:0] free_phys_reg_0, free_phys_reg_1, free_phys_reg_2;
    
    logic free_list_empty;
    logic [5:0] free_list_count;

    // Test tracking variables
    int test_count = 0;
    int pass_count = 0;
    int fail_count = 0;
    
    // Test helper variables
    logic [PHYS_ADDR_WIDTH-1:0] temp_phys_reg;
    logic [PHYS_ADDR_WIDTH-1:0] saved_old_phys [2:0];
    int allocation_count;
    
    //==========================================================================
    // DUT INSTANTIATION
    //==========================================================================
    
    register_alias_table #(
        .ARCH_REGS(ARCH_REGS),
        .PHYS_REGS(PHYS_REGS),
        .ARCH_ADDR_WIDTH(ARCH_ADDR_WIDTH),
        .PHYS_ADDR_WIDTH(PHYS_ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        
        .rs1_arch_0(rs1_arch_0), .rs1_arch_1(rs1_arch_1), .rs1_arch_2(rs1_arch_2),
        .rs2_arch_0(rs2_arch_0), .rs2_arch_1(rs2_arch_1), .rs2_arch_2(rs2_arch_2),
        .rd_arch_0(rd_arch_0), .rd_arch_1(rd_arch_1), .rd_arch_2(rd_arch_2),
        .decode_valid(decode_valid),
        .rd_write_enable_0(rd_write_enable_0), .rd_write_enable_1(rd_write_enable_1), .rd_write_enable_2(rd_write_enable_2),
        
        .rs1_phys_0(rs1_phys_0), .rs1_phys_1(rs1_phys_1), .rs1_phys_2(rs1_phys_2),
        .rs2_phys_0(rs2_phys_0), .rs2_phys_1(rs2_phys_1), .rs2_phys_2(rs2_phys_2),
        .rd_phys_0(rd_phys_0), .rd_phys_1(rd_phys_1), .rd_phys_2(rd_phys_2),
        .old_rd_phys_0(old_rd_phys_0), .old_rd_phys_1(old_rd_phys_1), .old_rd_phys_2(old_rd_phys_2),
        .rename_valid(rename_valid),
        
        .commit_valid(commit_valid),
        .free_phys_reg_0(free_phys_reg_0), .free_phys_reg_1(free_phys_reg_1), .free_phys_reg_2(free_phys_reg_2),
        
        .free_list_empty(free_list_empty),
        .free_list_count(free_list_count)
    );

    //==========================================================================
    // CLOCK GENERATION
    //==========================================================================
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    //==========================================================================
    // TEST UTILITY TASKS
    //==========================================================================
    
    // Initialize all inputs
    task init_inputs(input logic reset = 1);
        rs1_arch_0 = 0; rs1_arch_1 = 0; rs1_arch_2 = 0;
        rs2_arch_0 = 0; rs2_arch_1 = 0; rs2_arch_2 = 0;
        rd_arch_0 = 0; rd_arch_1 = 0; rd_arch_2 = 0;
        decode_valid = 3'b000;
        rd_write_enable_0 = 0; rd_write_enable_1 = 0; rd_write_enable_2 = 0;
        commit_valid = 3'b000;
        free_phys_reg_0 = 0; free_phys_reg_1 = 0; free_phys_reg_2 = 0;
        if (reset)
            apply_reset();
    endtask

    // Apply reset
    task apply_reset();
        reset = 0;
        @(posedge clk);
        @(posedge clk);
        reset = 1;
        @(posedge clk);
        $display("[%0t] Reset applied", $time);
    endtask

    // Wait for clock edges
    task wait_cycles(int cycles);
        repeat(cycles) @(posedge clk);
    endtask

    // Check test result
    task check_result(string test_name, logic condition);
        test_count++;
        if (condition) begin
            pass_count++;
            $display("[%0t] PASS: %s", $time, test_name);
        end else begin
            fail_count++;
            $display("[%0t] FAIL: %s", $time, test_name);
        end
    endtask

    // Issue a single instruction for renaming
    task issue_instruction(
        input int slot,
        input logic [ARCH_ADDR_WIDTH-1:0] rs1, rs2, rd,
        input logic rd_wr_en
    );
        case (slot)
            0: begin
                rs1_arch_0 = rs1; rs2_arch_0 = rs2; rd_arch_0 = rd;
                rd_write_enable_0 = rd_wr_en;
                decode_valid[0] = 1'b1;
            end
            1: begin
                rs1_arch_1 = rs1; rs2_arch_1 = rs2; rd_arch_1 = rd;
                rd_write_enable_1 = rd_wr_en;
                decode_valid[1] = 1'b1;
            end
            2: begin
                rs1_arch_2 = rs1; rs2_arch_2 = rs2; rd_arch_2 = rd;
                rd_write_enable_2 = rd_wr_en;
                decode_valid[2] = 1'b1;
            end
        endcase
    endtask

    // Commit a physical register
    task commit_register(
        input int slot,
        input logic [PHYS_ADDR_WIDTH-1:0] phys_reg
    );
        case (slot)
            0: begin
                free_phys_reg_0 = phys_reg;
                commit_valid[0] = 1'b1;
            end
            1: begin
                free_phys_reg_1 = phys_reg;
                commit_valid[1] = 1'b1;
            end
            2: begin
                free_phys_reg_2 = phys_reg;
                commit_valid[2] = 1'b1;
            end
        endcase
    endtask

    //==========================================================================
    // TEST SEQUENCES
    //==========================================================================

    // Test 1: Reset and Initial State
    task test_reset_and_initial_state();
        $display("\n=== TEST 1: Reset and Initial State ===");
        
        init_inputs();
        apply_reset();
        wait_cycles(2);
        
        // Check initial free list count (should be 32 free registers: 32-63)
        check_result("Initial free list count", free_list_count == 32);
        check_result("Free list not empty initially", !free_list_empty);
        
        // Check that x0 always maps to physical register 0
        rs1_arch_0 = 0;
        decode_valid = 3'b001;
        wait_cycles(1);
        check_result("x0 maps to physical register 0", rs1_phys_0 == 0);
        
        init_inputs();
        wait_cycles(1);
    endtask

    // Test 2: Single Instruction Rename
    task test_single_instruction_rename();
        $display("\n=== TEST 2: Single Instruction Rename ===");
        
        init_inputs();
        
        // Issue instruction: add x1, x2, x3 (rd=x1, rs1=x2, rs2=x3)
        issue_instruction(0, 5'd2, 5'd3, 5'd1, 1'b1);
        wait_cycles(1);
        
        // Check that rename was successful
        check_result("Single rename valid", rename_valid[0] == 1'b1);
        check_result("Source rs1 lookup", rs1_phys_0 == 2); // x2 initially maps to phys reg 2
        check_result("Source rs2 lookup", rs2_phys_0 == 3); // x3 initially maps to phys reg 3
        check_result("Old rd mapping saved", old_rd_phys_0 == 1); // x1 initially maps to phys reg 1
        check_result("New rd allocated", rd_phys_0 == 32); // Should get first free register (32)
        #1ns;
        check_result("Free list count decreased", free_list_count == 31);
        wait_cycles(1);
        
        
    endtask

    // Test 3: Three-Way Parallel Rename
    task test_three_way_parallel_rename();
        $display("\n=== TEST 3: Three-Way Parallel Rename ===");
        
        init_inputs();
        
        // Issue 3 instructions simultaneously
        // Inst 0: add x4, x1, x2
        // Inst 1: sub x5, x3, x4  
        // Inst 2: or x6, x5, x1
        issue_instruction(0, 5'd1, 5'd2, 5'd4, 1'b1);
        issue_instruction(1, 5'd3, 5'd4, 5'd5, 1'b1);
        issue_instruction(2, 5'd5, 5'd1, 5'd6, 1'b1);
        
        wait_cycles(1);
        
        // All renames should be successful
        check_result("Three-way rename all valid", rename_valid == 3'b111);
        #1ns;
        check_result("Three allocations made", free_list_count == 29); // Started with 31, allocated 3
        
        // Check source lookups use current RAT mappings
        check_result("Inst 0 rs1 lookup", rs1_phys_0 == 1);
        check_result("Inst 1 rs1 lookup", rs1_phys_1 == 3);
        check_result("Inst 2 rs1 lookup", rs1_phys_2 == 33);
        
        // Check new allocations are unique
        check_result("Unique allocation 0-1", rd_phys_0 != rd_phys_1);
        check_result("Unique allocation 0-2", rd_phys_0 != rd_phys_2);
        check_result("Unique allocation 1-2", rd_phys_1 != rd_phys_2);
        
       wait_cycles(1);
    endtask

    // Test 4: x0 Special Handling
    task test_x0_special_handling();
        $display("\n=== TEST 4: x0 Special Handling ===");
        
        init_inputs();
        
        // Try to rename x0 (should be ignored)
        issue_instruction(0, 5'd1, 5'd2, 5'd0, 1'b1);
        wait_cycles(1);
        
        check_result("x0 rename ignored", rename_valid[0] == 1'b0);
        check_result("No allocation for x0", free_list_count == 32); // Should remain unchanged
        
        // x0 should always read as physical register 0
        init_inputs();
        rs1_arch_0 = 0;
        rs2_arch_1 = 0;
        decode_valid = 3'b011;
        wait_cycles(1);
        
        check_result("x0 always maps to phys 0 (rs1)", rs1_phys_0 == 0);
        check_result("x0 always maps to phys 0 (rs2)", rs2_phys_1 == 0);
        
         wait_cycles(1);
    endtask

    // Test 5: Commit and Free List Recovery
    task test_commit_and_recovery();
        $display("\n=== TEST 5: Commit and Free List Recovery ===");
        
        init_inputs();
        
        // First, allocate some registers
        issue_instruction(0, 5'd1, 5'd2, 5'd3, 1'b1);
        issue_instruction(1, 5'd4, 5'd5, 5'd6, 1'b1);
        wait_cycles(1);
        
        // Save old physical registers for later commit
        saved_old_phys[0] = old_rd_phys_0;
        saved_old_phys[1] = old_rd_phys_1;
        #1ns;
        check_result("Two allocations made", free_list_count == 30);
        
        // Now commit the old physical registers
        init_inputs(.reset(0));
        commit_register(0, saved_old_phys[0]);
        commit_register(1, saved_old_phys[1]);
        wait_cycles(1);
        #1ns;
        check_result("Free list recovered after commit", free_list_count == 32);
        
        wait_cycles(1);
    endtask

    // Test 6: Free List Exhaustion
    task test_free_list_exhaustion();
        $display("\n=== TEST 6: Free List Exhaustion ===");
        
        init_inputs();
        apply_reset(); // Start fresh
        wait_cycles(1);
        
        // Allocate many registers to exhaust free list
        allocation_count = 0;
        for (int i = 1; i < 32; i += 3) begin
            init_inputs();
            if (i < 30) begin
                issue_instruction(0, 5'd0, 5'd0, i[4:0], 1'b1);
                issue_instruction(1, 5'd0, 5'd0, (i+1), 1'b1);
                issue_instruction(2, 5'd0, 5'd0, (i+2), 1'b1);
                allocation_count += 3;
            end else if (i < 31) begin
                issue_instruction(0, 5'd0, 5'd0, i[4:0], 1'b1);
                issue_instruction(1, 5'd0, 5'd0, (i+1), 1'b1);
                allocation_count += 2;
            end else begin
                issue_instruction(0, 5'd0, 5'd0, i[4:0], 1'b1);
                allocation_count += 1;
            end
            wait_cycles(1);
        end
        
        $display("Allocated %0d registers, free count: %0d", allocation_count, free_list_count);
        
        // Try to allocate when free list is empty/low
        init_inputs();
        issue_instruction(0, 5'd1, 5'd2, 5'd3, 1'b1);
        wait_cycles(1);
        
        if (free_list_count == 0) begin
            check_result("Allocation fails when free list empty", rename_valid[0] == 1'b0);
            check_result("Free list empty flag set", free_list_empty == 1'b1);
        end
        
        wait_cycles(1);
    endtask

    // Test 7: Source Register Dependency Chain
    task test_dependency_chain();
        $display("\n=== TEST 7: Source Register Dependency Chain ===");
        
        init_inputs();
        apply_reset();
        wait_cycles(1);
        
        // Create a dependency chain: x1 -> x2 -> x3
        // Instruction 1: add x1, x0, x0
        init_inputs(.reset(0));
        issue_instruction(0, 5'd0, 5'd0, 5'd1, 1'b1);
        wait_cycles(1);
        temp_phys_reg = rd_phys_0;  // Save new mapping of x1
        
        // Instruction 2: add x2, x1, x0 (should use new mapping of x1)
        init_inputs(.reset(0));
        issue_instruction(0, 5'd1, 5'd0, 5'd2, 1'b1);
        wait_cycles(1);
        
        check_result("x1 source uses new mapping", rs1_phys_0 == temp_phys_reg);
        temp_phys_reg = rd_phys_0;  // Save new mapping of x2
        
        // Instruction 3: add x3, x2, x1 (should use both new mappings)
        init_inputs(.reset(0));
        issue_instruction(0, 5'd2, 5'd1, 5'd3, 1'b1);
        wait_cycles(1);
        
        check_result("x2 source uses new mapping", rs1_phys_0 == temp_phys_reg);
        wait_cycles(1);
    endtask

    // Test 8: Simultaneous Allocation and Commit
    task test_simultaneous_alloc_commit();
        $display("\n=== TEST 8: Simultaneous Allocation and Commit ===");
        
        init_inputs();
        
        // Allocate and commit in same cycle
        issue_instruction(0, 5'd1, 5'd2, 5'd3, 1'b1);
        commit_register(0, 6'd40); // Commit some arbitrary register
        wait_cycles(1);
        
        // Should handle both operations correctly
        check_result("Allocation successful with commit", rename_valid[0] == 1'b1);
        
         wait_cycles(1);
    endtask

    //==========================================================================
    // MAIN TEST SEQUENCE
    //==========================================================================
    
    initial begin
        $display("Starting Register Alias Table Testbench");
        $display("=====================================");
        
        // Initialize
        init_inputs();
        reset = 0;
        
        // Run all tests
        test_reset_and_initial_state();
        test_single_instruction_rename();
        test_three_way_parallel_rename();
        test_x0_special_handling();
        test_commit_and_recovery();
        test_free_list_exhaustion();
        test_dependency_chain();
        test_simultaneous_alloc_commit();
        
        // Final report
        wait_cycles(5);
        $display("\n=====================================");
        $display("Test Summary:");
        $display("  Total Tests: %0d", test_count);
        $display("  Passed:      %0d", pass_count);
        $display("  Failed:      %0d", fail_count);
        
        if (fail_count == 0) begin
            $display("  Result: ALL TESTS PASSED!");
        end else begin
            $display("  Result: %0d TESTS FAILED!", fail_count);
        end
        $display("=====================================");
        
        $finish;
    end

    //==========================================================================
    // ASSERTIONS AND MONITORS
    //==========================================================================
    
    // Monitor free list count
    always @(posedge clk) begin
        if (reset) begin
            if (free_list_count > 32) begin
                $error("[%0t] Free list count exceeded maximum: %0d", $time, free_list_count);
            end
        end
    end
    
    // Monitor for x0 violations
    always @(posedge clk) begin
        if (reset) begin
            if (rs1_arch_0 == 0 && rs1_phys_0 != 0) begin
                $error("[%0t] x0 source mapping violation: rs1_phys_0 = %0d", $time, rs1_phys_0);
            end
            if (rs2_arch_0 == 0 && rs2_phys_0 != 0) begin
                $error("[%0t] x0 source mapping violation: rs2_phys_0 = %0d", $time, rs2_phys_0);
            end
        end
    end

endmodule
