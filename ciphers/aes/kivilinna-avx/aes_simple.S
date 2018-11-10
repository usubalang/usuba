/* aes_asm_bitslice_avx.S
 *
 * Copyright © 2012-2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */
/*
 *
 * Based on article "Faster and Timing-Attach Resistant AES-GCM" by
 * Emilia Käsper and implementation by Peter Schwabe, available at
 * http://cryptojedi.org/crypto/index.shtml#aesbs
 *
 * Original source header:
 * # Author: Peter Schwabe, ported from an assembly implementation by Emilia \
 * Käsper
 * # Date: 2009-03-19
 * # Public domain
 */

#ifdef __x86_64

.file "aes_bitslice_avx.S"


/*
 * ctx: u128 bitsliced_keysched[AES_MAX_NR + 1][8];
 *      aesctx: uint32 keysched[(AES_MAX_NR + 1) * AES_MAX_NB];
 *	        uint32 invkeysched[(AES_MAX_NR + 1) * AES_MAX_NB];
 *	        int Nr;
 */

#define AES_MAX_NR 14
#define AES_MAX_NK 8
#define AES_MAX_NB 4

#define bs_keysched	0
#define keysched	(16 * (AES_MAX_NR + 1) * 8)
#define invkeysched	(keysched + ((AES_MAX_NR + 1) * AES_MAX_NB * 4))
#define nr		(invkeysched + ((AES_MAX_NR + 1) * AES_MAX_NB * 4))

/* registers */
#define CTX %rdi

/***********************************************************************
 * 8-way AVX bitsliced AES
 ***********************************************************************/

.data
.align 16

.Lbswap128_mask:
	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

.Lshiftrow_shuf:
	.byte 0x00, 0x05, 0x0a, 0x0f, 0x04, 0x09, 0x0e, 0x03
	.byte 0x08, 0x0d, 0x02, 0x07, 0x0c, 0x01, 0x06, 0x0b

.Lshiftrow_inv_shuf:
	.byte 0x00, 0x0d, 0x0a, 0x07, 0x04, 0x01, 0x0e, 0x0b
	.byte 0x08, 0x05, 0x02, 0x0f, 0x0c, 0x09, 0x06, 0x03

.Lror_byte_1_shuf:
	.byte 0x01, 0x02, 0x03, 0x00, 0x05, 0x06, 0x07, 0x04
	.byte 0x09, 0x0a, 0x0b, 0x08, 0x0d, 0x0e, 0x0f, 0x0c

.Lror_byte_2_shuf:
	.byte 0x02, 0x03, 0x00, 0x01, 0x06, 0x07, 0x04, 0x05
	.byte 0x0a, 0x0b, 0x08, 0x09, 0x0e, 0x0f, 0x0c, 0x0d

.Laffinetransform_const:
	.byte 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63
	.byte 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63

.align 4

.L_bs0:
	.long 0x55555555
.L_bs1:
	.long 0x33333333
.L_bs2:
	.long 0x0f0f0f0f

.text

/*
 * input bitslicing/output debitslicing
 */
#define swapmove(a, b, n, m, t) \
	vpsrld	$n, b, t; \
	vpxor	a, t, t; \
	vpand	m, t, t; \
	vpxor	t, a, a; \
	vpslld	$n, t, t; \
	vpxor	t, b, b;

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7, t0, t1) \
	vbroadcastss .L_bs0,	t0; \
	swapmove(x7, x6, 1, t0, t1); \
	swapmove(x5, x4, 1, t0, t1); \
	swapmove(x3, x2, 1, t0, t1); \
	swapmove(x1, x0, 1, t0, t1); \
	\
	vbroadcastss .L_bs1,	t0; \
	swapmove(x7, x5, 2, t0, t1); \
	swapmove(x6, x4, 2, t0, t1); \
	swapmove(x3, x1, 2, t0, t1); \
	swapmove(x2, x0, 2, t0, t1); \
	\
	vbroadcastss .L_bs2,	t0; \
	swapmove(x7, x3, 4, t0, t1); \
	swapmove(x6, x2, 4, t0, t1); \
	swapmove(x5, x1, 4, t0, t1); \
	swapmove(x4, x0, 4, t0, t1);

/*
 * addroundkey
 */
#define addroundkey(x0, x1, x2, x3, x4, x5, x6, x7, reg_mem) \
	vpxor	0*16(reg_mem), x0, x0; \
	vpxor	1*16(reg_mem), x1, x1; \
	vpxor	2*16(reg_mem), x2, x2; \
	vpxor	3*16(reg_mem), x3, x3; \
	vpxor	4*16(reg_mem), x4, x4; \
	vpxor	5*16(reg_mem), x5, x5; \
	vpxor	6*16(reg_mem), x6, x6; \
	vpxor	7*16(reg_mem), x7, x7;

/*
 * shiftrow / shiftrow_inv
 */
#define shiftrow(x0, x1, x2, x3, x4, x5, x6, x7, t0) \
	vmovdqa .Lshiftrow_shuf, t0; \
	vpshufb t0, x0, x0; \
	vpshufb t0, x1, x1; \
	vpshufb t0, x2, x2; \
	vpshufb t0, x3, x3; \
	vpshufb t0, x4, x4; \
	vpshufb t0, x5, x5; \
	vpshufb t0, x6, x6; \
	vpshufb t0, x7, x7;

#define shiftrow_inv(x0, x1, x2, x3, x4, x5, x6, x7, t0) \
	vmovdqa .Lshiftrow_inv_shuf, t0; \
	vpshufb t0, x0, x0; \
	vpshufb t0, x1, x1; \
	vpshufb t0, x2, x2; \
	vpshufb t0, x3, x3; \
	vpshufb t0, x4, x4; \
	vpshufb t0, x5, x5; \
	vpshufb t0, x6, x6; \
	vpshufb t0, x7, x7;

/*
 * mixcolumns
 */
#define mixcolumns(x0, x1, x2, x3, x4, x5, x6, x7, \
		   t0, t1, t2, t3, t4, t5, t6, t7) \
	vmovdqa .Lror_byte_1_shuf, t6; \
	vmovdqa .Lror_byte_2_shuf, t7; \
	\
	vpshufb	t6, x0, t0; \
	vpxor	x0, t0, x0; \
	\
	vpshufb	t6, x1, t1; \
	vpxor	x1, t1, x1; \
	\
	vpshufb	t6, x2, t2; \
	vpxor	x2, t2, x2; \
	\
	vpshufb	t6, x3, t3; \
	vpxor	x3, t3, x3; \
	\
	vpxor	x0, t1, t1; \
	vpshufb t7, x0, x0; \
	\
	vpxor	x1, t2, t2; \
	vpshufb t7, x1, x1; \
	\
	vpxor	x2, t3, t3; \
	vpshufb t7, x2, x2; \
	vpxor	x2, t2, x2; \
	\
	vpshufb	t6, x7, t2; \
	vpxor	x7, t2, x7; \
	\
	vpshufb	t6, x4, t4; \
	vpxor	x4, t4, x4; \
	\
	vpshufb	t6, x5, t5; \
	vpxor	x5, t5, x5; \
	\
	vpshufb	t6, x6, t6; \
	vpxor	x6, t6, x6; \
	\
	vpxor	x3, t4, t4; \
	vpshufb	t7, x3, x3; \
	\
	vpxor	x4, t5, t5; \
	vpshufb	t7, x4, x4; \
	\
	vpxor	x5, t6, t6; \
	vpshufb	t7, x5, x5; \
	vpxor	x5, t5, x5; \
	\
	vpxor	x6, t2, t2; \
	vpshufb	t7, x6, x6; \
	vpxor	x6, t6, x6; \
	\
	vpxor	x7, t0, t0; \
	vpxor	x0, t0, x0; \
	\
	vpxor	x7, t1, t1; \
	vpxor	x1, t1, x1; \
	\
	vpxor	x7, t3, t3; \
	vpxor	x3, t3, x3; \
	\
	vpxor	x7, t4, t4; \
	vpxor	x4, t4, x4; \
	\
	vpshufb	t7, x7, x7; \
	vpxor	x7, t2, x7;

/*
 * mixcolumns_inv
 *
 * InvMixColumns optimization from "The Design of Rijndael: AES - The Advanced
 * Encryption Standard", 4.1.3.
 *
 * mix-columns: c(x)
 * inv-mix-columns: d(x)
 *
 * d(x) = {4*x² + 5} * c(x)
 */
#define mixcolumns_inv(x0, x1, x2, x3, x4, x5, x6, x7, \
		       t0, t1, t2, t3, t4, t5, t6, t7) \
	vmovdqa	.Lror_byte_2_shuf, t7; \
	\
	vpshufb	t7, x0, t0; \
	vpxor	x0, t0, t0; \
	\
	vpshufb	t7, x1, t1; \
	vpxor	x1, t1, t1; \
	\
	vpshufb	t7, x2, t2; \
	vpxor	x2, t2, t2; \
	\
	vpshufb	t7, x3, t3; \
	vpxor	x3, t3, t3; \
	\
	vpshufb	t7, x4, t4; \
	vpxor	x4, t4, t4; \
	\
	vpshufb	t7, x5, t5; \
	vpxor	x5, t5, t5; \
	\
	vpshufb	t7, x6, t6; \
	vpxor	x6, t6, t6; \
	\
	vpshufb	t7, x7, t7; \
	vpxor	x7, t7, t7; \
	\
	vpxor	x0, t6, x0; \
	\
	vpxor	x1, t6, x1; \
	vpxor	x1, t7, x1; \
	\
	vpxor	x2, t0, x2; \
	vpxor	x2, t7, x2; \
	\
	vpxor	x3, t1, x3; \
	vpxor	x3, t6, x3; \
	\
	vpxor	x4, t2, x4; \
	vpxor	x4, t6, x4; \
	vpxor	x4, t7, x4; \
	\
	vpxor	x5, t3, x5; \
	vpxor	x5, t7, x5; \
	\
	vpxor	x6, t4, x6; \
	\
	vpxor	x7, t5, x7; \
	\
	mixcolumns(x0, x1, x2, x3, x4, x5, x6, x7, \
		   t0, t1, t2, t3, t4, t5, t6, t7);

/*
 * subbytes / subbytes_inv
 */

/*
 * gf(2^4) multiplicative inverse, generated using genetic-algorithm 4-bit sbox
 * builder + reordered and tuned by hand. (crappy hack that generated this by
 * pure luck out of randomness, in other words, don't ask).
 */
#define gf16_inv(x0, x1, x2, x3, t0, t1, t2, t3) \
	vpand	x0, x3, t1; \
	vpxor	x1, x0, x0; \
	vpand	x2, x1, t2; \
	vpor	t1, t2, t0; \
	vpxor	x1, t2, x1; \
	\
	vpxor	x2, x3, x3; \
	vpor	x0, x2, t3; \
	vpor	x3, t2, t2; \
	vpand	x3, t0, t0; \
	vpxor	t0, x2, x2; \
	\
	vpand	t2, x0, x0; \
	vpxor	x3, t0, t0; \
	vpxor	t1, t2, x3; \
	vpor	x0, x1, t2; \
	\
	vpxor	x3, t2, x1; \
	vpand	x0, t0, t0; \
	vpor	t0, t1, t1; \
	vpxor	t1, t3, x0;

/* gf(2^4) multiplication, a * (a+x) => o */
#define gf16_mult_a_ax(a0, a1, a2, a3, x0, x1, x2, x3, \
		       o0, o1, p0, p1, s0, s1, r0, r1) \
	/* gf4_add_ax_ax(&a[0], &x[0], &s[0]); \
	 * gf4_add(&a[0], &a[2], &r[0]); */ \
	vpxor	a0, a2, r0; \
	vpxor	x0, r0, s0; \
	vpxor	x2, s0, s0; \
	vpxor	a1, a3, r1; \
	vpxor	x1, r1, s1; \
	vpxor	x3, s1, s1; \
	\
	/* gf4_mult(&s[0], &r[0], &p[0]) */ \
	vpand	s1, r1, p0; \
	vpand	s0, r1, p1; \
	vpxor	p0, p1, p1; \
	vpand	s0, r0, r1; \
	vpand	s1, r0, r0; \
	vpxor	r0, p1, p1; \
	vpxor	r1, p0, p0; \
	\
	/* gf4_multi_gf4_mult_fii_a_ax(&a[2], &x[2], &o[0]); */ \
	vpand	a2, x3, o0; \
	vpand	a3, x2, o1; \
	vpxor	o0, o1, s0; \
	vpandn	a3, x3, o0; \
	vpxor	o0, s0, o0; \
	vpandn	a2, x2, o1; \
	vpxor	o1, s0, o1; \
	\
	/* gf4_mult_a_ax(&a[0], &x[0], &r[0]); */ \
	vpandn	a0, x0, r0; \
	vpandn	a1, x1, r1; \
	vpxor	r1, r0, r0; \
	vpand	x1, a0, s0; \
	vpxor	r1, s0, r1; \
	vpand	x0, a1, s1; \
	vpxor	r1, s1, r1; \
	\
	/* gf4_add(&s[0], &r[0], &o[0]); */ \
	vpxor	r0, o0, o0; \
	vpxor	r1, o1, o1; \
	\
	/* gf4_add(&s[0], &r[0], &p[0]); */ \
	vpxor	r0, p0, p0; \
	vpxor	r1, p1, p1;

/*
 * two gf(2^4) multiplications combined,
 *  y * x[0..3] => x[0..3]
 *  y * x[4..7] => x[4..7]
 */
#define gf16_mult_2(y0, y1, y2, y3, x0, x1, x2, x3, x4, x5, x6, x7, \
		    r0, r1, s0, s1) \
	/* gf4_mult(&y[0], &x[0], &s[0]); */ \
	vpand	y1, x1, s1; \
	vpand	y0, x0, s0; \
	vpxor	s1, s0, s0; \
	vpand	y0, x1, r0; \
	vpxor	r0, s1, s1; \
	vpand	y1, x0, r0; \
	vpxor	r0, s1, s1; \
	\
	/* \
	 * gf4_add(&x[0], &x[2], &r[0]); \
	 * gf4_add(&y[0], &y[2], &y[0]); \
	 */ \
	/* \
	 * note: y[0] is needed later, but we are running out of registers. \
	 * However y[0] can be restored with "gf4_add(&y[0], &y[2], &y[0])" \
	 * later on. \
	 * TODO: Investigate if using stack as temporary storage is faster. \
	 */ \
	vpxor	x0, x2, r0; \
	vpxor	x1, x3, r1; \
	vpxor	y2, y0, y0; \
	vpxor	y3, y1, y1; \
	\
	/* gf4_mult(&r[0], &y[0], &x[0]); */ \
	vpand	r1, y1, x1; \
	vpand	r0, y0, x0; \
	vpxor	x1, x0, x0; \
	vpand	y1, r0, r0; \
	vpxor	r0, x1, x1; \
	vpand	y0, r1, r1; \
	vpxor	r1, x1, x1; \
	\
	/* gf4_multi_gf4_mult_fii(&y[2], &x[2], &r[0]); */ \
	vpand	x2, y3, r0; \
	vpand	x3, y2, r1; \
	vpxor	r1, r0, r0; \
	vpand	y2, x2, x2; \
	vpand	y3, x3, x3; \
	vpxor	x2, r0, r1; \
	vpxor	x3, r0, r0; \
	\
	/* gf4_add(&x[0], &s[0], &x[2]); \
	 * gf4_add(&r[0], &s[0], &x[0]); */ \
	vpxor	x0, s0, x2; \
	vpxor	x1, s1, x3; \
	vpxor	r0, s0, x0; \
	vpxor	r1, s1, x1; \
	\
	/* gf4_add(&x[4], &x[6], &r[0]); */ \
	vpxor	x4, x6, r0; \
	vpxor	x5, x7, r1; \
	\
	/* gf4_mult(&r[0], &y[0], &s[0]); */ \
	vpand	r1, y1, s1; \
	vpand	r0, y0, s0; \
	vpxor	s1, s0, s0; \
	vpand	y1, r0, r0; \
	vpxor	r0, s1, s1; \
	vpand	y0, r1, r1; \
	vpxor	r1, s1, s1; \
	\
	/* restore original y[0]. */ \
	/* gf4_add(&y[0], &y[2], &y[0]); */ \
	vpxor	y2, y0, y0; \
	vpxor	y3, y1, y1; \
	\
	/* gf4_multi_gf4_mult_fii(&y[2], &x[6], &r[0]); */ \
	vpand	x6, y3, r0; \
	vpand	x7, y2, r1; \
	vpxor	r1, r0, r0; \
	vpand	x6, y2, x6; \
	vpand	x7, y3, x7; \
	vpxor	x6, r0, r1; \
	vpxor	x7, r0, r0; \
	\
	/* gf4_mult(&y[0], &x[4], &y[2]); */ \
	vpand	x5, y1, y3; \
	vpand	x4, y0, y2; \
	vpxor	y3, y2, y2; \
	vpand	x4, y1, x4; \
	vpxor	x4, y3, y3; \
	vpand	x5, y0, x5; \
	vpxor	x5, y3, y3; \
	\
	/* gf4_add(&r[0], &y[2], &x[4]); \
	 * gf4_add(&s[0], &y[2], &x[6]); */ \
	vpxor	r0, y2, x4; \
	vpxor	r1, y3, x5; \
	vpxor	s0, y2, x6; \
	vpxor	s1, y3, x7;

#define gf256_inv(x0, x1, x2, x3, x4, x5, x6, x7, \
		  g0, g1, g2, g3, d0, d1, d2, d3) \
	/* input in x0..7 */ \
	gf16_mult_a_ax(x0, x1, x2, x3, x4, x5, x6, x7, \
		       g0, g1, g2, g3, d0, d1, d2, d3); \
	/* x0..7, g0..3 in use */ \
	\
	/* gf16_square + gf16_mult_lambda: */ \
	vpxor	x6, x7, d0; \
	vpxor	x4, x7, d2; \
	vpxor	x4, x5, d3; \
	vpxor	x6, d3, d3; \
	/* x0..7, g0..3, d0, d2, d3 in use */ \
	\
	/* gf16_add: */ \
	vpxor	d0, g0, g0; \
	vpxor	x7, g1, g1; \
	vpxor	d2, g2, g2; \
	vpxor	d3, g3, g3; \
	/* x0..7, g0..3 in use */ \
	\
	gf16_inv(g0, g1, g2, g3, d0, d1, d2, d3); \
	/* x0..7, g0..3 in use */ \
	\
	/* gf16_add: */ \
	vpxor	x0, x4, x0; \
	vpxor	x1, x5, x1; \
	vpxor	x2, x6, x2; \
	vpxor	x3, x7, x3; \
	/* x0..7, g0..3 in use */ \
	\
	gf16_mult_2(g0, g1, g2, g3, x0, x1, x2, x3, x4, x5, x6, x7, \
		    d0, d1, d2, d3); \
	/* output in x0..7 */

#define isom_map(x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2, t3) \
	vpxor	x3, x2, t3; \
	vpxor	t3, x1, t0; \
	vpxor	x6, x1, t1; \
	vpxor	x7, x6, t2; \
	vpxor	t0, t2, t2; \
	\
	vpxor	x4, t0, x2; \
	vpxor	x7, x2, x2; \
	vpxor	x5, x7, x7; \
	\
	vpxor	x7, t3, x5; \
	vpxor	x4, t1, x1; \
	\
	vpxor	x4, t2, x6; \
	vpxor	x7, t0, x4; \
	\
	vpxor	t1, x0, x0; \
	vpxor	x3, t2, x3;

#define isommapinv_affinetform(x0, x1, x2, x3, x4, x5, x6, x7, \
			       t0, t1, t2, t3, t4, t5) \
	vpcmpeqd t0, t0, t0; \
	vpxor	t0, x7, t0; \
	vpxor	x4, x5, t2; \
	vpxor	x6, t2, t2; \
	vpxor	x0, x1, t3; \
	vpxor	x2, x3, t4; \
	\
	vpxor	x4, t3, x4; \
	vpxor	x7, x4, x4; \
	vpxor	x7, t4, x7; \
	\
	vpxor	x1, x2, t5; \
	vpxor	x6, t5, t5; \
	vpxor	x0, t4, t4; \
	\
	vpxor	x0, t0, x1; \
	vpxor	x1, t5, x0; \
	vpxor	x2, t3, x3; \
	vpxor	x2, t0, x5; \
	vpxor	t4, t2, x2; \
	vpxor	t2, t0, x6;

#ifdef SUBBYTES_CONSTRUCTIVE /* Based partially on Matsui's paper */

#define subbytes(x0, x1, x2, x3, x4, x5, x6, x7, \
		 t0, t1, t2, t3, t4, t5, t6, t7) \
	isom_map(x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2, t3); \
	gf256_inv(x0, x1, x2, x3, x4, x5, x6, x7, \
		  t0, t1, t2, t3, t4, t5, t6, t7); \
	isommapinv_affinetform(x0, x1, x2, x3, x4, x5, x6, x7, \
			       t0, t1, t2, t3, t4, t5);

#else /* SUBBYTES_ITERATIVE_IMPROVEMENT */ /* Based on Käsper's paper (SSSE2 => AVX) */

#ifdef NO_SBOX
#define subbytes(b0, b1, b2, b3, b4, b5, b6, b7, \
		 t0, t1, t2, t3, s0, s1, s2, s3)
#else
#define subbytes(b0, b1, b2, b3, b4, b5, b6, b7, \
		 t0, t1, t2, t3, s0, s1, s2, s3) \
	InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7, t0); \
	Inv_GF256(b6, t0, b0, b3, b7, b1, b4, b2, b5, t1, t2, t3, s0, s1, s2, s3); \
	OutBasisChange(b7, b1, b4, b2, b6, t0, b0, b3, b5, t1, t2, t3, s0, s1, s2, s3);
#endif
    
#define OutBasisChange(b7, b1, b4, b2, b6, b5, b0, b3, \
		       t0, t1, t2, t3, t4, t5, t6, t7) \
	vpxor    b7, b0, t0;    \
	vpxor    b1, b6, t1;    \
	vpxor    b4, t0, t2;    \
	vpxor    b6, b0, t4;    \
	vpxor    b0, t1, b0;    \
	\
	vpxor    b5, t1, b1;    \
	vpxor    b5, b2, b7;    \
	vpxor    b2, b3, b6;    \
	vpxor    t2, b7, b2;    \
	vpxor    b3, b7, b4;    \
	\
	vpxor    t4, b4, b3;

#define InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7, t5) \
	vpxor    b6, b5, b5;    \
	vpxor    b1, b2, b2;    \
	vpxor    b0, b5, t5;    \
	vpxor    b2, b6, b6;    \
	vpxor    b0, b3, b3;    \
	\
	vpxor    b3, b6, b6;    \
	vpxor    b7, b3, b3;    \
	vpxor    t5, b7, b7;    \
	vpxor    b4, b3, b3;    \
	vpxor    t5, b4, b4;    \
	\
	vpxor    b1, b3, b3;    \
	vpxor    b7, b2, b2;    \
	vpxor    t5, b1, b1;

#define Mul_GF4_N(x0, x1, y0, y1, t0) \
	vpxor    y0, y1, t0;    \
	vpand    x0, t0, t0;    \
	vpxor    x1, x0, x0;    \
	vpand    y1, x0, x0;    \
	vpand    y0, x1, x1;    \
	vpxor    x0, x1, x1;    \
	vpxor    t0, x0, x0;

#define Mul_GF4(x0, x1, i0, i1, y0, y1, t0) \
	vpxor    y0, y1, t0;    \
	vpand    i0, t0, t0;    \
	vpxor    i0, i1, x0;    \
	vpand    y1, x0, x0;    \
	vpand    i1, y0, x1;    \
	vpxor    x1, x0, x0;    \
	vpxor    t0, x1, x1;

#define Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, \
		   y0, y1, y2, y3, t0, t1, t2, t3) \
	Mul_GF4(t0, t1, x0, x1, y0, y1, t2);\
	vpxor    x2, x0, x0;    \
	vpxor    x3, x1, x1;    \
	vpxor    y2, y0, y0;    \
	vpxor    y3, y1, y1;    \
	Mul_GF4_N(x0, x1, y0, y1, t3);\
	Mul_GF4(x2, x3, x2, x3, y2, y3, t2);\
	vpxor    x0, x2, x2;    \
	vpxor    t0, x0, x0;    \
	vpxor    x1, x3, x3;    \
	vpxor    t1, x1, x1;    \
	vpxor    x4, x6, t0;    \
	vpxor    x5, x7, t1;    \
	Mul_GF4_N(t0, t1, y0, y1, t3);\
	Mul_GF4(x6, x7, x6, x7, y2, y3, t2);\
	vpxor    y2, y0, y0;    \
	vpxor    y3, y1, y1;    \
	Mul_GF4(x4, x5, x4, x5, y0, y1, t3);\
	vpxor    t0, x4, x4;    \
	vpxor    t0, x6, x6;    \
	vpxor    t1, x5, x5;    \
	vpxor    t1, x7, x7;

#define Inv_GF256(x0,  x1, x2, x3, x4, x5, x6, x7, \
		  t0, t1, t2, t3, s0, s1, s2, s3) \
	vpxor    x4, x6, t3;    \
	vpxor    x5, x7, t2;    \
	vpxor    x1, x3, t1;    \
	vpxor    x7, x6, s1;    \
	vpxor    x0, x2, s0;    \
	\
	vpxor    t3, t2, s3;    \
	vpand    t2, t1, t0;    \
	vpor     t1, t2, t2;    \
	vpand    t3, s0, s2;    \
	vpor     s0, t3, t3;    \
	vpxor    t1, s0, s0;    \
	vpand    s0, s3, s3;    \
	vpxor    x3, x2, s0;    \
	vpand    s0, s1, s1;    \
	vpxor    s1, t3, t3;    \
	vpxor    s1, t2, t2;    \
	vpxor    x4, x5, s1;    \
	vpxor    x1, x0, s0;    \
	vpor     s1, s0, t1;    \
	vpand    s0, s1, s1;    \
	vpxor    s1, t0, t0;    \
	vpxor    s3, t3, t3;    \
	vpxor    s2, t2, t2;    \
	vpxor    s3, t1, t1;    \
	vpxor    s2, t0, t0;    \
	vpxor    s2, t1, t1;    \
	vpand    x7, x3, s0;    \
	vpand    x6, x2, s1;    \
	vpand    x5, x1, s2;    \
	vpor     x4, x0, s3;    \
	vpxor    s0, t3, t3;    \
	vpxor    s1, t2, t2;    \
	vpxor    s2, t1, t1;    \
	vpxor    s3, t0, t0;    \
	\
	vpxor    t3, t2, s0;    \
	vpand    t1, t3, t3;    \
	vpxor    t0, t3, s2;    \
	vpand    s0, s2, s3;    \
	vpxor    t2, s3, s3;    \
	vpxor    t1, t0, s1;    \
	vpxor    t2, t3, t3;    \
	vpand    t3, s1, s1;    \
	vpxor    t0, s1, s1;    \
	vpxor    s1, t1, t1;    \
	vpxor    s2, s1, t2;    \
	vpand    t0, t2, t2;    \
	vpxor    t2, t1, t1;    \
	vpxor    t2, s2, s2;    \
	vpand    s3, s2, s2;    \
	vpxor    s0, s2, s2;    \
	\
	Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, \
		   s3, s2, s1, t1, s0, t0, t2, t3);

#endif /* SUBBYTES_CONSTRUCTIVE */

#define affinetforminv_isommap(x0, x1, x2, x3, x4, x5, x6, x7, \
			       t0, t1, t2, t3, t4, t5, t6) \
	vpcmpeqd t6, t6, t6; \
	vpxor	x7, t6, t0; \
	vpxor	x0, x6, t4; \
	vpxor	x0, x3, t5; \
	\
	vpxor	x2, x6, x0; \
	vpxor	x0, t0, x0; \
	vpxor	x1, x0, t2; \
	vpxor	x4, t6, t3; \
	vpxor	x5, t3, t3; \
	\
	vpxor	x3, x1, x1; \
	vpxor	x5, x1, x1; \
	vpxor	t5, t2, x6; \
	vpxor	x3, t3, x4; \
	vpxor	x5, t0, x3; \
	vpxor	t6, t2, x7; \
	vpxor	x5, t2, x2; \
	vpxor	t4, t3, x5;

#define isom_map_inv(x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2) \
	vpxor	x4, x2, t2; \
	vpxor	x3, x1, t1; \
	vpxor	t1, t2, t1; \
	\
	vpxor	x5, t1, x3; \
	vpxor	x5, x1, t0; \
	vpxor	x5, x4, x1; \
	vpxor	x6, t0, x5; \
	\
	vpxor	x6, x2, x6; \
	vpxor	x1, x0, x0; \
	vpxor	x6, x0, x0; \
	vpxor	x7, t1, x2; \
	vpxor	x5, t2, x4; \
	vpxor	x5, x7, x7;

    
.align 8
.global aes_avx_enc_blk8
.type   aes_avx_enc_blk8,@function;
aes_avx_enc_blk8:
	/* input:
	 *	%rdi: ctx, CTX
	 *	%xmm0-%xmm7: eight input/output blocks
	 */

	movl	nr(CTX), %eax;
	decl	%eax;
	leaq	bs_keysched(CTX), %r8;
    
.Lenc_loop:

	addroundkey(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		    %r8);
	addq	$(8*16), %r8;

	shiftrow(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8);

	subbytes(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		 %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15);

	mixcolumns(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		   %xmm8, %xmm9, %xmm10, %xmm11,
		   %xmm12, %xmm13, %xmm14, %xmm15);
	decl	%eax;
	jnz	.Lenc_loop;

    
	addroundkey(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		    %r8);
	addq	$(8*16), %r8;

	shiftrow(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8);

	subbytes(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		 %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15);

	addroundkey(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		    %r8);
    

	ret;

#endif
