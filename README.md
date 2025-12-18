# RV32I 3-Way Superscalar Processor

## Overview

A high-performance **3-way superscalar RISC-V RV32I processor** with out-of-order execution using the **Tomasulo algorithm** with physical register renaming.

## Key Features

| Feature | Specification |
|---------|---------------|
| **ISA** | RV32I Base Integer |
| **Execution Model** | 3-Way Superscalar, Out-of-Order |
| **Pipeline** | Fetch → Issue → Dispatch → Execute |
| **Register Renaming** | 32 Architectural → 64 Physical |
| **ROB** | 32 entries |
| **BRAT** | 16-entry circular buffer |
| **Instruction Buffer** | 16 entries (5 in / 3 out per cycle) |
| **LSQ** | 32 entries with store-to-load forwarding |
| **Branch Predictor** | 2-bit saturating counter (32 entries) |

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                         FETCH STAGE                                 │
│  ┌─────────┐   ┌────────────┐   ┌─────────────────────────────────┐│
│  │ PC Ctrl │──▶│ Multi-Fetch│──▶│ Instruction Buffer (16 entries) ││
│  │         │   │  (5 ports) │   │       5 in / 3 out              ││
│  └─────────┘   └────────────┘   └─────────────────────────────────┘│
│       ▲ Branch Predictor (32-entry, 2-bit)                         │
└───────│────────────────────────────────────────────────────────────┘
        │ Misprediction Redirect              │ 3 instructions/cycle
        │                                     ▼
┌───────│────────────────────────────────────────────────────────────┐
│       │                    ISSUE STAGE                             │
│  ┌────┴────────────────────────────────────────────────────────┐   │
│  │            Register Alias Table (RAT)                        │   │
│  │          32 Arch → 64 Physical Register Mapping             │   │
│  │              Circular buffer free list                       │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                      │
│  ┌───────────────────────────┴──────────────────────────────────┐   │
│  │                 BRAT (16-entry circular buffer)              │   │
│  │         RAT snapshot per branch for misprediction recovery   │   │
│  │              In-order branch resolution outputs              │   │
│  └──────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
                               │ 3 instructions/cycle
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        DISPATCH STAGE                               │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │              Reorder Buffer (ROB) - 32 entries               │   │
│  │   3 allocation ports, 6 CDB update ports, 3 commit ports     │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │             3× Reservation Stations (single-entry each)      │   │
│  │          Tag-based dependency (3-bit: 111 = ready)           │   │
│  │               CDB monitoring for operand wakeup              │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                 LSQ - 32 entries (FIFO)                      │   │
│  │   Store-to-load forwarding, eager misprediction flush        │   │
│  │              3 parallel memory ports                         │   │
│  └──────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        EXECUTE STAGE                                │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                    │
│  │   ALU 0    │  │   ALU 1    │  │   ALU 2    │                    │
│  │  (R/I ops) │  │  (R/I ops) │  │(R/I/Branch)│                    │
│  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘                    │
│        │               │               │                            │
│        ▼               ▼               ▼                            │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │        Common Data Bus (CDB) - 3 ALU + 3 LSQ channels        │   │
│  │   cdb_valid_0/1/2 (ALU), cdb_valid_3_0/3_1/3_2 (LSQ)        │   │
│  └──────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      WRITEBACK & COMMIT                             │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │       Physical Register File (64 × 32-bit)                   │   │
│  │   6 read ports (3 inst × 2 operands), 3 commit write ports   │   │
│  │        Write-through for same-cycle read/write               │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │              In-Order Commit (3 per cycle)                   │   │
│  │         ROB head → Register File → Free old physical reg     │   │
│  └──────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

## Project Structure

```
RV32I/
├── digital/
│   ├── modules/
│   │   ├── common/                    # Shared packages (rv32i_pkg.sv)
│   │   ├── fetch_stage/src/           # PC ctrl, branch predictor, jump controller
│   │   ├── decode_stage/              # Instruction decoder, control
│   │   ├── execute/                   # ALU, ALU control
│   │   ├── mem/                       # Data memory controller
│   │   ├── write_back/                # (Legacy)
│   │   ├── hazard/                    # Hazard unit
│   │   │
│   │   └── superscalar_spesific_modules/
│   │       ├── common/
│   │       │   ├── brat_circular_buffer.sv   # BRAT (16-entry)
│   │       │   └── priority_encoder.sv
│   │       ├── fetch_stage/
│   │       │   ├── instruction_buffer_new.sv # 16-entry FIFO
│   │       │   ├── branch_predictor_super.sv # 32-entry 2-bit predictor
│   │       │   ├── multi_fetch.sv            # 5-port fetch
│   │       │   └── pc_ctrl_super.sv
│   │       ├── issue_stage/
│   │       │   ├── register_alias_table.sv   # RAT with free list
│   │       │   └── issue_stage.sv
│   │       ├── dispatch_stage/
│   │       │   ├── reorder_buffer.sv         # 32-entry ROB
│   │       │   ├── reservation_station.sv    # Single-entry RS
│   │       │   ├── multi_port_register_file.sv # 64-reg, 6R/3W
│   │       │   └── dispatch_stage.sv
│   │       ├── execute_stage/
│   │       │   └── execute_stage.sv
│   │       ├── load_store_queue/
│   │       │   ├── lsq_simple_top.sv         # 32-entry LSQ
│   │       │   └── lsq_package.sv
│   │       └── top/
│   │           └── rv32i_superscalar_core.sv # Processor top
│   │
│   ├── sim/                           # Simulation files
│   │   ├── superscalar_new.f          # Main file list
│   │   ├── hex/                       # Test programs
│   │   └── run/                       # Simulation outputs
│   │
│   ├── testbench/                     # Verification
│   └── tests/                         # Test programs (C/ASM)
│
├── doc/                               # Documentation
├── scripts/                           # Utility scripts
└── tools/riscv-dv/                    # RISC-V DV verification
```

## Module Summary

| Module | Location | Description |
|--------|----------|-------------|
| `rv32i_superscalar_core` | top/ | Processor top module |
| `register_alias_table` | issue_stage/ | RAT with circular buffer free list |
| `brat_circular_buffer` | common/ | 16-entry BRAT for branch recovery |
| `reorder_buffer` | dispatch_stage/ | 32-entry ROB |
| `reservation_station` | dispatch_stage/ | Single-entry RS with CDB monitoring |
| `multi_port_register_file` | dispatch_stage/ | 64×32-bit, 6R/3W ports |
| `instruction_buffer_new` | fetch_stage/ | 16-entry FIFO (5in/3out) |
| `lsq_simple_top` | load_store_queue/ | 32-entry LSQ with forwarding |
| `branch_predictor_super` | fetch_stage/ | 32-entry 2-bit predictor |

## Tomasulo Implementation

1. **Issue**: Decode → RAT lookup → Allocate ROB entry → Dispatch to RS
2. **Execute**: RS operands ready → Issue to ALU → Broadcast on CDB
3. **Writeback**: CDB updates ROB, RS, LSQ operands
4. **Commit**: ROB head ready → Update register file → Free old physical reg

### Tag Encoding
- `3'b000` - `3'b110`: Waiting for producer (ROB index / physical reg)
- `3'b111`: Operand ready/valid

### Branch Misprediction Recovery
1. Branch executes → Result stored in BRAT entry
2. BRAT outputs in-order resolution (oldest first)
3. On misprediction: Restore RAT from BRAT snapshot, flush pipeline
4. BRAT ensures correct ordering even with out-of-order execution

## Supported Instructions

| Type | Instructions |
|------|--------------|
| **R-Type** | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU |
| **I-Type** | ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SLLI, SRLI, SRAI |
| **Load** | LW, LH, LHU, LB, LBU |
| **Store** | SW, SH, SB |
| **Branch** | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| **Jump** | JAL, JALR |
| **Upper** | LUI, AUIPC |

## Simulation

```bash
cd digital/sim/run
dsim -f ../superscalar_new.f -top tb_top +HEX_FILE=../hex/test.hex
```

## Performance Counters

The processor tracks:
- `perf_cycles` - Total clock cycles
- `perf_instructions_fetched` - Instructions fetched
- `perf_instructions_executed` - Instructions committed
- `perf_branch_mispredictions` - Branch misprediction count
- `perf_buffer_stalls` - Instruction buffer stall cycles

## Author

**Ensar Işkın**  
Graduate Research - RV32I Superscalar Processor Design
