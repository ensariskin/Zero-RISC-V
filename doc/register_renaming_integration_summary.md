# Register Renaming & BRAT Integration Summary

## 1. Overview

This document describes the Register Alias Table (RAT) and Branch Resolution Alias Table (BRAT) integration in the RV32I superscalar processor. The design implements Tomasulo-style register renaming with speculative execution support via BRAT for efficient misprediction recovery.

### 1.1 Key Components

| Component | Module | Description |
|-----------|--------|-------------|
| RAT | `register_alias_table.sv` | Maps 32 arch → 64 phys registers |
| Free List | `circular_buffer_3port.sv` | Manages available physical registers |
| BRAT | `brat_circular_buffer.sv` | Stores RAT snapshots for branch speculation |

### 1.2 Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       register_alias_table                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │               RAT Mapping Table (32 × 6-bit)                       │ │
│  │  rat_table[arch_reg] = phys_reg                                    │ │
│  │  arch_reg[0..31] → phys_reg[0..63]                                 │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                                                          │
│  ┌──────────────────────┐    ┌──────────────────────┐                   │
│  │  free_address_buffer │    │  lsq_address_buffer  │                   │
│  │  (Physical Reg Pool) │    │  (LSQ Index Pool)    │                   │
│  │  circular_buffer_3port│    │  circular_buffer_3port│                  │
│  └──────────────────────┘    └──────────────────────┘                   │
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                    brat_buffer (BRAT v2)                           │ │
│  │  brat_circular_buffer - 16 entries                                 │ │
│  │  - RAT snapshot storage                                            │ │
│  │  - In-order branch resolution                                      │ │
│  │  - Combinational bypass for low latency                            │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 2. RAT (Register Alias Table)

### 2.1 Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `ARCH_REG_COUNT` | 32 | Architectural registers (x0-x31) |
| `PHYS_REG_BITS` | 6 | Physical register address width |
| `PHYS_REG_COUNT` | 64 | Total physical registers |
| `FREE_LIST_SIZE` | 32 | Available for renaming (32-63) |

### 2.2 RAT Mapping Table

```systemverilog
// RAT entry: 6-bit physical register address
logic [5:0] rat_table [0:31];

// Initial state: identity mapping (arch_i → phys_i)
initial begin
    for (int i = 0; i < 32; i++)
        rat_table[i] = i[5:0];  // x0→0, x1→1, ..., x31→31
end
```

### 2.3 Register Renaming Interface

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `rs1_arch_i_0..2` | 5 each | Input | Source 1 architectural |
| `rs2_arch_i_0..2` | 5 each | Input | Source 2 architectural |
| `rd_arch_i_0..2` | 5 each | Input | Destination architectural |
| `rd_we_i_0..2` | 1 each | Input | Destination write enable |
| `rs1_phys_o_0..2` | 6 each | Output | Source 1 physical |
| `rs2_phys_o_0..2` | 6 each | Output | Source 2 physical |
| `rd_phys_o_0..2` | 6 each | Output | New destination physical |
| `rd_old_phys_o_0..2` | 6 each | Output | Old destination physical |

### 2.4 Renaming Flow (3-Way Parallel)

```
Per-Instruction Renaming (Instruction N):

1. READ PHASE (combinational):
   ├─ rs1_phys[N] = rat_table[rs1_arch[N]]
   └─ rs2_phys[N] = rat_table[rs2_arch[N]]

2. ALLOCATE PHASE (if rd_we[N] && rd_arch[N] != 0):
   ├─ rd_old_phys[N] = rat_table[rd_arch[N]]
   ├─ rd_phys[N] = free_list.pop()
   └─ rat_table[rd_arch[N]] = rd_phys[N]

3. SAME-CYCLE FORWARDING:
   └─ If inst_1 reads what inst_0 writes:
      rs1_phys[1] = rd_phys[0]  (bypass RAT lookup)
```

### 2.5 Free List Management

The free list is implemented as `circular_buffer_3port`:

```
Free List Structure:
├─ Depth: 32 entries (indices 32-63)
├─ Initial: All physical regs 32-63 available
├─ Allocation: Pop head (up to 3/cycle)
├─ Deallocation: Push to tail (on commit)
└─ 3-port: Supports 3-way superscalar

Allocation Flow:
1. Check free_list.count >= num_allocations
2. Pop head for each rd requiring rename
3. Return old_phys to issue stage (for ROB)

Commit Flow (from ROB):
1. Receive old_phys_reg from committed instruction
2. Push to free list tail
3. Register now available for reuse
```

### 2.6 Commit Interface

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `commit_enable_i_0..2` | 1 each | Input | Commit valid |
| `commit_old_phys_i_0..2` | 6 each | Input | Old phys reg to free |
| `commit_arch_i_0..2` | 5 each | Input | Arch reg (for validation) |

---

## 3. BRAT (Branch Resolution Alias Table)

### 3.1 Purpose

BRAT enables **eager misprediction recovery** by:
1. Storing RAT snapshots when branches are decoded
2. Outputting resolved branches in program order
3. Restoring RAT instantly on misprediction (no ROB drain)

### 3.2 BRAT Entry Structure

```systemverilog
typedef struct packed {
    logic [4:0]  rob_id;            // ROB index for matching
    logic        is_jalr;           // 0=branch, 1=JALR
    logic [31:0] pc_at_prediction;  // PC for predictor table update
    logic        resolved;          // Branch has executed
    logic        mispredicted;      // Misprediction detected
    logic [31:0] correct_pc;        // Corrected target PC
    logic [32*6-1:0] rat_snapshot;  // Full RAT state (32×6 = 192 bits)
} brat_entry_t;
```

### 3.3 BRAT Interface

**Allocation (from Issue Stage)**:
| Signal | Width | Description |
|--------|-------|-------------|
| `alloc_enable_i[2:0]` | 3 | Branch allocation enables |
| `alloc_rob_id_0..2_i` | 5 each | ROB IDs of branches |
| `alloc_is_jalr_0..2_i` | 1 each | JALR vs branch type |
| `alloc_pc_at_prediction_0..2_i` | 32 each | PCs for predictor |
| `alloc_snapshot_data_i` | 192 | Current RAT snapshot |

**Execute Result Write**:
| Signal | Width | Description |
|--------|-------|-------------|
| `exec_branch_valid_i[2:0]` | 3 | Branch executed flags |
| `exec_mispredicted_i[2:0]` | 3 | Misprediction flags |
| `exec_rob_id_0..2_i` | 5 each | ROB IDs of executed branches |
| `exec_correct_pc_0..2_i` | 32 each | Corrected PC values |

**In-Order Resolution Outputs**:
| Signal | Width | Description |
|--------|-------|-------------|
| `branch_resolved_o[2:0]` | 3 | In-order resolved signals |
| `branch_mispredicted_o[2:0]` | 3 | In-order misprediction |
| `correct_pc_0..2_o` | 32 each | Corrected PC values |
| `is_jalr_0..2_o` | 1 each | JALR vs branch type |
| `pc_at_prediction_0..2_o` | 32 each | PCs for predictor update |
| `restore_snapshot_o` | 192 | RAT snapshot to restore |

### 3.4 BRAT Operation

```
ALLOCATION (When branch decoded):
1. Push entry at BRAT tail
2. Store: rob_id, is_jalr, pc_at_prediction
3. Capture current RAT snapshot
4. Initialize: resolved=0, mispredicted=0

EXECUTE RESULT WRITE (When branch executes):
1. Search BRAT for matching rob_id
2. Write: resolved=1, mispredicted, correct_pc
3. If at head: trigger combinational bypass

IN-ORDER RESOLUTION OUTPUT (Every cycle):
1. Check head entry(ies)
2. If head.resolved:
   ├─ Output resolution signals
   ├─ If mispredicted: output restore_snapshot
   └─ Dequeue head
3. If !head.resolved: stall outputs
```

### 3.5 Combinational Bypass

BRAT implements same-cycle bypass for minimum latency:

```systemverilog
// If execute result arrives for head entry this cycle
wire bypass_active = exec_branch_valid_i[j] && 
                     exec_rob_id_i[j] == head_rob_id;

assign head_resolved = bypass_active ? 1'b1 : stored_head_resolved;
assign head_mispredicted = bypass_active ? exec_mispredicted_i[j] : stored_mispredicted;
assign head_correct_pc = bypass_active ? exec_correct_pc_i[j] : stored_correct_pc;
```

This ensures misprediction recovery begins the same cycle the branch executes.

---

## 4. Integration in Issue Stage

### 4.1 Issue Stage RAT Usage

```systemverilog
// Instantiate RAT in issue_stage
register_alias_table rat (
    // Rename inputs (from decoders)
    .rs1_arch_i_0(rs1_arch_0), .rs1_arch_i_1(rs1_arch_1), .rs1_arch_i_2(rs1_arch_2),
    .rs2_arch_i_0(rs2_arch_0), .rs2_arch_i_1(rs2_arch_1), .rs2_arch_i_2(rs2_arch_2),
    .rd_arch_i_0(rd_arch_0),   .rd_arch_i_1(rd_arch_1),   .rd_arch_i_2(rd_arch_2),
    .rd_we_i_0(we_0),          .rd_we_i_1(we_1),          .rd_we_i_2(we_2),
    
    // Branch interface (to BRAT)
    .branch_0_i(is_branch_0), .branch_1_i(is_branch_1), .branch_2_i(is_branch_2),
    .branch_rob_id_0_i(rob_id_0), .branch_rob_id_1_i(rob_id_1), .branch_rob_id_2_i(rob_id_2),
    
    // Renamed outputs (to dispatch)
    .rs1_phys_o_0(rs1_phys_0), .rs1_phys_o_1(rs1_phys_1), .rs1_phys_o_2(rs1_phys_2),
    .rs2_phys_o_0(rs2_phys_0), .rs2_phys_o_1(rs2_phys_1), .rs2_phys_o_2(rs2_phys_2),
    .rd_phys_o_0(rd_phys_0),   .rd_phys_o_1(rd_phys_1),   .rd_phys_o_2(rd_phys_2),
    .rd_old_phys_o_0(old_phys_0), .rd_old_phys_o_1(old_phys_1), .rd_old_phys_o_2(old_phys_2),
    
    // BRAT outputs (to fetch, ROB, RS, LSQ)
    .branch_resolved_o(brat_resolved),
    .branch_mispredicted_o(brat_mispredicted),
    .correct_pc_0_o(brat_correct_pc_0), ...
);
```

### 4.2 BRAT Output Distribution

```
BRAT Outputs → Multiple Destinations:

1. Fetch Stage (multi_fetch):
   ├─ misprediction_i[2:0]      → PC redirect
   ├─ update_valid_i[2:0]       → Predictor update
   ├─ is_jalr_i[2:0]            → Select branch/JALR predictor
   ├─ pc_at_prediction_i[2:0]   → Predictor table index
   └─ correct_pc_i[2:0]         → New fetch address

2. RAT (internal):
   └─ restore_snapshot          → Restore mapping table

3. ROB (reorder_buffer):
   └─ branch_misprediction_i    → Tail truncation

4. RS (reservation_station × 3):
   └─ branch_misprediction_i    → Flush younger entries

5. LSQ (lsq_simple_top):
   └─ branch_misprediction_i    → Flush younger entries
```

---

## 5. Misprediction Recovery

### 5.1 Traditional vs BRAT Recovery

**Traditional (ROB-based)**:
```
1. Branch misprediction detected in execute
2. ROB marks entry as exception
3. Wait for branch to reach ROB head
4. Drain all younger instructions
5. Restore architectural state
6. Redirect fetch to correct PC
Total: ~10-20 cycles penalty
```

**BRAT-based (Eager)**:
```
1. Branch misprediction detected in execute
2. BRAT receives result (same cycle via bypass)
3. BRAT outputs in-order (oldest mispredicted first)
4. Same cycle: All modules receive flush signal
   ├─ RAT restores snapshot
   ├─ ROB truncates tail
   ├─ RS/LSQ flush younger entries
   └─ Fetch redirects to correct PC
5. Next cycle: Correct-path execution begins
Total: 1-2 cycles penalty
```

### 5.2 RAT Snapshot Restore

```systemverilog
// On misprediction, restore RAT from BRAT snapshot
always_ff @(posedge clk) begin
    if (brat_mispredicted_o[0]) begin
        // Restore all 32 entries from snapshot
        for (int i = 0; i < 32; i++) begin
            rat_table[i] <= restore_snapshot[i*6 +: 6];
        end
        // Also restore free list state (separate mechanism)
    end
end
```

---

## 6. Same-Cycle Forwarding

### 6.1 Intra-Group Forwarding

When multiple instructions rename in the same cycle, later instructions must see earlier renames:

```systemverilog
// Instruction 0 renames rd_0
// Instruction 1 reads rs1_1 = rd_0 → must get rd_phys_0

// Forwarding logic
always_comb begin
    // Default: read from RAT
    rs1_phys_1 = rat_table[rs1_arch_1];
    
    // Forward from inst_0 if dependency
    if (rd_we_0 && rd_arch_0 == rs1_arch_1 && rd_arch_0 != 0) begin
        rs1_phys_1 = rd_phys_0;  // Bypass RAT lookup
    end
end
```

### 6.2 Commit Forwarding

When commit and rename happen same cycle for same arch reg:

```systemverilog
// Commit frees old_phys for arch_reg X
// Rename allocates new_phys for arch_reg X
// Read of arch_reg X should return new_phys (not committed value)

// This is handled by RAT lookup happening after rename update
```

---

## 7. LSQ Index Allocation

The RAT module also manages LSQ index allocation via `lsq_address_buffer`:

```systemverilog
circular_buffer_3port #(.DEPTH(32), .DATA_WIDTH(5)) lsq_address_buffer (
    // Allocation (for memory ops)
    .alloc_enable_0_i(is_mem_op_0), .alloc_data_o_0(lsq_idx_0),
    .alloc_enable_1_i(is_mem_op_1), .alloc_data_o_1(lsq_idx_1),
    .alloc_enable_2_i(is_mem_op_2), .alloc_data_o_2(lsq_idx_2),
    
    // Deallocation (from LSQ commit)
    .dealloc_enable_0_i(lsq_commit_0), .dealloc_data_i_0(lsq_commit_idx_0),
    ...
);
```

---

## 8. Performance Characteristics

### 8.1 Latency

| Operation | Cycles | Notes |
|-----------|--------|-------|
| RAT Lookup | 0 | Combinational |
| RAT Update | 1 | Next cycle visible |
| Free List Pop | 0 | Combinational |
| BRAT Allocation | 1 | Next cycle in queue |
| BRAT Bypass | 0 | Same-cycle execute→output |
| RAT Restore | 1 | Single-cycle restore |

### 8.2 Area Overhead

| Component | Bits | Description |
|-----------|------|-------------|
| RAT Table | 192 | 32 × 6-bit entries |
| Free List | 192 | 32 × 6-bit entries |
| BRAT Entries | 3,840 | 16 × 240-bit entries |
| Control Logic | ~500 | FSM, comparators |
| **Total** | ~4,724 | ~590 bytes |

---

## 9. Verification Points

### 9.1 RAT Assertions

```systemverilog
// x0 always maps to physical 0
assert property (@(posedge clk) rat_table[0] == 6'd0);

// No duplicate physical register mappings
assert property (@(posedge clk) 
    $onehot0({(rat_table[0] == 6'd32), (rat_table[1] == 6'd32), ...}));

// Free list count + allocated count = 32
assert property (@(posedge clk)
    free_list.count + allocated_count == 32);
```

### 9.2 BRAT Assertions

```systemverilog
// In-order output: older branches resolve first
assert property (@(posedge clk)
    branch_resolved_o[1] |-> branch_resolved_o[0]);

// No output without resolution
assert property (@(posedge clk)
    branch_mispredicted_o[i] |-> branch_resolved_o[i]);

// Snapshot restore only on misprediction
assert property (@(posedge clk)
    |restore_snapshot |-> |branch_mispredicted_o);
```

---

## 10. Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-09 | Initial RAT integration |
| 2.0 | 2025-12 | BRAT v2, simplified interface, is_jalr/pc_at_prediction support |

---

*This document reflects the current implementation in `register_alias_table.sv` and `brat_circular_buffer.sv`.*
