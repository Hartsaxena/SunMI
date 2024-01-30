/* C Declarations */

%{
	#include <stdio.h>
	int sym[33]; // Variable storage
    void (*functionArray[256])(); // Function Storage
	int t1 = 0;
	int t0 = 0;
	int t2 = 0;
	int t3 = 0;
	int t4 = 0;
	int cnt = 0;
%}

/* bison declarations */

%token NUM VAR IF ELSE WHILE CASE SWITCH BREAK PRINT DEFAULT
%token FUNCTION RETURN
%token STDOUT STDIN
%nonassoc IFX
%nonassoc ELSE
%left '<' '>'
%left '+' '-'
%left '*' '/'

/* Grammar rules and actions follow.  */

%%

program: /* NULL */
| program statement {;}

functionDef: FUNCTION '(' VAR ')' compoundStatement {;}
functionCall: FUNCTION '(' VAR ')'
| FUNCTION '('')'{

}

compoundStatement: '{' statementList '}'

statementList: statementList statement {;}


statement:  SWITCH '(' VAR ')' '{' BASE '}'     
| expression ';' {printf("value of expression: %d\n", $1);}
| declaration
| whileLoop
| ifStatement ;

/* Declaration of variable */
declaration:
VAR '=' expression ';' { 
                        sym[$1] = $3;
                        t4 = sym[$1];
                        printf("Value of the variable: %d\t\n",$3);
                    }
| VAR '=' functionCall ';' {

                    }

/* While loops */
whileLoop:
WHILE '(' expression ')' statementList ';' {
                            printf("\n----- Loop Started Here ---- \n");
                            while($3--) {
                                printf("Loop Here :  %d\n", $3);
                            }
                            printf("----- Loop Ended Here -----\n\n");				
                        }

/* IF statements */
ifStatement:
IF '(' expression ')' statementList ';' %prec IFX {
                            if($3) {
                                printf("\nValue of expression in IF: %d\n",$5);
                            } else {
                                printf("Condition value zero in IF block\n");
                            }
                        }

| IF '(' expression ')' expression ';' ELSE expression ';' {
                                if($3)
                                {
                                    printf("Value of expression in IF: %d\n",$5);
                                }
                                else
                                {
                                    printf("Value of expression in ELSE: %d\n",$8);
                                }
                            }

|IF '(' expression ')' '{' statement '}' {;}


BASE : Base
     | Base Default
     ;

Base   : /*NULL*/
     | Base Case
     ;

Case    : CASE NUM ':' expression ';' BREAK ';' {
            if(t4==$2) {
                cnt=1;
                printf("\nSwitch Case statement Started Here \nID : %d  Returned %d.\nSwitch case ended\n\n",$2,$4);
            }
        };

Default    : DEFAULT ':' expression ';' BREAK ';'{
            if(cnt==0){
                printf("\nSwitch Case statement Started Here\nYou Failed !!!\nSwitch case ended\n\n");
            }
        }
     ;     


expression: NUM { $$ = $1; 	}
| VAR  { $$ = sym[$1]; }

| expression '+' expression	{ $$ = $1 + $3; }

| expression '-' expression	{ $$ = $1 - $3; }

| expression '*' expression	{ $$ = $1 * $3; }

| expression '/' expression	{ 	
                    if($3 != 0) {
                        $$ = $1 / $3;
                    } else {
                        $$ = 0;
                        printf("\nERROR: Division by 0\t");
                    }
                }

| expression '<' expression	{ $$ = $1 < $3; }

| expression '>' expression	{ $$ = $1 > $3; }

| '(' expression ')'		{ $$ = $2;	}
;
%%

int yywrap() {
    return 1;
}

int yyerror(char *s){
	printf( "%s\n", s);
}

