`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: execute_stage
//
// Description:
//     Execute stage for 3-way superscalar RISC-V processor implementing Tomasulo
//     algorithm. Contains 3 functional units that receive instructions from
//     reservation stations, execute them, and broadcast results on the CDB.
//
// Features:
//     - 3 parallel functional units (ALU/Shifter)
//     - Interface with reservation stations via rs_to_exec_if
//     - Result broadcast via Common Data Bus (CDB)
//     - Support for all RV32I arithmetic and logic operations
//
// Functional Units:
//     - FU0: ALU/Shifter for integer operations
//     - FU1: ALU/Shifter for integer operations
//     - FU2: ALU/Shifter for integer operations
//////////////////////////////////////////////////////////////////////////////////

module superscalar_execute_stage #(
        parameter DATA_WIDTH = 32
    )(
        input logic clk,
        input logic rst_n,
        input  logic enable_pipe_1,
        input  logic enable_pipe_2,

        output logic update_predictor_0,
        output logic update_predictor_1,
        output logic update_predictor_2,

        output logic misprediction_0,
        output logic misprediction_1,
        output logic misprediction_2,

        output logic [DATA_WIDTH-1:0] correct_pc_0,
        output logic [DATA_WIDTH-1:0] correct_pc_1,
        output logic [DATA_WIDTH-1:0] correct_pc_2,

        output logic [DATA_WIDTH-1:0] update_pc_0,
        output logic [DATA_WIDTH-1:0] update_pc_1,
        output logic [DATA_WIDTH-1:0] update_pc_2,

        // JALR detection and misprediction signals
        output logic is_jalr_0,
        output logic is_jalr_1,
        output logic is_jalr_2,

        output logic [5:0] phys_reg_branch_0,
        output logic [5:0] phys_reg_branch_1,
        output logic [5:0] phys_reg_branch_2,

        // Interface to reservation stations
        rs_to_exec_if.functional_unit rs_to_exec_0,
        rs_to_exec_if.functional_unit rs_to_exec_1,
        rs_to_exec_if.functional_unit rs_to_exec_2

    );

    // Functional unit signals for FU0
    logic [DATA_WIDTH-1:0] fu0_data_a, fu0_data_b;
    logic [3:0] fu0_func_sel;
    logic [DATA_WIDTH-1:0] fu0_result;
    logic fu0_carry_out, fu0_overflow, fu0_negative, fu0_zero;
    logic fu0_busy;

    // Branch control signals for FU0
    logic fu0_mpc, fu0_jalr;
    logic fu0_misprediction;
    logic [DATA_WIDTH-1:0] fu0_corrected_result;
    logic [DATA_WIDTH-1:0] fu0_correct_pc;

    // Functional unit signals for FU1
    logic [DATA_WIDTH-1:0] fu1_data_a, fu1_data_b;
    logic [3:0] fu1_func_sel;
    logic [DATA_WIDTH-1:0] fu1_result;
    logic fu1_carry_out, fu1_overflow, fu1_negative, fu1_zero;
    logic fu1_busy;

    // Branch control signals for FU1
    logic fu1_mpc, fu1_jalr;
    logic fu1_misprediction;
    logic [DATA_WIDTH-1:0] fu1_corrected_result;
    logic [DATA_WIDTH-1:0] fu1_correct_pc;

    // Functional unit signals for FU2
    logic [DATA_WIDTH-1:0] fu2_data_a, fu2_data_b;
    logic [3:0] fu2_func_sel;
    logic [DATA_WIDTH-1:0] fu2_result;
    logic fu2_carry_out, fu2_overflow, fu2_negative, fu2_zero;
    logic fu2_busy;

    // Branch control signals for FU2
    logic fu2_mpc, fu2_jalr;
    logic fu2_misprediction;
    logic [DATA_WIDTH-1:0] fu2_corrected_result;
    logic [DATA_WIDTH-1:0] fu2_correct_pc;

    // TODO WE NEED REGISTERS HERE BECAUSE ALL OFF THESE SIGNALS ARE FORWARDED ALL OTHER MODULES (MAYBE)
    //=======================================================================
    // Functional Unit 0 (FU0)
    //=======================================================================
    // FU0 is ready when not busy
    assign rs_to_exec_0.issue_ready = !fu0_busy;

    // Extract function select from control signals
    // Control signals format: [10:7] = func_sel, [6:0] = other control bits
    assign fu0_func_sel = rs_to_exec_0.control_signals[10:7];

    // Operand assignment for FU0
    assign fu0_data_a = rs_to_exec_0.data_a;
    assign fu0_data_b = rs_to_exec_0.data_b;

    // Misprediction detection for FU0
    assign fu0_misprediction = fu0_jalr ? fu0_result != rs_to_exec_0.pc_value_at_prediction : (fu0_mpc ^ rs_to_exec_0.branch_prediction);

    // PC correction for JALR (FU0)
    assign fu0_correct_pc = fu0_jalr ? {fu0_result[31:2], 2'b00} : {rs_to_exec_0.pc[31:2], 2'b00};

    // Result selection: save PC for JAL/JALR or ALU result (FU0)
    assign fu0_corrected_result = rs_to_exec_0.control_signals[5] ? {rs_to_exec_0.pc[31:2], 2'b00} : fu0_result;

    // Result assignment
    assign rs_to_exec_0.data_result = rs_to_exec_0.is_branch ? rs_to_exec_0.pc_value_at_prediction : fu0_corrected_result;

    assign rs_to_exec_0.mem_addr_calculation = (rs_to_exec_0.control_signals[4] ) || (rs_to_exec_0.control_signals[3] && !rs_to_exec_0.control_signals[6]);

    assign rs_to_exec_0.misprediction = fu0_misprediction;
    assign rs_to_exec_0.is_branch = rs_to_exec_0.branch_sel > 0 & rs_to_exec_0.branch_sel < 6; // if branch_sel is not NOBRANCH(0) or JAL/JALR(6,7)
    assign rs_to_exec_0.correct_pc = fu0_correct_pc;

    assign misprediction_0 = rs_to_exec_0.issue_valid ? fu0_misprediction : 0;
    assign correct_pc_0 = fu0_correct_pc;
    assign update_pc_0 = rs_to_exec_0.data_result;
    assign update_predictor_0 = rs_to_exec_0.issue_valid ? (rs_to_exec_0.branch_sel > 0 & rs_to_exec_0.branch_sel < 6) : 0;
    assign phys_reg_branch_0 = rs_to_exec_0.rd_phys_addr;

    // JALR detection and misprediction for FU0
    assign is_jalr_0 = rs_to_exec_0.issue_valid && fu0_jalr;
    //=======================================================================
    // Functional Unit 1 (FU1)
    //=======================================================================

    assign rs_to_exec_1.issue_ready = !fu1_busy & enable_pipe_1;
    assign fu1_func_sel = rs_to_exec_1.control_signals[10:7];
    assign fu1_data_a = rs_to_exec_1.data_a;
    assign fu1_data_b = rs_to_exec_1.data_b;

    // Misprediction detection for FU1
    assign fu1_misprediction = fu1_jalr? fu1_result != rs_to_exec_1.pc_value_at_prediction : (fu1_mpc ^ rs_to_exec_1.branch_prediction);

    // PC correction for JALR (FU1)
    assign fu1_correct_pc = fu1_jalr ? {fu1_result[31:2], 2'b00} : {rs_to_exec_1.pc[31:2], 2'b00};

    // Result selection: save PC for JAL/JALR or ALU result (FU1)
    assign fu1_corrected_result = rs_to_exec_1.control_signals[5] ? {rs_to_exec_1.pc[31:2], 2'b00} : fu1_result;

    assign rs_to_exec_1.data_result = rs_to_exec_1.is_branch ? rs_to_exec_1.pc_value_at_prediction : fu1_corrected_result;
    assign rs_to_exec_1.mem_addr_calculation = (rs_to_exec_1.control_signals[4] ) || (rs_to_exec_1.control_signals[3] && !rs_to_exec_1.control_signals[6]);

    assign rs_to_exec_1.misprediction = fu1_misprediction;
    assign rs_to_exec_1.is_branch = rs_to_exec_1.branch_sel > 0 & rs_to_exec_1.branch_sel < 6; // if branch_sel is not NOBRANCH(0) or JAL/JALR(6,7)
    assign rs_to_exec_1.correct_pc = fu1_correct_pc;

    assign misprediction_1 = rs_to_exec_1.issue_valid ?  fu1_misprediction : 0;
    assign correct_pc_1 = fu1_correct_pc;
    assign update_pc_1 = rs_to_exec_1.data_result;
    assign update_predictor_1 = rs_to_exec_1.issue_valid ? (rs_to_exec_1.branch_sel > 0 & rs_to_exec_1.branch_sel < 6) : 0;
    assign phys_reg_branch_1 = rs_to_exec_1.rd_phys_addr;

    // JALR detection and misprediction for FU1
    assign is_jalr_1 = rs_to_exec_1.issue_valid && fu1_jalr;
    //=======================================================================
    // Functional Unit 2 (FU2)
    //=======================================================================

    assign rs_to_exec_2.issue_ready = !fu2_busy & enable_pipe_2;
    assign fu2_func_sel = rs_to_exec_2.control_signals[10:7];
    assign fu2_data_a = rs_to_exec_2.data_a;
    assign fu2_data_b = rs_to_exec_2.data_b;

    // Misprediction detection for FU2
    assign fu2_misprediction = fu2_jalr ? fu2_result != rs_to_exec_2.pc_value_at_prediction : (fu2_mpc ^ rs_to_exec_2.branch_prediction);

    // PC correction for JALR (FU2)
    assign fu2_correct_pc = fu2_jalr ? {fu2_result[31:2], 2'b00} : {rs_to_exec_2.pc[31:2], 2'b00};

    // Result selection: save PC for JAL/JALR or ALU result (FU2)
    assign fu2_corrected_result = rs_to_exec_2.control_signals[5] ? {rs_to_exec_2.pc[31:2], 2'b00} : fu2_result;

    assign rs_to_exec_2.data_result = rs_to_exec_2.is_branch  ? rs_to_exec_2.pc_value_at_prediction : fu2_corrected_result;
    assign rs_to_exec_2.mem_addr_calculation = (rs_to_exec_2.control_signals[4] ) || (rs_to_exec_2.control_signals[3] && !rs_to_exec_2.control_signals[6]);

    assign rs_to_exec_2.misprediction = fu2_misprediction;
    assign rs_to_exec_2.is_branch = rs_to_exec_2.branch_sel > 0 & rs_to_exec_2.branch_sel < 6; // if branch_sel is not NOBRANCH(0) or JAL/JALR(6,7)
    assign rs_to_exec_2.correct_pc = fu2_correct_pc;

    assign misprediction_2 = rs_to_exec_2.issue_valid ? fu2_misprediction : 0;
    assign correct_pc_2 = fu2_correct_pc;
    assign update_pc_2 = rs_to_exec_2.data_result;
    assign update_predictor_2 = rs_to_exec_2.issue_valid ? (rs_to_exec_2.branch_sel > 0 & rs_to_exec_2.branch_sel < 6) : 0;
    assign phys_reg_branch_2 = rs_to_exec_2.rd_phys_addr;

    // JALR detection and misprediction for FU2
    assign is_jalr_2 = rs_to_exec_2.issue_valid && fu2_jalr;
    //=======================================================================
    // Legacy Functional Unit Instances
    //=======================================================================

    // FU0: ALU/Shifter instance
    function_unit_alu_shifter #(
        .size(DATA_WIDTH)
    ) fu0_alu_shifter (
        .data_a(fu0_data_a),
        .data_b(fu0_data_b),
        .func_sel(fu0_func_sel),
        .data_result(fu0_result),
        .carry_out(fu0_carry_out),
        .overflow(fu0_overflow),
        .negative(fu0_negative),
        .zero(fu0_zero),
        .busy(fu0_busy)
    );

    // FU1: ALU/Shifter instance
    function_unit_alu_shifter #(
        .size(DATA_WIDTH)
    ) fu1_alu_shifter (
        .data_a(fu1_data_a),
        .data_b(fu1_data_b),
        .func_sel(fu1_func_sel),
        .data_result(fu1_result),
        .carry_out(fu1_carry_out),
        .overflow(fu1_overflow),
        .negative(fu1_negative),
        .zero(fu1_zero),
        .busy(fu1_busy)
    );

    // FU2: ALU/Shifter instance
    function_unit_alu_shifter #(
        .size(DATA_WIDTH)
    ) fu2_alu_shifter (
        .data_a(fu2_data_a),
        .data_b(fu2_data_b),
        .func_sel(fu2_func_sel),
        .data_result(fu2_result),
        .carry_out(fu2_carry_out),
        .overflow(fu2_overflow),
        .negative(fu2_negative),
        .zero(fu2_zero),
        .busy(fu2_busy)
    );

    //=======================================================================
    // Branch Controller Instances
    //=======================================================================

    // Branch Controller for FU0
    Branch_Controller fu0_branch_controller (
        .Branch_sel(rs_to_exec_0.branch_sel),
        .Z(fu0_zero),
        .N(fu0_negative),
        .MPC(fu0_mpc),
        .JALR(fu0_jalr)
    );

    // Branch Controller for FU1
    Branch_Controller fu1_branch_controller (
        .Branch_sel(rs_to_exec_1.branch_sel),
        .Z(fu1_zero),
        .N(fu1_negative),
        .MPC(fu1_mpc),
        .JALR(fu1_jalr)
    );

    // Branch Controller for FU2
    Branch_Controller fu2_branch_controller (
        .Branch_sel(rs_to_exec_2.branch_sel),
        .Z(fu2_zero),
        .N(fu2_negative),
        .MPC(fu2_mpc),
        .JALR(fu2_jalr)
    );

endmodule