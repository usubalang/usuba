/*
 * mem.h  -- include file for mem.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_MEM_H__
#define BSC_MEM_H__

#include <sys/types.h>
#include "types.h"

void *getmem(size_t);
void *incmem(void *, size_t, size_t);
void freemem(void *);

/* for optimization, MEM_GRAN should be a power of 2 */
#define MEM_GRAN 1024

#endif /* BSC_MEM_H__ */
