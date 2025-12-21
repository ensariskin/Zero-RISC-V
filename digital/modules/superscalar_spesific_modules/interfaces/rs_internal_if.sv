`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Interface: rs_internal_if
//
// Description:
//     Interface for RS internal register monitoring and validation.
//     Used between Reservation Station and RS Validator for TMR.
//
// Signals:
//     - RS → Validator (output modport): Raw internal register values
//     - Validator → RS (input modport): Validated values for secure mode
//////////////////////////////////////////////////////////////////////////////////

interface rs_internal_if #(
      parameter DATA_WIDTH = 32,
      parameter PHYS_REG_ADDR_WIDTH = 6
   );

   //==========================================================================
   // RS Internal Registers (RS → Validator for voting)
   //==========================================================================
   logic        enable;
   logic        occupied;
   logic [10:0] control_signals;
   logic [DATA_WIDTH-1:0] pc;
   logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr;
   logic [DATA_WIDTH-1:0] pc_value_at_prediction;
   logic [2:0]  branch_sel;
   logic        branch_prediction;
   logic [DATA_WIDTH-1:0] store_data;
   logic [DATA_WIDTH-1:0] operand_a_data;
   logic [2:0]  operand_a_tag;
   logic [DATA_WIDTH-1:0] operand_b_data;
   logic [2:0]  operand_b_tag;

   //==========================================================================
   // Validated Values (Validator → RS for secure mode)
   //==========================================================================
   logic        validated_enable;
   logic        validated_occupied;
   logic [10:0] validated_control_signals;
   logic [DATA_WIDTH-1:0] validated_pc;
   logic [PHYS_REG_ADDR_WIDTH-1:0] validated_rd_phys_addr;
   logic [DATA_WIDTH-1:0] validated_pc_value_at_prediction;
   logic [2:0]  validated_branch_sel;
   logic        validated_branch_prediction;
   logic [DATA_WIDTH-1:0] validated_store_data;
   logic [DATA_WIDTH-1:0] validated_operand_a_data;
   logic [2:0]  validated_operand_a_tag;
   logic [DATA_WIDTH-1:0] validated_operand_b_data;
   logic [2:0]  validated_operand_b_tag;

   //==========================================================================
   // Modports
   //==========================================================================

   // RS side: outputs raw values, receives validated values
   modport reservation_station (
      output enable,
      output occupied,
      output control_signals,
      output pc,
      output rd_phys_addr,
      output pc_value_at_prediction,
      output branch_sel,
      output branch_prediction,
      output store_data,
      output operand_a_data,
      output operand_a_tag,
      output operand_b_data,
      output operand_b_tag,
      input  validated_enable,
      input  validated_occupied,
      input  validated_control_signals,
      input  validated_pc,
      input  validated_rd_phys_addr,
      input  validated_pc_value_at_prediction,
      input  validated_branch_sel,
      input  validated_branch_prediction,
      input  validated_store_data,
      input  validated_operand_a_data,
      input  validated_operand_a_tag,
      input  validated_operand_b_data,
      input  validated_operand_b_tag
   );

   // Validator side: receives raw values, outputs validated values
   modport validator (
      input  enable,
      input  occupied,
      input  control_signals,
      input  pc,
      input  rd_phys_addr,
      input  pc_value_at_prediction,
      input  branch_sel,
      input  branch_prediction,
      input  store_data,
      input  operand_a_data,
      input  operand_a_tag,
      input  operand_b_data,
      input  operand_b_tag,
      output validated_enable,
      output validated_occupied,
      output validated_control_signals,
      output validated_pc,
      output validated_rd_phys_addr,
      output validated_pc_value_at_prediction,
      output validated_branch_sel,
      output validated_branch_prediction,
      output validated_store_data,
      output validated_operand_a_data,
      output validated_operand_a_tag,
      output validated_operand_b_data,
      output validated_operand_b_tag
   );

endinterface
