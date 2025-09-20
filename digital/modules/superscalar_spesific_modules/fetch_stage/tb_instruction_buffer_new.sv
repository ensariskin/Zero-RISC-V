`timescale 1ns/1ns

module tb_instruction_buffer_new;

    parameter BUFFER_DEPTH = 8;
    parameter DATA_WIDTH = 32;
    parameter CLK_PERIOD = 10ns;
    
    // DUT signals
    logic clk;
    logic reset;
    logic [2:0] fetch_valid_i;
    logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2;
    logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2;
    logic [DATA_WIDTH-1:0] imm_i_0, imm_i_1, imm_i_2;
    logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2;
    logic [2:0] decode_valid_o;
    logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2;
    logic [DATA_WIDTH-1:0] pc_o_0, pc_o_1, pc_o_2;
    logic [DATA_WIDTH-1:0] imm_o_0, imm_o_1, imm_o_2;
    logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2;
    logic [2:0] decode_ready_i;
    logic fetch_ready_o;
    logic flush_i;
    logic buffer_empty_o;
    logic buffer_full_o;
    logic [3:0] occupancy_o;
    
    // Test signals
    int cycle_count = 0;
    
    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;
    
    // DUT instantiation
    instruction_buffer_new #(
        .BUFFER_DEPTH(BUFFER_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
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
        .decode_ready_i(decode_ready_i),
        .fetch_ready_o(fetch_ready_o),
        .flush_i(flush_i),
        .buffer_empty_o(buffer_empty_o),
        .buffer_full_o(buffer_full_o),
        .occupancy_o(occupancy_o)
    );
    
    // Cycle counter
    always_ff @(posedge clk) begin
        if (reset) cycle_count <= cycle_count + 1;
    end
    
    // Test procedure
    initial begin
        $display("Starting instruction buffer test...");
        
        // Initialize signals
        clk = 0;
        reset = 0;
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
        decode_ready_i = 3'b000;
        flush_i = 1'b0;
        
        // Reset sequence
        repeat(3) @(posedge clk);
        reset = 1;
        repeat(2) @(posedge clk);
        
        $display("Test 1: Basic write/read operation");
        test_basic_operation();
        
        $display("Test 2: Buffer full condition");
        test_buffer_full();
        
        $display("Test 3: Flush operation");
        test_flush();
        
        $display("Test 4: Backpressure handling");
        test_backpressure();
        
        $display("All tests completed!");
        $finish;
    end
    
    // Test basic write/read operation
    task test_basic_operation();
        begin
            $display("[%t] Test 1: Basic operation", $time);
            
            // Write 3 instructions
            @(posedge clk);
            fetch_valid_i = 3'b111;
            instruction_i_0 = 32'hDEADBEEF;
            instruction_i_1 = 32'hCAFEBABE;
            instruction_i_2 = 32'h12345678;
            pc_i_0 = 32'h1000;
            pc_i_1 = 32'h1004;
            pc_i_2 = 32'h1008;
            
            @(posedge clk);
            fetch_valid_i = 3'b000; // Stop writing
            
            // Check if instructions are buffered
            if (occupancy_o != 3) begin
                $error("Expected occupancy 3, got %d", occupancy_o);
            end
            
            // Read 2 instructions
            decode_ready_i = 3'b011;
            @(posedge clk);
            
            if (decode_valid_o != 3'b011) begin
                $error("Expected decode_valid_o = 011, got %b", decode_valid_o);
            end
            
            if (instruction_o_0 != 32'hDEADBEEF || instruction_o_1 != 32'hCAFEBABE) begin
                $error("Instruction mismatch");
            end
            
            decode_ready_i = 3'b000;
            @(posedge clk);
            
            $display("  ✓ Basic operation test passed");
        end
    endtask
    
    // Test buffer full condition
    task test_buffer_full();
        begin
            $display("[%t] Test 2: Buffer full condition", $time);
            
            // Fill buffer to capacity
            decode_ready_i = 3'b000; // No reading
            
            for (int i = 0; i < 3; i++) begin
                @(posedge clk);
                fetch_valid_i = 3'b111;
                instruction_i_0 = 32'h1000 + i*3;
                instruction_i_1 = 32'h1000 + i*3 + 1;
                instruction_i_2 = 32'h1000 + i*3 + 2;
            end
            
            @(posedge clk);
            
            if (!buffer_full_o) begin
                $error("Buffer should be full but full signal not asserted");
            end
            
            if (fetch_ready_o) begin
                $error("Fetch ready should be low when buffer is full");
            end
            
            $display("  ✓ Buffer full test passed");
        end
    endtask
    
    // Test flush operation
    task test_flush();
        begin
            $display("[%t] Test 3: Flush operation", $time);
            
            // Flush the buffer
            @(posedge clk);
            flush_i = 1'b1;
            
            @(posedge clk);
            flush_i = 1'b0;
            
            if (occupancy_o != 0) begin
                $error("Buffer should be empty after flush, occupancy = %d", occupancy_o);
            end
            
            if (!buffer_empty_o) begin
                $error("Buffer empty signal should be asserted after flush");
            end
            
            $display("  ✓ Flush test passed");
        end
    endtask
    
    // Test backpressure handling
    task test_backpressure();
        begin
            $display("[%t] Test 4: Backpressure handling", $time);
            
            // Write some instructions
            @(posedge clk);
            fetch_valid_i = 3'b111;
            instruction_i_0 = 32'hAAAA0000;
            instruction_i_1 = 32'hAAAA0001;
            instruction_i_2 = 32'hAAAA0002;
            
            @(posedge clk);
            fetch_valid_i = 3'b000;
            
            // Try to read with limited decode ready
            decode_ready_i = 3'b001; // Only one decode stage ready
            @(posedge clk);
            
            if (decode_valid_o[0] != 1'b1 || decode_valid_o[1] != 1'b0) begin
                $error("Decode valid mismatch with limited ready signals");
            end
            
            decode_ready_i = 3'b000;
            @(posedge clk);
            
            $display("  ✓ Backpressure test passed");
        end
    endtask
    
    // Monitor changes
    always @(posedge clk) begin
        if (reset) begin
            $display("[%t] Cycle %d: occupancy=%d, empty=%b, full=%b, fetch_ready=%b", 
                     $time, cycle_count, occupancy_o, buffer_empty_o, buffer_full_o, fetch_ready_o);
        end
    end

endmodule