BISON_FILE = bison.y
FLEX_FILE = flex.l
CC = gcc

all:
	bison -d $(BISON_FILE)
	flex $(FLEX_FILE)
	
	$(CC) -o SunMI lex.yy.c bison.tab.c -lfl

clean:
	rm -f lex.yy.c bison.tab.c bison.tab.h SunMI output.txt