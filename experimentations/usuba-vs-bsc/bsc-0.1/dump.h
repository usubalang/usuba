/*
 * dump.h  -- include file for dump.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_DUMP_H__
#define BSC_DUMP_H__

#include "syntax.h"

#ifdef DEBUG
void dump_action_list(struct action *);
#endif
void dump_C(FILE *, char *, struct action *, long *, int, long *, int);

#endif /* BSC_DUMP_H__ */
