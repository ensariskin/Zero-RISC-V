`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Module: jalr_predictor
//
// Description:
//     JALR (Jump and Link Register) target predictor
//     Stores previously seen JALR target addresses indexed by PC
//     Updates on misprediction when update_prediction_valid is 0 (indicating JALR)
//     
// Parameters:
//     ADDR_WIDTH - Address width (default 32 bits)
//     ENTRIES    - Number of prediction entries (default 16)
//
// Operation:
//     - Lookup: Uses current PC to predict JALR target
//     - Update: On JALR misprediction, stores correct target address
//     - Index: Uses lower bits of PC for table indexing
//     - Priority: If multiple JALRs present, uses lowest index instruction
//////////////////////////////////////////////////////////////////////////////////

module jalr_predictor #(
    parameter ADDR_WIDTH = 32,
    parameter ENTRIES = 16
) (
    input  logic clk,
    input  logic reset,

    // Lookup interface - 5 instruction streams
    input  logic [ADDR_WIDTH-1:0] current_pc_0,
    input  logic [ADDR_WIDTH-1:0] current_pc_1,
    input  logic [ADDR_WIDTH-1:0] current_pc_2,
    input  logic [ADDR_WIDTH-1:0] current_pc_3,
    input  logic [ADDR_WIDTH-1:0] current_pc_4,

    input  logic is_jalr_i_0,
    input  logic is_jalr_i_1,
    input  logic is_jalr_i_2,
    input  logic is_jalr_i_3,
    input  logic is_jalr_i_4,

    // Prediction output - single prediction for earliest JALR
    output logic jalr_prediction_valid_o,
    output logic [ADDR_WIDTH-1:0] jalr_prediction_target_o,

    // Update interface - 3 update ports
    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_0,
    input  logic update_prediction_valid_i_0,
    input  logic misprediction_0,
    input  logic [ADDR_WIDTH-1:0] correct_pc_0,

    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_1,
    input  logic update_prediction_valid_i_1,
    input  logic misprediction_1,
    input  logic [ADDR_WIDTH-1:0] correct_pc_1,

    input  logic [ADDR_WIDTH-1:0] update_prediction_pc_2,
    input  logic update_prediction_valid_i_2,
    input  logic misprediction_2,
    input  logic [ADDR_WIDTH-1:0] correct_pc_2
);

    localparam INDEX_BITS = $clog2(ENTRIES);
    localparam D = 1; // Delay for simulation

    // JALR prediction table
    // Each entry stores: valid bit + target address
    logic [ENTRIES-1:0] valid;
    logic [ADDR_WIDTH-1:0] target_table [ENTRIES-1:0];

    // Index calculation helpers
    logic [INDEX_BITS-1:0] lookup_idx_0, lookup_idx_1, lookup_idx_2, lookup_idx_3, lookup_idx_4;
    logic [INDEX_BITS-1:0] update_idx_0, update_idx_1, update_idx_2;

    // Lookup results
    logic [ADDR_WIDTH-1:0] prediction_target_0, prediction_target_1, prediction_target_2, prediction_target_3, prediction_target_4;

    // Update detection
    logic jalr_misprediction_0, jalr_misprediction_1, jalr_misprediction_2;

    //==========================================================================
    // INDEX CALCULATION
    //==========================================================================
    // Use lower bits of PC for indexing (PC[INDEX_BITS+1:2] to skip byte offset)
    assign lookup_idx_0 = current_pc_0[INDEX_BITS+1:2];
    assign lookup_idx_1 = current_pc_1[INDEX_BITS+1:2];
    assign lookup_idx_2 = current_pc_2[INDEX_BITS+1:2];
    assign lookup_idx_3 = current_pc_3[INDEX_BITS+1:2];
    assign lookup_idx_4 = current_pc_4[INDEX_BITS+1:2];

    // Update index uses (update_pc - 4) to get the JALR instruction PC
    assign update_idx_0 = (update_prediction_pc_0 - 4) >> 2;
    assign update_idx_1 = (update_prediction_pc_1 - 4) >> 2;
    assign update_idx_2 = (update_prediction_pc_2 - 4) >> 2;

    //==========================================================================
    // JALR MISPREDICTION DETECTION
    //==========================================================================
    // JALR misprediction: misprediction=1 AND update_prediction_valid=0
    // (update_prediction_valid=1 means branch, =0 means JALR)
    assign jalr_misprediction_0 = misprediction_0 && !update_prediction_valid_i_0;
    assign jalr_misprediction_1 = misprediction_1 && !update_prediction_valid_i_1;
    assign jalr_misprediction_2 = misprediction_2 && !update_prediction_valid_i_2;

    //==========================================================================
    // PREDICTION TABLE LOOKUP
    //==========================================================================
    always_comb begin
        // Instruction 0 lookup
        prediction_target_0 = target_table[lookup_idx_0];

        // Instruction 1 lookup
        prediction_target_1 = target_table[lookup_idx_1];

        // Instruction 2 lookup
        prediction_target_2 = target_table[lookup_idx_2];

        // Instruction 3 lookup
        prediction_target_3 = target_table[lookup_idx_3];

        // Instruction 4 lookup
        prediction_target_4 = target_table[lookup_idx_4];
    end

    //==========================================================================
    // PREDICTION OUTPUT PRIORITY ENCODING
    //==========================================================================
    // If multiple JALRs present, use the earliest one (lowest index)
    always_comb begin
        jalr_prediction_valid_o = 1'b0;
        jalr_prediction_target_o = '0;

        if (is_jalr_i_0) begin
            jalr_prediction_valid_o = valid[lookup_idx_0];
            jalr_prediction_target_o = prediction_target_0;
        end else if (is_jalr_i_1) begin
            jalr_prediction_valid_o = valid[lookup_idx_1];;
            jalr_prediction_target_o = prediction_target_1;
        end else if (is_jalr_i_2) begin
            jalr_prediction_valid_o = valid[lookup_idx_2];
            jalr_prediction_target_o = prediction_target_2;
        end else if (is_jalr_i_3) begin
            jalr_prediction_valid_o = valid[lookup_idx_3];
            jalr_prediction_target_o = prediction_target_3;
        end else if (is_jalr_i_4) begin
            jalr_prediction_valid_o = valid[lookup_idx_4];
            jalr_prediction_target_o = prediction_target_4;
        end
    end

    //==========================================================================
    // PREDICTION TABLE UPDATE
    //==========================================================================
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            valid <= #D '0;
            for (int i = 0; i < ENTRIES; i++) begin
                target_table[i] <= #D '0;
            end
        end else begin
            // Update port 0
            if (jalr_misprediction_0) begin
                valid[update_idx_0] <= #D 1'b1;
                target_table[update_idx_0] <= #D correct_pc_0;
            end

            // Update port 1
            if (jalr_misprediction_1) begin
                valid[update_idx_1] <= #D 1'b1;
                target_table[update_idx_1] <= #D correct_pc_1;
            end

            // Update port 2
            if (jalr_misprediction_2) begin
                valid[update_idx_2] <= #D 1'b1;
                target_table[update_idx_2] <= #D correct_pc_2;
            end
        end
    end

endmodule
