# LSQ Quick Reference Guide

**Module:** Load-Store Queue (LSQ)  
**Location:** `digital/modules/superscalar_spesific_modules/load_store_queue/`  
**Date:** October 8, 2025

---

## Quick Module Summary

| Module | Lines | Purpose |
|--------|-------|---------|
| `lsq_package.sv` | 200 | Common types and helper functions |
| `lsq_interfaces.sv` | 210 | 5 SystemVerilog interfaces |
| `lsq_entry_array.sv` | 320 | Queue storage and allocation |
| `lsq_age_matrix.sv` | 150 | Age tracking (12×12 bits) |
| `lsq_address_cam.sv` | 190 | Address dependency checking |
| `lsq_forward_logic.sv` | 230 | Store→load forwarding (4-entry) |
| `lsq_mem_interface.sv` | 220 | Memory controller interface |
| `lsq_top.sv` | 420 | Top-level integration |

---

## Key Parameters

```systemverilog
// From lsq_package.sv
parameter LSQ_DEPTH = 12;              // Total queue entries
parameter FORWARD_WINDOW = 4;          // Forwarding window size
parameter DATA_WIDTH = 32;
parameter TAG_WIDTH = 2;
parameter ROB_ADDR_WIDTH = 5;
parameter PHYS_REG_WIDTH = 6;
```

---

## Interface Quick Reference

### 1. Allocation Interface (`lsq_alloc_if`)
**Purpose:** Issue Stage → LSQ allocation

```systemverilog
// Inputs (from Issue Stage)
logic [2:0]                 alloc_valid;        // 3 allocation requests
logic [2:0]                 alloc_is_store;     // Load or store
logic [2:0][4:0]           alloc_rob_idx;      // ROB index
logic [2:0][5:0]           alloc_phys_reg;     // Destination register (loads)
logic [2:0][31:0]          alloc_addr_operand; // Address operand
logic [2:0][1:0]           alloc_addr_tag;     // Address tag
logic [2:0][31:0]          alloc_data_operand; // Store data operand
logic [2:0][1:0]           alloc_data_tag;     // Store data tag
logic [2:0][1:0]           alloc_size;         // Byte/half/word
logic [2:0]                alloc_sign_extend;  // Sign extend (loads)

// Outputs (to Issue Stage)
logic                      alloc_ready;        // LSQ has space
logic [2:0][3:0]          alloc_lsq_idx;      // Allocated LSQ indices
```

### 2. CDB Monitor Interface (`lsq_cdb_monitor_if`)
**Purpose:** Monitor CDB for operand resolution

```systemverilog
// Inputs (from CDB)
logic [2:0]         cdb_valid;    // CDB channel valid
logic [2:0][1:0]   cdb_tag;      // CDB tag (ALU0/1/2/ready)
logic [2:0][31:0]  cdb_data;     // CDB data
```

### 3. CDB Broadcast Interface (`lsq_cdb_broadcast_if`)
**Purpose:** LSQ → CDB for load results

```systemverilog
// Outputs (from LSQ)
logic         lsq_cdb_valid;      // Load result valid
logic [1:0]  lsq_cdb_tag;        // Always TAG_READY
logic [31:0] lsq_cdb_data;       // Load data
logic [5:0]  lsq_cdb_phys_reg;   // Destination physical register
logic [4:0]  lsq_cdb_rob_idx;    // ROB index
```

### 4. Memory Interface (`lsq_mem_if`)
**Purpose:** LSQ ↔ Memory Controller

```systemverilog
// Load Request (LSQ → Memory)
logic         load_valid;
logic         load_ready;         // Memory ready input
logic [31:0] load_addr;
logic [1:0]  load_size;
logic        load_sign_extend;
logic [3:0]  load_lsq_idx;       // For tracking

// Load Response (Memory → LSQ)
logic         load_complete;
logic [31:0] load_data;
logic [3:0]  load_lsq_idx_ret;
logic        load_error;

// Store Request (LSQ → Memory, up to 3/cycle)
logic [2:0]         store_valid;
logic [2:0][31:0]  store_addr;
logic [2:0][31:0]  store_data;
logic [2:0][3:0]   store_be;        // Byte enable
logic [2:0][1:0]   store_size;

// Store Response (Memory → LSQ)
logic [2:0]         store_ack;
```

### 5. ROB Interface (`lsq_rob_if`)
**Purpose:** ROB → LSQ store commits

```systemverilog
// Inputs (from ROB, up to 3/cycle)
logic [2:0]         commit_valid;
logic [2:0]         commit_is_store;
logic [2:0][4:0]   commit_rob_idx;
logic [2:0][3:0]   commit_lsq_idx;    // Which LSQ entry to commit

// Outputs (to ROB)
logic [2:0]         commit_ack;        // Store committed
logic [2:0]         commit_error;      // Commit failed
```

---

## Entry Structure (`lsq_entry_t`)

```systemverilog
typedef struct packed {
    logic        valid;          // Entry occupied
    logic        is_store;       // 1=store, 0=load
    logic        addr_valid;     // Address computed
    logic [31:0] address;        // Memory address
    logic [1:0]  addr_tag;       // Address dependency tag
    logic        data_valid;     // Store data available
    logic [31:0] data;           // Store data
    logic [1:0]  data_tag;       // Store data dependency tag
    logic [4:0]  rob_idx;        // ROB index
    logic [5:0]  phys_reg;       // Destination register (loads)
    mem_size_t   size;           // Byte/half/word
    logic        sign_extend;    // Sign extend (loads)
    logic        executed;       // Load completed
    logic        committed;      // Store committed
} lsq_entry_t;
```

---

## Operation Flow Quick Reference

### Load Flow
1. **Allocate** → LSQ entry allocated
2. **Resolve** → Address resolved via CDB
3. **Check** → CAM checks dependencies
4. **Forward?** → Check recent stores
5. **Issue** → To memory (if not forwarded)
6. **Broadcast** → Result on CDB
7. **Free** → Deallocate LSQ entry

### Store Flow
1. **Allocate** → LSQ entry allocated
2. **Resolve** → Address & data via CDB
3. **Wait** → Buffer until ROB commits
4. **Commit** → ROB signals commit
5. **Write** → To memory controller
6. **ACK** → Wait for acknowledgment
7. **Free** → Deallocate LSQ entry

---

## Size Encoding

```systemverilog
typedef enum logic [1:0] {
    SIZE_BYTE = 2'b00,    // LB/LBU/SB
    SIZE_HALF = 2'b01,    // LH/LHU/SH
    SIZE_WORD = 2'b10,    // LW/SW
    SIZE_RSVD = 2'b11     // Reserved
} mem_size_t;
```

---

## Tag Encoding

```systemverilog
localparam TAG_ALU0  = 2'b00;    // Waiting for ALU0
localparam TAG_ALU1  = 2'b01;    // Waiting for ALU1
localparam TAG_ALU2  = 2'b10;    // Waiting for ALU2
localparam TAG_READY = 2'b11;    // Data ready/valid
```

---

## Helper Functions

### Extract Bytes (for loads)
```systemverilog
function automatic logic [31:0] extract_bytes(
    input logic [31:0] word_data,
    input logic [1:0]  byte_offset,
    input mem_size_t   size,
    input logic        sign_ext
);
```
**Purpose:** Extract byte/half/word from store data for forwarding

### Generate Byte Enable (for stores)
```systemverilog
function automatic logic [3:0] generate_byte_enable(
    input logic [1:0] byte_offset,
    input mem_size_t  size
);
```
**Purpose:** Generate byte enable signals for memory controller

---

## Instantiation Template

```systemverilog
// Declare interfaces
lsq_alloc_if #(.NUM_ALLOC(3)) lsq_alloc_if_inst();
lsq_cdb_monitor_if #(.NUM_CDB(3)) lsq_cdb_monitor_if_inst();
lsq_cdb_broadcast_if lsq_cdb_broadcast_if_inst();
lsq_mem_if lsq_mem_if_inst();
lsq_rob_if #(.NUM_COMMIT(3)) lsq_rob_if_inst();

// Instantiate LSQ
lsq_top u_lsq (
    .clk                (clk),
    .rst_n              (rst_n),
    .alloc_if           (lsq_alloc_if_inst),
    .cdb_monitor_if     (lsq_cdb_monitor_if_inst),
    .cdb_broadcast_if   (lsq_cdb_broadcast_if_inst),
    .mem_if             (lsq_mem_if_inst),
    .rob_if             (lsq_rob_if_inst),
    .lsq_entries_used_o (lsq_entries_used),
    .lsq_full_o         (lsq_full),
    .lsq_empty_o        (lsq_empty)
);
```

---

## Common Operations

### Check if LSQ has space
```systemverilog
if (lsq_alloc_if_inst.alloc_ready) begin
    // Can allocate up to 3 operations
end
```

### Allocate a load
```systemverilog
lsq_alloc_if_inst.alloc_valid[0] = 1'b1;
lsq_alloc_if_inst.alloc_is_store[0] = 1'b0;  // Load
lsq_alloc_if_inst.alloc_rob_idx[0] = rob_idx;
lsq_alloc_if_inst.alloc_phys_reg[0] = dest_reg;
lsq_alloc_if_inst.alloc_addr_operand[0] = addr;
lsq_alloc_if_inst.alloc_addr_tag[0] = TAG_READY;
lsq_alloc_if_inst.alloc_size[0] = SIZE_WORD;
lsq_alloc_if_inst.alloc_sign_extend[0] = 1'b0;
```

### Allocate a store
```systemverilog
lsq_alloc_if_inst.alloc_valid[0] = 1'b1;
lsq_alloc_if_inst.alloc_is_store[0] = 1'b1;  // Store
lsq_alloc_if_inst.alloc_rob_idx[0] = rob_idx;
lsq_alloc_if_inst.alloc_addr_operand[0] = addr;
lsq_alloc_if_inst.alloc_addr_tag[0] = TAG_ALU0;  // Wait for ALU0
lsq_alloc_if_inst.alloc_data_operand[0] = data;
lsq_alloc_if_inst.alloc_data_tag[0] = TAG_READY;
lsq_alloc_if_inst.alloc_size[0] = SIZE_WORD;
```

### Commit a store
```systemverilog
lsq_rob_if_inst.commit_valid[0] = 1'b1;
lsq_rob_if_inst.commit_is_store[0] = 1'b1;
lsq_rob_if_inst.commit_rob_idx[0] = rob_idx;
lsq_rob_if_inst.commit_lsq_idx[0] = lsq_idx;
```

---

## Debug Signals

```systemverilog
// Check LSQ status
wire [3:0] lsq_used = lsq_entries_used_o;
wire lsq_full = lsq_full_o;
wire lsq_empty = lsq_empty_o;

// Monitor load/store activity
wire load_issued = lsq_mem_if_inst.load_valid;
wire load_complete = lsq_mem_if_inst.load_complete;
wire [2:0] stores_committing = lsq_mem_if_inst.store_valid;

// Monitor CDB broadcast
wire lsq_broadcasting = lsq_cdb_broadcast_if_inst.lsq_cdb_valid;
wire [31:0] lsq_broadcast_data = lsq_cdb_broadcast_if_inst.lsq_cdb_data;
```

---

## Performance Counters (Simulation Only)

Add to testbench for profiling:

```systemverilog
// From lsq_address_cam
integer load_stalls_unknown_store;
integer load_stalls_addr_conflict;

// From lsq_forward_logic
integer forward_hits;
integer forward_misses;

// From lsq_mem_interface
integer loads_issued;
integer loads_completed;
integer stores_committed;

// Calculate metrics
real forwarding_rate = real'(forward_hits) / (forward_hits + forward_misses);
real avg_lsq_occupancy = real'(total_entries_used) / total_cycles;
```

---

## Common Issues and Solutions

### Issue: LSQ Full
**Symptom:** `alloc_ready` = 0  
**Cause:** All 12 entries occupied  
**Solution:** 
- Check if loads are completing
- Check if ROB is committing stores
- Verify deallocation logic

### Issue: Loads Not Executing
**Symptom:** `load_ready` = 0 for valid loads  
**Cause:** Dependency on older stores  
**Solution:**
- Check if older stores have unknown addresses
- Verify age matrix is working
- Check address CAM logic

### Issue: Forwarding Not Working
**Symptom:** `forward_valid` = 0 when expected  
**Cause:** Size mismatch or outside forwarding window  
**Solution:**
- Check load/store size compatibility
- Verify store is in 4-entry forwarding window
- Check age matrix (store must be older than load)

### Issue: Stores Not Committing
**Symptom:** Stores stuck in LSQ  
**Cause:** ROB not signaling commits  
**Solution:**
- Verify ROB interface connections
- Check `commit_is_store` signal
- Verify LSQ index tracking in ROB

---

## Filelist Order

**Important:** Compile in this order!

```
1. lsq_package.sv          # Package (must be first)
2. lsq_interfaces.sv       # Interfaces
3. lsq_entry_array.sv      # Submodules (any order)
4. lsq_age_matrix.sv
5. lsq_address_cam.sv
6. lsq_forward_logic.sv
7. lsq_mem_interface.sv
8. lsq_top.sv              # Top module (must be last)
```

---

## Quick Checklist for Integration

- [ ] Add `load_store_queue.f` to compilation
- [ ] Declare LSQ interfaces in dispatch stage
- [ ] Connect Issue Stage → LSQ allocation
- [ ] Connect CDB → LSQ monitoring (3 channels)
- [ ] Connect LSQ → CDB broadcast
- [ ] Add LSQ index to ROB entries
- [ ] Connect ROB → LSQ commit interface
- [ ] Connect LSQ ↔ Memory controller
- [ ] Handle `alloc_ready` backpressure
- [ ] Add memory operation detection in decode

---

**Quick Reference Version:** 1.0  
**Last Updated:** October 8, 2025
