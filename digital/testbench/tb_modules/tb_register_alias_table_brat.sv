`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Testbench: tb_register_alias_table_brat
//
// Description:
//     Comprehensive testbench for Register Alias Table with BRAT stack
//     Tests branch snapshot push/pop, misprediction recovery, and RAT restore
//////////////////////////////////////////////////////////////////////////////////

module tb_register_alias_table_brat;

    // Parameters
    localparam ARCH_REGS = 32;
    localparam PHYS_REGS = 64;
    localparam ARCH_ADDR_WIDTH = 5;
    localparam PHYS_ADDR_WIDTH = 6;
    localparam BRAT_STACK_DEPTH = 16;
    localparam CLK_PERIOD = 10;

    // Clock and Reset
    logic clk;
    logic reset;
    logic flush;

    // Decode interface
    logic [4:0] rs1_arch_0, rs1_arch_1, rs1_arch_2;
    logic [4:0] rs2_arch_0, rs2_arch_1, rs2_arch_2;
    logic [4:0] rd_arch_0, rd_arch_1, rd_arch_2;
    logic [2:0] decode_valid;
    logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2;
    logic branch_0, branch_1, branch_2;

    // Rename outputs
    logic [5:0] rs1_phys_0, rs1_phys_1, rs1_phys_2;
    logic [5:0] rs2_phys_0, rs2_phys_1, rs2_phys_2;
    logic [5:0] rd_phys_0, rd_phys_1, rd_phys_2;
    logic [2:0] alloc_tag_0, alloc_tag_1, alloc_tag_2;
    logic [5:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2;
    logic [2:0] rename_valid;
    logic [2:0] rename_ready;

    // Commit interface
    logic [4:0] commit_addr_0, commit_addr_1, commit_addr_2;
    logic [4:0] commit_rob_idx_0, commit_rob_idx_1, commit_rob_idx_2;
    logic [2:0] commit_valid;

    // LSQ interface
    logic load_store_0, load_store_1, load_store_2;
    logic [2:0] lsq_alloc_ready;
    logic lsq_alloc_0_valid, lsq_alloc_1_valid, lsq_alloc_2_valid;
    logic lsq_commit_0, lsq_commit_1, lsq_commit_2;

    // Branch resolution interface
    logic [2:0] branch_resolved;
    logic [2:0] branch_mispredicted;
    logic [5:0] resolved_phys_reg_0, resolved_phys_reg_1, resolved_phys_reg_2;

    logic [5:0] branch_phys_reg_saved;
    logic [5:0] branch1_phys;
    logic [5:0] branch2_phys; 
    logic [5:0] rat_before_mispredict [32];
    logic [5:0] saved_snapshot [32];
    logic [5:0] inst0_rd, inst1_rd, branch_slot2_phys;
    logic rat_identity;
    logic rat_restored_correctly;
    logic [3:0] tail_minus_one;

    // Test statistics
    int test_count = 0;
    int pass_count = 0;
    int fail_count = 0;

    // DUT Instantiation
    register_alias_table #(
        .ARCH_REGS(ARCH_REGS),
        .PHYS_REGS(PHYS_REGS),
        .ARCH_ADDR_WIDTH(ARCH_ADDR_WIDTH),
        .PHYS_ADDR_WIDTH(PHYS_ADDR_WIDTH),
        .BRAT_STACK_DEPTH(BRAT_STACK_DEPTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .rs1_arch_0(rs1_arch_0), .rs1_arch_1(rs1_arch_1), .rs1_arch_2(rs1_arch_2),
        .rs2_arch_0(rs2_arch_0), .rs2_arch_1(rs2_arch_1), .rs2_arch_2(rs2_arch_2),
        .rd_arch_0(rd_arch_0), .rd_arch_1(rd_arch_1), .rd_arch_2(rd_arch_2),
        .decode_valid(decode_valid),
        .rd_write_enable_0(rd_write_enable_0),
        .rd_write_enable_1(rd_write_enable_1),
        .rd_write_enable_2(rd_write_enable_2),
        .branch_0(branch_0), .branch_1(branch_1), .branch_2(branch_2),
        .rs1_phys_0(rs1_phys_0), .rs1_phys_1(rs1_phys_1), .rs1_phys_2(rs1_phys_2),
        .rs2_phys_0(rs2_phys_0), .rs2_phys_1(rs2_phys_1), .rs2_phys_2(rs2_phys_2),
        .rd_phys_0(rd_phys_0), .rd_phys_1(rd_phys_1), .rd_phys_2(rd_phys_2),
        .alloc_tag_0(alloc_tag_0), .alloc_tag_1(alloc_tag_1), .alloc_tag_2(alloc_tag_2),
        .old_rd_phys_0(old_rd_phys_0),
        .old_rd_phys_1(old_rd_phys_1),
        .old_rd_phys_2(old_rd_phys_2),
        .rename_valid(rename_valid),
        .rename_ready(rename_ready),
        .commit_addr_0(commit_addr_0), .commit_addr_1(commit_addr_1), .commit_addr_2(commit_addr_2),
        .commit_rob_idx_0(commit_rob_idx_0),
        .commit_rob_idx_1(commit_rob_idx_1),
        .commit_rob_idx_2(commit_rob_idx_2),
        .commit_valid(commit_valid),
        .load_store_0(load_store_0), .load_store_1(load_store_1), .load_store_2(load_store_2),
        .lsq_alloc_ready(lsq_alloc_ready),
        .lsq_alloc_0_valid(lsq_alloc_0_valid),
        .lsq_alloc_1_valid(lsq_alloc_1_valid),
        .lsq_alloc_2_valid(lsq_alloc_2_valid),
        .lsq_commit_0(lsq_commit_0), .lsq_commit_1(lsq_commit_1), .lsq_commit_2(lsq_commit_2),
        .branch_resolved(branch_resolved),
        .branch_mispredicted(branch_mispredicted),
        .resolved_phys_reg_0(resolved_phys_reg_0),
        .resolved_phys_reg_1(resolved_phys_reg_1),
        .resolved_phys_reg_2(resolved_phys_reg_2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Helper task to initialize inputs
    task init_inputs();
        reset = 1;
        flush = 0;
        decode_valid = 3'b000;
        rd_write_enable_0 = 0;
        rd_write_enable_1 = 0;
        rd_write_enable_2 = 0;
        branch_0 = 0;
        branch_1 = 0;
        branch_2 = 0;
        rs1_arch_0 = 0; rs1_arch_1 = 0; rs1_arch_2 = 0;
        rs2_arch_0 = 0; rs2_arch_1 = 0; rs2_arch_2 = 0;
        rd_arch_0 = 0; rd_arch_1 = 0; rd_arch_2 = 0;
        commit_valid = 3'b000;
        commit_addr_0 = 0; commit_addr_1 = 0; commit_addr_2 = 0;
        commit_rob_idx_0 = 0; commit_rob_idx_1 = 0; commit_rob_idx_2 = 0;
        load_store_0 = 0; load_store_1 = 0; load_store_2 = 0;
        // lsq_alloc_ready is an OUTPUT from DUT, don't drive it
        lsq_commit_0 = 0; lsq_commit_1 = 0; lsq_commit_2 = 0;
        branch_resolved = 3'b000;
        branch_mispredicted = 3'b000;
        resolved_phys_reg_0 = 0;
        resolved_phys_reg_1 = 0;
        resolved_phys_reg_2 = 0;
    endtask

    // Helper task to check condition
    task check(string test_name, logic condition);
        test_count++;
        if (condition) begin
            $display("[PASS] %s", test_name);
            pass_count++;
        end else begin
            $display("[FAIL] %s", test_name);
            fail_count++;
        end
    endtask

    // Helper task to dispatch instruction
    task dispatch_instruction(
        input int slot,
        input logic [4:0] rd,
        input logic [4:0] rs1,
        input logic [4:0] rs2,
        input logic is_branch,
        input logic is_load_store
    );
        case(slot)
            0: begin
                decode_valid[0] = 1;
                rd_arch_0 = rd;
                rs1_arch_0 = rs1;
                rs2_arch_0 = rs2;
                rd_write_enable_0 = (rd != 0);
                branch_0 = is_branch;
                load_store_0 = is_load_store;
            end
            1: begin
                decode_valid[1] = 1;
                rd_arch_1 = rd;
                rs1_arch_1 = rs1;
                rs2_arch_1 = rs2;
                rd_write_enable_1 = (rd != 0);
                branch_1 = is_branch;
                load_store_1 = is_load_store;
            end
            2: begin
                decode_valid[2] = 1;
                rd_arch_2 = rd;
                rs1_arch_2 = rs1;
                rs2_arch_2 = rs2;
                rd_write_enable_2 = (rd != 0);
                branch_2 = is_branch;
                load_store_2 = is_load_store;
            end
        endcase
    endtask

    // Test sequence
    initial begin
        $display("========================================");
        $display("  RAT BRAT Stack Testbench Starting");
        $display("========================================\n");

        init_inputs();

        // Reset
        reset = 0;
        repeat(2) @(posedge clk);
        reset = 1;
        @(posedge clk);

        //======================================================================
        // TEST 1: Basic RAT functionality (no branches)
        //======================================================================
        $display("\n[TEST 1] Basic RAT rename without branches");
        
        // Dispatch: ADD x1, x2, x3
        dispatch_instruction(0, 5'd1, 5'd2, 5'd3, 0, 0);
        @(posedge clk);
        check("T1.1: Instruction dispatched", rename_valid[0] == 1);
        check("T1.2: Physical register allocated", rd_phys_0 >= 32); // ROB entry
        
        decode_valid = 3'b000;
        @(posedge clk);

        //======================================================================
        // TEST 2: Single branch push to BRAT stack
        //======================================================================
        $display("\n[TEST 2] Branch instruction pushes to BRAT stack");
        
        // Dispatch: BEQ x4, x5, offset (branch instruction)
        dispatch_instruction(0, 5'd4, 5'd5, 5'd6, 1, 0); // is_branch = 1
        @(posedge clk);
        
        
        
        branch_phys_reg_saved = rd_phys_0;
        check("T2.1: Branch allocated physical register", rd_phys_0 >= 32);
        $display("      Branch physical register: %0d", branch_phys_reg_saved);
        
        decode_valid = 3'b000;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        
        // Verify BRAT stack has entry
        check("T2.2: BRAT stack not empty", dut.brat_count > 0);
        check("T2.3: BRAT entry valid", dut.brat_peek_valid_0 == 1);
        check("T2.4: Branch phys reg stored", dut.brat_peek_phys_0 == branch_phys_reg_saved);

        //======================================================================
        // TEST 3: Branch correct prediction (pop and discard)
        //======================================================================
        $display("\n[TEST 3] Branch resolves correctly - pop and discard");
        
        // Resolve branch correctly
        branch_resolved = 3'b001;
        branch_mispredicted = 3'b000;  // Correct prediction
        resolved_phys_reg_0 = branch_phys_reg_saved;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        
        check("T3.1: BRAT entry popped (buffer empty)", dut.brat_count == 0);
        
        branch_resolved = 3'b000;
        @(posedge clk);

        //======================================================================
        // TEST 4: Multiple branches in flight
        //======================================================================
        $display("\n[TEST 4] Multiple branches in BRAT stack");
        
        // Dispatch branch 1
        dispatch_instruction(0, 5'd7, 5'd8, 5'd9, 1, 0);
        @(posedge clk);
        
        branch1_phys = rd_phys_0;
        
        decode_valid = 3'b000;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        
        // Dispatch some regular instructions
        dispatch_instruction(0, 5'd10, 5'd11, 5'd12, 0, 0);
        @(posedge clk);
        
        decode_valid = 3'b000;
        @(posedge clk);
        
        // Dispatch branch 2
        dispatch_instruction(0, 5'd13, 5'd14, 5'd15, 1, 0);
        @(posedge clk);
        
        
        branch2_phys = rd_phys_0;
        
        decode_valid = 3'b000;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        
        check("T4.1: Two branches in stack", dut.brat_count == 2);
        check("T4.2: First branch valid", dut.brat_peek_valid_0 == 1);
        check("T4.3: Second branch valid", dut.brat_peek_valid_1 == 1);

        //======================================================================
        // TEST 5: Misprediction - restore RAT from BRAT
        //======================================================================
        $display("\n[TEST 5] Branch misprediction - RAT restore");
        
        // Save current RAT state for comparison
        
        for (int i = 0; i < 32; i++) begin
            rat_before_mispredict[i] = dut.rat_table[i];
        end
        
        // Dispatch instruction that will be squashed
        dispatch_instruction(0, 5'd16, 5'd17, 5'd18, 0, 0);
        @(posedge clk);
        
        decode_valid = 3'b000;
        @(posedge clk);
        
        // Save the snapshot before triggering misprediction (from BRAT buffer)
        for (int i = 0; i < 32; i++) begin
            saved_snapshot[i] = dut.brat_buffer.rat_snapshot_mem[dut.brat_buffer.head_ptr[3:0]][i];
        end
        
        // Now trigger misprediction on branch1
        branch_resolved = 3'b001;
        branch_mispredicted = 3'b001;  // Mispredicted!
        resolved_phys_reg_0 = branch1_phys;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        
        // Check that RAT was restored from saved BRAT snapshot
        rat_restored_correctly = 1;
        for (int i = 0; i < 32; i++) begin
            // RAT should match the saved snapshot from when branch1 was dispatched
            if (dut.rat_table[i] != saved_snapshot[i]) begin
                rat_restored_correctly = 0;
                $display("      RAT[%0d] mismatch: current=%0d, expected=%0d", 
                         i, dut.rat_table[i], saved_snapshot[i]);
            end
        end
        check("T5.1: RAT restored from BRAT snapshot", rat_restored_correctly);
        check("T5.2: BRAT buffer flushed", dut.brat_count == 0);
        check("T5.3: Buffer empty after restore", dut.brat_empty == 1);
        check("T5.4: Head pointer reset", dut.brat_buffer.head_ptr == 0);
        
        branch_resolved = 3'b000;
        branch_mispredicted = 3'b000;
        @(posedge clk);

        //======================================================================
        // TEST 6: Instruction ordering in same cycle
        //======================================================================
        $display("\n[TEST 6] Branch in slot 2 - RAT snapshot with inst 0,1 updates");
        
        // Dispatch 3 instructions: 2 regular + 1 branch
        dispatch_instruction(0, 5'd1, 5'd2, 5'd3, 0, 0);  // Updates x1
        dispatch_instruction(1, 5'd4, 5'd1, 5'd5, 0, 0);  // Uses x1, updates x4
        dispatch_instruction(2, 5'd7, 5'd4, 5'd8, 1, 0);  // Branch, uses x4
        
        @(posedge clk);
        inst0_rd = rd_phys_0;
        inst1_rd = rd_phys_1;
        branch_slot2_phys = rd_phys_2;
        #2; // Wait for #D delay in RAT module
        
        // Branch snapshot should include updates from inst 0 and 1
        // The branch is at tail-1 position in circular buffer
        tail_minus_one = (dut.brat_buffer.tail_ptr[3:0] == 0) ? 4'd15 : dut.brat_buffer.tail_ptr[3:0] - 4'd1;
        check("T6.1: BRAT snapshot has inst0 update", 
              dut.brat_buffer.rat_snapshot_mem[tail_minus_one][1] == inst0_rd);
        check("T6.2: BRAT snapshot has inst1 update", 
              dut.brat_buffer.rat_snapshot_mem[tail_minus_one][4] == inst1_rd);
        
        decode_valid = 3'b000;
        @(posedge clk);
        
        // Resolve correctly
        branch_resolved = 3'b001;
        branch_mispredicted = 3'b000;
        resolved_phys_reg_0 = branch_slot2_phys;
        @(posedge clk);
        
        branch_resolved = 3'b000;
        @(posedge clk);

        //======================================================================
        // TEST 7: Global flush
        //======================================================================
        $display("\n[TEST 7] Global flush clears BRAT stack");
        
        // Push some branches
        dispatch_instruction(0, 5'd20, 5'd21, 5'd22, 1, 0);
        @(posedge clk);
        decode_valid = 3'b000;
        @(posedge clk);
        
        dispatch_instruction(0, 5'd23, 5'd24, 5'd25, 1, 0);
        @(posedge clk);
        decode_valid = 3'b000;
        @(posedge clk);
        
        check("T7.1: Branches in stack before flush", dut.brat_count > 0);
        
        // Trigger flush
        flush = 1;
        @(posedge clk);
        #2; // Wait for #D delay in RAT module
        flush = 0;
        
        check("T7.2: Stack cleared after flush", dut.brat_count == 0);
        check("T7.3: Buffer empty", dut.brat_empty == 1);
        check("T7.4: Head pointer reset", dut.brat_buffer.head_ptr == 0);
        
        // Check RAT reset to identity
        rat_identity = 1;
        for (int i = 0; i < 32; i++) begin
            if (dut.rat_table[i] != i[5:0]) begin
                rat_identity = 0;
            end
        end
        check("T7.5: RAT reset to identity mapping", rat_identity);
        
        @(posedge clk);

        //======================================================================
        // TEST 8: Stack full handling
        //======================================================================
        $display("\n[TEST 8] BRAT stack full condition");
        
        // Fill the stack
        for (int i = 0; i < BRAT_STACK_DEPTH; i++) begin
            dispatch_instruction(0, 5'd10, 5'd11, 5'd12, 1, 0);
            @(posedge clk);
            decode_valid = 3'b000;
            @(posedge clk);
        end
        #2; // Wait for #D delay in RAT module
        
        check("T8.1: Stack full", dut.brat_full == 1);
        check("T8.2: Stack count at max", dut.brat_count == BRAT_STACK_DEPTH);
        
        // Try to push when full (should not push)
        dispatch_instruction(0, 5'd15, 5'd16, 5'd17, 1, 0);
        @(posedge clk);
        
        check("T8.3: No push when full", dut.brat_count == BRAT_STACK_DEPTH);
        
        decode_valid = 3'b000;
        flush = 1;
        @(posedge clk);
        flush = 0;
        @(posedge clk);

        //======================================================================
        // Test Summary
        //======================================================================
        $display("\n========================================");
        $display("  Test Summary");
        $display("========================================");
        $display("  Total Tests: %0d", test_count);
        $display("  Passed:      %0d", pass_count);
        $display("  Failed:      %0d", fail_count);
        $display("========================================\n");

        if (fail_count == 0) begin
            $display("*** ALL TESTS PASSED ***\n");
        end else begin
            $display("*** SOME TESTS FAILED ***\n");
        end

        $finish;
    end

    // Timeout
    initial begin
        #100000;
        $display("\n[ERROR] Testbench timeout!");
        $finish;
    end

    // Waveform dump
    initial begin
        $dumpfile("tb_register_alias_table_brat.vcd");
        $dumpvars(0, tb_register_alias_table_brat);
    end

endmodule
