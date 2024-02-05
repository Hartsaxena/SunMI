/* C++ Declarations */
/* Currently Porting everything to C++ */

%{
    #include <stdio.h>
	int sym[33]; // Variable storage
	int t1 = 0;
	int t0 = 0;
	int t2 = 0;
	int t3 = 0;
	int t4 = 0;
	int cnt = 0;
%}


%union {
    int num;
    char var;
    int expr;
    int func;
}

/* bison declarations */

%token NUM VAR IF ELSE WHILE CASE SWITCH BREAK PRINT DEFAULT
%token FUNCTION RETURN
%token STDOUT STDIN
%nonassoc IFX
%nonassoc ELSE
%left '<' '>'
%left '+' '-'
%left '*' '/'

// Type of tokens
%type <num> NUM
%type <var> VAR
%type <expr> expression

/* Grammar rules and actions follow.  */

%%

program: /* NULL */
| program statement {;}

functionDef: FUNCTION '(' VAR ')' compoundStatement {;}
functionCall: VAR '(' expression ')'
| FUNCTION '('')'{
}

compoundStatement: '{' statementList '}'

statementList: statementList statement {;}


statement:  SWITCH '(' VAR ')' '{' BASE '}'     
| expression ';' {std::cout<<"value of expression: %d\n", $1);}
| declaration
| whileLoop
| ifStatement ;

/* Declaration of variable */
declaration:
VAR '=' expression ';' { 
                        sym[$1] = $3;
                        t4 = sym[$1];
                        std::cout<<"Value of the variable: %d\t\n",$3;
                    }
| VAR '=' functionCall ';' {

                    }

/* While loops */
whileLoop:
WHILE '(' expression ')' statementList ';' {
                            std::cout<<"\n----- Loop Started Here ---- \n";
                            while($3--) {
                                std::cout<<format("Loop Here :  %d\n", $3);
                            }
                            std::cout<<"----- Loop Ended Here -----\n\n";			
                        }

/* IF statements */
ifStatement:
IF '(' expression ')' statementList ';' %prec IFX {
                            if($3) {
                                std::cout<<"IF statement condition passed\n";
                            } else {
                                std::cout<<"Condition value zero in IF block\n";
                            }
                        }

| IF '(' expression ')' expression ';' ELSE expression ';' {
                                if($3)
                                {
                                    std::cout<<format("Value of expression in IF: %d\n",$5);
                                }
                                else
                                {
                                    std::cout<<format("Value of expression in ELSE: %d\n",$8);
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
                std::cout<<format("\nSwitch Case statement Started Here \nID : %d  Returned %d.\nSwitch case ended\n\n",$2,$4);
            }
        };

Default    : DEFAULT ':' expression ';' BREAK ';'{
            if(cnt==0){
                std::cout<<"\nSwitch Case statement Started Here\nYou Failed !!!\nSwitch case ended\n\n";
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
                        std::cout<<"\nERROR: Division by 0\t";
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
	std::cout<< "%s\n", s);
}