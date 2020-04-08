/*
 * lexer.c  -- Lexer for bsc
 * (c) Thomas Pornin 1998
 * inspired from cpp/lex.c from lcc
 *     (authors: Chirstopher W. Fraser and David R. Hanson)
 */

#include "lexer.h"
#include "types.h"
#include "mem.h"
#include <memory.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parse.h"

/*
 * character classes:
 *   C_WS    is whitespace (' ', '\n', '\t', '\r')
 *   C_ALPH  is alphabetic ([a-zA-Z_])
 *   C_NUM   is numeric ([0-9])
 *   C_XX    is everything
 */
#define C_WS	1
#define C_ALPH	2
#define C_NUM	3
#define C_XX	4

/* for optimization, MAXSTATE should be a power of 2 */
#define MAXSTATE 32
#define noMOD(x)	((x) & 4095)
#define STO(x)		((x) | (1 << 12))
#define isSTO(x)	((x) & (1 << 12))
#define REQ(x)		((x) | (1 << 13))
#define isREQ(x)	((x) & (1 << 13))
#define FRZ(x)		((x) | (1 << 14))
#define isFRZ(x)	((x) & (1 << 14))

/*
 * These are the states of the automaton implementing the preprocessor.
 * All states except S_SELF, S_STNL and UNCLASS must be between 0
 * and MAXSTATE - 1
 */
enum lm_state {
	START = 0, NUM1, NUM2, NUM3, ID1, ST1, ST2, ST3, ST4, COM1, COM2, COM3,
	CC1, CC2, WS1, PLUS1, MINUS1, STAR1, SLASH1, PCT1, SHARP1,
	CIRC1, GT1, GT2, LT1, LT2, OR1, AND1, ASG1, NOT1, LNOT1, DOTS1,
	S_SELF = MAXSTATE, S_STNL, UNCLASS
};

struct lms {
	int state;
	u8 ch[4];
	int n_state;
};

/*
 * This is the description of the automaton
 *
 * REQ() means that a special action is required (it may be replace by a
 *       test state >= MAXSTATE)
 * STO() means that the token is to be stored with the given type ; the
 *       next state will be START
 * FRZ() means that the character must not be discarded, but considered
 *       again
 */
static struct lms fm[] = {
	/* start state */
	START,	{ C_XX },	REQ(UNCLASS),
	START,	{ C_WS },	WS1,
	START,	{ C_NUM },	NUM1,
	START,	{ '.' },	NUM3,
	START,	{ C_ALPH },	ID1,
	START,	{ 'L' },	ST1,
	START,	{ '"' },	ST2,
	START,	{ '\'' },	CC1,
	START,	{ '/' },	COM1,
	START,	{ '-' },	MINUS1,
	START,	{ '+' },	PLUS1,
	START,	{ '<' },	LT1,
	START,	{ '>' },	GT1,
	START,	{ '=' },	ASG1,
	START,	{ '!' },	NOT1,
	START,	{ '&' },	AND1,
	START,	{ '|' },	OR1,
	START,	{ '#' },	SHARP1,
	START,	{ '%' },	PCT1,
	START,	{ '[' },	STO(LBRK),
	START,	{ ']' },	STO(RBRK),
	START,	{ '(' },	STO(LPAR),
	START,	{ ')' },	STO(RPAR),
	START,	{ '*' },	STAR1,
	START,	{ ',' },	STO(COMMA),
	START,	{ '?' },	STO(QUEST),
	START,	{ ':' },	STO(COLON),
	START,	{ ';' },	STO(SEMIC),
	START,	{ '{' },	STO(LBRA),
	START,	{ '}' },	STO(RBRA),
	START,	{ '~' },	LNOT1,
	START,	{ '^' },	CIRC1,

	/* saw a digit */
	NUM1,	{ C_XX },	FRZ(STO(NUMBER)),
	NUM1,	{ C_NUM, C_ALPH, '.' },	NUM1,
	NUM1,	{ 'E', 'e' },	NUM2,

	/* saw possible start of exponent, digits-e */
	NUM2,	{ C_XX },	FRZ(STO(NUMBER)),
	NUM2,	{ '+', '-' },	NUM1,
	NUM2,	{ C_NUM, C_ALPH },	NUM1,

	/* saw a '.', which could be a number or an operator */
	NUM3,	{ C_XX },	FRZ(STO(DOT)),
	NUM3,	{ '.' },	DOTS1,
	NUM3,	{ C_NUM },	NUM1,

	DOTS1,	{ C_XX },	REQ(UNCLASS),
	DOTS1,	{ C_NUM },	NUM1,
	DOTS1,	{ '.' },	STO(ELLIPS),

	/* saw a letter or _ */
	ID1,	{ C_XX },	FRZ(STO(NAME)),
	ID1,	{ C_ALPH, C_NUM },	ID1,

	/* saw L (start of wide string?) */
	ST1,	{ C_XX },	FRZ(STO(NAME)),
	ST1,	{ C_ALPH, C_NUM },	ID1,
	ST1,	{ '"' },	ST2,
	ST1,	{ '\'' },	CC1,

	/* saw " beginning string */
	ST2,	{ C_XX },	ST2,
	ST2,	{ '"' },	STO(STRING),
	ST2,	{ '\\' },	ST3,
	ST2,	{ '\n', '\r' },	REQ(S_STNL),

	/* saw \ in string */
	ST3,	{ C_XX },	ST2,
	ST3,	{ '\n', '\r' },	REQ(S_STNL),

	/* saw < after a #include or #import */
	/* we suppose such a statement is not spread on several lines
	   with a '\' */
	ST4,	{ C_XX },	ST4,
	ST4,	{ '>' },	STO(STRING),
	ST4,	{ '\n', '\r' },	REQ(S_STNL),

	/* saw ' beginning character const */
	CC1,	{ C_XX },	CC1,
	CC1,	{ '\'' },	STO(CCON),
	CC1,	{ '\\' },	CC2,
	CC1,	{ '\n', '\r' },	REQ(S_STNL),

	/* saw \ in ccon */
	CC2,	{ C_XX },	CC1,
	CC2,	{ '\n', '\r' },	REQ(S_STNL),

	/* saw /, perhaps start of comment */
	COM1,	{ C_XX },	FRZ(STO(SLASH)),
	COM1,	{ '=' },	STO(ASSLASH),
	COM1,	{ '*' },	COM2,

	/* saw start of comment */
	COM2,	{ C_XX },	COM2,
	COM2,	{ '*' },	COM3,

	/* saw the * possibly ending a comment */
	COM3,	{ C_XX },	COM2,
	COM3,	{ '*' },	COM3,
	COM3,	{ '/' },	STO(NONE),

	/* saw white space, eat it up */
	WS1,	{ C_XX },	FRZ(STO(NONE)),
	WS1,	{ C_WS },	WS1,

	/* saw -, check --, -=, -> */
	MINUS1,	{ C_XX },	FRZ(STO(MINUS)),
	MINUS1,	{ '-' },	STO(MMINUS),
	MINUS1,	{ '=' },	STO(ASMINUS),
	MINUS1,	{ '>' },	STO(ARROW),

	/* saw +, check ++, += */
	PLUS1,	{ C_XX },	FRZ(STO(PLUS)),
	PLUS1,	{ '+' },	STO(PPLUS),
	PLUS1,	{ '=' },	STO(ASPLUS),

	/* saw <, check <<, <<=, <= */
	LT1,	{ C_XX },	FRZ(STO(LT)),
	LT1,	{ '<' },	LT2,
	LT1,	{ '=' },	STO(LEQ),
	LT2,	{ C_XX },	FRZ(STO(LSH)),
	LT2,	{ '=' },	STO(ASLSH),

	/* saw >, check >>, >>=, >= */
	GT1,	{ C_XX },	FRZ(STO(GT)),
	GT1,	{ '>' },	GT2,
	GT1,	{ '=' },	STO(GEQ),
	GT2,	{ C_XX },	FRZ(STO(RSH)),
	GT2,	{ '=' },	STO(ASRSH),

	/* = */
	ASG1,	{ C_XX },	FRZ(STO(ASGN)),
	ASG1,	{ '=' },	STO(EQ),

	/* ! */
	NOT1,	{ C_XX },	FRZ(STO(NOT)),
	NOT1,	{ '=' },	STO(NEQ),

	/* ~ */
	LNOT1,	{ C_XX },	FRZ(STO(LNOT)),
	LNOT1,	{ '=' },	STO(ASNOT),

	/* & */
	AND1,	{ C_XX },	FRZ(STO(AND)),
	AND1,	{ '&' },	STO(LAND),
	AND1,	{ '=' },	STO(ASAND),

	/* | */
	OR1,	{ C_XX },	FRZ(STO(OR)),
	OR1,	{ '|' },	STO(LOR),
	OR1,	{ '=' },	STO(ASOR),

	/* # */
	SHARP1,	{ C_XX },	FRZ(STO(SHARP)),
	SHARP1,	{ '=' },	STO(ASSHARP),

	/* % */
	PCT1,	{ C_XX },	FRZ(STO(PCT)),
	PCT1,	{ '=' },	STO(ASPCT),

	/* * */
	STAR1,	{ C_XX },	FRZ(STO(STAR)),
	STAR1,	{ '=' },	STO(ASSTAR),

	/* ^ */
	CIRC1,	{ C_XX },	FRZ(STO(CIRC)),
	CIRC1,	{ '=' },	STO(ASCIRC),

	-1
};

/*
 * This array stores the expanded automaton
 */
u16 tfm[256][MAXSTATE];

/*
 * This function must be called before any use of the lexer. It does not
 * need to be called more than once.
 */
void init_lexer(void)
{
	struct lms *fp;
	int i, j;
	u16 n;

	for (j = 0; j < 256; j ++) for (i = 0; i < MAXSTATE; i ++) {
		tfm[j][i] = REQ(ERROR);
	}
	for (fp = fm; fp->state != -1; fp ++) for (i = 0; fp->ch[i]; i ++) {
		n = fp->n_state;
		assert(fp->state != START || (!isFRZ(n)));
		assert(fp->state < MAXSTATE);
		assert(noMOD(n) < MAXSTATE || isSTO(n) || isREQ(n));
		switch (fp->ch[i]) {
		case C_XX:
			for (j = 0; j < 256; j ++)
				tfm[j][fp->state] = n;
			break;
		case C_ALPH:
			for (j = 'A'; j <= 'Z'; j ++)
				tfm[j][fp->state] = n;
			for (j = 'a'; j <= 'z'; j ++)
				tfm[j][fp->state] = n;
			tfm['_'][fp->state] = n;
			break;
		case C_NUM:
			for (j = '0'; j <= '9'; j ++)
				tfm[j][fp->state] = n;
			break;
		case C_WS:
			tfm[' '][fp->state] = n;
			tfm['\t'][fp->state] = n;
			tfm['\n'][fp->state] = n;
			tfm['\r'][fp->state] = n;
			tfm['\v'][fp->state] = n;
		default:
			tfm[fp->ch[i]][fp->state] = n;
		}
	}
}

/*
 * This function adds a character at the end of an array of char,
 * reallocating some memory if needed
 */
static char *add_char(char *s, int l, char c)
{
	char *t = s;

	if (l == 0) t = getmem(MEM_GRAN);
	else if (((l + 1) % MEM_GRAN) == 0) t = incmem(s, l, l + MEM_GRAN + 1);
	t[l] = c;
	return t;
}

/*
 * This function stores the token at the end of the given list.
 * If the type is NONE, the contents are discarded.
 */
static void sto_token(char *s, int l, int type, struct token **toklist, int *tklp, long line)
{
	char *t = s;

	if (*tklp == 0)
		*toklist = getmem(MEM_GRAN * sizeof(struct token));
	else if (((*tklp + 1) % MEM_GRAN) == 0)
		*toklist = incmem(*toklist, (*tklp) * sizeof(struct token), (*tklp + MEM_GRAN + 1) * sizeof(struct token));
	if (type != NONE) {
		if (((l + 1) % MEM_GRAN) == 0)
			t = incmem(s, l, l + MEM_GRAN + 1);
		t[l] = 0;
		((*toklist)[*tklp]).name = getmem(l + 1);
		memcpy(((*toklist)[*tklp]).name , t, l + 1);
	}
	((*toklist)[*tklp]).type = type;
	((*toklist)[*tklp]).line = line;
	(*tklp) ++;
	free(t);
}

/*
 * This is a small hack, in order to recognize strings like <stdio.h>
 * that may be found after #include or #import; with this modification,
 * one can rebuild a functional C code, including the cpp directives,
 * from the token list. This feature is not used anymore in bsc.
 */
#define HACK_NONE	0
#define HACK_SHARP	1
#define HACK_IMPORT	2

/*
 * This is the lexing function; it uses the file descriptor f as input.
 * This function is fully reentrant.
 */
struct token *lex(FILE *f)
{
	u8 buf[MEM_GRAN];
	size_t pbuf, ebuf;
	int cstat, nstat;
	int hackstate;
	char *ctok;
	int ltok, tklp;
	u8 c;
	struct token *toklist;
	long line;

	tklp = 0;
	pbuf = ebuf = 0;
	cstat = START;
	ltok = 0;
	line = 1;
	hackstate = HACK_NONE;
	do {
		if (pbuf == ebuf) {
			ebuf = fread(buf, 1, MEM_GRAN, f);
			pbuf = 0;
		}
		if (ebuf == 0) continue;
		c = buf[pbuf];
		if (c == '\n') line ++;
		nstat = tfm[c][cstat];
		if (isREQ(nstat)) switch (noMOD(nstat)) {
			case UNCLASS:
				fprintf(stderr, "bsc: illegal character '%c'\n", c);
				exit(1);
				break;
			case S_STNL:
				fprintf(stderr, "bsc: newline in string or character constant\n");
				exit(1);
				break;
			case ERROR:
			default:
				fprintf(stderr, "bsc: internal lexer error\n");
				fprintf(stderr, "bsc: please report bug to thomas.pornin\100ens.fr\n");
				exit(1);
				break;
		}
		if (!isFRZ(nstat)) {
			ctok = add_char(ctok, ltok ++, c);
			pbuf ++;
		}
		if (isSTO(nstat)) switch(hackstate) {
			case HACK_NONE:
				if (noMOD(nstat) == SHARP)
					hackstate = HACK_SHARP;
				break;
			case HACK_SHARP:
				if (noMOD(nstat) == NAME && ((ltok == 7 && !strncmp(ctok, "include", 7)) || (ltok == 6 && !strncmp(ctok, "import", 6))))
					hackstate = HACK_IMPORT;
				else if (noMOD(nstat) != NONE)
					hackstate = HACK_NONE;
				break;
			case HACK_IMPORT:
				if (noMOD(nstat) == LT) nstat = ST4;
				else if (noMOD(nstat) != NONE)
					hackstate = HACK_NONE;
				break;
			default:
				fprintf(stderr, "bsc: internal lexer error\n");
				fprintf(stderr, "bsc: please report bug to thomas.pornin\100ens.fr\n");
				exit(1);
				break;
		}
		if (isSTO(nstat)) {
			if (noMOD(nstat) != NONE)
				sto_token(ctok, ltok, noMOD(nstat), &toklist, &tklp, line);
			ltok = 0;
			nstat = START;
		}
		cstat = noMOD(nstat);
		assert(cstat < MAXSTATE);
	} while (ebuf != 0);
	sto_token(0, 0, NONE, &toklist, &tklp, line);
	return toklist;
}
