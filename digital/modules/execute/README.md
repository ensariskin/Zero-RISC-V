# Execution Stage

The Execution stage serves as the computational core of the RISC-V processor, performing arithmetic, logical, shift, and branch operations. This stage implements the third pipeline stage where instruction execution occurs.

## Module Components

### execute_stage.sv

Top-level execution stage integration module featuring:
- Component instantiation and interconnection
- Data forwarding path integration
- Operand multiplexing and selection
- Result and control signal routing to pipeline registers
- Branch target address calculation
- Jump and Link Register (JALR) address computation

### function_unit_alu_shifter.sv

Unified arithmetic and shift functional unit providing:
- Integrated ALU and shifter operation execution
- Operation selection based on instruction encoding
- Standardized SystemVerilog interface design
- Optimized critical path timing
- Comprehensive flag generation and status indication

### alu.sv

Arithmetic Logic Unit implementation featuring:
- Complete arithmetic operation support
- Full logical operation implementation
- Condition flag generation (zero, negative, overflow)
- Signed and unsigned operation handling
- Optimized combinational logic design

### arithmetic_unit.sv

Dedicated arithmetic processing unit implementing:
- Addition and subtraction operations
- Set-less-than comparison (SLT, SLTU)
- Signed and unsigned comparison logic
- Zero detection and flag generation
- Overflow detection for arithmetic operations

### logical_unit.sv

Bitwise logical operation unit providing:
- AND, OR, XOR logical operations
- Bit manipulation functionality
- Fast combinational logic implementation
- Operation selection and control interface

### shifter.sv

Shift operation unit implementing:
- Logical left shift (SLL) operations
- Logical right shift (SRL) operations  
- Arithmetic right shift (SRA) operations
- Shift amount processing and validation
- Optimized barrel shifter design

### Branch_Controller.sv

Branch condition evaluation unit featuring:
- Branch instruction type detection (BEQ, BNE, BLT, BGE, BLTU, BGEU)
- Condition evaluation based on ALU flags
- Branch prediction verification
- Branch target address validation
- Misprediction detection and correction signal generation

## Stage Operation

The execution stage performs the following sequence each clock cycle:

1. **Operand Reception**: Receives operands from decode stage or forwarding paths
2. **Operation Selection**: Determines operation type based on control signals
3. **Functional Unit Execution**: Performs arithmetic, logical, or shift operations
4. **Flag Generation**: Computes condition flags for branch evaluation
5. **Branch Evaluation**: Determines branch outcomes and target addresses
6. **Prediction Verification**: Validates branch predictions from fetch stage
7. **Result Forwarding**: Provides results to forwarding network and memory stage

## Data Forwarding Integration

The execution stage incorporates comprehensive data forwarding mechanisms:

- **Operand Multiplexing**: Selection between register file and forwarded data
- **Forward Path A**: Forwarding for first source operand (rs1)
- **Forward Path B**: Forwarding for second source operand (rs2)
- **Dependency Resolution**: Automatic handling of data dependencies
- **Hazard Mitigation**: Reduction of pipeline stall requirements

## Operation Support

The execution stage supports all RV32I operations:

- **Arithmetic Operations**: ADD, SUB, ADDI with overflow handling
- **Logical Operations**: AND, OR, XOR, ANDI, ORI, XORI  
- **Shift Operations**: SLL, SRL, SRA, SLLI, SRLI, SRAI
- **Comparison Operations**: SLT, SLTU, SLTI, SLTIU
- **Branch Operations**: BEQ, BNE, BLT, BGE, BLTU, BGEU
- **Jump Operations**: JAL, JALR address calculation
- **Upper Immediate**: LUI, AUIPC computation

## Performance Characteristics

The execution stage is optimized for:

- **Single-Cycle Execution**: All operations complete in one clock cycle
- **Critical Path Optimization**: Minimized delay through functional units
- **Resource Sharing**: Efficient utilization of arithmetic and logic resources
- **Pipeline Efficiency**: Maintains maximum throughput under normal operation
- **Branch Penalty Reduction**: Fast branch resolution and prediction verification
