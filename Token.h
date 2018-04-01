#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef TOKEN_H
#define TOKEN_H

extern FILE *yyin, *yyout;

typedef enum eTOKENS
{
	TOKEN_KEYWORD,
	TOKEN_UNARY,
	TOKEN_ASSIGNEMENT,
	TOKEN_POINTER,
	TOKEN_REL_OP,
	TOKEN_SEP_SIGNS,
	TOKEN_AR_OP,
	TOKEN_VARIABLE_TYPE,
	TOKEN_ID,
	TOKEN_INT,
	TOKEN_REAL,
	TOKEN_END_OF_FILE,
}eTOKENS;


typedef struct Token
{
	eTOKENS kind;
	char *lexeme;
	int lineNumber;
}Token;

typedef struct Node
{
	Token *tokensArray;
	struct Node *prev;
	struct Node *next;
} Node;

void create_and_store_token(eTOKENS kind, char* lexeme, int numOfLine);

Token *next_token();
Token *back_token();

#endif
