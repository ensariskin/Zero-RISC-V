# RV32I 3-Way Superscalar Processor - Design Hierarchy

## Overview

This document describes the complete design hierarchy of the 3-way superscalar RV32I processor with out-of-order execution capabilities using the Tomasulo algorithm. The processor features speculative execution with BRAT (Branch Resolution Alias Table) for efficient misprediction recovery.

**Key Specifications:**
- **ISA**: RISC-V RV32I Base Integer Instruction Set
- **Issue Width**: 3 instructions per cycle
- **Fetch Width**: 5 instructions per cycle
- **Execution**: Out-of-order with Tomasulo algorithm
- **Commit**: In-order through Reorder Buffer

---

## Top-Level Module Hierarchy

```
rv32i_superscalar_core
│
├── fetch_buffer_unit (fetch_buffer_top)
│   ├── fetch_unit (multi_fetch)
│   │   ├── early_stage_immediate_decoder × 5
│   │   ├── jump_controller_super
│   │   │   ├── branch_predictor (2-bit saturating counter)
│   │   │   └── jalr_predictor (BTB for indirect jumps)
│   │   └── pc_ctrl_super (5-way parallel PC management)
│   │
│   └── instruction_buffer (instruction_buffer_new)
│       └── 16-entry FIFO buffer with 5-in/3-out ports
│
├── issue_stage_unit (issue_stage)
│   ├── decoder_0, decoder_1, decoder_2 (rv32i_decoder)
│   │   └── Full RV32I instruction decode with control word generation
│   │
│   └── rat (register_alias_table)
│       ├── RAT Mapping Table (32 arch → 64 phys)
│       ├── free_address_buffer (circular_buffer_3port)
│       ├── lsq_address_buffer (circular_buffer_3port)
│       └── brat_buffer (brat_circular_buffer) ★ NEW
│           ├── 16-entry branch resolution queue
│           ├── RAT snapshot storage per branch
│           └── In-order branch resolution with combinational bypass
│
├── dispatch_stage_unit (dispatch_stage)
│   ├── rob (reorder_buffer)
│   │   ├── 32-entry circular buffer
│   │   ├── 6 read ports + 6 write ports (CDB)
│   │   ├── 3-way parallel commit with exception handling
│   │   └── Eager misprediction tail truncation
│   │
│   ├── physical_reg_file (multi_port_register_file)
│   │   ├── 32 architectural registers
│   │   ├── 6 read ports (2 per RS)
│   │   └── 3 write ports (commit)
│   │
│   ├── rs_0, rs_1, rs_2 (reservation_station)
│   │   ├── Single-entry station per FU
│   │   ├── Tag-based dependency tracking
│   │   ├── CDB snooping for operand wake-up
│   │   └── BRAT-based eager flush support
│   │
│   ├── lsq (lsq_simple_top)
│   │   ├── 32-entry Load-Store Queue
│   │   ├── 3-way allocation/deallocation
│   │   ├── Store-to-load forwarding
│   │   ├── 3 independent memory ports
│   │   └── BRAT-based eager flush support
│   │
│   └── cdb_interface (cdb_if)
│       └── 6-channel Common Data Bus (3 ALU + 3 LSQ)
│
└── execute_stage_unit (superscalar_execute_stage)
    ├── fu0_alu_shifter, fu1_alu_shifter, fu2_alu_shifter
    │   └── Full RV32I ALU with single-cycle latency
    │
    └── fu0_branch_controller, fu1_branch_controller, fu2_branch_controller
        └── Branch resolution and misprediction detection
```

---

## Pipeline Stages

### Stage 1: Fetch (`fetch_buffer_top`)

The fetch stage is responsible for instruction fetching with branch prediction support.

**Module: `multi_fetch`**

| Port Category | Signals | Description |
|---------------|---------|-------------|
| Memory Interface | `inst_addr_0..4`, `instruction_i_0..4` | 5-port instruction memory |
| BRAT Interface | `misprediction_i_0..2` | In-order misprediction signals |
| | `update_valid_i_0..2` | Predictor update enables |
| | `is_jalr_i_0..2` | JALR vs branch distinction |
| | `pc_at_prediction_i_0..2` | PC for predictor table lookup |
| | `correct_pc_i_0..2` | Target PC for redirect/update |
| Outputs | `fetch_valid_o[4:0]` | Valid instruction bitmap |
| | `pc_o_0..4` | PC values for buffer |
| | `branch_prediction_o_0..4` | Branch prediction results |

**Key Features:**
- **5-Wide Fetch**: Fetches up to 5 sequential instructions per cycle
- **Branch Prediction**: 2-bit saturating counter predictor + JALR BTB
- **Early Termination**: Stops at predicted-taken branches
- **BRAT Integration**: Receives in-order branch results for predictor updates

**Module: `instruction_buffer_new`**

| Parameter | Value | Description |
|-----------|-------|-------------|
| BUFFER_DEPTH | 16 | FIFO depth |
| Input Width | 5 | Up to 5 instructions/cycle from fetch |
| Output Width | 3 | Up to 3 instructions/cycle to decode |

**Key Features:**
- **Decoupling Buffer**: Separates fetch rate from decode rate
- **Flush Support**: Clear on misprediction via `eager_flush` signal
- **Backpressure**: `fetch_ready_o` stops fetch when full

---

### Stage 2: Issue (`issue_stage`)

The issue stage handles instruction decode and register renaming.

**Module: `rv32i_decoder`**

Decodes RV32I instructions into control words:

```
Control Word [25:0]:
├── [25:21] rd_arch     - Destination register
├── [20:16] rs2_arch    - Source register 2
├── [15:11] rs1_arch    - Source register 1
├── [10:7]  func_sel    - ALU function select
├── [6]     we          - Register write enable
├── [5]     save_pc     - Save PC+4 (JAL/JALR)
├── [4]     is_load     - Load operation
├── [3]     use_imm     - Use immediate for operand B
├── [2]     sign_ext    - Sign extend memory data
└── [1:0]   mem_size    - Memory access size (B/H/W)

Branch Select [2:0]:
├── 000: No branch
├── 001: BEQ
├── 010: BNE
├── 011: BLT
├── 100: BGE
├── 101: BLTU
├── 110: BGEU
└── 111: JALR
```

**Module: `register_alias_table`**

The RAT implements Tomasulo register renaming with BRAT for speculative execution support.

| Feature | Implementation |
|---------|----------------|
| Mapping Table | 32 entries × 6-bit (arch → phys) |
| Physical Registers | 64 total (32 RF + 32 ROB) |
| Free List | `circular_buffer_3port` for 3-way alloc/dealloc |
| BRAT | `brat_circular_buffer` with 16 entries |

**RAT Renaming Flow:**
1. Lookup rs1/rs2 in RAT → get current physical mapping
2. Allocate new physical register from free list for rd
3. Update RAT: arch_reg[rd] → new_phys_reg
4. If branch: push RAT snapshot to BRAT
5. On misprediction: restore RAT from BRAT snapshot

**BRAT v2 Features:**
- **In-Order Resolution**: Outputs oldest-first resolved branches
- **Combinational Bypass**: Same-cycle execute→output for low latency
- **Snapshot Storage**: Full RAT state per speculative branch
- **Auto-Recovery**: Restores RAT on misprediction detection

---

### Stage 3: Dispatch (`dispatch_stage`)

The dispatch stage allocates ROB/LSQ entries and manages operand availability.

**Module: `reorder_buffer`**

```
ROB Entry Structure:
├── data[31:0]        - Result data
├── tag[2:0]          - Producer tag (111=ready)
├── addr[4:0]         - Architectural destination
├── executed          - Completion flag
├── exception         - Misprediction flag
├── correct_pc[31:0]  - Corrected PC for branch
├── is_branch         - Branch instruction flag
└── is_store          - Store instruction flag
```

| Interface | Ports | Description |
|-----------|-------|-------------|
| Allocation | `alloc_enable_0..2` | 3-way parallel allocation |
| CDB Write | `cdb_valid_0..2`, `cdb_data_0..2` | 6 CDB write ports |
| Read | `read_addr_0..5`, `read_data_0..5` | 6 read ports for RS |
| Commit | `commit_valid_0..2`, `commit_data_0..2` | 3-way in-order commit |
| Eager Flush | `branch_misprediction_i` | Tail truncation on BRAT signal |

**Module: `reservation_station`**

Single-entry Tomasulo station with tag-based wake-up:

| Signal | Width | Description |
|--------|-------|-------------|
| `operand_a_data` | 32 | Operand A value |
| `operand_a_tag` | 3 | Producer tag (111=ready) |
| `operand_b_data` | 32 | Operand B value |
| `operand_b_tag` | 3 | Producer tag (111=ready) |
| `rd_phys_addr` | 6 | Destination physical reg |
| `control_signals` | 11 | Execution control |

**Tag Encoding:**
```
000: Waiting for ALU0
001: Waiting for ALU1
010: Waiting for ALU2
011: Waiting for LSQ
111: Operand ready
```

**Module: `lsq_simple_top`**

Load-Store Queue with memory ordering:

| Feature | Implementation |
|---------|----------------|
| Queue Depth | 32 entries |
| Allocation | 3-way parallel |
| Memory Ports | 3 independent |
| Store Forwarding | CAM-based address match |
| Eager Flush | BRAT-distance based invalidation |

---

### Stage 4: Execute (`superscalar_execute_stage`)

Three parallel functional units with branch resolution:

**Module: `function_unit_alu_shifter`**

| Operation | `func_sel` | Description |
|-----------|------------|-------------|
| ADD | 0000 | Addition |
| SUB | 0001 | Subtraction |
| SLT | 0010 | Set less than (signed) |
| SLTU | 0011 | Set less than (unsigned) |
| AND | 0100 | Bitwise AND |
| OR | 0101 | Bitwise OR |
| XOR | 0110 | Bitwise XOR |
| SLL | 0111 | Shift left logical |
| SRL | 1000 | Shift right logical |
| SRA | 1001 | Shift right arithmetic |

**Branch Resolution:**
```
Execute Stage Outputs → BRAT:
├── exec_branch_valid_i[2:0]   - Branch executed flags
├── exec_mispredicted_i[2:0]   - Misprediction flags
├── exec_rob_id_0/1/2_i        - ROB IDs of branches
├── exec_correct_pc_0/1/2_i    - Corrected PC values
└── exec_pc_at_prediction_0/1/2_i - PCs for predictor update

BRAT Outputs → All Modules:
├── branch_resolved_o[2:0]     - In-order resolved signals
├── branch_mispredicted_o[2:0] - In-order misprediction
├── correct_pc_0/1/2_o         - Corrected PC values
├── is_jalr_0/1/2_o            - JALR vs branch type
└── pc_at_prediction_0/1/2_o   - For predictor table update
```

---

## Data Flow

### Normal Execution Pipeline

```
┌─────────┐    ┌─────────┐    ┌──────────┐    ┌─────────┐    ┌────────┐
│  FETCH  │───►│  ISSUE  │───►│ DISPATCH │───►│ EXECUTE │───►│ COMMIT │
│ (5-way) │    │ (3-way) │    │  (3-way) │    │ (3-way) │    │(3-way) │
└─────────┘    └─────────┘    └──────────┘    └─────────┘    └────────┘
     │              │              │               │              │
     │              │              │               │              │
   I-Mem          RAT+           ROB+            CDB            RF+
   (5-port)       BRAT           RF+RS           Broadcast      RAT
                                 LSQ                            Update
```

### Misprediction Recovery (BRAT v2)

```
1. Execute Stage → BRAT
   └─► Branch resolves, misprediction detected
   
2. BRAT → In-Order Output
   └─► Oldest mispredicted branch emitted first
   
3. BRAT → All Modules (same cycle)
   ├─► RAT: Restore snapshot
   ├─► ROB: Truncate tail
   ├─► RS: Flush younger entries
   ├─► LSQ: Flush younger entries
   └─► Fetch: Redirect PC

4. BRAT → Fetch
   └─► Update predictor tables
```

---

## Key Design Parameters

| Component | Parameter | Value |
|-----------|-----------|-------|
| **Fetch** | Fetch Width | 5 instructions/cycle |
| | Instruction Buffer | 16 entries |
| | Branch Predictor | 2-bit saturating, 256 entries |
| | JALR Predictor | 64-entry BTB |
| **Issue** | Decode Width | 3 instructions/cycle |
| | Arch Registers | 32 (x0-x31) |
| | Phys Registers | 64 (32 RF + 32 ROB) |
| | BRAT Depth | 16 entries |
| **Dispatch** | ROB Depth | 32 entries |
| | ROB Read Ports | 6 |
| | LSQ Depth | 32 entries |
| | RS Count | 3 (1 per FU) |
| | CDB Channels | 6 (3 ALU + 3 LSQ) |
| **Execute** | Functional Units | 3 ALU/Shifters |
| | Latency | 1 cycle |
| **Memory** | I-Mem Ports | 5 |
| | D-Mem Ports | 3 |

---

## File Organization

```
digital/modules/superscalar_spesific_modules/
├── top/
│   └── rv32i_superscalar_core.sv       # Top-level integration
│
├── fetch_stage/
│   ├── fetch_buffer_top.sv             # Fetch + buffer wrapper
│   ├── multi_fetch.sv                  # 5-wide parallel fetch
│   ├── instruction_buffer_new.sv       # 16-entry FIFO
│   ├── jump_controller_super.sv        # Branch prediction
│   ├── pc_ctrl_super.sv                # 5-way PC management
│   ├── branch_predictor.sv             # 2-bit predictor
│   └── jalr_predictor.sv               # JALR BTB
│
├── issue_stage/
│   ├── issue_stage.sv                  # Issue wrapper + decoders
│   ├── rv32i_decoder.sv                # RV32I instruction decoder
│   └── register_alias_table.sv         # RAT + BRAT integration
│
├── dispatch_stage/
│   ├── dispatch_stage.sv               # Dispatch wrapper
│   ├── reorder_buffer.sv               # 32-entry ROB
│   ├── reservation_station.sv          # Single-entry RS
│   ├── multi_port_register_file.sv     # 6R/3W register file
│   └── lsq_simple_top.sv               # Load-Store Queue
│
├── execute_stage/
│   └── execute_stage.sv                # 3× ALU + branch control
│
├── load_store_queue/
│   ├── lsq_simple_top.sv               # LSQ top module
│   └── lsq_package.sv                  # LSQ types/params
│
├── common/
│   ├── brat_circular_buffer.sv         # BRAT v2 implementation
│   ├── circular_buffer_3port.sv        # Free list / LSQ alloc
│   ├── priority_encoder.sv             # Multi-bit priority encoder
│   └── early_stage_immediate_decoder.sv # Early immediate decode
│
└── interfaces/
    ├── cdb_if.sv                       # CDB interface
    ├── rs_to_exec_if.sv                # RS-to-Execute interface
    ├── issue_to_dispatch_if.sv         # Issue-to-Dispatch interface
    └── decode_to_rs_if.sv              # Decode-to-RS interface
```

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-23 | - | Initial documentation |
| 2.0 | 2025-12-01 | - | BRAT v2 integration, updated interfaces |

---

*This document reflects the current state of the superscalar-clean branch.*
