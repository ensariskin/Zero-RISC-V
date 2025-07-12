# Top-Level Processor Integration

This directory contains the top-level integration module for the complete RISC-V RV32I pipelined processor implementation. This module serves as the primary interface and coordination point for all processor components.

## Module Components

### TOP_Pipelined_design.v

Complete processor integration module providing:
- Full 5-stage pipeline instantiation and interconnection
- Pipeline register integration and signal routing
- Hazard detection and data forwarding coordination
- Memory interface management and control
- Clock and reset distribution throughout processor
- External interface definition and signal management

## Processor Architecture Integration

The top-level module integrates the complete processor architecture:

### Pipeline Stage Integration
- **Instruction Fetch Stage**: Program counter management and instruction retrieval
- **Instruction Decode Stage**: Instruction decoding and register file access
- **Execute Stage**: Arithmetic, logical, and branch operation execution
- **Memory Access Stage**: Data memory interface and load/store operations
- **Write-Back Stage**: Result selection and register file update

### Pipeline Register Management
- **IF_ID Register**: Instruction and control signal storage between fetch and decode
- **ID_EX Register**: Operand and control signal storage between decode and execute
- **EX_MEM Register**: Result and control signal storage between execute and memory
- **MEM_WB Register**: Final result storage between memory access and write-back

### Hazard Resolution Integration
- **Data Forwarding Unit**: Hardware-based data dependency resolution
- **Hazard Detection Unit**: Pipeline stall control and bubble insertion
- **Branch Prediction Interface**: Control hazard minimization support

## External Interface Specification

### Clock and Reset Interface
- **clk**: Primary system clock input for synchronized operation
- **reset**: Asynchronous reset signal for processor initialization

### Instruction Memory Interface
- **instruction_i**: 32-bit instruction word input from instruction memory
- **ins_address**: 32-bit instruction address output to instruction memory

### Data Memory Interface
- **MEM_result_i**: 32-bit data input from data memory for load operations
- **RAM_DATA_o**: 32-bit data output to data memory for store operations
- **RAM_Addr_o**: 32-bit address output to data memory
- **RAM_DATA_control**: Memory access type control (byte, halfword, word)
- **RAM_rw**: Read/write control signal for memory operations

## Signal Flow Management

The top-level module coordinates:

- **Instruction Pipeline Flow**: Sequential instruction progression through pipeline stages
- **Data Path Management**: Operand and result routing between processor components
- **Control Signal Distribution**: Control information propagation across pipeline stages
- **Hazard Signal Coordination**: Stall and forwarding signal management
- **Memory Access Coordination**: Instruction and data memory interface timing
