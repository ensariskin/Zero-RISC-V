# Complex Test Program

This directory contains a comprehensive test program designed to thoroughly exercise the RV32I processor with various challenging scenarios.

## Test Features

The `complex_test.c` program includes:

### 1. Nested Loop Testing (3 levels deep)
- Triple nested loops with varying iteration counts
- Complex conditional logic within nested structures
- Tests branch prediction and loop handling

### 2. Multiple If-Else Blocks
- Deep conditional nesting (up to 4 levels)
- Complex boolean conditions
- Mixed arithmetic and logical operations in conditions

### 3. Array and Matrix Operations
- 1D array initialization and processing
- 3x3 matrix operations
- Memory access patterns testing

### 4. Arithmetic Operations
- Addition, subtraction, multiplication, division
- Modulo operations
- Mixed arithmetic expressions

### 5. Control Flow Testing
- Break and continue statements
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

The generated `complex_test.hex` file can be loaded into your processor simulation:

```bash
# Using your simulator
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
