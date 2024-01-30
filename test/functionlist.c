/*
A test file to see how arrays of functions work in C.
I need to be able to store a function and call it with arguments
*/

#include <stdio.h>

// Define sample functions with different signatures
int add(int a, int b) {
    return a + b;
}
int subtract(int a, int b) {
    return a - b;
}
int multiply(int a, int b) {
    return a * b;
}
float divide(float a, float b) {
    if (b != 0.0) {
        return a / b;
    } else {
        printf("Sorry, but you can't divide by 0. Returning 0.\n");
        return 0.0f;
    }
}

int main() {
    // Declare an array of void pointers for function pointers
    void (*functionArray[4])();

    /*
    Technically, because all the functions we're storing only take 2 integer arguments, we can use:
    void (*functionArray[4])(int, int);

    But if we're storing functions that take different arguments in SunMI, so not specifying any arguments is better.
    */

    // Initialize the array with the functions
    functionArray[0] = (void (*)())add;
    functionArray[1] = (void (*)())subtract;
    functionArray[2] = (void (*)())multiply;
    functionArray[3] = (void (*)())divide;

    // Call each function in the array with appropriate arguments
    int addOutput, subOutput, multOutput;
    addOutput = ((int (*)(int, int))functionArray[0])(12, 23);
    subOutput = ((int (*)(int, int))functionArray[1])(12, 23);
    multOutput = ((int (*)(int, int))functionArray[2])(12, 23);
    float divOutput;
    divOutput = ((float (*)(float, float))functionArray[3])(12.0, 23.0);

    printf("addOutput: %d\n", addOutput);
    printf("subOutput: %d\n", subOutput);
    printf("multOutput: %d\n", multOutput);
    printf("divOutput: %f\n", divOutput);

    return 0;
}
