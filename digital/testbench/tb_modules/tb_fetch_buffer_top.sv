`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025
// Design Name: Fetch Buffer Integration Testbench
// Module Name: tb_fetch_buffer_top
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Testbench for fetch_buffer_top module testing branch prediction
//              optimization and instruction buffer integration
// 
// Dependencies: fetch_buffer_top.sv, multi_fetch.sv, instruction_buffer.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_fetch_buffer_top;

    // Parameters
    parameter CLK_PERIOD = 10;  // 100MHz clock
    parameter DATA_WIDTH = 32;
    parameter BUFFER_DEPTH = 16;
    
    // Testbench signals
    logic clk;
    logic reset;
    
    // Memory interface
    logic [DATA_WIDTH-1:0] inst_addr_0, inst_addr_1, inst_addr_2;
    logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2;
    
    // Pipeline control
    logic flush;
    logic buble;
    
    // Branch prediction interface
    logic [DATA_WIDTH-1:0] pc_value_at_prediction_0, pc_value_at_prediction_1, pc_value_at_prediction_2;
    logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2;
    logic update_prediction_valid_i_0, update_prediction_valid_i_1, update_prediction_valid_i_2;
    logic [DATA_WIDTH-1:0] update_prediction_pc_0, update_prediction_pc_1, update_prediction_pc_2;
    logic misprediction_0, misprediction_1, misprediction_2;
    logic [DATA_WIDTH-1:0] correct_pc;
    
    // Output to decode stages
    logic [2:0] decode_valid_o;
    logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2;
    logic [DATA_WIDTH-1:0] pc_decode_o_0, pc_decode_o_1, pc_decode_o_2;
    logic [DATA_WIDTH-1:0] imm_decode_o_0, imm_decode_o_1, imm_decode_o_2;
    logic branch_prediction_decode_o_0, branch_prediction_decode_o_1, branch_prediction_decode_o_2;
    
    // Decode ready signals
    logic [2:0] decode_ready_i;
    
    // Status outputs
    logic buffer_empty_o;
    logic buffer_full_o;
    logic [$clog2(BUFFER_DEPTH):0] occupancy_o;
    
    // Legacy outputs
    logic [DATA_WIDTH-1:0] legacy_instruction_o_0, legacy_instruction_o_1, legacy_instruction_o_2;
    logic [DATA_WIDTH-1:0] legacy_imm_o_0, legacy_imm_o_1, legacy_imm_o_2;
    logic [DATA_WIDTH-1:0] pc_plus_o;
    
    // Test control
    integer test_case = 0;
    integer cycle_count = 0;
    
    // Test memory array
    logic [31:0] test_memory [0:1023];
    
    // DUT instantiation
    fetch_buffer_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        
        // Memory interface
        .inst_addr_0(inst_addr_0),
        .instruction_i_0(instruction_i_0),
        .inst_addr_1(inst_addr_1),
        .instruction_i_1(instruction_i_1),
        .inst_addr_2(inst_addr_2),
        .instruction_i_2(instruction_i_2),
        
        // Pipeline control
        .flush(flush),
        .buble(buble),
        
        // Branch prediction interface
        .pc_value_at_prediction_0(pc_value_at_prediction_0),
        .branch_prediction_o_0(branch_prediction_o_0),
        .update_prediction_valid_i_0(update_prediction_valid_i_0),
        .update_prediction_pc_0(update_prediction_pc_0),
        .misprediction_0(misprediction_0),
        
        .pc_value_at_prediction_1(pc_value_at_prediction_1),
        .branch_prediction_o_1(branch_prediction_o_1),
        .update_prediction_valid_i_1(update_prediction_valid_i_1),
        .update_prediction_pc_1(update_prediction_pc_1),
        .misprediction_1(misprediction_1),
        
        .pc_value_at_prediction_2(pc_value_at_prediction_2),
        .branch_prediction_o_2(branch_prediction_o_2),
        .update_prediction_valid_i_2(update_prediction_valid_i_2),
        .update_prediction_pc_2(update_prediction_pc_2),
        .misprediction_2(misprediction_2),
        
        .correct_pc(correct_pc),
        
        // Output to decode stages
        .decode_valid_o(decode_valid_o),
        .instruction_o_0(instruction_o_0),
        .instruction_o_1(instruction_o_1),
        .instruction_o_2(instruction_o_2),
        .pc_decode_o_0(pc_decode_o_0),
        .pc_decode_o_1(pc_decode_o_1),
        .pc_decode_o_2(pc_decode_o_2),
        .imm_decode_o_0(imm_decode_o_0),
        .imm_decode_o_1(imm_decode_o_1),
        .imm_decode_o_2(imm_decode_o_2),
        .branch_prediction_decode_o_0(branch_prediction_decode_o_0),
        .branch_prediction_decode_o_1(branch_prediction_decode_o_1),
        .branch_prediction_decode_o_2(branch_prediction_decode_o_2),
        
        // Decode ready signals
        .decode_ready_i(decode_ready_i),
        
        // Status outputs
        .buffer_empty_o(buffer_empty_o),
        .buffer_full_o(buffer_full_o),
        .occupancy_o(occupancy_o),
        
        // Legacy outputs
        .legacy_instruction_o_0(legacy_instruction_o_0),
        .legacy_instruction_o_1(legacy_instruction_o_1),
        .legacy_instruction_o_2(legacy_instruction_o_2),
        .legacy_imm_o_0(legacy_imm_o_0),
        .legacy_imm_o_1(legacy_imm_o_1),
        .legacy_imm_o_2(legacy_imm_o_2),
        .pc_plus_o(pc_plus_o)
    );
    
    // Simple memory model
    always_ff @(posedge clk) begin
        instruction_i_0 <= test_memory[inst_addr_0[11:2]];
        instruction_i_1 <= test_memory[inst_addr_1[11:2]];
        instruction_i_2 <= test_memory[inst_addr_2[11:2]];
    end

    always @(inst_addr_0)
    begin
        $display("[%0t] Fetching instruction 0 from address: 0x%08h, Instruction: 0x%08h", $time, inst_addr_0, instruction_i_0);
        $display("[%0t] Fetching instruction 1 from address: 0x%08h, Instruction: 0x%08h", $time, inst_addr_1, instruction_i_1);
        $display("[%0t] Fetching instruction 2 from address: 0x%08h, Instruction: 0x%08h", $time, inst_addr_2, instruction_i_2);
    end
    
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
        $display("=== Fetch Buffer Integration Testbench Started ===");
        
        // Initialize all signals
        reset = 0;
        flush = 0;
        buble = 0;
        
        // Initialize branch prediction inputs
        update_prediction_valid_i_0 = 0;
        update_prediction_valid_i_1 = 0;
        update_prediction_valid_i_2 = 0;
        update_prediction_pc_0 = 0;
        update_prediction_pc_1 = 0;
        update_prediction_pc_2 = 0;
        misprediction_0 = 0;
        misprediction_1 = 0;
        misprediction_2 = 0;
        correct_pc = 0;
        
        // Initialize decode ready
        decode_ready_i = 3'b111;
        
        // Load test program
        load_branch_test_program();
        
        // Reset sequence
        #(CLK_PERIOD * 2);
        reset = 1;
        $display("[%0t] Reset released", $time);
        
        // Test Case 1: No branch prediction (all instructions valid)
        #(CLK_PERIOD * 50);
        
        
        #(CLK_PERIOD * 10);
        $display("=== All Tests Completed Successfully ===");
        $finish;
    end
    
    // Load test program with branch instructions
    task load_branch_test_program();
        $display("[%0t] Loading branch test program", $time);
        
        // Normal instructions
        test_memory[0] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[1] = 32'h00100093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[2] = 32'h00200113;  // addi x2, x0, 2  @ 0x80000008
        test_memory[3] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[4] = 32'h00200093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[5] = 32'h00300113;  // addi x2, x0, 2  @ 0x80000008
        test_memory[6] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[7] = 32'h00300093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[8] = 32'h00400113;  // addi x2, x0, 2  @ 0x80000008
        test_memory[9] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[10] = 32'h00400093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[11] = 32'h00500113;  // addi x2, x0, 2  @ 0x80000008
        test_memory[12] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[13] = 32'h00500093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[14] = 32'h00600113;  // addi x2, x0, 2  @ 0x80000008
        test_memory[15] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[16] = 32'h00600093;  // addi x1, x0, 1  @ 0x80000004
        test_memory[17] = 32'h00700113;  // addi x2, x0, 2  @ 0x80000008
        
        
        // Branch instructions for testing
        test_memory[18] = 32'h00208663;  // beq x1, x2, 8   @ 0x80000010 (branch)
        test_memory[19] = 32'h00318213;  // addi x4, x3, 3  @ 0x80000014 (should not fetch if prev branch taken)
        test_memory[20] = 32'h0041f293;  // andi x5, x3, 4  @ 0x80000018 (should not fetch if prev branch taken)
        test_memory[21] = 32'h00208663;  // beq x1, x2, 8   @ 0x80000010 (branch)
        test_memory[22] = 32'h00318213;  // addi x4, x3, 3  @ 0x80000014 (should not fetch if prev branch taken)
        test_memory[23] = 32'h0041f293;  // andi x5, x3, 4  @ 0x80000018 (should not fetch if prev branch taken)

        
        test_memory[24] = 32'h00100093;  // addi x1, x0, 1  @ 0x80000020
        test_memory[25] = 32'h00208663;  // beq x1, x2, 8   @ 0x80000024 (branch at inst_1)
        test_memory[26] = 32'h00300393; // addi x7, x0, 3  @ 0x80000028 (should not fetch if prev branch taken)
        test_memory[27] = 32'h00100093;  // addi x1, x0, 1  @ 0x80000020
        test_memory[28] = 32'h00208663;  // beq x1, x2, 8   @ 0x80000024 (branch at inst_1)
        test_memory[29] = 32'h00300393;
        
        test_memory[30] = 32'h00500493; // addi x9, x0, 5  @ 0x80000030
        test_memory[31] = 32'h00600513; // addi x10, x0, 6 @ 0x80000034
        test_memory[32] = 32'h00208663; // beq x1, x2, 16  @ 0x80000038 (branch at inst_2)
        test_memory[33] = 32'h00500493; // addi x9, x0, 5  @ 0x80000030
        test_memory[34] = 32'h00600513; // addi x10, x0, 6 @ 0x80000034
        test_memory[35] = 32'h00208663; // beq x1, x2, 16  @ 0x80000038 (branch at inst_2)
        test_memory[36] = 32'h00000013;  // nop             @ 0x80000000
        test_memory[37] = 32'h00000013;
        test_memory[38] = 32'h00000013;
        test_memory[39] = 32'h00000013; 
        test_memory[40] = 32'h00000013; 
        test_memory[41] = 32'h00000013; 
        test_memory[42] = 32'h00000013;

        $display("[%0t] Branch test program loaded", $time);
    endtask
    
    
   
    
    // Timeout protection
    initial begin
        #(CLK_PERIOD * 1000);
        $error("Testbench timeout!");
        $finish;
    end

endmodule
