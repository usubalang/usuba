#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>



void print64bin (const unsigned long n) {
  for (int i = 1; i <= 64; i++) {
    printf("%lu",(n>>(64-i)) & 1);
  }
}

void print128bin (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}

void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
  /* printf("%016lx%016lx\n",((unsigned long*)bytearray)[0], ((unsigned long *)bytearray)[1]); */
}


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

void orthogonalize_t(__m128i data[]) {

  __m128i mask_l[7] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm_set1_epi64x(0xffff0000ffff0000UL),
    _mm_set1_epi64x(0xffffffff00000000UL),
    _mm_set_epi64x(0x0000000000000000UL,0xffffffffffffffffUL),
  
  };

  __m128i mask_r[1] = {
    _mm_set1_epi64x(0x00000000ffffffffUL)
  };
  /* puts(""); */
  /* for (int i = 0; i < 7; i++) print128hex(mask_l[i]); */
  
  for (int j = 0; j < 4; j += 2) {
        
    __m128i u = _mm_and_si128(data[j], mask_l[0]);
    
    __m128i v = _mm_and_si128(data[j], mask_r[0]);
    __m128i x = _mm_and_si128(data[j + 1], mask_l[0]);
    __m128i y = _mm_and_si128(data[j + 1], mask_r[0]);
    data[j] = _mm_or_si128(u, _mm_srli_epi64(x, 32));
    data[j + 1] = _mm_or_si128(_mm_slli_epi64(v, 32), y);
    /* puts(""); */
    /* for (int i = 0; i < 4; i++) print128hex(data[i]); */
  }
}


#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define _L_SHIFT_SMALL(a,b,c) _mm_slli_epi##c(a,b)
#define L_SHIFT_SMALL(a,b,c) _L_SHIFT_SMALL(a,b,c)
#define _L_SHIFT_x8(a,b,c) _mm_srli_si##c(a, 8)
#define L_SHIFT_x8(a,b,c) _L_SHIFT_x8(a,b,c)
#define _R_SHIFT_SMALL(a,b,c) _mm_srli_epi##c(a,b)
#define R_SHIFT_SMALL(a,b,c) _R_SHIFT_SMALL(a,b,c)
#define _R_SHIFT_x8(a,b,c)  _mm_slli_si##c(a, 8)
#define R_SHIFT_x8(a,b,c) _R_SHIFT_x8(a,b,c)

static inline void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
  DATATYPE mask_l[] = {
    SET1_EPI64(0xaaaaaaaaaaaaaaaaUL),
    SET1_EPI64(0xccccccccccccccccUL),
    SET1_EPI64(0xf0f0f0f0f0f0f0f0UL),
    SET1_EPI64(0x00ff00ff00ff00ffUL),
    SET1_EPI64(0x0000ffff0000ffffUL),
    SET1_EPI64(0x00000000ffffffffUL),
    SET_EPI64_2(0x0000000000000000UL,0xffffffffffffffffUL),
    SET_EPI64_4(0x0000000000000000UL,0x0000000000000000UL,
                0xffffffffffffffffUL,0xffffffffffffffffUL)
  };
  
  DATATYPE mask_r[] = {
    SET1_EPI64(0x5555555555555555UL),
    SET1_EPI64(0x3333333333333333UL),
    SET1_EPI64(0x0f0f0f0f0f0f0f0fUL),
    SET1_EPI64(0xff00ff00ff00ff00UL),
    SET1_EPI64(0xffff0000ffff0000UL),
    SET1_EPI64(0xffffffff00000000UL),
    SET_EPI64_2(0xffffffffffffffffUL,0x0000000000000000UL),
    SET_EPI64_4(0xffffffffffffffffUL,0xffffffffffffffffUL,
                0x0000000000000000UL,0x0000000000000000UL)
  };

  for (int i = 0; i < LOG2_M; i++) {
    int n = 1UL << i;
    for (int j = 0; j < M; j += 2*n) {
      for (int k = 0; k < n; k++) {
        DATATYPE u = AND(data[j + k], mask_l[LOG2_A+i]);
        DATATYPE v = AND(data[j + k], mask_r[LOG2_A+i]);
        DATATYPE x = AND(data[j + n + k], mask_l[LOG2_A+i]);
        DATATYPE y = AND(data[j + n + k], mask_r[LOG2_A+i]);
        if ((i+LOG2_A) <= 2) {
          data[j + k] =     OR(u, R_SHIFT_SMALL(x,(1UL << (i+LOG2_A)),64));
          data[j + n + k] = OR(L_SHIFT_SMALL(v,(1UL << (i+LOG2_A)),64), y);
        }
        else if ((i+LOG2_A) <= 5) {
          data[j + k] = OR(u, L_SHIFT(x,(1UL << (i+LOG2_A)),64));
          data[j + n + k] =OR(R_SHIFT(v,(1UL << (i+LOG2_A)),64), y);
        } else {
          data[j + k] = OR(u, R_SHIFT_x8(x,i+LOG2_A,BITS_PER_REG));
          data[j + n + k] =OR(L_SHIFT_x8(v,i+LOG2_A,BITS_PER_REG), y);
        }
      }
    }
  }
}
#pragma pop_macro("L_SHIFT")
#pragma pop_macro("R_SHIFT")


#define NB_LOOP 100000000

void eval_speed() {

  __m128i data[4];
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < 100000; i++)
    //TRANSPOSE4(data[0],data[1],data[2],data[3]);
    orthogonalize(data,4,2,5);
  timer = _rdtsc() - timer;
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    //TRANSPOSE4(data[0],data[1],data[2],data[3]);
    orthogonalize(data,4,2,5);
  timer = _rdtsc() - timer;
  printf("Cycles per ortho: %lu\n", timer / NB_LOOP);
  
  FILE* f = fopen("/dev/null","r");
  fwrite(data,4,16,f);

}

void visual() {

  __m128i data[4];
  data[0] = _mm_set_epi32(0x33333333, 0x22222222, 0x11111111, 0x00000000);
  data[1] = _mm_set_epi32(0x77777777, 0x66666666, 0x55555555, 0x44444444);
  data[2] = _mm_set_epi32(0xBBBBBBBB, 0xAAAAAAAA, 0x99999999, 0x88888888);
  data[3] = _mm_set_epi32(0xFFFFFFFF, 0xEEEEEEEE, 0xDDDDDDDD, 0xCCCCCCCC);

  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");

  //TRANSPOSE4(data[0],data[1],data[2],data[3]);
  //orthogonalize(data);
  orthogonalize(data,4,2,5);
  
  
  for (int i = 0; i < 4; i++) print128hex(data[i]);
  
  
}

int main() {

  eval_speed();
  //visual();
  
  return 0;
  
}
