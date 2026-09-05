#include <stdio.h>
#include <stdlib.h>

int add(int a, int b) {
    int result;
    asm("addl %2, %0" : "=r" (result) : "0" (a), "r" (b));
    return result;
}

int subtract(int a, int b) {
    int result;
    asm("subl %2, %0" : "=r" (result) : "0" (a), "r" (b));
    return result;
}

int multiply(int a, int b) {
    int result;
    asm("imull %2, %0" : "=r" (result) : "0" (a), "r" (b));
    return result;
}

int divide(int a, int b) {
    int result;
    if (b == 0) {
        printf("Error: Division by zero\n");
        return 0;
    }
    asm("movl %1, %%eax\n\t"
        "cltd\n\t"
        "idivl %2\n\t"
        "movl %%eax, %0"
        : "=r" (result)
        : "r" (a), "r" (b)
        : "%eax", "%edx");
    return result;
}

int main() {
    int num1, num2, result;
    char op;
    
    printf("Enter first number: ");
    scanf("%d", &num1);
    
    printf("Enter operator (+, -, *, /): ");
    scanf(" %c", &op);
    
    printf("Enter second number: ");
    scanf("%d", &num2);
    
    switch(op) {
        case '+':
            result = add(num1, num2);
            break;
        case '-':
            result = subtract(num1, num2);
            break;
        case '*':
            result = multiply(num1, num2);
            break;
        case '/':
            result = divide(num1, num2);
            break;
        default:
            printf("Invalid operator\n");
            return 1;
    }
    
    printf("Result: %d\n", result);
    return 0;
}
