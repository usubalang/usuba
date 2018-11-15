#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#define TRANSPOSE4(x0, x1, x2, x3)              \
  do {                                          \
    __m256i t0, t1, t2;                         \
                                                \
    t0 = _mm256_unpacklo_epi32(x1,x0);          \
    t2 = _mm256_unpackhi_epi32(x1,x0);          \
    t1 = _mm256_unpacklo_epi32(x3,x2);          \
    x3 = _mm256_unpackhi_epi32(x3,x2);          \
                                                \
    x0 = _mm256_unpacklo_epi64(t1,t0);          \
    x1 = _mm256_unpackhi_epi64(t1,t0);          \
    x2 = _mm256_unpacklo_epi64(x3,t2);          \
    x3 = _mm256_unpackhi_epi64(x3,t2);          \
  } while (0);



#define NB_LOOP 300000000

int main() {
  __m256i data[4];
  for (int i = 0; i < 4; i++)
    data[i] = _mm256_set_epi64x(rand(),rand(),rand(),rand());

  for (int i = 0; i < 100000; i++)
    TRANSPOSE4(data[0], data[1], data[2], data[3]);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    TRANSPOSE4(data[0], data[1], data[2], data[3]);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (32*4));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,32,4,FP);
  fclose(FP);
}
