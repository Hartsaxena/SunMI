all: parser

OBJS = bison.o  \
       codegen.o \
       main.o    \
       flex.o  \
       corefn.o  \
	   native.o  \

CPPFLAGS = $(shell llvm-config --cxxflags) -std=c++14
LDFLAGS = $(shell llvm-config --ldflags --system-libs --libs)
LIBS = `llvm-config --libs`
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
