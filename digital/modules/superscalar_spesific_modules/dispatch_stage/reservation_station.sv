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
    parameter ALU_TAG = 2'b00  // This RS's ALU tag (00, 01, or 10)
)(
    // Clock and Reset
    input logic clk,
    input logic reset,
    
    // Interface from Decode/Dispatch Stage
    decode_to_rs_if.reservation_station decode_if,
    
    
    // Interface to CDB (for monitoring other ALUs and broadcasting results)
    cdb_if cdb_if_port,  // Note: Will be connected to appropriate modport (rs0, rs1, rs2)
    
    // Interface to Functional Unit
    rs_to_exec_if.reservation_station exec_if
);

    localparam D = 1; // Delay for simulation
    localparam TAG_READY = 2'b11; // Tag indicating operand is ready/valid

    //==========================================================================
    // RESERVATION STATION STORAGE REGISTERS
    //==========================================================================
    
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
    logic [1:0] stored_operand_a_tag;
    
    // Operand B storage and tracking  
    logic [DATA_WIDTH-1:0] stored_operand_b_data;
    logic [1:0] stored_operand_b_tag;

    //==========================================================================
    // COMBINATIONAL LOGIC FOR OPERAND SELECTION
    //==========================================================================
    
    // Check if operands are valid (from decode or CDB)
    logic operand_a_valid_from_decode, operand_b_valid_from_decode;
    logic operand_a_valid_from_stored, operand_b_valid_from_stored;
    logic [DATA_WIDTH-1:0] final_operand_a_data, final_operand_b_data;
    logic should_issue;
    
    always_comb begin
        // Check if operands are valid from decode interface (only TAG_READY, no CDB monitoring)
        operand_a_valid_from_decode = (decode_if.operand_a_tag == TAG_READY);
        operand_b_valid_from_decode = (decode_if.operand_b_tag == TAG_READY);
        
        // Check if stored operands are valid (from storage or CDB monitoring)
        operand_a_valid_from_stored = (stored_operand_a_tag == TAG_READY) ||
                                     (cdb_if_port.cdb_valid_0 && stored_operand_a_tag == 2'b00) ||
                                     (cdb_if_port.cdb_valid_1 && stored_operand_a_tag == 2'b01) ||
                                     (cdb_if_port.cdb_valid_2 && stored_operand_a_tag == 2'b10);
                                     
        operand_b_valid_from_stored = (stored_operand_b_tag == TAG_READY) ||
                                     (cdb_if_port.cdb_valid_0 && stored_operand_b_tag == 2'b00) ||
                                     (cdb_if_port.cdb_valid_1 && stored_operand_b_tag == 2'b01) ||
                                     (cdb_if_port.cdb_valid_2 && stored_operand_b_tag == 2'b10);
        
        // Determine what data to use and when to issue
        if (decode_if.dispatch_valid && operand_a_valid_from_decode && operand_b_valid_from_decode) begin
            // Use decode data directly (both operands ready)
            should_issue = 1'b1;
            
            // Use operand data directly from decode (no CDB needed)
            final_operand_a_data = decode_if.operand_a_data;
            final_operand_b_data = decode_if.operand_b_data;
            
        end else if (occupied && operand_a_valid_from_stored && operand_b_valid_from_stored) begin
            // Use stored data (both operands now ready)
            should_issue = 1'b1;
            
            // Select operand A data from stored/CDB
            if (stored_operand_a_tag == TAG_READY) begin
                final_operand_a_data = stored_operand_a_data;
            end else if (cdb_if_port.cdb_valid_0 && stored_operand_a_tag == 2'b00) begin
                final_operand_a_data = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && stored_operand_a_tag == 2'b01) begin
                final_operand_a_data = cdb_if_port.cdb_data_1;
            end else begin // cdb_valid_2 && stored_operand_a_tag == 2'b10
                final_operand_a_data = cdb_if_port.cdb_data_2;
            end
            
            // Select operand B data from stored/CDB
            if (stored_operand_b_tag == TAG_READY) begin
                final_operand_b_data = stored_operand_b_data;
            end else if (cdb_if_port.cdb_valid_0 && stored_operand_b_tag == 2'b00) begin
                final_operand_b_data = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && stored_operand_b_tag == 2'b01) begin
                final_operand_b_data = cdb_if_port.cdb_data_1;
            end else begin // cdb_valid_2 && stored_operand_b_tag == 2'b10
                final_operand_b_data = cdb_if_port.cdb_data_2;
            end
            
        end else begin
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
    assign decode_if.dispatch_ready = !occupied; //(occupied && operand_a_valid_from_stored && operand_b_valid_from_stored && exec_if.issue_ready);

    //==========================================================================
    // RESERVATION STATION STORAGE UPDATE
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            occupied <= #D 1'b0;
            stored_control_signals <= #D '0;
            stored_pc <= #D '0;
            stored_rd_phys_addr <= #D '0;
            stored_pc_value_at_prediction <= #D '0;
            stored_branch_sel <= #D '0;
            stored_branch_prediction <= #D 1'b0;
            stored_store_data <= #D '0;
            stored_operand_a_data <= #D '0;
            stored_operand_a_tag <= #D TAG_READY;
            stored_operand_b_data <= #D '0;
            stored_operand_b_tag <= #D TAG_READY;
        end else begin
            // Handle instruction dispatch that needs storage
            if (decode_if.dispatch_valid && decode_if.dispatch_ready && 
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
            else if (occupied) begin
                // Update operand A from CDB if still waiting
                if (stored_operand_a_tag != TAG_READY) begin
                    if (cdb_if_port.cdb_valid_0 && stored_operand_a_tag == 2'b00) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_0;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_1 && stored_operand_a_tag == 2'b01) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_1;
                        stored_operand_a_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_2 && stored_operand_a_tag == 2'b10) begin
                        stored_operand_a_data <= #D cdb_if_port.cdb_data_2;
                        stored_operand_a_tag <= #D TAG_READY;
                    end
                end
                
                // Update operand B from CDB if still waiting
                if (stored_operand_b_tag != TAG_READY) begin
                    if (cdb_if_port.cdb_valid_0 && stored_operand_b_tag == 2'b00) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_0;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_1 && stored_operand_b_tag == 2'b01) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_1;
                        stored_operand_b_tag <= #D TAG_READY;
                    end else if (cdb_if_port.cdb_valid_2 && stored_operand_b_tag == 2'b10) begin
                        stored_operand_b_data <= #D cdb_if_port.cdb_data_2;
                        stored_operand_b_tag <= #D TAG_READY;
                    end
                end
            end
            
            // Clear occupied when instruction is issued from storage
            if (occupied && operand_a_valid_from_stored && operand_b_valid_from_stored && exec_if.issue_ready) begin
                occupied <= #D 1'b0;
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
            if (should_issue) begin
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
                    exec_if.control_signals <= #D stored_control_signals;
                    exec_if.pc <= #D stored_pc;
                    exec_if.store_data <= #D stored_store_data;
                    exec_if.rd_phys_addr <= #D stored_rd_phys_addr;
                    exec_if.pc_value_at_prediction <= #D stored_pc_value_at_prediction;
                    exec_if.branch_sel <= #D stored_branch_sel;
                    exec_if.branch_prediction <= #D stored_branch_prediction;
                end
            end else begin
                exec_if.issue_valid <= #D 1'b0;
            end
        end
    end//==========================================================================
    // CDB OUTPUT (COMBINATIONAL FOR SPEED)
    //==========================================================================
    
    // Broadcast results from functional unit to CDB
    // Note: The specific CDB channel (0, 1, or 2) is determined by the modport connection
    generate
        if (ALU_TAG == 2'b00) begin : gen_alu0_cdb
            // ALU0 broadcasts on channel 0
            assign cdb_if_port.cdb_valid_0 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_0 = ALU_TAG;
            assign cdb_if_port.cdb_data_0 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_0 = exec_if.rd_phys_addr;
        end else if (ALU_TAG == 2'b01) begin : gen_alu1_cdb
            // ALU1 broadcasts on channel 1  
            assign cdb_if_port.cdb_valid_1 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_1 = ALU_TAG;
            assign cdb_if_port.cdb_data_1 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_1 = exec_if.rd_phys_addr;
        end else if (ALU_TAG == 2'b10) begin : gen_alu2_cdb
            // ALU2 broadcasts on channel 2
            assign cdb_if_port.cdb_valid_2 = exec_if.issue_valid && exec_if.issue_ready; // Result valid when FU completes
            assign cdb_if_port.cdb_tag_2 = ALU_TAG;
            assign cdb_if_port.cdb_data_2 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_2 = exec_if.rd_phys_addr;
        end
    endgenerate

endmodule