# RISC-V RV32I Processor Project Change Log (June 25, 2025)

This log summarizes the changes made to the RISC-V processor project since the previous changelog.

## Major Changes

### 1. Execute Stage Architecture Redesign
- Consolidated functional blocks for better code organization:
  - Replaced individual `FU.sv` and `ALU.sv` with a unified `function_unit_alu_shifter.sv`
  - Removed redundant `Zero_comparator.sv` module
  - Redesigned module hierarchy for improved clarity and maintainability
- Renamed and standardized all signal names to follow consistent conventions:
  - `A`/`B` → `data_a`/`data_b`
  - `S` → `data_result`
  - `Sel` → `func_sel`

### 2. ALU Components Modernization
- Enhanced `arithmetic_unit.sv`:
  - Improved signal naming for clarity
  - Optimized zero detection logic
  - Added comprehensive comments explaining operations
  - Fixed signed/unsigned handling in comparisons
- Updated `logical_unit.sv`:
  - Standardized signal names
  - Enhanced operation selection clarity
  - Improved readability with consistent naming conventions

### 3. Program Counter Control Enhancement
- Improved JALR handling in PC calculation:
  - Added additional prediction path for JALR
  - Enhanced PC+immediate calculation logic
  - Added framework for potential PC caching in jump operations
- Added comprehensive comments about potential enhancements

### 4. Documentation Improvements
- Added detailed TODO comments on remaining work:
  - JALR prediction improvements
  - Flag handling optimizations
  - Signal optimization possibilities
  - Future architectural enhancements
- Added clarifying comments on PC value preservation and jump handling

### 5. Code Quality Improvements
- Consolidated module instantiations with explicit parameter declarations
- Enhanced type safety with consistent use of SystemVerilog `logic` type
- Added detailed comments explaining design decisions
- Improved structural clarity with consistent spacing and formatting

## File Statistics
- Total files changed: 9
- New files: 1 (`function_unit_alu_shifter.sv`)
- Deleted files: 2 (`FU.sv`, `Zero_comparator.sv`)
- Modified files: 6

## Functional Changes

### Execution Unit Enhancement
- Consolidated arithmetic, logical, and shift operations into cleaner hierarchy
- Enhanced flag generation and propagation
- Improved parameter handling for better modularity
- Optimized zero detection mechanism

### Control Flow Improvements
- Enhanced PC calculation for jumps and branches
- Added proper AUIPC instruction support
- Improved JALR prediction logic
- Added foundation for performance optimizations in branch prediction

### SystemVerilog Feature Utilization
- Consistently used typed module parameters
- Employed explicit port declarations
- Leveraged modern SystemVerilog constructs for cleaner code

## Key Modules Updated

- `function_unit_alu_shifter.sv` (NEW): Consolidated function unit with ALU and shifter integration
- `alu.sv` (renamed from ALU.sv): Enhanced with improved interfaces and functionality
- `arithmetic_unit.sv`: Updated with standardized interfaces and optimized logic
- `logical_unit.sv`: Improved with clearer operation selection
- `execute_stage.sv`: Updated to use new function unit module
- `program_counter_ctrl.sv`: Enhanced with improved JALR handling

## Next Steps

- Implement optimized JALR prediction mechanism
- Enhance branch prediction accuracy
- Consider implementing PC value caching for improved jump performance
- Continue standardizing remaining components in the CPU pipeline
- Address TODOs in comment blocks throughout the codebase
- Develop comprehensive test cases for new execution unit features
