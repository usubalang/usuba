#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <inttypes.h>


#define WARMUP 1000
#define NB_RUN_BITSLICE 200000000

#if ! (defined(AVX) || defined(SSE) || defined(GP))
#define SSE
#endif


#ifdef AVX
#define DATATYPE __m256i
#define REG_SIZE (sizeof(__m256i)*8)
#define ZERO _mm256_setzero_si256()
#define INIT() _mm256_set_epi32(rand(), rand(), rand(), rand(),rand(), rand(), rand(), rand())
#define ASM_MOD "x"
#elif defined(SSE)
#define DATATYPE __m128i
#define REG_SIZE (sizeof(__m128i)*8)
#define ZERO _mm_setzero_si128()
#define INIT() _mm_set_epi32(rand(), rand(), rand(), rand())
#define ASM_MOD "x"
#elif defined(GP)
#define DATATYPE int
#define ZERO 0
#define REG_SIZE (sizeof(int)*8)
#define INIT() rand()
#define ASM_MOD "r"
#else
#error SSE or GP must be defined
#endif

#ifdef VOLATILE
#define _VOLATILE volatile
#endif


#define full_adder(_a,_b,_c,_res) {             \
    DATATYPE _res_tmp = _a ^ _b ^ _c;           \
    _c = (_a & _b) ^ (_c & (_a ^ _b));          \
    _res = _res_tmp;                            \
  }


#include "adder_bs.c"


int main() {
  speed_bitslice();
}
