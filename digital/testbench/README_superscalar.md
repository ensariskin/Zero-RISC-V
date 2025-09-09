# RV32I Superscalar Core Testbench

## Overview
This testbench validates the RV32I superscalar processor core with 3-way parallel fetch and execution capabilities.

## Features
- **3-Port Instruction Memory**: Supports parallel instruction fetch from three separate addresses
- **Multi-Decode Stage**: Decodes up to 3 instructions in parallel using shared multi-port register file
- **Performance Monitoring**: Tracks IPC, fetch efficiency, branch prediction accuracy, and stall rates
- **Comprehensive Assertions**: Validates instruction alignment, memory access patterns, and performance metrics
- **Wishbone B4 Interface**: Standard bus interface for memory access
- **Coverage Collection**: Monitors instruction type coverage and performance characteristics

## File Structure
```
testbench/
├── riscv_dv_tb/
│   └── dv_top_superscalar.sv          # Main testbench top module
├── tb_modules/
│   ├── rv32i_superscalar_inst_wb_adapter.sv  # Instruction memory adapter
│   ├── rv32i_superscalar_data_wb_adapter.sv  # Data memory adapter
│   ├── memory_3rw.sv                   # 3-port instruction memory
│   ├── memory_2rw_wb.sv               # 2-port data memory with Wishbone
│   └── data_memory_selector.sv        # Memory region decoder
└── tb_modules_superscalar.f           # Filelist for superscalar testbench
```

## Memory Configuration
- **Instruction Memory**: 64KB (16K words) with 3-port simultaneous access
- **Data Memory Region 0**: 4KB (1K words) at configurable base address
- **Data Memory Region 1**: 64KB (16K words) at configurable base address
- **Default Addresses**:
  - Region 0: 0x80000000
  - Region 1: 0x80001000

## Usage

### Basic Simulation
```bash
# Using default test program
vsim -f superscalar.f dv_top_superscalar

# With custom hex file
vsim -f superscalar.f dv_top_superscalar +hex_file=my_program.hex

# With custom memory regions
vsim -f superscalar.f dv_top_superscalar +region0_base=90000000 +region1_base=90001000
```

### Simulation Parameters
- `+hex_file=<filename>`: Load custom program from hex file
- `+region0_base=<addr>`: Set Region 0 base address (hex)
- `+region1_base=<addr>`: Set Region 1 base address (hex)

## Performance Metrics
The testbench automatically tracks and reports:
- **IPC (Instructions Per Cycle)**: Should approach 3.0 for optimal superscalar performance
- **Fetch Efficiency**: Instructions fetched per cycle (up to 3.0)
- **Branch Prediction Accuracy**: Percentage of correct branch predictions
- **Buffer Stall Rate**: Percentage of cycles with instruction buffer stalls

## Assertions and Checks
- Instruction address 4-byte alignment
- Sequential fetch address progression
- Data memory access alignment validation
- Performance counter monotonicity
- Reasonable IPC bounds (≤ 3.0 for 3-way superscalar)
- Buffer stall efficiency warnings (>10% stall rate)
- Branch prediction accuracy warnings (>30% misprediction rate)

## Test Completion
Tests complete when:
- **ECALL instruction** is encountered (normal completion)
- **Timeout** occurs after 1M cycles (test failure)
- **Simulation error** is detected

## Coverage
The testbench collects coverage on:
- **Instruction Types**: R-type, I-type, S-type, B-type, U-type, J-type for all 3 fetch ports
- **Performance Ranges**: Low/medium/high IPC and fetch efficiency bins

## Default Test Program
If no hex file is specified, a simple test program is loaded:
```assembly
ADDI x1, x0, 1    # x1 = 1
ADDI x2, x1, 2    # x2 = 3
ADD  x3, x1, x2   # x3 = 4
NOP               # Pipeline filler
NOP               # Pipeline filler
NOP               # Pipeline filler
```

## Expected Performance
For an efficient 3-way superscalar implementation:
- **IPC**: 1.5-2.5 (depending on instruction dependencies)
- **Fetch Efficiency**: 2.0-3.0 instructions/cycle
- **Branch Accuracy**: >70% with basic prediction
- **Buffer Stalls**: <10% of total cycles

## Integration with Superscalar Core
The testbench interfaces with `rv32i_superscalar_core` module expecting:
- 3-port instruction interface (`inst_addr_[0:2]`, `instruction_i_[0:2]`)
- Standard data memory interface
- Performance counter outputs
- Debug interface for PC tracking
- Status signals for halt detection
