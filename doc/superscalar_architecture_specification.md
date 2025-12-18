# RV32I 3-Way Superscalar Processor Architecture Specification

## 1. Overview

This document specifies the complete architecture of a 3-way superscalar RV32I processor implementing the Tomasulo algorithm for out-of-order execution with speculative branch execution using BRAT (Branch Resolution Alias Table).

### 1.1 Key Features

| Feature | Specification |
|---------|--------------|
| **ISA** | RISC-V RV32I Base Integer |
| **Superscalar Width** | 3-way issue, dispatch, execute, commit |
| **Fetch Width** | 5 instructions per cycle |
| **Execution Model** | Out-of-order with in-order commit |
| **Speculation** | BRAT-based branch speculation with eager recovery |
| **Register Renaming** | 32 arch → 64 physical (Tomasulo) |
| **Branch Prediction** | 2-bit saturating counter + JALR BTB |

### 1.2 Design Philosophy

1. **Eager Misprediction Recovery**: BRAT enables instant recovery without waiting for ROB head
2. **In-Order Branch Resolution**: BRAT outputs branches in program order for correct speculation
3. **Tag-Based Dependency**: 3-bit producer tags eliminate RAW hazards dynamically
4. **Decoupled Fetch**: 5-wide fetch with 16-entry buffer feeds 3-wide decode

---

## 2. Pipeline Architecture

### 2.1 Four-Stage Pipeline

```
┌──────────────────────────────────────────────────────────────────────────┐
│                          RV32I Superscalar Pipeline                       │
├───────────┬───────────┬────────────┬───────────┬────────────────────────┤
│   FETCH   │   ISSUE   │  DISPATCH  │  EXECUTE  │        COMMIT          │
│  (5-way)  │  (3-way)  │  (3-way)   │  (3-way)  │       (3-way)          │
├───────────┼───────────┼────────────┼───────────┼────────────────────────┤
│multi_fetch│decoder ×3 │    ROB     │   ALU0    │   ROB Head Retire      │
│instruction│    RAT    │    RF      │   ALU1    │   RF Write (3 ports)   │
│  buffer   │   BRAT    │   RS ×3    │   ALU2    │   RAT Commit           │
│           │           │   LSQ      │   Branch  │   Free List Return     │
└───────────┴───────────┴────────────┴───────────┴────────────────────────┘
```

### 2.2 Clock Cycle Breakdown

| Cycle | Stage | Operations |
|-------|-------|------------|
| 1 | Fetch | I-Mem access, branch prediction, buffer fill |
| 2 | Issue | Decode, RAT rename, BRAT push (branches) |
| 3 | Dispatch | ROB alloc, RF read, RS dispatch, LSQ alloc |
| 4 | Execute | ALU compute, branch resolve, CDB broadcast |
| 5 | Commit | In-order retire, RF write, RAT update |

---

## 3. Fetch Stage (`fetch_buffer_top`)

### 3.1 Module: `multi_fetch`

The fetch unit performs 5-wide parallel instruction fetch with integrated branch prediction.

#### 3.1.1 Port Interface

```systemverilog
module multi_fetch #(
    parameter PARALLEL_FETCH = 5
)(
    // Clock & Reset
    input  logic clk_i, rst_ni,
    
    // Instruction Memory (5 ports)
    output logic [31:0] inst_addr_0, inst_addr_1, inst_addr_2, 
                        inst_addr_3, inst_addr_4,
    input  logic [31:0] instruction_i_0, instruction_i_1, instruction_i_2,
                        instruction_i_3, instruction_i_4,
    
    // BRAT Interface (3 ports - in-order resolution)
    input  logic        misprediction_i_0, misprediction_i_1, misprediction_i_2,
    input  logic        update_valid_i_0, update_valid_i_1, update_valid_i_2,
    input  logic        is_jalr_i_0, is_jalr_i_1, is_jalr_i_2,
    input  logic [31:0] pc_at_prediction_i_0, pc_at_prediction_i_1, pc_at_prediction_i_2,
    input  logic [31:0] correct_pc_i_0, correct_pc_i_1, correct_pc_i_2,
    
    // Buffer Interface
    input  logic        fetch_ready_i,
    output logic [4:0]  fetch_valid_o,
    output logic [31:0] pc_o_0..4, instruction_o_0..4
);
```

#### 3.1.2 Branch Prediction

**2-Bit Saturating Counter (`branch_predictor`)**:
- 256 entries indexed by PC[9:2]
- States: Strongly Not-Taken (00) → Weakly Not-Taken (01) → Weakly Taken (10) → Strongly Taken (11)
- Prediction threshold: State[1] = Taken

**JALR BTB (`jalr_predictor`)**:
- 64-entry fully-associative BTB
- Tag: PC[31:2]
- Target: 32-bit predicted return address
- Used for JALR and function returns

#### 3.1.3 Fetch Logic

```
1. PC Generation:
   ├─ Normal: PC + 4 for each slot
   ├─ Predicted-Taken: PC + (predicted_offset << 1)
   └─ Misprediction: correct_pc from BRAT
   
2. Early Branch Detection:
   ├─ Scan instruction[6:0] opcode for JAL/JALR/Branch
   ├─ Extract immediate via early_stage_immediate_decoder
   └─ Stop fetch at first predicted-taken branch
   
3. Valid Generation:
   ├─ fetch_valid[0] = always 1 (first instruction)
   ├─ fetch_valid[1..4] = ~(any prior predicted-taken)
   └─ All invalid after misprediction until redirect
```

### 3.2 Module: `instruction_buffer_new`

16-entry FIFO buffer decoupling 5-wide fetch from 3-wide decode.

| Parameter | Value | Description |
|-----------|-------|-------------|
| `BUFFER_DEPTH` | 16 | Total FIFO entries |
| `INPUT_WIDTH` | 5 | Max instructions pushed per cycle |
| `OUTPUT_WIDTH` | 3 | Max instructions popped per cycle |

**Key Signals**:
- `eager_flush_i`: Immediate clear on BRAT misprediction
- `fetch_ready_o`: Backpressure when buffer almost full
- `valid_count_o[4:0]`: Number of valid entries for debug

---

## 4. Issue Stage (`issue_stage`)

### 4.1 Module: `rv32i_decoder`

Full RV32I instruction decoder producing control words and immediate values.

#### 4.1.1 Control Word Encoding (26 bits)

```
[25:21] rd_arch      - Destination architectural register
[20:16] rs2_arch     - Source 2 architectural register  
[15:11] rs1_arch     - Source 1 architectural register
[10:7]  func_sel     - ALU function select (see table)
[6]     we           - Register write enable
[5]     save_pc      - Save PC+4 to rd (JAL/JALR)
[4]     is_load      - Memory load operation
[3]     use_imm      - Use immediate for operand B
[2]     sign_ext     - Sign extend memory data
[1:0]   mem_size     - Memory access size (00=B, 01=H, 10=W)
```

#### 4.1.2 Branch Select Encoding (3 bits)

| `branch_sel` | Branch Type | Condition |
|--------------|-------------|-----------|
| 3'b000 | None | No branch |
| 3'b001 | BEQ | rs1 == rs2 |
| 3'b010 | BNE | rs1 != rs2 |
| 3'b011 | BLT | rs1 < rs2 (signed) |
| 3'b100 | BGE | rs1 >= rs2 (signed) |
| 3'b101 | BLTU | rs1 < rs2 (unsigned) |
| 3'b110 | BGEU | rs1 >= rs2 (unsigned) |
| 3'b111 | JALR | Unconditional indirect |

#### 4.1.3 ALU Function Select (4 bits)

| `func_sel` | Operation | Description |
|------------|-----------|-------------|
| 4'b0000 | ADD | rs1 + rs2/imm |
| 4'b0001 | SUB | rs1 - rs2 |
| 4'b0010 | SLT | (rs1 < rs2) ? 1 : 0 (signed) |
| 4'b0011 | SLTU | (rs1 < rs2) ? 1 : 0 (unsigned) |
| 4'b0100 | AND | rs1 & rs2 |
| 4'b0101 | OR | rs1 \| rs2 |
| 4'b0110 | XOR | rs1 ^ rs2 |
| 4'b0111 | SLL | rs1 << rs2[4:0] |
| 4'b1000 | SRL | rs1 >> rs2[4:0] |
| 4'b1001 | SRA | rs1 >>> rs2[4:0] |
| 4'b1010 | LUI_AUIPC | Pass operand B (for LUI/AUIPC) |

### 4.2 Module: `register_alias_table`

The RAT manages Tomasulo register renaming with integrated BRAT for speculative execution.

#### 4.2.1 Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `ARCH_REG_COUNT` | 32 | Number of architectural registers |
| `PHYS_REG_BITS` | 6 | Physical register address width |
| `BRAT_DEPTH` | 16 | Maximum in-flight branches |

#### 4.2.2 RAT Mapping Table

```systemverilog
// RAT entry: 6-bit physical address
logic [5:0] rat_table [0:31];  // rat_table[arch_reg] = phys_reg

// Initial state: arch_reg[i] → phys_reg[i] (identity mapping)
initial begin
    for (int i = 0; i < 32; i++)
        rat_table[i] = i[5:0];
end
```

#### 4.2.3 Free List Management

```
Free List Circular Buffer:
├─ Depth: 32 entries (indices 32-63 initially free)
├─ Head: Next free register to allocate
├─ Tail: Where freed registers return
├─ 3-port alloc/dealloc per cycle

Allocation Flow (per instruction with rd != x0):
1. Pop head → new_phys_reg
2. old_phys_reg = rat_table[rd_arch]
3. rat_table[rd_arch] = new_phys_reg
4. old_phys_reg sent to ROB for commit-time free

Deallocation Flow (commit):
1. Push old_phys_reg to free list tail
2. Maintain free list invariant
```

#### 4.2.4 BRAT Integration

The RAT instantiates BRAT for branch speculation:

```systemverilog
brat_circular_buffer #(
    .DEPTH(16),
    .DATA_WIDTH(32*6)  // Full RAT snapshot
) brat_buffer (
    // Allocation (from Issue - when branch decoded)
    .alloc_enable_i(branch_alloc_enable[2:0]),
    .alloc_rob_id_0_i, .alloc_rob_id_1_i, .alloc_rob_id_2_i,
    .alloc_is_jalr_0_i, .alloc_is_jalr_1_i, .alloc_is_jalr_2_i,
    .alloc_pc_at_prediction_0_i, .alloc_pc_at_prediction_1_i, ...,
    .alloc_snapshot_data_i(current_rat_snapshot),
    
    // Execute Result Write
    .exec_branch_valid_i, .exec_mispredicted_i,
    .exec_rob_id_0_i, .exec_correct_pc_0_i, ...,
    
    // In-Order Resolution Outputs
    .branch_resolved_o[2:0],
    .branch_mispredicted_o[2:0],
    .correct_pc_0_o, .correct_pc_1_o, .correct_pc_2_o,
    .is_jalr_0_o, .is_jalr_1_o, .is_jalr_2_o,
    .pc_at_prediction_0_o, .pc_at_prediction_1_o, .pc_at_prediction_2_o
);
```

---

## 5. Branch Resolution Alias Table (BRAT v2)

### 5.1 Overview

BRAT is the key innovation enabling **eager misprediction recovery**. Unlike traditional ROB-based recovery that waits for the mispredicting branch to reach ROB head, BRAT outputs resolved branches in program order, allowing immediate recovery.

### 5.2 Module: `brat_circular_buffer`

#### 5.2.1 Entry Structure

```systemverilog
typedef struct packed {
    logic [4:0]  rob_id;           // ROB index for matching
    logic        is_jalr;          // 0=branch, 1=JALR
    logic [31:0] pc_at_prediction; // PC for predictor update
    logic        resolved;         // Branch has executed
    logic        mispredicted;     // Execution detected mispredict
    logic [31:0] correct_pc;       // Corrected target PC
    logic [32*6-1:0] rat_snapshot; // Full RAT state at allocation
} brat_entry_t;
```

#### 5.2.2 Key Operations

**Allocation (Issue Stage)**:
```
When branch instruction decoded:
1. Push entry at BRAT tail
2. Store rob_id, is_jalr, pc_at_prediction
3. Capture current RAT snapshot
4. Initialize resolved=0, mispredicted=0
```

**Execute Result Write**:
```
When branch executes:
1. Search BRAT for matching rob_id
2. Write resolved=1, mispredicted, correct_pc
3. Trigger combinational bypass if at head
```

**In-Order Resolution Output**:
```
Every cycle, check BRAT head(s):
├─ If head.resolved && head.mispredicted:
│   ├─ Output branch_mispredicted_o[i] = 1
│   ├─ Output correct_pc_i_o = head.correct_pc
│   ├─ Output is_jalr_i_o = head.is_jalr
│   ├─ Output pc_at_prediction_i_o = head.pc_at_prediction
│   └─ Restore RAT from head.rat_snapshot
│
├─ If head.resolved && !head.mispredicted:
│   ├─ Output branch_resolved_o[i] = 1
│   ├─ Output update_valid = 1 (predictor update)
│   └─ Dequeue head (no restore needed)
│
└─ If !head.resolved:
    └─ Stall outputs until resolved
```

#### 5.2.3 Combinational Bypass

BRAT implements same-cycle bypass for minimal latency:

```systemverilog
// If execute result arrives for head entry this cycle
assign head_entry_data = (exec_branch_valid_i[j] && 
                          exec_rob_id_i[j] == head_rob_id) ?
                         {1'b1, exec_mispredicted_i[j], exec_correct_pc_i[j]} :
                         stored_head_data;
```

This ensures misprediction recovery begins in the same cycle the branch executes.

### 5.3 BRAT Output Distribution

```
BRAT Outputs → Multiple Destinations:
│
├─► Fetch Stage (multi_fetch):
│   ├─ misprediction_i[2:0] → PC redirect
│   ├─ update_valid_i[2:0] → predictor update
│   ├─ is_jalr_i[2:0] → select branch/JALR predictor
│   ├─ pc_at_prediction_i[2:0] → predictor table index
│   └─ correct_pc_i[2:0] → new fetch address
│
├─► RAT (register_alias_table):
│   └─ Restore snapshot on misprediction
│
├─► ROB (reorder_buffer):
│   └─ branch_misprediction_i → tail truncation
│
├─► RS (reservation_station × 3):
│   └─ branch_misprediction_i → flush younger entries
│
└─► LSQ (lsq_simple_top):
    └─ branch_misprediction_i → flush younger entries
```

---

## 6. Dispatch Stage (`dispatch_stage`)

### 6.1 Module: `reorder_buffer`

The ROB tracks in-flight instructions for in-order commit and precise exceptions.

#### 6.1.1 Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `ROB_DEPTH` | 32 | Number of ROB entries |
| `TAG_WIDTH` | 3 | Producer tag bits |
| `DATA_WIDTH` | 32 | Result data width |

#### 6.1.2 ROB Entry Structure

```systemverilog
typedef struct packed {
    logic [31:0] data;         // Result data
    logic [2:0]  tag;          // Producer tag (111=ready)
    logic [4:0]  rd_arch;      // Architectural destination
    logic [5:0]  rd_phys;      // Physical destination
    logic [5:0]  old_phys;     // Old physical mapping (for free list)
    logic        executed;     // Execution complete
    logic        is_store;     // Store instruction
    logic        is_branch;    // Branch instruction
    logic        exception;    // Misprediction flag
    logic [31:0] correct_pc;   // For branch misprediction
    logic [31:0] pc;           // Instruction PC (debug)
} rob_entry_t;
```

#### 6.1.3 ROB Operations

**Allocation (3-way parallel)**:
```
For each decoded instruction:
1. Allocate entry at ROB tail
2. Store rd_arch, rd_phys, old_phys, is_store, is_branch
3. Initialize tag = producer_tag (or 111 if no dependency)
4. Increment tail pointer
```

**CDB Write (6 channels)**:
```
When CDB broadcast arrives:
1. Match cdb_rob_id to ROB entry
2. Write data = cdb_data
3. Write executed = 1
4. If branch && mispredicted: exception = 1, correct_pc = cdb_correct_pc
```

**Commit (3-way in-order)**:
```
For up to 3 consecutive head entries:
├─ If head.executed && !head.exception:
│   ├─ Commit to register file (if rd != x0)
│   ├─ Return old_phys to free list
│   ├─ If is_store: grant store permission to LSQ
│   └─ Dequeue head
│
└─ If head.exception:
    └─ Handled by BRAT (eager recovery)
```

#### 6.1.4 Eager Misprediction Tail Truncation

```systemverilog
// When BRAT signals misprediction
always_ff @(posedge clk_i) begin
    if (branch_misprediction_i) begin
        // Find mispredicting branch ROB ID
        // Truncate tail to entry after mispredicting branch
        tail_ptr <= mispredicting_rob_id + 1;
        
        // Invalidate all entries after mispredicting branch
        for (int i = 0; i < ROB_DEPTH; i++) begin
            if (is_younger(i, mispredicting_rob_id))
                rob_valid[i] <= 1'b0;
        end
    end
end
```

### 6.2 Module: `reservation_station`

Single-entry Tomasulo reservation station with CDB snooping.

#### 6.2.1 RS Entry Structure

```systemverilog
typedef struct packed {
    logic [31:0] operand_a_data;
    logic [2:0]  operand_a_tag;    // 111 = ready
    logic [31:0] operand_b_data;
    logic [2:0]  operand_b_tag;    // 111 = ready
    logic [5:0]  rd_phys;
    logic [4:0]  rob_id;
    logic [10:0] control_signals;
    logic [31:0] pc;
    logic [31:0] immediate;
    logic        valid;
    logic        is_branch;
    logic        branch_prediction;
} rs_entry_t;
```

#### 6.2.2 Tag Encoding

| Tag | Source | Description |
|-----|--------|-------------|
| 3'b000 | ALU0 | Waiting for ALU0 result |
| 3'b001 | ALU1 | Waiting for ALU1 result |
| 3'b010 | ALU2 | Waiting for ALU2 result |
| 3'b011 | LSQ | Waiting for load result |
| 3'b111 | Ready | Data available in register |

#### 6.2.3 CDB Snooping

```systemverilog
// CDB monitoring for operand wake-up
always_comb begin
    operand_a_ready = (operand_a_tag == 3'b111);
    operand_b_ready = (operand_b_tag == 3'b111);
    
    // Check CDB for matching tags
    for (int i = 0; i < 6; i++) begin
        if (cdb_valid[i]) begin
            if (operand_a_tag == cdb_tag[i]) begin
                operand_a_ready = 1'b1;
                operand_a_data = cdb_data[i];  // Forward from CDB
            end
            if (operand_b_tag == cdb_tag[i]) begin
                operand_b_ready = 1'b1;
                operand_b_data = cdb_data[i];
            end
        end
    end
    
    issue_ready = valid && operand_a_ready && operand_b_ready;
end
```

### 6.3 Module: `multi_port_register_file`

64-entry physical register file with 6 read and 3 write ports.

| Parameter | Value |
|-----------|-------|
| Depth | 64 registers |
| Read Ports | 6 (2 per RS) |
| Write Ports | 3 (commit) |
| Data Width | 32 bits |

**Port Assignment**:
- Read ports 0,1 → RS0
- Read ports 2,3 → RS1  
- Read ports 4,5 → RS2
- Write ports 0,1,2 → ROB commit

### 6.4 Module: `lsq_simple_top`

Load-Store Queue for memory operation ordering.

#### 6.4.1 Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `LSQ_DEPTH` | 32 | Queue entries |
| `NUM_PORTS` | 3 | Memory ports |

#### 6.4.2 LSQ Entry Structure

```systemverilog
typedef struct packed {
    logic [31:0] address;
    logic [31:0] data;
    logic [1:0]  size;        // 00=B, 01=H, 10=W
    logic        is_store;
    logic [4:0]  rob_id;
    logic        address_valid;
    logic        data_valid;   // For stores
    logic        committed;    // Store can issue to memory
    logic        completed;
} lsq_entry_t;
```

#### 6.4.3 Store-to-Load Forwarding

```
When load address calculated:
1. Search all older stores for address match
2. If match found && store.data_valid:
   └─ Forward store data to load (bypass memory)
3. If match found && !store.data_valid:
   └─ Stall load until store data ready
4. If no match:
   └─ Issue load to memory
```

---

## 7. Execute Stage (`superscalar_execute_stage`)

### 7.1 Module: `function_unit_alu_shifter`

Full-width RV32I ALU with single-cycle latency.

#### 7.1.1 Operations

| func_sel | Operation | Implementation |
|----------|-----------|----------------|
| 0000 | ADD | `a + b` |
| 0001 | SUB | `a - b` |
| 0010 | SLT | `$signed(a) < $signed(b)` |
| 0011 | SLTU | `a < b` |
| 0100 | AND | `a & b` |
| 0101 | OR | `a \| b` |
| 0110 | XOR | `a ^ b` |
| 0111 | SLL | `a << b[4:0]` |
| 1000 | SRL | `a >> b[4:0]` |
| 1001 | SRA | `$signed(a) >>> b[4:0]` |
| 1010 | PASS_B | `b` (for LUI/AUIPC) |

### 7.2 Branch Resolution

Each FU contains a branch controller for conditional evaluation:

```systemverilog
// Branch condition evaluation
always_comb begin
    case (branch_sel)
        3'b001: branch_taken = (operand_a == operand_b);           // BEQ
        3'b010: branch_taken = (operand_a != operand_b);           // BNE
        3'b011: branch_taken = ($signed(operand_a) < $signed(operand_b));   // BLT
        3'b100: branch_taken = ($signed(operand_a) >= $signed(operand_b));  // BGE
        3'b101: branch_taken = (operand_a < operand_b);            // BLTU
        3'b110: branch_taken = (operand_a >= operand_b);           // BGEU
        3'b111: branch_taken = 1'b1;                               // JALR
        default: branch_taken = 1'b0;
    endcase
    
    mispredicted = is_branch && (branch_taken != branch_prediction);
    
    // Correct PC calculation
    if (is_jalr)
        correct_pc = (operand_a + immediate) & ~32'b1;  // JALR target
    else if (branch_taken)
        correct_pc = pc + immediate;                     // Branch target
    else
        correct_pc = pc + 4;                             // Fall-through
end
```

### 7.3 CDB Interface

```systemverilog
interface cdb_if;
    // 6 broadcast channels
    logic        valid   [5:0];
    logic [31:0] data    [5:0];
    logic [2:0]  tag     [5:0];
    logic [5:0]  rd_phys [5:0];
    logic [4:0]  rob_id  [5:0];
    
    // Branch-specific
    logic        is_branch [5:0];
    logic        mispredicted [5:0];
    logic [31:0] correct_pc [5:0];
    
    modport producer(output valid, data, tag, rd_phys, rob_id, is_branch, mispredicted, correct_pc);
    modport consumer(input  valid, data, tag, rd_phys, rob_id, is_branch, mispredicted, correct_pc);
endinterface
```

---

## 8. Data Flow Summary

### 8.1 Normal Instruction Flow

```
Cycle 1: FETCH
├─ PC → I-Mem → instruction[4:0]
├─ Branch prediction for control flow
└─ Push to instruction buffer

Cycle 2: ISSUE  
├─ Pop 3 instructions from buffer
├─ Decode → control word + immediate
├─ RAT rename: arch_reg → phys_reg
├─ If branch: BRAT push with RAT snapshot
└─ Output to dispatch pipeline registers

Cycle 3: DISPATCH
├─ ROB allocation → rob_id
├─ RF read → operand data or tag
├─ RS dispatch with operands/tags
├─ LSQ allocation (if load/store)
└─ CDB snoop for same-cycle operands

Cycle 4: EXECUTE
├─ RS issue when operands ready
├─ ALU compute result
├─ Branch resolution
├─ CDB broadcast: result + rob_id + tag
└─ BRAT write if branch

Cycle 5: COMMIT
├─ ROB head check for completion
├─ In-order retire (up to 3)
├─ RF write: phys_reg ← result
├─ RAT commit: free old phys_reg
└─ LSQ store grant if store
```

### 8.2 Misprediction Recovery Flow

```
Cycle N: Execute detects misprediction
├─ CDB broadcasts exception to ROB
└─ BRAT receives execute result

Cycle N (same cycle via bypass): BRAT outputs in-order
├─ branch_mispredicted_o[i] = 1
├─ correct_pc_o = corrected address
├─ is_jalr_o = branch type
└─ pc_at_prediction_o = for predictor update

Cycle N (same cycle): All modules react
├─ Fetch: PC ← correct_pc, flush buffer
├─ RAT: Restore from BRAT snapshot
├─ ROB: Truncate tail to mispredicting ROB ID
├─ RS: Flush younger entries
└─ LSQ: Flush younger entries

Cycle N+1: Normal fetch resumes from correct_pc
```

---

## 9. Performance Characteristics

### 9.1 Theoretical Maximum

| Metric | Value | Notes |
|--------|-------|-------|
| Peak IPC | 3.0 | All 3 FUs active |
| Fetch Bandwidth | 5 inst/cycle | I-Mem limited |
| Commit Bandwidth | 3 inst/cycle | ROB limited |

### 9.2 Realistic IPC Range

| Workload Type | Expected IPC | Bottleneck |
|---------------|--------------|------------|
| Sequential ALU | 2.5-3.0 | RS depth |
| Branch-heavy | 1.5-2.0 | Misprediction |
| Memory-heavy | 1.0-2.0 | LSQ/memory latency |
| Mixed | 1.8-2.5 | Various |

### 9.3 Critical Paths

| Path | Stages | Timing Impact |
|------|--------|---------------|
| RAT Lookup | Issue | ~1 gate delay |
| RF Read + Tag Check | Dispatch | ~2 gate delays |
| CDB Broadcast | Execute→Dispatch | ~1 gate delay |
| BRAT Bypass | Execute→Output | ~1 gate delay |

---

## 10. Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-09-15 | Initial specification |
| 2.0 | 2025-12-01 | BRAT v2 integration, eager recovery |
| 2.1 | 2025-12-15 | Simplified BRAT interface (5 signals) |

---

*This document reflects the current architecture of the superscalar-clean branch.*
