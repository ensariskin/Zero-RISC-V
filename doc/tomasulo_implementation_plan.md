# Tomasulo-Based Superscalar RV32I Processor Implementation Plan

## 🎯 **Overview: Simplified Tomasulo for 3-ALU Superscalar**

**Goal**: Implement a 3-way superscalar, out-of-order RV32I processor using Tomasulo's algorithm with register renaming.

**Key Benefits**:
- ✅ Eliminates WAW and WAR dependencies through register renaming
- ✅ Only RAW dependencies handled dynamically in reservation stations
- ✅ Out-of-order execution with in-order commit (ROB at the end)
- ✅ 3 identical ALUs - maximum flexibility

**Existing Assets**:
- ✅ 3-way fetch buffer infrastructure
- ✅ Multi-decode stage (3 decoders)
- ✅ Register file with 3R/3W ports (32→64 entries extensible)
- ✅ Existing ALU design (replicable)

---

## 🏗️ **Simplified Architecture**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Fetch Buffer    │───▶│ Instruction     │───▶│ Decode & Rename │
│   (existing)    │    │   Buffer        │    │   + RAT         │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │ ALU Reservation │
                                               │   Station       │
                                               │  (unified)      │
                                               └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │  3 Identical    │
                                               │      ALUs       │
                                               │ (any→any exec)  │
                                               └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │ Common Data Bus │
                                               │     (CDB)       │
                                               │ Result Broadcast│
                                               └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │ Extended Reg    │
                                               │ File (64 entry) │
                                               │   3R/3W ports   │
                                               └─────────────────┘
                                                        
                           [ROB - Implemented Last for Commit]
```

---

## 📋 **Implementation Phases (Simplified)**

### **Phase 1: Decode Stage Integration (Weeks 1-2)**

#### **1.1 Register Alias Table (RAT) in Decode**
- **Location**: Integrated into existing decode stage
- **Purpose**: Rename architectural registers (x0-x31) to physical registers (0-63)
- **Features**: 
  - 32→64 register mapping
  - Free list for available physical registers
  - Handles 3 instructions per cycle

#### **1.2 Extended Register File**
- **Current**: 32 entries, 3R/3W ports
- **Upgrade**: Extend to 64 entries (easy modification)
- **Keep**: Same port configuration (3R/3W)

### **Phase 2: Reservation Station (Weeks 3-4)**

#### **2.1 Unified ALU Reservation Station**
- **Purpose**: Schedule ALL RV32I operations for 3 identical ALUs
- **Size**: 12-16 entries total
- **Operations**: Complete RV32I instruction set
- **Dispatch**: Round-robin to any available ALU

### **Phase 3: Triple ALU Integration (Weeks 5-6)**

#### **3.1 Three Identical ALUs**
- **Existing**: Use current ALU design
- **Replication**: Create 3 copies (ALU0, ALU1, ALU2)
- **Capability**: Each ALU executes ANY RV32I instruction
- **Connection**: Any reservation station entry → any free ALU

#### **3.2 Common Data Bus (CDB)**
- **Purpose**: Broadcast ALU results to all reservation stations
- **Functionality**: 
  - 3 ALUs compete for CDB access
  - Results broadcast with physical register tags
  - Reservation stations snoop for waiting operands
- **Arbitration**: Priority-based or round-robin for simultaneous results

### **Phase 4: ROB for Commit (Weeks 7-8)**

#### **4.1 Reorder Buffer (Final Phase)**
- **Purpose**: In-order commit of out-of-order results
- **Size**: 16-32 entries
- **Features**: Exception handling, precise state recovery

---

## 🔧 **Key Component Details**

### **Register Alias Table (in Decode Stage)**
```systemverilog
module register_alias_table #(
    parameter ARCH_REGS = 32,
    parameter PHYS_REGS = 64
)(
    input logic clk, reset,
    
    // 3-way decode interface
    input logic [4:0] src1_arch [2:0], src2_arch [2:0], dest_arch [2:0],
    input logic [2:0] decode_valid,
    
    // Rename outputs
    output logic [5:0] src1_phys [2:0], src2_phys [2:0], dest_phys [2:0],
    output logic [5:0] old_dest_phys [2:0],  // For freeing later
    
    // Free list management
    output logic [2:0] rename_valid,
    input logic [2:0] commit_valid,
    input logic [5:0] free_phys_reg [2:0]
);
```

### **Unified Reservation Station**
```systemverilog
typedef struct packed {
    logic valid;
    logic [31:0] instruction;
    logic [5:0] dest_phys_reg;
    
    // Source operands (renamed)
    logic src1_ready, src2_ready;
    logic [31:0] src1_value, src2_value;
    logic [5:0] src1_tag, src2_tag;
    
    // Operation info
    logic [4:0] alu_operation;
    logic [31:0] immediate;
    logic [31:0] pc;
    
    // Simple fields
    logic is_branch;
    logic is_memory_addr;
} reservation_entry_t;
```

### **Common Data Bus (CDB)**
```systemverilog
typedef struct packed {
    logic valid;
    logic [5:0] phys_reg_tag;     // Which physical register is being written
    logic [31:0] result_data;     // The computed result
    logic [1:0] alu_id;           // Which ALU produced this result
} cdb_broadcast_t;

module common_data_bus #(
    parameter NUM_ALUS = 3
)(
    input logic clk, reset,
    
    // ALU result inputs
    input cdb_broadcast_t alu_results [NUM_ALUS-1:0],
    input logic [NUM_ALUS-1:0] alu_result_valid,
    
    // CDB output (to reservation stations and register file)
    output cdb_broadcast_t cdb_data,
    output logic cdb_valid,
    
    // Arbitration - which ALU gets the bus this cycle
    output logic [NUM_ALUS-1:0] alu_granted
);
```

### **Extended Register File (64 entries)**
```systemverilog
module extended_register_file #(
    parameter REGS = 64,        // Extended from 32
    parameter WIDTH = 32
)(
    input logic clk,
    
    // 3 read ports (existing)
    input logic [5:0] read_addr_1, read_addr_2, read_addr_3,  // 6 bits for 64 regs
    output logic [WIDTH-1:0] read_data_1, read_data_2, read_data_3,
    
    // 3 write ports (existing)
    input logic write_enable_1, write_enable_2, write_enable_3,
    input logic [5:0] write_addr_1, write_addr_2, write_addr_3,
    input logic [WIDTH-1:0] write_data_1, write_data_2, write_data_3,
    
    // CDB write interface
    input cdb_broadcast_t cdb_data,
    input logic cdb_valid
);
```

### **Week 1-2: Decode + RAT**
1. **Integrate RAT into decode stage** - Register renaming logic
2. **Extend register file** - 32→64 entries (simple modification)
3. **Test rename functionality** - Validate dependency elimination

### **Week 3-4: Reservation Station**
1. **Unified reservation station** - Single station for all 3 ALUs
2. **Round-robin dispatch** - Any ready instruction to any free ALU
3. **RAW dependency handling** - Only real dependencies remain

### **Week 5-6: Triple ALU + CDB**
1. **Replicate existing ALU** - Create 3 identical copies
2. **Common Data Bus design** - Result broadcasting mechanism
3. **CDB arbitration** - Handle simultaneous ALU results
4. **Reservation station snooping** - Update waiting operands from CDB

---

## 🚀 **Development Strategy**

### **Week 7-8: ROB & Integration**
1. **Reorder Buffer** - In-order commit mechanism
2. **Full system integration** - Connect all components
3. **Performance tuning** - Optimize for maximum IPC

---

## 📊 **Expected Benefits**

- **IPC Target**: 2.8-3.0 instructions per cycle
- **Perfect load balancing**: Any instruction to any ALU
- **Simplified design**: Leverage existing components
- **Maximum flexibility**: No ALU specialization bottlenecks

---

## 🎯 **Next Steps**

1. **Start with RAT integration** into existing decode stage
2. **Extend register file** from 32 to 64 entries  
3. **Design unified reservation station** for 3-ALU dispatch
4. **ROB implementation** saved for final phase

**Priority**: Begin with **Register Alias Table in Decode Stage** - the foundation for dependency elimination?
