/*
 * SuperCop glue code for Serpent-AVX-8way
 *
 * Public domain, 2013/03/06
 * Jussi Kivilinna
 */
 
#include "crypto_stream.h"
#include <stdlib.h>
#include "api.h"
#include "serpent.h"

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

#define BLOCKSIZE 16

extern void __serpent_enc_blk_8way(struct serpent_ctx *ctx, uint8_t *dst, const uint8_t *src, char xor);

typedef struct {
	uint64_t ll[2];
} uint128_t;

static inline void bswap128(uint128_t *dst, const uint128_t *src)
{
	uint64_t tmp;

	tmp = __builtin_bswap64(src->ll[1]);
	dst->ll[1] = __builtin_bswap64(src->ll[0]);
	dst->ll[0] = tmp;
}

static inline void inc128(uint128_t *u)
{
	__asm__ (
		"addq $1, %[ll0];\n"
		"adcq $0, %[ll1];\n"
		: [ll0] "=g" (u->ll[0]), [ll1] "=g" (u->ll[1])
		: "0" (u->ll[0]), "1" (u->ll[1])
		:
	);
}

static inline void add128(uint128_t *dst, const uint128_t *src, uint64_t add)
{
	__asm__ (
		"addq %[add], %[ll0];\n"
		"adcq $0, %[ll1];\n"
		: [ll0] "=g" (dst->ll[0]), [ll1] "=g" (dst->ll[1])
		: "0" (src->ll[0]), "1" (src->ll[1]), [add] "cg" (add)
		:
	);
}

static inline void xor128(uint128_t *dst, const uint128_t *src1, const uint128_t *src2)
{
	__asm__ (
		"vmovdqu %[s1], %%xmm0;\n"
		"vpxor %[s2], %%xmm0, %%xmm0;\n"
		"vmovdqu %%xmm0, %[d];\n"
		: [d] "=m" (*dst)
		: [s1] "m" (*src1), [s2] "m" (*src2)
		: "xmm0", "memory"
	);
}

#define move128(dst, src) ({ \
	__asm__ ("vmovdqu %[s], %%xmm0;\n" \
		 "vmovdqu %%xmm0, %[d];\n" \
		 : [d] "=m" (*(dst)) \
		 : [s] "m" (*(src)) \
		 : "xmm0", "memory" \
	);})

static unsigned char bswap128const[16] = {
	15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
};

int crypto_stream_xor(unsigned char *out, const unsigned char *in,
		      unsigned long long inlen, const unsigned char *n,
		      const unsigned char *k)
{
#define CTX_TYPE struct serpent_ctx
#define PTR_ALIGN(ptr, mask) ((void *)((((long)(ptr)) + (mask)) & ~((long)(mask))))
	const unsigned long align = 16;
	char ctxbuf[sizeof(CTX_TYPE) + align];
	CTX_TYPE *ctx = PTR_ALIGN(ctxbuf, align - 1);
	uint128_t iv;
	uint128_t ivs[8];

	serpent_init(ctx, k, CRYPTO_KEYBYTES);
	bswap128(&iv, (const uint128_t *)n); /* be => le */

	while (likely(inlen >= BLOCKSIZE * 8)) {
		if (unlikely(iv.ll[0] > (0xffffffffffffffffULL - 8))) {
			bswap128(&ivs[0], &iv); /* le => be */
			add128(&ivs[1], &iv, 1);
			bswap128(&ivs[1], &ivs[1]); /* le => be */
			add128(&ivs[2], &iv, 2);
			bswap128(&ivs[2], &ivs[2]); /* le => be */
			add128(&ivs[3], &iv, 3);
			bswap128(&ivs[3], &ivs[3]); /* le => be */
			add128(&ivs[4], &iv, 4);
			bswap128(&ivs[4], &ivs[4]); /* le => be */
			add128(&ivs[5], &iv, 5);
			bswap128(&ivs[5], &ivs[5]); /* le => be */
			add128(&ivs[6], &iv, 6);
			bswap128(&ivs[6], &ivs[6]); /* le => be */
			add128(&ivs[7], &iv, 7);
			bswap128(&ivs[7], &ivs[7]); /* le => be */
			add128(&iv, &iv, 8);
		} else {
			__asm__ (
				"vpcmpeqd %%xmm0, %%xmm0, %%xmm0; \n"
				"vpsrldq $8, %%xmm0, %%xmm0; \n"
				"vmovdqu %[bswap], %%xmm1; \n"
				/* load IV and byteswap */
				"vmovdqu %[iv], %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 0*16(%[ivs]); \n"
				/* construct IVs */
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 1*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 2*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 3*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 4*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 5*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 6*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vpshufb %%xmm1, %%xmm7, %%xmm2; \n"
				"vmovdqu %%xmm2, 7*16(%[ivs]); \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vmovdqu %%xmm7, %[iv]; \n"
				:
				: [ivs] "r" (&ivs[0]), [iv] "m" (iv),
				  [bswap] "m" (bswap128const[0])
				: "memory", "xmm0", "xmm1", "xmm2", "xmm7"
			);
		}

		if (unlikely(in) && unlikely(in != out)) {
			move128(out + 16 * 0, in + 16 * 0);
			move128(out + 16 * 1, in + 16 * 1);
			move128(out + 16 * 2, in + 16 * 2);
			move128(out + 16 * 3, in + 16 * 3);
			move128(out + 16 * 4, in + 16 * 4);
			move128(out + 16 * 5, in + 16 * 5);
			move128(out + 16 * 6, in + 16 * 6);
			move128(out + 16 * 7, in + 16 * 7);
		}

		__serpent_enc_blk_8way(ctx, out, (uint8_t *)ivs, in != NULL);

		if (unlikely(in))
			in += BLOCKSIZE * 8;

		out += BLOCKSIZE * 8;
		inlen -= BLOCKSIZE * 8;
	}

	if (unlikely(inlen > 0)) {
		unsigned int nblock = inlen / BLOCKSIZE;
		unsigned int lastlen = inlen % BLOCKSIZE;
		unsigned int i, j;

		for (i = 0; i < nblock + !!lastlen; i++) {
			bswap128(&ivs[i], &iv); /* le => be */
			inc128(&iv);
		}
		for (; i < 8; i++) {
			ivs[i].ll[0] = 0;
			ivs[i].ll[1] = 0;
		}

		__serpent_enc_blk_8way(ctx, (uint8_t *)ivs, (uint8_t *)ivs, 0);

		if (in) {
			for (i = 0; inlen >= BLOCKSIZE; i++) {
				xor128((uint128_t *)out, (uint128_t *)in, &ivs[i]);

				inlen -= BLOCKSIZE;
				in += BLOCKSIZE;
				out += BLOCKSIZE;
			}

			for (j = 0; j < inlen; j++)
				out[j] = in[j] ^ ((uint8_t*)&ivs[i])[j];
		} else {
			for (i = 0; inlen >= BLOCKSIZE; i++) {
				move128((uint128_t *)out, &ivs[i]);

				inlen -= BLOCKSIZE;
				out += BLOCKSIZE;
			}

			for (j = 0; j < inlen; j++)
				out[j] = ((uint8_t*)&ivs[i])[j];
		}
	}

	return 0;
}

int crypto_stream(unsigned char *out, unsigned long long outlen,
		  const unsigned char *n,const unsigned char *k)
{
	return crypto_stream_xor(out, NULL, outlen, n, k);
}
