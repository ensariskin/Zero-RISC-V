# RISC-V RV32I Processor Project Change Log (June 23, 2025)

This log summarizes the changes made to the RISC-V processor project since the previous changelog.

## Major Changes

### 1. Signal Naming Standardization
- Continued standardizing signal names across all modules:
  - Renamed signal names to follow snake_case convention
  - Changed capitalized names to lowercase (e.g., `Predicted_MPC` → `branch_prediction`)
  - Renamed confusing signal names to improve clarity (e.g., `isValid` → `misprediction`)

### 2. Module Interface Improvements
- Updated module port declarations to use consistent naming:
  - Modified fetch stage input/output ports (`ins_address` → `current_pc`, `PCPlus` → `pc_save`)
  - Enhanced pipeline register interface with clearer signal names
  - Standardized control signal interfaces across modules

### 3. Execute Stage Refactoring
- Renamed `EX.sv` to `execute_stage.sv` for consistency with other stage modules
- Updated execute stage with improved signal names:
  - `A_i`/`B_i` → `data_a_i`/`data_b_i`
  - `RAM_DATA_i` → `store_data_i`
  - `A_sel`/`B_sel` → `data_a_forward_sel`/`data_b_forward_sel`
  - `FU_o` → `function_unit_o`
- Enhanced branch control logic for clearer operation

### 4. SystemVerilog Type Enhancement
- Converted `wire` declarations to `logic` throughout all modules
- Added proper parameter typing to module instantiations
- Added explicit module parameter declarations in instantiations

### 5. Testbench Modernization
- Converted testbench files from Verilog (`.v`) to SystemVerilog (`.sv`)
- Updated `risc_v.dpf` simulation configuration to reference SystemVerilog testbenches
- Removed obsolete testbench files no longer compatible with the design

## File Statistics
- Total files changed: 9
- Renamed files: 1 (`EX.sv` → `execute_stage.sv`)
- Updated files: 8
- Deleted obsolete testbench files: 4

## Functional Changes

### Signal Clarity Improvements
- Enhanced signal naming for better readability and maintainability
- Improved clarity of branch prediction and misprediction handling
- Made control flow more explicit in module interfaces

### Execution Stage Enhancement
- Redesigned execution stage interface with more descriptive signal names
- Changed branch handling logic to use explicit misprediction signal
- Improved clarity of data forwarding paths

### Code Quality Improvements
- Added TODO comments for future enhancements
- Fixed inconsistencies in module interfaces
- Enhanced parameter passing with explicit declarations
- Improved module instantiation with clearer parameter declarations

## Key Modules Updated

- `digital_top/src/rv32i_core.sv`: Updated all internal signal declarations
- `common/src/parametric_mux.sv`: Improved interface with logic type declarations
- `decode_stage/src/decode_stage.sv`: Enhanced with clearer control signal interfaces
- `execute/src/execute_stage.sv`: Complete redesign with modern naming and clearer interfaces
- `fetch_stage/src/fetch_stage.sv`: Renamed signals for clarity and consistency
- `fetch_stage/src/program_counter_ctrl.sv`: Updated interface for better PC control
- `fetch_stage/src/early_stage_immediate_decoder.sv`: Improved interface and naming
- `pipeline_register/src/id_to_ex.sv`: Enhanced with better signal naming

## Next Steps

- Continue updating remaining modules with consistent naming
- Enhance testbenches for comprehensive design verification
- Add additional comments to improve code documentation
- Develop regression tests for the refactored design
- Address TODO items identified during refactoring
