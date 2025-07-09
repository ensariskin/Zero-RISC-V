#include <stdio.h>

int main() {
    printf("Starting multiply program...\n");

    int mul = 1;
    for (int i = 1; i <= 5; i++) {
        mul *= i;
        printf("Count: %d, Mul : %d\n", i, mul);
    }

    printf("Multiply program finished!\n");
    return 0;
}
