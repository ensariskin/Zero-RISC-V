`timescale 1ns/1ns

module fetch_stage#(parameter size = 32)(
    input  logic clk,
    input  logic reset,
    input  logic buble,
    input  logic misprediction,
    input  logic [size-1 : 0] instruction_i,
    input  logic instruction_valid,
    // Pipeline control signals
    input  logic flush,

	input  logic [size-1 : 0] correct_pc,
    output logic [size-1 : 0] inst_addr,

    // Pipeline outputs (IF/ID register outputs)
    output logic [size-1 : 0] instruction_o,
    output logic [size-1 : 0] imm_o,
    output logic [size-1 : 0] pc_plus_o,
    output logic branch_prediction_o,

    tracer_interface.source tracer_if
    );
    
    localparam D = 1; // Delay for simulation purposes

    // Internal signals
    logic [size-1 : 0] current_pc;
    logic jump;
    logic [size-1 : 0] imm;
	logic jalr;
    logic [size-1 : 0] pc_plus_internal;

    // Immediate decoder
    early_stage_immediate_decoder  early_stage_imm_dec(
        .instruction(instruction_i),
        .imm_o(imm));

    // Jump controller
    jump_controller #(.size(size)) jump_controller(
        .instruction(instruction_i),
        .jump(jump),
		.jalr(jalr));

    // Program counter control
    program_counter_ctrl PC(
        .clk(clk),
        .reset(reset),
        .buble(buble),
        .instruction_valid(instruction_valid),
        .jump(jump),
		.jalr(jalr),
		.correct_pc(correct_pc),
		.misprediction(misprediction),
        .imm_i(imm),
        .inst_addr(inst_addr),
        .current_pc(current_pc),
        .pc_save(pc_plus_internal));

    // IF/ID Pipeline Register
    always @(posedge clk or negedge reset)
    begin
        if (!reset) begin
            instruction_o <= #D 0;
            imm_o <= #D 0;
            pc_plus_o <= #D 0;
            branch_prediction_o <= #D 0;
        end else begin                     
            if(flush) begin
                instruction_o <= #D 32'h00000013;
                imm_o <= #D 0;
                pc_plus_o <= #D 0;
                branch_prediction_o <= #D 0;
            end else if (~buble) begin
                instruction_o <= #D instruction_i;
                imm_o <= #D imm;
                pc_plus_o <= #D pc_plus_internal;
                branch_prediction_o <= #D jump;
            end
        end
    end


    always @(posedge clk or negedge reset)
    begin
        if(!reset) begin
             // Tracer interface reset
            tracer_if.pc <= #D 0;
            tracer_if.instr <= #D instruction_i;
            tracer_if.valid <= #D 0;
            tracer_if.reg_addr <= #D 0;
            tracer_if.reg_data <= #D 0;
            tracer_if.is_load <= #D 0;
            tracer_if.is_store <= #D 0;
            tracer_if.is_float <= #D 0;
            tracer_if.mem_size <= #D 0;
            tracer_if.mem_addr <= #D 0;
            tracer_if.mem_data <= #D 0;
            tracer_if.fpu_flags <= #D 0;
        end else begin  
            if(flush) begin
                // Reset tracer interface on flush
                tracer_if.valid <= #D 0;
                tracer_if.pc <= #D 0;
                tracer_if.instr <= #D 32'h00000013; // NOP instruction
                tracer_if.reg_addr <= #D 0;
                tracer_if.reg_data <= #D 0;
                tracer_if.is_load <= #D 0;
                tracer_if.is_store <= #D 0;
                tracer_if.is_float <= #D 0;
                tracer_if.mem_size <= #D 2'b00; // No memory operation
                tracer_if.mem_addr <= #D 32'b0; // No memory address
                tracer_if.mem_data <= #D 32'b0; // No memory data
                tracer_if.fpu_flags <= #D 32'b0; // No FPU flags
            end else if(~buble) begin
                // Update tracer interface
                tracer_if.valid <= #D 1;
                tracer_if.pc <= #D current_pc;
                tracer_if.instr <= #D instruction_i;
                tracer_if.reg_addr <= #D 0; // No register address in fetch stage
                tracer_if.reg_data <= #D 0; // No register data in fetch stage
                tracer_if.is_load <= #D 0; // No load operation in fetch stage
                tracer_if.is_store <= #D 0; // No store operation in fetch stage
                tracer_if.is_float <= #D 0; // No floating-point operation in fetch stage
                tracer_if.mem_size <= #D 2'b00; // No memory size in fetch stage
                tracer_if.mem_addr <= #D 32'b0; // No memory address in fetch stage
                tracer_if.mem_data <= #D 32'b0; // No memory data in fetch stage
                tracer_if.fpu_flags <= #D 32'b0; // No FPU flags in fetch stage
            end
        end
    end
endmodule
