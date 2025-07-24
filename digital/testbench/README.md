# Verification and Testing Infrastructure

This directory contains comprehensive verification components for the RISC-V RV32I processor implementation. All testbenches utilize a standardized timescale of 100 ps / 1 ps for precise simulation timing and consistent results across different simulation environments.

## SystemVerilog Testbenches

### Pipeline_tb.v

Complete processor verification testbench providing:
- Full pipeline operation validation
- Instruction sequence execution verification
- Hazard detection and handling verification
- Data forwarding mechanism testing
- Branch prediction functionality assessment

### RegisterFile_tb.v

Register file verification testbench covering:
- Dual-port read operation verification
- Single-port write operation testing
- Concurrent read/write operation validation
- Zero register (x0) immutability verification
- Timing constraint compliance checking

### PC_tb.v

Program counter verification testbench including:
- Sequential instruction fetch verification
- Branch target address calculation testing
- Jump instruction address update validation
- Reset state initialization verification
- PC update timing requirement checking

### Controller_tb.v

Control unit verification testbench ensuring:
- Instruction decode accuracy for all RV32I instructions
- Control signal generation correctness
- ALU operation code assignment verification
- Pipeline control signal propagation testing

### Datapath_tb.v

Processor datapath verification covering:
- Inter-stage data flow validation
- ALU functional unit operation verification
- Memory interface protocol compliance
- Register file integration testing
- Pipeline register operation verification

### Single_cycle_processor_tb.v

Reference implementation testbench for:
- Single-cycle design validation
- Instruction functionality baseline testing
- Performance comparison reference

### NVRAM_tb.v

Non-volatile memory model verification including:
- Memory read/write operation validation
- Initialization sequence verification
- Access timing characteristic testing
- Data persistence verification

## Test Program Memory Images

### Core Test Programs

- **init_ins.hex**: Primary instruction memory initialization containing comprehensive instruction testing sequences
- **init_data.hex**: Data memory initialization for load/store operation validation

### Specialized Verification Programs

- **init_ins_branches.hex**: Branch instruction comprehensive testing including conditional and unconditional branches
- **init_ins_jump.hex**: Jump instruction verification covering JAL and JALR operations
- **init_ins_jalr.hex**: Jump-and-link-register specific instruction testing
- **init_ins_raw_error.hex**: Read-after-write hazard detection and handling verification
- **init_ins_load_use_hazard.hex**: Load-use hazard detection and pipeline stall verification
- **init_ins_structural_error.hex**: Structural hazard detection and resource conflict handling

## Verification Methodology

Testbench execution follows standardized verification procedures:

1. **Design Under Test Initialization**: Reset sequence and initial state establishment
2. **Stimulus Application**: Test vector application according to verification plan
3. **Output Monitoring**: Continuous monitoring of processor outputs and internal signals
4. **Timing Verification**: Clock edge timing and setup/hold time validation
5. **Result Analysis**: Automated checking and manual inspection of simulation results
6. **Coverage Analysis**: Functional and code coverage assessment

## Simulation Environment

### Primary Simulation Platform
- **DSim Simulator**: Primary simulation environment with advanced debugging capabilities
- **Waveform Generation**: VCD format output for comprehensive signal analysis
- **Surfer Waveform Viewer**: Integrated waveform analysis and debugging tool

### Simulation Configuration
- **Project File**: risc_v.dpf contains complete simulation configuration
- **Timescale Standard**: 100 ps / 1 ps across all verification components
- **Memory Models**: Behavioral memory models for instruction and data storage

### Alternative Simulation Support
- ModelSim/QuestaSim compatibility
- Vivado Simulator support
- Synopsys VCS compatibility
- Open-source Icarus Verilog support

## Fault Injection Utility

`fault_injector.sv` provides a simple mechanism to inject transient faults into
a user defined list of signals. The list of target signals lives in
`include/fault_target_list.svh` where each signal is aliased to a slot in the
`fi_targets` array. Extend this file to inject faults into additional signals.
The injector can be instantiated or bound to the testbench and configured via
plusargs.

### Usage Example

```bash
dsim +fi_seed=42 +fi_interval=5000 \
     -timescale 1ns/1ns -top work.dv_top -F digital/sim/processor.f
```

Parameters:

- `fi_seed`       – Random seed for fault generation.
- `fi_interval`   – Number of cycles between fault injections.

The `fi_targets` array defined in `fault_target_list.svh` aliases the DUT
signals to be affected. Edit this file to add or remove fault injection points
and update `NUM_FAULT_TARGETS` accordingly.
