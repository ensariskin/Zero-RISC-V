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
    parameter NUM_READ_PORTS = 6,
    parameter NUM_REGISTERS = 64,  // Extended to 64 physical registers
    parameter TAG_WIDTH = 2        // 2 bits: 00=ALU0, 01=ALU1, 10=ALU2, 11=VALID
)(
    input logic clk,
    input logic reset,
    
    // Read ports (separated signals for better understanding)
    input logic [ADDR_WIDTH-1:0] read_addr_0, read_addr_1, read_addr_2, read_addr_3, read_addr_4, read_addr_5,
    output logic [DATA_WIDTH-1:0] read_data_0, read_data_1, read_data_2, read_data_3, read_data_4, read_data_5,
    output logic [TAG_WIDTH-1:0] read_tag_0, read_tag_1, read_tag_2, read_tag_3, read_tag_4, read_tag_5,
    
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

    // Internal arrays to connect separated signals to existing logic
    logic [NUM_READ_PORTS-1:0][ADDR_WIDTH-1:0] read_addr;
    logic [NUM_READ_PORTS-1:0][DATA_WIDTH-1:0] read_data;
    logic [NUM_READ_PORTS-1:0][TAG_WIDTH-1:0] read_tag;
    
    // Allocation arrays (for setting tags during decode)
    logic [2:0] alloc_enable;
    logic [2:0][ADDR_WIDTH-1:0] alloc_addr;
    logic [2:0][TAG_WIDTH-1:0] alloc_tag;
    
    // Commit arrays (for writing data from ROB)
    logic [2:0] commit_enable;
    logic [2:0][ADDR_WIDTH-1:0] commit_addr;
    logic [2:0][DATA_WIDTH-1:0] commit_data;
    
    // Connect separated input signals to internal arrays
    assign read_addr[0] = read_addr_0; assign read_addr[1] = read_addr_1; assign read_addr[2] = read_addr_2;
    assign read_addr[3] = read_addr_3; assign read_addr[4] = read_addr_4; assign read_addr[5] = read_addr_5;
    
    assign alloc_enable[0] = alloc_enable_0; assign alloc_enable[1] = alloc_enable_1; assign alloc_enable[2] = alloc_enable_2;
    assign alloc_addr[0] = alloc_addr_0; assign alloc_addr[1] = alloc_addr_1; assign alloc_addr[2] = alloc_addr_2;
    assign alloc_tag[0] = alloc_tag_0; assign alloc_tag[1] = alloc_tag_1; assign alloc_tag[2] = alloc_tag_2;
    
    assign commit_enable[0] = commit_enable_0; assign commit_enable[1] = commit_enable_1; assign commit_enable[2] = commit_enable_2;
    assign commit_addr[0] = commit_addr_0; assign commit_addr[1] = commit_addr_1; assign commit_addr[2] = commit_addr_2;
    assign commit_data[0] = commit_data_0; assign commit_data[1] = commit_data_1; assign commit_data[2] = commit_data_2;
    
    // Connect internal arrays to separated output signals
    assign read_data_0 = read_data[0]; assign read_data_1 = read_data[1]; assign read_data_2 = read_data[2];
    assign read_data_3 = read_data[3]; assign read_data_4 = read_data[4]; assign read_data_5 = read_data[5];
    assign read_tag_0 = read_tag[0]; assign read_tag_1 = read_tag[1]; assign read_tag_2 = read_tag[2];
    assign read_tag_3 = read_tag[3]; assign read_tag_4 = read_tag[4]; assign read_tag_5 = read_tag[5];

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
            if (alloc_enable[0] && alloc_addr[0] != 0) begin
                register_tags[alloc_addr[0]] <= #D alloc_tag[0];
                // Data doesn't matter during allocation, just setting the tag
            end
            if (alloc_enable[1] && alloc_addr[1] != 0) begin
                register_tags[alloc_addr[1]] <= #D alloc_tag[1];
            end
            if (alloc_enable[2] && alloc_addr[2] != 0) begin
                register_tags[alloc_addr[2]] <= #D alloc_tag[2];
            end
            
            // Handle commits from ROB (sets data and marks as valid)
            // No conflicts since ROB guarantees different addresses
            if (commit_enable[0] && commit_addr[0] != 0) begin
                register_data[commit_addr[0]] <= #D commit_data[0];
                register_tags[commit_addr[0]] <= #D TAG_VALID;
            end
            if (commit_enable[1] && commit_addr[1] != 0) begin
                register_data[commit_addr[1]] <= #D commit_data[1];
                register_tags[commit_addr[1]] <= #D TAG_VALID;
            end
            if (commit_enable[2] && commit_addr[2] != 0) begin
                register_data[commit_addr[2]] <= #D commit_data[2];
                register_tags[commit_addr[2]] <= #D TAG_VALID;
            end
            
            // x0 is always zero and valid
            register_data[0] <= #D '0;
            register_tags[0] <= #D TAG_VALID;
        end
    end
    
    //==========================================================================
    // READ PORT IMPLEMENTATION (SIMPLIFIED FOR ROB)
    //==========================================================================
    
    generate
        for (genvar port = 0; port < NUM_READ_PORTS; port++) begin : gen_read_ports
            
            // Check for allocation forwarding (same cycle read/allocation)
            logic forward_from_alloc;
            logic [TAG_WIDTH-1:0] forwarded_tag;
            logic [2:0] alloc_match;
            
            // Check if any allocation port is allocating to the same address
            for (genvar ap = 0; ap < 3; ap++) begin : gen_alloc_forward_check
                assign alloc_match[ap] = alloc_enable[ap] && 
                                       (alloc_addr[ap] == read_addr[port]) && 
                                       (read_addr[port] != 0);
            end
            
            // Priority encoder for allocation forwarding - highest port wins
            always_comb begin
                forward_from_alloc = 1'b0;
                forwarded_tag = TAG_VALID;
                
                for (int ap = 2; ap >= 0; ap--) begin
                    if (alloc_match[ap]) begin
                        forward_from_alloc = 1'b1;
                        forwarded_tag = alloc_tag[ap];
                    end
                end
            end
            
            // Output read data and tags with forwarding
            always_comb begin
                if (read_addr[port] == 0) begin
                    // x0 always reads as zero and valid
                    read_data[port] = '0;
                    read_tag[port] = TAG_VALID;
                end else if (forward_from_alloc) begin
                    // Forward tag from concurrent allocation
                    read_data[port] = register_data[read_addr[port]]; // Data doesn't matter for new allocation
                    read_tag[port] = forwarded_tag;
                end else begin
                    // Normal read from register file
                    read_data[port] = register_data[read_addr[port]];
                    read_tag[port] = register_tags[read_addr[port]];
                end
            end
        end
    endgenerate

endmodule
