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

    //==========================================================================
    // INTERNAL LOGIC SIGNALS (COMBINATIONAL)
    //==========================================================================
    
    // Current instruction state (directly in output registers)
    logic instruction_valid;                        // Valid instruction being processed
    
    // Operand dependency tags (for CDB monitoring)
    logic [1:0] operand_a_tag;                      // Operand A dependency tag
    logic [1:0] operand_b_tag;                      // Operand B dependency tag
    logic operand_a_ready;                          // Operand A is ready
    logic operand_b_ready;                          // Operand B is ready
    
    //==========================================================================
    // OPERAND READINESS LOGIC
    //==========================================================================
    
    // Next state logic for operand data and readiness
    logic operand_a_ready_next, operand_b_ready_next;
    logic [DATA_WIDTH-1:0] operand_a_data_next, operand_b_data_next;
    
    // Check if operands are ready from CDB broadcasts
    always_comb begin
        // Default: keep current state from output registers
        operand_a_ready_next = operand_a_ready;
        operand_a_data_next = exec_if.data_a;
        operand_b_ready_next = operand_b_ready;
        operand_b_data_next = exec_if.data_b;
        
        // Check operand A against CDB broadcasts
        if (!operand_a_ready && instruction_valid) begin
            // Check CDB channel 0 (ALU0)
            if (cdb_if_port.cdb_valid_0 && (operand_a_tag == 2'b00)) begin
                operand_a_ready_next = 1'b1;
                operand_a_data_next = cdb_if_port.cdb_data_0;
            end
            // Check CDB channel 1 (ALU1) 
            else if (cdb_if_port.cdb_valid_1 && (operand_a_tag == 2'b01)) begin
                operand_a_ready_next = 1'b1;
                operand_a_data_next = cdb_if_port.cdb_data_1;
            end
            // Check CDB channel 2 (ALU2)
            else if (cdb_if_port.cdb_valid_2 && (operand_a_tag == 2'b10)) begin
                operand_a_ready_next = 1'b1;
                operand_a_data_next = cdb_if_port.cdb_data_2;
            end
        end
        
        // Check operand B against CDB broadcasts
        if (!operand_b_ready && instruction_valid) begin
            // Check CDB channel 0 (ALU0)
            if (cdb_if_port.cdb_valid_0 && (operand_b_tag == 2'b00)) begin
                operand_b_ready_next = 1'b1;
                operand_b_data_next = cdb_if_port.cdb_data_0;
            end
            // Check CDB channel 1 (ALU1)
            else if (cdb_if_port.cdb_valid_1 && (operand_b_tag == 2'b01)) begin
                operand_b_ready_next = 1'b1;
                operand_b_data_next = cdb_if_port.cdb_data_1;
            end
            // Check CDB channel 2 (ALU2)
            else if (cdb_if_port.cdb_valid_2 && (operand_b_tag == 2'b10)) begin
                operand_b_ready_next = 1'b1;
                operand_b_data_next = cdb_if_port.cdb_data_2;
            end
        end
    end
    
    //==========================================================================
    // DISPATCH/ISSUE CONTROL LOGIC
    //==========================================================================
    
    // Ready to accept new instruction from decode stage
    assign decode_if.dispatch_ready = !instruction_valid || (instruction_valid && operand_a_ready_next && operand_b_ready_next && exec_if.issue_ready);
    
    // Ready to issue to functional unit (both operands ready)
    logic ready_to_issue;
    assign ready_to_issue = instruction_valid && operand_a_ready_next && operand_b_ready_next;
    
    //==========================================================================
    // EXECUTE INTERFACE OUTPUTS (SINGLE LEVEL REGISTERS)
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset all output registers
            exec_if.issue_valid <= #D 1'b0;
            exec_if.control_signals <= #D 11'h0;
            exec_if.pc <= #D {DATA_WIDTH{1'b0}};
            exec_if.data_a <= #D {DATA_WIDTH{1'b0}};
            exec_if.data_b <= #D {DATA_WIDTH{1'b0}};
            exec_if.store_data <= #D {DATA_WIDTH{1'b0}};
            exec_if.rd_phys_addr <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            exec_if.pc_value_at_prediction <= #D {DATA_WIDTH{1'b0}};
            exec_if.branch_sel <= #D 3'b000;
            exec_if.branch_prediction <= #D 1'b0;
            
            // Reset internal state
            instruction_valid <= #D 1'b0;
            operand_a_tag <= #D 2'b11;  // Default to ready
            operand_b_tag <= #D 2'b11;  // Default to ready
            operand_a_ready <= #D 1'b1;
            operand_b_ready <= #D 1'b1;
            
        end else begin
            // Handle new instruction dispatch
            if (decode_if.dispatch_valid && decode_if.dispatch_ready) begin
                // Load new instruction into output registers
                instruction_valid <= #D 1'b1;
                exec_if.control_signals <= #D decode_if.control_signals;
                exec_if.pc <= #D decode_if.pc;
                exec_if.rd_phys_addr <= #D decode_if.rd_phys_addr;
                exec_if.pc_value_at_prediction <= #D decode_if.pc_value_at_prediction;
                exec_if.branch_sel <= #D decode_if.branch_sel;
                exec_if.branch_prediction <= #D decode_if.branch_prediction;
                exec_if.store_data <= #D decode_if.store_data;
                
                // Handle operand A with immediate CDB check
                
                if (decode_if.operand_a_tag == 2'b11) begin
                    // Operand A is ready (immediate or already resolved register)
                    exec_if.data_a <= #D decode_if.operand_a_data;
                    operand_a_ready <= #D 1'b1;
                    operand_a_tag <= #D decode_if.operand_a_tag;
                end else begin
                    // Check if operand A is available on CDB right now
                    if (cdb_if_port.cdb_valid_0 && (operand_a_tag == 2'b00)) begin
                        // ALU0 has the data we need
                        exec_if.data_a <= #D cdb_if_port.cdb_data_0;
                        operand_a_ready <= #D 1'b1;
                        operand_a_tag <= #D 2'b11;
                    end else if (cdb_if_port.cdb_valid_1 && (operand_a_tag == 2'b01)) begin
                        // ALU1 has the data we need
                        exec_if.data_a <= #D cdb_if_port.cdb_data_1;
                        operand_a_ready <= #D 1'b1;
                        operand_a_tag <= #D 2'b11;
                    end else if (cdb_if_port.cdb_valid_2 && (operand_a_tag == 2'b10)) begin
                        // ALU2 has the data we need
                        exec_if.data_a <= #D cdb_if_port.cdb_data_2;
                        operand_a_ready <= #D 1'b1;
                        operand_a_tag <= #D 2'b11;
                    end else begin
                        // Data not available yet, use placeholder and wait
                        exec_if.data_a <= #D decode_if.operand_a_data;
                        operand_a_ready <= #D 1'b0;
                        operand_a_tag <= #D decode_if.operand_a_tag;
                    end
                end
                
                // Handle operand B with immediate CDB check
                
                if (decode_if.operand_b_tag == 2'b11) begin
                    // Operand B is ready (immediate or already resolved register)
                    exec_if.data_b <= #D decode_if.operand_b_data;
                    operand_b_ready <= #D 1'b1;
                    operand_b_tag <= #D 2'b11;
                end else begin
                    // Check if operand B is available on CDB right now
                    if (cdb_if_port.cdb_valid_0 && (operand_b_tag == 2'b00)) begin
                        // ALU0 has the data we need
                        exec_if.data_b <= #D cdb_if_port.cdb_data_0;
                        operand_b_ready <= #D 1'b1;
                        operand_b_tag <= #D 2'b11;
                    end else if (cdb_if_port.cdb_valid_1 && (operand_b_tag == 2'b01)) begin
                        // ALU1 has the data we need
                        exec_if.data_b <= #D cdb_if_port.cdb_data_1;
                        operand_b_ready <= #D 1'b1;
                        operand_b_tag <= #D 2'b11;
                    end else if (cdb_if_port.cdb_valid_2 && (operand_b_tag == 2'b10)) begin
                        // ALU2 has the data we need
                        exec_if.data_b <= #D cdb_if_port.cdb_data_2;
                        operand_b_ready <= #D 1'b1;
                        operand_b_tag <= #D 2'b11;
                    end else begin
                        // Data not available yet, use placeholder and wait
                        exec_if.data_b <= #D decode_if.operand_b_data;
                        operand_b_ready <= #D 1'b0;
                        operand_b_tag <= #D decode_if.operand_b_tag;
                    end
                end
                
                // Set issue valid based on final operand readiness (after CDB check)
                exec_if.issue_valid <= #D ((decode_if.operand_a_tag == 2'b11) || 
                                           (cdb_if_port.cdb_valid_0 && (decode_if.operand_a_tag == 2'b00)) ||
                                           (cdb_if_port.cdb_valid_1 && (decode_if.operand_a_tag == 2'b01)) ||
                                           (cdb_if_port.cdb_valid_2 && (decode_if.operand_a_tag == 2'b10))) &&
                                          ((decode_if.operand_b_tag == 2'b11) || 
                                           (cdb_if_port.cdb_valid_0 && (decode_if.operand_b_tag == 2'b00)) ||
                                           (cdb_if_port.cdb_valid_1 && (decode_if.operand_b_tag == 2'b01)) ||
                                           (cdb_if_port.cdb_valid_2 && (decode_if.operand_b_tag == 2'b10)));
                
            end
            // Handle instruction issue (clear when issued and accepted)
            else if (ready_to_issue && exec_if.issue_ready) begin
                instruction_valid <= #D 1'b0;  // Clear instruction
                exec_if.issue_valid <= #D 1'b0;  // Clear issue valid
            end
            // Handle CDB updates (update operand readiness and data)
            else begin
                operand_a_ready <= #D operand_a_ready_next;
                exec_if.data_a <= #D operand_a_data_next;
                operand_b_ready <= #D operand_b_ready_next;
                exec_if.data_b <= #D operand_b_data_next;
                
                // Update issue valid when operands become ready
                exec_if.issue_valid <= #D ready_to_issue;
            end
        end
    end
    
    //==========================================================================
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