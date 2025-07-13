`timescale 1ns/1ns


module execute_stage #(parameter size = 32)(
    input clk,
    input reset,
    
    // TODO : critical!!! check the logic for JAL, JALR and AUIPC!!!!
    input  logic branch_prediction_i,
    input  logic [size-1 : 0] data_a_i,
    input  logic [size-1 : 0] data_b_i,
    input  logic [size-1 : 0] store_data_i,
    input  logic [size-1 : 0] pc_plus_i,
    input  logic [25 : 0]     control_signal_i,

    input  logic [size-1 : 0] data_from_mem,
    input  logic [size-1 : 0] data_from_wb,
    input  logic [1 : 0] data_a_forward_sel,
    input  logic [1 : 0] data_b_forward_sel,
    input  logic [1 : 0] data_store_forward_sel, // for store data forwarding
    input  logic [2 : 0] branch_sel,

    output logic [size-1 : 0] store_data_o,
    output logic [size-1 : 0] calculated_result_o,

    output logic [11 : 0] control_signal_o,

    output logic [4:0] rs1_addr,    // we can move them to id_to_execute module
    output logic [4:0] rs2_addr,

    output logic misprediction_o,
	output logic [size-1 : 0] correct_pc,

    tracer_interface.sink tracer_if_i,
    tracer_interface.source tracer_if_o
    );

    localparam D = 1; // Delay for simulation purposes

    logic [size-1:0] data_a;
    logic [size-1:0] data_b;
    logic N,Z;
    logic Real_MPC;
	logic isJALR;
    logic [size-1 : 0] function_unit_o;
    
    // Internal signals for EX/MEM pipeline register
    logic [size-1 : 0] calculated_result_internal;
    logic [size-1 : 0] store_data_internal;
    logic [11 : 0] control_signal_internal;

    parametric_mux #(.mem_width(size), .mem_depth(4)) data_a_mux(
        .addr(data_a_forward_sel),
        .data_in({data_from_mem, data_from_wb, data_from_mem, data_a_i}),
        .data_out(data_a));

    parametric_mux  #(.mem_width(size), .mem_depth(4)) dat_b_mux(
        .addr(data_b_forward_sel),
        .data_in({data_from_mem, data_from_wb, data_from_mem, data_b_i}),
        .data_out(data_b));

    parametric_mux #(.mem_width(size), .mem_depth(4)) data_store_mux(
        .addr(data_store_forward_sel),
        .data_in({data_from_mem, data_from_wb, data_from_mem, store_data_i}),
        .data_out(store_data_internal));

    function_unit_alu_shifter #(.size(size)) func_unit(
        .data_a(data_a),
        .data_b(data_b),
        .func_sel(control_signal_i[10:7]),
        .data_result(function_unit_o),
        .carry_out(),
        .overflow(),
        .negative(N),
        .zero(Z));

    Branch_Controller branch_controller(
        .Branch_sel(branch_sel),
        .Z(Z),
        .N(N),
        .MPC(Real_MPC),
        .JALR(isJALR));

	parametric_mux #(.mem_width(size), .mem_depth(2)) pc_correction_mux(
		.addr(isJALR),
		.data_in({function_unit_o, pc_plus_i}),
		.data_out(correct_pc));

    parametric_mux #(.mem_width(size), .mem_depth(2)) pc_mux(
        .addr(control_signal_i[5]),                             //save pc value or function unit output
        .data_in({pc_plus_i, function_unit_o}),
        .data_out(calculated_result_internal));

    // Internal assignments
    assign control_signal_internal = {control_signal_i[25:21],control_signal_i[6:0]};
    
    // Combinational outputs (not registered)
    assign rs1_addr = control_signal_i[15:11]; // todo we can handle this at top level
    assign rs2_addr = control_signal_i[20:16];
    assign misprediction_o =  (Real_MPC ^  branch_prediction_i);

    // EX/MEM Pipeline Register
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            calculated_result_o <= #D {size{1'b0}};
            store_data_o <= #D {size{1'b0}};
            control_signal_o <= #D 12'b0; 
        end else begin
            calculated_result_o <= #D calculated_result_internal;
            store_data_o <= #D store_data_internal;
            control_signal_o <= #D control_signal_internal;
        end
    end

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            tracer_if_o.valid <= #D 1'b0;
            tracer_if_o.pc <= #D 0;
            tracer_if_o.instr <= #D 0;
            tracer_if_o.reg_addr <= #D 0;
            tracer_if_o.reg_data <= #D 0;
            tracer_if_o.is_load <= #D 0;
            tracer_if_o.is_store <= #D 0;
            tracer_if_o.is_float <= #D 0;
            tracer_if_o.mem_size <= #D 2'b00; // No memory operations in EX stage
            tracer_if_o.mem_addr <= #D 32'b0; // No memory address in EX stage
            tracer_if_o.mem_data <= #D 32'b0; // No memory data in EX stage
            tracer_if_o.fpu_flags <= #D 32'b0; // No FPU flags in EX stage
        end else begin
            // Update tracer interface
            tracer_if_o.valid    <= #D 1'b1; // Mark the tracer interface as valid
            tracer_if_o.pc       <= #D tracer_if_i.pc;
            tracer_if_o.instr    <= #D tracer_if_i.instr;
            tracer_if_o.reg_addr <= #D tracer_if_i.reg_addr;
            tracer_if_o.is_load  <= #D tracer_if_i.is_load;
            tracer_if_o.is_store <= #D tracer_if_i.is_store;
            tracer_if_o.is_float <= #D tracer_if_i.is_float;
            tracer_if_o.mem_size <= #D tracer_if_i.mem_size;
            tracer_if_o.mem_addr <= #D tracer_if_i.is_store | tracer_if_i.is_load ? calculated_result_internal : 32'b0; 
            tracer_if_o.mem_data <= #D tracer_if_i.is_store ? store_data_internal : 32'b0; // Data to be stored in memory
            tracer_if_o.reg_data <= #D !(tracer_if_i.is_store | tracer_if_i.is_load) ?  calculated_result_internal : 32'b0; // Data to be written back to register file
            tracer_if_o.fpu_flags <= #D tracer_if_i.fpu_flags; // No FPU flags in EX stage
        end
    end
endmodule
