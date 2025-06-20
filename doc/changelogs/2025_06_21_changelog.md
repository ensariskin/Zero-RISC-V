# RISC-V RV32I Processor Project Change Log (June 21, 2025)

This log summarizes the changes made to the RISC-V processor project since the initial commit.

## Major Changes

### 1. File Format and Extension Changes
- Converted all design files from Verilog (`.v`) to SystemVerilog (`.sv`)
- Updated file references in the directory structure and file lists (`.f` files)

### 2. Module Renaming and Standardization
- Renamed `instruction_fetch` directory to `fetch_stage`
- Renamed `instruction_decode` directory to `decode_stage`
- Renamed key files:
  - `PC_new.v` → `program_counter_ctrl.sv`
  - `ES_IMM_Decoder.v` → `early_stage_immediate_decoder.sv`
  - `IF.v` → `fetch_stage.sv`
  - `ID.v` → `decode_stage.sv`
  - `Instruction_decoder.v` → `rv32i_decoder.sv`
  - `TOP_Pipelined_design.v` → `rv32i_core.sv`
  - `Branch_predictor.v` → `branch_predictor.sv`

### 3. Documentation Updates
- Added/updated README files in multiple directories:
  - Created new `fetch_stage/README.md`
  - Created new `decode_stage/README.md`
  - Updated main `digital/README.md`
  - Updated project-level `README.md`
- Added detailed documentation for each component
- Added information about module interactions, control flow, and signal descriptions

### 4. Git Configuration
- Added `.gitignore` file with 11 additions
- Added specific rule for `.dvt/` directory
- Removed previously tracked `.dvt` directory files

### 5. VS Code Configuration
- Added `RV32I-Processor.code-workspace` with IDE-specific settings
  - File associations for `.v` and `.vh` files
  - Editor configurations (tab size, spaces, whitespace handling)
  - Search exclusion patterns for simulation artifacts
  - Extension recommendations

### 6. Module Enhancements
- Updated the `branch_predictor` with improved JALR instruction handling
- Enhanced `program_counter_ctrl` with better branch prediction support
- Updated `decode_stage` to handle bubble insertion for hazard handling

## File Statistics
- Total files changed: 68
- Insertions: 914
- Deletions: 891

## Functional Changes

### Branch Prediction
- Enhanced branch prediction logic with JALR instruction handling
- Improved the PC update logic for speculative execution

### Pipeline Control
- Streamlined control signal propagation through pipeline stages
- Enhanced the control word generation in the decode stage

### SystemVerilog Features
- Converted to SystemVerilog for advanced language features
- Updated module declarations and parameter handling

## Key Commits

- 96975c9: Initial commit: Add complete RV32I processor implementation
- 35708af: Renamed modules and signals
- dbd9069: Fixed various issues
- 332b13a: Updated README files
- ed7938c: Latest enhancements (current HEAD)

## Next Steps

- Continue standardizing naming conventions
- Update testbenches for SystemVerilog compatibility
- Enhance documentation with signal descriptions
- Consider adding simulation instructions and examples
