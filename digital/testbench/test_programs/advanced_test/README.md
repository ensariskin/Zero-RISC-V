# Advanced Test Program - Test 2

This is a comprehensive test program designed to stress-test different aspects of your RV32I processor that weren't covered in the first complex test.

## New Test Features

### 1. **Sorting Algorithm (Bubble Sort)**
- **Many conditional branches**: Each comparison creates a branch
- **Data movement patterns**: Frequent swaps test load/store units
- **Nested loops**: Tests branch prediction in different contexts

### 2. **Binary Search Pattern**
- **Different branch behavior**: Logarithmic search pattern
- **Division operations**: Tests divide unit
- **Variable loop bounds**: Dynamic termination conditions

### 3. **Table Lookup Operations**
- **Memory access patterns**: Array indexing with computed indices
- **Data dependencies**: Results depend on previous lookups
- **Cache-like behavior**: Repeated access to lookup table

### 4. **Data Dependency Chains**
- **Read-after-write hazards**: Intentional data dependencies
- **Pipeline stress**: Forces forwarding mechanisms
- **Complex addressing**: Multi-dimensional array access

### 5. **Prime Number Sieve**
- **Branch-heavy algorithm**: Many conditional operations
- **Nested elimination**: Complex control flow
- **Mathematical operations**: Modulo and multiplication

### 6. **Pattern Matching**
- **String-like operations**: Sequential data comparison
- **Early termination**: Break conditions in loops
- **Partial matches**: Complex scoring logic

### 7. **Modified Fibonacci**
- **Recursive patterns**: Data dependencies across iterations
- **Conditional computation**: Different formulas based on index
- **Overflow handling**: Modulo operations

### 8. **Multi-array Processing**
- **Cross-array dependencies**: Data from multiple arrays
- **Complex expressions**: Multiple arithmetic operations
- **Chain dependencies**: Results feed into next computation

## Expected Behavior

This test should:
- **Execute more instructions** than the first test (~1000-1500 instructions)
- **Take longer**: Expect 20,000-30,000 cycles without branch prediction
- **Stress different units**: More memory operations, more divisions
- **Test different patterns**: Different branch behaviors

## Performance Expectations

| Metric | Expected Range |
|--------|----------------|
| **Instructions** | 1000-1500 |
| **Cycles (no branch pred)** | 20,000-30,000 |
| **CPI** | 15-25 |
| **Final result** | Deterministic value |

## What This Tests Differently

### Compared to complex_test.c:
1. **More memory-intensive**: More array operations
2. **Different algorithms**: Sorting, searching, sieving
3. **More data dependencies**: Chains of dependent operations
4. **Different branch patterns**: Binary search vs nested conditions
5. **More arithmetic variety**: Division, modulo, multiplication chains

## Building and Running

```bash
cd d:\Ensar\Tez\RV32I\digital\testbench\test_programs\advanced_test
make build
```

This will generate `advanced_test.hex` for your processor simulation.

## Verification Points

The program stores results in multiple locations:
- `data_array[0]` = final result
- `processed_data[0]` = accumulator value  
- `lookup_table[0]` = final_value

You can monitor these in your simulation to verify correct execution.

## Success Criteria

✅ **Processor completes execution**  
✅ **Deterministic results** (same values each run)  
✅ **Reasonable cycle count** (15,000-35,000 cycles)  
✅ **No infinite loops** or hangs  
✅ **Memory operations work** correctly  

This test will give you confidence that your processor can handle a wide variety of real-world computation patterns! 🚀
