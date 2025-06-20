# Execute (EX) Stage

The Execute (EX) stage is the computational core of the processor where arithmetic, logical, and control operations are performed. All components in this stage use a consistent timescale of `100 ps / 1 ps` for accurate simulation.

## Components

### EX.v

Top-level module for the Execute stage that integrates all EX components and handles data forwarding inputs.

### FU.v (Functional Unit)

The main ALU module that:
- Performs arithmetic operations
- Executes logical operations
- Handles shift operations
- Sets condition flags (Z, N, etc.)

### arithmetic_unit.v

Implements:
- Addition and subtraction
- Comparison operations (SLT, SLTU)
- Arithmetic calculations for the RV32I ISA

### logical_unit.v

Performs bitwise logical operations:
- AND
- OR
- XOR

### shifter.v

Implements shift operations:
- Logical left shift (SLL)
- Logical right shift (SRL)
- Arithmetic right shift (SRA)

### Branch_Controller.v

Makes branch decisions based on:
- Branch type (BEQ, BNE, BLT, BGE, BLTU, BGEU)
- ALU flags (zero, negative)
- Verifies branch prediction from the IF stage

### Zero_comparator.v

Efficiently detects when a value equals zero for branch condition evaluation.

## Operation

1. The EX stage receives operands from ID stage or via forwarding paths
2. The FU performs the operation specified by the control signals
3. Branch conditions are evaluated by the Branch_Controller
4. Branch prediction is verified, and correction signals generated if needed
5. Results and control signals are passed to the EX/MEM pipeline register

## Key Features

- Operand forwarding from MEM and WB stages
- Branch target calculation
- Branch prediction validation
- JALR calculation
- ALU operation for all RV32I instructions
- Modular design with specialized functional units
- Single-cycle execution for most operations
- Consistent timing using `100 ps / 1 ps` timescale
