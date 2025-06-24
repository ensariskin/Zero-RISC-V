# RV32I Digital Design Files

This directory contains the core implementation files for the RISC-V RV32I pipelined processor. The design is implemented in SystemVerilog and follows a standard 5-stage pipeline architecture (Fetch, Decode, Execute, Memory, Writeback).

## Directory Structure

### modules/

The `modules` directory contains the implementation of individual processor components organized by pipeline stage and functionality:

- **digital_top/**: Top-level integration of all modules
  - Contains `TOP_Pipelined_design.sv` which instantiates and connects all processor components

- **common/**: Reusable building blocks used throughout the design
  - Basic components like multiplexers, adders, and flip-flops
  - Parameterized designs for flexibility and reuse

- **fetch_stage/**: Instruction Fetch (IF) stage components
  - Program counter implementation and control
  - Branch predictor
  - Early-stage immediate value decoder

- **decode_stage/**: Instruction Decode (ID) stage components
  - RV32I instruction decoder
  - Register file
  - Control signal generation

- **execute/**: Execute (EX) stage components
  - ALU and functional units
  - Branch condition evaluation
  - Arithmetic, logical, and shifting units

- **mem/**: Memory Access (MEM) stage components
  - Memory interfacing logic
  - Address calculation
  - Data alignment

- **write_back/**: Write Back (WB) stage components
  - Write-back data selection logic
  - Register write control

- **pipeline_register/**: Pipeline registers between stages
  - IF/ID, ID/EX, EX/MEM, and MEM/WB pipeline registers
  - Pipeline state and control signal propagation

- **hazard/**: Pipeline hazard handling logic
  - Data forwarding unit
  - Hazard detection unit
  - Pipeline stall control

### sim/

The `sim` directory contains simulation-related files and configuration:

- **processor.f**: File list for simulation
- **risc_v.dpf**: DSim project file with simulation configurations
- **run/**: Directory containing simulation run artifacts
  - Simulation logs
  - Compiler logs
  - Intermediate files

- **waves/**: Directory for waveform output files
  - Contains VCD files for waveform visualization

### testbench/

The `testbench` directory contains verification-related files:

- **tests/**: Testbench files for various components
  - Pipeline_tb.v: Full pipeline processor testbench
  - Component-specific testbenches (RegisterFile_tb.v, PC_tb.v, etc.)
  - Coverage and verification logic

- **hex/**: Memory initialization files
  - Instruction memory initialization files
  - Data memory initialization files
  - Specialized test case memory files

## Design and Simulation Flow

1. Individual modules are implemented in their respective directories
2. The `rv32i_core.sv` integrates all modules into a complete processor
3. Testbenches in the `testbench` directory verify functionality
4. The simulation configuration in `sim` directory runs the testbenches
5. Waveforms are generated in the `waves` directory for analysis

## File Lists (.f files)

Each module directory contains a `.f` file (e.g., `common.f`, `execute.f`) that lists all source files in that module. These are included by the main `processor.f` file to build the complete design.

## Pipeline Design

The processor implements a standard 5-stage RISC-V pipeline:

1. **Fetch Stage**: Retrieves instructions from memory and implements branch prediction
2. **Decode Stage**: Decodes instructions, reads register values, and generates control signals
3. **Execute Stage**: Performs ALU operations, branch condition evaluation, and address calculation
4. **Memory Stage**: Handles memory access operations (load/store)
5. **Writeback Stage**: Writes results back to the register file

The design includes hazard detection and data forwarding to handle pipeline hazards and dependencies.
