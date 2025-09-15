# Superscalar Architecture Conversion Plan

## Current State Analysis

### Existing Design Structure
```
current_fetch_stage → multi_decode_stage → individual_reservation_stations → functional_units
                      (decode + RAT +      (3 separate modules)
                       register_file)
```

### Target Architecture Structure  
```
fetch_stage → issue_stage → dispatch_stage → functional_units
             (decode + RAT)  (3 RS + shared
                            register_file)
```

## Conversion Strategy

### Phase 1: Interface and Module Restructuring

#### Task 1: Rename Pipeline Stages
- **Current**: `multi_decode_stage.sv` → **Target**: `issue_stage.sv`
- **Current**: Individual `reservation_station.sv` → **Target**: Integrated into `dispatch_stage.sv`
- **Current**: `fetch_stage.sv` → **Target**: Keep as `fetch_stage.sv` (minimal changes)

#### Task 2: Update Interface Definitions
**modify `decode_to_rs_if.sv`**:
```systemverilog
// REMOVE these data signals:
// logic [DATA_WIDTH-1:0] operand_a_data;
// logic [DATA_WIDTH-1:0] operand_b_data;

// ADD physical register addresses instead:
logic [PHYS_REG_ADDR_WIDTH-1:0] operand_a_phys_addr;
logic [PHYS_REG_ADDR_WIDTH-1:0] operand_b_phys_addr;
```

### Phase 2: Issue Stage Modification (Critical Path Optimization)

#### Task 3: Remove Register File from Issue Stage
**File**: `multi_decode_stage.sv` → `issue_stage.sv`

**Changes Required**:
1. **Remove multi_port_register_file instantiation**
2. **Keep RAT and decoders only**
3. **Output physical register addresses instead of data**
4. **Remove data pipeline registers**

**Critical Path Becomes**:
```
arch_register_address → RAT_lookup → physical_register_address → pipeline_register
```

#### Task 4: Update Issue Stage Outputs
```systemverilog
// REMOVE: 
// assign decode_to_rs_0.operand_a_data = data_a_reg_0;
// assign decode_to_rs_0.operand_b_data = data_b_reg_0;

// ADD:
assign decode_to_rs_0.operand_a_phys_addr = rs1_phys_0;
assign decode_to_rs_0.operand_b_phys_addr = rs2_phys_0;
```

### Phase 3: Create New Dispatch Stage

#### Task 5: Design dispatch_stage.sv Module
**New module structure**:
```systemverilog
module dispatch_stage (
    // Clock and reset
    input logic clk, reset,
    
    // From issue stage (3 interfaces)
    decode_to_rs_if.reservation_station issue_to_dispatch_0,
    decode_to_rs_if.reservation_station issue_to_dispatch_1, 
    decode_to_rs_if.reservation_station issue_to_dispatch_2,
    
    // To functional units
    rs_to_exec_if.reservation_station dispatch_to_alu_0,
    rs_to_exec_if.reservation_station dispatch_to_alu_1,
    rs_to_exec_if.reservation_station dispatch_to_alu_2,
    
    // CDB interface
    cdb_if.dispatch cdb_interface
);
```

#### Task 6: Integrate Components in Dispatch Stage
**Components to include**:
1. **64-entry multi-port register file** (moved from issue stage)
2. **3 reservation stations** (modified for register file access)
3. **CDB arbitration logic**
4. **Tag management system**

### Phase 4: Register File Integration

#### Task 7: Multi-Port Register File Configuration
```systemverilog
multi_port_register_file #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(6),        // 64 physical registers
    .NUM_READ_PORTS(6),    // 2 per reservation station
    .NUM_REGISTERS(64)
) physical_reg_file (
    // 6 read ports (2 per RS)
    .read_addr_0(rs1_phys_addr_0), .read_addr_1(rs2_phys_addr_0),  // RS0
    .read_addr_2(rs1_phys_addr_1), .read_addr_3(rs2_phys_addr_1),  // RS1  
    .read_addr_4(rs1_phys_addr_2), .read_addr_5(rs2_phys_addr_2),  // RS2
    
    // 6 read outputs
    .read_data_0(operand_a_data_0), .read_data_1(operand_b_data_0), // RS0
    .read_data_2(operand_a_data_1), .read_data_3(operand_b_data_1), // RS1
    .read_data_4(operand_a_data_2), .read_data_5(operand_b_data_2), // RS2
    
    // 3 write ports (from CDB)
    .write_enable_0(cdb_valid_0), .write_addr_0(cdb_dest_reg_0), .write_data_0(cdb_data_0),
    .write_enable_1(cdb_valid_1), .write_addr_1(cdb_dest_reg_1), .write_data_1(cdb_data_1),
    .write_enable_2(cdb_valid_2), .write_addr_2(cdb_dest_reg_2), .write_data_2(cdb_data_2)
);
```

### Phase 5: Reservation Station Redesign

#### Task 8: Modify Reservation Station Logic
**Key Changes**:
1. **Remove internal data storage** (operand_a_data, operand_b_data)
2. **Add register file access logic**
3. **Tag checking with co-located register file**
4. **Direct CDB result forwarding**

**New RS Operation Flow**:
```systemverilog
// 1. Receive physical addresses from issue stage
rs_entry.operand_a_phys_addr <= issue_if.operand_a_phys_addr;
rs_entry.operand_b_phys_addr <= issue_if.operand_b_phys_addr;

// 2. Access register file for data and tags
assign reg_file_read_addr_a = rs_entry.operand_a_phys_addr;
assign reg_file_read_addr_b = rs_entry.operand_b_phys_addr;

// 3. Check readiness based on tags from register file
assign operand_a_ready = (reg_file_tag_a == 2'b11);
assign operand_b_ready = (reg_file_tag_b == 2'b11);

// 4. Issue when both operands ready
assign can_issue = operand_a_ready && operand_b_ready && rs_entry.valid;
```

### Phase 6: CDB Integration

#### Task 9: Direct Register File Updates
**CDB to Register File Connection**:
```systemverilog
// CDB results write directly to register file, no intermediate storage
assign reg_file_write_enable[0] = cdb_valid_0;
assign reg_file_write_addr[0] = cdb_dest_reg_0;
assign reg_file_write_data[0] = cdb_data_0;
assign reg_file_write_tag[0] = 2'b11; // Mark as valid data

// Similar for channels 1 and 2
```

### Phase 7: Top-Level Integration

#### Task 10: Update rv32i_superscalar_core.sv
**Connection Updates**:
```systemverilog
// New 3-stage pipeline
fetch_stage fetch_inst (
    // Keep existing connections
);

issue_stage issue_inst (  // Renamed from multi_decode_stage
    // Remove register file ports
    // Keep RAT and decoder connections
);

dispatch_stage dispatch_inst (  // New integrated module
    // Connect to issue stage outputs
    // Connect to functional units
    // Connect CDB
);
```

## Implementation Order

### Week 1: Infrastructure
1. ✅ Create architecture document
2. ✅ Create conversion plan
3. Create `decode_to_rs_if` interface updates
4. Rename `multi_decode_stage` to `issue_stage`

### Week 2: Issue Stage
5. Remove register file from issue stage
6. Update interface connections
7. Test issue stage timing and functionality

### Week 3: Dispatch Stage  
8. Create `dispatch_stage.sv` module
9. Integrate register file and reservation stations
10. Implement CDB direct write logic

### Week 4: Integration and Testing
11. Update top-level connections
12. Create comprehensive testbench
13. Verify timing and performance
14. Optimization and debugging

## Validation Criteria

### Functional Verification
- [ ] All 3 pipeline stages operate correctly
- [ ] Register renaming works properly  
- [ ] Dependency resolution via tags
- [ ] CDB result broadcasting
- [ ] Instruction issue and execution

### Timing Verification
- [ ] Critical paths balanced across stages
- [ ] Register file access timing
- [ ] RAT lookup timing
- [ ] Interface setup/hold times

### Performance Verification  
- [ ] IPC measurement (target: 1.5-2.5)
- [ ] Frequency scaling capability
- [ ] Resource utilization efficiency

---

**Plan Version**: 1.0  
**Estimated Duration**: 4 weeks  
**Risk Level**: Medium (register file timing)  
**Success Criteria**: Improved frequency + maintained functionality