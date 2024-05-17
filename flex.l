%{

#include <iostream>
#include <string>
#include "node.h"
#include "bison.hpp"

#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t)    (yylval.token = t)
#define OUT(t)      printf("%s\n", t)
%}

%option noyywrap

%%

[ \t\n]					        ;
"extern"                        return TOKEN(TEXTERN); OUT("EXTERN");
"return"				        return TOKEN(TRETURN); OUT("RETURN");
"if"                            return TOKEN(TIF); OUT("IF");
"else"                          return TOKEN(TELSE); OUT("ELSE");
"class"                         return TOKEN(TCLASS); OUT("CLASS");

"true"                            return TOKEN(TTRUE); OUT("TRUE");
"false"                           return TOKEN(TFALSE); OUT("FALSE");
[a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TIDENTIFIER; OUT("IDENTIFIER");
[0-9]+\.[0-9]* 			    SAVE_TOKEN; return TDOUBLE; OUT("DOUBLE");
[0-9]+					        SAVE_TOKEN; return TINTEGER; OUT("INTEGER");

\"([^\\\n]|(\\.))*?\"            {SAVE_TOKEN; return TSTRING; OUT("STRING");}

"="						          return TOKEN(TEQUAL); OUT("EQUAL");
"=="				          	return TOKEN(TCEQ); OUT("CEQ");
"!="			          		return TOKEN(TCNE); OUT("CNE");
"<"				          		return TOKEN(TCLT); OUT("CLT");
"<="	          				return TOKEN(TCLE); OUT("CLE");
">"				          		return TOKEN(TCGT); OUT("CGT");
">="					          return TOKEN(TCGE); OUT("CGE");

"("	          					return TOKEN(TLPAREN); OUT("LPAREN");
")"					          	return TOKEN(TRPAREN); OUT("RPAREN");
"{"         						return TOKEN(TLBRACE); OUT("LBRACE");
"}"					          	return TOKEN(TRBRACE); OUT("RBRACE");

"."         						return TOKEN(TDOT); OUT("DOT");
","				          		return TOKEN(TCOMMA); OUT("COMMA");

"+"				          		return TOKEN(TPLUS); OUT("PLUS");
"-"		          				return TOKEN(TMINUS); OUT("MINUS");
"*"		          				return TOKEN(TMUL); OUT("MUL");
"/"				          		return TOKEN(TDIV); OUT("DIV");

.                       printf("Unknown token!: %s\n", yytext); yyterminate();

%%
