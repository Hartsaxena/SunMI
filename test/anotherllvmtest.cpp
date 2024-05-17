#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/Support/raw_ostream.h>

int main() {
    // Do something stupid with LLVM
    llvm::LLVMContext context;
    llvm::Module module("my_module", context);

    // Create a function
    llvm::FunctionType* funcType = llvm::FunctionType::get(llvm::Type::getVoidTy(context), false);
    llvm::Function* func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "my_function", &module);

    // Print the function name
    llvm::outs() << "Function name: " << func->getName() << "\n";

    return 0;
}