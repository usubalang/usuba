/*
 * lut.c  -- bitslice representation of lookup tables
 * (c) Thomas Pornin 1998
 */

#include "lut.h"
#include "syntax.h"
#include "mem.h"
#include <stdio.h>

static struct action *local_action_list;
static int lalp;

/*
 * This function adds an action at the end of the local action list
 */
static void aal(struct action n)
{
	local_action_list = add_action(local_action_list, lalp ++, n);
}

/*
 * This function initializes the local action list
 */
static void init_aal(void)
{
	local_action_list = getmem(MEM_GRAN * sizeof(struct action));
	lalp = 0;
}

/*
 * This is a fake multiplexer: it generates actions that perform
 * the following calculation: rd = r0 ^ (r1 & rc)
 * (rc choses between r0 and r0^r1)
 */
static void fake_mux(long r0, long r1, long rc, long rd)
{
	struct action a;
	long t;

	new_regs(&t, 1);
	a.type = B_CREAT; a.r1 = t; aal(a);
	a.type = B_AND; a.r1 = rc; a.r2 = r1; a.r3 = t; aal(a);
	a.type = B_XOR; a.r1 = r0; a.r2 = t; a.r3 = rd; aal(a);
	a.type = B_ZAP; a.r1 = t; aal(a);
}

/*
 * This function generates the action that are used to evaluate
 * a lookup table; it uses the fake multiplexer fake_mux()
 */
void def_lut(struct symbol *f, struct num_list n)
{
	int i, j, k, l, m, si, so;
	long *t, *r, *u;
	struct action a;
	struct num_list n2;

	init_aal();
	/* n2 is a copy of n, that we modify, to make it compatible
	   with fake_mux */
	n2.data = getmem(n.length * sizeof(unsigned long));
	n2.length = n.length;
	for (i = 0; i < n.length; i ++) n2.data[i] = n.data[i];
	si = f->width[1];
	so = f->width[0];
	for (i = 0; i < si; i ++) for (j = 0; j < n2.length; j ++) {
		if (j & (1 << i)) n2.data[j] ^= n2.data[j ^ (1 << i)];
	}
	u = getmem(si * sizeof(long));
	new_regs(u, si);
	for (j = 0; j < si; j ++) {
		a.type = B_ARG; a.r1 = u[j]; aal(a);
	}
	r = getmem(so * sizeof(long));
	new_regs(r, so);
	for (j = 0; j < so; j ++) {
		a.type = B_RET; a.r1 = r[j]; aal(a);
	}
	t = getmem((1 << si) * sizeof(long));
	for (i = 0; i < so; i ++) {
		new_regs(t, (1 << si));
		for (j = 0; j < (1 << si); j ++) {
			a.type = B_CREAT; a.r1 = t[j]; aal(a);
		}
		for (l = 0, k = 0; k < (1 << si); k += 2) {
			fake_mux((n2.data[k] & (1 << (so - 1 - i))) != 0, (n2.data[k + 1] & (1 << (so - 1 - i))) != 0, u[si - 1], t[l ++]);
		}
		m = 0;
		for (j = 1; j < si; j ++) {
			for (k = 0; k < (1 << (si - j)); k += 2) {
				fake_mux(t[m + k], t[m + k + 1], u[si - 1 - j], t[l ++]);
			}
			m += (1 << (si - j));
		}
		a.type = B_COPY; a.r1 = t[l - 1]; a.r2 = r[i]; aal(a);
		for (j = 0; j < (1 << si); j ++) {
			a.type = B_ZAP; a.r1 = t[j]; aal(a);
		}
	}
	a.type = B_ENDF; aal(a);
	f->u.def = local_action_list;
	freemem(t);
	freemem(r);
	freemem(n2.data);
}

/*
 * Same as def_lut, for an extraction (a permutation)
 */
void def_ext(struct symbol *f, struct num_list n)
{
	int i, si, so;
	long *t, *u;
	struct action a;

	init_aal();
	si = f->width[1];
	so = f->width[0];
	t = getmem(si * sizeof(long));
	new_regs(t, si);
	for (i = 0; i < si; i ++) {
		a.type = B_ARG; a.r1 = t[i]; aal(a);
	}
	u = getmem(so * sizeof(long));
	new_regs(u, so);
	for (i = 0; i < so; i ++) {
		a.type = B_RET; a.r1 = u[i]; aal(a);
	}
	for (i = 0; i < so; i ++) {
		if (n.data[i] < 0 || n.data[i] >= si) {
			fprintf(stderr, "bsc: out of bounds permutation: '%s'\n", f->name);
			exit(1);
		}
		a.type = B_COPY; a.r1 = t[n.data[i]]; a.r2 = u[i]; aal(a);
	}
	a.type = B_ENDF; aal(a);
	f->u.def = local_action_list;
	freemem(u);
	freemem(t);
}
