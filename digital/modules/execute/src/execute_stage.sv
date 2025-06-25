`timescale 1ns/1ns


module execute_stage #(parameter size = 32)(
    /*input clk,
    input reset,
    */
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
    input  logic [2 : 0] branch_sel,

    output logic [size-1 : 0] store_data_o,
    output logic [size-1 : 0] calculated_result_o,

    output logic [11 : 0] control_signal_o,

    output logic [4:0] rs1_addr,    // we can move them to id_to_execute module
    output logic [4:0] rs2_addr,

    output logic misprediction_o,
	output logic [size-1 : 0] correct_pc);

    logic [size-1:0] data_a;
    logic [size-1:0] data_b;
    logic N,Z;
    logic Real_MPC;
	logic isJALR;
    logic [size-1 : 0] function_unit_o;

    parametric_mux #(.mem_width(size), .mem_depth(4)) data_a_mux(
        .addr(data_a_forward_sel),
        .data_in({data_from_mem, data_from_wb, data_from_mem, data_a_i}),
        .data_out(data_a));

   parametric_mux  #(.mem_width(size), .mem_depth(4)) dat_b_mux(
        .addr(data_b_forward_sel),
        .data_in({data_from_mem, data_from_wb, data_from_mem, data_b_i}),
        .data_out(data_b));

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
        .data_out(calculated_result_o));

    assign store_data_o = store_data_i;
    assign control_signal_o = {control_signal_i[25:21],control_signal_i[6:0]};
    assign rs1_addr = control_signal_i[15:11]; // todo we can handle this at top level
    assign rs2_addr = control_signal_i[20:16];
    assign misprediction_o =  (Real_MPC ^  branch_prediction_i);
endmodule
