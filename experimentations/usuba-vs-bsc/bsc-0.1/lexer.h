/*
 * lexer.h  -- include file for lexer.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_LEXER_H__
#define BSC_LEXER_H__

#include <stdio.h>

struct token {
	int type;
	long line;
	char *name;
};

void init_lexer(void);
struct token *lex(FILE *);

#endif /* BSC_LEXER_H__ */
