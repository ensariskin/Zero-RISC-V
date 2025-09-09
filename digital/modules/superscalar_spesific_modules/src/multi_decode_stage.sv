`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: multi_decode_stage
//
// Description:
//     This module implements 3 parallel decode units for superscalar execution.
//     Each decode unit processes one instruction independently, accessing a 
//     shared multi-port register file. Supports variable width decoding (1-3 
//     instructions per cycle).
//
// Features:
//     - 3 independent decode units using rv32i_decoder
//     - Multi-port register file (6 read ports, 3 write ports)
//     - Pipeline control with flush and bubble support
//     - Forwarding from writeback stages
//     - Dependency detection and scoreboarding (future)
//////////////////////////////////////////////////////////////////////////////////

module multi_decode_stage #(
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
    
    // Outputs to Execute Stage (now with physical addresses)
    output logic [2:0] decode_valid_o,
    output logic [DATA_WIDTH-1:0] data_a_o_0, data_a_o_1, data_a_o_2,
    output logic [DATA_WIDTH-1:0] data_b_o_0, data_b_o_1, data_b_o_2,
    output logic [DATA_WIDTH-1:0] store_data_o_0, store_data_o_1, store_data_o_2,
    output logic [DATA_WIDTH-1:0] pc_o_0, pc_o_1, pc_o_2,
    output logic [25:0] control_signal_o_0, control_signal_o_1, control_signal_o_2,
    output logic [DATA_WIDTH-1:0] pc_value_at_prediction_o_0, pc_value_at_prediction_o_1, pc_value_at_prediction_o_2,
    output logic [2:0] branch_sel_o_0, branch_sel_o_1, branch_sel_o_2,
    output logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2,
    
    // Physical register addresses for reservation station
    output logic [PHYS_REG_ADDR_WIDTH-1:0] rs1_phys_o_0, rs1_phys_o_1, rs1_phys_o_2,
    output logic [PHYS_REG_ADDR_WIDTH-1:0] rs2_phys_o_0, rs2_phys_o_1, rs2_phys_o_2,
    output logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_o_0, rd_phys_o_1, rd_phys_o_2,
    output logic [PHYS_REG_ADDR_WIDTH-1:0] old_rd_phys_o_0, old_rd_phys_o_1, old_rd_phys_o_2,
    output logic [2:0] rename_valid_o,
    
    // Architectural register addresses (for debugging/tracing)
    output logic [ARCH_REG_ADDR_WIDTH-1:0] rs1_arch_o_0, rs1_arch_o_1, rs1_arch_o_2,
    output logic [ARCH_REG_ADDR_WIDTH-1:0] rs2_arch_o_0, rs2_arch_o_1, rs2_arch_o_2,
    output logic [ARCH_REG_ADDR_WIDTH-1:0] rd_arch_o_0, rd_arch_o_1, rd_arch_o_2
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
    logic [PHYS_REG_ADDR_WIDTH-1:0] old_rd_phys_0, old_rd_phys_1, old_rd_phys_2;
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
        .rd_phys_0(rd_phys_0), .rd_phys_1(rd_phys_1), .rd_phys_2(rd_phys_2),
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
        .NUM_WRITE_PORTS(3) // 1 port per instruction
    ) reg_file (
        .clk(clk),
        .reset(reset),
        
        // Read ports (6 total: 2 per instruction) - separated signals for better understanding
        .read_addr_0(rs1_phys_0), .read_addr_1(rs2_phys_0),
        .read_addr_2(rs1_phys_1), .read_addr_3(rs2_phys_1),
        .read_addr_4(rs1_phys_2), .read_addr_5(rs2_phys_2),
        
        .read_data_0(reg_a_data_0), .read_data_1(reg_b_data_0),
        .read_data_2(reg_a_data_1), .read_data_3(reg_b_data_1),
        .read_data_4(reg_a_data_2), .read_data_5(reg_b_data_2),
        
        // Write ports (3 total: 1 per writeback) - separated signals for better understanding
        .write_enable_0(wb_reg_write_i_0), .write_enable_1(wb_reg_write_i_1), .write_enable_2(wb_reg_write_i_2),
        .write_addr_0(wb_rd_i_0), .write_addr_1(wb_rd_i_1), .write_addr_2(wb_rd_i_2),
        .write_data_0(wb_data_i_0), .write_data_1(wb_data_i_1), .write_data_2(wb_data_i_2)
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
    
    // Always ready for now (no structural hazards)
    assign decode_ready_o = 3'b111; // TODO implement real ready logic
    
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
            end
        end
    end
    
    //==========================================================================
    // OUTPUT ASSIGNMENTS
    //==========================================================================
    
    assign decode_valid_o = decode_valid_reg;
    
    assign data_a_o_0 = data_a_reg_0;
    assign data_a_o_1 = data_a_reg_1;
    assign data_a_o_2 = data_a_reg_2;
    
    assign data_b_o_0 = data_b_reg_0;
    assign data_b_o_1 = data_b_reg_1;
    assign data_b_o_2 = data_b_reg_2;
    
    assign store_data_o_0 = store_data_reg_0;
    assign store_data_o_1 = store_data_reg_1;
    assign store_data_o_2 = store_data_reg_2;
    
    assign pc_o_0 = pc_reg_0;
    assign pc_o_1 = pc_reg_1;
    assign pc_o_2 = pc_reg_2;
    
    assign control_signal_o_0 = control_signal_reg_0;
    assign control_signal_o_1 = control_signal_reg_1;
    assign control_signal_o_2 = control_signal_reg_2;
    
    assign pc_value_at_prediction_o_0 = pc_prediction_reg_0;
    assign pc_value_at_prediction_o_1 = pc_prediction_reg_1;
    assign pc_value_at_prediction_o_2 = pc_prediction_reg_2;
    
    assign branch_sel_o_0 = branch_sel_reg_0;
    assign branch_sel_o_1 = branch_sel_reg_1;
    assign branch_sel_o_2 = branch_sel_reg_2;
    
    assign branch_prediction_o_0 = branch_prediction_reg_0;
    assign branch_prediction_o_1 = branch_prediction_reg_1;
    assign branch_prediction_o_2 = branch_prediction_reg_2;
    
    // Physical register addresses for reservation station
    assign rs1_phys_o_0 = rs1_phys_0;
    assign rs1_phys_o_1 = rs1_phys_1;
    assign rs1_phys_o_2 = rs1_phys_2;
    
    assign rs2_phys_o_0 = rs2_phys_0;
    assign rs2_phys_o_1 = rs2_phys_1;
    assign rs2_phys_o_2 = rs2_phys_2;
    
    assign rd_phys_o_0 = rd_phys_0;
    assign rd_phys_o_1 = rd_phys_1;
    assign rd_phys_o_2 = rd_phys_2;
    
    assign old_rd_phys_o_0 = old_rd_phys_0;
    assign old_rd_phys_o_1 = old_rd_phys_1;
    assign old_rd_phys_o_2 = old_rd_phys_2;
    
    assign rename_valid_o = rename_valid_internal;
    
    // Architectural register addresses (for debugging/tracing)
    assign rs1_arch_o_0 = rs1_arch_0;
    assign rs1_arch_o_1 = rs1_arch_1;
    assign rs1_arch_o_2 = rs1_arch_2;
    
    assign rs2_arch_o_0 = rs2_arch_0;
    assign rs2_arch_o_1 = rs2_arch_1;
    assign rs2_arch_o_2 = rs2_arch_2;
    
    assign rd_arch_o_0 = rd_arch_0;
    assign rd_arch_o_1 = rd_arch_1;
    assign rd_arch_o_2 = rd_arch_2;

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
