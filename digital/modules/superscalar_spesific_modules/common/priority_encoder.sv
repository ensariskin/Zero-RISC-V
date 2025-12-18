`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: priority_encoder
//
// Description:
//     Parametric priority encoder that finds the first (lowest index) set bit
//     in the input vector.
//
// Parameters:
//     WIDTH - Number of input bits (default 32)
//
// Ports:
//     in_vector  - Input bit vector to search
//     first_idx  - Index of first set bit (lowest index with '1')
//     valid      - Indicates at least one bit is set
//
// Example:
//     WIDTH=8, in_vector=8'b00101000
//     first_idx=3, valid=1 (bit 3 is first set bit from LSB)
//
//////////////////////////////////////////////////////////////////////////////////

module priority_encoder #(
    parameter int WIDTH = 32,
    parameter int IDX_WIDTH = $clog2(WIDTH)
)(
    input  logic [WIDTH-1:0]     in_vector,
    output logic [IDX_WIDTH-1:0] first_idx,
    output logic                 valid
);

    // Hierarchical priority encoder for better timing
    // Split into 4-bit chunks and use two-level encoding
    
    localparam int NUM_CHUNKS = (WIDTH + 3) / 4;  // Ceiling division
    
    logic [NUM_CHUNKS-1:0] chunk_valid;
    logic [1:0] chunk_idx [NUM_CHUNKS-1:0];
    
    // First level: 4-bit priority encoders for each chunk
    genvar i;
    generate
        for (i = 0; i < NUM_CHUNKS; i++) begin : gen_chunks
            localparam int BASE = i * 4;
            localparam int CHUNK_END = (BASE + 3 < WIDTH) ? BASE + 3 : WIDTH - 1;
            
            // Extract chunk (pad with zeros if partial)
            wire [3:0] chunk;
            if (BASE + 3 < WIDTH) begin
                assign chunk = in_vector[BASE+3:BASE];
            end else begin
                // Partial chunk at end
                assign chunk = {{(BASE + 4 - WIDTH){1'b0}}, in_vector[WIDTH-1:BASE]};
            end
            
            // 4-bit priority encoder
            always_comb begin
                casez (chunk)
                    4'b???1: begin chunk_idx[i] = 2'd0; chunk_valid[i] = 1'b1; end
                    4'b??10: begin chunk_idx[i] = 2'd1; chunk_valid[i] = 1'b1; end
                    4'b?100: begin chunk_idx[i] = 2'd2; chunk_valid[i] = 1'b1; end
                    4'b1000: begin chunk_idx[i] = 2'd3; chunk_valid[i] = 1'b1; end
                    default: begin chunk_idx[i] = 2'd0; chunk_valid[i] = 1'b0; end
                endcase
            end
        end
    endgenerate
    
    // Second level: Find first valid chunk
    logic [$clog2(NUM_CHUNKS)-1:0] first_chunk;
    logic chunk_found;
    
    always_comb begin
        first_chunk = '0;
        chunk_found = 1'b0;
        
        for (int j = 0; j < NUM_CHUNKS; j++) begin
            if (chunk_valid[j] && !chunk_found) begin
                first_chunk = j[$clog2(NUM_CHUNKS)-1:0];
                chunk_found = 1'b1;
            end
        end
    end
    
    // Combine chunk index and bit-within-chunk index
    assign valid = chunk_found;
    assign first_idx = {first_chunk, chunk_idx[first_chunk]};

endmodule
