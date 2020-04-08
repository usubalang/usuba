/*
 * syntax.h  -- include file for syntax.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_SYNTAX_H__
#define BSC_SYNTAX_H__

#include "hash.h"
#include <stdio.h>

enum action_type {
	B_CREAT, B_ARG, B_RET, B_ZAP,
	B_XOR, B_OR, B_AND, B_NOT, B_COPY,
	B_ENDF, B_END
};

struct action {
	int type;
	long r1, r2, r3;
};

struct symbol {
	int type;
	int width[2];
	char *name;
	union {
		long *reg;
		struct action *def;
	} u;
};

struct num_list {
	int length;
	unsigned long *data;
};

extern struct HT *symtab;

struct HT *new_symbol_table(void);
int add_symbol(struct symbol *, struct HT *);
struct symbol *get_symbol(char *, struct HT *);
struct symbol *new_symbol(struct HT *);

struct action *add_action(struct action *, int, struct action);
void aa(struct action);
void new_regs(long *, int);
void add_action_deftab(struct symbol *, struct num_list);
void add_action_defext(struct symbol *, struct num_list);
void add_action_defbit(struct symbol *);
void add_action_fun(struct symbol *, struct symbol *, struct symbol *);
void add_action_copy(struct symbol *, struct symbol *);
void add_action_not(struct symbol *, struct symbol *);
void add_action_xor(struct symbol *, struct symbol *, struct symbol *);
void add_action_or(struct symbol *, struct symbol *, struct symbol *);
void add_action_and(struct symbol *, struct symbol *, struct symbol *);
void add_action_concat(struct symbol *, struct symbol *, struct symbol *);

int yyparse(void);
struct action *parse(FILE *, struct symbol *[]);

#endif /* BSC_SYNTAX_H__ */
