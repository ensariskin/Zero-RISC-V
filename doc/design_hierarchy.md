# RV32I 3-Way Superscalar Processor Design Hierarchy

## Overview
This document describes the complete design hierarchy of the 3-way superscalar RV32I processor with out-of-order execution capabilities using the Tomasulo algorithm.

---

## Top-Level Module: `rv32i_superscalar_core`

```
rv32i_superscalar_core
│
├── fetch_buffer_unit (fetch_buffer_top)
│   ├── fetch_unit (multi_fetch)
│   │   └── Fetches up to 5 instructions per cycle
│   │
│   └── instruction_buffer (instruction_buffer_new)
│       └── 16-entry FIFO buffer for fetch/decode decoupling
│
├── issue_stage_unit (issue_stage)
│   ├── decoder_0 (rv32i_decoder)
│   │   └── Decodes instruction stream 0
│   │
│   ├── decoder_1 (rv32i_decoder)
│   │   └── Decodes instruction stream 1
│   │
│   ├── decoder_2 (rv32i_decoder)
│   │   └── Decodes instruction stream 2
│   │
│   └── rat (register_alias_table)
│       ├── 32-entry architectural to 64-entry physical register mapping
│       ├── Free list management (circular buffer)
│       └── 3-way allocation and commit per cycle
│
├── dispatch_stage_unit (dispatch_stage)
│   ├── rob (reorder_buffer)
│   │   ├── 32-entry circular buffer
│   │   ├── In-order commit (up to 3 per cycle)
│   │   ├── Out-of-order completion tracking
│   │   ├── Exception/misprediction detection
│   │   └── 6 read ports for operand fetch
│   │
│   ├── physical_reg_file (multi_port_register_file)
│   │   ├── 32 architectural registers (5-bit address)
│   │   ├── 6 read ports (2 per reservation station)
│   │   └── 3 write ports (commit from ROB)
│   │
│   ├── rs_0 (reservation_station)
│   │   ├── Single-entry station for ALU0
│   │   ├── Tag-based dependency tracking (3-bit tags)
│   │   ├── CDB monitoring for operand wake-up
│   │   └── Direct bypass when operands ready
│   │
│   ├── rs_1 (reservation_station)
│   │   ├── Single-entry station for ALU1
│   │   ├── Tag-based dependency tracking
│   │   ├── CDB monitoring for operand wake-up
│   │   └── Direct bypass when operands ready
│   │
│   ├── rs_2 (reservation_station)
│   │   ├── Single-entry station for ALU2
│   │   ├── Tag-based dependency tracking
│   │   ├── CDB monitoring for operand wake-up
│   │   └── Direct bypass when operands ready
│   │
│   ├── lsq (lsq_simple_top)
│   │   ├── Load-Store Queue for memory ordering
│   │   ├── 3-way allocation per cycle
│   │   ├── Address calculation tracking
│   │   ├── Store buffering
│   │   └── Memory dependency checking
│   │
│   └── cdb_interface (cdb_if)
│       ├── Common Data Bus with 4 broadcast channels:
│       │   ├── CDB0: Results from ALU0
│       │   ├── CDB1: Results from ALU1
│       │   ├── CDB2: Results from ALU2
│       │   └── CDB3: Results from LSQ (memory operations)
│       │
│       └── Broadcasts to all reservation stations simultaneously
│
└── execute_stage_unit (superscalar_execute_stage)
    ├── fu_0 (execute)
    │   ├── Full RV32I ALU (ADD, SUB, SLT, SLTU, etc.)
    │   ├── Shifter (SLL, SRL, SRA)
    │   ├── Logic operations (AND, OR, XOR)
    │   └── Branch/Jump computation
    │
    ├── fu_1 (execute)
    │   ├── Full RV32I ALU
    │   ├── Shifter
    │   ├── Logic operations
    │   └── Branch/Jump computation
    │
    └── fu_2 (execute)
        ├── Full RV32I ALU
        ├── Shifter
        ├── Logic operations
        └── Branch/Jump computation
```

---

## Pipeline Stages

### 1. Fetch Stage (`fetch_buffer_top`)
**Components:**
- `multi_fetch`: Parallel instruction fetcher (up to 5 instructions/cycle)
- `instruction_buffer_new`: 16-entry FIFO buffer

**Features:**
- Branch prediction integration
- Misprediction recovery (flush and redirect)
- Variable fetch width (1-5 instructions)
- Decouples fetch from decode

**Interfaces:**
- **Input**: 5 instruction memory ports
- **Output**: Up to 3 instructions per cycle to issue stage
- **Control**: Flush signal, correct PC for misprediction recovery

---

### 2. Issue Stage (`issue_stage`)
**Components:**
- 3 parallel `rv32i_decoder` units
- `register_alias_table` (RAT)

**Features:**
- 3-way instruction decode
- Register renaming (32 arch → 64 phys registers)
- Free list management
- Structural hazard detection (ROB/LSQ full)

**Interfaces:**
- **Input**: 3 instruction streams from fetch buffer
- **Output**: 3 renamed instruction streams to dispatch
- **Control**: ROB full, LSQ full, decode_ready backpressure

**RAT Details:**
- **Allocation**: Up to 3 physical registers per cycle
- **Commit**: Up to 3 registers freed per cycle
- **Free List**: Circular buffer with head/tail pointers
- **Mapping Table**: 32 entries (arch reg → phys reg + valid bit)

---

### 3. Dispatch Stage (`dispatch_stage`)
**Components:**
- `reorder_buffer` (ROB)
- `multi_port_register_file`
- 3 × `reservation_station` (RS0, RS1, RS2)
- `lsq_simple_top` (Load-Store Queue)
- `cdb_if` (Common Data Bus)

**Features:**
- Out-of-order dispatch to reservation stations
- Operand fetching from ROB or register file
- Tag-based dependency resolution
- In-order commit through ROB

**ROB Details:**
- **Depth**: 32 entries
- **Allocation**: Up to 3 entries per cycle
- **Commit**: Up to 3 entries per cycle (in-order from head)
- **Read Ports**: 6 (for 3 instructions × 2 operands)
- **Write Ports**: 6 (from CDB channels)

**Reservation Station Details:**
- **Depth**: 1 entry per station (simplified Tomasulo)
- **Operand Ready**: Immediate dispatch if both operands available
- **Operand Wait**: Monitor CDB for pending operands
- **Tags**: 3-bit producer tags (000=ALU0, 001=ALU1, 010=ALU2, 011=LSQ, 111=Ready)

**LSQ Details:**
- **Allocation**: Up to 3 memory operations per cycle
- **Address Calculation**: Tracked via CDB
- **Store Forwarding**: Load-store dependency checking
- **Memory Ports**: 3 independent data memory interfaces

**CDB Details:**
- **Channels**: 4 broadcast buses
  - CDB0: ALU0 results
  - CDB1: ALU1 results
  - CDB2: ALU2 results
  - CDB3: LSQ results (load data)
- **Broadcast**: Simultaneous to all RSs, ROB, and RAT
- **Data**: Result value + destination register + valid bit

---

### 4. Execute Stage (`superscalar_execute_stage`)
**Components:**
- 3 × `execute` units (FU0, FU1, FU2)

**Features:**
- Single-cycle execution for most operations
- Branch resolution and misprediction detection
- Result broadcast via CDB

**Functional Unit Capabilities:**
- Arithmetic: ADD, SUB, SLT, SLTU
- Logic: AND, OR, XOR
- Shift: SLL, SRL, SRA
- Branch: BEQ, BNE, BLT, BGE, BLTU, BGEU
- Jump: JAL, JALR
- Memory Address Calculation: LOAD/STORE effective address

**Branch Handling:**
- **Prediction Check**: Compare actual vs. predicted outcome
- **Misprediction Signal**: Sent to ROB for exception marking
- **PC Correction**: Calculated correct PC sent to fetch stage
- **Recovery**: ROB waits for head, then flushes entire pipeline

---

## Data Flow

### Instruction Flow (Normal Execution)
```
1. FETCH (fetch_buffer_top)
   │
   ├─→ multi_fetch: Fetch 5 instructions from memory
   │
   └─→ instruction_buffer: Store in 16-entry FIFO
       │
       └─→ Output 3 instructions per cycle
           │
           ▼
2. ISSUE (issue_stage)
   │
   ├─→ rv32i_decoder × 3: Decode instructions
   │
   └─→ register_alias_table: Rename registers
       │   ├─→ Allocate physical registers
       │   ├─→ Update mapping table
       │   └─→ Check ROB/LSQ availability
       │
       └─→ Output renamed instructions
           │
           ▼
3. DISPATCH (dispatch_stage)
   │
   ├─→ reorder_buffer: Allocate ROB entries
   │   └─→ Store instruction metadata
   │
   ├─→ Operand Fetch:
   │   ├─→ Check ROB for pending results
   │   └─→ Read register file for ready values
   │
   └─→ reservation_station × 3: Dispatch if ready
       │   ├─→ If operands ready: Issue to execute
       │   └─→ If operands pending: Wait for CDB
       │
       └─→ lsq: Allocate LSQ entry for loads/stores
           │
           ▼
4. EXECUTE (superscalar_execute_stage)
   │
   ├─→ execute × 3: Perform operation
   │   ├─→ ALU computation
   │   ├─→ Branch resolution
   │   └─→ Memory address calculation
   │
   └─→ CDB Broadcast:
       │   ├─→ To reservation_stations (wake-up waiting ops)
       │   ├─→ To reorder_buffer (mark complete)
       │   └─→ To lsq (address/data forwarding)
       │
       ▼
5. COMMIT (reorder_buffer)
   │
   ├─→ In-order commit from ROB head
   │   ├─→ Check for exceptions/mispredictions
   │   └─→ Up to 3 instructions per cycle
   │
   ├─→ Update architectural state:
   │   ├─→ Write register file (3 ports)
   │   ├─→ Free old physical registers (RAT)
   │   └─→ Commit memory operations (LSQ)
   │
   └─→ If misprediction: FLUSH pipeline
```

### Misprediction Recovery Flow
```
1. Branch Resolution (execute stage)
   │
   └─→ Detect misprediction
       │
       ▼
2. ROB Exception Marking
   │
   ├─→ CDB broadcasts exception flag
   │
   └─→ ROB marks entry as exception
       │
       ▼
3. Wait for ROB Head
   │
   └─→ Allow older instructions to commit
       │
       ▼
4. Exception Detection at Head
   │
   ├─→ Signal misprediction_detected
   │
   └─→ Provide correct_pc
       │
       ▼
5. Pipeline Flush
   │
   ├─→ Clear instruction buffer
   ├─→ Clear reservation stations
   ├─→ Clear ROB entries after head
   └─→ Reset RAT to committed state
       │
       ▼
6. Fetch Restart
   │
   └─→ Begin fetching from correct_pc
```

---

## Key Design Parameters

| Component | Parameter | Value |
|-----------|-----------|-------|
| **Fetch Stage** | Instructions/cycle (max) | 5 |
| | Instruction Buffer Depth | 16 |
| **Issue Stage** | Decode Width | 3 |
| | Architectural Registers | 32 |
| | Physical Registers | 64 |
| **Dispatch Stage** | ROB Depth | 32 |
| | LSQ Depth | Variable |
| | Reservation Stations | 3 × 1-entry |
| | CDB Channels | 4 |
| **Execute Stage** | Functional Units | 3 |
| | Execution Latency | 1 cycle |
| **Memory** | Data Memory Ports | 3 |
| | Instruction Memory Ports | 5 |

---


## File Organization

```
digital/modules/superscalar_spesific_modules/
│
├── top/
│   └── rv32i_superscalar_core.sv          # Top-level integration
│
├── fetch_stage/
│   ├── fetch_buffer_top.sv                # Fetch + buffer wrapper
│   ├── multi_fetch.sv                     # Parallel fetch unit
│   └── instruction_buffer_new.sv          # FIFO buffer
│
├── issue_stage/
│   ├── issue_stage.sv                     # Issue wrapper
│   ├── rv32i_decoder.sv                   # Instruction decoder
│   └── register_alias_table.sv            # RAT for renaming
│
├── dispatch_stage/
│   ├── dispatch_stage.sv                  # Dispatch wrapper
│   ├── reorder_buffer.sv                  # ROB implementation
│   ├── reservation_station.sv             # Single-entry RS
│   ├── multi_port_register_file.sv        # Physical register file
│   └── lsq_simple_top.sv                  # Load-Store Queue
│
├── execute_stage/
│   ├── execute_stage.sv                   # Execute wrapper
│   └── execute.sv                         # Functional unit (ALU)
│
└── common/
    ├── cdb_if.sv                          # CDB interface definition
    ├── rs_to_exec_if.sv                   # RS-to-Execute interface
    └── issue_to_dispatch_if.sv            # Issue-to-Dispatch interface
```

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-23 | AI Assistant | Initial design hierarchy documentation |

---

*This document reflects the current state of the superscalar-clean branch.*
