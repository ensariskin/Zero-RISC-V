/*
 * Simple Debug Program for RV32I Processor
 * 
 * This is a minimal test to debug basic processor functionality
 * Start with the simplest possible operations and gradually add complexity
 */

int main() {
    // Test 1: Simple variable assignment
    int a = 5;
    int b = 10;
    
    // Test 2: Basic arithmetic
    int c = a + b;  // c should be 15
    
    // Test 3: Simple array operation
    int array[3];
    array[0] = a;      // Store 5 in array[0]
    array[1] = b;      // Store 10 in array[1] 
    array[2] = c;      // Store 15 in array[2]
    
    // Test 4: Simple conditional
    if (c > 10) {
        array[0] = 99;  // This should execute, array[0] becomes 99
    }
    
    // Test 5: Simple loop
    for (int i = 0; i < 2; i++) {
        array[i] = array[i] + 1;  // array[0] becomes 100, array[1] becomes 11
    }
    
    return 0;
}
