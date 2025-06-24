# Execute (EX) Stage

The Execute (EX) stage is the computational core of the processor where arithmetic, logical, and control operations are performed. All components in this stage have been modernized with SystemVerilog and follow consistent interface conventions.

## Components

### execute_stage.sv

Top-level module for the Execute stage that integrates all EX components and handles data forwarding inputs with standardized signal naming and parameterization.

### function_unit_alu_shifter.sv

Unified functional unit that:
- Consolidates ALU and shifter operations into a single module
- Provides cleaner interfaces and signal flow
- Improves parameter handling for better modularity
- Enhances flag generation and propagation

### alu.sv

Modern ALU implementation that:
- Performs arithmetic operations
- Executes logical operations
- Sets condition flags
- Uses standardized interfaces with consistent naming

### arithmetic_unit.sv

Implements:
- Addition and subtraction
- Comparison operations (SLT, SLTU) with improved signed/unsigned handling
- Optimized zero detection logic
- Comprehensive operation documentation

### logical_unit.sv

Performs bitwise logical operations:
- AND
- OR
- XOR
- Enhanced operation selection clarity

### shifter.sv

Implements shift operations:
- Logical left shift (SLL)
- Logical right shift (SRL)
- Arithmetic right shift (SRA)

### Branch_Controller.sv

Makes branch decisions based on:
- Branch type (BEQ, BNE, BLT, BGE, BLTU, BGEU)
- ALU flags (zero, negative)
- Verifies branch prediction from the IF stage

## Operation

1. The execute stage receives operands from ID stage or via forwarding paths
2. The function_unit_alu_shifter performs the operation specified by the control signals
3. Branch conditions are evaluated by the Branch_Controller
4. Branch prediction is verified, and correction signals generated if needed
5. Results and control signals are passed to the ex_to_mem pipeline register

## Key Features

- Consolidated arithmetic, logical, and shift operations in cleaner hierarchy
- Enhanced flag generation and propagation
- Standardized interfaces with consistent signal naming:
  - `data_a`/`data_b` instead of `A`/`B`
  - `data_result` instead of `S`
  - `func_sel` instead of `Sel`
- Improved parameter handling for better modularity
- Optimized zero detection mechanism
- Branch target calculation with improved accuracy
- Branch prediction validation
- JALR calculation with enhanced handling
- Single-cycle execution for all operations
- Comprehensive signal documentation
