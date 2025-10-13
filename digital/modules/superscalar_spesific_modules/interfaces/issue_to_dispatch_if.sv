`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: issue_to_dispatch_if
//
// Description:
//     Interface between Issue Stage and Dispatch Stage for the 3-way superscalar
//     processor. Carries decoded instruction information and physical register
//     addresses (not data) to optimize critical path timing.
//
// Key Features:
//     - Physical register addresses only (no data values)
//     - Control signals for execution
//     - Immediate values and PC information
//     - Ready/valid handshaking protocol
//
// Critical Path Optimization:
//     Issue Stage: arch_reg → RAT_lookup → phys_reg_addr (short path)
//     Dispatch Stage: phys_reg_addr → register_file → data (separate path)
//////////////////////////////////////////////////////////////////////////////////

interface issue_to_dispatch_if #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6
);

    // Control signals
    logic dispatch_valid;                           // Instruction is valid and ready to dispatch
    logic dispatch_ready;                           // Dispatch stage is ready to accept
    logic [10:0] control_signals;                   // Execution control (no register addresses)
    
    // Program counter and prediction info
    logic [DATA_WIDTH-1:0] pc;                      // Program counter
    logic [DATA_WIDTH-1:0] pc_value_at_prediction;  // PC used for branch prediction
    logic [2:0] branch_sel;                         // Branch type selector
    logic branch_prediction;                        // Branch prediction result
    
    // Physical register addresses (key difference from old interface)
    logic [PHYS_REG_ADDR_WIDTH-1:0] operand_a_phys_addr;  // Physical address for rs1
    logic [PHYS_REG_ADDR_WIDTH-1:0] operand_b_phys_addr;  // Physical address for rs2
    logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr;         // Destination physical register
    logic [PHYS_REG_ADDR_WIDTH-2:0] rd_arch_addr;         // Destination physical register
    logic [2:0]                     alloc_tag;
    // Immediate value (for immediate instructions)
    logic [DATA_WIDTH-1:0] immediate_value;         // Sign-extended immediate
    
    //==========================================================================
    // MODPORTS FOR DIFFERENT STAGES
    //==========================================================================
    
    // Issue stage perspective (master)
    modport issue (
        output dispatch_valid,
        input  dispatch_ready,
        output control_signals,
        output pc,
        output pc_value_at_prediction,
        output branch_sel,
        output branch_prediction,
        output operand_a_phys_addr,
        output operand_b_phys_addr,
        output rd_phys_addr,
        output rd_arch_addr,
        output alloc_tag,
        output immediate_value
    );
    
    // Dispatch stage perspective (slave)
    modport dispatch (
        input  dispatch_valid,
        output dispatch_ready,
        input  control_signals,
        input  pc,
        input  pc_value_at_prediction,
        input  branch_sel,
        input  branch_prediction,
        input  operand_a_phys_addr,
        input  operand_b_phys_addr,
        input  rd_phys_addr,
        input  rd_arch_addr,
        input  alloc_tag,
        input  immediate_value
    );

endinterface