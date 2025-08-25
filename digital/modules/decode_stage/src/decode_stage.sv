`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: decode_stage
//
// Description:
//     This module implements the Instruction Decode (ID) stage of a 5-stage RISC-V
//     pipeline processor. It handles instruction decoding, register file access,
//     immediate value selection, and hazard detection.
//
// Features:
//     - Register file read/write operations
//     - Control signal generation from instruction decoding
//     - Operand forwarding from writeback stage
//     - Pipeline bubble insertion for hazard handling
//     - Branch prediction signal propagation
//////////////////////////////////////////////////////////////////////////////////

module decode_stage #(parameter size = 32)(
    input logic clk,
    input logic reset,
    input logic buble,
    input logic [size-1 : 0] i_instruction,
    input logic [size-1 : 0] immediate_i,
    input logic [size-1 : 0] pc_plus_i,

    input logic [size-1 : 0] pc_value_at_prediction_i, 
    input logic branch_perediction_i,

    // Pipeline control signals
    input logic flush,

    //Signal from writeback stage
    input logic [5:0] control_signal_wb,
    input logic [size-1:0] data_in_wb, // TODO : consider renaming

    // Pipeline outputs (ID/EX register outputs)
    output logic branch_prediction_o,
    output logic [size-1 : 0] data_a_o,
    output logic [size-1 : 0] data_b_o,
    output logic [size-1 : 0] store_data_o,
    output logic [size-1 : 0] pc_plus_o,
    output logic [25 : 0] control_signal_o,
    output logic [size-1 : 0] pc_value_at_prediction_o, 
    output logic [2:0] branch_sel_o,
    
    output logic [4:0] rs1_addr,
    output logic [4:0] rs2_addr,

    tracer_interface.sink tracer_if_i,
    tracer_interface.source tracer_if_o
    );

    localparam D = 1; // Delay for simulation purposes
    
    // Internal signals
    logic [size-1 : 0] reg_b_value;
    logic branch_prediction_internal;
    logic [size-1 : 0] data_a_internal;
    logic [size-1 : 0] data_b_internal;
    logic [size-1 : 0] store_data_internal;
    logic [size-1 : 0] pc_plus_internal;
    logic [25 : 0] control_signal_internal;
    logic [2:0] branch_sel_internal;
    tracer_interface tracer_if_internal();

    rv32i_decoder #(.size(size)) decoder(
        .instruction(i_instruction),
        //.buble(buble),
        .branch_sel(branch_sel_internal),      // TODO : consider moving branch_sel to control signals
        .control_word(control_signal_internal), // TODO : consider using interface for control signals
        .tracer_if_i(tracer_if_i),
        .tracer_if_o(tracer_if_internal) // Internal tracer interface for this stage
    );

    assign rs1_addr = control_signal_internal[15:11];
    assign rs2_addr = control_signal_internal[20:16];

    register_file #(.mem_width(size),.mem_depth(size)) RegFile(
        .clk(clk),
        .reset(reset),
        .we(control_signal_wb[0]),
        .rd_in(data_in_wb),
        .a_select(control_signal_internal[15:11]),
        .b_select(control_signal_internal[20:16]),
        .write_addr(control_signal_wb[5:1]),
        .a_out(data_a_internal),
        .b_out(reg_b_value));

    parametric_mux #(.mem_width(size), .mem_depth(2)) Mux_B(
        .addr(control_signal_internal[3]),
        .data_in({immediate_i, reg_b_value}),
        .data_out(data_b_internal));

    // Internal assignments
    assign branch_prediction_internal = branch_perediction_i;
    assign store_data_internal = reg_b_value;
    assign pc_plus_internal = pc_plus_i;

    // ID/EX Pipeline Register
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            branch_prediction_o <= #D 1'b0;
            data_a_o <= #D {size{1'b0}};
            data_b_o <= #D {size{1'b0}};
            store_data_o <= #D {size{1'b0}};
            pc_plus_o <= #D {size{1'b0}};
            control_signal_o <= #D {26{1'b0}};
            pc_value_at_prediction_o <= #D {size{1'b0}};
            branch_sel_o <= #D 3'b000;
        end else begin
            if(flush | buble) begin // todo insert addi x0, x0, 0
                branch_prediction_o <= #D 1'b0;
                data_a_o <= #D {size{1'b0}};
                data_b_o <= #D {size{1'b0}};
                store_data_o <= #D {size{1'b0}};
                pc_plus_o <= #D {size{1'b0}};
                control_signal_o <= #D {26{1'b0}};
                pc_value_at_prediction_o <= #D {size{1'b0}};
                branch_sel_o <= #D 3'b000;
            end else begin
                branch_prediction_o <= #D branch_prediction_internal;
                data_a_o <= #D data_a_internal;
                data_b_o <= #D data_b_internal;
                store_data_o <= #D store_data_internal;
                pc_plus_o <= #D pc_plus_internal;
                control_signal_o <= #D control_signal_internal;
                pc_value_at_prediction_o <= #D pc_value_at_prediction_i;
                branch_sel_o <= #D branch_sel_internal;
            end
        end
    end


    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset tracer interface
                tracer_if_o.valid     <= #D 0;
                tracer_if_o.pc        <= #D 0;
                tracer_if_o.instr     <= #D 32'h00000013; // NOP instruction
                tracer_if_o.reg_addr  <= #D 0;
                tracer_if_o.reg_data  <= #D 0;
                tracer_if_o.is_load   <= #D 0;
                tracer_if_o.is_store  <= #D 0;
                tracer_if_o.is_float  <= #D 0;
                tracer_if_o.mem_size  <= #D 2'b00; // No memory operation
                tracer_if_o.mem_addr  <= #D 32'b0; // No memory address
                tracer_if_o.mem_data  <= #D 32'b0; // No memory data
                tracer_if_o.fpu_flags <= #D 32'b0; // No FPU flags
        end else begin  
            if(flush | buble) begin
                // Reset tracer interface on flush or bubble
                tracer_if_o.valid     <= #D 0;
                //tracer_if_o.pc        <= #D 0;
                tracer_if_o.instr     <= #D 32'h00000013; // NOP instruction
                tracer_if_o.reg_addr  <= #D 0;
                tracer_if_o.reg_data  <= #D 0;
                tracer_if_o.is_load   <= #D 0;
                tracer_if_o.is_store  <= #D 0;
                tracer_if_o.is_float  <= #D 0;
                tracer_if_o.mem_size  <= #D 2'b00; // No memory operation
                tracer_if_o.mem_addr  <= #D 32'b0; // No memory address
                tracer_if_o.mem_data  <= #D 32'b0; // No memory data
                tracer_if_o.fpu_flags <= #D 32'b0; // No FPU flags
            end else begin
                // Update tracer interface
                if(tracer_if_internal.valid) begin
                    tracer_if_o.valid    <= #D 1;
                    tracer_if_o.pc       <= #D tracer_if_internal.pc;
                    tracer_if_o.instr    <= #D tracer_if_internal.instr;
                    tracer_if_o.reg_addr <= #D tracer_if_internal.reg_addr;
                    tracer_if_o.is_load  <= #D tracer_if_internal.is_load;
                    tracer_if_o.is_store <= #D tracer_if_internal.is_store;
                    tracer_if_o.is_float <= #D tracer_if_internal.is_float;
                    tracer_if_o.mem_size <= #D tracer_if_internal.mem_size;
                    tracer_if_o.reg_data <= #D 0; 
                    tracer_if_o.mem_addr <= #D 0;
                    tracer_if_o.mem_data <= #D 0;
                    tracer_if_o.fpu_flags <= #D tracer_if_internal.fpu_flags;
                end
                else 
                    tracer_if_o.valid    <= #D 0;
            end
        end
    end
endmodule
