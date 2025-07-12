# Advanced Test Program - Test 2

This directory contains a comprehensive test program designed to evaluate advanced processor functionality and stress-test specific aspects of the RV32I processor implementation not covered in basic validation tests.

## Advanced Test Components

### 1. Sorting Algorithm Implementation (Bubble Sort)
- **Conditional Branch Testing**: Multiple comparison operations generating frequent branch instructions
- **Data Movement Validation**: Extensive swap operations testing load/store unit functionality
- **Nested Loop Execution**: Multi-level loop structures testing branch prediction accuracy
- **Memory Access Patterns**: Sequential and random access pattern validation

### 2. Binary Search Algorithm
- **Logarithmic Search Pattern**: Non-linear branch behavior testing
- **Division Operation Testing**: Arithmetic unit division functionality validation
- **Dynamic Loop Bounds**: Variable termination condition handling
- **Address Calculation**: Complex index computation testing

### 3. Table Lookup Operations
- **Computed Index Access**: Array indexing with calculated offsets
- **Data Dependency Chains**: Sequential lookup operations with result dependencies
- **Memory Access Optimization**: Repeated access pattern efficiency testing
- **Address Translation**: Multi-dimensional array access validation

### 4. Data Dependency Chain Testing
- **Read-After-Write Hazards**: Intentional pipeline hazard generation for forwarding validation
- **Pipeline Stress Testing**: Maximum utilization of data forwarding mechanisms
- **Complex Address Modes**: Multi-dimensional array access with computed indices
- **Dependency Resolution**: Hardware hazard detection and resolution verification

### 5. Prime Number Sieve Algorithm
- **Branch-Intensive Computation**: High conditional operation density
- **Nested Elimination Loops**: Complex control flow pattern testing
- **Mathematical Operation Validation**: Modulo and multiplication instruction testing
- **Algorithm Complexity**: Computational intensity evaluation

### 6. Pattern Matching Implementation
- **Sequential Data Comparison**: String-like operation emulation
- **Early Loop Termination**: Break condition handling in iterative structures
- **Partial Match Scoring**: Complex conditional logic evaluation
- **Character Processing**: Byte-level data manipulation testing

### 7. Modified Fibonacci Sequence
- **Recursive Pattern Implementation**: Inter-iteration data dependency testing
- **Conditional Computation**: Variable formula application based on index values
- **Overflow Management**: Modulo operation handling for large number computation
- **Sequence Generation**: Iterative algorithm implementation validation

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
cd digital\testbench\test_programs\advanced_test
make build
```

This will generate `advanced_test.hex` for processor simulation.

## Verification Points

The program stores results in multiple locations:
- `data_array[0]` = final result
- `processed_data[0]` = accumulator value
- `lookup_table[0]` = final_value

These values can be monitored in simulation to verify correct execution.

## Success Criteria

✅ **Processor completes execution**
✅ **Deterministic results** (same values each run)
✅ **Reasonable cycle count** (15,000-35,000 cycles)
✅ **No infinite loops** or hangs
✅ **Memory operations work** correctly

This test validates that the processor can handle a wide variety of real-world computation patterns.
