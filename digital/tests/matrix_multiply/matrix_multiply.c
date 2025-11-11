// Matrix Multiplication Test for 50x50 matrices
// Tests superscalar processor performance with intensive computation

#define MATRIX_SIZE 15

// Global matrices to avoid stack overflow
int A[MATRIX_SIZE][MATRIX_SIZE];
int B[MATRIX_SIZE][MATRIX_SIZE];
int C[MATRIX_SIZE][MATRIX_SIZE];

// Initialize matrices with simple patterns
void init_matrices() {
    int i, j;
    
    // Initialize matrix A with row index pattern
    for (i = 0; i < MATRIX_SIZE; i++) {
        for (j = 0; j < MATRIX_SIZE; j++) {
            A[i][j] = i + 1;
        }
    }
    
    // Initialize matrix B with column index pattern
    for (i = 0; i < MATRIX_SIZE; i++) {
        for (j = 0; j < MATRIX_SIZE; j++) {
            B[i][j] = j + 1;
        }
    }
    
    // Initialize result matrix C to zero
    for (i = 0; i < MATRIX_SIZE; i++) {
        for (j = 0; j < MATRIX_SIZE; j++) {
            C[i][j] = 0;
        }
    }
}

// Matrix multiplication: C = A * B
void matrix_multiply() {
    int i, j, k;
    int sum;
    
    for (i = 0; i < MATRIX_SIZE; i++) {
        for (j = 0; j < MATRIX_SIZE; j++) {
            sum = 0;
            for (k = 0; k < MATRIX_SIZE; k++) {
                sum += A[i][k] * B[k][j];
            }
            C[i][j] = sum;
        }
    }
}

// Verify result (C[i][j] should equal (i+1) * sum(1 to 50) * (j+1))
// Since sum(1 to 50) = 50*51/2 = 1275
int verify_result() {
    int i, j;
    int expected;
    int errors = 0;
    
    for (i = 0; i < MATRIX_SIZE; i++) {
        for (j = 0; j < MATRIX_SIZE; j++) {
            expected = (i + 1) * 1275 * (j + 1);
            if (C[i][j] != expected) {
                errors++;
            }
        }
    }
    
    return errors;
}

int main() {
    int errors;
    
    // Initialize matrices
    init_matrices();
    
    // Perform matrix multiplication
    matrix_multiply();
    
    // Verify results
    errors = verify_result();
    
    // Return 0 if success, number of errors otherwise
    return errors;
}
