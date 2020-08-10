#define R 24 /* XXX: also baked into rotate24() below */
#define S 9

#include <x86intrin.h>

typedef unsigned int uint32;

static inline __m256i shift(__m256i x,int bits)
{
  return _mm256_slli_epi32(x,bits);
}

static inline __m256i rotate(__m256i x,int bits)
{
  return _mm256_slli_epi32(x,bits) | _mm256_srli_epi32(x,32 - bits);
}

static inline __m256i rotate24(__m256i x)
{
  return _mm256_shuffle_epi8(x,
    _mm256_set_epi8(
      12,15,14,13,8,11,10,9,4,7,6,5,0,3,2,1,
      28,31,30,29,24,27,26,25,20,23,22,21,16,19,18,17
    )
  );
}

static const uint32 coeffs[48] __attribute__((aligned(32))) = {
  0x9e377904,0,0,0,0x9e377904,0,0,0,
  0x9e377908,0,0,0,0x9e377908,0,0,0,
  0x9e37790c,0,0,0,0x9e37790c,0,0,0,
  0x9e377910,0,0,0,0x9e377910,0,0,0,
  0x9e377914,0,0,0,0x9e377914,0,0,0,
  0x9e377918,0,0,0,0x9e377918,0,0,0,
} ;


void gimli(uint32 *state)
{
  int round;
  __m256i x;
  __m256i y;
  __m256i z;
  __m256i x2;
  __m256i y2;
  __m256i z2;
  __m256i newy;
  __m256i newz;

  x = _mm256_loadu2_m128i((void *) (state + 0),(void *) (state + 12));
  y = _mm256_loadu2_m128i((void *) (state + 4),(void *) (state + 16));
  z = _mm256_loadu2_m128i((void *) (state + 8),(void *) (state + 20));
  x2 = _mm256_loadu2_m128i((void *) (state + 24),(void *) (state + 36));
  y2 = _mm256_loadu2_m128i((void *) (state + 28),(void *) (state + 40));
  z2 = _mm256_loadu2_m128i((void *) (state + 32),(void *) (state + 44));

  for (round = 5;round >= 0;--round) {
       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

	       x2 = rotate24(x2);
	       y2 = rotate(y2,S);
            newz  = x2 ^ shift(z2,1) ^ shift(y2&z2,2);
            newy  = y2 ^ x2          ^ shift(x2|z2,1);
               x2 = z2 ^ y2          ^ shift(x2&y2,3);
               y2 = newy;
               z2 = newz;

    x = _mm256_shuffle_epi32(x,_MM_SHUFFLE(2,3,0,1));
    x ^= round[(__m256i *) coeffs];

            x2 = _mm256_shuffle_epi32(x2,_MM_SHUFFLE(2,3,0,1));
            x2 ^= round[(__m256i *) coeffs];

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

	       x2 = rotate24(x2);
	       y2 = rotate(y2,S);
            newz  = x2 ^ shift(z2,1) ^ shift(y2&z2,2);
            newy  = y2 ^ x2          ^ shift(x2|z2,1);
               x2 = z2 ^ y2          ^ shift(x2&y2,3);
               y2 = newy;
               z2 = newz;

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

	       x2 = rotate24(x2);
	       y2 = rotate(y2,S);
            newz  = x2 ^ shift(z2,1) ^ shift(y2&z2,2);
            newy  = y2 ^ x2          ^ shift(x2|z2,1);
               x2 = z2 ^ y2          ^ shift(x2&y2,3);
               y2 = newy;
               z2 = newz;

    x = _mm256_shuffle_epi32(x,_MM_SHUFFLE(1,0,3,2));

            x2 = _mm256_shuffle_epi32(x2,_MM_SHUFFLE(1,0,3,2));

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

	       x2 = rotate24(x2);
	       y2 = rotate(y2,S);
            newz  = x2 ^ shift(z2,1) ^ shift(y2&z2,2);
            newy  = y2 ^ x2          ^ shift(x2|z2,1);
               x2 = z2 ^ y2          ^ shift(x2&y2,3);
               y2 = newy;
               z2 = newz;
  }

  _mm256_storeu2_m128i((void *) (state + 0),(void *) (state + 12),x);
  _mm256_storeu2_m128i((void *) (state + 4),(void *) (state + 16),y);
  _mm256_storeu2_m128i((void *) (state + 8),(void *) (state + 20),z);
  _mm256_storeu2_m128i((void *) (state + 24),(void *) (state + 36),x2);
  _mm256_storeu2_m128i((void *) (state + 28),(void *) (state + 40),y2);
  _mm256_storeu2_m128i((void *) (state + 32),(void *) (state + 44),z2);
}

#include <stdint.h>

/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  uint32_t state[3*4*2*2] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (state));

  /* Outputs */
  /* Primitive call */
  gimli(state);

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (state));

  /* Returning the number of encrypted bytes */
  return 48*2*2;
}
