# Top-Level Design

This directory contains the top-level module for the RISC-V RV32I pipelined processor. All components use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### TOP_Pipelined_design.v

The top-level integration module that:
- Connects all pipeline stages
- Integrates hazard handling components
- Manages pipeline control signals
- Interfaces with external memory
- Coordinates the overall pipeline operation

## Architecture

The TOP_Pipelined_design.v integrates the following major components:

1. **Pipeline Stages**:
   - Instruction Fetch (IF)
   - Instruction Decode (ID)
   - Execute (EX)
   - Memory Access (MEM)
   - Write Back (WB)

2. **Pipeline Registers**:
   - IF_ID: Between Fetch and Decode stages
   - ID_EX: Between Decode and Execute stages
   - EX_MEM: Between Execute and Memory stages
   - MEM_WB: Between Memory and Write Back stages

3. **Hazard Handling**:
   - Data_Forward: Resolves data hazards through forwarding
   - Hazard_Detection: Identifies and handles pipeline stalls

## Interface

The top module has the following external interfaces:

- **Clock and Reset**:
  - `clk`: System clock
  - `reset`: Asynchronous reset

- **Instruction Memory Interface**:
  - `instruction_i`: Instruction input from memory
  - `ins_address`: Address to instruction memory

- **Data Memory Interface**:
  - `MEM_result_i`: Data input from memory
  - `RAM_DATA_o`: Data output to memory
  - `RAM_Addr_o`: Address output to memory
  - `RAM_DATA_control`: Data width and sign control
  - `RAM_rw`: Read/write control signal

## Signal Flow

The TOP_Pipelined_design.v manages the flow of:
- Instructions through the pipeline stages
- Data between register file and memory
- Control signals for each stage
- Hazard detection and resolution signals
- Branch prediction and correction signals

## Integration Points

This module serves as the critical integration point for:
- Connecting pipeline stages in sequence
- Establishing bypass paths for data forwarding
- Managing pipeline stalling for hazards
- Handling branch misprediction recovery
