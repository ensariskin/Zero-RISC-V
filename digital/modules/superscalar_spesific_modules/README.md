# Superscalar Specific Modules

This directory contains modules specifically designed for the superscalar implementation of the RV32I processor.

## Top Level Module

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
