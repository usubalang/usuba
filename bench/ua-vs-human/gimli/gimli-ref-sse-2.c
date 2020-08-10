#define R 24 /* XXX: also baked into rotate24() below */
#define S 9

#include <x86intrin.h>

typedef unsigned int uint32;

static inline __m128i shift(__m128i x,int bits)
{
  return _mm_slli_epi32(x,bits);
}

static inline __m128i rotate(__m128i x,int bits)
{
  return _mm_slli_epi32(x,bits) | _mm_srli_epi32(x,32 - bits);
}

static inline __m128i rotate24(__m128i x)
{
  return _mm_shuffle_epi8(x,
    _mm_set_epi8(
      12,15,14,13,8,11,10,9,4,7,6,5,0,3,2,1
    )
  );
}

static const uint32 coeffs[24] __attribute__((aligned(16))) = {
  0x9e377904,0,0,0,
  0x9e377908,0,0,0,
  0x9e37790c,0,0,0,
  0x9e377910,0,0,0,
  0x9e377914,0,0,0,
  0x9e377918,0,0,0,
} ;

extern void gimli(uint32 *state)
{
  int round;
  __m128i x = _mm_loadu_si128((void *) (state + 0));
  __m128i y = _mm_loadu_si128((void *) (state + 4));
  __m128i z = _mm_loadu_si128((void *) (state + 8));
  __m128i newy;
  __m128i newz;

  for (round = 5;round >= 0;--round) {
       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

    x = _mm_shuffle_epi32(x,_MM_SHUFFLE(2,3,0,1));
    x ^= round[(__m128i *) coeffs];

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;

    x = _mm_shuffle_epi32(x,_MM_SHUFFLE(1,0,3,2));

       x = rotate24(x);
       y = rotate(y,S);
    newz = x ^ shift(z,1) ^ shift(y&z,2);
    newy = y ^ x          ^ shift(x|z,1);
       x = z ^ y          ^ shift(x&y,3);
       y = newy;
       z = newz;
  }

  _mm_storeu_si128((void *) (state + 0),x);
  _mm_storeu_si128((void *) (state + 4),y);
  _mm_storeu_si128((void *) (state + 8),z);
}

#include <stdint.h>

/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  uint32_t state[3*4] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (state));

  /* Outputs */
  /* Primitive call */
  gimli(state);

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (state));

  /* Returning the number of encrypted bytes */
  return 48;
}
