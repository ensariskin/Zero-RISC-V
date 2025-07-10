/*
 * Complex Test Program for RV32I Processor
 * 
 * This program tests various processor features including:
 * - Nested loops (up to 3 levels deep)
 * - Multiple if-else conditions
 * - Array operations
 * - Arithmetic operations
 * - Logical operations
 * - Memory access patterns
 * - Branch prediction challenges
 */

int main() {
    // Test variables
    int sum = 0;
    int product = 1;
    int counter = 0;
    int result = 0;
    int temp = 0;
    int array[10];
    int matrix[3][3];
    int i, j, k;
    
    // Initialize array with some values
    for (i = 0; i < 10; i++) {
        array[i] = i * 2 + 1;  // Odd numbers: 1, 3, 5, 7, ...
    }
    
    // Initialize 3x3 matrix
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            matrix[i][j] = i * 3 + j + 1;  // Values 1-9
        }
    }
    
    // Test 1: Nested loops with multiple conditions
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 4; j++) {
            for (k = 0; k < 3; k++) {
                // Complex condition testing
                if (i > j) {
                    if (j > k) {
                        sum += i + j + k;
                    } else if (k == 2) {
                        sum += i * j;
                    } else {
                        sum -= k;
                    }
                } else if (i == j) {
                    if (k % 2 == 0) {
                        product *= (k + 1);
                    } else {
                        product += k;
                    }
                } else {
                    // i < j case
                    temp = i + j + k;
                    if (temp > 5) {
                        counter++;
                        if (counter % 3 == 0) {
                            result += temp * 2;
                        } else if (counter % 2 == 0) {
                            result += temp;
                        } else {
                            result -= temp / 2;
                        }
                    } else {
                        counter--;
                    }
                }
            }
        }
    }
    
    // Test 2: Array processing with conditions
    temp = 0;
    for (i = 0; i < 10; i++) {
        if (array[i] % 3 == 0) {
            // Divisible by 3
            temp += array[i] * 2;
            if (temp > 50) {
                temp /= 2;
                counter++;
            }
        } else if (array[i] % 5 == 0) {
            // Divisible by 5
            temp -= array[i];
            if (temp < 0) {
                temp = -temp;  // Absolute value
            }
        } else {
            // Not divisible by 3 or 5
            if (i % 2 == 0) {
                temp += array[i] / 2;
            } else {
                temp *= 2;
                if (temp > 100) {
                    temp = temp % 100;
                }
            }
        }
    }
    
    // Test 3: Matrix operations with nested conditions
    int matrix_sum = 0;
    int diagonal_sum = 0;
    
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            matrix_sum += matrix[i][j];
            
            // Diagonal elements
            if (i == j) {
                diagonal_sum += matrix[i][j];
                if (matrix[i][j] > 5) {
                    result += matrix[i][j] * 3;
                } else {
                    result += matrix[i][j];
                }
            }
            
            // Upper triangle
            if (i < j) {
                if (matrix[i][j] % 2 == 0) {
                    product += matrix[i][j];
                } else {
                    product -= matrix[i][j] / 2;
                }
            }
            
            // Lower triangle
            if (i > j) {
                temp = matrix[i][j];
                while (temp > 0) {
                    if (temp % 2 == 0) {
                        temp /= 2;
                        counter++;
                    } else {
                        temp = temp * 3 + 1;
                        if (temp > 20) {
                            temp -= 10;
                        }
                        temp--;
                    }
                }
            }
        }
    }
    
    // Test 4: Complex branching with multiple conditions
    int branch_test = 42;
    
    if (sum > 100) {
        if (product > 200) {
            if (counter > 50) {
                branch_test = sum + product + counter;
            } else if (counter > 25) {
                branch_test = sum * 2 + product;
            } else {
                branch_test = sum + product * 2;
            }
        } else if (product > 100) {
            branch_test = sum - product + counter * 3;
        } else {
            branch_test = sum + product + counter;
        }
    } else if (sum > 50) {
        if (result > 75) {
            branch_test = result * 2 - sum;
        } else {
            branch_test = result + sum * 3;
        }
    } else {
        // sum <= 50
        if (temp > 30) {
            if (diagonal_sum > 15) {
                branch_test = temp + diagonal_sum + matrix_sum;
            } else {
                branch_test = temp * diagonal_sum;
            }
        } else {
            branch_test = temp + sum + product;
        }
    }
    
    // Test 5: Loop with break and continue conditions
    int loop_result = 0;
    for (i = 0; i < 20; i++) {
        if (i % 7 == 0 && i != 0) {
            break;  // Exit loop
        }
        
        if (i % 3 == 0) {
            continue;  // Skip this iteration
        }
        
        temp = i;
        while (temp > 0) {
            if (temp % 2 == 0) {
                temp /= 2;
                loop_result += temp;
            } else {
                temp = temp * 3 + 1;
                if (temp > 100) {
                    break;
                }
                loop_result += temp % 10;
            }
            
            if (loop_result > 500) {
                break;
            }
        }
        
        if (loop_result > 1000) {
            break;
        }
    }
    
    // Test 6: Fibonacci-like sequence with conditions
    int fib_a = 1, fib_b = 1, fib_c;
    for (i = 2; i < 15; i++) {
        fib_c = fib_a + fib_b;
        
        if (fib_c % 2 == 0) {
            sum += fib_c;
            if (fib_c > 50) {
                product *= 2;
            }
        } else {
            sum -= fib_c / 3;
            if (fib_c % 5 == 0) {
                counter += fib_c;
            }
        }
        
        fib_a = fib_b;
        fib_b = fib_c;
        
        if (fib_c > 200) {
            break;
        }
    }
    
    // Final calculation combining all results
    result = (sum + product + counter + branch_test + loop_result) % 1000;
    
    // Add some final conditional logic
    if (result > 500) {
        if (result % 2 == 0) {
            result = result / 2 + 123;
        } else {
            result = result * 2 - 456;
            if (result < 0) {
                result = -result;
            }
        }
    } else {
        result = result + matrix_sum + diagonal_sum;
    }
    
    // Store final result in a memory location (for verification)
    array[0] = result;
    
    return 0;
}
