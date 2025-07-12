# Write-Back Stage

The Write-Back stage implements the final pipeline stage, responsible for result selection and register file update operations. This stage completes the instruction execution cycle and provides data forwarding for hazard resolution.

## Module Components

### WB.v

Write-back control and data selection module providing:
- Result multiplexing from multiple data sources
- Register file write control signal generation
- Write-back data forwarding to earlier pipeline stages
- Final instruction completion processing
- Register write address and data management

## Stage Operation

The write-back stage performs the following operations:

1. **Data Source Selection**: Multiplexes between available result sources
2. **Register Write Control**: Determines register file write enable conditions
3. **Address Validation**: Ensures correct destination register addressing
4. **Data Forwarding**: Provides results to forwarding network for hazard resolution
5. **Write Completion**: Completes register file update transaction

## Data Source Multiplexing

The write-back stage selects the final result from multiple sources:

- **ALU Result**: Arithmetic and logical operation results from execution stage
- **Memory Data**: Load operation data retrieved from memory access stage  
- **PC+4 Value**: Return address storage for jump and link operations (JAL, JALR)
- **Upper Immediate**: Immediate values for LUI and AUIPC instructions
- **Zero Value**: Special case handling for non-register-writing instructions

## Register Write Control

Write-back control logic manages:

- **Write Enable Generation**: Control signal (WE_WB) determining register file update
- **Destination Address**: Register address (RD_WB) for write-back operation
- **Data Validation**: Ensures write data integrity and proper formatting
- **Zero Register Protection**: Prevents writes to hardwired zero register (x0)

## Data Forwarding Integration

The write-back stage supports data forwarding mechanisms:

- **Forward to Execute**: Provides results for execution stage operand forwarding
- **Forward to Decode**: Supplies data for decode stage dependency resolution
- **Hazard Resolution**: Enables single-cycle resolution of read-after-write hazards
- **Pipeline Efficiency**: Maintains maximum pipeline throughput

## Instruction Type Support

The write-back stage handles all instruction categories:

- **Arithmetic Instructions**: Register write-back of computation results
- **Logic Instructions**: Bitwise operation result storage
- **Load Instructions**: Memory data write-back to destination registers
- **Jump Instructions**: Return address storage for link operations
- **Branch Instructions**: No register write-back required
- **Store Instructions**: No register write-back required
