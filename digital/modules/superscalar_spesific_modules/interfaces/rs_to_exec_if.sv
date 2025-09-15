`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: rs_to_exec_if
//
// Description:
//     This interface defines the minimal communication protocol between a 
//     reservation station and its functional unit. Contains only the signals
//     needed by the functional unit and basic handshaking.
//
// Features:
//     - Ready/valid handshaking for instruction issue
//     - Direct functional unit inputs (data_a, data_b, func_sel)
//////////////////////////////////////////////////////////////////////////////////

interface rs_to_exec_if #(
    parameter DATA_WIDTH = 32
);
    // Handshaking signals
    logic issue_valid;                 // RS has instruction ready for execution
    logic issue_ready;                 // Functional unit ready to accept instruction
    
    // Functional unit inputs (RS → Functional Unit)
    logic [DATA_WIDTH-1:0] data_a;     // Source operand A 
    logic [DATA_WIDTH-1:0] data_b;     // Source operand B
    logic [3:0] func_sel;              // Function select for ALU/shifter
    
    // Functional unit result (Functional Unit → RS → CDB)
    logic [DATA_WIDTH-1:0] data_result; // Computed result to be forwarded to CDB
    
    // Modport definitions
    modport reservation_station (
        output issue_valid,
        input  issue_ready,
        output data_a,
        output data_b,
        output func_sel,
        input  data_result
    );
    
    modport functional_unit (
        input  issue_valid,
        output issue_ready,
        input  data_a,
        input  data_b,
        input  func_sel,
        output data_result
    );

endinterface