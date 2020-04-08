%{
/*
 * parse.y  -- parser for bsc (to be used with yacc or bison)
 * (c) Thomas Pornin 1998
 */

#include "syntax.h"
#include <stdio.h>
#include <stdlib.h>
#include "mem.h"

extern struct HT *symtab;

void check_symbol(char *name);
%}

%union {
	char *id;
	long num;
	struct num_list list;
	int width[2];
}

%token <id> NAME FNAME STRING VOID
%token <num> NUMBER
%token NONE CCON SLASH ASSLASH MINUS MMINUS
%token ASMINUS ARROW PLUS PPLUS ASPLUS LT LEQ LSH ASLSH
%token GT GEQ RSH ASRSH ASGN EQ NOT NEQ AND LAND ASAND
%token OR LOR ASOR SHARP ASSHARP PCT ASPCT STAR ASSTAR
%token CIRC ASCIRC LNOT ASNOT LBRA RBRA LBRK RBRK LPAR RPAR
%token COMMA QUEST SEMIC COLON DOT ELLIPS ERROR

%token LOOP TAB EXT BIT

%right ASGN ASSHARP ASCIRC ASOR ASAND
%left OR AND CIRC
%nonassoc LNOT

%type <id> expression, concat_expressions
%type <list> list_of_numbers

%%
/* ==================================================================== */
/*  Parser Rules                                                        */
/* ==================================================================== */

statement:
	| TAB NAME LBRK NUMBER RBRK LPAR NUMBER RPAR LBRA list_of_numbers RBRA
		{
			struct symbol *s = getmem(sizeof(struct symbol));

			s->type = TAB;
			s->name = $2;
			s->width[0] = $4;
			s->width[1] = $7;
			add_symbol(s, symtab);
			if ($10.length != (1 << $7)) {
				fprintf(stderr, "bsc: size of tab %s does not match definition\n", s->name);
				exit(1);
			}
			add_action_deftab(s, $10);
		}
	| EXT NAME LBRK NUMBER RBRK LPAR NUMBER RPAR LBRA list_of_numbers RBRA
		{
			struct symbol *s = getmem(sizeof(struct symbol));

			s->type = EXT;
			s->name = $2;
			s->width[0] = $4;
			s->width[1] = $7;
			add_symbol(s, symtab);
			if ($10.length != $4) {
				fprintf(stderr, "bsc: size of ext %s does not match definition\n", s->name);
				exit(1);
			}
			add_action_defext(s, $10);
		}
	| BIT NAME LBRK NUMBER RBRK
		{
			struct symbol *s = getmem(sizeof(struct symbol));

			s->type = BIT;
			s->name = $2;
			s->width[0] = $4;
			add_symbol(s, symtab);
			add_action_defbit(s);
		}
	| expression
		{
		}

/* ==================================================================== */

expression:
	  LPAR expression RPAR
		{
			$$ = $2;
		}
	| NAME LPAR expression RPAR
		{
			struct symbol *t, *s = get_symbol($3, symtab);
			struct symbol *f = get_symbol($1, symtab);

			check_symbol($1);
			if (f->type != TAB && f->type != EXT) {
				fprintf(stderr, "bsc: not a function: '%s'\n", f->name);
				exit(1);
			}
			if (s->width[0] != f->width[1]) {
				fprintf(stderr, "bsc: size mismatch on argument of function '%s'\n", f->name);
				exit(1);
			}
			t = new_symbol(symtab);
			t->type = BIT;
			t->width[0] = f->width[0];
			add_action_defbit(t);
			add_action_fun(f, s, t);
			$$ = t->name;
		}
	| NAME
		{
			struct symbol *s = get_symbol($1, symtab);

			check_symbol($1);
			if (s->type != BIT) {
				fprintf(stderr, "bsc: '%s' is not a variable\n", s->name);
				exit(1);
			}
			$$ = $1;
		}
	| expression ASGN expression
		{
			struct symbol *s = get_symbol($1, symtab);
			struct symbol *t = get_symbol($3, symtab);

			add_action_copy(t, s);
			$$ = $1;
		}
	| expression ASCIRC expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_xor(s, t, u);
			add_action_copy(u, s);
			$$ = $1;
		}
	| expression ASOR expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_or(s, t, u);
			add_action_copy(u, s);
			$$ = $1;
		}
	| expression ASAND expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_and(s, t, u);
			add_action_copy(u, s);
			$$ = $1;
		}
	| expression OR expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_or(s, t, u);
			$$ = u->name;
		}
	| expression AND expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_and(s, t, u);
			$$ = u->name;
		}
	| expression CIRC expression
		{
			struct symbol *s = get_symbol($3, symtab);
			struct symbol *t = get_symbol($1, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = t->width[0];
			add_action_defbit(u);
			add_action_xor(s, t, u);
			$$ = u->name;
		}
	| LNOT expression
		{
			struct symbol *s = get_symbol($2, symtab);
			struct symbol *u = new_symbol(symtab);

			u->type = BIT;
			u->width[0] = s->width[0];
			add_action_defbit(u);
			add_action_not(s, u);
			$$ = u->name;
		}
	| LBRK concat_expressions RBRK
		{
			$$ = $2;
		}

/* ==================================================================== */

concat_expressions:
	  expression
		{
			$$ = $1;
		}
	| expression SHARP concat_expressions
		{
			struct symbol *s, *t, *u = new_symbol(symtab);

			s = get_symbol($1, symtab);
			t = get_symbol($3, symtab);
			u->type = BIT;
			u->width[0] = s->width[0] + t->width[0];
			add_action_concat(s, t, u);
			$$ = u->name;
		}

/* ==================================================================== */

list_of_numbers:
	  VOID
		{
			$$.length = 0;
		}
	| NUMBER
		{
			$$.length = 1;
			$$.data = getmem(MEM_GRAN * sizeof(long));
			$$.data[0] = $1;
		}
	| NUMBER COMMA list_of_numbers
		{
			int i;

			$$.length = $3.length + 1;
			if (!($3.length % MEM_GRAN)) {
				$3.data = incmem($3.data, $3.length * sizeof(long), ($3.length + MEM_GRAN) * sizeof(long));
			}
			$$.data = $3.data;
			for (i = $3.length - 1; i >= 0; i --)
				$$.data[i + 1] = $$.data[i];
			$$.data[0] = $1;
		}

%%

/* ==================================================================== */
/* ==================================================================== */

void check_symbol(char *name)
{
	if (!get_symbol(name, symtab)) {
		fprintf(stderr, "bsc: unknown identifier '%s'\n", name);
		exit(1);
	}
}
