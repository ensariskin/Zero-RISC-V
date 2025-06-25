# RISC-V RV32I Processor Project Change Log (June 25, 2025)

This log summarizes the changes made to the RISC-V processor project since the previous changelog.

## Major Changes

### 1. Instruction Decoder Enhancements
- Fixed critical JALR instruction handling in `rv32i_decoder.sv`:
  - Corrected the `load` and `jalr` flags in JALR instruction case (7'b1100111)
  - Proper setting of `save_pc` flag for JALR instructions
- Fixed memory width selection for load/store operations:
  - Corrected `func3` indexing from `func3[14:12]` to simply `func3`

### 2. Control Signal Consistency
- Added missing `save_pc` flag initialization in default case block
- Improved control signal propagation throughout the pipeline
- Enhanced clarity of control word structure

### 3. File Format Standardization
- Updated all filename references in .f files to match SystemVerilog naming conventions
- Ensured consistent file inclusion patterns across module directories

## File Statistics
- Total files changed: 3
- Modified files: 3
  - `rv32i_decoder.sv` - Fixed critical control signal bugs
  - `digital_top.f` - Updated file references
  - `decode_stage.f` - Standardized file naming

## Functional Changes

### JALR Instruction Handling
- Fixed a critical bug where JALR instructions were incorrectly flagged as load instructions
- Properly set the `jalr` flag to 1'b1 and `load` flag to 1'b0 for JALR opcodes
- Ensured consistent PC saving behavior for jump operations

### Memory Access Control
- Corrected memory width selector field extraction from instruction
- Fixed potential issue with incorrect memory addressing for byte/half-word operations

### Default Instruction Handling
- Added proper initialization for `save_pc` flag in the default case
- Improved handling of invalid or unsupported instructions

## Next Steps

- Continue standardizing signal naming throughout the codebase
- Verify corrected JALR functionality with additional test cases
- Further optimize memory access pattern for byte and half-word operations
- Implement comprehensive regression tests focusing on JALR instructions
