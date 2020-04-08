/*
 * opt.c  -- optimization of an action list, for bsc
 * (c) Thomas Pornin 1998
 */

#include "mem.h"
#include "types.h"
#include "opt.h"
#include "syntax.h"
#include "dump.h"
#include <stdio.h>

/*
 * separate_registers() uses the B_CREAT and B_ZAP directives to
 * separate different instances of a register (each time a function
 * is called, the same registers are used -- this function corrects
 * this fact, which allows some more optimizations)
 */
static long separate_registers(struct action *al)
{
	long m, k, l, u;
	long *r;

	for (m = 1, k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_XOR:
		case B_OR:
		case B_AND:
			if (al[k].r3 > m) m = al[k].r3;
		case B_NOT:
		case B_COPY:
			if (al[k].r2 > m) m = al[k].r2;
		case B_CREAT:
		case B_ZAP:
			if (al[k].r1 > m) m = al[k].r1;
	}
	m ++;
	r = getmem(m * sizeof(long));
	for (k = 0; k < m; k ++) r[k] = -1;
	for (l = k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_ZAP:
			r[al[k].r1] = m ++;
			break;
		case B_XOR:
		case B_OR:
		case B_AND:
			if ((u = r[al[k].r3]) != -1) al[k].r3 = u;
		case B_NOT:
		case B_COPY:
			if ((u = r[al[k].r2]) != -1) al[k].r2 = u;
			if ((u = r[al[k].r1]) != -1) al[k].r1 = u;
			if (l != k) al[l] = al[k];
			l ++;
	}
	al[l].type = B_END;
	freemem(r);
	return m;
}

/*
 * zap_redudancy() calls separate_registers(), and then deletes all
 * unnecessary copies; with this, permutations are free
 */
void zap_redudancy(struct action *al,
	long inreg[], int irw, long outreg[], int orw)
{
	long l, k, m, s, t, u, v;
	long *r, *r2, *wt;
	int i;

	m = separate_registers(al);
	r = getmem(m * sizeof(long));
	wt = getmem(m * sizeof(long));
	for (k = 0; k < m; k ++) wt[k] = r[k] = -1;
	/* r[k] contains a potential equivalent for the register k;
	   r2[] is the inverse array (when r[k] != -1, we have r2[r[k]] = k */
	for (k = 0; al[k].type != B_END; k ++) if (al[k].type == B_COPY) {
		if (r[al[k].r1] == -1) r[al[k].r1] = al[k].r2;
		else if (r[al[k].r2] == -1) r[al[k].r2] = al[k].r1;
	}
	r2 = getmem(m * sizeof(long));
	for (k = 0; k < m; k ++) r2[k] = -1;
	for (k = 0; k < m; k ++) if (r[k] != -1) r2[r[k]] = k;
	/*
	 * We identify all equivalence that should not be. For A and B
	 * to be the same register, there must be a write to B between
	 * every read from B and any preceding write to A, and also the
	 * other way round (between a write to B and a read from A, there
	 * must be a write to A)
	 */
	for (t = 0, k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_XOR:
		case B_OR:
		case B_AND:
			if ((v = r[u = al[k].r1]) != -1) {
				if (wt[v] > wt[u]) {
					r[u] = -1;
					if (r[v] == u) r[v] = -1;
				}
			}
			if ((v = r[u = al[k].r2]) != -1) {
				if (wt[v] > wt[u]) {
					r[u] = -1;
					if (r[v] == u) r[v] = -1;
				}
			}
			if ((v = r2[u = al[k].r1]) != -1) {
				if (wt[v] > wt[u]) {
					r2[u] = -1;
					if (r2[v] == u) r2[v] = -1;
				}
			}
			if ((v = r2[u = al[k].r2]) != -1) {
				if (wt[v] > wt[u]) {
					r2[u] = -1;
					if (r2[v] == u) r[v] = -1;
				}
			}
			wt[al[k].r3] = t ++;
			break;
		case B_NOT:
		case B_COPY:
			if ((v = r[u = al[k].r1]) != -1) {
				if (wt[v] > wt[u]) {
					r[u] = -1;
					if (r[v] == u) r[v] = -1;
				}
			}
			if ((v = r2[u = al[k].r1]) != -1) {
				if (wt[v] > wt[u]) {
					r2[u] = -1;
					if (r2[v] == u) r2[v] = -1;
				}
			}
			wt[al[k].r2] = t ++;
			break;
	}
	freemem(wt);
	for (k = 0; k < m; k ++) if (r[k] != -1 && r2[r[k]] == -1) r[k] = -1;
	freemem(r2);
	/*
	 * Here we propagate all equivalence by transitivity
	 */
	for (k = 0; k < m; k ++) if (r[k] != -1) {
		for (s = k; r[s] != -1 && r[s] < m; s = r[s] - m) r[s] += m;
		for (t = k; r[t] >= m; t = v) {
			v = r[t] - m; r[t] = s;
		}
		r[s] = -1;
	}
	/* if the register 0 has been found equivalent to others, make
	   all of them equivalent to 0 */
	if (r[0] != -1) {
		for (k = 0; k < m; k ++) if (r[k] == r[0]) r[k] = 0;
		r[r[0]] = 0;
	}
	/* same for register 1 */
	if (r[1] != -1) {
		for (k = 0; k < m; k ++) if (r[k] == r[1]) r[k] = 1;
		r[r[1]] = 1;
	}
	/* apply all found equivalences */
	for (k = 0; al[k].type != B_END; k ++) switch (al[k].type) {
		case B_XOR:
		case B_OR:
		case B_AND:
			if ((u = r[al[k].r3]) != -1) al[k].r3 = u;
		case B_NOT:
		case B_COPY:
			if ((u = r[al[k].r2]) != -1) al[k].r2 = u;
			if ((u = r[al[k].r1]) != -1) al[k].r1 = u;
	}
	for (l = k = 0; al[k].type != B_END; k ++) {
		if (al[k].type != B_COPY || al[k].r1 != al[k].r2) {
			if (l != k) al[l] = al[k];
			l ++;
		}
	}
	al[l].type = B_END;
	/* do not forget the input and output registers */
	for (i = 0; i < irw; i ++) if ((u = r[inreg[i]]) != -1) inreg[i] = u;
	for (i = 0; i < orw; i ++) if ((u = r[outreg[i]]) != -1) outreg[i] = u;
	freemem(r);
}
