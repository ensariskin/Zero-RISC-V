# Verification and Testing Infrastructure

This directory contains comprehensive verification components for the **3-way superscalar RISC-V RV32I processor**. The testbench infrastructure supports out-of-order execution verification, branch misprediction recovery testing, and superscalar throughput validation.

## Architecture Overview

The verification environment validates:
- **3-way superscalar fetch and issue**
- **Tomasulo algorithm with register renaming**
- **32-entry ROB with in-order commit**
- **32-entry LSQ with store-to-load forwarding**
- **BRAT v2 branch recovery**
- **GShare branch prediction**

## Directory Structure

```
testbench/
├── riscv_dv_tb/              # RISC-V DV integration testbench
│   └── dv_top_superscalar.sv # Main superscalar testbench top
├── tb_modules/               # Module-level testbenches
│   ├── memory_3rw.sv         # 3-port instruction memory
│   ├── memory_2rw_wb.sv      # 2-port data memory (Wishbone)
│   ├── data_memory_selector.sv
│   └── *.sv                  # Individual module tests
├── include/                  # Testbench utilities
│   ├── fault_injector.sv    # Fault injection utility
│   └── fault_target_list.svh
├── tb_modules.f              # Legacy testbench file list
└── tb_modules_superscalar.f  # Superscalar testbench file list
```

## Superscalar Testbench Features

### dv_top_superscalar.sv

Main testbench for superscalar processor verification:

| Feature | Description |
|---------|-------------|
| **3-Port Instruction Memory** | Parallel fetch from 3 addresses per cycle |
| **Performance Monitoring** | IPC, fetch efficiency, stall rates |
| **Branch Prediction Tracking** | Prediction accuracy, misprediction count |
| **ROB Utilization** | Occupancy statistics, commit rates |
| **LSQ Monitoring** | Store-to-load forwarding, memory ordering |
| **Coverage Collection** | Instruction types, performance bins |

### Performance Metrics

The testbench automatically tracks and reports:

| Metric | Target | Description |
|--------|--------|-------------|
| **IPC** | 1.5-2.5 | Instructions Per Cycle |
| **Fetch Efficiency** | 2.0-3.0 | Instructions fetched per cycle |
| **Branch Accuracy** | >70% | Correct branch predictions |
| **Buffer Stalls** | <10% | Instruction buffer stall rate |
| **ROB Utilization** | Variable | Average ROB occupancy |

### Assertions and Checks

Comprehensive verification includes:
- Instruction address 4-byte alignment
- In-order commit sequence validation
- ROB entry consistency checks
- RAT/BRAT integrity verification
- CDB broadcast correctness
- LSQ ordering violation detection
- Store-to-load forwarding validation
- Branch target prediction accuracy

## Memory Configuration

### Instruction Memory
```
Size: 64KB (16K words)
Ports: 3 simultaneous read ports
Access: Aligned 32-bit fetch
```

### Data Memory
```
Region 0: 4KB (1K words) at 0x80000000
Region 1: 64KB (16K words) at 0x80001000
Ports: 2-port read/write with Wishbone B4
```

## Simulation Commands

### Basic Simulation
```bash
# Navigate to run directory
cd digital/sim/run

# Run superscalar simulation
dsim -f ../superscalar_new.f -top dv_top_superscalar

# With custom hex file
dsim -f ../superscalar_new.f -top dv_top_superscalar +hex_file=../hex/test.hex

# With waveform dump
dsim -f ../superscalar_new.f -top dv_top_superscalar +WAVE_DUMP=1
```

### Advanced Options
```bash
# Custom memory regions
+region0_base=90000000
+region1_base=90001000

# Performance timeout (cycles)
+timeout=1000000

# Verbose debug output
+verbose=1
```

## Test Completion Criteria

Tests complete when:
| Condition | Result |
|-----------|--------|
| `ECALL` instruction | Normal completion - pass |
| Timeout (1M cycles) | Test failure |
| `EBREAK` instruction | Debug trap |
| Simulation error | Immediate failure |

## Module-Level Testbenches

### Core Component Tests

| Testbench | Module Under Test | Description |
|-----------|-------------------|-------------|
| `rob_tb.sv` | `rob.sv` | ROB allocation, commit, flush |
| `rat_tb.sv` | `rat.sv` | Register renaming, checkpoint |
| `brat_tb.sv` | `brat_v2.sv` | Branch checkpoint, restore |
| `rs_tb.sv` | `reservation_station_priority.sv` | Issue logic, operand ready |
| `lsq_tb.sv` | `lsq_simple_top.sv` | Load/store ordering |
| `ibuf_tb.sv` | `instruction_buffer_new.sv` | FIFO operations |

### Functional Unit Tests

| Testbench | Description |
|-----------|-------------|
| `alu_tb.sv` | ALU operations for RV32I |
| `branch_tb.sv` | Branch condition evaluation |
| `memory_tb.sv` | Load/store operations |

## Coverage Model

### Instruction Type Coverage
```systemverilog
covergroup instruction_cg;
  inst_type: coverpoint instruction[6:0] {
    bins r_type = {7'b0110011};  // R-type ALU
    bins i_type = {7'b0010011};  // I-type ALU
    bins load   = {7'b0000011};  // Load
    bins store  = {7'b0100011};  // Store
    bins branch = {7'b1100011};  // Branch
    bins jal    = {7'b1101111};  // JAL
    bins jalr   = {7'b1100111};  // JALR
    bins lui    = {7'b0110111};  // LUI
    bins auipc  = {7'b0010111};  // AUIPC
  }
endgroup
```

### Performance Coverage
```systemverilog
covergroup performance_cg;
  ipc_bins: coverpoint ipc_value {
    bins low    = {[0:99]};      // IPC < 1.0
    bins medium = {[100:199]};   // IPC 1.0-2.0
    bins high   = {[200:300]};   // IPC 2.0-3.0
  }
  
  rob_util: coverpoint rob_occupancy {
    bins empty     = {[0:7]};
    bins quarter   = {[8:15]};
    bins half      = {[16:23]};
    bins full      = {[24:32]};
  }
endgroup
```

## Fault Injection

The `fault_injector.sv` provides transient fault injection for reliability testing:

### Configuration
```bash
dsim +fi_seed=42 +fi_interval=5000 \
     -timescale 1ns/1ns -top dv_top_superscalar
```

### Parameters
| Parameter | Description |
|-----------|-------------|
| `fi_seed` | Random seed for fault generation |
| `fi_interval` | Cycles between fault injections |

### Fault Targets
Edit `include/fault_target_list.svh` to define injection points:
```systemverilog
// ROB entry corruption
assign fi_targets[0] = dut.u_rob.entries[0].value;
// RAT mapping corruption
assign fi_targets[1] = dut.u_rat.mapping[1];
// CDB data corruption
assign fi_targets[2] = dut.cdb[0].data;
```

## Debug Features

### Signal Dumping
```bash
# Full waveform dump
+WAVE_DUMP=1

# Selective signal dump
+DUMP_ROB=1
+DUMP_RAT=1
+DUMP_CDB=1
```

### Runtime Monitoring
```systemverilog
// Performance counter display (every 1000 cycles)
always @(posedge clk) begin
  if (cycle_count % 1000 == 0) begin
    $display("Cycle %0d: IPC=%.2f, Commits=%0d, Mispred=%0d",
             cycle_count, ipc, total_commits, mispredictions);
  end
end
```

## Integration with RISC-V DV

The testbench integrates with [RISC-V DV](https://github.com/google/riscv-dv) for comprehensive instruction-level verification:

```bash
# Generate random tests
cd tools/riscv-dv
python3 run.py --target rv32i --test riscv_arithmetic_basic_test

# Run generated tests
cd digital/sim/run
dsim -f ../superscalar_new.f +hex_file=../../tools/riscv-dv/out/test.hex
```

## Expected Results

For the 3-way superscalar processor:

| Workload Type | Expected IPC | Notes |
|---------------|--------------|-------|
| Pure ALU | 2.5-3.0 | No dependencies |
| Mixed ALU | 1.5-2.0 | Some RAW hazards |
| Branch Heavy | 1.0-1.5 | Misprediction overhead |
| Memory Heavy | 1.0-2.0 | LSQ throughput limited |
| Complex Mix | 1.5-2.5 | Realistic workload |

## Related Documentation

- [Architecture Specification](../../doc/superscalar_architecture_specification.md)
- [LSQ Design](../../doc/lsq_design_specification.md)
- [ROB/RAT/BRAT Design](../../doc/register_renaming_integration_summary.md)
