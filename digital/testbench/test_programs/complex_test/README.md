# Complex Test Program

This directory contains a comprehensive test program designed to thoroughly exercise the RISC-V RV32I processor implementation through challenging computational scenarios and complex control flow patterns.

## Test Program Features

The complex_test.c program implements the following verification components:

### 1. Nested Loop Structure Testing (3-level depth)
- Triple-nested loop iterations with variable bounds
- Complex conditional logic within nested loop structures
- Branch prediction mechanism validation across multiple nesting levels
- Loop counter management and termination condition testing

### 2. Multi-Level Conditional Processing
- Deep conditional nesting structures (up to 4 levels)
- Complex boolean expression evaluation
- Mixed arithmetic and logical operation conditions
- Conditional branch instruction coverage testing

### 3. Array and Matrix Operation Implementation
- Single-dimensional array initialization and processing algorithms
- 3x3 matrix mathematical operations
- Memory access pattern validation and optimization testing
- Sequential and random memory access pattern evaluation

### 4. Comprehensive Arithmetic Testing
- Addition, subtraction, multiplication, and division operations
- Modulo operation implementation and validation
- Mixed arithmetic expression evaluation
- Integer overflow and underflow condition handling

### 5. Advanced Control Flow Validation
- Break and continue statement implementation
- Early loop termination condition handling
- Control transfer instruction testing
- Exception and edge case processing
- Complex branching scenarios
- Loop exit conditions

### 6. Algorithm Implementation
- Fibonacci-like sequence generation
- Collatz conjecture simulation
- Matrix diagonal and triangle processing

## Building

```bash
make build
```

This will:
1. Compile the C code with RISC-V GCC
2. Generate the binary file
3. Create the hex file for processor simulation

## Usage

The generated `complex_test.hex` file can be loaded into processor simulation:

```bash
# Using simulator
<simulator> +load_hex +hex_file=complex_test.hex
```

## Expected Behavior

The program performs extensive computations without any output functions (no printf). 
The final result is stored in `array[0]` which can be monitored in simulation for verification.

## Test Coverage

This test exercises:
- ✅ Arithmetic instructions (ADD, SUB, MUL, DIV)
- ✅ Logical instructions (AND, OR, XOR)
- ✅ Comparison instructions (SLT, SLTU)
- ✅ Branch instructions (BEQ, BNE, BLT, BGE, BLTU, BGEU)
- ✅ Jump instructions (JAL, JALR)
- ✅ Load/Store instructions (LW, SW, LH, SH, LB, SB)
- ✅ Immediate instructions (ADDI, SLTI, ANDI, ORI, XORI)
- ✅ Shift instructions (SLL, SRL, SRA)
- ✅ Memory access patterns
- ✅ Pipeline hazards
- ✅ Complex control flow

## Debugging

If the processor fails during execution, check:
1. Branch prediction logic
2. Hazard detection and forwarding
3. Memory interface timing
4. Arithmetic unit functionality
5. Register file read/write operations
