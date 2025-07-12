# Instruction Decode Stage

The Instruction Decode stage implements the second pipeline stage, responsible for instruction interpretation, register file access, and control signal generation. This stage forms the critical control path for the RISC-V processor pipeline.

## Module Components

### decode_stage.sv

Top-level decode stage integration module providing:
- Instruction processing from IF/ID pipeline register
- Register file interface management
- Control signal aggregation and distribution
- Data forwarding control logic
- Pipeline bubble insertion for hazard management
- Operand preparation for execution stage

### rv32i_decoder.sv

Complete RISC-V RV32I instruction decoder featuring:
- Full instruction format parsing (R, I, S, B, U, J-type)
- Instruction type identification and classification
- Register address field extraction (rd, rs1, rs2)
- Immediate value extraction and sign extension
- Control signal generation for all pipeline stages
- ALU operation code determination
- Memory operation type specification
- Branch and jump instruction handling

### RegisterFile.sv

32-entry register file implementation providing:
- 32 general-purpose registers (x0 through x31)
- Dual-port read capability for simultaneous operand access
- Single-port write interface with write-back stage
- Hardwired zero register (x0) implementation
- Concurrent read/write operation support
- Register forwarding logic integration

## Stage Operation

The decode stage performs the following operations each clock cycle:

1. **Instruction Reception**: Accepts instruction word from IF/ID pipeline register
2. **Instruction Decoding**: Parses instruction fields and determines operation type
3. **Register Address Extraction**: Identifies source and destination register addresses
4. **Register File Access**: Reads operand values from specified source registers
5. **Immediate Processing**: Extracts and sign-extends immediate values as required
6. **Control Signal Generation**: Creates control word for pipeline stage coordination
7. **Pipeline Handoff**: Transfers operands and control signals to ID/EX pipeline register

## Control Signal Architecture

### Primary Control Word (26-bit)
The decode stage generates a comprehensive control signal containing:

- **Register Addresses**: Destination (rd), source registers (rs1, rs2)
- **ALU Function Select**: 4-bit operation code for arithmetic/logic unit
- **Memory Control**: Read/write enables and operation type specification
- **Register Write Enable**: Write-back stage register file control
- **Operand Selection**: Multiplexer control for operand routing
- **Branch Control**: Branch condition and target address selection

### Branch Selection Signal
- **Branch_sel**: Branch type identification for execution stage processing

## Instruction Support

The decode stage provides complete support for:

- **R-type Instructions**: Register-register arithmetic and logical operations
- **I-type Instructions**: Immediate arithmetic, loads, and JALR
- **S-type Instructions**: Store operations with immediate addressing
- **B-type Instructions**: Conditional branch operations
- **U-type Instructions**: Upper immediate operations (LUI, AUIPC)
- **J-type Instructions**: Unconditional jump operations (JAL)

## Hazard Management

The decode stage incorporates hazard detection mechanisms:

- **Pipeline Bubble Insertion**: Stall signal generation for load-use hazards
- **Data Dependency Detection**: Identification of register dependencies
- **Control Hazard Handling**: Support for branch prediction resolution
- **Forwarding Path Control**: Configuration of data forwarding multiplexers
