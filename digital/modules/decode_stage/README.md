# Decode Stage

The Decode Stage is responsible for interpreting instructions, reading register values, and generating control signals for the execution pipeline. This stage represents the second phase of the RISC-V 5-stage pipeline.

## Components

### decode_stage.sv

Top-level module for the Decode Stage that integrates the instruction decoder, register file, and control signal generation:
- Processes instructions from the fetch stage
- Reads register values
- Controls operand forwarding
- Generates control signals for subsequent pipeline stages
- Handles bubble insertion for hazard handling

### rv32i_decoder.sv

RISC-V instruction decoder that:
- Parses RV32I instruction formats
- Identifies instruction types (R, I, S, B, U, J)
- Extracts register addresses
- Generates control signals for execution units
- Determines branch type and memory operation type
- Sets up data path configurations for different instructions

### RegisterFile.sv

Register file implementation that:
- Stores 32 general-purpose registers (x0-x31)
- Provides two read ports for operand access
- Handles write-back from the WB stage
- Maintains x0 as hardwired zero

## Operation

1. The instruction from the IF/ID pipeline register is decoded by the rv32i_decoder
2. Register addresses are extracted and sent to the RegisterFile
3. Register values are read from the RegisterFile
4. Control signals are generated based on the instruction type
5. All operands and control signals are passed to the ID/EX pipeline register

## Key Signals

- **Control_Signal**: A 26-bit control word containing:
  - Register addresses (RD, RA, RB)
  - ALU function select (FS)
  - Memory and register write enables
  - Operand selection controls
  - Memory type selection

- **Branch_sel**: Determines branch handling in later stages

## Features

- Support for all RV32I instruction types
- Handling of immediate values for different instruction formats
- Generation of specialized control signals for the ALU
- Support for memory access operations
- Hazard detection through "bubble" insertion
- Proper handling of JALR and branch instructions
