`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: multi_port_register_file
//
// Description:
//     Multi-port register file supporting multiple simultaneous reads and writes
//     for superscalar processor. Implements RISC-V register file semantics with
//     register x0 hardwired to zero.
//
// Features:
//     - Configurable number of read and write ports
//     - Register x0 always reads as zero, writes ignored
//     - Simultaneous multi-port access
//     - Write-through behavior for same-cycle read/write
//////////////////////////////////////////////////////////////////////////////////

module multi_port_register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 6,  // Changed to 6 for 64 physical registers
    parameter NUM_REGISTERS = 64  // Extended to 64 physical registers
)(
    input logic clk,
    input logic reset,
    
    // Read ports (descriptive naming for better understanding)
    input logic [ADDR_WIDTH-1:0] inst_0_read_addr_a, inst_0_read_addr_b,  // Instruction 0 operands A and B
    input logic [ADDR_WIDTH-1:0] inst_1_read_addr_a, inst_1_read_addr_b,  // Instruction 1 operands A and B
    input logic [ADDR_WIDTH-1:0] inst_2_read_addr_a, inst_2_read_addr_b,  // Instruction 2 operands A and B
    output logic [DATA_WIDTH-1:0] inst_0_read_data_a, inst_0_read_data_b,  // Instruction 0 data outputs
    output logic [DATA_WIDTH-1:0] inst_1_read_data_a, inst_1_read_data_b,  // Instruction 1 data outputs
    output logic [DATA_WIDTH-1:0] inst_2_read_data_a, inst_2_read_data_b,  // Instruction 2 data outputs
    
    // Commit ports - for ROB commits (3 simultaneous commits with different addresses)
    input logic commit_enable_0, commit_enable_1, commit_enable_2,
    input logic [ADDR_WIDTH-1:0] commit_addr_0, commit_addr_1, commit_addr_2,
    input logic [DATA_WIDTH-1:0] commit_data_0, commit_data_1, commit_data_2
);

    localparam D = 1; // Delay for simulation purposes
    
    // Register file memory with tags
    logic [NUM_REGISTERS-1:0][DATA_WIDTH-1:0] register_data;
    
    //==========================================================================
    // REGISTER FILE UPDATE
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset all registers to zero with valid tags
            for (int i = 0; i < NUM_REGISTERS; i++) begin
                register_data[i] <= #D '0;
            end
            register_data[2] <= #D 32'h7FFFFFF0;
        end else begin
            // Handle commits from ROB (sets data and marks as valid)
            // No conflicts since ROB guarantees different addresses
            if (commit_enable_0 && commit_addr_0 != 0) begin
                register_data[commit_addr_0] <= #D commit_data_0;
            end
            if (commit_enable_1 && commit_addr_1 != 0) begin
                register_data[commit_addr_1] <= #D commit_data_1;
            end
            if (commit_enable_2 && commit_addr_2 != 0) begin
                register_data[commit_addr_2] <= #D commit_data_2;
            end
            
            // x0 is always zero and valid
            register_data[0] <= #D '0;
        end
    end
    
    //==========================================================================
    // READ PORT IMPLEMENTATION 
    //==========================================================================

    logic inst_0_read_addr_a_equal_commit_addr_0, inst_0_read_addr_a_equal_commit_addr_1, inst_0_read_addr_a_equal_commit_addr_2;
    logic inst_0_read_addr_b_equal_commit_addr_0, inst_0_read_addr_b_equal_commit_addr_1, inst_0_read_addr_b_equal_commit_addr_2;
    logic inst_1_read_addr_a_equal_commit_addr_0, inst_1_read_addr_a_equal_commit_addr_1, inst_1_read_addr_a_equal_commit_addr_2;
    logic inst_1_read_addr_b_equal_commit_addr_0, inst_1_read_addr_b_equal_commit_addr_1, inst_1_read_addr_b_equal_commit_addr_2;
    logic inst_2_read_addr_a_equal_commit_addr_0, inst_2_read_addr_a_equal_commit_addr_1, inst_2_read_addr_a_equal_commit_addr_2;
    logic inst_2_read_addr_b_equal_commit_addr_0, inst_2_read_addr_b_equal_commit_addr_1, inst_2_read_addr_b_equal_commit_addr_2;
    
    // todo think smaller logic
    // todo forwarding from higher ports to lower ports????
    assign inst_0_read_addr_a_equal_commit_addr_0 = (commit_addr_0 == inst_0_read_addr_a) && (commit_addr_0 != 0);
    assign inst_0_read_addr_a_equal_commit_addr_1 = (commit_addr_1 == inst_0_read_addr_a) && (commit_addr_1 != 0);
    assign inst_0_read_addr_a_equal_commit_addr_2 = (commit_addr_2 == inst_0_read_addr_a) && (commit_addr_2 != 0);
    assign inst_0_read_addr_b_equal_commit_addr_0 = (commit_addr_0 == inst_0_read_addr_b) && (commit_addr_0 != 0);
    assign inst_0_read_addr_b_equal_commit_addr_1 = (commit_addr_1 == inst_0_read_addr_b) && (commit_addr_1 != 0);
    assign inst_0_read_addr_b_equal_commit_addr_2 = (commit_addr_2 == inst_0_read_addr_b) && (commit_addr_2 != 0);
    assign inst_1_read_addr_a_equal_commit_addr_0 = (commit_addr_0 == inst_1_read_addr_a) && (commit_addr_0 != 0);
    assign inst_1_read_addr_a_equal_commit_addr_1 = (commit_addr_1 == inst_1_read_addr_a) && (commit_addr_1 != 0);
    assign inst_1_read_addr_a_equal_commit_addr_2 = (commit_addr_2 == inst_1_read_addr_a) && (commit_addr_2 != 0);
    assign inst_1_read_addr_b_equal_commit_addr_0 = (commit_addr_0 == inst_1_read_addr_b) && (commit_addr_0 != 0);
    assign inst_1_read_addr_b_equal_commit_addr_1 = (commit_addr_1 == inst_1_read_addr_b) && (commit_addr_1 != 0);
    assign inst_1_read_addr_b_equal_commit_addr_2 = (commit_addr_2 == inst_1_read_addr_b) && (commit_addr_2 != 0);
    assign inst_2_read_addr_a_equal_commit_addr_0 = (commit_addr_0 == inst_2_read_addr_a) && (commit_addr_0 != 0);
    assign inst_2_read_addr_a_equal_commit_addr_1 = (commit_addr_1 == inst_2_read_addr_a) && (commit_addr_1 != 0);
    assign inst_2_read_addr_a_equal_commit_addr_2 = (commit_addr_2 == inst_2_read_addr_a) && (commit_addr_2 != 0);
    assign inst_2_read_addr_b_equal_commit_addr_0 = (commit_addr_0 == inst_2_read_addr_b) && (commit_addr_0 != 0);
    assign inst_2_read_addr_b_equal_commit_addr_1 = (commit_addr_1 == inst_2_read_addr_b) && (commit_addr_1 != 0);
    assign inst_2_read_addr_b_equal_commit_addr_2 = (commit_addr_2 == inst_2_read_addr_b) && (commit_addr_2 != 0);
    
    // Read port 0: can forward from commit 2, 1, or 0 
    always_comb begin
        if(inst_0_read_addr_a_equal_commit_addr_2) begin
            inst_0_read_data_a = commit_data_2;
        end
        else if(inst_0_read_addr_a_equal_commit_addr_1) begin
            inst_0_read_data_a = commit_data_1;
        end
        else if(inst_0_read_addr_a_equal_commit_addr_0) begin
            inst_0_read_data_a = commit_data_0;
        end
        else begin
            inst_0_read_data_a = register_data[inst_0_read_addr_a];
        end
    end

    always_comb begin
        if(inst_0_read_addr_b_equal_commit_addr_2) begin
            inst_0_read_data_b = commit_data_2;
            
        end
        else if(inst_0_read_addr_b_equal_commit_addr_1) begin
            inst_0_read_data_b = commit_data_1;
           
        end
        else if(inst_0_read_addr_b_equal_commit_addr_0) begin
            inst_0_read_data_b = commit_data_0;
           
        end
        else begin
            inst_0_read_data_b = register_data[inst_0_read_addr_b];
           
        end
    end

    // Read port 1: can forward from commit 2, 1, or 0, or alloc 0
    always_comb begin
        if(inst_1_read_addr_a_equal_commit_addr_2) begin
            inst_1_read_data_a = commit_data_2;
        end
        else if(inst_1_read_addr_a_equal_commit_addr_1) begin
            inst_1_read_data_a = commit_data_1;
        end
        else if(inst_1_read_addr_a_equal_commit_addr_0) begin
            inst_1_read_data_a = commit_data_0;
        end else begin
            inst_1_read_data_a = register_data[inst_1_read_addr_a];
        end
    end

    always_comb begin
        if(inst_1_read_addr_b_equal_commit_addr_2) begin
            inst_1_read_data_b = commit_data_2;
        end
        else if(inst_1_read_addr_b_equal_commit_addr_1) begin
            inst_1_read_data_b = commit_data_1;
        end
        else if(inst_1_read_addr_b_equal_commit_addr_0) begin
            inst_1_read_data_b = commit_data_0;
        end else begin
            inst_1_read_data_b = register_data[inst_1_read_addr_b];
        end
    end
    
    // Read port 2: can forward from commit 2, 1, or 0, or alloc 1 or 0
    always_comb begin
        if(inst_2_read_addr_a_equal_commit_addr_2) begin
            inst_2_read_data_a = commit_data_2;
        end
        else if(inst_2_read_addr_a_equal_commit_addr_1) begin
            inst_2_read_data_a = commit_data_1;
        end
        else if(inst_2_read_addr_a_equal_commit_addr_0) begin
            inst_2_read_data_a = commit_data_0;
        end else begin
            inst_2_read_data_a = register_data[inst_2_read_addr_a];
        end
    end

    always_comb begin
        if(inst_2_read_addr_b_equal_commit_addr_2) begin
            inst_2_read_data_b = commit_data_2;
        end
        else if(inst_2_read_addr_b_equal_commit_addr_1) begin
            inst_2_read_data_b = commit_data_1;
        end
        else if(inst_2_read_addr_b_equal_commit_addr_0) begin
            inst_2_read_data_b = commit_data_0;
        end else begin
            inst_2_read_data_b = register_data[inst_2_read_addr_b];
        end
    end

endmodule
