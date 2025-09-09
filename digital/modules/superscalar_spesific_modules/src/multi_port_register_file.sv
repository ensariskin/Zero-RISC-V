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
    parameter ADDR_WIDTH = 5,
    parameter NUM_READ_PORTS = 6,
    parameter NUM_WRITE_PORTS = 3,
    parameter NUM_REGISTERS = 32
)(
    input logic clk,
    input logic reset,
    
    // Read ports (separated signals for better understanding)
    input logic [ADDR_WIDTH-1:0] read_addr_0, read_addr_1, read_addr_2, read_addr_3, read_addr_4, read_addr_5,
    output logic [DATA_WIDTH-1:0] read_data_0, read_data_1, read_data_2, read_data_3, read_data_4, read_data_5,
    
    // Write ports (separated signals for better understanding)
    input logic write_enable_0, write_enable_1, write_enable_2,
    input logic [ADDR_WIDTH-1:0] write_addr_0, write_addr_1, write_addr_2,
    input logic [DATA_WIDTH-1:0] write_data_0, write_data_1, write_data_2
);

    localparam D = 1; // Delay for simulation purposes

    // Internal arrays to connect separated signals to existing logic
    logic [NUM_READ_PORTS-1:0][ADDR_WIDTH-1:0] read_addr;
    logic [NUM_READ_PORTS-1:0][DATA_WIDTH-1:0] read_data;
    logic [NUM_WRITE_PORTS-1:0] write_enable;
    logic [NUM_WRITE_PORTS-1:0][ADDR_WIDTH-1:0] write_addr;
    logic [NUM_WRITE_PORTS-1:0][DATA_WIDTH-1:0] write_data;
    
    // Connect separated input signals to internal arrays
    assign read_addr[0] = read_addr_0; assign read_addr[1] = read_addr_1; assign read_addr[2] = read_addr_2;
    assign read_addr[3] = read_addr_3; assign read_addr[4] = read_addr_4; assign read_addr[5] = read_addr_5;
    
    assign write_enable[0] = write_enable_0; assign write_enable[1] = write_enable_1; assign write_enable[2] = write_enable_2;
    assign write_addr[0] = write_addr_0; assign write_addr[1] = write_addr_1; assign write_addr[2] = write_addr_2;
    assign write_data[0] = write_data_0; assign write_data[1] = write_data_1; assign write_data[2] = write_data_2;
    
    // Connect internal arrays to separated output signals
    assign read_data_0 = read_data[0]; assign read_data_1 = read_data[1]; assign read_data_2 = read_data[2];
    assign read_data_3 = read_data[3]; assign read_data_4 = read_data[4]; assign read_data_5 = read_data[5];

    // Register file memory
    logic [NUM_REGISTERS-1:0][DATA_WIDTH-1:0] registers;
    
    // Write conflict resolution - higher indexed port has priority
    logic [NUM_REGISTERS-1:0] write_enable_decoded [NUM_WRITE_PORTS-1:0];
    logic [NUM_REGISTERS-1:0] final_write_enable;
    logic [NUM_REGISTERS-1:0][DATA_WIDTH-1:0] write_data_selected;
    
    //==========================================================================
    // WRITE PORT DECODING AND CONFLICT RESOLUTION
    //==========================================================================
    
    // Decode write enables for each port
    generate
        for (genvar port = 0; port < NUM_WRITE_PORTS; port++) begin : gen_write_decode
            for (genvar reg_idx = 0; reg_idx < NUM_REGISTERS; reg_idx++) begin : gen_reg_decode
                assign write_enable_decoded[port][reg_idx] = 
                    write_enable[port] && (write_addr[port] == reg_idx) && (reg_idx != 0);
            end
        end
    endgenerate
    
    // Resolve write conflicts - priority to higher indexed ports
    // Also select the data to write for each register
    generate
        for (genvar reg_idx = 0; reg_idx < NUM_REGISTERS; reg_idx++) begin : gen_write_resolve
            logic [NUM_WRITE_PORTS-1:0] port_wants_write;
            logic [$clog2(NUM_WRITE_PORTS):0] winning_port;
            
            // Check which ports want to write to this register
            for (genvar port = 0; port < NUM_WRITE_PORTS; port++) begin : gen_port_check
                assign port_wants_write[port] = write_enable_decoded[port][reg_idx];
            end
            
            // Priority encoder - highest port wins
            always_comb begin
                winning_port = 0;
                final_write_enable[reg_idx] = 1'b0;
                write_data_selected[reg_idx] = '0;
                
                for (int port = NUM_WRITE_PORTS-1; port >= 0; port--) begin
                    if (port_wants_write[port]) begin
                        winning_port = port;
                        final_write_enable[reg_idx] = 1'b1;
                        write_data_selected[reg_idx] = write_data[port];
                    end
                end
            end
        end
    endgenerate
    
    //==========================================================================
    // REGISTER FILE UPDATE
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset all registers to zero
            for (int i = 0; i < NUM_REGISTERS; i++) begin
                registers[i] <= #D '0;
            end
        end else begin
            // Update registers based on write enables
            for (int reg_idx = 1; reg_idx < NUM_REGISTERS; reg_idx++) begin // Skip x0
                if (final_write_enable[reg_idx]) begin
                    registers[reg_idx] <= #D write_data_selected[reg_idx];
                end
            end
            // x0 is always zero
            registers[0] <= #D '0;
        end
    end
    
    //==========================================================================
    // READ PORT IMPLEMENTATION
    //==========================================================================
    
    generate
        for (genvar port = 0; port < NUM_READ_PORTS; port++) begin : gen_read_ports
            
            // Check for write forwarding (same cycle read/write)
            logic forward_from_write;
            logic [DATA_WIDTH-1:0] forwarded_data;
            logic [NUM_WRITE_PORTS-1:0] write_match;
            
            // Check if any write port is writing to the same address
            for (genvar wp = 0; wp < NUM_WRITE_PORTS; wp++) begin : gen_forward_check
                assign write_match[wp] = write_enable[wp] && 
                                       (write_addr[wp] == read_addr[port]) && 
                                       (read_addr[port] != 0);
            end
            
            // Priority encoder for forwarding - highest write port wins
            always_comb begin
                forward_from_write = 1'b0;
                forwarded_data = '0;
                
                for (int wp = NUM_WRITE_PORTS-1; wp >= 0; wp--) begin
                    if (write_match[wp]) begin
                        forward_from_write = 1'b1;
                        forwarded_data = write_data[wp];
                    end
                end
            end
            
            // Output read data with forwarding
            always_comb begin
                if (read_addr[port] == 0) begin
                    // x0 always reads as zero
                    read_data[port] = '0;
                end else if (forward_from_write) begin
                    // Forward from concurrent write
                    read_data[port] = forwarded_data;
                end else begin
                    // Normal read from register file
                    read_data[port] = registers[read_addr[port]];
                end
            end
        end
    endgenerate

endmodule
