`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: cdb_if
//
// Description:
//     This interface defines the Common Data Bus (CDB) for broadcasting results
//     between 3 reservation stations in a superscalar RISC-V processor implementing
//     the Tomasulo algorithm. Each RS can broadcast results and listen for results
//     from other RSs to resolve dependencies.
//
// Features:
//     - 3-way result broadcasting (one per ALU/RS)
//     - Tag-based dependency resolution
//     - Physical register address broadcasting
//     - Valid/ready signaling for each broadcast channel
//////////////////////////////////////////////////////////////////////////////////

interface cdb_if #(
    parameter DATA_WIDTH = 32,
    parameter PHYS_REG_ADDR_WIDTH = 6
);
    // CDB Channel 0 (from RS/ALU 0)
    logic cdb_valid_0;                              // Valid result on channel 0
    logic [1:0] cdb_tag_0;                          // Tag for channel 0 (2'b00 = ALU0)
    logic [DATA_WIDTH-1:0] cdb_data_0;              // Result data from ALU 0
    logic [PHYS_REG_ADDR_WIDTH-1:0] cdb_dest_reg_0; // Destination physical register
    
    // CDB Channel 1 (from RS/ALU 1)
    logic cdb_valid_1;                              // Valid result on channel 1
    logic [1:0] cdb_tag_1;                          // Tag for channel 1 (2'b01 = ALU1)
    logic [DATA_WIDTH-1:0] cdb_data_1;              // Result data from ALU 1
    logic [PHYS_REG_ADDR_WIDTH-1:0] cdb_dest_reg_1; // Destination physical register
    
    // CDB Channel 2 (from RS/ALU 2)
    logic cdb_valid_2;                              // Valid result on channel 2
    logic [1:0] cdb_tag_2;                          // Tag for channel 2 (2'b10 = ALU2)
    logic [DATA_WIDTH-1:0] cdb_data_2;              // Result data from ALU 2
    logic [PHYS_REG_ADDR_WIDTH-1:0] cdb_dest_reg_2; // Destination physical register

    // CDB Channel 3 (from LSQ)
    logic cdb_valid_3;                              // Valid result on channel 2
    logic [1:0] cdb_tag_3;                          // Tag for channel 2 (2'b10 = ALU2)
    logic [DATA_WIDTH-1:0] cdb_data_3;              // Result data from ALU 2
    logic [PHYS_REG_ADDR_WIDTH-1:0] cdb_dest_reg_3; // Destination physical register
    
    // Modport for Reservation Station 0 (can broadcast on channel 0, listen to all)
    modport rs0 (
        // Broadcasting (RS0 → CDB)
        output cdb_valid_0,
        output cdb_tag_0,
        output cdb_data_0,
        output cdb_dest_reg_0,
        
        // Listening (CDB → RS0)
        input  cdb_valid_1,
        input  cdb_tag_1,
        input  cdb_data_1,
        input  cdb_dest_reg_1,
        input  cdb_valid_2,
        input  cdb_tag_2,
        input  cdb_data_2,
        input  cdb_dest_reg_2,
        input  cdb_valid_3,
        input  cdb_tag_3,
        input  cdb_data_3,
        input  cdb_dest_reg_3
    );
    
    // Modport for Reservation Station 1 (can broadcast on channel 1, listen to all)
    modport rs1 (
        // Broadcasting (RS1 → CDB)
        output cdb_valid_1,
        output cdb_tag_1,
        output cdb_data_1,
        output cdb_dest_reg_1,
        
        // Listening (CDB → RS1)
        input  cdb_valid_0,
        input  cdb_tag_0,
        input  cdb_data_0,
        input  cdb_dest_reg_0,
        input  cdb_valid_2,
        input  cdb_tag_2,
        input  cdb_data_2,
        input  cdb_dest_reg_2,
        input  cdb_valid_3,
        input  cdb_tag_3,
        input  cdb_data_3,
        input  cdb_dest_reg_3
    );
    
    // Modport for Reservation Station 2 (can broadcast on channel 2, listen to all)
    modport rs2 (
        // Broadcasting (RS2 → CDB)
        output cdb_valid_2,
        output cdb_tag_2,
        output cdb_data_2,
        output cdb_dest_reg_2,
        
        // Listening (CDB → RS2)
        input  cdb_valid_0,
        input  cdb_tag_0,
        input  cdb_data_0,
        input  cdb_dest_reg_0,
        input  cdb_valid_1,
        input  cdb_tag_1,
        input  cdb_data_1,
        input  cdb_dest_reg_1,
        input  cdb_valid_3,
        input  cdb_tag_3,
        input  cdb_data_3,
        input  cdb_dest_reg_3
    );

    modport lsq (
        // Broadcasting (LSQ → CDB)
        output cdb_valid_3,
        output cdb_tag_3,
        output cdb_data_3,
        output cdb_dest_reg_3,
        
        // Listening (CDB → LSQ)
        input  cdb_valid_0,
        input  cdb_tag_0,
        input  cdb_data_0,
        input  cdb_dest_reg_0,
        input  cdb_valid_1,
        input  cdb_tag_1,
        input  cdb_data_1,
        input  cdb_dest_reg_1,
        input  cdb_valid_2,
        input  cdb_tag_2,
        input  cdb_data_2,
        input  cdb_dest_reg_2
    );
    
    // Modport for Register File (listens to all channels for writeback)
    modport register_file (
        input  cdb_valid_0,
        input  cdb_tag_0,
        input  cdb_data_0,
        input  cdb_dest_reg_0,
        input  cdb_valid_1,
        input  cdb_tag_1,
        input  cdb_data_1,
        input  cdb_dest_reg_1,
        input  cdb_valid_2,
        input  cdb_tag_2,
        input  cdb_data_2,
        input  cdb_dest_reg_2,
        input  cdb_valid_3,
        input  cdb_tag_3,
        input  cdb_data_3,
        input  cdb_dest_reg_3
    );

endinterface