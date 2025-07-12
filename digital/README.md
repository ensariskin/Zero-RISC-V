# RV32I Digital Implementation

This directory contains the complete SystemVerilog implementation of the RISC-V RV32I pipelined processor. The design follows a standard 5-stage pipeline architecture with comprehensive hazard handling and data forwarding mechanisms.

## Directory Organization

### modules/

The modules directory contains SystemVerilog implementations organized by functionality:

- **digital_top/**: Top-level processor integration
  - Complete processor instantiation and interconnection

- **common/**: Reusable design components  
  - Parameterized multiplexers, adders, and control logic
  - Standard building blocks for digital design

- **fetch_stage/**: Instruction Fetch stage implementation
  - Program counter control and branch prediction
  - Instruction memory interface

- **decode_stage/**: Instruction Decode stage implementation
  - Complete RV32I instruction decoder
  - 32-entry register file with dual read ports
  - Control signal generation logic

- **execute/**: Execute stage implementation
  - Arithmetic Logic Unit with full RV32I operation support
  - Branch condition evaluation unit
  - Address calculation logic

- **mem/**: Memory Access stage implementation
  - Data memory interface logic
  - Load/store operation handling
  - Memory alignment and control

- **write_back/**: Write Back stage implementation
  - Result multiplexing and write-back control
  - Register file write enable generation

- **pipeline_register/**: Inter-stage pipeline registers
  - IF/ID, ID/EX, EX/MEM, and MEM/WB registers
  - Pipeline control signal propagation

- **hazard/**: Pipeline hazard management
  - Data forwarding unit implementation
  - Hazard detection and stall control
  - Pipeline dependency resolution

### sim/

Simulation environment and configuration files:

- **processor.f**: Complete file list for compilation
- **risc_v.dpf**: DSim project configuration
- **run/**: Simulation execution directory
  - Build artifacts and intermediate files
  - Compilation and simulation logs

- **waves/**: Waveform output directory
  - VCD files for timing analysis
  - Signal trace files for debugging

### testbench/

Comprehensive verification infrastructure:

- **tests/**: SystemVerilog testbenches
  - Full processor verification testbench
  - Individual component test modules
  - Functional and timing verification

- **hex/**: Test program memory images
  - Instruction memory initialization files
  - Comprehensive test case coverage
  - Specialized validation programs

## Implementation Architecture

The processor implements a classic 5-stage RISC-V pipeline:

1. **Instruction Fetch (IF)**: Program counter management and instruction retrieval
2. **Instruction Decode (ID)**: Instruction decoding and register file access  
3. **Execute (EX)**: ALU operations and branch condition evaluation
4. **Memory Access (MEM)**: Data memory interface and load/store execution
5. **Write Back (WB)**: Register file update and result selection

## Hazard Handling

The design incorporates comprehensive hazard management:

- **Data Forwarding**: Hardware-based resolution of read-after-write hazards
- **Load-Use Detection**: Automatic stall insertion for load-use dependencies  
- **Control Hazard Mitigation**: Branch prediction infrastructure support
- **Structural Hazard Avoidance**: Pipeline resource conflict prevention

## File Organization

Each module directory contains:
- Source SystemVerilog files (.sv)
- File list for compilation (.f)
- Module-specific documentation
- Individual test cases where applicable
