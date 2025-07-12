/*
 * Advanced Test Program for RV32I Processor - Test 2
 * 
 * This program focuses on different aspects than the first complex test:
 * - Different algorithm patterns
 * - More memory-intensive operations
 * - Different branching patterns
 * - Stress test for data hazards
 * - Various arithmetic patterns
 */

int main() {
    // Test variables
    int result = 0;
    int accumulator = 1;
    int data_array[15];
    int lookup_table[8];
    int processed_data[10];
    int i, j, k;
    
    // Checkpoint arrays - completely separate from algorithm
    int checkpoint_markers[5];    // Store checkpoint markers (1111, 2222, etc.)
    int checkpoint_values[5];     // Store intermediate values for tracking
    int checkpoint_extra[5];      // Store additional debug info

    // Initialize lookup table with powers of 2
    lookup_table[0] = 1;
    for (i = 1; i < 8; i++) {
        lookup_table[i] = lookup_table[i-1] * 2;  // 1, 2, 4, 8, 16, 32, 64, 128
    }
    
    // Initialize data array with a pattern
    for (i = 0; i < 15; i++) {
        data_array[i] = (i * 7 + 3) % 23;  // Semi-random pattern
    }
    
    checkpoint_markers[0] = 1773;
    checkpoint_markers[1] = 1773;
    checkpoint_markers[2] = 1773;
    checkpoint_markers[3] = 1773;
    checkpoint_markers[4] = 1773;

    checkpoint_values[0] = 2017;
    checkpoint_values[1] = 2017;
    checkpoint_values[2] = 2017;
    checkpoint_values[3] = 2017;
    checkpoint_values[4] = 2017;

    checkpoint_extra[0] = 2022;
    checkpoint_extra[1] = 2022;
    checkpoint_extra[2] = 2022;
    checkpoint_extra[3] = 2022;
    checkpoint_extra[4] = 2022;

    // CHECKPOINT 1: Initial state
    checkpoint_markers[0] = 1111;
    checkpoint_values[0] = accumulator;  // Should be 1
    checkpoint_extra[0] = data_array[1]; // Second element before sort (should be 10)
    
    // Test 1: Bubble Sort Algorithm (tests many branches and swaps)
    for (i = 0; i < 14; i++) {
        for (j = 0; j < 14 - i; j++) {
            if (data_array[j] > data_array[j + 1]) {
                // Swap elements
                int temp = data_array[j];
                data_array[j] = data_array[j + 1];
                data_array[j + 1] = temp;
                accumulator++;
            }
        }
    }
    
    // CHECKPOINT 2: After bubble sort
    checkpoint_markers[1] = 2222;
    checkpoint_values[1] = accumulator;  // Number of swaps + 1
    checkpoint_extra[1] = data_array[1]; // Second element after sort (should be 2)
    
    // Test 2: Binary Search Pattern (different branch behavior)
    int target = 12;
    int left = 0, right = 14, found = -1;
    while (left <= right) {
        int mid = (left + right) / 2;
        if (data_array[mid] == target) {
            found = mid;
            break;
        } else if (data_array[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
        accumulator += mid;
    }
    
    // Test 3: Data Processing with Table Lookups
    for (i = 0; i < 10; i++) {
        int value = data_array[i] % 8;  // Use as index into lookup table
        processed_data[i] = data_array[i] * lookup_table[value];
        
        // Apply different transformations based on value
        if (processed_data[i] > 100) {
            processed_data[i] = processed_data[i] % 100 + lookup_table[2];
        } else if (processed_data[i] > 50) {
            processed_data[i] = processed_data[i] + lookup_table[1];
        } else {
            processed_data[i] = processed_data[i] * 2;
        }
        
        accumulator += processed_data[i];
    }
    
    // CHECKPOINT 3: After data processing
    checkpoint_markers[2] = 3333;
    checkpoint_values[2] = accumulator;
    checkpoint_extra[2] = found;  // Binary search result (-1 if not found)
    
    // Test 4: Nested Loop with Data Dependencies
    int sum_matrix[4][4];
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            sum_matrix[i][j] = 0;
            for (k = 0; k < 3; k++) {
                // Create data dependency chain
                int base_val = (i + j + k) % 15;
                sum_matrix[i][j] += data_array[base_val];
                
                // Conditional accumulation
                if (sum_matrix[i][j] % 3 == 0) {
                    sum_matrix[i][j] += lookup_table[k % 8];
                    accumulator += sum_matrix[i][j] / 4;
                } else if (sum_matrix[i][j] % 2 == 0) {
                    sum_matrix[i][j] -= lookup_table[(k+1) % 8];
                    accumulator -= sum_matrix[i][j] / 8;
                } else {
                    sum_matrix[i][j] = sum_matrix[i][j] * 3 / 2;
                    accumulator += sum_matrix[i][j] % 10;
                }
            }
            result += sum_matrix[i][j];
        }
    }
    
    // Test 5: Prime Number Sieve (branch-heavy algorithm)
    int is_prime[30];
    // Initialize all as potentially prime
    for (i = 2; i < 30; i++) {
        is_prime[i] = 1;
    }
    
    // Sieve algorithm
    for (i = 2; i * i < 30; i++) {
        if (is_prime[i]) {
            for (j = i * i; j < 30; j += i) {
                is_prime[j] = 0;
            }
        }
    }
    
    // Count and accumulate primes
    int prime_sum = 0;
    for (i = 2; i < 30; i++) {
        if (is_prime[i]) {
            prime_sum += i;
            accumulator += lookup_table[i % 8];
        }
    }
    
    // CHECKPOINT 4: After prime sieve
    checkpoint_markers[3] = 4444;
    checkpoint_values[3] = prime_sum;   // Should be 129
    checkpoint_extra[3] = accumulator;
    
    // Test 6: String-like Pattern Matching
    int pattern[5]; 
    pattern[0] = 3;
    pattern[1] = 7;
    pattern[2] = 2;
    pattern[3] = 9;
    pattern[4] = 1;
    
    int matches = 0;
    

    for (i = 0; i <= 10; i++) {  // Search in first 10 elements of data_array
        int match_count = 0;
        for (j = 0; j < 5 && (i + j) < 15; j++) {
            if (data_array[i + j] == pattern[j]) {
                match_count++;
            } else {
                break;  // Partial match only
            }
        }
        
        if (match_count == 5) {
            matches++;
            result += 100;
        } else if (match_count >= 3) {
            matches++;
            result += match_count * 10;
        } else if (match_count >= 1) {
            result += match_count;
        }
        
        accumulator += match_count * lookup_table[match_count % 8];
    }
    
    // Test 7: Complex Arithmetic Sequence
    int fib_like[12];
    fib_like[0] = 1;
    fib_like[1] = 2;
    
    for (i = 2; i < 12; i++) {
        // Modified Fibonacci with conditions
        if (i % 3 == 0) {
            fib_like[i] = fib_like[i-1] + fib_like[i-2] + i;
        } else if (i % 2 == 0) {
            fib_like[i] = fib_like[i-1] * 2 - fib_like[i-2];
        } else {
            fib_like[i] = (fib_like[i-1] + fib_like[i-2]) / 2 + 1;
        }
        
        // Prevent overflow and add to result
        fib_like[i] = fib_like[i] % 1000;
        result += fib_like[i];
        
        // Chain dependency
        accumulator = (accumulator + fib_like[i]) % 500;
    }
    
    // CHECKPOINT 5: After Fibonacci sequence
    checkpoint_markers[4] = 5555;
    checkpoint_values[4] = result;
    checkpoint_extra[4] = matches;
    
    // Test 8: Final Processing with Multiple Dependencies
    int final_value = 0;
    for (i = 0; i < 8; i++) {
        int temp1 = processed_data[i] + lookup_table[i];
        int temp2 = sum_matrix[i/2][i%2] + fib_like[i];
        int temp3 = (temp1 + temp2) % prime_sum;
        
        if (temp3 > accumulator) {
            final_value += temp3 - accumulator;
            if (final_value > 200) {
                final_value = final_value / 2 + matches;
            }
        } else {
            final_value += accumulator - temp3;
            if (final_value < 50) {
                final_value = final_value * 2 + (i + 1);
            }
        }
        
        // Update accumulator with dependency
        accumulator = (accumulator + final_value) % 300;
    }
    
    // Combine all results with complex expression
    result = (result + accumulator + final_value + prime_sum + matches) % 1000;
    
    // Final conditional processing
    if (result > 750) {
        result = result - 500 + lookup_table[7];
    } else if (result > 500) {
        result = result + 250 - lookup_table[6];
    } else if (result > 250) {
        result = result * 2 - lookup_table[5];
    } else {
        result = result + 100 + lookup_table[4];
    }
    
    // Ensure result is positive and store in array
    if (result < 0) {
        result = -result;
    }
    
    // Store final result in multiple locations for verification
    data_array[0] = result;
    processed_data[0] = accumulator;
    lookup_table[0] = final_value;
    
    return 0;
}
