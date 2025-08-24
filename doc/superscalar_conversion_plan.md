# RV32I Superscalar Processor Conversion Plan

## Executive Summary

This document outlines the comprehensive plan to convert the current in-order RV32I processor into a superscalar out-of-order processor. The conversion will be implemented in phases to maintain functionality and enable incremental testing.

**Current Focus**: Phase 1 implementation - Adding 3 ALUs to the existing pipeline as the first step toward superscalar execution. This focused approach allows for incremental development while laying the foundation for future enhancements.

## Current Architecture Analysis

### Existing Pipeline Structure
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Fetch     │───▶│   Decode    │───▶│   Execute   │───▶│   Memory    │───▶│ Write-Back  │
│    (IF)     │    │    (ID)     │    │    (EX)     │    │   (MEM)     │    │    (WB)     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### Current Capabilities
- ✅ Single instruction issue per cycle
- ✅ In-order execution and completion
- ✅ Basic data forwarding (MEM→EX, WB→EX)
- ✅ Load-use hazard detection with stalling
- ✅ Simple branch prediction (static)
- ✅ Full RV32I ISA support
- ✅ 32x32-bit register file with dual read ports

### Current Limitations
- ❌ Single instruction fetch per cycle
- ❌ Single functional unit (ALU only)
- ❌ No register renaming
- ❌ No dynamic instruction scheduling
- ❌ No speculative execution
- ❌ Limited memory bandwidth (single access per cycle)

## Target Superscalar Architecture

### Pipeline Overview
```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│      Frontend       │    │     Execution       │    │      Backend        │
│                     │    │                     │    │                     │
│ ┌─────────────────┐ │    │ ┌─────────────────┐ │    │ ┌─────────────────┐ │
│ │ Multi-Fetch     │ │    │ │ Reservation     │ │    │ │ Reorder Buffer  │ │
│ │ (2-4 inst/cyc)  │ │    │ │ Stations        │ │    │ │ (ROB)           │ │
│ └─────────────────┘ │    │ └─────────────────┘ │    │ └─────────────────┘ │
│ ┌─────────────────┐ │    │ ┌─────────────────┐ │    │ ┌─────────────────┐ │
│ │ Multi-Decode    │ │─── │ │ Multiple        │ │──  │ │ Load/Store      │ │
│ │ (2-4 inst/cyc)  │ │    │ │ Execution Units │ │    │ │ Queue           │ │
│ └─────────────────┘ │    │ └─────────────────┘ │    │ └─────────────────┘ │
│ ┌─────────────────┐ │    │ ┌─────────────────┐ │    │ ┌─────────────────┐ │
│ │ Register        │ │    │ │ ALU0 ALU1 LSU   │ │    │ │ Commit Logic    │ │
│ │ Renaming        │ │    │ │ BR0  FPU  ...   │ │    │ │                 │ │
│ └─────────────────┘ │    │ └─────────────────┘ │    │ └─────────────────┘ │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
```

### Target Specifications
- 🎯 **Issue Width**: 2-4 instructions per cycle
- 🎯 **Execution Units**: 2x ALU, 1x LSU, 1x Branch, 1x Mult/Div
- 🎯 **Register Renaming**: 64-128 physical registers
- 🎯 **Reorder Buffer**: 32-64 entries
- 🎯 **Load/Store Queue**: 16-32 entries each
- 🎯 **Branch Prediction**: 2-level adaptive with BTB
- 🎯 **Memory System**: Dual-port data cache interface

## Implementation Phases

## Phase 1: Infrastructure and Frontend Enhancement

### 1.1 Multi-Instruction Fetch Unit
**Objective**: Fetch 2-4 instructions per cycle

**New Modules to Create**:
```
digital/modules/fetch_stage_super/
├── src/
│   ├── multi_fetch_unit.sv          # Main multi-fetch controller
│   ├── instruction_buffer.sv        # Fetch buffer (8-16 entries)
│   ├── fetch_target_predictor.sv    # Next-line predictor
│   └── instruction_alignment.sv     # Handle misaligned fetches
├── multi_fetch.f                    # File list
└── README.md                        # Documentation
```

**Modifications Required**:
- `instruction_memory interface`: Widen to support multi-word fetch
- `fetch_stage.sv`: Replace with multi-fetch controller
- Memory system: Support for wider instruction fetch

**Implementation Details**:
```systemverilog
module multi_fetch_unit #(
    parameter FETCH_WIDTH = 2,  // Number of instructions per cycle
    parameter BUFFER_DEPTH = 16 // Instruction buffer depth
)(
    input  logic clk, reset,
    input  logic [31:0] pc_i,
    input  logic fetch_enable,
    
    // Memory interface (wider)
    output logic [31:0] imem_addr_o,
    input  logic [FETCH_WIDTH*32-1:0] imem_data_i,
    input  logic imem_valid_i,
    
    // Output to decode
    output logic [FETCH_WIDTH-1:0][31:0] instructions_o,
    output logic [FETCH_WIDTH-1:0] valid_o,
    output logic [FETCH_WIDTH-1:0][31:0] pc_o,
    
    // Control
    input  logic flush_i,
    input  logic stall_i
);
```

### 1.2 Enhanced Branch Prediction
**Objective**: Improve branch prediction accuracy

**New Modules to Create**:
```
digital/modules/branch_predictor_super/
├── src/
│   ├── branch_target_buffer.sv     # BTB (256-512 entries)
│   ├── pattern_history_table.sv    # 2-level adaptive predictor
│   ├── return_address_stack.sv     # RAS for function calls
│   └── branch_predictor_top.sv     # Top-level integration
├── branch_pred.f
└── README.md
```

**Key Features**:
- Branch Target Buffer (BTB) for target prediction
- 2-level adaptive pattern prediction
- Return Address Stack (RAS) for function returns
- Branch history register integration

### 1.3 Multi-Instruction Decode
**Objective**: Decode 2-4 instructions per cycle

**New Modules to Create**:
```
digital/modules/decode_stage_super/
├── src/
│   ├── multi_decode_unit.sv         # Parallel decoders
│   ├── decode_scheduler.sv          # Instruction ordering
│   ├── dependency_checker.sv       # Initial dependency analysis
│   └── instruction_queue.sv        # Pre-decode queue
├── multi_decode.f
└── README.md
```

**Implementation Strategy**:
- Parallel decoder instances (2-4 copies)
- Early dependency detection
- Instruction pre-classification (ALU, LSU, Branch, etc.)

## Phase 2: Register Renaming and Dynamic Scheduling

### 2.1 Register Renaming Unit
**Objective**: Eliminate false dependencies (WAR, WAW)

**New Modules to Create**:
```
digital/modules/register_renaming/
├── src/
│   ├── register_alias_table.sv     # RAT (32 entries)
│   ├── free_register_list.sv       # Free list manager
│   ├── physical_register_file.sv   # 64-128 physical registers
│   ├── checkpoint_manager.sv       # For speculation recovery
│   └── rename_unit_top.sv          # Top-level integration
├── rename.f
└── README.md
```

**Key Components**:
```systemverilog
module register_alias_table #(
    parameter ARCH_REGS = 32,
    parameter PHYS_REGS = 64
)(
    input  logic clk, reset,
    
    // Lookup ports (for decode)
    input  logic [4:0] src1_arch_i, src2_arch_i,
    output logic [5:0] src1_phys_o, src2_phys_o,
    output logic src1_ready_o, src2_ready_o,
    
    // Allocation ports (for rename)
    input  logic [4:0] dst_arch_i,
    input  logic dst_valid_i,
    output logic [5:0] dst_phys_o,
    
    // Commit ports
    input  logic [4:0] commit_arch_i,
    input  logic [5:0] commit_phys_i,
    input  logic commit_valid_i,
    
    // Recovery
    input  logic flush_i,
    input  logic [ARCH_REGS-1:0][5:0] checkpoint_i
);
```

### 2.2 Reservation Stations
**Objective**: Dynamic instruction scheduling

**New Modules to Create**:
```
digital/modules/reservation_stations/
├── src/
│   ├── reservation_station.sv      # Generic RS template
│   ├── alu_reservation_station.sv  # For ALU operations
│   ├── lsu_reservation_station.sv  # For Load/Store operations
│   ├── branch_reservation_station.sv # For branch operations
│   ├── wakeup_logic.sv             # Result broadcast logic
│   └── issue_arbiter.sv            # Issue port arbitration
├── reservation.f
└── README.md
```

**Reservation Station Structure**:
```systemverilog
module reservation_station #(
    parameter NUM_ENTRIES = 8,
    parameter DATA_WIDTH = 32,
    parameter TAG_WIDTH = 6
)(
    input  logic clk, reset,
    
    // Dispatch interface
    input  logic dispatch_valid_i,
    input  logic [31:0] dispatch_pc_i,
    input  logic [31:0] dispatch_instr_i,
    input  logic [TAG_WIDTH-1:0] dispatch_dst_tag_i,
    input  logic [TAG_WIDTH-1:0] dispatch_src1_tag_i,
    input  logic [TAG_WIDTH-1:0] dispatch_src2_tag_i,
    input  logic [DATA_WIDTH-1:0] dispatch_src1_data_i,
    input  logic [DATA_WIDTH-1:0] dispatch_src2_data_i,
    input  logic dispatch_src1_ready_i,
    input  logic dispatch_src2_ready_i,
    output logic dispatch_ready_o,
    
    // Issue interface
    output logic issue_valid_o,
    output logic [31:0] issue_pc_o,
    output logic [31:0] issue_instr_o,
    output logic [TAG_WIDTH-1:0] issue_dst_tag_o,
    output logic [DATA_WIDTH-1:0] issue_src1_data_o,
    output logic [DATA_WIDTH-1:0] issue_src2_data_o,
    input  logic issue_ready_i,
    
    // Wakeup interface (result broadcast)
    input  logic wakeup_valid_i,
    input  logic [TAG_WIDTH-1:0] wakeup_tag_i,
    input  logic [DATA_WIDTH-1:0] wakeup_data_i
);
```

### 2.3 Multiple Execution Units
**Objective**: Parallel instruction execution

**New Modules to Create**:
```
digital/modules/execution_units/
├── src/
│   ├── alu_unit_0.sv               # Primary ALU
│   ├── alu_unit_1.sv               # Secondary ALU
│   ├── load_store_unit.sv          # Memory operations
│   ├── branch_unit.sv              # Branch resolution
│   ├── multiplier_unit.sv          # Integer multiply/divide
│   ├── execution_arbiter.sv        # Resource allocation
│   └── result_broadcast_network.sv # Result forwarding
├── exec_units.f
└── README.md
```

## Phase 3: Out-of-Order Backend

### 3.1 Reorder Buffer (ROB)
**Objective**: Maintain precise exceptions and in-order commit

**New Modules to Create**:
```
digital/modules/reorder_buffer/
├── src/
│   ├── reorder_buffer.sv           # Main ROB structure
│   ├── rob_entry.sv                # Individual ROB entry
│   ├── commit_logic.sv             # Commit stage logic
│   ├── exception_handler.sv        # Exception processing
│   └── recovery_manager.sv         # Speculation recovery
├── rob.f
└── README.md
```

**ROB Structure**:
```systemverilog
module reorder_buffer #(
    parameter ROB_ENTRIES = 32,
    parameter TAG_WIDTH = 6
)(
    input  logic clk, reset,
    
    // Allocation interface
    input  logic alloc_valid_i,
    input  logic [31:0] alloc_pc_i,
    input  logic [31:0] alloc_instr_i,
    input  logic [4:0] alloc_arch_dst_i,
    input  logic [TAG_WIDTH-1:0] alloc_phys_dst_i,
    output logic [TAG_WIDTH-1:0] alloc_rob_tag_o,
    output logic alloc_ready_o,
    
    // Completion interface
    input  logic complete_valid_i,
    input  logic [TAG_WIDTH-1:0] complete_rob_tag_i,
    input  logic [31:0] complete_result_i,
    input  logic complete_exception_i,
    
    // Commit interface
    output logic commit_valid_o,
    output logic [4:0] commit_arch_dst_o,
    output logic [TAG_WIDTH-1:0] commit_phys_dst_o,
    output logic [31:0] commit_result_o,
    
    // Recovery interface
    output logic flush_o,
    output logic [31:0] recovery_pc_o
);
```

### 3.2 Load/Store Queue
**Objective**: Handle memory operations out-of-order

**New Modules to Create**:
```
digital/modules/load_store_queue/
├── src/
│   ├── load_queue.sv               # Load operation queue
│   ├── store_queue.sv              # Store operation queue
│   ├── memory_disambiguation.sv    # Address dependency check
│   ├── store_buffer.sv             # Store data buffering
│   └── lsq_top.sv                  # Top-level integration
├── lsq.f
└── README.md
```

**Key Features**:
- Load queue for pending loads
- Store queue for pending stores
- Memory address disambiguation
- Store-to-load forwarding
- Memory ordering enforcement

### 3.3 Enhanced Register File
**Objective**: Support multiple reads/writes per cycle

**Modifications Required**:
```
digital/modules/register_file_super/
├── src/
│   ├── multi_port_register_file.sv # 6R4W or 8R4W register file
│   ├── register_file_arbiter.sv    # Port arbitration
│   └── bypass_network.sv           # Internal forwarding
├── regfile.f
└── README.md
```

## Phase 4: Advanced Features and Optimization

### 4.1 Advanced Branch Prediction
**Enhancements**:
- Tournament predictor (combining multiple predictors)
- Indirect branch target prediction
- Loop detection and optimization
- Branch confidence estimation

### 4.2 Memory System Enhancement
**New Features**:
- Data cache integration
- Memory prefetching
- Store buffer optimization
- Memory scheduling improvements

### 4.3 Performance Monitoring
**New Modules**:
```
digital/modules/performance_counters/
├── src/
│   ├── performance_counters.sv     # Hardware counters
│   ├── ipc_monitor.sv              # Instructions per cycle tracking
│   ├── cache_monitor.sv            # Cache performance metrics
│   └── branch_monitor.sv           # Branch prediction metrics
├── perf.f
└── README.md
```

## Implementation Strategy

### Development Approach
1. **Incremental Development**: Implement one phase at a time
2. **Maintain Compatibility**: Keep existing interfaces working
3. **Extensive Testing**: Test each phase thoroughly before proceeding
4. **Performance Validation**: Measure performance improvements at each step

### Testing Strategy
1. **Unit Testing**: Test individual modules in isolation
2. **Integration Testing**: Test module interactions
3. **Regression Testing**: Ensure existing functionality remains working
4. **Performance Testing**: Validate performance improvements
5. **Compliance Testing**: Ensure RV32I specification compliance

### Directory Structure
```
digital/modules/
├── superscalar/                    # New superscalar modules
│   ├── frontend/                   # Frontend components
│   ├── backend/                    # Backend components
│   ├── execution/                  # Execution units
│   ├── memory/                     # Memory subsystem
│   └── common/                     # Shared components
├── legacy/                         # Original in-order modules (backup)
└── integration/                    # Integration modules
```

## Risk Assessment and Mitigation

### High-Risk Areas
1. **Register Renaming Complexity**: Mitigation - Start with simple implementation
2. **Memory Disambiguation**: Mitigation - Conservative approach initially
3. **Exception Handling**: Mitigation - Maintain precise exception semantics
4. **Verification Complexity**: Mitigation - Extensive testing infrastructure

### Critical Path Considerations
1. **Issue Logic**: May become timing critical
2. **Wakeup Logic**: Wide fan-out may impact timing
3. **Register File**: Multiple ports may impact area/timing

## Success Metrics

### Performance Targets
- **IPC Improvement**: 1.5-2.5x over current implementation
- **Frequency**: Maintain or improve current maximum frequency
- **Area**: Reasonable area increase (2-3x acceptable)

### Functionality Requirements
- **ISA Compliance**: Full RV32I compatibility maintained
- **Exception Handling**: Precise exceptions preserved
- **Memory Consistency**: Correct memory ordering

## Conclusion

This conversion plan provides a structured approach to transforming the current in-order RV32I processor into a high-performance superscalar out-of-order processor. The phased approach ensures maintainability and reduces implementation risk while delivering significant performance improvements.

**Next Steps**:
1. Set up development environment on `superscalar-development` branch
2. Begin Phase 1 implementation with multi-fetch unit
3. Establish testing infrastructure for new modules
4. Create detailed specifications for each new module
