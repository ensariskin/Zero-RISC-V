`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: issue_stage
//
// Description:
//     This module implements 3 parallel decode units with register renaming
//     for superscalar execution. Each decode unit processes one instruction 
//     independently, performing register alias table (RAT) lookup for renaming.
//     Outputs physical register addresses to dispatch stage.
//
// Features:
//     - 3 independent decode units using rv32i_decoder
//     - Register Alias Table (RAT) for register renaming
//     - Pipeline control with flush and bubble support
//     - Physical register address generation
//     - Critical path optimization (no register file access)
//////////////////////////////////////////////////////////////////////////////////

module issue_stage #(
    parameter DATA_WIDTH = 32,
    parameter ARCH_REG_ADDR_WIDTH = 5,
    parameter PHYS_REG_ADDR_WIDTH = 6
)(
    // Clock and Reset
    input logic clk,
    input logic reset,
    
    // Pipeline Control
    input logic flush,
    input logic bubble,
    
    // Input from Fetch/Buffer Stage
    input logic [2:0] decode_valid_i,
    input logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2,
    input logic [DATA_WIDTH-1:0] immediate_i_0, immediate_i_1, immediate_i_2,
    input logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2,
    input logic [DATA_WIDTH-1:0] pc_value_at_prediction_i_0, pc_value_at_prediction_i_1, pc_value_at_prediction_i_2,
    input logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2,
    
    // Ready signal to previous stage
    output logic [2:0] decode_ready_o,
    
    // ROB commit interface (for freeing physical registers)
    input logic [2:0] commit_valid_i,
    input logic [PHYS_REG_ADDR_WIDTH-1:0] commit_free_phys_reg_i_0, commit_free_phys_reg_i_1, commit_free_phys_reg_i_2,
    
    // Dispatch Stage Interfaces (NEW - replaces reservation station interfaces)
    issue_to_dispatch_if.issue issue_to_dispatch_0,
    issue_to_dispatch_if.issue issue_to_dispatch_1,
    issue_to_dispatch_if.issue issue_to_dispatch_2
);

    localparam D = 1; // Delay for simulation
    
    // Internal signals for decode units - REMOVED register file data signals
    logic [25:0] control_signal_internal_0, control_signal_internal_1, control_signal_internal_2;
    logic [2:0] branch_sel_internal_0, branch_sel_internal_1, branch_sel_internal_2;
    
    // Architectural register addresses (from decoders)
    logic [ARCH_REG_ADDR_WIDTH-1:0] rs1_arch_0, rs1_arch_1, rs1_arch_2;
    logic [ARCH_REG_ADDR_WIDTH-1:0] rs2_arch_0, rs2_arch_1, rs2_arch_2;
    logic [ARCH_REG_ADDR_WIDTH-1:0] rd_arch_0, rd_arch_1, rd_arch_2;
    
    // Physical register addresses (from RAT)
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs1_phys_0, rs1_phys_1, rs1_phys_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rs2_phys_0, rs2_phys_1, rs2_phys_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_0, rd_phys_1, rd_phys_2;
    logic [PHYS_REG_ADDR_WIDTH-1:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2; /// TODO : add recovery logic
    logic [2:0] rename_valid_internal;
    
    // Write enable signals for destinations
    logic rd_write_enable_0, rd_write_enable_1, rd_write_enable_2;
    
    // Pipeline registers - SIMPLIFIED (no data, only control and addresses)
    logic [2:0] decode_valid_reg;
    logic [DATA_WIDTH-1:0] pc_reg_0, pc_reg_1, pc_reg_2;
    logic [25:0] control_signal_reg_0, control_signal_reg_1, control_signal_reg_2;
    logic [DATA_WIDTH-1:0] pc_prediction_reg_0, pc_prediction_reg_1, pc_prediction_reg_2;
    logic [2:0] branch_sel_reg_0, branch_sel_reg_1, branch_sel_reg_2;
    logic branch_prediction_reg_0, branch_prediction_reg_1, branch_prediction_reg_2;
    logic [DATA_WIDTH-1:0] immediate_reg_0, immediate_reg_1, immediate_reg_2;
    
    // Physical register address pipeline registers
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_reg_0, rd_phys_reg_1, rd_phys_reg_2;

    
    //==========================================================================
    // DECODER UNITS (3 independent decoders)
    //==========================================================================
    
    // Decoder 0
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_0 (
        .instruction(instruction_i_0),
        .control_word(control_signal_internal_0),
        .branch_sel(branch_sel_internal_0),
        .tracer_if_i(dummy_tracer_in_0.sink),
        .tracer_if_o(dummy_tracer_out_0.source)
    );
    
    // Decoder 1
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_1 (
        .instruction(instruction_i_1),
        .control_word(control_signal_internal_1),
        .branch_sel(branch_sel_internal_1),
        .tracer_if_i(dummy_tracer_in_1.sink),
        .tracer_if_o(dummy_tracer_out_1.source)
    );
    
    // Decoder 2
    rv32i_decoder #(.size(DATA_WIDTH)) decoder_2 (
        .instruction(instruction_i_2),
        .control_word(control_signal_internal_2),
        .branch_sel(branch_sel_internal_2),
        .tracer_if_i(dummy_tracer_in_2.sink),
        .tracer_if_o(dummy_tracer_out_2.source)
    );
    
    // Extract architectural register addresses from control signals
    assign rs1_arch_0 = control_signal_internal_0[15:11];
    assign rs2_arch_0 = control_signal_internal_0[20:16];
    assign rd_arch_0 = control_signal_internal_0[25:21];
    
    assign rs1_arch_1 = control_signal_internal_1[15:11];
    assign rs2_arch_1 = control_signal_internal_1[20:16];
    assign rd_arch_1 = control_signal_internal_1[25:21];
    
    assign rs1_arch_2 = control_signal_internal_2[15:11];
    assign rs2_arch_2 = control_signal_internal_2[20:16];
    assign rd_arch_2 = control_signal_internal_2[25:21];
    
    // Determine if instruction writes to destination register
    assign rd_write_enable_0 = control_signal_internal_0[6]; // we bit from control word
    assign rd_write_enable_1 = control_signal_internal_1[6];
    assign rd_write_enable_2 = control_signal_internal_2[6];
    
    //==========================================================================
    // REGISTER ALIAS TABLE (RAT) - RENAME LOGIC
    //==========================================================================
    
    register_alias_table #(
        .ARCH_REGS(32),
        .PHYS_REGS(64),
        .ARCH_ADDR_WIDTH(ARCH_REG_ADDR_WIDTH),
        .PHYS_ADDR_WIDTH(PHYS_REG_ADDR_WIDTH)
    ) rat_inst (
        .clk(clk),
        .reset(reset),
        
        // Decode interface - separated signals
        .rs1_arch_0(rs1_arch_0), .rs1_arch_1(rs1_arch_1), .rs1_arch_2(rs1_arch_2),
        .rs2_arch_0(rs2_arch_0), .rs2_arch_1(rs2_arch_1), .rs2_arch_2(rs2_arch_2),
        .rd_arch_0(rd_arch_0), .rd_arch_1(rd_arch_1), .rd_arch_2(rd_arch_2),
        .decode_valid(decode_valid_i),
        .rd_write_enable_0(rd_write_enable_0), .rd_write_enable_1(rd_write_enable_1), .rd_write_enable_2(rd_write_enable_2),
        
        // Rename outputs - separated signals
        .rs1_phys_0(rs1_phys_0), .rs1_phys_1(rs1_phys_1), .rs1_phys_2(rs1_phys_2),
        .rs2_phys_0(rs2_phys_0), .rs2_phys_1(rs2_phys_1), .rs2_phys_2(rs2_phys_2),
        .rd_phys_0(rd_phys_0),   .rd_phys_1(rd_phys_1),   .rd_phys_2(rd_phys_2),
        .old_rd_phys_0(old_rd_phys_0), .old_rd_phys_1(old_rd_phys_1), .old_rd_phys_2(old_rd_phys_2),
        .rename_valid(rename_valid_internal),
        
        // Commit interface (from ROB) - separated signals  
        .commit_valid(commit_valid_i),
        .free_phys_reg_0(commit_free_phys_reg_i_0), .free_phys_reg_1(commit_free_phys_reg_i_1), .free_phys_reg_2(commit_free_phys_reg_i_2)
    );
    
    //==========================================================================
    // IMMEDIATE VALUE EXTRACTION
    //==========================================================================
    
    // Extract immediate values from instructions (no muxing needed here)
    // Immediate values will be passed directly to dispatch stage
    
    //==========================================================================
    // PIPELINE CONTROL (SIMPLIFIED - no data dependencies)
    //==========================================================================
    
    // Ready signal indicates RAT can allocate physical registers and dispatch stage can accept
    assign decode_ready_o = rename_valid_internal & {issue_to_dispatch_2.dispatch_ready, issue_to_dispatch_1.dispatch_ready, issue_to_dispatch_0.dispatch_ready};
    
    //==========================================================================
    // ISSUE STAGE PIPELINE REGISTERS (CONTROL AND ADDRESSES ONLY)
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            decode_valid_reg <= #D 3'b000;
            pc_reg_0 <= #D {DATA_WIDTH{1'b0}};
            pc_reg_1 <= #D {DATA_WIDTH{1'b0}};
            pc_reg_2 <= #D {DATA_WIDTH{1'b0}};
            control_signal_reg_0 <= #D 26'h0;
            control_signal_reg_1 <= #D 26'h0;
            control_signal_reg_2 <= #D 26'h0;
            pc_prediction_reg_0 <= #D {DATA_WIDTH{1'b0}};
            pc_prediction_reg_1 <= #D {DATA_WIDTH{1'b0}};
            pc_prediction_reg_2 <= #D {DATA_WIDTH{1'b0}};
            branch_sel_reg_0 <= #D 3'b000;
            branch_sel_reg_1 <= #D 3'b000;
            branch_sel_reg_2 <= #D 3'b000;
            branch_prediction_reg_0 <= #D 1'b0;
            branch_prediction_reg_1 <= #D 1'b0;
            branch_prediction_reg_2 <= #D 1'b0;
            immediate_reg_0 <= #D {DATA_WIDTH{1'b0}};
            immediate_reg_1 <= #D {DATA_WIDTH{1'b0}};
            immediate_reg_2 <= #D {DATA_WIDTH{1'b0}};
            rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
        end else begin
            if (flush | bubble) begin
                // Insert NOPs on flush or bubble
                decode_valid_reg <= #D 3'b000;
                pc_reg_0 <= #D {DATA_WIDTH{1'b0}};
                pc_reg_1 <= #D {DATA_WIDTH{1'b0}};
                pc_reg_2 <= #D {DATA_WIDTH{1'b0}};
                control_signal_reg_0 <= #D 26'h0;
                control_signal_reg_1 <= #D 26'h0;
                control_signal_reg_2 <= #D 26'h0;
                pc_prediction_reg_0 <= #D {DATA_WIDTH{1'b0}};
                pc_prediction_reg_1 <= #D {DATA_WIDTH{1'b0}};
                pc_prediction_reg_2 <= #D {DATA_WIDTH{1'b0}};
                branch_sel_reg_0 <= #D 3'b000;
                branch_sel_reg_1 <= #D 3'b000;
                branch_sel_reg_2 <= #D 3'b000;
                branch_prediction_reg_0 <= #D 1'b0;
                branch_prediction_reg_1 <= #D 1'b0;
                branch_prediction_reg_2 <= #D 1'b0;
                immediate_reg_0 <= #D {DATA_WIDTH{1'b0}};
                immediate_reg_1 <= #D {DATA_WIDTH{1'b0}};
                immediate_reg_2 <= #D {DATA_WIDTH{1'b0}};
                rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            end else begin
                // Normal operation - register the decoded control and addresses only
                decode_valid_reg <= #D decode_valid_i;
                
                // PC values
                pc_reg_0 <= #D decode_valid_i[0] ? pc_i_0 : {DATA_WIDTH{1'b0}};
                pc_reg_1 <= #D decode_valid_i[1] ? pc_i_1 : {DATA_WIDTH{1'b0}};
                pc_reg_2 <= #D decode_valid_i[2] ? pc_i_2 : {DATA_WIDTH{1'b0}};
                
                // Control signals
                control_signal_reg_0 <= #D decode_valid_i[0] ? control_signal_internal_0 : 26'h0;
                control_signal_reg_1 <= #D decode_valid_i[1] ? control_signal_internal_1 : 26'h0;
                control_signal_reg_2 <= #D decode_valid_i[2] ? control_signal_internal_2 : 26'h0;
                
                // Branch prediction data
                pc_prediction_reg_0 <= #D decode_valid_i[0] ? pc_value_at_prediction_i_0 : {DATA_WIDTH{1'b0}};
                pc_prediction_reg_1 <= #D decode_valid_i[1] ? pc_value_at_prediction_i_1 : {DATA_WIDTH{1'b0}};
                pc_prediction_reg_2 <= #D decode_valid_i[2] ? pc_value_at_prediction_i_2 : {DATA_WIDTH{1'b0}};
                
                branch_sel_reg_0 <= #D decode_valid_i[0] ? branch_sel_internal_0 : 3'b000;
                branch_sel_reg_1 <= #D decode_valid_i[1] ? branch_sel_internal_1 : 3'b000;
                branch_sel_reg_2 <= #D decode_valid_i[2] ? branch_sel_internal_2 : 3'b000;
                
                branch_prediction_reg_0 <= #D decode_valid_i[0] ? branch_prediction_i_0 : 1'b0;
                branch_prediction_reg_1 <= #D decode_valid_i[1] ? branch_prediction_i_1 : 1'b0;
                branch_prediction_reg_2 <= #D decode_valid_i[2] ? branch_prediction_i_2 : 1'b0;
                
                // Immediate values
                immediate_reg_0 <= #D decode_valid_i[0] ? immediate_i_0 : {DATA_WIDTH{1'b0}};
                immediate_reg_1 <= #D decode_valid_i[1] ? immediate_i_1 : {DATA_WIDTH{1'b0}};
                immediate_reg_2 <= #D decode_valid_i[2] ? immediate_i_2 : {DATA_WIDTH{1'b0}};
                
                // Physical register addresses
                rd_phys_reg_0 <= #D decode_valid_i[0] ? rd_phys_0 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_1 <= #D decode_valid_i[1] ? rd_phys_1 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_2 <= #D decode_valid_i[2] ? rd_phys_2 : {PHYS_REG_ADDR_WIDTH{1'b0}};
            end
        end
    end
    
    //==========================================================================
    // RESERVATION STATION INTERFACE CONNECTIONS
    //==========================================================================
    
    //==========================================================================
    // OUTPUT ASSIGNMENTS TO NEW ISSUE_TO_DISPATCH INTERFACE
    //==========================================================================
    
    // Issue to Dispatch Channel 0
    assign issue_to_dispatch_0.dispatch_valid = decode_valid_reg[0];
    assign issue_to_dispatch_0.control_signals = control_signal_reg_0[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_0.pc = pc_reg_0;
    assign issue_to_dispatch_0.operand_a_phys_addr = rs1_phys_0; // Physical address from RAT
    assign issue_to_dispatch_0.operand_b_phys_addr = rs2_phys_0; // Physical address from RAT
    assign issue_to_dispatch_0.immediate_value = immediate_reg_0; // Immediate value for dispatch stage
    assign issue_to_dispatch_0.rd_phys_addr = rd_phys_reg_0;
    assign issue_to_dispatch_0.pc_value_at_prediction = pc_prediction_reg_0;
    assign issue_to_dispatch_0.branch_sel = branch_sel_reg_0;
    assign issue_to_dispatch_0.branch_prediction = branch_prediction_reg_0;
    
    // Issue to Dispatch Channel 1
    assign issue_to_dispatch_1.dispatch_valid = decode_valid_reg[1];
    assign issue_to_dispatch_1.control_signals = control_signal_reg_1[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_1.pc = pc_reg_1;
    assign issue_to_dispatch_1.operand_a_phys_addr = rs1_phys_1; // Physical address from RAT
    assign issue_to_dispatch_1.operand_b_phys_addr = rs2_phys_1; // Physical address from RAT
    assign issue_to_dispatch_1.immediate_value = immediate_reg_1; // Immediate value for dispatch stage
    assign issue_to_dispatch_1.rd_phys_addr = rd_phys_reg_1;
    assign issue_to_dispatch_1.pc_value_at_prediction = pc_prediction_reg_1;
    assign issue_to_dispatch_1.branch_sel = branch_sel_reg_1;
    assign issue_to_dispatch_1.branch_prediction = branch_prediction_reg_1;
   
    // Issue to Dispatch Channel 2
    assign issue_to_dispatch_2.dispatch_valid = decode_valid_reg[2];
    assign issue_to_dispatch_2.control_signals = control_signal_reg_2[10:0]; // Remove register addresses, use bits [10:0]
    assign issue_to_dispatch_2.pc = pc_reg_2;
    assign issue_to_dispatch_2.operand_a_phys_addr = rs1_phys_2; // Physical address from RAT
    assign issue_to_dispatch_2.operand_b_phys_addr = rs2_phys_2; // Physical address from RAT
    assign issue_to_dispatch_2.immediate_value = immediate_reg_2; // Immediate value for dispatch stage
    assign issue_to_dispatch_2.rd_phys_addr = rd_phys_reg_2;
    assign issue_to_dispatch_2.pc_value_at_prediction = pc_prediction_reg_2;
    assign issue_to_dispatch_2.branch_sel = branch_sel_reg_2;
    assign issue_to_dispatch_2.branch_prediction = branch_prediction_reg_2;

    //==========================================================================
    // DUMMY TRACER INTERFACES (for future tracing support)
    //==========================================================================
    
    // Create dummy tracer interfaces for each decoder
    // These are placeholder interfaces that satisfy the rv32i_decoder port requirements
    // When full tracing is needed later, these can be replaced with actual tracer connections
    // from the superscalar core's debug/trace infrastructure
    tracer_interface dummy_tracer_in_0();
    tracer_interface dummy_tracer_out_0();
    tracer_interface dummy_tracer_in_1();
    tracer_interface dummy_tracer_out_1();
    tracer_interface dummy_tracer_in_2();
    tracer_interface dummy_tracer_out_2();
    
    // Initialize dummy tracer inputs (all inactive for now)
    initial begin
        dummy_tracer_in_0.valid = 1'b0;
        dummy_tracer_in_0.pc = 32'h0;
        dummy_tracer_in_0.instr = 32'h0;
        dummy_tracer_in_0.reg_addr = 5'h0;
        dummy_tracer_in_0.reg_data = 32'h0;
        dummy_tracer_in_0.is_load = 1'b0;
        dummy_tracer_in_0.is_store = 1'b0;
        dummy_tracer_in_0.is_float = 1'b0;
        dummy_tracer_in_0.mem_size = 2'h0;
        dummy_tracer_in_0.mem_addr = 32'h0;
        dummy_tracer_in_0.mem_data = 32'h0;
        dummy_tracer_in_0.fpu_flags = 32'h0;
        
        dummy_tracer_in_1.valid = 1'b0;
        dummy_tracer_in_1.pc = 32'h0;
        dummy_tracer_in_1.instr = 32'h0;
        dummy_tracer_in_1.reg_addr = 5'h0;
        dummy_tracer_in_1.reg_data = 32'h0;
        dummy_tracer_in_1.is_load = 1'b0;
        dummy_tracer_in_1.is_store = 1'b0;
        dummy_tracer_in_1.is_float = 1'b0;
        dummy_tracer_in_1.mem_size = 2'h0;
        dummy_tracer_in_1.mem_addr = 32'h0;
        dummy_tracer_in_1.mem_data = 32'h0;
        dummy_tracer_in_1.fpu_flags = 32'h0;
        
        dummy_tracer_in_2.valid = 1'b0;
        dummy_tracer_in_2.pc = 32'h0;
        dummy_tracer_in_2.instr = 32'h0;
        dummy_tracer_in_2.reg_addr = 5'h0;
        dummy_tracer_in_2.reg_data = 32'h0;
        dummy_tracer_in_2.is_load = 1'b0;
        dummy_tracer_in_2.is_store = 1'b0;
        dummy_tracer_in_2.is_float = 1'b0;
        dummy_tracer_in_2.mem_size = 2'h0;
        dummy_tracer_in_2.mem_addr = 32'h0;
        dummy_tracer_in_2.mem_data = 32'h0;
        dummy_tracer_in_2.fpu_flags = 32'h0;
    end
endmodule
