# Simple Debug Programs

This directory contains minimal test programs to debug RV32I processor issues step by step.

## Programs

### 1. `ultra_simple.c` 
**Use this first!** Minimal operations:
- One variable assignment: `int x = 42`
- One arithmetic operation: `int y = x + 1`  
- One array store: `arr[0] = y`

### 2. `simple_debug.c`
Slightly more complex but still minimal:
- Multiple variables
- Basic arithmetic
- Array operations
- Simple conditional
- Simple loop

## Building

```bash
# Build ultra simple first
make build

# Or build specific version
riscv32-unknown-elf-gcc ultra_simple.c ../crt0.s -march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -o ultra_simple.elf
riscv32-unknown-elf-objcopy -O binary -j .init -j .text -j .rodata ultra_simple.elf ultra_simple.bin
../rom_generator ultra_simple.bin

# Generate assembly for analysis
make disasm
```

## Debugging Strategy

### Step 1: Start with ultra_simple.c
1. Load `ultra_simple.hex` into your testbench
2. Run simulation and check if processor reaches expected PCs
3. Monitor the execution flow with the enhanced testbench logging

### Step 2: Check Assembly
```bash
riscv32-unknown-elf-objdump -d ultra_simple.elf > ultra_simple.s
```
Look for:
- Where the main function starts
- The store instruction addresses  
- Expected PC progression

### Step 3: If ultra_simple works, try simple_debug.c
- Build and test `simple_debug.c`
- Compare execution patterns

### Step 4: Identify the Issue
The enhanced testbench will show:
- Every PC change: `[1] PC: 0x00000000 -> 0x00000044, Instr: 0x12345678`
- Where processor gets stuck: `*** PROCESSOR APPEARS STUCK at PC=0x00000080 ***`
- Instruction count: Stops after 100 instructions for analysis

## Expected Behavior

For `ultra_simple.c`, you should see:
1. PC starting at 0x00000000 (startup code)
2. Jump to main function (around 0x00000044)
3. A few instructions for variable assignments
4. Store instruction for `arr[0] = y`
5. Return from main
6. End execution

## Common Issues to Check

1. **Processor stuck at startup**: Check reset logic, clock, instruction fetch
2. **Processor stuck in main**: Check instruction decode, execution units
3. **Store instruction not executing**: Check memory interface, data path
4. **Infinite loop**: Check branch prediction, hazard detection

## Testbench Enhancements

The updated testbench now provides:
- **PC tracking**: Every instruction execution
- **Stuck detection**: Identifies if processor stops advancing
- **Instruction counting**: Limits execution for debugging
- **State monitoring**: Shows processor internal state when stuck

This makes it much easier to identify exactly where the issue occurs!
