/* I didn't even know you could use ampersands in variable declarations. */

#include <iostream>

int getPointer(int* num) {
    return *num;
}

int getReference(int& num) {
    return num;
}



int main() {
    int num = 5;
    int* ptr = &num;
    int& ref = num;

    int ptrVal = getPointer(ptr);
    int refVal = getReference(ref);

    std::cout << ptrVal << std::endl;
    std::cout << refVal << std::endl << std::endl;

    int* newPointer = NULL;

    return 0;
}