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
    
    // Writeback inputs (for register file writes and forwarding)
    input logic [2:0] wb_valid_i,
    input logic [DATA_WIDTH-1:0] wb_data_i_0, wb_data_i_1, wb_data_i_2,
    input logic [PHYS_REG_ADDR_WIDTH-1:0] wb_rd_i_0, wb_rd_i_1, wb_rd_i_2,  // Now physical addresses
    input logic wb_reg_write_i_0, wb_reg_write_i_1, wb_reg_write_i_2,
    
    // ROB commit interface (for freeing physical registers)
    input logic [2:0] commit_valid_i,
    input logic [PHYS_REG_ADDR_WIDTH-1:0] commit_free_phys_reg_i_0, commit_free_phys_reg_i_1, commit_free_phys_reg_i_2,
    
    // Reservation Station Interfaces
    decode_to_rs_if.decode decode_to_rs_0,
    decode_to_rs_if.decode decode_to_rs_1,
    decode_to_rs_if.decode decode_to_rs_2
);

    localparam D = 1; // Delay for simulation
    
    // Internal signals for decode units
    logic [DATA_WIDTH-1:0] reg_a_data_0, reg_a_data_1, reg_a_data_2;
    logic [DATA_WIDTH-1:0] reg_b_data_0, reg_b_data_1, reg_b_data_2;
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
    
    // Mux outputs (immediate vs register)
    logic [DATA_WIDTH-1:0] data_b_mux_0, data_b_mux_1, data_b_mux_2;
    
    // Pipeline registers
    logic [2:0] decode_valid_reg;
    logic [DATA_WIDTH-1:0] data_a_reg_0, data_a_reg_1, data_a_reg_2;
    logic [DATA_WIDTH-1:0] data_b_reg_0, data_b_reg_1, data_b_reg_2;
    logic [DATA_WIDTH-1:0] store_data_reg_0, store_data_reg_1, store_data_reg_2;
    logic [DATA_WIDTH-1:0] pc_reg_0, pc_reg_1, pc_reg_2;
    logic [25:0] control_signal_reg_0, control_signal_reg_1, control_signal_reg_2;
    logic [DATA_WIDTH-1:0] pc_prediction_reg_0, pc_prediction_reg_1, pc_prediction_reg_2;
    logic [2:0] branch_sel_reg_0, branch_sel_reg_1, branch_sel_reg_2;
    logic branch_prediction_reg_0, branch_prediction_reg_1, branch_prediction_reg_2;
    
    // Physical register address pipeline registers
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_reg_0, rd_phys_reg_1, rd_phys_reg_2;
    
    // Tag pipeline registers  
    logic [1:0] operand_a_tag_reg_0, operand_a_tag_reg_1, operand_a_tag_reg_2;
    logic [1:0] operand_b_tag_reg_0, operand_b_tag_reg_1, operand_b_tag_reg_2;

    // Writeback valid signals 
    logic wb_valid_0, wb_valid_1, wb_valid_2;
    assign wb_valid_0 = wb_valid_i[0] & wb_reg_write_i_0;
    assign wb_valid_1 = wb_valid_i[1] & wb_reg_write_i_1;
    assign wb_valid_2 = wb_valid_i[2] & wb_reg_write_i_2;
    
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
    // EXTENDED MULTI-PORT REGISTER FILE (64 physical registers)
    //==========================================================================
    
    multi_port_register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(PHYS_REG_ADDR_WIDTH),  // Now 6 bits for 64 registers
        .NUM_READ_PORTS(6),  // 2 ports per instruction (rs1, rs2)
        .NUM_REGISTERS(64)   // 64 physical registers
    ) reg_file (
        .clk(clk),
        .reset(reset),
        
        // Read ports (6 total: 2 per instruction) - separated signals for better understanding
        .read_addr_0(rs1_phys_0), .read_addr_1(rs2_phys_0),
        .read_addr_2(rs1_phys_1), .read_addr_3(rs2_phys_1),
        .read_addr_4(rs1_phys_2), .read_addr_5(rs2_phys_2),
        
        .read_data_0(reg_a_data_0), .read_data_1(reg_b_data_0),  // Instruction 0
        .read_data_2(reg_a_data_1), .read_data_3(reg_b_data_1),  // Instruction 1
        .read_data_4(reg_a_data_2), .read_data_5(reg_b_data_2),  // Instruction 2
        
        // Read tags (6 total: 2 per instruction) - for dependency checking
        .read_tag_0(), .read_tag_1(),  // Instruction 0 - not used yet, will be used by reservation stations
        .read_tag_2(), .read_tag_3(),  // Instruction 1 - not used yet, will be used by reservation stations  
        .read_tag_4(), .read_tag_5(),  // Instruction 2 - not used yet, will be used by reservation stations
        
        // Allocation ports (from RAT for register allocation during decode)
        .alloc_enable_0(rename_valid_internal[0]), .alloc_enable_1(rename_valid_internal[1]), .alloc_enable_2(rename_valid_internal[2]),
        .alloc_addr_0(rd_phys_0), .alloc_addr_1(rd_phys_1), .alloc_addr_2(rd_phys_2),
        .alloc_tag_0(2'b00), .alloc_tag_1(2'b01), .alloc_tag_2(2'b10),  // Tags: port 0->ALU0, port 1->ALU1, port 2->ALU2
        
        // Commit ports (from ROB - will be connected later)
        .commit_enable_0(wb_valid_0), .commit_enable_1(wb_valid_1), .commit_enable_2(wb_valid_2),
        .commit_addr_0(wb_rd_i_0), .commit_addr_1(wb_rd_i_1), .commit_addr_2(wb_rd_i_2),
        .commit_data_0(wb_data_i_0), .commit_data_1(wb_data_i_1), .commit_data_2(wb_data_i_2)
    );
    
    //==========================================================================
    // IMMEDIATE VS REGISTER SELECTION MUXES
    //==========================================================================
    
    // Mux for instruction 0 (immediate vs register B)
    parametric_mux #(.mem_width(DATA_WIDTH), .mem_depth(2)) mux_b_0 (
        .addr(control_signal_internal_0[3]), // Use immediate bit from control signal
        .data_in({immediate_i_0, reg_b_data_0}),
        .data_out(data_b_mux_0)
    );
    
    // Mux for instruction 1
    parametric_mux #(.mem_width(DATA_WIDTH), .mem_depth(2)) mux_b_1 (
        .addr(control_signal_internal_1[3]),
        .data_in({immediate_i_1, reg_b_data_1}),
        .data_out(data_b_mux_1)
    );
    
    // Mux for instruction 2
    parametric_mux #(.mem_width(DATA_WIDTH), .mem_depth(2)) mux_b_2 (
        .addr(control_signal_internal_2[3]),
        .data_in({immediate_i_2, reg_b_data_2}),
        .data_out(data_b_mux_2)
    );
    
    //==========================================================================
    // PIPELINE CONTROL
    //==========================================================================
    
    // can be totally combinational
    assign decode_ready_o = rename_valid_internal & {decode_to_rs_2.dispatch_ready, decode_to_rs_1.dispatch_ready, decode_to_rs_0.dispatch_ready};
    
    //==========================================================================
    // DECODE/EXECUTE PIPELINE REGISTERS
    //==========================================================================
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            decode_valid_reg <= #D 3'b000;
            data_a_reg_0 <= #D {DATA_WIDTH{1'b0}};
            data_a_reg_1 <= #D {DATA_WIDTH{1'b0}};
            data_a_reg_2 <= #D {DATA_WIDTH{1'b0}};
            data_b_reg_0 <= #D {DATA_WIDTH{1'b0}};
            data_b_reg_1 <= #D {DATA_WIDTH{1'b0}};
            data_b_reg_2 <= #D {DATA_WIDTH{1'b0}};
            store_data_reg_0 <= #D {DATA_WIDTH{1'b0}};
            store_data_reg_1 <= #D {DATA_WIDTH{1'b0}};
            store_data_reg_2 <= #D {DATA_WIDTH{1'b0}};
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
            rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
            operand_a_tag_reg_0 <= #D 2'b11;
            operand_a_tag_reg_1 <= #D 2'b11;
            operand_a_tag_reg_2 <= #D 2'b11;
            operand_b_tag_reg_0 <= #D 2'b11;
            operand_b_tag_reg_1 <= #D 2'b11;
            operand_b_tag_reg_2 <= #D 2'b11;
        end else begin
            if (flush | bubble) begin
                // Insert NOPs on flush or bubble
                decode_valid_reg <= #D 3'b000;
                data_a_reg_0 <= #D {DATA_WIDTH{1'b0}};
                data_a_reg_1 <= #D {DATA_WIDTH{1'b0}};
                data_a_reg_2 <= #D {DATA_WIDTH{1'b0}};
                data_b_reg_0 <= #D {DATA_WIDTH{1'b0}};
                data_b_reg_1 <= #D {DATA_WIDTH{1'b0}};
                data_b_reg_2 <= #D {DATA_WIDTH{1'b0}};
                store_data_reg_0 <= #D {DATA_WIDTH{1'b0}};
                store_data_reg_1 <= #D {DATA_WIDTH{1'b0}};
                store_data_reg_2 <= #D {DATA_WIDTH{1'b0}};
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
                rd_phys_reg_0 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_1 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_2 <= #D {PHYS_REG_ADDR_WIDTH{1'b0}};
                operand_a_tag_reg_0 <= #D 2'b11;
                operand_a_tag_reg_1 <= #D 2'b11;
                operand_a_tag_reg_2 <= #D 2'b11;
                operand_b_tag_reg_0 <= #D 2'b11;
                operand_b_tag_reg_1 <= #D 2'b11;
                operand_b_tag_reg_2 <= #D 2'b11;
            end else begin
                // Normal operation - register the decoded values
                decode_valid_reg <= #D decode_valid_i;
                
                // Register operand A (always from register file)
                data_a_reg_0 <= #D decode_valid_i[0] ? reg_a_data_0 : {DATA_WIDTH{1'b0}};
                data_a_reg_1 <= #D decode_valid_i[1] ? reg_a_data_1 : {DATA_WIDTH{1'b0}};
                data_a_reg_2 <= #D decode_valid_i[2] ? reg_a_data_2 : {DATA_WIDTH{1'b0}};
                
                // Register operand B (muxed between immediate and register)
                data_b_reg_0 <= #D decode_valid_i[0] ? data_b_mux_0 : {DATA_WIDTH{1'b0}};
                data_b_reg_1 <= #D decode_valid_i[1] ? data_b_mux_1 : {DATA_WIDTH{1'b0}};
                data_b_reg_2 <= #D decode_valid_i[2] ? data_b_mux_2 : {DATA_WIDTH{1'b0}};
                
                // Store data (always register B value for stores)
                store_data_reg_0 <= #D decode_valid_i[0] ? reg_b_data_0 : {DATA_WIDTH{1'b0}};
                store_data_reg_1 <= #D decode_valid_i[1] ? reg_b_data_1 : {DATA_WIDTH{1'b0}};
                store_data_reg_2 <= #D decode_valid_i[2] ? reg_b_data_2 : {DATA_WIDTH{1'b0}};
                
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
                
                // Physical register addresses
                rd_phys_reg_0 <= #D decode_valid_i[0] ? rd_phys_0 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_1 <= #D decode_valid_i[1] ? rd_phys_1 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                rd_phys_reg_2 <= #D decode_valid_i[2] ? rd_phys_2 : {PHYS_REG_ADDR_WIDTH{1'b0}};
                
                // Tags (TODO: Connect to register file read tags)
                operand_a_tag_reg_0 <= #D decode_valid_i[0] ? 2'b11 : 2'b11;
                operand_a_tag_reg_1 <= #D decode_valid_i[1] ? 2'b11 : 2'b11;
                operand_a_tag_reg_2 <= #D decode_valid_i[2] ? 2'b11 : 2'b11;
                operand_b_tag_reg_0 <= #D decode_valid_i[0] ? 2'b11 : 2'b11;
                operand_b_tag_reg_1 <= #D decode_valid_i[1] ? 2'b11 : 2'b11;
                operand_b_tag_reg_2 <= #D decode_valid_i[2] ? 2'b11 : 2'b11;
            end
        end
    end
    
    //==========================================================================
    // RESERVATION STATION INTERFACE CONNECTIONS
    //==========================================================================
    
    // Reservation Station 0 connections
    assign decode_to_rs_0.dispatch_valid = decode_valid_reg[0];
    assign decode_to_rs_0.control_signals = control_signal_reg_0[10:0]; // Remove register addresses, use bits [10:0]
    assign decode_to_rs_0.pc = pc_reg_0;
    assign decode_to_rs_0.operand_a_data = data_a_reg_0;
    assign decode_to_rs_0.operand_b_data = data_b_reg_0;
    assign decode_to_rs_0.store_data = store_data_reg_0;
    assign decode_to_rs_0.operand_a_tag = operand_a_tag_reg_0;
    assign decode_to_rs_0.operand_b_tag = operand_b_tag_reg_0;
    assign decode_to_rs_0.rd_phys_addr = rd_phys_reg_0;
    assign decode_to_rs_0.pc_value_at_prediction = pc_prediction_reg_0;
    assign decode_to_rs_0.branch_sel = branch_sel_reg_0;
    assign decode_to_rs_0.branch_prediction = branch_prediction_reg_0;
    
    // Reservation Station 1 connections
    assign decode_to_rs_1.dispatch_valid = decode_valid_reg[1];
    assign decode_to_rs_1.control_signals = control_signal_reg_1[10:0]; // Remove register addresses, use bits [10:0]
    assign decode_to_rs_1.pc = pc_reg_1;
    assign decode_to_rs_1.operand_a_data = data_a_reg_1;
    assign decode_to_rs_1.operand_b_data = data_b_reg_1;
    assign decode_to_rs_1.store_data = store_data_reg_1;
    assign decode_to_rs_1.operand_a_tag = operand_a_tag_reg_1;
    assign decode_to_rs_1.operand_b_tag = operand_b_tag_reg_1;
    assign decode_to_rs_1.rd_phys_addr = rd_phys_reg_1;
    assign decode_to_rs_1.pc_value_at_prediction = pc_prediction_reg_1;
    assign decode_to_rs_1.branch_sel = branch_sel_reg_1;
    assign decode_to_rs_1.branch_prediction = branch_prediction_reg_1;
    
    // Reservation Station 2 connections
    assign decode_to_rs_2.dispatch_valid = decode_valid_reg[2];
    assign decode_to_rs_2.control_signals = control_signal_reg_2[10:0]; // Remove register addresses, use bits [10:0]
    assign decode_to_rs_2.pc = pc_reg_2;
    assign decode_to_rs_2.operand_a_data = data_a_reg_2;
    assign decode_to_rs_2.operand_b_data = data_b_reg_2;
    assign decode_to_rs_2.store_data = store_data_reg_2;
    assign decode_to_rs_2.operand_a_tag = operand_a_tag_reg_2;
    assign decode_to_rs_2.operand_b_tag = operand_b_tag_reg_2;
    assign decode_to_rs_2.rd_phys_addr = rd_phys_reg_2;
    assign decode_to_rs_2.pc_value_at_prediction = pc_prediction_reg_2;
    assign decode_to_rs_2.branch_sel = branch_sel_reg_2;
    assign decode_to_rs_2.branch_prediction = branch_prediction_reg_2;


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
