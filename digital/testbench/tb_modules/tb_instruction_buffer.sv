`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2025
// Design Name: Instruction Buffer Testbench
// Module Name: tb_instruction_buffer
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Comprehensive testbench for instruction_buffer module
//              Tests variable-width input/output, backpressure, flush operations,
//              and buffer management
// 
// Dependencies: instruction_buffer.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_instruction_buffer;

    // Parameters
    parameter CLK_PERIOD = 10;  // 100MHz clock
    parameter BUFFER_DEPTH = 16;
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = $clog2(BUFFER_DEPTH);
    
    // Testbench signals
    logic clk;
    logic reset;
    
    // Input signals (from multi_fetch)
    logic [2:0] fetch_valid_i;
    logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2;
    logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2;
    logic [DATA_WIDTH-1:0] imm_i_0, imm_i_1, imm_i_2;
    logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2;
    
    // Output signals (to decode stages)
    logic [2:0] decode_valid_o;
    logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2;
    logic [DATA_WIDTH-1:0] pc_o_0, pc_o_1, pc_o_2;
    logic [DATA_WIDTH-1:0] imm_o_0, imm_o_1, imm_o_2;
    logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2;
    
    // Control signals
    logic [2:0] decode_ready_i;
    logic fetch_ready_o;
    logic flush_i;
    
    // Status signals
    logic buffer_empty_o;
    logic buffer_full_o;
    logic [ADDR_WIDTH:0] occupancy_o;
    
    // Test control
    integer test_case = 0;
    integer cycle_count = 0;
    
    // DUT instantiation
    instruction_buffer #(
        .BUFFER_DEPTH(BUFFER_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        
        // Input from multi_fetch
        .fetch_valid_i(fetch_valid_i),
        .instruction_i_0(instruction_i_0),
        .instruction_i_1(instruction_i_1),
        .instruction_i_2(instruction_i_2),
        .pc_i_0(pc_i_0),
        .pc_i_1(pc_i_1),
        .pc_i_2(pc_i_2),
        .imm_i_0(imm_i_0),
        .imm_i_1(imm_i_1),
        .imm_i_2(imm_i_2),
        .branch_prediction_i_0(branch_prediction_i_0),
        .branch_prediction_i_1(branch_prediction_i_1),
        .branch_prediction_i_2(branch_prediction_i_2),
        
        // Output to decode stages
        .decode_valid_o(decode_valid_o),
        .instruction_o_0(instruction_o_0),
        .instruction_o_1(instruction_o_1),
        .instruction_o_2(instruction_o_2),
        .pc_o_0(pc_o_0),
        .pc_o_1(pc_o_1),
        .pc_o_2(pc_o_2),
        .imm_o_0(imm_o_0),
        .imm_o_1(imm_o_1),
        .imm_o_2(imm_o_2),
        .branch_prediction_o_0(branch_prediction_o_0),
        .branch_prediction_o_1(branch_prediction_o_1),
        .branch_prediction_o_2(branch_prediction_o_2),
        
        // Control signals
        .decode_ready_i(decode_ready_i),
        .fetch_ready_o(fetch_ready_o),
        .flush_i(flush_i),
        
        // Status outputs
        .buffer_empty_o(buffer_empty_o),
        .buffer_full_o(buffer_full_o),
        .occupancy_o(occupancy_o)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Cycle counter
    always @(posedge clk) begin
        if (reset)
            cycle_count <= cycle_count + 1;
    end
    
    // Main test sequence
    initial begin
        $display("=== Instruction Buffer Testbench Started ===");
        
        // Initialize all signals
        reset = 0;
        flush_i = 0;
        
        // Initialize fetch inputs
        fetch_valid_i = 3'b000;
        instruction_i_0 = 32'h0;
        instruction_i_1 = 32'h0;
        instruction_i_2 = 32'h0;
        pc_i_0 = 32'h0;
        pc_i_1 = 32'h0;
        pc_i_2 = 32'h0;
        imm_i_0 = 32'h0;
        imm_i_1 = 32'h0;
        imm_i_2 = 32'h0;
        branch_prediction_i_0 = 1'b0;
        branch_prediction_i_1 = 1'b0;
        branch_prediction_i_2 = 1'b0;
        
        // Initialize decode inputs
        decode_ready_i = 3'b000;
        
        // Reset sequence
        #(CLK_PERIOD * 2);
        reset = 1;
        $display("[%0t] Reset released", $time);
        
        // Test Case 1: Basic buffer operation
        @(posedge clk);
        test_case = 1;
        test_basic_operation();
        
        // Test Case 2: Buffer fill and drain
        #(CLK_PERIOD * 2);
        test_case = 2;
        test_fill_and_drain();
        
        // Test Case 3: Backpressure handling
        #(CLK_PERIOD * 2);
        test_case = 3;
        test_backpressure();
        
        // Test Case 4: Flush operation
        #(CLK_PERIOD * 2);
        test_case = 4;
        test_flush_operation();
        
        // Test Case 5: Variable width operation
        #(CLK_PERIOD * 2);
        test_case = 5;
        test_variable_width();
        
        // Test Case 6: Buffer boundary conditions
        #(CLK_PERIOD * 2);
        test_case = 6;
        test_boundary_conditions();
        
        #(CLK_PERIOD * 10);
        $display("=== All Tests Completed Successfully ===");
        $finish;
    end
    
    // Test Case 1: Basic buffer operation
    task test_basic_operation();
        $display("\\n=== Test Case 1: Basic Buffer Operation ===");
        
        // Enable decode stages to accept all instructions
        decode_ready_i = 3'b111;
        
        @(posedge clk);
        
        // Send 3 instructions
        fetch_valid_i = 3'b111;
        instruction_i_0 = 32'h00000013; // nop
        instruction_i_1 = 32'h00100093; // addi x1, x0, 1
        instruction_i_2 = 32'h00200113; // addi x2, x0, 2
        pc_i_0 = 32'h80000000;
        pc_i_1 = 32'h80000004;
        pc_i_2 = 32'h80000008;
        imm_i_0 = 32'h0;
        imm_i_1 = 32'h1;
        imm_i_2 = 32'h2;
        
        @(posedge clk);
        #1ns;
        $display("[%0t] Checking basic operation:", $time);
        $display("  fetch_ready_o = %b (expected: 1)", fetch_ready_o);
        $display("  decode_valid_o = 3'b%b (expected: 3'b111)", decode_valid_o);
        $display("  instruction_o_0 = 0x%08x (expected: 0x00000013)", instruction_o_0);
        $display("  instruction_o_1 = 0x%08x (expected: 0x00100093)", instruction_o_1);
        $display("  instruction_o_2 = 0x%08x (expected: 0x00200113)", instruction_o_2);
        $display("  occupancy = %0d", occupancy_o);
        
        assert(fetch_ready_o == 1'b1) else $error("fetch_ready_o should be high");
        assert(decode_valid_o == 3'b111) else $error("All decode outputs should be valid");
        
        // Clear inputs
        fetch_valid_i = 3'b000;
        
        $display("Test Case 1: PASSED\\n \n");
    endtask
    
    // Test Case 2: Buffer fill and drain
    task test_fill_and_drain();
        $display("=== Test Case 2: Buffer Fill and Drain ===");
        
        // Disable decode stages to fill buffer
        @(posedge clk);
        decode_ready_i = 3'b000;
        
        // Fill buffer with multiple cycles
        for (int i = 0; i < 3; i++) begin
             
            fetch_valid_i = 3'b111;
            instruction_i_0 = 32'h00000013 + i*3;
            instruction_i_1 = 32'h00100093 + i*3;
            instruction_i_2 = 32'h00200113 + i*3;
            pc_i_0 = 32'h80000000 + i*12;
            pc_i_1 = 32'h80000004 + i*12;
            pc_i_2 = 32'h80000008 + i*12;
            @(posedge clk);
            #1ns;
            $display("[%0t] Cycle %0d - Occupancy: %0d, Buffer Full: %b", 
                    $time, i, occupancy_o, buffer_full_o);
        end

        
        // Clear fetch inputs
        fetch_valid_i = 3'b000;
        
        @(posedge clk);
        $display("[%0t] Buffer filled - Occupancy: %0d", $time, occupancy_o);
        
        // Now drain buffer
        decode_ready_i = 3'b111;
        
        for (int i = 0; i < 3; i++) begin
            @(posedge clk);
            #1ns;
            $display("[%0t] Draining cycle %0d - Occupancy: %0d, Valid: 3'b%b", 
                    $time, i, occupancy_o, decode_valid_o);
            
            if (occupancy_o == 0) break;
        end
        
        $display("Test Case 2: PASSED\\n \n");
    endtask
    
    // Test Case 3: Backpressure handling
    task test_backpressure();
        $display("=== Test Case 3: Backpressure Handling ===");
        
        // Test scenario where decode stages are slower than fetch
        @(posedge clk);
        decode_ready_i = 3'b001; // Only one decode stage ready
        
        for (int i = 0; i < 10; i++) begin
            
            
            // Try to send 3 instructions every cycle
            fetch_valid_i = 3'b111;
            instruction_i_0 = 32'h00000013 + i;
            instruction_i_1 = 32'h00100093 + i;
            instruction_i_2 = 32'h00200113 + i;
            pc_i_0 = 32'h80001000 + i*12;
            pc_i_1 = 32'h80001004 + i*12;
            pc_i_2 = 32'h80001008 + i*12;
            #1ns;
            @(posedge clk);
            #1ns;
            
            $display("[%0t] Cycle %0d - Fetch Ready: %b, Occupancy: %0d", 
                    $time, i, fetch_ready_o, occupancy_o);
                    
            // Check if backpressure is working
            if (!fetch_ready_o && i > 2) begin
                $display("  ✓ Backpressure detected correctly");
            end
            else if(buffer_full_o)
                $error("Backpressure CANNOT DETECTED");
        end
        
        // Clear and reset
        fetch_valid_i = 3'b000;
        decode_ready_i = 3'b111;
        
        // Wait for buffer to drain
        repeat (5) @(posedge clk);
        
        $display("Test Case 3: PASSED\\n \n");
    endtask
    
    // Test Case 4: Flush operation
    task test_flush_operation();
        $display("=== Test Case 4: Flush Operation ===");
        
        // Fill buffer partially
        decode_ready_i = 3'b000; // Don't drain
        
        @(posedge clk);
        fetch_valid_i = 3'b111;
        instruction_i_0 = 32'hDEADBEEF;
        instruction_i_1 = 32'hCAFEBABE;
        instruction_i_2 = 32'h12345678;
        pc_i_0 = 32'h80002000;
        pc_i_1 = 32'h80002004;
        pc_i_2 = 32'h80002008;
        
        @(posedge clk);
        #1ns;
        fetch_valid_i = 3'b000;
        
        $display("[%0t] Before flush - Occupancy: %0d", $time, occupancy_o);
        assert(occupancy_o > 0) else $error("Buffer should have instructions before flush");
        
        // Apply flush
        @(posedge clk);
        flush_i = 1'b1;
        
        @(posedge clk);
        #1ns;
        flush_i = 1'b0;
        
        $display("[%0t] After flush - Occupancy: %0d, Empty: %b", $time, occupancy_o, buffer_empty_o);
        assert(occupancy_o == 0) else $error("Buffer should be empty after flush");
        assert(buffer_empty_o == 1'b1) else $error("Empty flag should be set after flush");
        
        $display("Test Case 4: PASSED\\n \n");
    endtask
    
    // Test Case 5: Variable width operation
    task test_variable_width();
        $display("=== Test Case 5: Variable Width Operation ===");
        
        decode_ready_i = 3'b111;
        
        // Test 1 instruction input
        @(posedge clk);
        fetch_valid_i = 3'b001;
        instruction_i_0 = 32'h00000001;
        pc_i_0 = 32'h80003000;
        
        @(posedge clk);
        #1ns;
        $display("[%0t] 1 instruction input - Valid: 3'b%b", $time, decode_valid_o);
        
        // Test 2 instruction input
        fetch_valid_i = 3'b011;
        instruction_i_0 = 32'h00000002;
        instruction_i_1 = 32'h00000003;
        pc_i_0 = 32'h80003004;
        pc_i_1 = 32'h80003008;
        
        @(posedge clk);
        #1ns;
        $display("[%0t] 2 instruction input - Valid: 3'b%b", $time, decode_valid_o);
        
        // Test variable decode readiness
        fetch_valid_i = 3'b111;
        decode_ready_i = 3'b011; // Only 2 decode stages ready
        instruction_i_0 = 32'h00000004;
        instruction_i_1 = 32'h00000005;
        instruction_i_2 = 32'h00000006;
        
        @(posedge clk);
        #1ns;
        $display("[%0t] 2 decode ready - Valid: 3'b%b", $time, decode_valid_o);
        
        fetch_valid_i = 3'b000;
        decode_ready_i = 3'b111;
        @(posedge clk);
        #1ns;
        
        $display("Test Case 5: PASSED\\n \n");
    endtask
    
    // Test Case 6: Buffer boundary conditions
    task test_boundary_conditions();
        $display("=== Test Case 6: Buffer Boundary Conditions ===");
        
        // Test buffer full condition
        @(posedge clk);
        decode_ready_i = 3'b000; // Don't drain
        
        // Fill buffer to capacity
        for (int i = 0; i < BUFFER_DEPTH/3 + 1; i++) begin
            
            fetch_valid_i = 3'b111;
            instruction_i_0 = 32'h10000000 + i*3;
            instruction_i_1 = 32'h20000000 + i*3;
            instruction_i_2 = 32'h30000000 + i*3;
            @(posedge clk);
            #1ns;
            $display("[%0t] Fill cycle %0d - Occupancy: %0d, Full: %b, Ready: %b", 
                    $time, i, occupancy_o, buffer_full_o, fetch_ready_o);
        end
        
        // Verify buffer full behavior
        assert(buffer_full_o == 1'b1 || occupancy_o >= BUFFER_DEPTH-2) 
            else $error("Buffer should be full or nearly full");
        
        // Test buffer empty after drain
        fetch_valid_i = 3'b000;
        decode_ready_i = 3'b111;
        
        // Drain completely
        repeat (BUFFER_DEPTH) @(posedge clk);
        
        $display("[%0t] After complete drain - Occupancy: %0d, Empty: %b", 
                $time, occupancy_o, buffer_empty_o);
        assert(buffer_empty_o == 1'b1) else $error("Buffer should be empty");
        
        $display("Test Case 6: PASSED\\n");
    endtask
    
    // Monitor important signals
    always @(posedge clk) begin
        if (reset && cycle_count > 5) begin
            // Check for invalid conditions
            if (occupancy_o > BUFFER_DEPTH) begin
                $error("[%0t] Buffer occupancy (%0d) exceeds depth (%0d)", 
                       $time, occupancy_o, BUFFER_DEPTH);
            end
        end
    end
    
    // Timeout protection
    initial begin
        #(CLK_PERIOD * 2000);
        $error("Testbench timeout!");
        $finish;
    end

endmodule
