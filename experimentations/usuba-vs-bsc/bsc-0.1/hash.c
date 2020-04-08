/*
 * hash.c  -- hash tables for bsc
 * (c) Thomas Pornin 1998
 */

#include "hash.h"
#include "mem.h"
#include "types.h"
#include <string.h>

/*
 * hash_string() is a sample hash functions that is supposed to work
 * well on strings. It includes one multiplication per char hashed, so
 * another quicker hash function such as some md5 derivative might be
 * prefered
 */
u32 hash_string(char *s)
{
	u32 h = 0;

	for (; *s; s ++) h = 65599 * (h + (u32)(*s));
	return h;
}

/*
 * struct hash_item is the basic data type to internally handle hash tables
 */
struct hash_item {
	void *data;
	struct hash_item *next;
};

/*
 * This function adds an entry to the struct hash_item list
 */
static struct hash_item *add_entry(struct hash_item *blist, void *data)
{
	struct hash_item *t = getmem(sizeof(struct hash_item));

	t->data = data;
	t->next = blist;
	return t;
}

/*
 * This function finds a struct hash_item in a list, using the
 * comparison function provided as cmpdata (*cmpdata() returns
 * non-zero if the two parameters are to be considered identical).
 *
 * It returns 0 if the item is not found.
 */
static struct hash_item *get_entry(struct hash_item *blist, void *data, int (*cmpdata)(void *, void *))
{
	struct hash_item *t = blist;

	while (t) {
		if ((*cmpdata)(data, t->data)) return t;
		t = t->next;
	}
	return 0;
}

/*
 * This function creates a new hashtable, with the hashing and comparison
 * functions given as parameters
 */
struct HT *newHT(u32 n, int (*cmpdata)(void *, void *), u32 (*hash)(void *))
{
	struct HT *t = getmem(sizeof(struct HT));
	u32 i;

	t->lists = getmem(n * sizeof(struct hash_item *));
	for (i = 0; i < n; i ++) t->lists[i] = 0;
	t->nb_lists = n;
	t->cmpdata = cmpdata;
	t->hash = hash;
	return t;
}

/*
 * This functions adds a new entry in the hashtable ht
 */
int putHT(struct HT *ht, void *data)
{
	u32 h;

	h = ((*(ht->hash))(data)) % ht->nb_lists;
	if (get_entry(ht->lists[h], data, ht->cmpdata))
		return 1;
	ht->lists[h] = add_entry(ht->lists[h], data);
	return 0;
}

/*
 * This function finds the entry corresponding to *data in the
 * hashtable ht (using the comparison function given as argument
 * to newHT)
 */
void *getHT(struct HT *ht, void *data)
{
	u32 h;
	struct hash_item *t;

	h = ((*(ht->hash))(data)) % ht->nb_lists;
	if ((t = get_entry(ht->lists[h], data, ht->cmpdata)) == 0)
		return 0;
	return (t->data);
}

/*
 * This function duplicates a given hash table; the data is not copied
 */
struct HT *copyHT(struct HT *ht)
{
	struct HT *nht = newHT(ht->nb_lists, ht->cmpdata, ht->hash);
	struct hash_item *t;
	int i, j;

	for (i = 0; i < nht->nb_lists; i ++) {
		j = 0;
		t = ht->lists[i];
		while (t) {
			t = t->next;
			j ++;
		}
		if (j != 0) {
			nht->lists[i] = getmem(j * sizeof(struct hash_item));
			memcpy(nht->lists[i], ht->lists[i], j * sizeof(struct hash_item));
		}
	}
	return nht;
}
