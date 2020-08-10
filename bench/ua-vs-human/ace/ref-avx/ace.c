/* Reference implementation of ACE-128, AEAD
 Written by:
 Kalikinkar Mandal <kmandal@uwaterloo.ca>
 */

#include "ace.h"

static __attribute__((always_inline)) inline __m256i _mm256_unpacklo_epi128(__m256i a, __m256i b)
{
        return _mm256_permute2x128_si256(a, b, 0x20);
}

static __attribute__((always_inline)) inline __m256i _mm256_unpackhi_epi128(__m256i a, __m256i b)
{
        return _mm256_permute2x128_si256(a, b, 0x31);
}


/*
   *ace: 16-round ace permutation of width 320 bits
   *x: input state, and output state is stored in state (inplace)
*/
void ace( __m256i *x )
{
        u8 i, j, k;
        u32 t1, t2;
        __m256i xtmp, ytmp;

        for ( i = 0; i < NUMSTEPS; i++ )
        {

                for ( k = 0; k < PARAL_INST_BY8; k++ )
                {
                        //SSb
                        PACK_SSb(x[10*k],x[10*k+1]);
                        for ( j = 0; j < SIMECKROUND; j++ )
                        {
                                t1 = (u32)((RC0[i] >> j)&1);
                                t2 = (u32)((RC1[i] >> j)&1);
                                ROAX(x[10*k], x[10*k+1], t1, t2);
                        }
                        UNPACK_SSb(x[10*k],x[10*k+1]);

			PACK_SSb(x[10*k+2],x[10*k+3]);
                        for ( j = 0; j < SIMECKROUND; j++ )
                        {
                                t1 = (u32)((RC0[i] >> j)&1);
                                t2 = (u32)((RC1[i] >> j)&1);
                                ROAX(x[10*k+2], x[10*k+3], t1, t2);
                        }
                        UNPACK_SSb(x[10*k+2],x[10*k+3]);

			PACK_SSb(x[10*k+8],x[10*k+9]);
                        for ( j = 0; j < SIMECKROUND; j++ )
                        {
                                t1 = (u32)((RC2[i] >> j)&1);
                                t2 = (u32)((RC2[i] >> j)&1);
                                ROAX(x[10*k+8], x[10*k+9], t1, t2);
                        }
                        UNPACK_SSb(x[10*k+8],x[10*k+9]);

                        //ASc and MSb
                        t1 = (u32)SC0[i];
                        t2 = (u32)SC1[i];
                        x[10*k+4] = x[10*k+4]^SC(t1, t2);
                        x[10*k+5] = x[10*k+5]^SC(t1, t2);
                        x[10*k+6] = x[10*k+6]^SC(t1, t2);
                        x[10*k+7] = x[10*k+7]^SC(t1, t2);

			//R0, R4
			x[10*k] = _mm256_permute4x64_epi64(x[10*k], _MM_SHUFFLE(2, 0, 3,1));
			x[10*k+4] = _mm256_permute4x64_epi64(x[10*k+4], _MM_SHUFFLE(3, 1, 2,0));
			xtmp = _mm256_unpacklo_epi128(x[10*k], x[10*k+8]);
			x[10*k+4]^=xtmp;
			xtmp = _mm256_unpackhi_epi128(x[10*k+4],x[10*k]);
			xtmp = _mm256_permute4x64_epi64(xtmp, _MM_SHUFFLE(3, 1, 2,0));

			ytmp = x[10*k+8]^_mm256_permute4x64_epi64(x[10*k], _MM_SHUFFLE(1,0,3,2));
			ytmp^=SC((u32)SC2[i], (u32)SC2[i]);
			ytmp = _mm256_unpacklo_epi128(x[10*k], ytmp);
			ytmp = _mm256_permute4x64_epi64(ytmp, _MM_SHUFFLE(3, 1, 2,0));
			x[10*k] = xtmp;
			x[10*k+8] = x[10*k+8]&maskhi;
			x[10*k+8]^=(x[10*k+4]&masklo);
			x[10*k+4] = ytmp;

			//R1, R5
			x[10*k+1] = _mm256_permute4x64_epi64(x[10*k+1], _MM_SHUFFLE(2, 0, 3,1));
			x[10*k+5] = _mm256_permute4x64_epi64(x[10*k+5], _MM_SHUFFLE(3, 1, 2,0));
			xtmp = _mm256_unpackhi_epi128(_mm256_permute4x64_epi64(x[10*k+1], _MM_SHUFFLE(1,0,3,2)), x[10*k+8]);
			x[10*k+5]^=xtmp;
			xtmp = _mm256_unpackhi_epi128(x[10*k+5],x[10*k+1]);
			xtmp = _mm256_permute4x64_epi64(xtmp, _MM_SHUFFLE(3, 1, 2,0));

			ytmp = x[10*k+8]^x[10*k+1];
			ytmp^=SC((u32)SC2[i], (u32)SC2[i]);
			ytmp = _mm256_unpackhi_epi128(_mm256_permute4x64_epi64(x[10*k+1],_MM_SHUFFLE(1,0,3,2)), ytmp);
			ytmp = _mm256_permute4x64_epi64(ytmp, _MM_SHUFFLE(3, 1, 2,0));
			x[10*k+1] = xtmp;
			x[10*k+8] = x[10*k+8]&masklo;
			x[10*k+8]^=(_mm256_permute4x64_epi64(x[10*k+5], _MM_SHUFFLE(1,0,3,2))&maskhi);
			x[10*k+5] = ytmp;

			//R2, R6
			x[10*k+2] = _mm256_permute4x64_epi64(x[10*k+2], _MM_SHUFFLE(2, 0, 3,1));
			x[10*k+6] = _mm256_permute4x64_epi64(x[10*k+6], _MM_SHUFFLE(3, 1, 2,0));
			xtmp = _mm256_unpacklo_epi128(x[10*k+2], x[10*k+9]);
			x[10*k+6]^=xtmp;
			xtmp = _mm256_unpackhi_epi128(x[10*k+6],x[10*k+2]);
			xtmp = _mm256_permute4x64_epi64(xtmp, _MM_SHUFFLE(3, 1, 2,0));

			ytmp = x[10*k+9]^_mm256_permute4x64_epi64(x[10*k+2], _MM_SHUFFLE(1,0,3,2));
			ytmp^=SC((u32)SC2[i], (u32)SC2[i]);
			ytmp = _mm256_unpacklo_epi128(x[10*k+2], ytmp);
			ytmp = _mm256_permute4x64_epi64(ytmp, _MM_SHUFFLE(3, 1, 2,0));
			x[10*k+2] = xtmp;
			x[10*k+9] = x[10*k+9]&maskhi;
			x[10*k+9]^=(x[10*k+6]&masklo);
			x[10*k+6] = ytmp;

			//R3, R7
			x[10*k+3] = _mm256_permute4x64_epi64(x[10*k+3], _MM_SHUFFLE(2, 0, 3,1));
			x[10*k+7] = _mm256_permute4x64_epi64(x[10*k+7], _MM_SHUFFLE(3, 1, 2,0));
			xtmp = _mm256_unpackhi_epi128(_mm256_permute4x64_epi64(x[10*k+3], _MM_SHUFFLE(1,0,3,2)), x[10*k+9]);
			x[10*k+7]^=xtmp;
			xtmp = _mm256_unpackhi_epi128(x[10*k+7],x[10*k+3]);
			xtmp = _mm256_permute4x64_epi64(xtmp, _MM_SHUFFLE(3, 1, 2,0));

			ytmp = x[10*k+9]^x[10*k+3];
			ytmp^=SC((u32)SC2[i], (u32)SC2[i]);
			ytmp = _mm256_unpackhi_epi128(_mm256_permute4x64_epi64(x[10*k+3],_MM_SHUFFLE(1,0,3,2)), ytmp);
			ytmp = _mm256_permute4x64_epi64(ytmp, _MM_SHUFFLE(3, 1, 2,0));
			x[10*k+3] = xtmp;
			x[10*k+9] = x[10*k+9]&masklo;
			x[10*k+9]^=(_mm256_permute4x64_epi64(x[10*k+7], _MM_SHUFFLE(1,0,3,2))&maskhi);
			x[10*k+7] = ytmp;
                }
        }
        return;
}


/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  __m256i input__[10] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Primitive call */
  ace(input__);

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Returning the number of encrypted bytes */
  return 320;
}
