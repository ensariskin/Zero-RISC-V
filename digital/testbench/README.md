# Testbench Components

This directory contains testbench files used to verify the functionality of the RISC-V RV32I processor design. All testbenches use a standardized timescale of `100 ps / 1 ps` for consistent and accurate simulation results.

## Test Files

### Pipeline_tb.v

Comprehensive testbench for the complete pipelined processor that:
- Verifies the entire pipeline operation
- Tests various instruction sequences
- Validates hazard handling mechanisms
- Checks branch prediction functionality

### RegisterFile_tb.v

Testbench for the register file that:
- Verifies read and write operations
- Tests concurrent read/write behavior
- Validates that x0 remains zero
- Checks timing requirements

### PC_tb.v

Program Counter testbench that:
- Tests normal PC increment operation
- Verifies branch and jump behavior
- Validates reset functionality
- Checks PC update timing

### Controller_tb.v

Tests the control unit to ensure:
- Proper control signal generation for all instructions
- Correct handling of different instruction formats
- Appropriate ALU operation selection

### Datapath_tb.v

Verifies the processor datapath:
- Tests data flow through all pipeline stages
- Validates ALU operations
- Checks memory interface operation
- Verifies register file integration

### Single_cycle_processor_tb.v

Reference testbench for the single-cycle design:
- Provides comparison baseline for the pipelined design
- Tests basic instruction functionality

### NVRAM_tb.v

Verifies the non-volatile memory model used in simulation:
- Tests read/write operations
- Validates memory initialization
- Checks timing characteristics

## Test Data

### init_ins.hex

Primary instruction memory initialization file containing a test program.

### init_data.hex

Data memory initialization file for testing load/store operations.

### Specialized Test Files

- **init_ins_branches.hex**: Tests branch instruction functionality
- **init_ins_jump.hex**: Tests jump instruction functionality
- **init_ins_jalr.hex**: Tests jump-and-link-register functionality
- **init_ins_raw_error.hex**: Tests Read-After-Write hazard handling
- **init_ins_load_use_hazard.hex**: Tests load-use hazard handling
- **init_ins_structural_error.hex**: Tests structural hazard handling

## Test Methodology

The testbenches follow these general steps:
1. Initialize the design under test
2. Apply stimulus according to test scenario
3. Monitor outputs for correctness
4. Verify timing requirements
5. Report test results

## Running Tests

Simulation is primarily performed using DSim:
- **DSim Simulator**: Main simulation environment with VCD waveform generation
- **Surfer**: Waveform viewer for analyzing simulation results
- **Simulation Configuration**: Configuration is specified in `risc_v.dpf`
- **Timescale**: All testbenches use consistent `100 ps / 1 ps` timescale

Additional supported simulators include:
- ModelSim/QuestaSim
- Vivado Simulator
- VCS
- Icarus Verilog
