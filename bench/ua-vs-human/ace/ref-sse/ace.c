/* Reference implementation of ACE-128, AEAD
 Written by:
 Kalikinkar Mandal <kmandal@uwaterloo.ca>
 */

#include "ace.h"


/*
   *ace: 16-round ace permutation of width 320 bits
   *x: input state, and output state is stored in state (inplace)
*/
void ace( __m128i *x )
{
        u8 i, j, k;
        u32 t1, t2;
        __m128i xtmp, ytmp;

        for ( i = 0; i < NUMSTEPS; i++ )
        {

                for ( k = 0; k < PARAL_INST_BY4; k++ )
                {
                        //Chi
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

                        //Diffusion
                        t1 = (u32)SC0[i];
                        t2 = (u32)SC1[i];
                        x[10*k+4] = x[10*k+4]^SC(t1, t2);
                        x[10*k+5] = x[10*k+5]^SC(t1, t2);
                        x[10*k+6] = x[10*k+6]^SC(t1, t2);
                        x[10*k+7] = x[10*k+7]^SC(t1, t2);

			xtmp = _mm_unpacklo_epi64(_mm_shuffle_epi32(x[10*k], _MM_SHUFFLE(1, 0, 3,2)), x[10*k+8]);
			x[10*k+4]^=xtmp;
			x[10*k+4] = _mm_shuffle_epi32(x[10*k+4], _MM_SHUFFLE(1, 0, 3,2));

			xtmp = _mm_unpackhi_epi64(x[10*k+1], x[10*k+8]);
			x[10*k+5]^=xtmp;
			x[10*k+5] = _mm_shuffle_epi32(x[10*k+5], _MM_SHUFFLE(1, 0, 3,2));

			xtmp = _mm_unpacklo_epi64(_mm_shuffle_epi32(x[10*k+2], _MM_SHUFFLE(1, 0, 3,2)), x[10*k+9]);
			x[10*k+6]^=xtmp;
			x[10*k+6] = _mm_shuffle_epi32(x[10*k+6], _MM_SHUFFLE(1, 0, 3,2));

			xtmp = _mm_unpackhi_epi64(x[10*k+3], x[10*k+9]);
			x[10*k+7]^=xtmp;
			x[10*k+7] = _mm_shuffle_epi32(x[10*k+7], _MM_SHUFFLE(1, 0, 3,2));

			x[10*k+8]^=(x[10*k]&masklo);
			x[10*k+8]^=(_mm_shuffle_epi32(x[10*k+1], _MM_SHUFFLE(1, 0, 3,2))&maskhi);
			x[10*k+8]^=SC((u32)SC2[i], (u32)SC2[i]);

			x[10*k+9]^=(x[10*k+2]&masklo);
			x[10*k+9]^=(_mm_shuffle_epi32(x[10*k+3], _MM_SHUFFLE(1, 0, 3,2))&maskhi);
			x[10*k+9]^=SC((u32)SC2[i], (u32)SC2[i]);


			xtmp = _mm_unpacklo_epi64(x[10*k+4], x[10*k]);
			ytmp = _mm_unpackhi_epi64(x[10*k], _mm_shuffle_epi32(x[10*k+8], _MM_SHUFFLE(1, 0, 3,2)));
			x[10*k] = xtmp;
			x[10*k+8] = x[10*k+8]&maskhi;
			x[10*k+8]^=(_mm_shuffle_epi32(x[10*k+4], _MM_SHUFFLE(1, 0, 3,2))&masklo);
			x[10*k+4] = ytmp;

			xtmp = _mm_unpacklo_epi64(x[10*k+5], x[10*k+1]);
			ytmp = _mm_unpackhi_epi64(x[10*k+1], x[10*k+8]);
			x[10*k+1] = xtmp;
			x[10*k+8] = x[10*k+8]&masklo;
			x[10*k+8]^=x[10*k+5]&maskhi;
			x[10*k+5] = ytmp;

			xtmp = _mm_unpacklo_epi64(x[10*k+6], x[10*k+2]);
			ytmp = _mm_unpackhi_epi64(x[10*k+2], _mm_shuffle_epi32(x[10*k+9], _MM_SHUFFLE(1, 0, 3,2)));
			x[10*k+2] = xtmp;
			x[10*k+9] = x[10*k+9]&maskhi;
			x[10*k+9]^=(_mm_shuffle_epi32(x[10*k+6], _MM_SHUFFLE(1, 0, 3,2))&masklo);
			x[10*k+6] = ytmp;

			xtmp = _mm_unpacklo_epi64(x[10*k+7], x[10*k+3]);
			ytmp = _mm_unpackhi_epi64(x[10*k+3], x[10*k+9]);
			x[10*k+3] = xtmp;
			x[10*k+9] = x[10*k+9]&masklo;
			x[10*k+9]^=x[10*k+7]&maskhi;
			x[10*k+7] = ytmp;
                }
        }
        return;
}


/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  __m128i input__[10] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Primitive call */
  ace(input__);

  // Uncomment for debug prints
  /* for (int i = 0; i < 5; i++) { */
  /*   uint64_t* buff = (uint64_t*)(&input__[i*2]); */
  /*   printf("%lx %lx %lx %lx\n", buff[0], buff[1], buff[2], buff[3]); */
  /* } */

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Returning the number of encrypted bytes */
  return 160;
}
