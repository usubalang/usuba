#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#define TRANSPOSE4(row0, row1, row2, row3)                  \
  do {                                                      \
    __m128 tmp3, tmp2, tmp1, tmp0;                          \
    tmp0 = _mm_unpacklo_ps((__m128)(row0), (__m128)(row1)); \
    tmp2 = _mm_unpacklo_ps((__m128)(row2), (__m128)(row3)); \
    tmp1 = _mm_unpackhi_ps((__m128)(row0), (__m128)(row1)); \
    tmp3 = _mm_unpackhi_ps((__m128)(row2), (__m128)(row3)); \
    row0 = (__m128i)_mm_movelh_ps(tmp0, tmp2);              \
    row1 = (__m128i)_mm_movehl_ps(tmp2, tmp0);              \
    row2 = (__m128i)_mm_movelh_ps(tmp1, tmp3);              \
    row3 = (__m128i)_mm_movehl_ps(tmp3, tmp1);              \
  } while (0)


#define NB_LOOP 300000000

int main() {
  __m128i data[4];
  for (int i = 0; i < 4; i++)
    data[i] = _mm_set_epi64x(rand(),rand());

  for (int i = 0; i < 100000; i++)
    TRANSPOSE4(data[0], data[1], data[2], data[3]);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    TRANSPOSE4(data[0], data[1], data[2], data[3]);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (16*4));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,16,4,FP);
  fclose(FP);
}
