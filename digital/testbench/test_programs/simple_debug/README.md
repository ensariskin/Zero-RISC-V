# Simple Debug Test Programs

This directory contains minimal C test programs designed for systematic debugging and validation of the RISC-V RV32I processor implementation. These programs provide incremental complexity for step-by-step verification.

## Test Program Hierarchy

### 1. ultra_simple.c
Initial verification program featuring:
- Single variable initialization (int x = 42)
- Basic arithmetic operation (int y = x + 1)
- Array element assignment (arr[0] = y)
- Minimal instruction set utilization
- Straightforward execution path for initial processor validation

### 2. simple_debug.c  
Extended verification program including:
- Multiple variable declarations and assignments
- Fundamental arithmetic operations (addition, subtraction)
- Array initialization and access operations
- Basic conditional execution (if statements)
- Simple loop structures (for loops)
- Sequential instruction execution patterns

## Build Configuration

### Standard Build Process
```bash
# Default build using Makefile
make build

# Manual compilation for ultra_simple.c
riscv32-unknown-elf-gcc ultra_simple.c ../crt0.s -march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -o ultra_simple.elf
riscv32-unknown-elf-objcopy -O binary -j .init -j .text -j .rodata ultra_simple.elf ultra_simple.bin
../rom_generator ultra_simple.bin

# Generate disassembly for analysis
make disasm
```

## Verification Methodology

### Phase 1: Initial Validation (ultra_simple.c)
1. Load generated hex file into processor testbench
2. Execute simulation and monitor program counter progression
3. Verify processor reaches expected execution milestones
4. Analyze instruction fetch and execution sequence

### Phase 2: Assembly Analysis
```bash
riscv32-unknown-elf-objdump -d ultra_simple.elf > ultra_simple.s
```
Examine for:
- Main function entry point address
- Store instruction memory locations
- Expected program counter sequence progression

### Phase 3: Extended Testing (simple_debug.c)
- Compile and execute extended test program
- Compare execution patterns with initial validation
- Verify consistent processor behavior

### Phase 4: Issue Identification
Enhanced testbench provides:
- Program counter transition logging
- Processor state monitoring
- Execution termination detection
- Instruction execution count tracking

## Expected Execution Sequence

### ultra_simple.c Execution Pattern
1. Program counter initialization at 0x00000000 (startup code)
2. Main function entry (approximately 0x00000044)
3. Variable assignment instruction execution
4. Array store operation completion
5. Main function return sequence
6. Program termination

## Diagnostic Capabilities

### Processor State Analysis
1. **Startup Issues**: Reset logic, clock generation, instruction fetch verification
2. **Main Function Execution**: Instruction decode, execution unit operation
3. **Memory Operations**: Store instruction execution, memory interface validation
4. **Control Flow**: Branch prediction, hazard detection verification

### Testbench Monitoring Features
- **Program Counter Tracking**: Complete instruction execution sequence
- **Execution Termination Detection**: Identification of processor halt conditions
- **Instruction Count Limiting**: Controlled execution for debugging analysis
- **State Information Logging**: Processor internal state during execution

This systematic approach enables precise identification of processor implementation issues and facilitates efficient debugging processes.
