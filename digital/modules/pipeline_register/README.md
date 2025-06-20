# Pipeline Registers

The pipeline registers separate the different stages of the processor pipeline, storing intermediate results and control signals. All registers use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### IF_ID.v

The Instruction Fetch to Instruction Decode pipeline register:
- Stores fetched instruction
- Preserves PC+4 value for JAL/JALR instructions
- Holds immediate value from the decoder
- Maintains branch prediction information
- Supports pipeline flush during branch misprediction

### ID_EX.v

The Instruction Decode to Execute pipeline register:
- Stores register values (A and B operands)
- Preserves control signals for later stages
- Holds immediate values and PC+4 for address calculation
- Maintains branch selection and prediction information
- Supports pipeline flush signals

### EX_MEM.v

The Execute to Memory Access pipeline register:
- Stores ALU results from the execute stage
- Holds data for memory operations
- Preserves control signals for memory and write-back stages
- Maintains PC+4 for JAL/JALR instructions
- Includes memory operation control signals

### MEM_WB.v

The Memory Access to Write Back pipeline register:
- Stores ALU results and memory load data
- Preserves control signals for the write-back stage
- Maintains PC+4 for JAL/JALR instructions
- Includes register write-back control signals

## Operation

1. At each clock edge, pipeline registers capture all necessary data from the previous stage
2. Signals are maintained until the next clock edge when they are passed to the next stage
3. During pipeline stalls, values may be preserved for multiple cycles
4. During pipeline flushes, registers may be cleared to remove incorrect speculative execution

## Key Features

- Synchronous operation with the system clock
- Asynchronous reset capability
- Support for pipeline stalls (bubbles)
- Support for pipeline flushes during branch mispredictions
- Preservation of all necessary signals between pipeline stages
