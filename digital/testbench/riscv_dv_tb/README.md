# RV32I Core RISC-V DV Testbench

This directory contains a modern SystemVerilog testbench for the RV32I core with Wishbone interfaces and execution tracing capability, designed for integration with RISC-V DV verification framework.

## Features

- **Wishbone Interface**: Adapter modules to convert the core's simple memory interface to Wishbone for compatibility with standard memory models
- **Execution Tracing**: Comprehensive trace generation compatible with RISC-V DV framework for instruction-by-instruction verification
- **Memory Models**: Dual-port Wishbone memory models for instruction and data memory with configurable size
- **Test Program Loading**: Support for hex file loading with multiple methods (command line arguments, RISC-V DV integration)
- **Test Completion Detection**: Automated test completion via ECALL detection or test signature writes

## File Structure

```
riscv_dv_tb/
├── dv_top.sv                    # Main testbench module
├── rv32i_inst_wb_adapter.sv     # Instruction memory Wishbone adapter
├── rv32i_data_wb_adapter.sv     # Data memory Wishbone adapter  
├── rv32i_tracer.sv              # Tracer adapter for core signals
├── rv32i_dv_tb.f                # File list for simulation
└── README.md                    # This file
```

## Usage

### Basic Simulation

```bash
# Compile and run with default test
<simulator> -f rv32i_dv_tb.f

# Load a specific hex file
<simulator> -f rv32i_dv_tb.f +load_hex +hex_file=test_program.hex

# Set maximum simulation cycles
<simulator> -f rv32i_dv_tb.f +max_cycles=50000
```

### RISC-V DV Integration

```bash  
# For RISC-V DV generated tests
<simulator> -f rv32i_dv_tb.f +riscv_dv_test +test_hex=generated_test.hex
```

### Test Completion

The testbench automatically detects test completion via:
1. **ECALL instruction** (0x00000073) - Standard test termination
2. **Test signature writes** to address 0xF0000000 - RISC-V compliance test style
3. **Timeout** - Configurable via +max_cycles plusarg

## Memory Map

- **Instruction Memory**: 0x00001000 - 0x0000FFFF (64KB)
- **Data Memory**: 0x10000000 - 0x1000FFFF (64KB) 
- **Test Signature**: 0xF0000000 (for compliance tests)

## Trace Output

Execution traces are written to `trace.log` in RISC-V DV compatible format:
```
0x00001000 (0x00100093) x1  0x00000001
0x00001004 (0x00200113) x2  0x00000002  
0x00001008 (0xfe208ce3) 
```

## Dependencies

- SystemVerilog 2012 compatible simulator
- Core modules from `../../modules/`
- Memory models from `../tb_modules/`
- RISC-V test programs in hex format
