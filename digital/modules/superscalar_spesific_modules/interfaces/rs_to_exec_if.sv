`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: rs_to_exec_if
//
// Description:
//     This interface defines the communication protocol between a reservation
//     station and its functional unit. Contains all decode information needed
//     by the execute stage for proper instruction execution.
//
// Features:
//     - Ready/valid handshaking for instruction issue
//     - Complete instruction execution context
//     - Control signals for different instruction types
//     - Branch prediction and PC information
//////////////////////////////////////////////////////////////////////////////////

interface rs_to_exec_if #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6
);
    // Handshaking signals
    logic issue_valid;                 // RS has instruction ready for execution
    logic issue_ready;                 // Functional unit ready to accept instruction
    
    // Execution control signals (RS → Functional Unit)
    logic [10:0] control_signals;      // Full control word from decode stage
    logic [DATA_WIDTH-1:0] pc;         // Program counter for this instruction
    
    // Operand data (RS → Functional Unit)
    logic [DATA_WIDTH-1:0] data_a;     // Source operand A (resolved)
    logic [DATA_WIDTH-1:0] data_b;     // Source operand B (resolved - reg or immediate)
    logic [DATA_WIDTH-1:0] store_data; // Data to be stored (for store instructions)
    
    // Physical destination register (RS → Functional Unit)
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr; // Destination physical register
    
    // Branch prediction information (RS → Functional Unit)
    logic [DATA_WIDTH-1:0] pc_value_at_prediction; // PC used for branch prediction
    logic [2:0] branch_sel;            // Branch type selector
    logic branch_prediction;           // Branch prediction result
    
    // Functional unit result (Functional Unit → RS → CDB)
    logic [DATA_WIDTH-1:0] data_result; // Computed result to be forwarded to CDB
    //logic mis_predicted_branch; // Indicates if branch was mispredicted
    //logic correct_pc;
    logic mem_addr_calculation;

    logic misprediction;
    logic is_branch;
    logic [DATA_WIDTH-1:0] correct_pc;

    
    // Modport definitions
    modport reservation_station (
        output issue_valid,
        input  issue_ready,
        output control_signals,
        output pc,
        output data_a,
        output data_b,
        output store_data,
        output rd_phys_addr,
        output pc_value_at_prediction,
        output branch_sel,
        output branch_prediction,
        input  data_result,
        input mem_addr_calculation,
        input misprediction,
        input is_branch,
        input correct_pc

    );
    
    modport functional_unit (
        input  issue_valid,
        output issue_ready,
        input  control_signals,
        input  pc,
        input  data_a,
        input  data_b,
        input  store_data,
        input  rd_phys_addr,
        input  pc_value_at_prediction,
        input  branch_sel,
        input  branch_prediction,
        output data_result,
        output mem_addr_calculation,
        output misprediction,
        output is_branch,
        output correct_pc
    );

endinterface