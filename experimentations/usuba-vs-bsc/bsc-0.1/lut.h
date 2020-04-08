/*
 * lut.h  -- include file for lut.c
 * (c) Thomas Pornin 1998
 */

#ifndef BSC_LUT_H__
#define BSC_LUT_H__

#include "syntax.h"

void def_lut(struct symbol *, struct num_list);
void def_ext(struct symbol *, struct num_list);

#endif /* BSC_LUT_H__ */
