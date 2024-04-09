all: parser

OBJS = bison.o  \
       codegen.o \
       main.o    \
       flex.o  \
       corefn.o  \
	   native.o  \

LLVMCONFIG = llvm-config
CPPFLAGS = `$(LLVMCONFIG) --cppflags` -std=c++14
LDFLAGS = `$(LLVMCONFIG) --ldflags` -lpthread -ldl -lncurses -rdynamic
LIBS = `$(LLVMCONFIG) --libs`
CC = g++

clean:
	$(RM) -rf bison.cpp bison.hpp bison flex.cpp $(OBJS) 

bison.cpp: bison.y
	bison -d -o $@ $^
	
bison.hpp: bison.cpp

flex.cpp: flex.l bison.hpp
	flex -o $@ $^

%.o: %.cpp
	$(CC) -c $(CPPFLAGS) -o $@ $<


parser: $(OBJS)
	$(CC)  -o $@ $(OBJS) $(LIBS) $(LDFLAGS)

test:
	g++ test.cpp -o test $(LDFLAGS)
