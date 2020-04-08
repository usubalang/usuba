/*
 * mem.c  -- generic memory (re)allocations for bsc
 * (c) Thomas Pornin 1998
 */

#include "mem.h"
#include "types.h"
#include <string.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>

/*
 * This function is equivalent to a malloc(), but will display an error
 * message and exit if the wanted memory is not available
 */
void *getmem(size_t x)
{
	void *m;

	m = malloc(x);
	if (m == 0) {
		fprintf(stderr, "malloc() failed: out of memory\n");
		exit(1);
	}
	return m;
}

/*
 * This function is equivalent to a realloc(); if the realloc() call
 * fails, it will try a malloc() and a memcpy(). If not enough memory is
 * available, the program exits with an error message
 */
void *incmem(void *m, size_t x, size_t nx)
{
	void *nm;

	if (!(nm = realloc(m, nx))) {
		if (x > nx) x = nx;
		nm = getmem(nx);
		memcpy(nm, m, x);
		free(m);
	}
	return nm;
}

/*
 * This function is a wrapper around free()
 */
void freemem(void *x)
{
	free(x);
}
