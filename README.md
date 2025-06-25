# RISC-V RV32I Pipelined Processor

This repository contai│   ├── common/                   # Common components
│       └── src/
│           ├── parametric_mux.sv
│           ├── parametric_decoder.sv
│           ├── dff_block_negedge_write.sv # Renamed flip-flop block
│           ├── dff_sync_reset_negedge_write.sv # New flip-flop variant
│           ├── RCA.sv             # Ripple Carry Adder
│           ├── CSA.sv             # Carry Save Adder
│           ├── FA.sv              # Full Adder
│           └── HA.sv              # Half Adderplementation of a 5-stage pipelined processor based on the RISC-V RV32I instruction set architecture. The design is implemented in SystemVerilog and optimized for performance and area efficiency while supporting the complete RV32I base instruction set.

## Project Structure

The project is organized according to the processor's design hierarchy:

```
digital/
├── modules/
│   ├── digital_top/              # Top-level integration
│   │   └── src/
│   │       └── rv32i_core.sv     # Top-level processor core module
│   │
│   ├── fetch_stage/              # Instruction Fetch (IF) stage
│   │   └── src/
│   │       ├── fetch_stage.sv    # Top-level fetch stage module
│   │       ├── program_counter_ctrl.sv  # Enhanced program counter with improved JALR and AUIPC support
│   │       ├── branch_predictor.sv      # Branch prediction logic
│   │       └── early_stage_immediate_decoder.sv  # Immediate decoder
│   │
│   ├── decode_stage/            # Instruction Decode (ID) stage
│   │   └── src/
│   │       ├── decode_stage.sv
│   │       ├── rv32i_decoder.sv
│   │       └── RegisterFile.sv
│   │
│   ├── execute/                  # Execute (EX) stage
│   │   └── src/
│   │       ├── execute_stage.sv  # Top-level execute stage module (renamed from EX.v)
│   │       ├── function_unit_alu_shifter.sv # Unified functional unit (replaces FU.sv)
│   │       ├── alu.sv            # Modernized ALU (renamed from ALU.sv)
│   │       ├── arithmetic_unit.sv
│   │       ├── logical_unit.sv
│   │       ├── shifter.sv
│   │       └── Branch_Controller.sv
│   │
│   ├── mem/                      # Memory Access (MEM) stage
│   │   └── src/
│   │       └── MEM.sv            # Memory stage module
│   │
│   ├── write_back/               # Write Back (WB) stage
│   │   └── src/
│   │       └── WB.sv             # Write Back stage module
│   │
│   ├── pipeline_register/        # Pipeline registers
│   │   └── src/
│   │       ├── if_to_id.sv       # Pipeline registers (renamed for consistency)
│   │       ├── id_to_ex.sv
│   │       ├── ex_to_mem.sv
│   │       └── mem_to_wb.sv
│   │
│   ├── hazard/                   # Pipeline hazard handling
│   │   └── src/
│   │       ├── Data_Forward.sv   # Data forwarding unit
│   │       └── hazard_detection_unit.sv # Hazard detection (renamed)
│   │
│   └── common/                   # Common components
│       └── src/
│           ├── parametric_mux.v
│           ├── D_FF_block.v
│           ├── dff_block.v
│           ├── RCA.v             # Ripple Carry Adder
│           ├── CSA.v             # Carry Save Adder
│           ├── FA.v              # Full Adder
│           └── HA.v              # Half Adder
│
├── testbench/                    # Testbenches
│   └── tb/
│       ├── Pipeline_tb.v
│       ├── RegisterFile_tb.v
│       ├── PC_tb.v
│       └── [...other testbenches]
│
└── sim/                          # Simulation files
    └── [...simulation scripts and results]

doc/
├── Schematic.pdf                # Architecture schematic
└── RISCV technical notes.xlsx   # Technical documentation
```

## Design Overview

This project implements a 5-stage pipelined RISC-V RV32I processor with the following key features:

### Pipeline Stages

1. **Instruction Fetch (IF)**: Fetches instructions from memory and includes branch prediction capability
2. **Instruction Decode (ID)**: Decodes instructions and reads register values
3. **Execute (EX)**: Performs ALU operations, branch calculations, and address generation
4. **Memory (MEM)**: Handles memory access operations (load/store)
5. **Write Back (WB)**: Writes results back to the register file

### Pipeline Hazard Handling

- **Data Forwarding**: Resolves data hazards by forwarding results from later pipeline stages to earlier ones
- **Hazard Detection**: Detects and handles hazards that cannot be resolved by forwarding
- **Branch Prediction**: Reduces branch penalties by predicting branch outcomes

### Special Components

- **program_counter_ctrl.sv**: Enhanced program counter with improved JALR handling, AUIPC support, and branch prediction capability
- **branch_predictor.sv**: Predicts branch outcomes to minimize pipeline stalls
- **function_unit_alu_shifter.sv**: Unified execution unit for arithmetic, logical, and shift operations
- **Data_Forward.sv**: Implements data forwarding to reduce data hazards
- **hazard_detection_unit.sv**: Detects and handles pipeline hazards

## Implementation Details

### Program Counter Implementation

The project now uses a unified enhanced program counter implementation:

- **program_counter_ctrl.sv**: Modern SystemVerilog implementation with:
  - Branch prediction support
  - Enhanced JALR instruction handling with additional prediction path
  - AUIPC instruction support
  - Branch misprediction recovery with improved logic
  - Pipeline stall capabilities
  - Optimized PC value calculation

### Function Unit Architecture

The central ALU implementation has been modernized with a consolidated approach:
- **function_unit_alu_shifter.sv**: Unified module that integrates ALU and shifter operations
- **alu.sv**: Handles all arithmetic and logical operations with improved interfaces
- **arithmetic_unit.sv**: Handles addition, subtraction, and comparison with enhanced signed/unsigned handling
- **logical_unit.sv**: Implements AND, OR, XOR, etc. with standardized interfaces
- **shifter.sv**: Performs logical and arithmetic shifts

### Memory Interface

The processor interfaces with external instruction and data memories, with support for different memory access types (byte, half-word, word) as specified by the RV32I ISA.

## Simulation and Testing

The `testbench` directory contains various test cases including:
- Basic functionality tests
- Pipeline hazard tests
- Branch and jump instruction tests
- Load/store tests

The simulation environment uses:
- **DSim Simulator**: Primary simulation tool with VCD waveform generation
- **Surfer**: Waveform viewer for analyzing simulation results
- **Timing**: All modules use a consistent timescale of `100 ps / 1 ps` for accurate simulation

## Documentation

- **Schematic.pdf**: Contains the overall architecture diagram
- **Processor_Datasheet.pdf**: Comprehensive processor documentation and specifications
- **RISCV technical notes.xlsx**: Includes technical details and implementation notes
- **Design Weakness.docx**: Documents current limitations and areas for improvement

## Development Workflow

This project uses Git for version control and GitHub for remote repository hosting:

- **Repository URL**: [https://github.com/ensariskin/Zero-RISC-V](https://github.com/ensariskin/Zero-RISC-V)
- **Main Branch**: `master` contains the stable, tested implementation
- **Issue Tracking**: Use GitHub Issues for bug reports and feature requests
- **Development Process**:
  1. Create feature branches for new development
  2. Use descriptive commit messages
  3. Submit pull requests for code review
  4. Merge only after tests pass

### Contribution Guidelines

When contributing to this project:
1. Create a branch named for your feature or fix
2. Follow the established coding style
3. Add or update tests for your changes
4. Update documentation
5. Submit a pull request with a clear description
