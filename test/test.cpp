/*Printing out a C++ class's code using llvm*/
#include <iostream>


class TestClass
{
public:
    TestClass();
    ~TestClass();
    void print();
    void print2();
};


TestClass::TestClass()
{
    std::cout << "TestClass constructor\n";
}

TestClass::~TestClass()
{
    std::cout << "TestClass destructor\n";
}

void TestClass::print() {
    std::cout << "HELLO\n";
}

void TestClass::print2() {
    std::cout << "GOODBYE\n";
}



int main() {
    TestClass t;
    t.print();

    return 0;
}