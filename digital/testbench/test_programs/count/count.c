#include <stdio.h>

int main() {
    int b;
    int c;

    c = 100;
    for (int i = 0; i <= 9; i++) {
        b = b + i; 
        c = c - b;
    }
    return 0;
}
