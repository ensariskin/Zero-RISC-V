`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: reservation_station
//
// Description:
//     This module implements a single reservation station for the Tomasulo
//     algorithm. It receives instructions from decode stage, tracks operand
//     dependencies via CDB, and issues ready instructions to execution units.
//
// Features:
//     - Instruction dispatch from decode stage via decode_to_rs_if
//     - Dependency tracking via CDB listening (cdb_if)
//     - Instruction issue to functional unit via rs_to_exec_if
//     - Tag-based operand dependency resolution
//     - Issues instructions only when both operands are ready
//////////////////////////////////////////////////////////////////////////////////

module reservation_station #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6,
    parameter ALU_TAG = 2'b00  // This RS's ALU tag (00=ALU0, 01=ALU1, 10=ALU2)
)(
    input logic clk,
    input logic reset,
    
    // Interface to decode stage
    decode_to_rs_if.reservation_station decode_if,
    
    // Interface to CDB for dependency resolution
    cdb_if.rs0 cdb_if_port, // Use rs0, rs1, or rs2 modport based on ALU_TAG
    
    // Interface to functional unit
    rs_to_exec_if.reservation_station exec_if
);

    // Reservation station entry
    typedef struct packed {
        logic valid;                                    // Entry is occupied
        logic [10:0] control_signals;                   // Control signals from decode
        logic [DATA_WIDTH-1:0] pc;                      // Program counter
        logic [DATA_WIDTH-1:0] store_data;              // Store data
        logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr;   // Destination physical register
        logic [DATA_WIDTH-1:0] pc_value_at_prediction;  // Branch prediction info
        logic [2:0] branch_sel;
        logic branch_prediction;
        
        // Operand A
        logic [DATA_WIDTH-1:0] operand_a_data;          // Operand A value
        logic [1:0] operand_a_tag;                      // Operand A dependency tag
        logic operand_a_ready;                          // Operand A is ready
        
        // Operand B  
        logic [DATA_WIDTH-1:0] operand_b_data;          // Operand B value
        logic [1:0] operand_b_tag;                      // Operand B dependency tag
        logic operand_b_ready;                          // Operand B is ready
        
        // Execution state
        logic issued;                                   // Instruction issued to functional unit
        logic executing;                                // Instruction currently executing
    } rs_entry_t;
    
    rs_entry_t rs_entry;
    
    // Internal signals
    logic instruction_ready_to_issue;
    logic can_accept_new_instruction;
    
    // Determine which CDB channel to broadcast on based on ALU_TAG
    logic result_broadcasted;
    
    
    //==========================================================================
    // RESERVATION STATION CONTROL LOGIC
    //==========================================================================
    
    // Can accept new instruction if entry is not valid or just completed
    assign can_accept_new_instruction = !rs_entry.valid;
    assign decode_if.dispatch_ready = can_accept_new_instruction;
    
    // Instruction ready to issue when both operands are ready and not yet issued
    assign instruction_ready_to_issue = rs_entry.valid && 
                                       rs_entry.operand_a_ready && 
                                       rs_entry.operand_b_ready && 
                                       !rs_entry.issued;
    
    //==========================================================================
    // INSTRUCTION DISPATCH AND CDB LISTENING
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            rs_entry <= '0;
        end else begin
            // Dispatch new instruction from decode stage
            if (decode_if.dispatch_valid && decode_if.dispatch_ready) begin
                rs_entry.valid <= 1'b1;
                rs_entry.control_signals <= decode_if.control_signals;
                rs_entry.pc <= decode_if.pc;
                rs_entry.store_data <= decode_if.store_data;
                rs_entry.rd_phys_addr <= decode_if.rd_phys_addr;
                rs_entry.pc_value_at_prediction <= decode_if.pc_value_at_prediction;
                rs_entry.branch_sel <= decode_if.branch_sel;
                rs_entry.branch_prediction <= decode_if.branch_prediction;
                
                // Set operand A
                rs_entry.operand_a_data <= decode_if.operand_a_data;
                rs_entry.operand_a_tag <= decode_if.operand_a_tag;
                rs_entry.operand_a_ready <= (decode_if.operand_a_tag == 2'b11); // Ready if tag is VALID
                
                // Set operand B
                rs_entry.operand_b_data <= decode_if.operand_b_data;
                rs_entry.operand_b_tag <= decode_if.operand_b_tag;
                rs_entry.operand_b_ready <= (decode_if.operand_b_tag == 2'b11); // Ready if tag is VALID
                
                // Reset execution state
                rs_entry.issued <= 1'b0;
                rs_entry.executing <= 1'b0;
            end else begin
                // CDB Listening for operand A dependency
                if (rs_entry.valid && !rs_entry.operand_a_ready) begin
                    // Check CDB channel 0
                    if (cdb_if_port.cdb_valid_0 && rs_entry.operand_a_tag == cdb_if_port.cdb_tag_0) begin
                        rs_entry.operand_a_data <= cdb_if_port.cdb_data_0;
                        rs_entry.operand_a_ready <= 1'b1;
                    end
                    // Check CDB channel 1  
                    else if (cdb_if_port.cdb_valid_1 && rs_entry.operand_a_tag == cdb_if_port.cdb_tag_1) begin
                        rs_entry.operand_a_data <= cdb_if_port.cdb_data_1;
                        rs_entry.operand_a_ready <= 1'b1;
                    end
                    // Check CDB channel 2
                    else if (cdb_if_port.cdb_valid_2 && rs_entry.operand_a_tag == cdb_if_port.cdb_tag_2) begin
                        rs_entry.operand_a_data <= cdb_if_port.cdb_data_2;
                        rs_entry.operand_a_ready <= 1'b1;
                    end
                end
                
                // CDB Listening for operand B dependency
                if (rs_entry.valid && !rs_entry.operand_b_ready) begin
                    // Check CDB channel 0
                    if (cdb_if_port.cdb_valid_0 && rs_entry.operand_b_tag == cdb_if_port.cdb_tag_0) begin
                        rs_entry.operand_b_data <= cdb_if_port.cdb_data_0;
                        rs_entry.operand_b_ready <= 1'b1;
                    end
                    // Check CDB channel 1
                    else if (cdb_if_port.cdb_valid_1 && rs_entry.operand_b_tag == cdb_if_port.cdb_tag_1) begin
                        rs_entry.operand_b_data <= cdb_if_port.cdb_data_1;
                        rs_entry.operand_b_ready <= 1'b1;
                    end
                    // Check CDB channel 2
                    else if (cdb_if_port.cdb_valid_2 && rs_entry.operand_b_tag == cdb_if_port.cdb_tag_2) begin
                        rs_entry.operand_b_data <= cdb_if_port.cdb_data_2;
                        rs_entry.operand_b_ready <= 1'b1;
                    end
                end
            end
            
            // Mark as issued when functional unit accepts
            if (exec_if.issue_valid && exec_if.issue_ready) begin
                rs_entry.issued <= 1'b1;
                rs_entry.executing <= 1'b1;
            end
            
            // Clear entry when execution completes and result is on CDB
            if (rs_entry.executing && result_broadcasted) begin
                rs_entry.valid <= 1'b0;
                rs_entry.executing <= 1'b0;
                rs_entry.issued <= 1'b0;
            end
        end
    end
    
    //==========================================================================
    // INSTRUCTION ISSUE (to functional unit)
    //==========================================================================
    
    // Issue instruction to functional unit when ready
    assign exec_if.issue_valid = instruction_ready_to_issue;
    
    // Send operands and control to functional unit (or zeros if not ready)
    assign exec_if.data_a = instruction_ready_to_issue ? rs_entry.operand_a_data : {DATA_WIDTH{1'b0}};
    assign exec_if.data_b = instruction_ready_to_issue ? rs_entry.operand_b_data : {DATA_WIDTH{1'b0}};
    assign exec_if.func_sel = instruction_ready_to_issue ? rs_entry.control_signals[10:7] : 4'b0000;
    
    //==========================================================================
    // CDB BROADCASTING (result forwarding)
    //==========================================================================
    
    
    generate
        if (ALU_TAG == 2'b00) begin : gen_cdb_channel_0
            assign cdb_if_port.cdb_valid_0 = rs_entry.executing && exec_if.issue_ready; // Result available
            assign cdb_if_port.cdb_tag_0 = ALU_TAG;
            assign cdb_if_port.cdb_data_0 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_0 = rs_entry.rd_phys_addr;
            assign result_broadcasted = cdb_if_port.cdb_valid_0;
        end else if (ALU_TAG == 2'b01) begin : gen_cdb_channel_1
            assign cdb_if_port.cdb_valid_1 = rs_entry.executing && exec_if.issue_ready; // Result available
            assign cdb_if_port.cdb_tag_1 = ALU_TAG;
            assign cdb_if_port.cdb_data_1 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_1 = rs_entry.rd_phys_addr;
            assign result_broadcasted = cdb_if_port.cdb_valid_1;
        end else begin : gen_cdb_channel_2
            assign cdb_if_port.cdb_valid_2 = rs_entry.executing && exec_if.issue_ready; // Result available
            assign cdb_if_port.cdb_tag_2 = ALU_TAG;
            assign cdb_if_port.cdb_data_2 = exec_if.data_result;
            assign cdb_if_port.cdb_dest_reg_2 = rs_entry.rd_phys_addr;
            assign result_broadcasted = cdb_if_port.cdb_valid_2;
        end
    endgenerate

endmodule