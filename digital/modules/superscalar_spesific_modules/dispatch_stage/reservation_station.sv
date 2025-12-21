`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: reservation_station
//
// Description:
//     Reservation station implementation for Tomasulo-based superscalar processor.
//     Handles instruction dispatch, dependency resolution via CDB monitoring,
//     and instruction issue to functional units when operands are ready.
//
// Features:
//     - Single-entry reservation station (can be extended to multi-entry)
//     - Tag-based dependency tracking (2-bit tags: 00=ALU0, 01=ALU1, 10=ALU2, 11=ready)
//     - CDB monitoring for operand resolution
//     - Registered outputs to functional unit
//     - Combinational CDB outputs for speed
//
// Behavior:
//     - If all operands ready (tags = 11): Forward directly to execute stage
//     - If operands not ready: Monitor CDB for matching tags
//     - Issue valid only when both operands are available
//     - Store complete instruction context for execution
//////////////////////////////////////////////////////////////////////////////////

module reservation_station #(
        parameter DATA_WIDTH = 32,
        parameter PHYS_REG_ADDR_WIDTH = 6,
        parameter ALU_TAG = 3'b000  // This RS's ALU tag (00, 01, or 10)
    )(
        // Clock and Reset
        input logic clk,
        input logic reset,
        input logic secure_mode,  // TMR secure mode enable

        // Eager misprediction flush interface
        input logic        eager_misprediction_i,
        input logic [5:0]  mispredicted_distance_i,
        input logic [4:0]  rob_head_ptr_i,

        // Interface from Decode/Dispatch Stage
        decode_to_rs_if.reservation_station decode_if,


        // Interface to CDB (for monitoring other ALUs and broadcasting results)
        cdb_if cdb_if_port,

        // Interface to Functional Unit
        rs_to_exec_if.reservation_station exec_if,

        //======================================================================
        // TMR VALIDATOR INTERFACE (for internal register monitoring/validation)
        //======================================================================
        rs_internal_if.reservation_station internal_if
    );

    localparam D = 1; // Delay for simulation
    localparam TAG_READY = 3'b111; // Tag indicating operand is ready/valid

    //==========================================================================
    // RESERVATION STATION STORAGE REGISTERS
    //==========================================================================

    // Enable signal for RS operation
    logic enable;

    // Instruction storage (valid when occupied)
    logic occupied;
    logic [10:0] stored_control_signals;
    logic [DATA_WIDTH-1:0] stored_pc;
    logic [PHYS_REG_ADDR_WIDTH-1:0] stored_rd_phys_addr;
    logic [DATA_WIDTH-1:0] stored_pc_value_at_prediction;
    logic [2:0] stored_branch_sel;
    logic stored_branch_prediction;
    logic [DATA_WIDTH-1:0] stored_store_data;

    // Operand A storage and tracking
    logic [DATA_WIDTH-1:0] stored_operand_a_data;
    logic [2:0] stored_operand_a_tag;

    // Operand B storage and tracking
    logic [DATA_WIDTH-1:0] stored_operand_b_data;
    logic [2:0] stored_operand_b_tag;

    //==========================================================================
    // TMR OUTPUT ASSIGNMENTS (all internal regs → validator via interface)
    //==========================================================================
    assign internal_if.enable = enable;
    assign internal_if.occupied = occupied;
    assign internal_if.control_signals = stored_control_signals;
    assign internal_if.pc = stored_pc;
    assign internal_if.rd_phys_addr = stored_rd_phys_addr;
    assign internal_if.pc_value_at_prediction = stored_pc_value_at_prediction;
    assign internal_if.branch_sel = stored_branch_sel;
    assign internal_if.branch_prediction = stored_branch_prediction;
    assign internal_if.store_data = stored_store_data;
    assign internal_if.operand_a_data = stored_operand_a_data;
    assign internal_if.operand_a_tag = stored_operand_a_tag;
    assign internal_if.operand_b_data = stored_operand_b_data;
    assign internal_if.operand_b_tag = stored_operand_b_tag;

    //==========================================================================
    // EFFECTIVE VALUES (secure mode: validated from interface, normal: internal regs)
    //==========================================================================
    wire effective_enable = secure_mode ? internal_if.validated_enable : enable;
    wire effective_occupied = secure_mode ? internal_if.validated_occupied : occupied;
    wire [10:0] effective_control_signals = secure_mode ? internal_if.validated_control_signals : stored_control_signals;
    wire [DATA_WIDTH-1:0] effective_pc = secure_mode ? internal_if.validated_pc : stored_pc;
    wire [PHYS_REG_ADDR_WIDTH-1:0] effective_rd_phys_addr = secure_mode ? internal_if.validated_rd_phys_addr : stored_rd_phys_addr;
    wire [DATA_WIDTH-1:0] effective_pc_value_at_prediction = secure_mode ? internal_if.validated_pc_value_at_prediction : stored_pc_value_at_prediction;
    wire [2:0] effective_branch_sel = secure_mode ? internal_if.validated_branch_sel : stored_branch_sel;
    wire effective_branch_prediction = secure_mode ? internal_if.validated_branch_prediction : stored_branch_prediction;
    wire [DATA_WIDTH-1:0] effective_store_data = secure_mode ? internal_if.validated_store_data : stored_store_data;
    wire [DATA_WIDTH-1:0] effective_operand_a_data = secure_mode ? internal_if.validated_operand_a_data : stored_operand_a_data;
    wire [2:0] effective_operand_a_tag = secure_mode ? internal_if.validated_operand_a_tag : stored_operand_a_tag;
    wire [DATA_WIDTH-1:0] effective_operand_b_data = secure_mode ? internal_if.validated_operand_b_data : stored_operand_b_data;
    wire [2:0] effective_operand_b_tag = secure_mode ? internal_if.validated_operand_b_tag : stored_operand_b_tag;

    //==========================================================================
    // EAGER MISPREDICTION FLUSH LOGIC
    //==========================================================================

    // Calculate distance of stored instruction from ROB head
    wire [4:0] stored_rob_idx = effective_rd_phys_addr[4:0];
    logic [5:0] stored_rob_distance;
    logic should_flush_rs;

    always_comb begin
        // Calculate circular buffer distance
        if (stored_rob_idx >= rob_head_ptr_i) begin
            stored_rob_distance = stored_rob_idx - rob_head_ptr_i;
        end else begin
            stored_rob_distance = 32 - rob_head_ptr_i + stored_rob_idx;
        end

        // RS should be flushed if: occupied AND distance > mispredicted_distance
        should_flush_rs = occupied && eager_misprediction_i &&
            (stored_rob_distance > mispredicted_distance_i);
    end

    //==========================================================================
    // COMBINATIONAL LOGIC FOR OPERAND SELECTION
    //==========================================================================

    // Check if operands are valid (from decode or CDB)
    logic operand_a_valid_from_decode, operand_b_valid_from_decode;
    logic operand_a_valid_from_stored, operand_b_valid_from_stored;
    logic [DATA_WIDTH-1:0] final_operand_a_data, final_operand_b_data;
    logic should_issue;
    logic a_valid;
    logic b_valid;
    logic all_valid;

    assign a_valid = effective_occupied ? operand_a_valid_from_stored : operand_a_valid_from_decode;
    assign b_valid = effective_occupied ? operand_b_valid_from_stored : operand_b_valid_from_decode;
    assign all_valid = a_valid & b_valid;
    always_comb begin
        // Check if operands are valid from decode interface (only TAG_READY, no CDB monitoring)
        operand_a_valid_from_decode = (decode_if.operand_a_tag == TAG_READY);
        operand_b_valid_from_decode = (decode_if.operand_b_tag == TAG_READY);

        // Check if stored operands are valid (from storage or CDB monitoring)
        // In secure mode, use validated tags from TMR voter
        operand_a_valid_from_stored = effective_occupied ? (effective_operand_a_tag == TAG_READY) ||
            (cdb_if_port.cdb_valid_0 && effective_operand_a_tag == 3'b000) ||
            (cdb_if_port.cdb_valid_1 && effective_operand_a_tag == 3'b001) ||
            (cdb_if_port.cdb_valid_2 && effective_operand_a_tag == 3'b010) ||
            (cdb_if_port.cdb_valid_3_2 && effective_operand_a_tag == 3'b011 &&
                effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_2) ||
            (cdb_if_port.cdb_valid_3_1 && effective_operand_a_tag == 3'b011 &&
                effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_1) ||
            (cdb_if_port.cdb_valid_3_0 && effective_operand_a_tag == 3'b011 &&
                effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_0)  : 1'b0;

        operand_b_valid_from_stored = effective_occupied ? (effective_operand_b_tag == TAG_READY) ||
            (cdb_if_port.cdb_valid_0 && effective_operand_b_tag == 3'b000) ||
            (cdb_if_port.cdb_valid_1 && effective_operand_b_tag == 3'b001) ||
            (cdb_if_port.cdb_valid_2 && effective_operand_b_tag == 3'b010) ||
            (cdb_if_port.cdb_valid_3_2 && effective_operand_b_tag == 3'b011 &&
                effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_2) ||
            (cdb_if_port.cdb_valid_3_1 && effective_operand_b_tag == 3'b011 &&
                effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_1) ||
            (cdb_if_port.cdb_valid_3_0 && effective_operand_b_tag == 3'b011 &&
                effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_0)  : 1'b0;

        // Determine what data to use and when to issue
        if (effective_occupied && operand_a_valid_from_stored && operand_b_valid_from_stored) begin
            // Use stored data (both operands now ready)
            should_issue = 1'b1;

            // Select operand A data from stored/CDB
            if (effective_operand_a_tag == TAG_READY) begin
                final_operand_a_data = effective_operand_a_data;
            end else if (cdb_if_port.cdb_valid_0 && effective_operand_a_tag == 3'b000) begin
                final_operand_a_data = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && effective_operand_a_tag == 3'b001) begin
                final_operand_a_data = cdb_if_port.cdb_data_1;
            end else if (cdb_if_port.cdb_valid_2 && effective_operand_a_tag == 3'b010) begin
                final_operand_a_data = cdb_if_port.cdb_data_2;
            end else if (cdb_if_port.cdb_valid_3_2 && effective_operand_a_tag == 3'b011 && effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_2) begin
                final_operand_a_data = cdb_if_port.cdb_data_3_2;
            end else if (cdb_if_port.cdb_valid_3_1 && effective_operand_a_tag == 3'b011 && effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_1) begin
                final_operand_a_data = cdb_if_port.cdb_data_3_1;
            end else begin
                final_operand_a_data = cdb_if_port.cdb_data_3_0;
            end

            // Select operand B data from stored/CDB
            if (effective_operand_b_tag == TAG_READY) begin
                final_operand_b_data = effective_operand_b_data;
            end else if (cdb_if_port.cdb_valid_0 && effective_operand_b_tag == 3'b000) begin
                final_operand_b_data = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && effective_operand_b_tag == 3'b001) begin
                final_operand_b_data = cdb_if_port.cdb_data_1;
            end else if (cdb_if_port.cdb_valid_2 && effective_operand_b_tag == 3'b010) begin
                final_operand_b_data = cdb_if_port.cdb_data_2;
            end else if (cdb_if_port.cdb_valid_3_2 && effective_operand_b_tag == 3'b011 && effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_2) begin
                final_operand_b_data = cdb_if_port.cdb_data_3_2;
            end else if (cdb_if_port.cdb_valid_3_1 && effective_operand_b_tag == 3'b011 && effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_1) begin
                final_operand_b_data = cdb_if_port.cdb_data_3_1;
            end else begin
                final_operand_b_data = cdb_if_port.cdb_data_3_0;
            end

        end else  if (decode_if.dispatch_valid && operand_a_valid_from_decode && operand_b_valid_from_decode) begin
            // Use decode data directly (both operands ready)
            should_issue = 1'b1;
            // Use operand data directly from decode (no CDB needed)
            final_operand_a_data = decode_if.operand_a_data;
            final_operand_b_data = decode_if.operand_b_data;
        end
        else begin
            // Not ready to issue
            should_issue = 1'b0;
            final_operand_a_data = '0;
            final_operand_b_data = '0;
        end
    end

    //==========================================================================
    // DECODE INTERFACE CONTROL
    //==========================================================================
    // Ready to accept new instruction when not occupied or when issuing from stored
    // In secure mode, use voted effective_enable from TMR validator
    assign decode_if.dispatch_ready = all_valid && exec_if.issue_ready && effective_enable;

    //==========================================================================
    // RESERVATION STATION STORAGE UPDATE
    //==========================================================================

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            enable <= #D 1'b0;
            occupied <= #D 1'b0;
            stored_control_signals <= #D '0;
            stored_pc <= #D '0;
            stored_rd_phys_addr <= #D '0;
            stored_pc_value_at_prediction <= #D '0;
            stored_branch_sel <= #D '0;
            stored_branch_prediction <= #D 1'b0;
            stored_store_data <= #D '0;
            stored_operand_a_data <= #D '0;
            stored_operand_a_tag <= #D 0;
            stored_operand_b_data <= #D '0;
            stored_operand_b_tag <= #D 0;
        end else begin
            enable <= #D 1'b1;

            if (decode_if.dispatch_valid &&
                    !(operand_a_valid_from_decode && operand_b_valid_from_decode)) begin

                // Store instruction context
                occupied <= #D 1'b1;
                stored_control_signals <= #D decode_if.control_signals;
                stored_pc <= #D decode_if.pc;
                stored_rd_phys_addr <= #D decode_if.rd_phys_addr;
                stored_pc_value_at_prediction <= #D decode_if.pc_value_at_prediction;
                stored_branch_sel <= #D decode_if.branch_sel;
                stored_branch_prediction <= #D decode_if.branch_prediction;
                stored_store_data <= #D decode_if.store_data;

                // Store operand A (no CDB monitoring during dispatch)
                stored_operand_a_data <= #D decode_if.operand_a_data;
                stored_operand_a_tag <= #D decode_if.operand_a_tag;

                // Store operand B (no CDB monitoring during dispatch)
                stored_operand_b_data <= #D decode_if.operand_b_data;
                stored_operand_b_tag <= #D decode_if.operand_b_tag;
            end

            // Update stored operands from CDB when waiting
            else if (effective_occupied) begin
                // Update operand A from CDB if still waiting
                if (effective_operand_a_tag != TAG_READY) begin
                    if (cdb_if_port.cdb_valid_0 && effective_operand_a_tag == 3'b000) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_0;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_1 && effective_operand_a_tag == 3'b001) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_1;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_2 && effective_operand_a_tag == 3'b010) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_2;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_2 && effective_operand_a_tag == 3'b011 && effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_2) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_3_2;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_1 && effective_operand_a_tag == 3'b011 && effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_1) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_3_1;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_0 && effective_operand_a_tag == 3'b011 && effective_operand_a_data == cdb_if_port.cdb_dest_reg_3_0) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_3_0;
                        stored_operand_a_tag <= #D TAG_READY;
                    end
                end

                // Update operand B from CDB if still waiting
                if (effective_operand_b_tag != TAG_READY) begin
                    if (cdb_if_port.cdb_valid_0 && effective_operand_b_tag == 3'b000) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_0;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_1 && effective_operand_b_tag == 3'b001) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_1;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_2 && effective_operand_b_tag == 3'b010) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_2;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_2 && effective_operand_b_tag == 3'b011 && effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_2) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_3_2;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_1 && effective_operand_b_tag == 3'b011 && effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_1) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_3_1;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_3_0 && effective_operand_b_tag == 3'b011 && effective_operand_b_data == cdb_if_port.cdb_dest_reg_3_0) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_3_0;
                        stored_operand_b_tag <= #D TAG_READY;
                    end
                end
            end

            // Clear occupied when instruction is issued from storage
            if (effective_occupied && operand_a_valid_from_stored && operand_b_valid_from_stored && exec_if.issue_ready) begin
                occupied <= #D 1'b0;
                stored_operand_a_tag <= #D 0;
                stored_operand_b_tag <= #D 0;
            end

            // EAGER MISPREDICTION FLUSH: Clear RS if stored instruction is speculative
            if (should_flush_rs) begin
                occupied <= #D 1'b0;
                stored_operand_a_tag <= #D 0;
                stored_operand_b_tag <= #D 0;
            end
        end
    end

    //==========================================================================
    // REGISTERED EXECUTE INTERFACE OUTPUTS (REQUIREMENT 1)
    //==========================================================================

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            exec_if.issue_valid <= #D 1'b0;
            exec_if.control_signals <= #D '0;
            exec_if.pc <= #D '0;
            exec_if.data_a <= #D '0;
            exec_if.data_b <= #D '0;
            exec_if.store_data <= #D '0;
            exec_if.rd_phys_addr <= #D '0;
            exec_if.pc_value_at_prediction <= #D '0;
            exec_if.branch_sel <= #D '0;
            exec_if.branch_prediction <= #D 1'b0;
        end else begin
            if (should_issue & !should_flush_rs) begin
                // Register outputs when ready to issue
                exec_if.issue_valid <= #D 1'b1;
                exec_if.data_a <= #D final_operand_a_data;
                exec_if.data_b <= #D final_operand_b_data;

                // Use decode data if issuing directly, otherwise use stored data
                if (decode_if.dispatch_valid && operand_a_valid_from_decode && operand_b_valid_from_decode) begin
                    exec_if.control_signals <= #D decode_if.control_signals;
                    exec_if.pc <= #D decode_if.pc;
                    exec_if.store_data <= #D decode_if.store_data;
                    exec_if.rd_phys_addr <= #D decode_if.rd_phys_addr;
                    exec_if.pc_value_at_prediction <= #D decode_if.pc_value_at_prediction;
                    exec_if.branch_sel <= #D decode_if.branch_sel;
                    exec_if.branch_prediction <= #D decode_if.branch_prediction;
                end else begin
                    exec_if.control_signals <= #D effective_control_signals;
                    exec_if.pc <= #D effective_pc;
                    exec_if.store_data <= #D effective_store_data;
                    exec_if.rd_phys_addr <= #D effective_rd_phys_addr;
                    exec_if.pc_value_at_prediction <= #D effective_pc_value_at_prediction;
                    exec_if.branch_sel <= #D effective_branch_sel;
                    exec_if.branch_prediction <= #D effective_branch_prediction;
                end
            end else begin
                exec_if.issue_valid <= #D 1'b0;
            end
        end
    end
    //==========================================================================
    // CDB OUTPUT (COMBINATIONAL FOR SPEED)
    //==========================================================================

    //update this part, register should be at this part not for the rs to alu interface
    //the source of the data is already registered!!! Update : not sure :D

    // Broadcast results from functional unit to CDB
    // Note: The specific CDB channel (0, 1, or 2) is determined by the modport connection
    generate
        if (ALU_TAG == 3'b000) begin : gen_alu0_cdb
            // ALU0 broadcasts on channel 0
            assign cdb_if_port.cdb_valid_0 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_0 = ALU_TAG;
            assign cdb_if_port.cdb_data_0 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_0 = exec_if.rd_phys_addr;
            assign cdb_if_port.cdb_mem_addr_calculation_0 = exec_if.mem_addr_calculation;
            assign cdb_if_port.cdb_misprediction_0 = exec_if.misprediction;
            assign cdb_if_port.cdb_is_branch_0 = exec_if.is_branch;
            assign cdb_if_port.cdb_correct_pc_0 = exec_if.correct_pc;


        end else if (ALU_TAG == 3'b001) begin : gen_alu1_cdb
            // ALU1 broadcasts on channel 1
            assign cdb_if_port.cdb_valid_1 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_1 = ALU_TAG;
            assign cdb_if_port.cdb_data_1 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_1 = exec_if.rd_phys_addr;
            assign cdb_if_port.cdb_mem_addr_calculation_1 = exec_if.mem_addr_calculation;
            assign cdb_if_port.cdb_misprediction_1 = exec_if.misprediction;
            assign cdb_if_port.cdb_is_branch_1 = exec_if.is_branch;
            assign cdb_if_port.cdb_correct_pc_1 = exec_if.correct_pc;
        end else if (ALU_TAG == 3'b010) begin : gen_alu2_cdb
            // ALU2 broadcasts on channel 2
            assign cdb_if_port.cdb_valid_2 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_2 = ALU_TAG;
            assign cdb_if_port.cdb_data_2 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_2 = exec_if.rd_phys_addr;
            assign cdb_if_port.cdb_mem_addr_calculation_2 = exec_if.mem_addr_calculation;
            assign cdb_if_port.cdb_misprediction_2 = exec_if.misprediction;
            assign cdb_if_port.cdb_is_branch_2 = exec_if.is_branch;
            assign cdb_if_port.cdb_correct_pc_2 = exec_if.correct_pc;
        end
    endgenerate

endmodule
