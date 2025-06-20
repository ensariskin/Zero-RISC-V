# RISC-V RV32I Pipelined Processor

This repository contains the implementation of a 5-stage pipelined processor based on the RISC-V RV32I instruction set architecture. The design is optimized for performance and area efficiency while supporting the complete RV32I base instruction set.

## Project Structure

The project is organized according to the processor's design hierarchy:

```
digital/
├── modules/
│   ├── digital_top/              # Top-level integration
│   │   └── src/
│   │       └── TOP_Pipelined_design.v
│   │
│   ├── instruction_fetch/        # Instruction Fetch (IF) stage
│   │   └── src/
│   │       ├── IF.v
│   │       ├── PC_new.v          # Enhanced program counter with branch prediction
│   │       ├── PC.v              # Basic program counter
│   │       ├── Branch_predictor.v
│   │       └── ES_IMM_Decoder.v
│   │
│   ├── instruction_decode/       # Instruction Decode (ID) stage
│   │   └── src/
│   │       ├── ID.v
│   │       ├── Instruction_decoder.v
│   │       └── RegisterFile.v
│   │
│   ├── execute/                  # Execute (EX) stage
│   │   └── src/
│   │       ├── EX.v
│   │       ├── FU.v              # Functional Unit (main ALU)
│   │       ├── arithmetic_unit.v
│   │       ├── logical_unit.v
│   │       ├── shifter.v
│   │       ├── Branch_Controller.v
│   │       └── Zero_comparator.v
│   │
│   ├── mem/                      # Memory Access (MEM) stage
│   │   └── src/
│   │       └── MEM.v
│   │
│   ├── write_back/               # Write Back (WB) stage
│   │   └── src/
│   │       └── WB.v
│   │
│   ├── pipeline_register/        # Pipeline registers
│   │   └── src/
│   │       ├── IF_ID.v
│   │       ├── ID_EX.v
│   │       ├── EX_MEM.v
│   │       └── MEM_WB.v
│   │
│   ├── hazard/                   # Pipeline hazard handling
│   │   └── src/
│   │       ├── Data_Forward.v    # Data forwarding unit
│   │       └── Hazard_Detection.v
│   │
│   └── common/                   # Common components
│       └── src/
│           ├── parametric_mux.v
│           ├── D_FF_block.v
│           ├── new_DFF_block.v
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

- **PC_new.v**: Enhanced program counter with branch prediction support, JALR instruction handling, and pipeline stall capability
- **Branch_predictor.v**: Predicts branch outcomes to minimize pipeline stalls
- **Data_Forward.v**: Implements data forwarding to reduce data hazards
- **Hazard_Detection.v**: Detects and handles pipeline hazards

## Implementation Details

### PC Implementation (PC_new.v vs PC.v)

The project includes two PC implementations:

- **PC.v**: Basic program counter that increments by 4 or takes branch targets
- **PC_new.v**: Enhanced PC with:
  - Branch prediction support
  - JALR instruction handling
  - Branch misprediction recovery
  - Pipeline stall capabilities

### Functional Unit (FU.v)

The central ALU implementation supports all RV32I arithmetic and logical operations through:
- **arithmetic_unit.v**: Handles addition, subtraction, and comparison
- **logical_unit.v**: Implements AND, OR, XOR, etc.
- **shifter.v**: Performs logical and arithmetic shifts

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
