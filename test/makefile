LLVM_ARGS := $(shell llvm-config --cxxflags --ldflags --libs --system-libs)

anothertest: anotherllvmtest.cpp
	g++ $< -o $@ $(LLVM_ARGS)