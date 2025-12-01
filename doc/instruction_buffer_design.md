# Instruction Buffer Design Specification

## 1. Overview

The instruction buffer (`instruction_buffer_new`) is a critical decoupling component between the fetch and decode stages in the RV32I superscalar processor. It handles variable-width instruction flow (5-in, 3-out) and provides necessary buffering for optimal pipeline utilization.

### 1.1 Key Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| `BUFFER_DEPTH` | 16 | Total FIFO entries (power of 2) |
| `DATA_WIDTH` | 32 | Instruction/PC width |
| Input Width | 5 | Max instructions from fetch per cycle |
| Output Width | 3 | Max instructions to decode per cycle |

### 1.2 Design Goals

1. **Fetch-Decode Decoupling**: Allow different rates between stages
2. **Variable Width Support**: Handle 0-5 input, 0-3 output per cycle
3. **Eager Flush**: Instant clear on misprediction for fast recovery
4. **No Deadlock**: Conservative backpressure prevents overflow

---

## 2. Architecture

### 2.1 Block Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                      instruction_buffer_new                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    16-Entry Circular FIFO                    │   │
│  │  ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐         │   │
│  │  │  0  │  1  │  2  │  3  │  4  │  5  │  6  │  7  │  ...    │   │
│  │  └─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘         │   │
│  │       ▲                                   ▲                 │   │
│  │       │                                   │                 │   │
│  │    head_ptr                            tail_ptr             │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐           │
│  │ Write    │  │ Read     │  │ Count    │  │ Flow     │           │
│  │ Control  │  │ Control  │  │ Tracker  │  │ Control  │           │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
         │                              │
         ▼                              ▼
┌─────────────────┐          ┌──────────────────┐
│   multi_fetch   │          │   issue_stage    │
│   (5 inst/cyc)  │          │   (3 inst/cyc)   │
└─────────────────┘          └──────────────────┘
```

### 2.2 Entry Structure

Each buffer entry contains:

```systemverilog
// Per-entry storage (separate memory arrays for synthesis)
logic [31:0] instruction_mem [0:15];     // 32-bit instruction word
logic [31:0] pc_mem [0:15];              // PC value of instruction
logic [31:0] imm_mem [0:15];             // Pre-decoded immediate
logic [31:0] pc_at_prediction_mem [0:15]; // PC for predictor update
logic        branch_prediction_mem [0:15]; // Branch prediction result
```

**Entry Size**: 32 + 32 + 32 + 32 + 1 = 129 bits per entry

**Total Storage**: 16 × 129 = 2,064 bits ≈ 258 bytes

---

## 3. Interface Specification

### 3.1 Input Interface (from multi_fetch)

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `fetch_valid_i` | 5 | Input | Bitmap of valid fetched instructions |
| `instruction_i_0..4` | 32 each | Input | Instruction words |
| `pc_i_0..4` | 32 each | Input | PC values |
| `imm_i_0..4` | 32 each | Input | Pre-decoded immediates |
| `pc_at_prediction_i_0..4` | 32 each | Input | PCs for predictor |
| `branch_prediction_i_0..4` | 1 each | Input | Branch predictions |

### 3.2 Output Interface (to issue_stage)

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `decode_valid_o` | 3 | Output | Bitmap of valid output instructions |
| `instruction_o_0..2` | 32 each | Output | Instruction words |
| `pc_o_0..2` | 32 each | Output | PC values |
| `imm_o_0..2` | 32 each | Output | Pre-decoded immediates |
| `pc_value_at_prediction_o_0..2` | 32 each | Output | PCs for predictor |
| `branch_prediction_o_0..2` | 1 each | Output | Branch predictions |

### 3.3 Control Signals

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `decode_ready_i` | 3 | Input | Which decode slots accept instructions |
| `fetch_ready_o` | 1 | Output | Buffer can accept from fetch |
| `flush_i` | 1 | Input | Flush entire buffer (misprediction) |

### 3.4 Status Outputs

| Signal | Width | Description |
|--------|-------|-------------|
| `buffer_empty_o` | 1 | Buffer has no valid entries |
| `buffer_full_o` | 1 | Buffer nearly full (space < 3) |
| `occupancy_o` | 5 | Current entry count (0-16) |

---

## 4. Operation Details

### 4.1 Pointer Management

```systemverilog
// Circular buffer pointers (5 bits for 16 entries + wrap)
logic [4:0] head_ptr;    // Next read location
logic [4:0] tail_ptr;    // Next write location
logic [4:0] count;       // Valid entry count (0-16)

// Pointer wrap using modulo (synthesizable)
next_tail = (tail_ptr + num_to_write) % BUFFER_DEPTH;
next_head = (head_ptr + num_to_read) % BUFFER_DEPTH;
```

### 4.2 Write Operation

```
Write Flow (per cycle):
1. Check space_available = BUFFER_DEPTH - count
2. If fetch_ready_o asserted:
   ├─ Count valid bits in fetch_valid_i[4:0]
   ├─ num_to_write = popcount(fetch_valid_i)
   │
   ├─ For each valid input:
   │   ├─ instruction_mem[tail_ptr + offset] ← instruction_i_n
   │   ├─ pc_mem[tail_ptr + offset] ← pc_i_n
   │   ├─ imm_mem[tail_ptr + offset] ← imm_i_n
   │   ├─ pc_at_prediction_mem[...] ← pc_at_prediction_i_n
   │   └─ branch_prediction_mem[...] ← branch_prediction_i_n
   │
   └─ tail_ptr ← (tail_ptr + num_to_write) % BUFFER_DEPTH
```

### 4.3 Read Operation

```
Read Flow (per cycle):
1. Check instructions_available = min(count, 3)
2. For each decode_ready_i[n]:
   ├─ If instructions available:
   │   ├─ decode_valid_o[n] = 1
   │   ├─ Output data from head_ptr + offset
   │   └─ Increment read count
   │
3. head_ptr ← (head_ptr + num_to_read) % BUFFER_DEPTH
```

### 4.4 Backpressure Logic

```systemverilog
// Conservative backpressure to prevent deadlock
// Leave space for maximum fetch width (5 instructions)
assign fetch_ready_o = !flush_i && 
                       !buffer_full_o && 
                       (space_available >= 5);

// Full when less than 3 spaces remain
assign buffer_full_o = (count >= (BUFFER_DEPTH - 3));
```

### 4.5 Flush Operation

```systemverilog
// Immediate flush on misprediction
if (flush_i) begin
    head_ptr <= 0;
    tail_ptr <= 0;
    count <= 0;
    // Memory contents don't need clearing (will be overwritten)
end
```

---

## 5. Timing Characteristics

### 5.1 Pipeline Integration

```
Cycle N:   multi_fetch produces instructions
           ↓
Cycle N:   instruction_buffer writes (same cycle, posedge)
           ↓
Cycle N+1: instruction_buffer outputs available
           ↓
Cycle N+1: issue_stage reads and decodes
```

### 5.2 Latency Analysis

| Operation | Cycles | Notes |
|-----------|--------|-------|
| Fetch → Buffer Write | 0 | Same-cycle push |
| Buffer Read → Decode | 0 | Combinational output |
| Flush → Empty | 1 | Single-cycle clear |
| Full → Ready | 1 | After decode consumes |

### 5.3 Critical Paths

| Path | Logic Depth | Mitigation |
|------|-------------|------------|
| `fetch_valid_i` → `num_to_write` | Popcount | Small (5-bit) |
| `head_ptr` → Output MUX | Address decode + MUX | Parallel memory |
| `count` → `fetch_ready_o` | Compare | Simple threshold |

---

## 6. Operational Scenarios

### 6.1 Normal Operation (No Branches)

```
Cycle  | Fetch Valid | Buffer Count | Decode Ready | Actions
-------|-------------|--------------|--------------|--------
  1    | 5'b11111    | 0 → 5        | 3'b111       | Push 5
  2    | 5'b11111    | 5 → 7        | 3'b111       | Push 5, Pop 3
  3    | 5'b11111    | 7 → 9        | 3'b111       | Push 5, Pop 3
  ...  | Steady state at ~6-8 entries |
```

### 6.2 Decode Stall

```
Cycle  | Fetch Valid | Buffer Count | Decode Ready | Actions
-------|-------------|--------------|--------------|--------
  1    | 5'b11111    | 5 → 10       | 3'b000       | Push 5, Pop 0
  2    | 5'b11111    | 10 → 15      | 3'b000       | Push 5, Pop 0
  3    | 5'b00000    | 15 → 15      | 3'b000       | fetch_ready=0
  4    | 5'b00000    | 15 → 12      | 3'b111       | Pop 3
  5    | 5'b11111    | 12 → 14      | 3'b111       | fetch_ready=1
```

### 6.3 Branch Misprediction

```
Cycle  | Action
-------|--------
  N    | Execute detects misprediction
  N    | BRAT outputs in-order (combinational bypass)
  N    | flush_i asserted from fetch_buffer_top
  N+1  | Buffer empty (head=tail=count=0)
  N+1  | Correct-path fetch begins
```

### 6.4 I-Cache Miss

```
Cycle  | Fetch Valid | Buffer Count | Decode Ready | Actions
-------|-------------|--------------|--------------|--------
  1    | 5'b00000    | 8 → 5        | 3'b111       | Pop 3 (drain)
  2    | 5'b00000    | 5 → 2        | 3'b111       | Pop 3
  3    | 5'b00000    | 2 → 0        | 3'b110       | Pop 2
  4    | 5'b00000    | 0 → 0        | 3'b000       | Stall decode
  5    | 5'b11111    | 0 → 5        | 3'b111       | I$ hit, refill
```

---

## 7. Integration with Multi-Fetch

### 7.1 Connection Diagram

```
multi_fetch                      instruction_buffer_new
┌──────────────────────┐        ┌────────────────────────┐
│                      │        │                        │
│  fetch_valid_o[4:0] ─┼───────►│ fetch_valid_i[4:0]    │
│                      │        │                        │
│  instruction_o_0..4 ─┼───────►│ instruction_i_0..4    │
│  pc_o_0..4          ─┼───────►│ pc_i_0..4             │
│  imm_o_0..4         ─┼───────►│ imm_i_0..4            │
│  pc_at_pred_o_0..4  ─┼───────►│ pc_at_prediction_i_0..4│
│  branch_pred_o_0..4 ─┼───────►│ branch_prediction_i_0..4│
│                      │        │                        │
│  fetch_ready_i      ◄┼────────┤ fetch_ready_o         │
│                      │        │                        │
└──────────────────────┘        └────────────────────────┘
```

### 7.2 Multi-Fetch Requirements

The multi_fetch module must:

1. **Respect Backpressure**: Only produce when `fetch_ready_i = 1`
2. **Contiguous Valid Bits**: `fetch_valid_o` must be contiguous (no holes)
   - Valid: 5'b00111, 5'b01111, 5'b11111
   - Invalid: 5'b00101 (hole in middle)
3. **Aligned Data**: instruction/pc/imm outputs must align with valid bits

---

## 8. Integration with Issue Stage

### 8.1 Connection Diagram

```
instruction_buffer_new           issue_stage
┌────────────────────────┐      ┌──────────────────────┐
│                        │      │                      │
│  decode_valid_o[2:0]  ─┼─────►│ inst_valid_i[2:0]   │
│                        │      │                      │
│  instruction_o_0..2   ─┼─────►│ instruction_i_0..2  │
│  pc_o_0..2            ─┼─────►│ pc_i_0..2           │
│  imm_o_0..2           ─┼─────►│ imm_i_0..2          │
│  pc_value_at_pred_o   ─┼─────►│ pc_at_pred_i_0..2   │
│  branch_prediction_o  ─┼─────►│ branch_pred_i_0..2  │
│                        │      │                      │
│  decode_ready_i[2:0]  ◄┼──────┤ decode_ready_o[2:0] │
│                        │      │                      │
└────────────────────────┘      └──────────────────────┘
```

### 8.2 Issue Stage Requirements

The issue_stage must:

1. **Drive Ready**: Assert `decode_ready_o[n]` when slot n can accept
2. **Handle Valid**: Only decode when `inst_valid_i[n] = 1`
3. **Contiguous Ready**: Ready bits should be contiguous for efficiency

---

## 9. Debug and Verification

### 9.1 Debug Signals

| Signal | Description |
|--------|-------------|
| `occupancy_o` | Real-time entry count for monitoring |
| `buffer_empty_o` | Indicates potential fetch bottleneck |
| `buffer_full_o` | Indicates potential decode bottleneck |

### 9.2 Assertions (for verification)

```systemverilog
// Pointer invariants
assert property (@(posedge clk) 
    count == ((tail_ptr >= head_ptr) ? 
              (tail_ptr - head_ptr) : 
              (BUFFER_DEPTH - head_ptr + tail_ptr)));

// No overflow
assert property (@(posedge clk)
    count <= BUFFER_DEPTH);

// Valid output consistency
assert property (@(posedge clk)
    decode_valid_o[2] |-> decode_valid_o[1]);
    
assert property (@(posedge clk)
    decode_valid_o[1] |-> decode_valid_o[0]);
```

---

## 10. Performance Impact

### 10.1 Benefits

1. **Fetch-Decode Decoupling**: 5-wide fetch feeds 3-wide decode smoothly
2. **I-Cache Miss Tolerance**: Buffer provides ~5 cycles of runway
3. **Branch Recovery**: Instant flush enables fast redirect
4. **Variable Issue**: Handles complex decode dependencies

### 10.2 Area Overhead

| Component | Bits | Percentage |
|-----------|------|------------|
| Instruction Memory | 512 | 25% |
| PC Memory | 512 | 25% |
| Immediate Memory | 512 | 25% |
| PC at Prediction | 512 | 25% |
| Branch Prediction | 16 | <1% |
| Control Logic | ~100 | ~5% |
| **Total** | ~2,164 | 100% |

---

## 11. Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-09-17 | Initial design |
| 2.0 | 2025-12-01 | Updated for 5-wide fetch, BRAT integration |

---

*This document reflects the current implementation in `instruction_buffer_new.sv`.*
