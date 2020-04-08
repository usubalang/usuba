/*
 * Functions that move data between the real world and the orthogonal space
 * (c) Thomas Pornin 1998
 */

#include "bsc.h"

/*
 * bsc_orth() will fill br[] with the orthogonal representation of
 * data[]. The nb_reg least significant bits of each data[j] contain
 * the relevant data, and br[] should be of size at least nb_reg
 * (br[0] will contain all most significant bits of the data[i],
 * among the nb_reg relevant bits; the most significant bits of br[]
 * refer to data[0], the least significant bits to data[nb_reg - 1])
 *
 * WARNING: data[] and br[] must NOT overlap
 */
void bsc_orth(unsigned long data[], int nb_reg, bsc_u br[])
{
	int i, j;

	for (i = 0; i < nb_reg; i ++) {
		br[i] = 0;
		for (j = 0; j < BSC_U_SIZE; j ++) {
			br[i] |= (((bsc_u)(((data[j]) & (1UL << (nb_reg - 1 - i))) != 0)) << (BSC_U_SIZE - 1 - j));
		}
	}
}

/*
 * bsc_unorth() does the opposite transformation of bsc_orth()
 */
void bsc_unorth(bsc_u br[], int nb_reg, unsigned long data[])
{
	int i, j;

	for (i = 0; i < BSC_U_SIZE; i ++) {
		data[i] = 0;
		for (j = 0; j < nb_reg; j ++) {
			data[i] |= (((unsigned long)(((br[j]) & (1UL << (BSC_U_SIZE - 1 - i))) != 0)) << (nb_reg - 1 - j));
		}
	}
}

/*
 * bsc_bm_l[] and bsc_bm_r[] are used by bsc_orth_sq(); they suppose
 * that bsc_u is an unsigned long, of size 64. This should also compile
 * (maybe with an harmless warning) if bsc_u is smaller.
 */
static bsc_u bsc_bm_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static bsc_u bsc_bm_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};

/*
 * bsc_orth_sq() handles the special case where the matrix is square;
 * and it does its job in place. It is much faster than bsc_orth()
 * and bsc_unorth(). It should be prefered over those two functions
 * whenever each data size is greater than about 6 or 7 bits
 *
 * bsc_orth_sq() is its own inverse.
 */
void bsc_orth_sq(bsc_u data[])
{
	int i, j, k, n;
	bsc_u u, v, x, y;

	for (i = 0; i < LOG_BSC_U_SIZE; i ++) {
		n = (1UL << i);
		for (j = 0; j < BSC_U_SIZE; j += (2 * n))
		    for (k = 0; k < n; k ++) {
			u = data[j + k] & bsc_bm_l[i];
			v = data[j + k] & bsc_bm_r[i];
			x = data[j + n + k] & bsc_bm_l[i];
			y = data[j + n + k] & bsc_bm_r[i];
			data[j + k] = u | (x >> n);
			data[j + n + k] = (v << n) | y;
		}
	}
}
