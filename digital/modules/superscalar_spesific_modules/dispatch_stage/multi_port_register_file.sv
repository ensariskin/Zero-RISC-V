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
    parameter NUM_REGISTERS = 64,  // Extended to 64 physical registers
    parameter TAG_WIDTH = 2        // 2 bits: 00=ALU0, 01=ALU1, 10=ALU2, 11=VALID
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
    output logic [TAG_WIDTH-1:0] inst_0_read_tag_a, inst_0_read_tag_b,     // Instruction 0 tag outputs
    output logic [TAG_WIDTH-1:0] inst_1_read_tag_a, inst_1_read_tag_b,     // Instruction 1 tag outputs
    output logic [TAG_WIDTH-1:0] inst_2_read_tag_a, inst_2_read_tag_b,     // Instruction 2 tag outputs
    
    // Write ports - for register allocation (sets tag to ALU) during decode
    input logic alloc_enable_0, alloc_enable_1, alloc_enable_2,
    input logic [ADDR_WIDTH-1:0] alloc_addr_0, alloc_addr_1, alloc_addr_2,
    input logic [TAG_WIDTH-1:0] alloc_tag_0, alloc_tag_1, alloc_tag_2,
    
    // Commit ports - for ROB commits (3 simultaneous commits with different addresses)
    input logic commit_enable_0, commit_enable_1, commit_enable_2,
    input logic [ADDR_WIDTH-1:0] commit_addr_0, commit_addr_1, commit_addr_2,
    input logic [DATA_WIDTH-1:0] commit_data_0, commit_data_1, commit_data_2
);

    localparam D = 1; // Delay for simulation purposes
    localparam TAG_VALID = 2'b11;  // Tag value indicating data is valid
    //localparam TAG_ALU0 = 2'b00;   // Tag value indicating ALU0 will produce data
    //localparam TAG_ALU1 = 2'b01;   // Tag value indicating ALU1 will produce data
    //localparam TAG_ALU2 = 2'b10;   // Tag value indicating ALU2 will produce data

    // No internal arrays - using direct port connections for cleaner code

    
    // Register file memory with tags
    logic [NUM_REGISTERS-1:0][DATA_WIDTH-1:0] register_data;
    logic [NUM_REGISTERS-1:0][TAG_WIDTH-1:0] register_tags;
    
    //==========================================================================
    // REGISTER FILE UPDATE (SIMPLIFIED FOR ROB)
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset all registers to zero with valid tags
            for (int i = 0; i < NUM_REGISTERS; i++) begin
                register_data[i] <= #D '0;
                register_tags[i] <= #D TAG_VALID;
            end
        end else begin
            // Handle allocation during decode (sets tags)
            if (alloc_enable_0 && alloc_addr_0 != 0) begin
                register_tags[alloc_addr_0] <= #D alloc_tag_0;
                // Data doesn't matter during allocation, just setting the tag
            end
            if (alloc_enable_1 && alloc_addr_1 != 0) begin
                register_tags[alloc_addr_1] <= #D alloc_tag_1;
            end
            if (alloc_enable_2 && alloc_addr_2 != 0) begin
                register_tags[alloc_addr_2] <= #D alloc_tag_2;
            end
            
            // Handle commits from ROB (sets data and marks as valid)
            // No conflicts since ROB guarantees different addresses
            if (commit_enable_0 && commit_addr_0 != 0) begin
                register_data[commit_addr_0] <= #D commit_data_0;
                register_tags[commit_addr_0] <= #D TAG_VALID;
            end
            if (commit_enable_1 && commit_addr_1 != 0) begin
                register_data[commit_addr_1] <= #D commit_data_1;
                register_tags[commit_addr_1] <= #D TAG_VALID;
            end
            if (commit_enable_2 && commit_addr_2 != 0) begin
                register_data[commit_addr_2] <= #D commit_data_2;
                register_tags[commit_addr_2] <= #D TAG_VALID;
            end
            
            // x0 is always zero and valid
            register_data[0] <= #D '0;
            register_tags[0] <= #D TAG_VALID;
        end
    end
    
    //==========================================================================
    // READ PORT IMPLEMENTATION (DIRECT ASSIGNMENTS WITHOUT ARRAYS)
    //==========================================================================

    // Address matching signals for debugging forwarding logic
    logic inst_1_read_addr_a_equal_alloc_addr_0;
    logic inst_1_read_addr_b_equal_alloc_addr_0;
    logic inst_2_read_addr_a_equal_alloc_addr_0, inst_2_read_addr_a_equal_alloc_addr_1;
    logic inst_2_read_addr_b_equal_alloc_addr_0, inst_2_read_addr_b_equal_alloc_addr_1;

    // Generate address matching signals
    
    assign inst_1_read_addr_a_equal_alloc_addr_0 = (alloc_addr_0 == inst_1_read_addr_a) && (alloc_addr_0 != 0);
    
    assign inst_1_read_addr_b_equal_alloc_addr_0 = (alloc_addr_0 == inst_1_read_addr_b) && (alloc_addr_0 != 0);
    
    assign inst_2_read_addr_a_equal_alloc_addr_0 = (alloc_addr_0 == inst_2_read_addr_a) && (alloc_addr_0 != 0);
    assign inst_2_read_addr_a_equal_alloc_addr_1 = (alloc_addr_1 == inst_2_read_addr_a) && (alloc_addr_1 != 0);
    
    assign inst_2_read_addr_b_equal_alloc_addr_0 = (alloc_addr_0 == inst_2_read_addr_b) && (alloc_addr_0 != 0);
    assign inst_2_read_addr_b_equal_alloc_addr_1 = (alloc_addr_1 == inst_2_read_addr_b) && (alloc_addr_1 != 0);
    

    logic inst_0_read_addr_a_equal_commit_addr_0, inst_0_read_addr_a_equal_commit_addr_1, inst_0_read_addr_a_equal_commit_addr_2;
    logic inst_0_read_addr_b_equal_commit_addr_0, inst_0_read_addr_b_equal_commit_addr_1, inst_0_read_addr_b_equal_commit_addr_2;
    logic inst_1_read_addr_a_equal_commit_addr_0, inst_1_read_addr_a_equal_commit_addr_1, inst_1_read_addr_a_equal_commit_addr_2;
    logic inst_1_read_addr_b_equal_commit_addr_0, inst_1_read_addr_b_equal_commit_addr_1, inst_1_read_addr_b_equal_commit_addr_2;
    logic inst_2_read_addr_a_equal_commit_addr_0, inst_2_read_addr_a_equal_commit_addr_1, inst_2_read_addr_a_equal_commit_addr_2;
    logic inst_2_read_addr_b_equal_commit_addr_0, inst_2_read_addr_b_equal_commit_addr_1, inst_2_read_addr_b_equal_commit_addr_2;
    
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
            inst_0_read_tag_a  = TAG_VALID;
        end
        else if(inst_0_read_addr_a_equal_commit_addr_1) begin
            inst_0_read_data_a = commit_data_1;
            inst_0_read_tag_a  = TAG_VALID;
        end
        else if(inst_0_read_addr_a_equal_commit_addr_0) begin
            inst_0_read_data_a = commit_data_0;
            inst_0_read_tag_a  = TAG_VALID;
        end
        else begin
            inst_0_read_data_a = register_data[inst_0_read_addr_a];
            inst_0_read_tag_a  = register_tags[inst_0_read_addr_a];
        end
    end

    always_comb begin
        if(inst_0_read_addr_b_equal_commit_addr_2) begin
            inst_0_read_data_b = commit_data_2;
            inst_0_read_tag_b  = TAG_VALID;
        end
        else if(inst_0_read_addr_b_equal_commit_addr_1) begin
            inst_0_read_data_b = commit_data_1;
            inst_0_read_tag_b  = TAG_VALID;
        end
        else if(inst_0_read_addr_b_equal_commit_addr_0) begin
            inst_0_read_data_b = commit_data_0;
            inst_0_read_tag_b  = TAG_VALID;
        end
        else begin
            inst_0_read_data_b = register_data[inst_0_read_addr_b];
            inst_0_read_tag_b  = register_tags[inst_0_read_addr_b];
        end
    end

    // Read port 1: can forward from commit 2, 1, or 0, or alloc 0
    always_comb begin
        if(inst_1_read_addr_a_equal_commit_addr_2) begin
            inst_1_read_data_a = commit_data_2;
            inst_1_read_tag_a  = TAG_VALID;
        end
        else if(inst_1_read_addr_a_equal_commit_addr_1) begin
            inst_1_read_data_a = commit_data_1;
            inst_1_read_tag_a  = TAG_VALID;
        end
        else if(inst_1_read_addr_a_equal_commit_addr_0) begin
            inst_1_read_data_a = commit_data_0;
            inst_1_read_tag_a  = TAG_VALID;
        end
        else if(alloc_enable_0 && inst_1_read_addr_a_equal_alloc_addr_0) begin
            inst_1_read_data_a = 0;
            inst_1_read_tag_a  = alloc_tag_0;
        end else begin
            inst_1_read_data_a = register_data[inst_1_read_addr_a];
            inst_1_read_tag_a  = register_tags[inst_1_read_addr_a];
        end
    end

    always_comb begin
        if(inst_1_read_addr_b_equal_commit_addr_2) begin
            inst_1_read_data_b = commit_data_2;
            inst_1_read_tag_b  = TAG_VALID;
        end
        else if(inst_1_read_addr_b_equal_commit_addr_1) begin
            inst_1_read_data_b = commit_data_1;
            inst_1_read_tag_b  = TAG_VALID;
        end
        else if(inst_1_read_addr_b_equal_commit_addr_0) begin
            inst_1_read_data_b = commit_data_0;
            inst_1_read_tag_b  = TAG_VALID;
        end
        else if (alloc_enable_0 && inst_1_read_addr_b_equal_alloc_addr_0) begin
            inst_1_read_data_b = 0;
            inst_1_read_tag_b  = alloc_tag_0;
        end else begin
            inst_1_read_data_b = register_data[inst_1_read_addr_b];
            inst_1_read_tag_b  = register_tags[inst_1_read_addr_b];
        end
    end
    
    // Read port 2: can forward from commit 2, 1, or 0, or alloc 1 or 0
    always_comb begin
        if(inst_2_read_addr_a_equal_commit_addr_2) begin
            inst_2_read_data_a = commit_data_2;
            inst_2_read_tag_a  = TAG_VALID;
        end
        else if(inst_2_read_addr_a_equal_commit_addr_1) begin
            inst_2_read_data_a = commit_data_1;
            inst_2_read_tag_a  = TAG_VALID;
        end
        else if(inst_2_read_addr_a_equal_commit_addr_0) begin
            inst_2_read_data_a = commit_data_0;
            inst_2_read_tag_a  = TAG_VALID;
        end
        else if (alloc_enable_1 && inst_2_read_addr_a_equal_alloc_addr_1 ) begin
            inst_2_read_data_a = 0;
            inst_2_read_tag_a  = alloc_tag_1;
        end else if (alloc_enable_0 && inst_2_read_addr_a_equal_alloc_addr_0) begin
            inst_2_read_data_a = 0;
            inst_2_read_tag_a  = alloc_tag_0;
        end else begin
            inst_2_read_data_a = register_data[inst_2_read_addr_a];
            inst_2_read_tag_a  = register_tags[inst_2_read_addr_a];
        end
    end

    always_comb begin
        if(inst_2_read_addr_b_equal_commit_addr_2) begin
            inst_2_read_data_b = commit_data_2;
            inst_2_read_tag_b  = TAG_VALID;
        end
        else if(inst_2_read_addr_b_equal_commit_addr_1) begin
            inst_2_read_data_b = commit_data_1;
            inst_2_read_tag_b  = TAG_VALID;
        end
        else if(inst_2_read_addr_b_equal_commit_addr_0) begin
            inst_2_read_data_b = commit_data_0;
            inst_2_read_tag_b  = TAG_VALID;
        end
        else if (alloc_enable_1 && inst_2_read_addr_b_equal_alloc_addr_1) begin
            inst_2_read_data_b = 0;
            inst_2_read_tag_b  = alloc_tag_1;
        end else if (alloc_enable_0 && inst_2_read_addr_b_equal_alloc_addr_0) begin
            inst_2_read_data_b = 0;
            inst_2_read_tag_b  = alloc_tag_0;
        end else begin
            inst_2_read_data_b = register_data[inst_2_read_addr_b];
            inst_2_read_tag_b  = register_tags[inst_2_read_addr_b];
        end
    end

endmodule
