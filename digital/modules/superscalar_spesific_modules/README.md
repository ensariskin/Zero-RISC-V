# Superscalar Module Organization

This directory contains the 3-way superscalar processor modules organized by pipeline stage:

## Directory Structure

```
superscalar_spesific_modules/
├── fetch_stage/              # Stage 1: Instruction Fetch
├── issue_stage/              # Stage 2: Decode + Rename  
├── dispatch_stage/           # Stage 3: Reservation Stations + Register File
├── interfaces/               # Pipeline stage interfaces
├── common/                   # Shared utility modules
├── top/                      # Top-level integration
└── src/                      # Legacy (empty after reorganization)
```

## Pipeline Stages

### Fetch Stage
- **Purpose**: 3-way instruction fetch with branch prediction
- **Key Modules**: fetch_buffer_top, multi_fetch, instruction_buffer
- **Features**: Branch prediction, PC control, instruction buffering

### Issue Stage  
- **Purpose**: Instruction decode and register renaming
- **Key Modules**: issue_stage, register_alias_table
- **Features**: 3-way decode, RAT management, critical path optimization

### Dispatch Stage
- **Purpose**: Dependency resolution and instruction dispatch
- **Key Modules**: dispatch_stage, reservation_station, multi_port_register_file
- **Features**: Tag-based dependency tracking, CDB broadcasting

## Interfaces
- `decode_to_rs_if`: Issue stage → Dispatch stage
- `rs_to_exec_if`: Dispatch stage → Functional units  
- `cdb_if`: Common Data Bus for result broadcasting

## File Lists
- `fetch_stage.f`: Files for fetch stage compilation
- `issue_stage.f`: Files for issue stage compilation
- `dispatch_stage.f`: Files for dispatch stage compilation
- `interfaces.f`: Interface definitions
- `common.f`: Shared utility modules

## Architecture Benefits
- **Modular Design**: Clean separation by pipeline stage
- **Critical Path Optimization**: Register file moved to dispatch stage
- **Interface-Based**: Clean communication between stages
- **Scalable**: Easy to add new features per stage

- `rv32i_superscalar_core.sv` - Main superscalar processor core integrating all pipeline stages

## Key Features

- 3-way superscalar fetch
- Instruction buffer for fetch/decode decoupling  
- Branch prediction with fetch optimization
- Multi-port register file interface
- Performance monitoring counters
- Debug and status interfaces

## TODO

- Implement multi-decode units
- Add proper execution units
- Implement memory pipeline stage
- Add register file with forwarding
- Implement exception/interrupt handling
- Add CSR (Control and Status Register) support
