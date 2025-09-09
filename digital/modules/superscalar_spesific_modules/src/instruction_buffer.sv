`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2025
// Design Name: Instruction Buffer for Superscalar Processor
// Module Name: instruction_buffer
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Variable-width instruction buffer that decouples fetch and decode
//              stages. Handles 3 instructions input, variable output (1-3),
//              and provides backpressure control.
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// - Circular buffer with configurable depth
// - Supports flush operations for branch mispredictions
// - Ready/valid handshaking protocol
// - Occupancy tracking for performance monitoring
//////////////////////////////////////////////////////////////////////////////////

module instruction_buffer #(
    parameter BUFFER_DEPTH = 8,    // Number of instruction entries (must be power of 2)
    parameter ADDR_WIDTH = $clog2(BUFFER_DEPTH),
    parameter DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic reset,
    
    // Input from multi_fetch (up to 3 instructions per cycle)
    input  logic [2:0] fetch_valid_i,           // Which of the 3 fetch slots are valid
    input  logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2,
    input  logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2,
    input  logic [DATA_WIDTH-1:0] imm_i_0, imm_i_1, imm_i_2,
    input  logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2,
    
    // Output to decode stages (up to 3 instructions per cycle)
    output logic [2:0] decode_valid_o,          // How many instructions are available for decode
    output logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2,
    output logic [DATA_WIDTH-1:0] pc_o_0, pc_o_1, pc_o_2,
    output logic [DATA_WIDTH-1:0] imm_o_0, imm_o_1, imm_o_2,
    output logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2,
    
    // Control signals
    input  logic [2:0] decode_ready_i,          // Which decode stages are ready to accept instructions
    output logic fetch_ready_o,                // Can accept more instructions from fetch
    input  logic flush_i,                      // Flush all buffered instructions
    
    // Status outputs
    output logic buffer_empty_o,
    output logic buffer_full_o,
    output logic [ADDR_WIDTH:0] occupancy_o    // Number of valid entries in buffer
);

    // Buffer entry structure
    typedef struct packed {
        logic valid;
        logic [DATA_WIDTH-1:0] instruction;
        logic [DATA_WIDTH-1:0] pc;
        logic [DATA_WIDTH-1:0] imm;
        logic branch_prediction;
    } buffer_entry_t;
    
    localparam D = 1; // Delay for simulation purposes
    
    // Buffer storage
    buffer_entry_t buffer [BUFFER_DEPTH];
    
    // Pointers and counters
    logic [ADDR_WIDTH-1:0] write_ptr, next_write_ptr;
    logic [ADDR_WIDTH-1:0] read_ptr, next_read_ptr;
    logic [ADDR_WIDTH:0] count, next_count;
    
    // Internal signals
    logic [2:0] fetch_count;        // Number of valid instructions from fetch
    logic [2:0] decode_accept_count; // Number of instructions decode can accept
    logic [2:0] actual_write_count; // Actual number written to buffer
    logic [2:0] actual_read_count;  // Actual number read from buffer
    
    // Calculate number of valid fetch instructions
    assign fetch_count = fetch_valid_i[0] + fetch_valid_i[1] + fetch_valid_i[2];
    
    // Calculate how many decode stages are ready
    assign decode_accept_count = decode_ready_i[0] + decode_ready_i[1] + decode_ready_i[2];
    
    // Status signals
    assign buffer_empty_o = (count == 0);
    assign buffer_full_o = (count >= BUFFER_DEPTH - 1); // Leave space for 3 instructions
    assign occupancy_o = count;
    
    // Fetch ready when buffer has space for incoming instructions
    assign fetch_ready_o = !buffer_full_o && (count + fetch_count <= BUFFER_DEPTH);
    
    // Determine actual write count (limited by buffer space and fetch valid)
    always_comb begin
        if (flush_i || !fetch_ready_o) begin
            actual_write_count = 0;
        end else begin
            automatic logic [ADDR_WIDTH:0] available_space = BUFFER_DEPTH - count;
            if (fetch_count <= available_space) begin
                actual_write_count = fetch_count;
            end else begin
                actual_write_count = available_space[2:0];
            end
        end
    end
    
    // Determine actual read count (limited by buffer occupancy and decode readiness)
    always_comb begin
        if (buffer_empty_o) begin
            actual_read_count = 0;
        end else begin
            automatic logic [2:0] available_instructions = (count >= 3) ? 3 : count[2:0];
            if (decode_accept_count <= available_instructions) begin
                actual_read_count = decode_accept_count;
            end else begin
                actual_read_count = available_instructions;
            end
        end
    end
    
    // Output valid signals
    assign decode_valid_o[0] = (actual_read_count >= 1) && !buffer_empty_o;
    assign decode_valid_o[1] = (actual_read_count >= 2) && !buffer_empty_o;
    assign decode_valid_o[2] = (actual_read_count >= 3) && !buffer_empty_o;
    
    // Pointer updates
    always_comb begin
        next_write_ptr = write_ptr;
        if (actual_write_count > 0 && !flush_i) begin
            next_write_ptr = (write_ptr + actual_write_count) % BUFFER_DEPTH;
        end
    end
    
    always_comb begin
        next_read_ptr = read_ptr;
        if (actual_read_count > 0 && !flush_i) begin
            next_read_ptr = (read_ptr + actual_read_count) % BUFFER_DEPTH;
        end
    end
    
    // Count update
    always_comb begin
        if (flush_i) begin
            next_count = 0;
        end else begin
            next_count = count + actual_write_count - actual_read_count;
        end
    end
    
    // Sequential logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            write_ptr <= #D 0;
            read_ptr <= #D 0;
            count <= #D 0;
            
            // Clear all buffer entries
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                buffer[i].valid <= #D 1'b0;
                buffer[i].instruction <= #D 32'h0;
                buffer[i].pc <= #D 32'h0;
                buffer[i].imm <= #D 32'h0;
                buffer[i].branch_prediction <= #D 1'b0;
            end
        end else begin
            write_ptr <= #D next_write_ptr;
            read_ptr <= #D next_read_ptr;
            count <= #D next_count;
            
            // Handle flush
            if (flush_i) begin
                for (int i = 0; i < BUFFER_DEPTH; i++) begin
                    buffer[i].valid <= #D 1'b0;
                end
            end else begin
                // Write new instructions
                if (actual_write_count >= 1 && fetch_valid_i[0]) begin
                    buffer[write_ptr].valid <= #D 1'b1;
                    buffer[write_ptr].instruction <= #D instruction_i_0;
                    buffer[write_ptr].pc <= #D pc_i_0;
                    buffer[write_ptr].imm <= #D imm_i_0;
                    buffer[write_ptr].branch_prediction <= #D branch_prediction_i_0;
                end
                
                if (actual_write_count >= 2 && fetch_valid_i[1]) begin
                    buffer[(write_ptr + 1) % BUFFER_DEPTH].valid <= #D 1'b1;
                    buffer[(write_ptr + 1) % BUFFER_DEPTH].instruction <= #D instruction_i_1;
                    buffer[(write_ptr + 1) % BUFFER_DEPTH].pc <= #D pc_i_1;
                    buffer[(write_ptr + 1) % BUFFER_DEPTH].imm <= #D imm_i_1;
                    buffer[(write_ptr + 1) % BUFFER_DEPTH].branch_prediction <= #D branch_prediction_i_1;
                end
                
                if (actual_write_count >= 3 && fetch_valid_i[2]) begin
                    buffer[(write_ptr + 2) % BUFFER_DEPTH].valid <= #D 1'b1;
                    buffer[(write_ptr + 2) % BUFFER_DEPTH].instruction <= #D instruction_i_2;
                    buffer[(write_ptr + 2) % BUFFER_DEPTH].pc <= #D pc_i_2;
                    buffer[(write_ptr + 2) % BUFFER_DEPTH].imm <= #D imm_i_2;
                    buffer[(write_ptr + 2) % BUFFER_DEPTH].branch_prediction <= #D branch_prediction_i_2;
                end
                
                // Invalidate read entries
                if (actual_read_count >= 1) begin
                    buffer[read_ptr].valid <= #D 1'b0;
                end
                if (actual_read_count >= 2) begin
                    buffer[(read_ptr + 1) % BUFFER_DEPTH].valid <= #D 1'b0;
                end
                if (actual_read_count >= 3) begin
                    buffer[(read_ptr + 2) % BUFFER_DEPTH].valid <= #D 1'b0;
                end
            end
        end
    end
    
    // Output assignments
    always_comb begin
        // Default assignments
        instruction_o_0 = 32'h00000013; // NOP
        instruction_o_1 = 32'h00000013; // NOP
        instruction_o_2 = 32'h00000013; // NOP
        pc_o_0 = 32'h0;
        pc_o_1 = 32'h0;
        pc_o_2 = 32'h0;
        imm_o_0 = 32'h0;
        imm_o_1 = 32'h0;
        imm_o_2 = 32'h0;
        branch_prediction_o_0 = 1'b0;
        branch_prediction_o_1 = 1'b0;
        branch_prediction_o_2 = 1'b0;
        
        // Assign valid outputs
        if (decode_valid_o[0]) begin
            instruction_o_0 = buffer[read_ptr].instruction;
            pc_o_0 = buffer[read_ptr].pc;
            imm_o_0 = buffer[read_ptr].imm;
            branch_prediction_o_0 = buffer[read_ptr].branch_prediction;
        end
        
        if (decode_valid_o[1]) begin
            instruction_o_1 = buffer[(read_ptr + 1) % BUFFER_DEPTH].instruction;
            pc_o_1 = buffer[(read_ptr + 1) % BUFFER_DEPTH].pc;
            imm_o_1 = buffer[(read_ptr + 1) % BUFFER_DEPTH].imm;
            branch_prediction_o_1 = buffer[(read_ptr + 1) % BUFFER_DEPTH].branch_prediction;
        end
        
        if (decode_valid_o[2]) begin
            instruction_o_2 = buffer[(read_ptr + 2) % BUFFER_DEPTH].instruction;
            pc_o_2 = buffer[(read_ptr + 2) % BUFFER_DEPTH].pc;
            imm_o_2 = buffer[(read_ptr + 2) % BUFFER_DEPTH].imm;
            branch_prediction_o_2 = buffer[(read_ptr + 2) % BUFFER_DEPTH].branch_prediction;
        end
    end
    
    // Assertions for debugging
    `ifdef DEBUG
    always_ff @(posedge clk) begin
        if (reset) begin
            assert (count <= BUFFER_DEPTH) else $error("Buffer count exceeds depth");
            assert (actual_write_count <= 3) else $error("Write count exceeds 3");
            assert (actual_read_count <= 3) else $error("Read count exceeds 3");
        end
    end
    `endif

endmodule
