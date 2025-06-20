# Memory Access (MEM) Stage

The Memory Access (MEM) stage handles all memory operations including loads and stores. All components in this stage use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### MEM.v

The Memory Access module that:
- Interfaces with external data memory
- Processes load and store operations
- Forwards computed values from the execute stage
- Handles memory address calculation

## Operation

1. For load instructions:
   - Uses the address computed in the EX stage
   - Applies appropriate control signals for byte, half-word, or word access
   - Receives data from memory for later processing in WB stage

2. For store instructions:
   - Uses the address computed in the EX stage
   - Sends data from the register file to memory
   - Applies appropriate control signals for byte, half-word, or word storage

3. For non-memory instructions:
   - Passes ALU results from the EX stage to the WB stage
   - Maintains control signals for later stages

## Key Features

- Memory access type control (byte, half-word, word)
- Read/write control signal generation
- Data alignment and organization for memory operations
- Memory address forwarding to data memory
