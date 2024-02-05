/* C++ Declarations */

%{
	#include <stdio.h>
    #include "bison.tab.h"
	#include <stdlib.h>
	extern int yylval;
%}

/* RE and Actions */

%%

[0-9]+ { 
    yylval = atoi(yytext);
    return NUM;
}

[a-z] {
    yylval = *yytext - 'a';
    return	VAR;
}

"loop"    return WHILE;
"if"	  return IF;
"else"  return ELSE;
"case"    return CASE;
"switch"  return SWITCH;
"break"   return BREAK;
"print"   return PRINT;
"default" return DEFAULT;
"function" return FUNCTION;
"return" return RETURN;
"stdout" return STDOUT;
"stdin" return STDIN;

[-+/*<>=,():;{}] {
    yylval = yytext[0];
    return *yytext;
}

[ \t\n]*	;

. {
    yyerror("Unknown Character.\n");
}
%%

int main() {
	yyin = freopen("in.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
}

