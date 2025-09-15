# RV32I Superscalar Processor Architecture Specification

## Overview

This document specifies the architecture for a 3-way superscalar RV32I processor implementing the Tomasulo algorithm for out-of-order execution. The design focuses on optimal timing, frequency scaling, and efficient dependency resolution.

## Design Philosophy

The architecture prioritizes:
- **Critical path optimization** by distributing logic across pipeline stages
- **Local dependency resolution** with register file close to reservation stations
- **Efficient tag-based tracking** for RAW, WAR, and WAW hazard elimination
- **Scalable frequency** through balanced pipeline stage complexity

## Pipeline Architecture

### Three-Stage Pipeline Overview

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ FETCH STAGE │───▶│ ISSUE STAGE │───▶│DISPATCH STAGE│
│             │    │             │    │             │
│ 3-way       │    │ 3-way       │    │ 3-way       │
│ Instruction │    │ Decode +    │    │ Reservation │
│ Fetch       │    │ Rename      │    │ Stations    │
└─────────────┘    └─────────────┘    └─────────────┘
```

## Stage 1: FETCH STAGE

### Purpose
Fetch up to 3 instructions per cycle and provide them to the issue stage with proper branch prediction and PC management.

### Key Components
- **3-way Instruction Fetch Unit**
- **Branch Predictor** (predict taken/not-taken)
- **Next PC Calculator**
- **Instruction Buffer** (feeds subsequent stages)

### Responsibilities
1. **Instruction Memory Access**: Read 3 aligned instructions per cycle
2. **Branch Prediction**: Predict branch outcomes for control flow
3. **PC Management**: Calculate next PC based on prediction
4. **Instruction Buffering**: Maintain instruction queue for issue stage
5. **Fetch Bandwidth Management**: Handle variable fetch width (1-3 instructions)

### Outputs to Issue Stage
- 3 instruction words (32-bit each)
- PC values for each instruction
- Branch prediction results
- Valid signals for each instruction

## Stage 2: ISSUE STAGE

### Purpose
Decode instructions and perform register renaming to eliminate WAR and WAW dependencies while maintaining short critical path.

### Key Components
- **3 Parallel RV32I Decoders**
- **Register Alias Table (RAT)** - 32 arch → 64 physical registers
- **Free List Manager** (physical register allocation)
- **Pipeline Registers** (issue → dispatch)

### Responsibilities
1. **Instruction Decoding**: Parse 3 instructions in parallel
2. **Register Renaming**: Map architectural to physical registers
3. **Dependency Breaking**: Eliminate WAR/WAW through renaming
4. **Physical Register Allocation**: Manage 64-register free list
5. **Control Signal Generation**: Create execution control signals

### Critical Path Optimization
```
Architectural Register Address → RAT Lookup → Physical Register Address
```
**Key Point**: This stage outputs physical register addresses only, NOT data values, keeping the critical path short.

### Outputs to Dispatch Stage
- Control signals for execution (11-bit per instruction)
- Physical register addresses (rs1_phys, rs2_phys, rd_phys)
- Immediate values and PC information
- Store data paths
- Valid/ready signals

### RAT (Register Alias Table) Details
- **Mapping**: 32 architectural → 64 physical registers
- **Free List**: Tracks available physical registers (32-63 initially free)
- **Allocation**: Up to 3 registers per cycle
- **Recovery**: Commit interface for freeing old physical registers

## Stage 3: DISPATCH STAGE

### Purpose
Perform dependency resolution, data access, and instruction issue to functional units using reservation stations and co-located register file.

### Key Components
- **3 Reservation Stations** (one per functional unit)
- **64-Entry Physical Register File** (6 read + 3 write ports)
- **Common Data Bus (CDB)** - 3 channels for result broadcasting
- **Dependency Resolution Logic**

### Responsibilities
1. **Data Access**: Read operand values using physical register addresses
2. **Dependency Tracking**: Monitor operand readiness via tag system
3. **Instruction Issue**: Send ready instructions to functional units
4. **Result Broadcasting**: Forward results via CDB to pending instructions
5. **RAW Hazard Resolution**: Ensure data dependencies are satisfied

### Tag System for Dependency Resolution
- **Tag Encoding**: 
  - `2'b00` = ALU0 result pending
  - `2'b01` = ALU1 result pending  
  - `2'b10` = ALU2 result pending
  - `2'b11` = Valid data available
- **Tag Matching**: Reservation stations monitor CDB for matching tags
- **Operand Readiness**: Instructions issue only when both operands ready

### Register File Architecture
- **Size**: 64 physical registers (32-bit each)
- **Ports**: 6 read ports (2 per RS) + 3 write ports (1 per CDB channel)
- **Tag Storage**: Each entry has associated 2-bit tag
- **CDB Integration**: Direct write from CDB results

### Reservation Station Operation
```
1. Receive instruction from Issue Stage (physical addresses only)
2. Access Register File to read operand data/tags
3. Check operand readiness (tag == 2'b11 means ready)
4. Listen to CDB for pending operand results
5. Issue instruction when both operands ready
6. Forward result via CDB when execution completes
```

## Critical Path Analysis

### Issue Stage Critical Path
```
Arch_Reg_Addr → RAT_Lookup → Phys_Reg_Addr → Pipeline_Reg
```
**Timing**: RAT lookup + setup time (optimized for frequency)

### Dispatch Stage Critical Path  
```
Phys_Reg_Addr → RegFile_Access → Tag_Check → Issue_Decision
```
**Timing**: Register file access + combinational logic (balanced)

## Interface Specifications

### Fetch → Issue Interface
- `instruction_word[2:0]` - 3 instruction words
- `pc_value[2:0]` - PC for each instruction  
- `branch_prediction[2:0]` - Prediction results
- `valid[2:0]` - Valid instruction indicators

### Issue → Dispatch Interface (decode_to_rs_if)
- `control_signals[10:0]` - Execution control (no register addresses)
- `operand_a_phys_addr[5:0]` - Physical register address for rs1
- `operand_b_phys_addr[5:0]` - Physical register address for rs2  
- `rd_phys_addr[5:0]` - Destination physical register
- `immediate_value[31:0]` - Sign-extended immediate
- `pc[31:0]` - Program counter
- `dispatch_valid` - Instruction ready signal

### Dispatch → Execution Interface (rs_to_exec_if)
- `data_a[31:0]` - First operand value
- `data_b[31:0]` - Second operand value
- `func_sel[3:0]` - Function select for ALU
- `issue_valid` - Instruction ready for execution
- `data_result[31:0]` - Execution result (back from FU)

### Common Data Bus Interface (cdb_if)
- `cdb_valid[2:0]` - Result valid for each channel
- `cdb_data[2:0][31:0]` - Result data from each ALU
- `cdb_tag[2:0][1:0]` - Source ALU tag for each result
- `cdb_dest_reg[2:0][5:0]` - Destination physical register

## Functional Units

### ALU Configuration
- **ALU0**: Arithmetic/Logic operations (RS0)
- **ALU1**: Arithmetic/Logic operations (RS1)  
- **ALU2**: Arithmetic/Logic operations (RS2)
- **Future**: Load/Store unit, Branch unit, Multiplier

### Execution Timing
- **Single Cycle**: Most ALU operations
- **Multi-Cycle**: Future multiplication, division
- **Variable Latency**: Memory operations (future)

## Performance Characteristics

### Instruction Throughput
- **Peak**: 3 instructions per cycle (IPC = 3.0)
- **Realistic**: 1.5-2.5 IPC depending on dependencies
- **Bottlenecks**: Branch misprediction, memory latency

### Frequency Targets
- **Current Goal**: Optimize for timing closure
- **Critical Paths**: Balanced across 3 pipeline stages
- **Register File**: Multi-port design impacts frequency

## Design Benefits

1. **Timing Optimization**: Critical path split across stages
2. **Local Dependency Resolution**: Register file co-located with RS
3. **Efficient CDB**: Direct register file updates
4. **Scalable Design**: Clean interfaces enable future expansion
5. **Tag-Based Tracking**: Efficient dependency resolution

## Future Enhancements

1. **Memory Operations**: Load/Store reservation stations
2. **Branch Prediction**: More sophisticated prediction algorithms  
3. **Register File**: Banking for higher frequency
4. **Instruction Buffer**: Larger buffer for fetch bandwidth
5. **ROB Integration**: Reorder buffer for precise exceptions

---

**Document Version**: 1.0  
**Date**: September 15, 2025  
**Architecture**: RV32I 3-way Superscalar with Tomasulo Algorithm