# Matrix Multiplication Test

## Description
This test performs 50x50 matrix multiplication to stress test the superscalar RISC-V processor.

## Test Details
- **Matrix A**: Initialized with row index pattern (A[i][j] = i + 1)
- **Matrix B**: Initialized with column index pattern (B[i][j] = j + 1)
- **Result C**: C = A × B

## Expected Result
C[i][j] = (i+1) × 1275 × (j+1)
where 1275 = sum(1 to 50) = 50×51/2

## Performance Metrics
- **Total Operations**: 50³ = 125,000 multiply-accumulate operations
- **Memory Accesses**: ~375,000 reads + 2,500 writes
- **Tests**: 
  - Loop unrolling optimization
  - Data cache performance
  - Branch prediction
  - Pipeline efficiency

## Build Instructions
```bash
make        # Generate hex file
make dis    # Generate hex and disassembly
make clean  # Clean build files
```

## Return Value
- **0**: All matrix elements computed correctly
- **>0**: Number of incorrect elements (indicates failure)

## Usage with Simulator
```bash
# Compile
make

# Run with RTL simulator
# Point hex_file to matrix_multiply.hex

# Expected output
# Return code: 0 (success)
```

## Performance Expectations
With a 3-way superscalar processor:
- Ideal IPC: ~2.5-2.8 instructions/cycle
- Expected cycles: ~50,000-80,000 cycles
- Branch mispredictions: Low (simple loop structure)
- Memory bottleneck: Possible with 50x50 matrices (10KB data)
