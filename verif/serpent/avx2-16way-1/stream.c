/*
 * SuperCop glue code for Serpent-AVX2-16way
 *
 * Public domain, 2013/06/04
 * Jussi Kivilinna
 */

#include "crypto_stream.h"
#include <stdlib.h>
#include "api.h"
#include "serpent.h"

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

#define BLOCKSIZE 16
#define PARALLEL_BLOCKS 16

extern void __serpent_enc_blk_16way(struct serpent_ctx *ctx, uint8_t *dst, const uint8_t *src, char xor);

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

static inline void xor256(uint128_t *dst, const uint128_t *src1, const uint128_t *src2)
{
	__asm__ (
		"vmovdqu %[s1], %%ymm0;\n"
		"vpxor %[s2], %%ymm0, %%ymm0;\n"
		"vmovdqu %%ymm0, %[d];\n"
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

#define move256(dst, src) ({ \
	__asm__ ("vmovdqu %[s], %%ymm0;\n" \
		 "vmovdqu %%ymm0, %[d];\n" \
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
	const unsigned long align = 32;
	char ctxbuf[sizeof(CTX_TYPE) + align];
	CTX_TYPE *ctx = PTR_ALIGN(ctxbuf, align - 1);
	uint128_t iv;
	uint128_t ivs[PARALLEL_BLOCKS];

	serpent_init(ctx, k, CRYPTO_KEYBYTES);
	bswap128(&iv, (const uint128_t *)n); /* be => le */

	__asm__ volatile ("vzeroupper; \n" :::);

	while (likely(inlen >= BLOCKSIZE * PARALLEL_BLOCKS)) {
		if (unlikely(iv.ll[0] > (0xffffffffffffffffULL - PARALLEL_BLOCKS))) {
			unsigned int i;

			bswap128(&ivs[0], &iv); /* le => be */
			for (i = 1; i < PARALLEL_BLOCKS; i++) {
				add128(&ivs[i], &iv, i);
				bswap128(&ivs[i], &ivs[i]); /* le => be */
			}
			add128(&iv, &iv, PARALLEL_BLOCKS);
		} else {
			__asm__ (
				"vpcmpeqd %%ymm0, %%ymm0, %%ymm0; \n"
				"vpsrldq $8, %%ymm0, %%ymm0; \n"
				"vbroadcasti128 %[bswap], %%ymm1; \n"
				/* load IV and byteswap */
				"vmovdqu %[iv], %%xmm7; \n"
				"vmovdqa %%xmm7, %%xmm8; \n"
				"vpsubq %%xmm0, %%xmm7, %%xmm7; \n"
				"vinserti128 $1, %%xmm7, %%ymm8, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 0*16(%[ivs]); \n"
				"vpaddq %%ymm0, %%ymm0, %%ymm8; \n"
				/* construct IVs */
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 2*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 4*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 6*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 8*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 10*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 12*16(%[ivs]); \n"
				"vpsubq %%ymm8, %%ymm7, %%ymm7; \n"
				"vpshufb %%ymm1, %%ymm7, %%ymm2; \n"
				"vmovdqu %%ymm2, 14*16(%[ivs]); \n"

				"vpsubq %%xmm8, %%xmm7, %%xmm7; \n"
				"vmovdqu %%xmm7, %[iv]; \n"
				:
				: [ivs] "r" (&ivs[0]), [iv] "m" (iv),
				  [bswap] "m" (bswap128const[0])
				: "memory", "xmm0", "xmm1", "xmm2", "xmm7", "xmm8"
			);
		}

		if (unlikely(in) && unlikely(in != out)) {
			move256(out + BLOCKSIZE * 0, in + BLOCKSIZE * 0);
			move256(out + BLOCKSIZE * 2, in + BLOCKSIZE * 2);
			move256(out + BLOCKSIZE * 4, in + BLOCKSIZE * 4);
			move256(out + BLOCKSIZE * 6, in + BLOCKSIZE * 6);
			move256(out + BLOCKSIZE * 8, in + BLOCKSIZE * 8);
			move256(out + BLOCKSIZE * 10, in + BLOCKSIZE * 10);
			move256(out + BLOCKSIZE * 12, in + BLOCKSIZE * 12);
			move256(out + BLOCKSIZE * 14, in + BLOCKSIZE * 14);
		}

		__serpent_enc_blk_16way(ctx, out, (uint8_t *)ivs, in != NULL);

		if (unlikely(in))
			in += BLOCKSIZE * PARALLEL_BLOCKS;

		out += BLOCKSIZE * PARALLEL_BLOCKS;
		inlen -= BLOCKSIZE * PARALLEL_BLOCKS;
	}

	if (unlikely(inlen > 0)) {
		unsigned int nblock = inlen / BLOCKSIZE;
		unsigned int lastlen = inlen % BLOCKSIZE;
		unsigned int i, j;

		for (i = 0; i < nblock + !!lastlen; i++) {
			bswap128(&ivs[i], &iv); /* le => be */
			inc128(&iv);
		}
		for (; i < PARALLEL_BLOCKS; i++) {
			ivs[i].ll[0] = 0;
			ivs[i].ll[1] = 0;
		}

		__serpent_enc_blk_16way(ctx, (uint8_t *)ivs, (uint8_t *)ivs, 0);

		if (in) {
			for (i = 0; inlen >= BLOCKSIZE; i += 1) {
				xor128((uint128_t *)out, (uint128_t *)in, &ivs[i]);

				inlen -= BLOCKSIZE;
				in += BLOCKSIZE;
				out += BLOCKSIZE;
			}

			for (j = 0; j < inlen; j++)
				out[j] = in[j] ^ ((uint8_t*)&ivs[i])[j];
		} else {
			for (i = 0; inlen >= BLOCKSIZE; i += 1) {
				move128((uint128_t *)out, &ivs[i]);

				inlen -= BLOCKSIZE;
				out += BLOCKSIZE;
			}

			for (j = 0; j < inlen; j++)
				out[j] = ((uint8_t*)&ivs[i])[j];
		}
	}

	__asm__ volatile ("vzeroupper; \n" :::);

	return 0;
}

int crypto_stream(unsigned char *out, unsigned long long outlen,
		  const unsigned char *n,const unsigned char *k)
{
	return crypto_stream_xor(out, NULL, outlen, n, k);
}
