`timescale 1ns/1ns

module ras_monitor #(
    parameter ADDR_WIDTH = 32,
    parameter RAS_DEPTH = 8
)(
    input logic clk,
    input logic reset,

    // Inputs from jalr_predictor
    input logic is_call_0, is_call_1, is_call_2, is_call_3, is_call_4,
    input logic is_return_0, is_return_1, is_return_2, is_return_3, is_return_4,
    
    input logic [ADDR_WIDTH-1:0] current_pc_0, current_pc_1, current_pc_2, current_pc_3, current_pc_4,
    input logic [ADDR_WIDTH-1:0] call_return_addr_0, call_return_addr_1, call_return_addr_2, call_return_addr_3, call_return_addr_4,

    input logic jalr_prediction_valid_o,
    input logic [ADDR_WIDTH-1:0] jalr_prediction_target_o,

    input logic update_prediction_valid_i_0, update_prediction_valid_i_1, update_prediction_valid_i_2,
    input logic misprediction_0, misprediction_1, misprediction_2,
    input logic [ADDR_WIDTH-1:0] correct_pc_0, correct_pc_1, correct_pc_2,
    
    // Restore Interface
    input logic ras_restore_en_i,
    input logic [2:0] ras_restore_tos_i,
    input logic [2:0] ras_tos_checkpoint_o,

    // Internal state of jalr_predictor
    input logic [ADDR_WIDTH-1:0] ras_stack [RAS_DEPTH-1:0],
    input logic [2:0] ras_tos
);

    integer f;

    initial begin
        f = $fopen("ras_monitor.log", "w");
        if (f) $display("RAS Monitor: Log file opened successfully.");
        else $display("RAS Monitor: Failed to open log file.");
    end

    final begin
        $fclose(f);
    end

    always @(posedge clk) begin
        if (reset) begin // Assuming active-low reset based on dv_top connection (rst_n -> reset)
            
            // Monitor Restore
            if (ras_restore_en_i) begin
                $fwrite(f, "[%0t] [RAS] RESTORE TRIGGERED: Restoring TOS to %d (Current TOS was %d)\n", $time, ras_restore_tos_i, ras_tos);
            end

            // Monitor PUSH
            if (is_call_0) begin
                $fwrite(f, "[%0t] [RAS] PUSH (Slot 0): PC=%h, RetAddr=%h, NewTOS=%d, Checkpoint=%d\n", $time, current_pc_0, call_return_addr_0, ras_tos, ras_tos_checkpoint_o);
                print_stack();
            end
            if (is_call_1) begin
                $fwrite(f, "[%0t] [RAS] PUSH (Slot 1): PC=%h, RetAddr=%h, NewTOS=%d, Checkpoint=%d\n", $time, current_pc_1, call_return_addr_1, ras_tos, ras_tos_checkpoint_o);
                print_stack();
            end
            if (is_call_2) begin
                $fwrite(f, "[%0t] [RAS] PUSH (Slot 2): PC=%h, RetAddr=%h, NewTOS=%d, Checkpoint=%d\n", $time, current_pc_2, call_return_addr_2, ras_tos, ras_tos_checkpoint_o);
                print_stack();
            end
            if (is_call_3) begin
                $fwrite(f, "[%0t] [RAS] PUSH (Slot 3): PC=%h, RetAddr=%h, NewTOS=%d, Checkpoint=%d\n", $time, current_pc_3, call_return_addr_3, ras_tos, ras_tos_checkpoint_o);
                print_stack();
            end
            if (is_call_4) begin
                $fwrite(f, "[%0t] [RAS] PUSH (Slot 4): PC=%h, RetAddr=%h, NewTOS=%d, Checkpoint=%d\n", $time, current_pc_4, call_return_addr_4, ras_tos, ras_tos_checkpoint_o);
                print_stack();
            end
            
            // Monitor POP
            if (is_return_0) begin
                $fwrite(f, "[%0t] [RAS] POP (Slot 0): PC=%h, Predicted=%h, NewTOS=%d\n", $time, current_pc_0, jalr_prediction_target_o, ras_tos);
                print_stack();
            end
            if (is_return_1) begin
                $fwrite(f, "[%0t] [RAS] POP (Slot 1): PC=%h, Predicted=%h, NewTOS=%d\n", $time, current_pc_1, jalr_prediction_target_o, ras_tos);
                print_stack();
            end
            if (is_return_2) begin
                $fwrite(f, "[%0t] [RAS] POP (Slot 2): PC=%h, Predicted=%h, NewTOS=%d\n", $time, current_pc_2, jalr_prediction_target_o, ras_tos);
                print_stack();
            end
            if (is_return_3) begin
                $fwrite(f, "[%0t] [RAS] POP (Slot 3): PC=%h, Predicted=%h, NewTOS=%d\n", $time, current_pc_3, jalr_prediction_target_o, ras_tos);
                print_stack();
            end
            if (is_return_4) begin
                $fwrite(f, "[%0t] [RAS] POP (Slot 4): PC=%h, Predicted=%h, NewTOS=%d\n", $time, current_pc_4, jalr_prediction_target_o, ras_tos);
                print_stack();
            end
            
            // Monitor Prediction
            if (jalr_prediction_valid_o) begin
                $fwrite(f, "[%0t] [RAS] PREDICTION: Target=%h\n", $time, jalr_prediction_target_o);
            end
            
            // Monitor Misprediction / Correction
            if (update_prediction_valid_i_0 && misprediction_0) 
                $fwrite(f, "[%0t] [RAS] MISPREDICT (Slot 0): Correct=%h\n", $time, correct_pc_0);
            if (update_prediction_valid_i_1 && misprediction_1) 
                $fwrite(f, "[%0t] [RAS] MISPREDICT (Slot 1): Correct=%h\n", $time, correct_pc_1);
            if (update_prediction_valid_i_2 && misprediction_2) 
                $fwrite(f, "[%0t] [RAS] MISPREDICT (Slot 2): Correct=%h\n", $time, correct_pc_2);
        end
    end

    task print_stack;
        integer i;
        begin
            $fwrite(f, "    Stack: ");
            for (i=0; i<RAS_DEPTH; i=i+1) begin
                if (i == ras_tos) $fwrite(f, "[%0d]=%h(TOS) ", i, ras_stack[i]);
                else $fwrite(f, "[%0d]=%h ", i, ras_stack[i]);
            end
            $fwrite(f, "\n");
        end
    endtask

endmodule
