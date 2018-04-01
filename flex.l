%{
#include "Token.h"
%}
%option nounput yylineno

LETTER [a-z|A-Z]
ID ({LETTER}+"_")*{LETTER}+
DIGIT [0-9]
INT [0|1-9]{DIGIT}*
REAL {INT}+"."{INT}+
COMMENT "--".*
%%

\n {;}
{COMMENT}
"block"|"begin"|"end"|"type"|"is"|"integer"|"real"|"array"|"of"|"when"|"do"|"default"|"end_when"|"for"|"end_for"|"malloc"|"size_of"|"free" {create_and_store_token(TOKEN_KEYWORD,yytext,yylineno);}
"++"|"&" {create_and_store_token(TOKEN_UNARY,yytext,yylineno);}
"=" {create_and_store_token(TOKEN_ASSIGNEMENT,yytext,yylineno);}
"^" {create_and_store_token(TOKEN_POINTER,yytext,yylineno);}
"=="|"!="|">"|"<"|"<="|">=" {create_and_store_token(TOKEN_REL_OP,yytext,yylineno);}
":"|";"|"("|")"|"]"|"["|","|"{"|"}"|"." {create_and_store_token(TOKEN_SEP_SIGNS,yytext,yylineno);}
"*"|"**"|"/"|"+"|"-" {create_and_store_token(TOKEN_AR_OP,yytext,yylineno);}
"int"|"double"|"ptr"|"arr" {create_and_store_token(TOKEN_VARIABLE_TYPE,yytext,yylineno);}
{ID} {create_and_store_token(TOKEN_ID,yytext,yylineno);}
{INT} {create_and_store_token(TOKEN_INT,yytext,yylineno);}
{REAL} {create_and_store_token(TOKEN_REAL,yytext,yylineno);}
<<EOF>>	{return 1;}
[ \t\r]+
. fprintf(yyout,"The character '%s' at line: {%d} does not begin with legal token\n",yytext,yylineno);

%%
void main(int argc, char* argv[])
{
	yyin=fopen("C:\\temp\\test1.txt","r");
	yyout=fopen("C:\\temp\\test1_lex.txt","w");

	if(yyin==0)
		fprintf(yyout,"Can't open file!");
	else
	{
		yylex();
		fclose(yyin);
		fclose(yyout);
	}

	yylineno=1;

	yyin=fopen("C:\\temp\\test2.txt","r");
	yyout=fopen("C:\\temp\\test2_lex.txt","w");
	if(yyin==0)
	  fprintf(yyout,"Can't not open the file!");
	else
	{
	  yylex();
	  fclose(yyin);
	}
	  fclose(yyout);
}

int yywrap(void)
{
	return 1;
}
