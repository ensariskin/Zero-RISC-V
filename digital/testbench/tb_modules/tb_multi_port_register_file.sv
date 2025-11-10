`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Testbench: tb_multi_port_register_file
//
// Description:
//     Comprehensive testbench for multi_port_register_file module
//     Tests tag-based register file for ROB-based Tomasulo processor
//
// Test Coverage:
//     - Basic read/write operations
//     - Tag allocation and commit operations
//     - Multiple simultaneous operations
//     - Forwarding scenarios
//     - Edge cases and error conditions
//     - Performance scenarios
//////////////////////////////////////////////////////////////////////////////////

module tb_multi_port_register_file;

    localparam D = 1;
    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 6;
    localparam NUM_READ_PORTS = 6;
    localparam NUM_REGISTERS = 64;
    localparam TAG_WIDTH = 2;
    
    // Tag definitions (matching the DUT)
    localparam TAG_VALID = 2'b11;
    localparam TAG_ALU0 = 2'b00;
    localparam TAG_ALU1 = 2'b01;
    localparam TAG_ALU2 = 2'b10;

    // Clock and Reset
    logic clk;
    logic reset;
    
    // Read ports
    logic [ADDR_WIDTH-1:0] read_addr_0, read_addr_1, read_addr_2, read_addr_3, read_addr_4, read_addr_5;
    logic [DATA_WIDTH-1:0] read_data_0, read_data_1, read_data_2, read_data_3, read_data_4, read_data_5;
    logic [TAG_WIDTH-1:0] read_tag_0, read_tag_1, read_tag_2, read_tag_3, read_tag_4, read_tag_5;
    
    // Allocation ports
    logic alloc_enable_0, alloc_enable_1, alloc_enable_2;
    logic [ADDR_WIDTH-1:0] alloc_addr_0, alloc_addr_1, alloc_addr_2;
    logic [TAG_WIDTH-1:0] alloc_tag_0, alloc_tag_1, alloc_tag_2;
    
    // Commit ports
    logic commit_enable_0, commit_enable_1, commit_enable_2;
    logic [ADDR_WIDTH-1:0] commit_addr_0, commit_addr_1, commit_addr_2;
    logic [DATA_WIDTH-1:0] commit_data_0, commit_data_1, commit_data_2;
    
    // Test control variables
    integer test_count;
    integer error_count;
    string current_test;
    
    // Expected values for checking
    logic [DATA_WIDTH-1:0] expected_data [NUM_REGISTERS-1:0];
    logic [TAG_WIDTH-1:0] expected_tag [NUM_REGISTERS-1:0];
    
    //==========================================================================
    // DUT INSTANTIATION
    //==========================================================================
    
    multi_port_register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .NUM_READ_PORTS(NUM_READ_PORTS),
        .NUM_REGISTERS(NUM_REGISTERS),
        .TAG_WIDTH(TAG_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        
        // Read ports
        .read_addr_0(read_addr_0), .read_addr_1(read_addr_1), .read_addr_2(read_addr_2),
        .read_addr_3(read_addr_3), .read_addr_4(read_addr_4), .read_addr_5(read_addr_5),
        .read_data_0(read_data_0), .read_data_1(read_data_1), .read_data_2(read_data_2),
        .read_data_3(read_data_3), .read_data_4(read_data_4), .read_data_5(read_data_5),
        .read_tag_0(read_tag_0), .read_tag_1(read_tag_1), .read_tag_2(read_tag_2),
        .read_tag_3(read_tag_3), .read_tag_4(read_tag_4), .read_tag_5(read_tag_5),
        
        // Allocation ports
        .alloc_enable_0(alloc_enable_0), .alloc_enable_1(alloc_enable_1), .alloc_enable_2(alloc_enable_2),
        .alloc_addr_0(alloc_addr_0), .alloc_addr_1(alloc_addr_1), .alloc_addr_2(alloc_addr_2),
        .alloc_tag_0(alloc_tag_0), .alloc_tag_1(alloc_tag_1), .alloc_tag_2(alloc_tag_2),
        
        // Commit ports
        .commit_enable_0(commit_enable_0), .commit_enable_1(commit_enable_1), .commit_enable_2(commit_enable_2),
        .commit_addr_0(commit_addr_0), .commit_addr_1(commit_addr_1), .commit_addr_2(commit_addr_2),
        .commit_data_0(commit_data_0), .commit_data_1(commit_data_1), .commit_data_2(commit_data_2)
    );
    
    //==========================================================================
    // CLOCK GENERATION
    //==========================================================================
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end
    
    //==========================================================================
    // UTILITY TASKS
    //==========================================================================
    
    // Initialize all inputs
    task initialize_inputs();
        read_addr_0 = 0; read_addr_1 = 0; read_addr_2 = 0; read_addr_3 = 0; read_addr_4 = 0; read_addr_5 = 0;
        alloc_enable_0 = 0; alloc_enable_1 = 0; alloc_enable_2 = 0;
        alloc_addr_0 = 0; alloc_addr_1 = 0; alloc_addr_2 = 0;
        alloc_tag_0 = 0; alloc_tag_1 = 0; alloc_tag_2 = 0;
        commit_enable_0 = 0; commit_enable_1 = 0; commit_enable_2 = 0;
        commit_addr_0 = 0; commit_addr_1 = 0; commit_addr_2 = 0;
        commit_data_0 = 0; commit_data_1 = 0; commit_data_2 = 0;
    endtask
    
    // Reset the DUT
    task reset_dut();
        current_test = "Reset";
        $display("[%0t] Starting %s", $time, current_test);
        
        reset = 0;
        initialize_inputs();
        
        // Apply reset
        @(posedge clk);
        reset <= #D 1;
        @(posedge clk);
        @(posedge clk);
        
        // Initialize expected values after reset
        for (int i = 0; i < NUM_REGISTERS; i++) begin
            expected_data[i] = 32'h0;
            expected_tag[i] = TAG_VALID;
        end
        
        $display("[%0t] Reset completed", $time);
    endtask
    
    // Wait for clock cycles
    task wait_cycles(input int cycles);
        repeat(cycles) @(posedge clk);
    endtask
    
    // Check a single register's data and tag
    task check_register(input int addr, input logic [DATA_WIDTH-1:0] exp_data, input logic [TAG_WIDTH-1:0] exp_tag, input string test_name);
        read_addr_0 = addr;
        @(posedge clk);
        #(D+1); // Wait for sequential delay D plus small delta for combinational logic
        
        if (read_data_0 !== exp_data || read_tag_0 !== exp_tag) begin
            $error("[%0t] %s: Register %0d mismatch - Expected: data=0x%08h, tag=%b | Got: data=0x%08h, tag=%b", 
                   $time, test_name, addr, exp_data, exp_tag, read_data_0, read_tag_0);
            error_count++;
        end else begin
            $display("[%0t] %s: Register %0d OK - data=0x%08h, tag=%b", $time, test_name, addr, read_data_0, read_tag_0);
        end
    endtask
    
    // Allocate a register with specific tag
    task allocate_register(input int port, input int addr, input logic [TAG_WIDTH-1:0] tag);
        case(port)
            0: begin
                alloc_enable_0 = 1;
                alloc_addr_0 = addr;
                alloc_tag_0 = tag;
            end
            1: begin
                alloc_enable_1 = 1;
                alloc_addr_1 = addr;
                alloc_tag_1 = tag;
            end
            2: begin
                alloc_enable_2 = 1;
                alloc_addr_2 = addr;
                alloc_tag_2 = tag;
            end
        endcase
        expected_tag[addr] = tag;
    endtask
    
    // Commit a register with data
    task commit_register(input int port, input int addr, input logic [DATA_WIDTH-1:0] data);
        case(port)
            0: begin
                commit_enable_0 = 1;
                commit_addr_0 = addr;
                commit_data_0 = data;
            end
            1: begin
                commit_enable_1 = 1;
                commit_addr_1 = addr;
                commit_data_1 = data;
            end
            2: begin
                commit_enable_2 = 1;
                commit_addr_2 = addr;
                commit_data_2 = data;
            end
        endcase
        expected_data[addr] = data;
        expected_tag[addr] = TAG_VALID;
    endtask
    
    // Clear all allocation enables
    task clear_allocations();
        alloc_enable_0 = 0; alloc_enable_1 = 0; alloc_enable_2 = 0;
    endtask
    
    // Clear all commit enables
    task clear_commits();
        commit_enable_0 = 0; commit_enable_1 = 0; commit_enable_2 = 0;
    endtask
    
    //==========================================================================
    // TEST CASES
    //==========================================================================
    
    // Test 1: Basic reset functionality
    task test_reset();
        current_test = "Basic Reset Test";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        reset_dut();
        
        // Check that all registers are zero and valid
        for (int i = 0; i < 8; i++) begin
            check_register(i, 32'h0, TAG_VALID, current_test);
        end
        
        // Specifically check register 0 (should always be zero)
        check_register(0, 32'h0, TAG_VALID, "x0 Register Check");
    endtask
    
    // Test 2: Single register allocation
    task test_single_allocation();
        current_test = "Single Register Allocation";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Allocate register 5 to ALU 1
        allocate_register(0, 5, TAG_ALU1);
        @(posedge clk);
        clear_allocations();
        
        check_register(5, expected_data[5], TAG_ALU1, current_test);
        
        // Verify other registers are unaffected
        check_register(4, 32'h0, TAG_VALID, "Unaffected Register");
        check_register(6, 32'h0, TAG_VALID, "Unaffected Register");
    endtask
    
    // Test 3: Multiple simultaneous allocations
    task test_multiple_allocations();
        current_test = "Multiple Simultaneous Allocations";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Allocate three different registers to different ALUs
        allocate_register(0, 10, TAG_ALU0);
        allocate_register(1, 11, TAG_ALU1);
        allocate_register(2, 12, TAG_ALU2);
        @(posedge clk);
        clear_allocations();
        
        check_register(10, expected_data[10], TAG_ALU0, current_test);
        check_register(11, expected_data[11], TAG_ALU1, current_test);
        check_register(12, expected_data[12], TAG_ALU2, current_test);
    endtask
    
    // Test 4: Single register commit
    task test_single_commit();
        current_test = "Single Register Commit";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // First allocate a register
        allocate_register(0, 15, TAG_ALU2);
        @(posedge clk);
        clear_allocations();
        
        // Then commit data to it
        commit_register(0, 15, 32'hDEADBEEF);
        @(posedge clk);
        clear_commits();
        
        check_register(15, 32'hDEADBEEF, TAG_VALID, current_test);
    endtask
    
    // Test 5: Multiple simultaneous commits
    task test_multiple_commits();
        current_test = "Multiple Simultaneous Commits";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // First allocate registers
        allocate_register(0, 20, TAG_ALU0);
        allocate_register(1, 21, TAG_ALU1);
        allocate_register(2, 22, TAG_ALU2);
        @(posedge clk);
        clear_allocations();
        
        // Then commit all three in same cycle
        commit_register(0, 20, 32'h12345678);
        commit_register(1, 21, 32'h9ABCDEF0);
        commit_register(2, 22, 32'hFEDCBA98);
        @(posedge clk);
        clear_commits();
        
        check_register(20, 32'h12345678, TAG_VALID, current_test);
        check_register(21, 32'h9ABCDEF0, TAG_VALID, current_test);
        check_register(22, 32'hFEDCBA98, TAG_VALID, current_test);
    endtask
    
    // Test 6: All read ports simultaneously
    task test_parallel_reads();
        current_test = "Parallel Read Ports";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Setup some registers with known values
        commit_register(0, 1, 32'h11111111);
        commit_register(1, 2, 32'h22222222);
        commit_register(2, 3, 32'h33333333);
        @(posedge clk);
        clear_commits();
        
        allocate_register(0, 4, TAG_ALU0);
        allocate_register(1, 5, TAG_ALU1);
        @(posedge clk);
        clear_allocations();
        
        // Read from all 6 ports simultaneously
        read_addr_0 = 0;  // x0 - should always be 0
        read_addr_1 = 1;  // Committed register
        read_addr_2 = 2;  // Committed register
        read_addr_3 = 3;  // Committed register
        read_addr_4 = 4;  // Allocated to ALU0
        read_addr_5 = 5;  // Allocated to ALU1
        
        @(posedge clk);
        #(D+1); // Wait for sequential delay D plus delta for combinational logic
        
        // Check all reads
        if (read_data_0 !== 32'h0 || read_tag_0 !== TAG_VALID) begin
            $error("[%0t] %s: Port 0 (x0) failed", $time, current_test);
            error_count++;
        end
        if (read_data_1 !== 32'h11111111 || read_tag_1 !== TAG_VALID) begin
            $error("[%0t] %s: Port 1 failed", $time, current_test);
            error_count++;
        end
        if (read_data_2 !== 32'h22222222 || read_tag_2 !== TAG_VALID) begin
            $error("[%0t] %s: Port 2 failed", $time, current_test);
            error_count++;
        end
        if (read_data_3 !== 32'h33333333 || read_tag_3 !== TAG_VALID) begin
            $error("[%0t] %s: Port 3 failed", $time, current_test);
            error_count++;
        end
        if (read_tag_4 !== TAG_ALU0) begin
            $error("[%0t] %s: Port 4 tag failed", $time, current_test);
            error_count++;
        end
        if (read_tag_5 !== TAG_ALU1) begin
            $error("[%0t] %s: Port 5 tag failed", $time, current_test);
            error_count++;
        end
        
        $display("[%0t] %s: All 6 read ports tested", $time, current_test);
    endtask
    
    // Test 7: Allocation forwarding
    task test_allocation_forwarding();
        current_test = "Allocation Forwarding";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Set up a read from register 30 while simultaneously allocating it
        read_addr_0 = 30;
        allocate_register(1, 30, TAG_ALU2);
        
        @(posedge clk);
        #(D+1); // Wait for sequential delay D plus delta for combinational logic
        
        // Should forward the new tag
        if (read_tag_0 !== TAG_ALU2) begin
            $error("[%0t] %s: Allocation forwarding failed - expected tag %b, got %b", 
                   $time, current_test, TAG_ALU2, read_tag_0);
            error_count++;
        end else begin
            $display("[%0t] %s: Allocation forwarding successful", $time, current_test);
        end
        
        clear_allocations();
    endtask
    
    // Test 8: Register 0 protection
    task test_register_zero_protection();
        current_test = "Register 0 Protection";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Try to allocate register 0 (should be ignored)
        allocate_register(0, 0, TAG_ALU1);
        @(posedge clk);
        clear_allocations();
        
        // Try to commit to register 0 (should be ignored)
        commit_register(0, 0, 32'hFFFFFFFF);
        @(posedge clk);
        clear_commits();
        
        // Register 0 should still be 0 and valid
        check_register(0, 32'h0, TAG_VALID, current_test);
    endtask
    
    // Test 9: Mixed operations
    task test_mixed_operations();
        current_test = "Mixed Allocation and Commit Operations";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Simultaneously allocate new registers and commit others
        allocate_register(0, 40, TAG_ALU0);
        allocate_register(1, 41, TAG_ALU1);
        commit_register(0, 20, 32'hAAAAAAAA); // From previous test
        commit_register(1, 21, 32'hBBBBBBBB); // From previous test
        
        @(posedge clk);
        clear_allocations();
        clear_commits();
        
        // Wait for outputs to settle after sequential delay
        #(D+1);
        
        // Check allocations
        check_register(40, expected_data[40], TAG_ALU0, "New Allocation");
        check_register(41, expected_data[41], TAG_ALU1, "New Allocation");
        
        // Check commits
        check_register(20, 32'hAAAAAAAA, TAG_VALID, "Commit Update");
        check_register(21, 32'hBBBBBBBB, TAG_VALID, "Commit Update");

        #(D+1); // Additional wait to ensure stability
        @(posedge clk);
        commit_register(0, 40, 32'hAAAAAAAA); // From previous test
        commit_register(1, 41, 32'hBBBBBBBB); // From previous test
        @(posedge clk);
        clear_commits();
        // Check commits
        check_register(40, 32'hAAAAAAAA, TAG_VALID, "Commit Update");
        check_register(41, 32'hBBBBBBBB, TAG_VALID, "Commit Update");
    endtask
    
    // Test 10: Stress test with rapid operations
    task test_stress_operations();
        current_test = "Stress Test - Rapid Operations";
        test_count++;
        $display("\n[%0t] ========== %s ==========", $time, current_test);
        
        // Reset register file before stress test to clear previous allocations
        reset_dut();
        
        // Rapid sequence of allocations and commits
        // Use addresses 1-30 to stay well within 64 register limit
        for (int i = 0; i < 10; i++) begin
            // Allocate 3 registers - addresses 1+i*3, 2+i*3, 3+i*3
            // Max address will be 3+9*3 = 30, well within 63 limit
            allocate_register(0, 1+i*3, TAG_ALU0);
            allocate_register(1, 2+i*3, TAG_ALU1);
            allocate_register(2, 3+i*3, TAG_ALU2);
            @(posedge clk);
            clear_allocations();
            
            // Commit them in next cycle
            commit_register(0, 1+i*3, 32'h1000_0000 + i*3);
            commit_register(1, 2+i*3, 32'h1000_0000 + i*3 + 1);
            commit_register(2, 3+i*3, 32'h1000_0000 + i*3 + 2);
            @(posedge clk);
            clear_commits();
            
            // Wait for outputs to settle
            #(D+1);
        end
        
        // Verify some of the results
        check_register(1, 32'h1000_0000, TAG_VALID, "Stress Test");
        check_register(4, 32'h1000_0003, TAG_VALID, "Stress Test");
        check_register(11, 32'h1000_000A, TAG_VALID, "Stress Test");
        check_register(29, 32'h1000_001C, TAG_VALID, "Stress Test");
        
        $display("[%0t] %s: Completed 30 rapid operations (addresses 1-30)", $time, current_test);
    endtask
    
    //==========================================================================
    // MAIN TEST SEQUENCE
    //==========================================================================
    
    initial begin
        $display("========================================");
        $display("Multi-Port Register File Testbench");
        $display("========================================");
        
        test_count = 0;
        error_count = 0;
        
        // Initialize
        initialize_inputs();
        
        // Run test sequence
        test_reset();
        test_single_allocation();
        test_multiple_allocations();
        test_single_commit();
        test_multiple_commits();
        test_parallel_reads();
        test_allocation_forwarding();
        test_register_zero_protection();
        test_mixed_operations();
        test_stress_operations();
        
        // Final report
        $display("\n========================================");
        $display("Test Summary:");
        $display("Tests Run: %0d", test_count);
        $display("Errors: %0d", error_count);
        if (error_count == 0) begin
            $display("*** ALL TESTS PASSED ***");
        end else begin
            $display("*** %0d TESTS FAILED ***", error_count);
        end
        $display("========================================");
        
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #100000;
        $error("Testbench timeout!");
        $finish;
    end

endmodule
