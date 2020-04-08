/*
 * dump.c  -- producing C code from an action list
 * (c) Thomas Pornin 1998
 */

#include "dump.h"
#include "mem.h"
#include "syntax.h"
#include <stdio.h>

#ifdef DEBUG
/*
 * dump_action_list(al) dumps the action list al on stderr
 */
void dump_action_list(struct action *al)
{
	long k;
	struct action a;

	for (k = 0; al[k].type != B_END; k ++) {
		a = al[k];
		switch (a.type) {
			case B_CREAT:
				fprintf(stderr, "CREAT: %05lx\n", a.r1);
				break;
			case B_ZAP:
				fprintf(stderr, "ZAP:   %05lx\n", a.r1);
				break;
			case B_XOR:
				fprintf(stderr, "XOR:   %05lx  %05lx  ->  %05lx\n", a.r1, a.r2, a.r3);
				break;
			case B_OR:
				fprintf(stderr, "OR:    %05lx  %05lx  ->  %05lx\n", a.r1, a.r2, a.r3);
				break;
			case B_AND:
				fprintf(stderr, "AND:   %05lx  %05lx  ->  %05lx\n", a.r1, a.r2, a.r3);
				break;
			case B_NOT:
				fprintf(stderr, "NOT:   %05lx  ->  %05lx\n", a.r1, a.r2);
				break;
			case B_COPY:
				fprintf(stderr, "COPY:  %05lx  ->  %05lx\n", a.r1, a.r2);
				break;
			default:
				fprintf(stderr, "bsc: rogue unallowed action %d\n", (int)(a.type));
				exit(1);
		}
	}
}
#endif

/*
 * dump_C() produces the C code implementing the action list; it also
 * produces the code necessary for inputs and outputs
 *
 * no code optimization is performed here
 */
void dump_C(FILE *f, char *fname, struct action *al,
	long inreg[], int irw, long outreg[], int orw)
{
	long k, m;
	int i;
	struct action a;
	int *r;

	fprintf(f, "#include \"bsc.h\"\n\n");
	fprintf(f, "void %s(bsc_u bsc_in[], bsc_u bsc_out[])\n", fname);
	fprintf(f, "{\n");
	/*
	 * Find the largest register number
	 */
	for (m = k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_XOR:
		case B_OR:
		case B_AND:
			if (al[k].r3 > m) m = al[k].r3;
		case B_NOT:
		case B_COPY:
			if (al[k].r2 > m) m = al[k].r2;
			if (al[k].r1 > m) m = al[k].r1;
	}
	for (i = 0; i < irw; i ++) if (m < inreg[i]) m = inreg[i];
	for (i = 0; i < orw; i ++) if (m < outreg[i]) m = outreg[i];
	m ++;
	/*
	 * Find which registers are used
	 */
	r = getmem(m * sizeof(int));
	for (k = 0; k < m; k ++) r[k] = 0;
	for (k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_XOR:
		case B_OR:
		case B_AND:
			r[al[k].r3] = 1;
		case B_NOT:
		case B_COPY:
			r[al[k].r2] = 1;
			r[al[k].r1] = 1;
	}
	for (i = 0; i < irw; i ++) r[inreg[i]] = 1;
	for (i = 0; i < orw; i ++) r[outreg[i]] = 1;
	/*
	 * Declare the registers
	 */
	for (k = 0; k < m; k ++) if (r[k])
		fprintf(f, "\tbsc_u r%05lx;\n", k);
	fprintf(f, "\n");
	for (i = 0; i < irw; i ++)
		fprintf(f, "\tr%05lx = bsc_in[%d];\n", inreg[i], i);
	if (r[0]) fprintf(f, "\tr00000 = 0;\n");
	if (r[1]) fprintf(f, "\tr00001 = ALL_ONE;\n");
	freemem(r);
	fprintf(f, "\n");
	/*
	 * generate the instructions
	 */
	for (k = 0; (a = al[k]).type != B_END; k ++) switch (a.type) {
		case B_XOR:
			fprintf(f, "\tr%05lx = r%05lx ^ r%05lx;\n", a.r3, a.r1, a.r2);
			break;
		case B_OR:
			fprintf(f, "\tr%05lx = r%05lx | r%05lx;\n", a.r3, a.r1, a.r2);
			break;
		case B_AND:
			fprintf(f, "\tr%05lx = r%05lx & r%05lx;\n", a.r3, a.r1, a.r2);
			break;
		case B_NOT:
			fprintf(f, "\tr%05lx = ~r%05lx;\n", a.r2, a.r1);
			break;
		case B_COPY:
			fprintf(f, "\tr%05lx = r%05lx;\n", a.r2, a.r1);
			break;
	}
	fprintf(f, "\n");
	for (i = 0; i < orw; i ++)
		fprintf(f, "\tbsc_out[%d] = r%05lx;\n", i, outreg[i]);
	fprintf(f, "}\n");
}
