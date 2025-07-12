# Memory Access Stage

The Memory Access stage implements the fourth pipeline stage, responsible for data memory interface operations including load and store instruction execution. This stage manages all memory transactions and data alignment operations.

## Module Components

### MEM.v

Memory access control module providing:
- Data memory interface management
- Load operation data retrieval and formatting
- Store operation data transmission and alignment
- Memory address validation and control
- Memory access type selection (byte, halfword, word)
- Non-memory instruction data path forwarding

## Stage Operation

The memory access stage performs different operations based on instruction type:

### Load Instructions
1. **Address Application**: Utilizes computed address from execution stage
2. **Memory Interface**: Initiates read transaction with data memory
3. **Access Control**: Applies appropriate control signals for data width selection
4. **Data Reception**: Receives memory data for write-back stage processing
5. **Alignment Handling**: Manages byte and halfword alignment requirements

### Store Instructions
1. **Address Application**: Utilizes computed address from execution stage
2. **Data Preparation**: Formats register data for memory storage
3. **Memory Interface**: Initiates write transaction with data memory
4. **Access Control**: Applies appropriate control signals for data width selection
5. **Write Completion**: Ensures proper memory write timing and control

### Non-Memory Instructions
1. **Data Forwarding**: Passes execution stage results to write-back stage
2. **Control Preservation**: Maintains control signals for subsequent pipeline stages
3. **Pipeline Continuity**: Ensures uninterrupted pipeline flow for arithmetic operations

## Memory Interface Specification

The memory access stage implements a standardized memory interface:

- **Address Bus**: 32-bit memory address output
- **Data Bus**: 32-bit bidirectional data interface
- **Control Signals**: Read/write enable and memory access type selection
- **Timing Control**: Memory ready/valid handshaking for multi-cycle operations
- **Error Handling**: Address alignment and access violation detection

## Access Type Support

The stage supports all RISC-V memory access types:

- **Byte Access (LB/LBU/SB)**: 8-bit memory operations with sign extension control
- **Halfword Access (LH/LHU/SH)**: 16-bit memory operations with alignment handling
- **Word Access (LW/SW)**: 32-bit memory operations for full data width
- **Signed/Unsigned Loads**: Proper sign extension for byte and halfword loads
