# Execute Stage

This module implements the execute stage for the 3-way superscalar RISC-V processor using the Tomasulo algorithm.

## Overview

The execute stage contains 3 parallel functional units that:
- Receive instructions from reservation stations via `rs_to_exec_if` interfaces
- Execute arithmetic, logic, shift, and branch operations 
- Handle branch prediction and JALR operations
- Return results back to reservation stations for CDB broadcast

## Architecture

### Functional Units
- **FU0**: ALU/Shifter + Branch Controller for integer and branch operations
- **FU1**: ALU/Shifter + Branch Controller for integer and branch operations  
- **FU2**: ALU/Shifter + Branch Controller for integer and branch operations

### Branch Processing
Each functional unit includes:
- **Branch Controller**: Evaluates branch conditions (BEQ, BNE, BLT, BGE, BLTU, BGEU)
- **JALR Detection**: Identifies JALR instructions for PC correction
- **Misprediction Detection**: Compares actual branch outcome with prediction
- **PC Handling**: Saves PC+4 for JAL/JALR instructions

### Operation
1. **Instruction Acceptance**: FUs signal readiness via `issue_ready`
2. **Execution**: Single-cycle combinational execution using legacy ALU/shifter
3. **Branch Evaluation**: Branch controllers evaluate conditions using Z/N flags
4. **Result Selection**: Choose between ALU result or PC+4 based on instruction type
5. **Result Return**: Computed results returned via `data_result` signal

### Interface Protocol
- **Ready/Valid Handshaking**: Standard interface for instruction flow control
- **Control Signals**: Function select extracted from bits [10:7], PC save from bit [5]
- **Branch Information**: Branch type from `branch_sel`, prediction from `branch_prediction`
- **Operand Data**: Pre-resolved operands from reservation stations

## Files

- `execute_stage.sv` - Main execute stage module
- `execute_stage.f` - File list including dependencies
- Dependencies:
  - `function_unit_alu_shifter.sv` - Legacy ALU/shifter functional unit
  - `alu.sv` - Arithmetic Logic Unit
  - `shifter.sv` - Barrel shifter
  - `Branch_Controller.sv` - Branch condition evaluation
  - `parametric_mux.sv` - Multiplexer for output selection

## Integration

This module connects between:
- **Input**: 3 reservation stations via `rs_to_exec_if` interfaces
- **Output**: Results returned to reservation stations for CDB broadcast

The reservation stations handle all CDB communication, making the execute stage purely computational.

## Supported Operations

### Arithmetic & Logic Operations
All RV32I arithmetic and logic operations:
- **Arithmetic**: ADD, SUB, SLT, SLTU
- **Logic**: AND, OR, XOR
- **Shift**: SLL, SRL, SRA

### Branch Operations
All RV32I branch instructions:
- **Conditional Branches**: BEQ, BNE, BLT, BGE, BLTU, BGEU
- **Unconditional Jumps**: JAL, JALR

### Special Features
- **JALR Handling**: PC correction to align target address
- **PC Saving**: Automatic PC+4 saving for JAL/JALR instructions
- **Branch Prediction**: Misprediction detection for prediction updates

## Branch Controller Encoding

Branch select encoding (from `branch_sel[2:0]`):
- `3'b000`: No branch
- `3'b001`: No branch  
- `3'b010`: BEQ (branch if zero)
- `3'b011`: BNE (branch if not zero)
- `3'b100`: BLT (branch if negative)
- `3'b101`: BGE (branch if not negative)
- `3'b110`: BLTU/BGEU (unsigned comparisons)
- `3'b111`: JALR (jump and link register)

Function select encoding matches the legacy decoder:
- Bits [10:7] of control_signals contain the 4-bit function select
- Bit [5] controls PC saving (1 = save PC+4, 0 = use ALU result)