`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2025
// Design Name: Simple Branch Predictor Testbench
// Module Name: tb_branch_predictor_simple
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Testbench for simple 2-bit branch predictor
// 
// Dependencies: branch_predictor_simple.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Tests basic prediction and learning
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_branch_predictor_simple;
    
    // Parameters
    parameter ENTRIES = 32;
    parameter ADDR_WIDTH = 32;
    parameter CLOCK_PERIOD = 10; // 10ns = 100MHz
    
    // Testbench signals
    logic clk;
    logic reset;
    
    // Prediction interface
    logic predict_valid_i;
    logic [ADDR_WIDTH-1:0] predict_pc_i;
    logic is_branch_i;
    
    // Prediction outputs
    logic branch_taken_o;
    logic [1:0] confidence_o;
    logic predictor_hit_o;
    
    // Update interface
    logic update_valid_i;
    logic [ADDR_WIDTH-1:0] update_pc_i;
    logic actual_taken_i;
    logic is_control_flow_i;
    
    // Flush interface
    logic flush_i;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD/2) clk = ~clk;
    end
    
    // DUT instantiation
    branch_predictor_simple #(
        .ENTRIES(ENTRIES),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .predict_valid_i(predict_valid_i),
        .predict_pc_i(predict_pc_i),
        .is_branch_i(is_branch_i),
        .branch_taken_o(branch_taken_o),
        .confidence_o(confidence_o),
        .predictor_hit_o(predictor_hit_o),
        .update_valid_i(update_valid_i),
        .update_pc_i(update_pc_i),
        .actual_taken_i(actual_taken_i),
        .is_control_flow_i(is_control_flow_i),
        .flush_i(flush_i)
    );
    
    // Test stimulus
    initial begin
        // Initialize signals
        reset = 1;
        predict_valid_i = 0;
        predict_pc_i = 0;
        is_branch_i = 0;
        update_valid_i = 0;
        update_pc_i = 0;
        actual_taken_i = 0;
        is_control_flow_i = 0;
        flush_i = 0;
        
        // Wait for reset deassertion
        repeat(10) @(posedge clk);
        reset = 0;
        repeat(5) @(posedge clk);
        
        $display("=== Simple Branch Predictor Testbench ===");
        $display("Time: %0t - Starting test sequence", $time);
        
        // Test 1: Cold start prediction
        $display("\n--- Test 1: Cold start prediction ---");
        predict_valid_i = 1;
        predict_pc_i = 32'h1000;
        is_branch_i = 1;
        @(posedge clk);
        $display("PC: 0x%08h, Prediction: %s, Hit: %b, Confidence: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", 
                 predictor_hit_o, confidence_o);
        
        // Test 2: Train the predictor
        $display("\n--- Test 2: Training predictor ---");
        predict_valid_i = 0;
        @(posedge clk);
        
        // Update with actual result (taken)
        update_valid_i = 1;
        update_pc_i = 32'h1000;
        actual_taken_i = 1;
        is_control_flow_i = 1;
        @(posedge clk);
        update_valid_i = 0;
        is_control_flow_i = 0;
        
        // Test the same branch again
        predict_valid_i = 1;
        predict_pc_i = 32'h1000;
        is_branch_i = 1;
        @(posedge clk);
        $display("PC: 0x%08h, Prediction: %s, Hit: %b, Confidence: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", 
                 predictor_hit_o, confidence_o);
        
        // Test 3: Train again to strengthen prediction
        $display("\n--- Test 3: Strengthen prediction ---");
        predict_valid_i = 0;
        @(posedge clk);
        
        // Another taken branch
        update_valid_i = 1;
        update_pc_i = 32'h1000;
        actual_taken_i = 1;
        is_control_flow_i = 1;
        @(posedge clk);
        update_valid_i = 0;
        is_control_flow_i = 0;
        
        // Test prediction again
        predict_valid_i = 1;
        predict_pc_i = 32'h1000;
        is_branch_i = 1;
        @(posedge clk);
        $display("PC: 0x%08h, Prediction: %s, Hit: %b, Confidence: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", 
                 predictor_hit_o, confidence_o);
        
        // Test 4: Test misprediction recovery
        $display("\n--- Test 4: Misprediction recovery ---");
        predict_valid_i = 0;
        @(posedge clk);
        
        // Branch not taken (opposite of prediction)
        update_valid_i = 1;
        update_pc_i = 32'h1000;
        actual_taken_i = 0;
        is_control_flow_i = 1;
        @(posedge clk);
        update_valid_i = 0;
        is_control_flow_i = 0;
        
        // Test prediction after misprediction
        predict_valid_i = 1;
        predict_pc_i = 32'h1000;
        is_branch_i = 1;
        @(posedge clk);
        $display("PC: 0x%08h, Prediction: %s, Hit: %b, Confidence: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", 
                 predictor_hit_o, confidence_o);
        
        // Test 5: Different branch (different index)
        $display("\n--- Test 5: Different branch ---");
        predict_pc_i = 32'h1020;  // Different index
        is_branch_i = 1;
        @(posedge clk);
        $display("PC: 0x%08h, Prediction: %s, Hit: %b, Confidence: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", 
                 predictor_hit_o, confidence_o);
        
        // Test 6: Flush operation
        $display("\n--- Test 6: Flush operation ---");
        predict_valid_i = 0;
        @(posedge clk);
        flush_i = 1;
        @(posedge clk);
        flush_i = 0;
        
        // Test after flush
        predict_valid_i = 1;
        predict_pc_i = 32'h1000;  // Same branch as before
        is_branch_i = 1;
        @(posedge clk);
        $display("After flush - PC: 0x%08h, Prediction: %s, Hit: %b", 
                 predict_pc_i, branch_taken_o ? "TAKEN" : "NOT_TAKEN", predictor_hit_o);
        
        predict_valid_i = 0;
        is_branch_i = 0;
        repeat(10) @(posedge clk);
        
        $display("\n=== Test completed successfully ===");
        $finish;
    end
    
    // Monitor important signals
    initial begin
        $monitor("Time: %0t | PC: 0x%08h | Pred: %s | Hit: %b | Conf: %b", 
                 $time, predict_pc_i, branch_taken_o ? "T" : "N", 
                 predictor_hit_o, confidence_o);
    end

endmodule
