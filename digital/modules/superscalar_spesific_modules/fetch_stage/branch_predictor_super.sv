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

module branch_predictor_super #(
    parameter ENTRIES = 32,                         // Number of predictor entries
    parameter INDEX_WIDTH = $clog2(ENTRIES),       // Auto-calculated index width
    parameter ADDR_WIDTH = 32
)(
    input  logic clk,
    input  logic reset,
    
    // Prediction interface (from fetch stage)
    input  logic [ADDR_WIDTH-1:0] current_pc_0,
    input  logic is_branch_i_0,                       // Current instruction is branch/jump

    input  logic [ADDR_WIDTH-1:0] current_pc_1,
    input  logic is_branch_i_1,                       // Current instruction is branch/jump

    input  logic [ADDR_WIDTH-1:0] current_pc_2,
    input  logic is_branch_i_2,                       // Current instruction is branch/jump

    input  logic [ADDR_WIDTH-1:0] current_pc_3,
    input  logic is_branch_i_3,                       // Current instruction is branch/jump

    input  logic [ADDR_WIDTH-1:0] current_pc_4,
    input  logic is_branch_i_4,                       // Current instruction is branch/jump
    
    // Prediction outputs
    output logic branch_taken_o_0,                    // Branch predicted taken
    output logic branch_taken_o_1,                    // Branch predicted taken
    output logic branch_taken_o_2,                    // Branch predicted taken
    output logic branch_taken_o_3,                    // Branch predicted taken
    output logic branch_taken_o_4,                    // Branch predicted taken
    
    // Update interface (from execute/writeback stage)
    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_0,
    input  logic update_prediction_valid_i_0,
    input  logic misprediction_0,                 
    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_1,
    input  logic update_prediction_valid_i_1,
    input  logic misprediction_1,                
    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_2,
    input  logic update_prediction_valid_i_2,
    input  logic misprediction_2                
);

    // 2-bit saturating counter states
    localparam [1:0] STRONG_NOT_TAKEN = 2'b00;
    localparam [1:0] WEAK_NOT_TAKEN   = 2'b01;
    localparam [1:0] WEAK_TAKEN       = 2'b10;
    localparam [1:0] STRONG_TAKEN     = 2'b11;
    
    localparam D = 1; // Delay for simulation purposes
    
    // Predictor entry structure (simplified - direction only)
    typedef struct packed {
        logic [1:0] counter;                       // 2-bit saturating counter
    } predictor_entry_t;
    
    // Predictor table
    predictor_entry_t predictor_table [ENTRIES-1:0];
    
    // Index calculation (simple PC-based)
    logic [INDEX_WIDTH-1:0] predict_index_0, predict_index_1, predict_index_2, predict_index_3, predict_index_4;
    logic [INDEX_WIDTH-1:0] update_index_0, update_index_1, update_index_2;
    
    assign predict_index_0 = current_pc_0[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
    assign update_index_0 = update_prediction_pc_0[INDEX_WIDTH+1:2];

    assign predict_index_1 = current_pc_1[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
    assign update_index_1 = update_prediction_pc_1[INDEX_WIDTH+1:2];

    assign predict_index_2 = current_pc_2[INDEX_WIDTH+1:2];  // Skip lower 2 bits (byte aligned)
    assign update_index_2 = update_prediction_pc_2[INDEX_WIDTH+1:2];

    assign predict_index_3 = current_pc_3[INDEX_WIDTH+1:2];
    assign predict_index_4 = current_pc_4[INDEX_WIDTH+1:2];
    
    assign branch_taken_o_0 = is_branch_i_0 ? predictor_table[predict_index_0].counter[1] : 1'b0;  // MSB = taken/not taken
    assign branch_taken_o_1 = is_branch_i_1 ? predictor_table[predict_index_1].counter[1] : 1'b0;  // MSB = taken/not taken
    assign branch_taken_o_2 = is_branch_i_2 ? predictor_table[predict_index_2].counter[1] : 1'b0;  // MSB = taken/not
    assign branch_taken_o_3 = is_branch_i_3 ? predictor_table[predict_index_3].counter[1] : 1'b0;  // MSB = taken/not taken
    assign branch_taken_o_4 = is_branch_i_4 ? predictor_table[predict_index_4].counter[1] : 1'b0;  // MSB = taken/not
    
    // Update logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Initialize all entries
            for (int i = 0; i < ENTRIES; i++) begin
                predictor_table[i].counter <= #D WEAK_NOT_TAKEN;  // Start with weak not taken
            end
        end else begin
            if (update_prediction_valid_i_0) begin
                // Update 2-bit saturating counter
                case (predictor_table[update_index_0].counter)
                    STRONG_NOT_TAKEN: begin
                        if (misprediction_0)
                            predictor_table[update_index_0].counter <= #D WEAK_NOT_TAKEN;
                    end
                    WEAK_NOT_TAKEN: begin
                        if (misprediction_0)
                            predictor_table[update_index_0].counter <= #D WEAK_TAKEN;
                        else
                            predictor_table[update_index_0].counter <= #D STRONG_NOT_TAKEN;
                    end
                    WEAK_TAKEN: begin
                        if (misprediction_0)
                            predictor_table[update_index_0].counter <= #D WEAK_NOT_TAKEN;
                        else
                            predictor_table[update_index_0].counter <= #D STRONG_TAKEN;
                    end
                    STRONG_TAKEN: begin
                        if (misprediction_0)
                            predictor_table[update_index_0].counter <= #D WEAK_TAKEN;
                    end
                endcase
            end
            if (update_prediction_valid_i_1) begin
                // Update 2-bit saturating counter
                case (predictor_table[update_index_1].counter)
                    STRONG_NOT_TAKEN: begin
                        if (misprediction_1)
                            predictor_table[update_index_1].counter <= #D WEAK_NOT_TAKEN;
                    end
                    WEAK_NOT_TAKEN: begin
                        if (misprediction_1)
                            predictor_table[update_index_1].counter <= #D WEAK_TAKEN;
                        else
                            predictor_table[update_index_1].counter <= #D STRONG_NOT_TAKEN;
                    end
                    WEAK_TAKEN: begin
                        if (misprediction_1)
                            predictor_table[update_index_1].counter <= #D WEAK_NOT_TAKEN;
                        else
                            predictor_table[update_index_1].counter <= #D STRONG_TAKEN;
                    end
                    STRONG_TAKEN: begin
                        if (misprediction_1)
                            predictor_table[update_index_1].counter <= #D WEAK_TAKEN;
                    end
                endcase
            end
            if (update_prediction_valid_i_2) begin
                // Update 2-bit saturating counter
                case (predictor_table[update_index_2].counter)
                    STRONG_NOT_TAKEN: begin
                        if (misprediction_2)
                            predictor_table[update_index_2].counter <= #D WEAK_NOT_TAKEN;
                    end
                    WEAK_NOT_TAKEN: begin
                        if (misprediction_2)
                            predictor_table[update_index_2].counter <= #D WEAK_TAKEN;
                        else
                            predictor_table[update_index_2].counter <= #D STRONG_NOT_TAKEN;
                    end
                    WEAK_TAKEN: begin
                        if (misprediction_2)
                            predictor_table[update_index_2].counter <= #D WEAK_NOT_TAKEN;
                        else
                            predictor_table[update_index_2].counter <= #D STRONG_TAKEN;
                    end
                    STRONG_TAKEN: begin
                        if (misprediction_2)
                            predictor_table[update_index_2].counter <= #D WEAK_TAKEN;
                    end
                endcase
            end
        end
    end


endmodule
