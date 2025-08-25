`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2025
// Design Name: Simple Branch Predictor
// Module Name: branch_predictor_simple
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Simple 2-bit branch predictor with 32 entries
//              No tags, direct-mapped for simplicity
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Optimized for simplicity and small area
// 
//////////////////////////////////////////////////////////////////////////////////

module branch_predictor #(
    parameter ENTRIES = 32,                         // Number of predictor entries
    parameter INDEX_WIDTH = $clog2(ENTRIES),       // Auto-calculated index width
    parameter ADDR_WIDTH = 32
)(
    input  logic clk,
    input  logic reset,
    
    // Prediction interface (from fetch stage)
    input  logic [ADDR_WIDTH-1:0] current_pc,
    input  logic is_branch_i,                       // Current instruction is branch/jump
    
    // Prediction outputs
    output logic branch_taken_o,                    // Branch predicted taken
    
    // Update interface (from execute/writeback stage)
    input  logic [ADDR_WIDTH-1:0] update_prediction_pc,
    input  logic update_prediction_valid_i,
    input  logic misprediction                 // Is branch/jump instruction
);

    // 2-bit saturating counter states
    localparam [1:0] STRONG_NOT_TAKEN = 2'b00;
    localparam [1:0] WEAK_NOT_TAKEN   = 2'b01;
    localparam [1:0] WEAK_TAKEN       = 2'b10;
    localparam [1:0] STRONG_TAKEN     = 2'b11;
    
    // Predictor entry structure (simplified - direction only)
    typedef struct packed {
        logic [1:0] counter;                       // 2-bit saturating counter
    } predictor_entry_t;
    
    // Predictor table
    predictor_entry_t predictor_table [ENTRIES-1:0];
    
    // Index calculation (simple PC-based)
    logic [INDEX_WIDTH-1:0] predict_index;
    logic [INDEX_WIDTH-1:0] update_index;
    
    assign predict_index = current_pc[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
    assign update_index = update_prediction_pc[INDEX_WIDTH+1:2];
    
    // Prediction logic
    always_comb begin
        if (is_branch_i) begin
            // Prediction based on counter MSB
            branch_taken_o = predictor_table[predict_index].counter[1];  // MSB = taken/not taken
        end else begin
            // No prediction for non-branch instructions
             branch_taken_o = 0;
        end
    end
    
    // Update logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Initialize all entries
            for (int i = 0; i < ENTRIES; i++) begin
                predictor_table[i].counter <= WEAK_NOT_TAKEN;  // Start with weak not taken
            end
        end else if (update_prediction_valid_i) begin
            // Update 2-bit saturating counter
            case (predictor_table[update_index].counter)
                STRONG_NOT_TAKEN: begin
                    if (misprediction)
                        predictor_table[update_index].counter <= WEAK_NOT_TAKEN;
                end
                WEAK_NOT_TAKEN: begin
                    if (misprediction)
                        predictor_table[update_index].counter <= WEAK_TAKEN;
                    else
                        predictor_table[update_index].counter <= STRONG_NOT_TAKEN;
                end
                WEAK_TAKEN: begin
                    if (misprediction)
                        predictor_table[update_index].counter <= WEAK_NOT_TAKEN;
                    else
                        predictor_table[update_index].counter <= STRONG_TAKEN;
                end
                STRONG_TAKEN: begin
                    if (misprediction)
                        predictor_table[update_index].counter <= WEAK_TAKEN;
                end
            endcase
        end
    end


endmodule
