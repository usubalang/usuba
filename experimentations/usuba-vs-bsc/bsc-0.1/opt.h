/*
 * opt.h  -- include file for opt.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_OPT_H__
#define BSC_OPT_H__

#include "types.h"
#include "syntax.h"

void zap_redudancy(struct action *, long *, int, long *, int);

#endif /* BSC_OPT_H__ */
