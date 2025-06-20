# Instruction Decode (ID) Stage

The Instruction Decode (ID) stage is responsible for decoding instructions, reading register values, and generating control signals. All components in this stage use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### ID.v

Top-level module for the Instruction Decode stage that integrates all ID components.

### Instruction_decoder.v

Decodes RISC-V instructions to:
- Determine instruction type (R, I, S, B, U, J)
- Generate control signals for each instruction
- Identify register addresses (rs1, rs2, rd)
- Select appropriate ALU operation
- Extract information for branch control

### RegisterFile.v

The register file contains 32 general-purpose registers (x0-x31) with:
- Two read ports for sourcing operands
- One write port for the Write Back stage
- x0 hardwired to zero as per RISC-V specification
- Synchronous write and asynchronous read capabilities

## Operation

1. The Instruction_decoder extracts register addresses and generates control signals
2. The RegisterFile reads values from the specified source registers
3. Immediate values from the IF stage are used when needed
4. Control signals and register values are passed to the ID/EX pipeline register

## Key Features

- Register file bypass logic for handling write-read dependencies
- Immediate value handling for various instruction types
- Bubble insertion for hazard handling
- Control signal generation for the entire pipeline
