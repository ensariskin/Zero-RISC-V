# Load-Store Queue (LSQ) Design Specification

## 1. Overview

The Load-Store Queue (`lsq_simple_top`) is a critical component in the RV32I superscalar processor that handles memory ordering, store-to-load forwarding, and speculative execution support through BRAT-based eager misprediction flush.

### 1.1 Key Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| `LSQ_DEPTH` | 32 | Total queue entries |
| `LSQ_ADDR_WIDTH` | 5 | Entry index bits |
| `DATA_WIDTH` | 32 | Data/address width |
| `TAG_WIDTH` | 3 | CDB tag width |
| `ROB_ADDR_WIDTH` | 5 | ROB index width |
| `PHYS_REG_WIDTH` | 6 | Physical register width |
| Memory Ports | 3 | Independent memory interfaces |

### 1.2 Design Philosophy

1. **Simplified Operation**: In-order-ish execution for simplicity
2. **3-Port Memory**: Independent ports for parallel operations
3. **Store Forwarding**: Full forwarding between heads
4. **Eager Flush**: BRAT-distance based speculative entry invalidation

---

## 2. Architecture

### 2.1 Block Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        lsq_simple_top                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                   32-Entry Circular Buffer                          │ │
│  │  ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐       │ │
│  │  │  0   │  1   │  2   │  3   │  4   │  5   │ ...  │  31  │       │ │
│  │  └──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘       │ │
│  │      ▲            ▲            ▲                    ▲              │ │
│  │   head_ptr    head_ptr_1    head_ptr_2           tail_ptr         │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │
│  │  Forwarding  │  │  CDB Snoop   │  │  Eager Flush │                  │
│  │    Logic     │  │    Logic     │  │    Logic     │                  │
│  └──────────────┘  └──────────────┘  └──────────────┘                  │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                 3-Port Memory Interface                           │   │
│  │  mem_0_req  ◄──►  D-Mem Port 0                                   │   │
│  │  mem_1_req  ◄──►  D-Mem Port 1                                   │   │
│  │  mem_2_req  ◄──►  D-Mem Port 2                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Entry Structure

```systemverilog
typedef struct packed {
    logic                       valid;        // Entry is occupied
    logic                       is_store;     // 1=store, 0=load

    // Physical register (ROB ID for stores, dest for loads)
    logic [PHYS_REG_WIDTH-1:0]  phys_reg;

    // Address computation
    logic                       addr_valid;   // Address computed
    logic [DATA_WIDTH-1:0]      address;      // Memory address
    logic [TAG_WIDTH-1:0]       addr_tag;     // Address dependency tag

    // Store data
    logic                       data_valid;   // Data available
    logic [DATA_WIDTH-1:0]      data;         // Store data
    logic [TAG_WIDTH-1:0]       data_tag;     // Store data dependency tag

    // Operation attributes
    mem_size_t                  size;         // SIZE_BYTE/HALF/WORD
    logic                       sign_extend;  // Sign extend for loads

    // Execution state
    logic                       mem_issued;   // Sent to memory
    logic                       mem_complete; // Memory responded
} lsq_simple_entry_t;
```

### 2.3 Memory Size Encoding

```systemverilog
typedef enum logic [1:0] {
    SIZE_BYTE = 2'b00,    // LB/LBU/SB
    SIZE_HALF = 2'b01,    // LH/LHU/SH
    SIZE_WORD = 2'b10,    // LW/SW
    SIZE_RSVD = 2'b11     // Reserved
} mem_size_t;
```

---

## 3. Interface Specification

### 3.1 Store Permission Interface (from ROB)

| Signal | Width | Description |
|--------|-------|-------------|
| `store_can_issue_0..2` | 1 each | ROB grants store permission |
| `allowed_store_address_0..2` | 6 each | Physical reg ID of allowed store |

**Note**: Stores only issue to memory after ROB grants permission (prevents speculative stores).

### 3.2 Allocation Interface (from Issue Stage)

| Signal | Width | Description |
|--------|-------|-------------|
| `alloc_valid_0..2_i` | 1 each | Allocation request valid |
| `alloc_is_store_0..2_i` | 1 each | 1=store, 0=load |
| `alloc_phys_reg_0..2_i` | 6 each | Physical register/ROB ID |
| `alloc_addr_tag_0..2_i` | 3 each | Address dependency tag |
| `alloc_data_operand_0..2_i` | 32 each | Store data operand |
| `alloc_data_tag_0..2_i` | 3 each | Store data dependency tag |
| `alloc_size_0..2_i` | 2 each | Memory operation size |
| `alloc_sign_extend_0..2_i` | 1 each | Sign extend for loads |
| `alloc_ready_o` | 1 | LSQ can accept allocations |

### 3.3 CDB Interface

The LSQ monitors CDB for address/data resolution and broadcasts load results:

```systemverilog
interface cdb_if;
    // Monitor channels 0-2 (ALU results)
    logic        cdb_valid_0, cdb_valid_1, cdb_valid_2;
    logic [31:0] cdb_data_0, cdb_data_1, cdb_data_2;
    logic [2:0]  cdb_tag_0, cdb_tag_1, cdb_tag_2;
    
    // Broadcast channels 3_0, 3_1, 3_2 (LSQ results)
    logic        cdb_valid_3_0, cdb_valid_3_1, cdb_valid_3_2;
    logic [31:0] cdb_data_3_0, cdb_data_3_1, cdb_data_3_2;
    logic [2:0]  cdb_tag_3_0, cdb_tag_3_1, cdb_tag_3_2;
    logic [5:0]  cdb_dest_reg_3_0, cdb_dest_reg_3_1, cdb_dest_reg_3_2;
endinterface
```

### 3.4 Memory Interface (3 Ports)

Each of the 3 memory ports has identical signals:

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `mem_N_req_valid_o` | 1 | Output | Request valid |
| `mem_N_req_is_store_o` | 1 | Output | 1=store, 0=load |
| `mem_N_req_addr_o` | 32 | Output | Memory address |
| `mem_N_req_data_o` | 32 | Output | Store data |
| `mem_N_req_be_o` | 4 | Output | Byte enable |
| `mem_N_req_ready_i` | 1 | Input | Memory can accept |
| `mem_N_resp_valid_i` | 1 | Input | Response valid |
| `mem_N_resp_data_i` | 32 | Input | Load data |

### 3.5 Eager Misprediction Interface

| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `eager_misprediction_i` | 1 | Input | BRAT signals misprediction |
| `mispredicted_distance_i` | 6 | Input | ROB distance of mispredicted entry |
| `rob_head_ptr_i` | 5 | Input | Current ROB head pointer |
| `first_invalid_lsq_idx_o` | 5 | Output | First flushed LSQ index |
| `lsq_flush_valid_o` | 1 | Output | Flush occurred |

### 3.6 Status Outputs

| Signal | Width | Description |
|--------|-------|-------------|
| `lsq_count_o` | 6 | Current entry count |
| `lsq_full_o` | 1 | LSQ is full |
| `lsq_empty_o` | 1 | LSQ is empty |

---

## 4. Operation Details

### 4.1 Three-Head Architecture

The LSQ uses three head pointers for parallel operation:

```
head_ptr   → Oldest entry (memory port 0)
head_ptr_1 → Second oldest (memory port 1)  
head_ptr_2 → Third oldest (memory port 2)
tail_ptr   → Next allocation slot
```

**Distance Calculation**:
```systemverilog
distance_0 = tail_ptr - head_ptr;
distance_1 = tail_ptr - head_ptr_1;
distance_2 = tail_ptr - head_ptr_2;
```

Oldest entry has largest distance (executed first).

### 4.2 Allocation Flow

```
1. Check alloc_ready_o (space available && !eager_misprediction)
2. For each valid allocation:
   ├─ Store entry at tail_ptr + offset
   ├─ Set valid=1, is_store, phys_reg, size, sign_extend
   ├─ Set addr_valid=0, addr_tag
   ├─ For stores: set data/data_tag
   └─ Initialize mem_issued=0, mem_complete=0
3. Advance tail_ptr by allocation count
```

### 4.3 CDB Snooping

The LSQ monitors CDB to resolve address and data dependencies:

```systemverilog
// Address resolution
for (int i = 0; i < LSQ_DEPTH; i++) begin
    if (!lsq_buffer[i].addr_valid) begin
        if (cdb_valid_0 && addr_tag == cdb_tag_0) begin
            lsq_buffer[i].addr_valid <= 1'b1;
            lsq_buffer[i].address <= cdb_data_0;
        end
        // Similar for cdb_1, cdb_2
    end
end

// Store data resolution (also checks LSQ CDB channels for load→store dep)
if (is_store && !data_valid) begin
    if (cdb_valid_3_0 && data_tag == 3'b011 && 
        data == cdb_dest_reg_3_0) begin  // phys_reg match
        lsq_buffer[i].data_valid <= 1'b1;
        lsq_buffer[i].data <= cdb_data_3_0;
    end
end
```

### 4.4 Store-to-Load Forwarding

The LSQ implements full forwarding between the three head entries:

```
Forwarding Logic:
1. If head_0 is load and head_1 or head_2 is older store:
   ├─ Check address match between entries
   ├─ Check store has valid data
   ├─ Check store size >= load size
   └─ If all pass: forward store data to load (bypass memory)

2. Priority based on age (older stores have priority)

3. Must wait if:
   ├─ Older store exists without valid data
   ├─ Address conflict with smaller store (partial overlap)
   └─ Store not yet issued to memory
```

**Forwarding Source Selection**:
```systemverilog
head_0_fwd_source: 2'b01 = from head_1, 2'b10 = from head_2
head_1_fwd_source: 2'b00 = from head_0, 2'b10 = from head_2
head_2_fwd_source: 2'b00 = from head_0, 2'b01 = from head_1
```

### 4.5 Memory Issue Logic

**Load Issue Conditions**:
```
load_can_issue = entry.valid &&
                 !entry.is_store &&
                 entry.addr_valid &&
                 !entry.mem_issued &&
                 !forwarding_active &&
                 !should_wait_for_store;
```

**Store Issue Conditions**:
```
store_can_issue = entry.valid &&
                  entry.is_store &&
                  entry.addr_valid &&
                  entry.data_valid &&
                  !entry.mem_issued &&
                  rob_permission_granted;  // From ROB commit
```

### 4.6 Deallocation

Entry deallocation occurs when:
1. Memory response received (`mem_N_resp_valid_i`)
2. Store-to-load forwarding completes (`fwd_head_N`)
3. Entry was already completed (`mem_complete`)

Head pointer advancement follows age order (oldest first).

---

## 5. Eager Misprediction Flush

### 5.1 Distance-Based Invalidation

When BRAT signals misprediction, LSQ flushes younger entries:

```systemverilog
// Calculate ROB distance for each entry
for (int i = 0; i < LSQ_DEPTH; i++) begin
    entry_rob_distance[i] = (entry_rob_idx >= rob_head_ptr_i) ?
                            (entry_rob_idx - rob_head_ptr_i) :
                            (32 - rob_head_ptr_i + entry_rob_idx);
    
    // Flush if younger than mispredicted branch
    entry_should_flush[i] = valid && 
                            (entry_rob_distance[i] > mispredicted_distance_i);
end
```

### 5.2 Flush Execution

```
Flush Flow:
1. BRAT outputs misprediction signal + distance
2. LSQ calculates which entries are younger
3. Priority encoder finds first entry to flush
4. Tail pointer moved to first flush index
5. All younger entries invalidated
6. Head pointers adjusted if needed
```

### 5.3 Head Pointer Adjustment

If flush affects current head entries:
```systemverilog
if (lsq_flush_valid_o) begin
    if (new_tail overlaps head_ptr)
        head_ptr <= new_tail;
    if (new_tail overlaps head_ptr_1)
        head_ptr_1 <= new_tail + adjust;
    if (new_tail overlaps head_ptr_2)
        head_ptr_2 <= new_tail + adjust;
end
```

---

## 6. Data Organization

### 6.1 Byte Extraction (Loads)

```systemverilog
function logic [31:0] extract_bytes(
    input logic [31:0] word_data,
    input logic [1:0]  byte_offset,
    input mem_size_t   size,
    input logic        sign_ext
);
    case (size)
        SIZE_BYTE: begin
            case (byte_offset)
                2'b00: result[7:0] = word_data[7:0];
                2'b01: result[7:0] = word_data[15:8];
                2'b10: result[7:0] = word_data[23:16];
                2'b11: result[7:0] = word_data[31:24];
            endcase
            result[31:8] = {24{sign_ext ? result[7] : 1'b0}};
        end
        SIZE_HALF: begin
            result[15:0] = byte_offset[1] ? word_data[31:16] : word_data[15:0];
            result[31:16] = {16{sign_ext ? result[15] : 1'b0}};
        end
        SIZE_WORD: result = word_data;
    endcase
endfunction
```

### 6.2 Byte Enable Generation (Stores)

```systemverilog
function logic [3:0] generate_byte_enable(
    input logic [1:0] byte_offset,
    input mem_size_t  size
);
    case (size)
        SIZE_BYTE: be = 4'b0001 << byte_offset;
        SIZE_HALF: be = byte_offset[1] ? 4'b1100 : 4'b0011;
        SIZE_WORD: be = 4'b1111;
    endcase
endfunction
```

---

## 7. CDB Broadcast (Load Results)

Load results broadcast on CDB channels 3_0, 3_1, 3_2:

```systemverilog
// Memory port 0 load result
assign cdb_interface.cdb_valid_3_0 = mem_0_resp_valid_i | fwd_head_0;
assign cdb_interface.cdb_tag_3_0 = 3'b011;  // LSQ tag
assign cdb_interface.cdb_data_3_0 = load_0_data;
assign cdb_interface.cdb_dest_reg_3_0 = lsq_buffer[head_idx].phys_reg;

// Similar for ports 1 and 2
```

---

## 8. Package Definitions (`lsq_package.sv`)

The package provides common types and helper functions:

```systemverilog
package lsq_package;
    // Parameters
    parameter int LSQ_DEPTH = 32;
    parameter int DATA_WIDTH = 32;
    parameter int TAG_WIDTH = 3;
    
    // Types
    typedef enum logic [1:0] { SIZE_BYTE, SIZE_HALF, SIZE_WORD, SIZE_RSVD } mem_size_t;
    
    // Tag constants
    localparam logic [TAG_WIDTH-1:0] TAG_ALU0  = 3'b000;
    localparam logic [TAG_WIDTH-1:0] TAG_ALU1  = 3'b001;
    localparam logic [TAG_WIDTH-1:0] TAG_ALU2  = 3'b010;
    localparam logic [TAG_WIDTH-1:0] TAG_LSQ   = 3'b011;
    localparam logic [TAG_WIDTH-1:0] TAG_READY = 3'b111;
    
    // Helper functions
    function automatic logic [31:0] extract_bytes(...);
    function automatic logic [31:0] insert_bytes(...);
    function automatic logic [3:0] generate_byte_enable(...);
endpackage
```

---

## 9. Timing Characteristics

### 9.1 Latency

| Operation | Cycles | Notes |
|-----------|--------|-------|
| Allocation | 0 | Same-cycle write |
| CDB → Data Valid | 1 | Next cycle availability |
| Memory Request | 1 | After address valid |
| Memory Response | 1+ | Memory latency |
| Store Forward | 0 | Combinational bypass |
| Eager Flush | 1 | Single-cycle invalidation |

### 9.2 Throughput

| Operation | Per Cycle | Notes |
|-----------|-----------|-------|
| Allocations | 3 | Limited by issue width |
| Deallocations | 3 | Limited by head count |
| Memory Requests | 3 | Limited by ports |
| CDB Broadcasts | 3 | Channels 3_0, 3_1, 3_2 |

---

## 10. Debug Interface

```systemverilog
`ifndef SYNTHESIS
output logic [31:0] tracer_0_store_data;
output logic [31:0] tracer_1_store_data;
output logic [31:0] tracer_2_store_data;
`endif
```

These signals expose store data for simulation tracing.

---

## 11. Conditional Compilation

### `SECURE_UNALIGN_LSQ`

When defined, adds additional checks for unaligned memory access:

```systemverilog
`ifdef SECURE_UNALIGN_LSQ
    head_0_should_wait_unaligned_store = (store.address[1:0] != 2'b00);
`endif
```

This prevents forwarding when addresses are unaligned, ensuring correctness at cost of performance.

---

## 12. Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-10-07 | Initial design specification |
| 2.0 | 2025-12-01 | 3-port memory, eager flush, store forwarding |

---

*This document reflects the current implementation in `lsq_simple_top.sv` and `lsq_package.sv`.*
