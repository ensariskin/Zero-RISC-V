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
    parameter CACHE_ENTRIES = 16,
    parameter RAS_DEPTH = 8
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

    input  logic is_call_0,
    input  logic is_call_1,
    input  logic is_call_2,
    input  logic is_call_3,
    input  logic is_call_4,

    input  logic is_return_i_0,
    input  logic is_return_i_1,
    input  logic is_return_i_2,
    input  logic is_return_i_3,
    input  logic is_return_i_4,

    input  logic [ADDR_WIDTH-1:0] call_return_addr_0,
    input  logic [ADDR_WIDTH-1:0] call_return_addr_1,
    input  logic [ADDR_WIDTH-1:0] call_return_addr_2,
    input  logic [ADDR_WIDTH-1:0] call_return_addr_3,
    input  logic [ADDR_WIDTH-1:0] call_return_addr_4,

    input  logic ras_restore_en_i,
    input  logic [$clog2(RAS_DEPTH)-1:0] ras_restore_tos_i,
    output logic [$clog2(RAS_DEPTH)-1:0] ras_tos_checkpoint_o,

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

    localparam CACHE_INDEX_BITS = $clog2(CACHE_ENTRIES);
    localparam CACHE_TAG_WIDTH = 10;
    localparam RAS_PTR_WIDTH = $clog2(RAS_DEPTH);
    localparam D = 1; // Delay for simulation

    // RAS
    logic [ADDR_WIDTH-1:0] ras_stack [RAS_DEPTH-1:0];
    logic [RAS_PTR_WIDTH-1:0] ras_tos; // Top of stack

    assign ras_tos_checkpoint_o = ras_tos;

    // Target cache
    logic [CACHE_ENTRIES-1:0] cache_valid;
    logic [CACHE_TAG_WIDTH-1:0] cache_tag [CACHE_ENTRIES-1:0];
    logic [ADDR_WIDTH-1:0] cache_target [CACHE_ENTRIES-1:0];

    logic [CACHE_INDEX_BITS-1:0] cache_idx_0, cache_idx_1, cache_idx_2, cache_idx_3, cache_idx_4;
    logic [CACHE_TAG_WIDTH-1:0] cache_tag_0, cache_tag_1, cache_tag_2, cache_tag_3, cache_tag_4;

    assign cache_idx_0 = current_pc_0[CACHE_INDEX_BITS+1:2];
    assign cache_idx_1 = current_pc_1[CACHE_INDEX_BITS+1:2];
    assign cache_idx_2 = current_pc_2[CACHE_INDEX_BITS+1:2];
    assign cache_idx_3 = current_pc_3[CACHE_INDEX_BITS+1:2];
    assign cache_idx_4 = current_pc_4[CACHE_INDEX_BITS+1:2];

    assign cache_tag_0 = current_pc_0[CACHE_INDEX_BITS+CACHE_TAG_WIDTH+1:2+CACHE_INDEX_BITS];
    assign cache_tag_1 = current_pc_1[CACHE_INDEX_BITS+CACHE_TAG_WIDTH+1:2+CACHE_INDEX_BITS];
    assign cache_tag_2 = current_pc_2[CACHE_INDEX_BITS+CACHE_TAG_WIDTH+1:2+CACHE_INDEX_BITS];
    assign cache_tag_3 = current_pc_3[CACHE_INDEX_BITS+CACHE_TAG_WIDTH+1:2+CACHE_INDEX_BITS];
    assign cache_tag_4 = current_pc_4[CACHE_INDEX_BITS+CACHE_TAG_WIDTH+1:2+CACHE_INDEX_BITS];

    logic cache_hit_0, cache_hit_1, cache_hit_2, cache_hit_3, cache_hit_4;
    assign cache_hit_0 = cache_valid[cache_idx_0] && (cache_tag[cache_idx_0] == cache_tag_0);
    assign cache_hit_1 = cache_valid[cache_idx_1] && (cache_tag[cache_idx_1] == cache_tag_1);
    assign cache_hit_2 = cache_valid[cache_idx_2] && (cache_tag[cache_idx_2] == cache_tag_2);
    assign cache_hit_3 = cache_valid[cache_idx_3] && (cache_tag[cache_idx_3] == cache_tag_3);
    assign cache_hit_4 = cache_valid[cache_idx_4] && (cache_tag[cache_idx_4] == cache_tag_4);

    // RAS PREDICTION LOGIC
    logic ras_valid;
    logic [ADDR_WIDTH-1:0] ras_top_value;
    logic disable_ras;

    assign disable_ras = 1'b0; // Placeholder for future RAS disable logic

    assign ras_valid = (ras_tos != '0);
    assign ras_top_value = ras_valid ? ras_stack[ras_tos-1] : '0;

    // Prediction output 
    always_comb begin
        jalr_prediction_valid_o = 1'b0;
        jalr_prediction_target_o = '0;

        // Priority encoding for JALR predictions
        if (is_jalr_i_0) begin
            if(is_return_i_0 && ras_valid) begin
                jalr_prediction_valid_o = 1'b1;
                jalr_prediction_target_o = ras_top_value;
            end else begin
                jalr_prediction_valid_o = cache_hit_0;
                jalr_prediction_target_o = cache_target[cache_idx_0];
            end 
        end else if (is_jalr_i_1) begin
            if(is_return_i_1 && ras_valid) begin
                jalr_prediction_valid_o = 1'b1;
                jalr_prediction_target_o = ras_top_value;
            end else begin
                jalr_prediction_valid_o = cache_hit_1;
                jalr_prediction_target_o = cache_target[cache_idx_1];
            end 
        end else if (is_jalr_i_2) begin
            if(is_return_i_2 && ras_valid) begin
                jalr_prediction_valid_o = 1'b1;
                jalr_prediction_target_o = ras_top_value;
            end else begin
                jalr_prediction_valid_o = cache_hit_2;
                jalr_prediction_target_o = cache_target[cache_idx_2];
            end 
        end else if (is_jalr_i_3) begin
            if(is_return_i_3 && ras_valid) begin
                jalr_prediction_valid_o = 1'b1;
                jalr_prediction_target_o = ras_top_value;
            end else begin
                jalr_prediction_valid_o = cache_hit_3;
                jalr_prediction_target_o = cache_target[cache_idx_3];
            end 
        end else if (is_jalr_i_4) begin
            if(is_return_i_4 && ras_valid) begin
                jalr_prediction_valid_o = 1'b1;
                jalr_prediction_target_o = ras_top_value;
            end else begin
                jalr_prediction_valid_o = cache_hit_4;
                jalr_prediction_target_o = cache_target[cache_idx_4];
            end 
        end
    end


    // RAS Speculative Update
    logic do_push, do_pop;
    logic [ADDR_WIDTH-1:0] push_addr;

    always_comb begin
        do_push = 1'b0;
        do_pop = 1'b0;
        push_addr = '0;
        
        // Check each instruction for call/return
        if (is_call_0) begin
            do_push = 1'b1;
            push_addr = call_return_addr_0;
        end else if (is_call_1) begin
            do_push = 1'b1;
            push_addr = call_return_addr_1;
        end else if (is_call_2) begin
            do_push = 1'b1;
            push_addr = call_return_addr_2;
        end else if (is_call_3) begin
            do_push = 1'b1;
            push_addr = call_return_addr_3;
        end else if (is_call_4) begin
            do_push = 1'b1;
            push_addr = call_return_addr_4;
        end else if (is_return_i_0 || is_return_i_1 || is_return_i_2 || is_return_i_3 || is_return_i_4) begin
            do_pop = 1'b1;
        end
    end
    
    // RAS Stack Update
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            ras_tos <= #D '0;
            for (int i = 0; i < RAS_DEPTH; i++) begin
                ras_stack[i] <= #D '0;
            end
        end else begin
            if (ras_restore_en_i) begin
                ras_tos <= #D ras_restore_tos_i;
            end else begin
                if (do_push) begin
                    ras_stack[ras_tos] <= #D push_addr;
                    ras_tos <= #D ras_tos + 1;
                end else if (do_pop && ras_valid) begin
                    ras_tos <= #D ras_tos - 1;
                end
            end
        end
    end

    // Prediction Cache Update
    logic [CACHE_INDEX_BITS-1:0] update_idx_0, update_idx_1, update_idx_2;
    logic [CACHE_TAG_WIDTH-1:0] update_tag_0, update_tag_1, update_tag_2;
    logic jalr_misprediction_0, jalr_misprediction_1, jalr_misprediction_2;

    assign update_idx_0 = (update_prediction_pc_0 - 4) >> 2;
    assign update_idx_1 = (update_prediction_pc_1 - 4) >> 2;
    assign update_idx_2 = (update_prediction_pc_2 - 4) >> 2;

    assign update_tag_0 = (update_prediction_pc_0 - 4) >> (2 + CACHE_INDEX_BITS);
    assign update_tag_1 = (update_prediction_pc_1 - 4) >> (2 + CACHE_INDEX_BITS);
    assign update_tag_2 = (update_prediction_pc_2 - 4) >> (2 + CACHE_INDEX_BITS);
    
    assign jalr_misprediction_0 = misprediction_0 && update_prediction_valid_i_0;
    assign jalr_misprediction_1 = misprediction_1 && update_prediction_valid_i_1;
    assign jalr_misprediction_2 = misprediction_2 && update_prediction_valid_i_2;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            cache_valid <= #D '0;
            for (int i = 0; i < CACHE_ENTRIES; i++) begin
                cache_tag[i] <= #D '0;
                cache_target[i] <= #D '0;
            end
        end else begin
            // Update port 2
            if (jalr_misprediction_2) begin
                cache_valid[update_idx_2] <= #D 1'b1;
                cache_tag[update_idx_2] <= #D update_tag_2;
                cache_target[update_idx_2] <= #D correct_pc_2;
            end

            // Update port 1
            if (jalr_misprediction_1) begin
                cache_valid[update_idx_1] <= #D 1'b1;
                cache_tag[update_idx_1] <= #D update_tag_1;
                cache_target[update_idx_1] <= #D correct_pc_1;
            end

            // Update port 0
            if (jalr_misprediction_0) begin
                cache_valid[update_idx_0] <= #D 1'b1;
                cache_tag[update_idx_0] <= #D update_tag_0;
                cache_target[update_idx_0] <= #D correct_pc_0;
            end
        end
    end

endmodule
