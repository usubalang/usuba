/*
 * hash.h  -- include file for hash.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_HASH_H__
#define BSC_HASH_H__

#include "types.h"

struct hash_item;

struct HT {
	struct hash_item **lists;
	u32 nb_lists;
	int (*cmpdata)(void *, void *);
	u32 (*hash)(void *);
};

u32 hash_string(char *);
struct HT *newHT(u32, int (*)(void *, void *), u32 (*)(void *));
int putHT(struct HT *, void *);
void *getHT(struct HT *, void *);
struct HT *copyHT(struct HT *);

#endif /* BSC_HASH_H__ */
