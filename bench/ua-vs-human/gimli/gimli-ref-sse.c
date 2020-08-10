#define R 24
#define S 9

#include <x86intrin.h>

typedef unsigned int uint32;

#define a 2
#define b 1
#define c 3
#define d R
#define e S
#define f 0

static inline __m128i shift(__m128i x,int bits)
{
  if (bits == 0) return x;
  return _mm_slli_epi32(x,bits);
}

static inline __m128i rotate(__m128i x,int bits)
{
  if (bits == 0) return x;
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

extern void gimli(uint32 *state)
{
  int round;
  int column;
  __m128i x = _mm_loadu_si128((void *) (state + 0));
  __m128i y = _mm_loadu_si128((void *) (state + 4));
  __m128i z = _mm_loadu_si128((void *) (state + 8));
  __m128i newx;
  __m128i newy;
  __m128i newz;

  for (round = 24;round > 0;--round) {
    x = rotate24(x);
    y = rotate(y,e);
    z = rotate(z,f);

    newz = x ^ shift(z,1) ^ shift(y&z,a);
    newy = y ^ x          ^ shift(x|z,b);
    newx = z ^ y          ^ shift(x&y,c);

    x = newx;
    y = newy;
    z = newz;

    if (1) {
      if ((round & 3) == 0) { // small swap: pattern s...s...s... etc.
        x = _mm_shuffle_epi32(x,_MM_SHUFFLE(2,3,0,1));
      }
      if ((round & 3) == 2) { // big swap: pattern ..S...S...S. etc.
        x = _mm_shuffle_epi32(x,_MM_SHUFFLE(1,0,3,2));
      }
    } else { // for tiny hardware
      if ((round & 1) == 0) { // swap: pattern s.s.s.s.s.s. etc.
        x = _mm_shuffle_epi32(x,_MM_SHUFFLE(2,0,3,1));
        y = _mm_shuffle_epi32(y,_MM_SHUFFLE(3,1,2,0));
        z = _mm_shuffle_epi32(z,_MM_SHUFFLE(3,1,2,0));
      }
    }

    if ((round & 3) == 0) { // add constant
      x ^= _mm_set_epi32(0,0,0,0x9e377900);
      x ^= _mm_set_epi32(0,0,0,round);
    }
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

  // Uncomment for debug
  /* for (int i = 0; i < 3; i++) { */
  /*   for (int j = 0; j < 4; j++) { */
  /*     printf("%08x ", state[i*4+j]); */
  /*   } */
  /*   printf("\n"); */
  /* } */

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (state));

  /* Returning the number of encrypted bytes */
  return 48;
}
