# Hazard Handling Components

This directory contains modules that detect and handle pipeline hazards in the processor. All components use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### Data_Forward.v

The Data Forwarding Unit:
- Detects data dependencies between instructions in different pipeline stages
- Forwards results from later pipeline stages to earlier ones
- Resolves Read-After-Write (RAW) hazards without pipeline stalls
- Supports forwarding from:
  - MEM stage to EX stage
  - WB stage to EX stage

### Hazard_Detection.v

The Hazard Detection Unit:
- Detects hazards that cannot be resolved by forwarding
- Handles load-use hazards (when an instruction uses the result of a load immediately)
- Inserts pipeline bubbles (stalls) when necessary
- Coordinates with the control unit to ensure proper pipeline operation

## Operation

### Data Forwarding

1. Monitors register addresses in different pipeline stages
2. Detects when a source register in EX stage matches a destination register in MEM or WB stage
3. Controls multiplexers in the EX stage to select forwarded data instead of register file output
4. Prioritizes forwarding from the nearest stage (MEM has priority over WB)

### Hazard Detection

1. Monitors the pipeline for potential hazards
2. For load-use hazards:
   - Detects when an instruction in ID stage needs the result of a load in EX stage
   - Stalls the pipeline by:
     - Holding IF and ID stage registers
     - Inserting a bubble in the EX stage
3. Works with the branch prediction and correction mechanism for control hazards

## Key Features

- Minimizes pipeline stalls for improved performance
- Ensures correct execution despite data dependencies
- Coordinates with branch prediction for control hazards
- Maintains pipeline integrity during hazardous conditions
- Low-latency detection and resolution logic
- Comprehensive hazard coverage for all RV32I instructions
- Uses consistent `100 ps / 1 ps` timescale for accurate simulation
