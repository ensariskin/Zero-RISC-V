# RISC-V RV32I Processor Project Change Log (June 22, 2025)

This log summarizes the changes made to the RISC-V processor project since commit a3fd91a.

## Major Changes

### 1. Pipeline Register Refactoring
- Renamed and redesigned all pipeline register modules:
  - `IF_ID.sv` → `if_to_id.sv`
  - `ID_EX.sv` → `id_to_ex.sv`
  - `EX_MEM.sv` → `ex_to_mem.sv`
  - `MEM_WB.sv` → `mem_to_wb.sv`
- Converted from D_FF_async_rst instantiation to modern always blocks
- Improved reset handling and signal initialization

### 2. Fetch Stage Enhancements
- Renamed `branch_predictor` module to `jump_controller`
- Standardized signal names (e.g., `IMM` → `imm`, `PC_Addr` → `pc_addr`)
- Improved clarity of control flow signals

### 3. Decoder Module Improvements
- Enhanced early_stage_immediate_decoder to handle immediate values more efficiently
- Unified interface for the decode stage modules
- Improved signal naming for better consistency with RISC-V specifications
- Enhanced decoder outputs to better support the control logic

### 4. Hazard Detection Overhaul
- Renamed `Hazard_Detection.sv` to `hazard_detection_unit.sv`
- Added proper reset handling to hazard detection logic
- Enhanced synchronization of bubble insertion

### 5. SystemVerilog Improvements
- Consistently used `logic` type for all signals
- Added parameter types for improved type checking
- Improved module port declarations

### 6. Simulation Cleanup
- Removed environment-specific simulation files from version control
  - Deleted `dsim.env` and `dvlcom.env`

## File Statistics
- Total files changed: 11
- Renamed files: 7
- New files: 4
- Deleted files: 7

## Functional Changes

### Control Flow Enhancements
- Improved jump/branch handling logic
- Clarified the relationship between jump controller and PC control
- Standardized signal names and interfaces

### Pipeline Register Design
- Converted from component-based to process-based design
- Improved flush handling in pipeline registers
- Enhanced synchronization and reset logic

### Code Quality
- Standardized naming conventions (snake_case)
- Improved logic organization
- Enhanced SystemVerilog compatibility

### RV32I Decoder Enhancements
- Completely redesigned `rv32i_decoder.sv` with improved structure:
  - Converted from Verilog to fully typed SystemVerilog
  - Enhanced instruction type detection with cleaner logic
  - Implemented dedicated decode paths for each instruction type (R, I, S, B, U, J)
  - Added comprehensive comments for instruction formats and fields
  - Improved ALU operation encoding for better execution stage compatibility
- Added support for more efficient branch and jump handling:
  - Direct connection to jump controller signals
  - Enhanced immediate value generation for branch targets
  - Better integration with program counter control logic
- Optimized control word generation:
  - Consolidated control signals for cleaner pipeline propagation
  - Improved hazard handling support
  - Enhanced forwarding capability support
  - Clearer memory operation encoding

### Control Word Structure Refinement
- Refined the 26-bit control word output from `rv32i_decoder.sv` with clearer organization:
  - Bits [25:21]: Destination register address (d_addr) - 5 bits
    - Target register for write operations
    - Set to 0 when write is disabled
  - Bits [20:16]: B operand address selection (b_select) - 5 bits
    - Source register address for operand B
  - Bits [15:11]: A operand address selection (a_select) - 5 bits
    - Source register address for operand A
    - Set to 0 for certain U-type and J-type instructions
  - Bits [10:7]: ALU function select (function_select) - 4 bits
    - 0000: ADD operation
    - 0001: SUB operation
    - 0010: SLT (Set Less Than)
    - 0011: SLTU (Set Less Than Unsigned)
    - 0100: XOR operation
    - 0101: OR operation
    - 0110: AND operation
    - 1000: SLL (Shift Left Logical)
    - 1001: SRA (Shift Right Arithmetic)
    - 1010: SRL (Shift Right Logical)
  - Bit [6]: Register write enable (we) - 1 bit
    - Enables writing to the register file
    - Active for R-type, I-type, U-type, and J-type instructions
  - Bit [5]: Save PC (save_pc) - 1 bit
    - Indicates PC value should be saved
    - Active for JAL, JALR, and AUIPC instructions
  - Bit [4]: Load operation (load) - 1 bit
    - Indicates memory load operation
  - Bit [3]: Use immediate (use_immediate) - 1 bit
    - Selects immediate value as an operand
    - Active for I-type, S-type, U-type, and J-type instructions
  - Bits [2:0]: Memory width select (mem_width_sel) - 3 bits
    - Controls data width for load/store operations
    - Based on func3 field for load/store instructions
- Added separate branch selection output (branch_sel) - 3 bits
  - 000: No branch
  - 010: BEQ (Branch if Equal)
  - 011: BNE (Branch if Not Equal)
  - 100: BLT/BLTU (Branch if Less Than)
  - 101: BGE/BGEU (Branch if Greater or Equal)
  - 110: JAL (Jump And Link)
  - 111: JALR (Jump And Link Register)
- Improved handling of bubble insertion with zero-out of control signals
- Enhanced instruction type detection with clearer logic separation

## Key Modules Updated

- `fetch_stage.sv`: Updated interfaces and signal names
- `program_counter_ctrl.sv`: Improved control logic and signal naming
- `jump_controller.sv`: Renamed from branch_predictor with updated logic
- `early_stage_immediate_decoder.sv`: Enhanced immediate value handling
- `rv32i_decoder.sv`: Major overhaul with improved instruction detection, SystemVerilog typing, better control signal generation, and enhanced immediate value handling
- `hazard_detection_unit.sv`: Improved reset handling and synchronization
- All pipeline register modules: Complete redesign with modern SystemVerilog practices

## Next Steps

- Continue standardizing naming conventions across all modules
- Update documentation to match new module names and interfaces
- Enhance testbenches to verify changes in pipeline behavior
- Improve clock domain handling and synchronization
