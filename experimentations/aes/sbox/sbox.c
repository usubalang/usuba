#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <stdint.h>

void sbox();

#define NO_RUNTIME
#ifdef STD
#include "STD.h"
#elif defined(SSE)
#include "SSE.h"
#elif defined(AVX)
#include "AVX.h"
#else
#error No architecture specified
#endif

#ifdef STD
#define print() FILE* fp = fopen("/dev/null","w");                  \
  fprintf(fp,"%ld%ld%ld%ld%ld%ld%ld%ld\n",v0,v1,v2,v3,v4,v5,v6,v7);
#elif defined(SSE)
#define print128(v) {                               \
    int64_t *v64 = (int64_t*) &v;                   \
    fprintf(fp,"%.16lx %.16lx\n", v64[1], v64[0]);   \
  }
#define p print128
#define print() FILE* fp = fopen("/dev/null","w");      \
  p(v0); p(v1); p(v2); p(v3); p(v4); p(v5); p(v6); p(v7);
#elif defined(AVX)
#define print256(v) {                                                   \
    int64_t *v64 = (int64_t*) &v;                                       \
    fprintf(fp,"%.16lx %.16lx %.16lx %.16lx\n",v64[3],v64[2],v64[1],v64[0]); \
  }
#define p print256
#define print() FILE* fp = fopen("/dev/null","w");          \
  p(v0); p(v1); p(v2); p(v3); p(v4); p(v5); p(v6); p(v7);
#endif



#ifdef UA_MACRO
#include "usuba_macro.c"
#elif defined(UA_FUN)
#include "usuba_fun.c"
#elif defined(UA_FUN_INLINE)
#include "usuba_fun_inline.c"
#else
#error Please define one of {UA_MACRO,UA_FUN,UA_FUN_INLINE}
#endif
#include "kivi_c.c"



#if defined(VERIF)
#define FOR(x) for (x = ZERO, i_##x = 0; i_##x <= 1; i_##x++, x = ONES)
#define BIT0(x) (*((int*)&x)&1)

#ifdef STD
#define NE(x,y) (x != y)
#elif defined(SSE)
#define NE(x,y) ({                              \
      uint64_t* a = (uint64_t*) &x;             \
      uint64_t* b = (uint64_t*) &y;             \
      a[0] != b[0] || a[1] != b[1];             \
    })
#elif defined(AVX)
#define NE(x,y) ({                                                  \
      uint64_t* a = (uint64_t*) &x;                                 \
      uint64_t* b = (uint64_t*) &y;                                 \
      a[0] != b[0] || a[1] != b[1] || a[2] != b[2] || a[3] != b[3]; \
    })
#endif


void verif_base() {
  int nbErr = 0;
  DATATYPE a, b, c, d, e, f, g, h,
    v0, v1, v2, v3, v4, v5, v6, v7;
  int i_a, i_b, i_c, i_d, i_e, i_f, i_g, i_h;
  FOR(a) FOR(b) FOR(c) FOR(d)
    FOR(e) FOR(f) FOR(g) FOR(h) {
    v0 = a; v1 = b; v2 = c; v3 = d; v4 = e; v5 = f; v6 = g; v7 = h;
    usuba(v0,v1,v2,v3,v4,v5,v6,v7);
    DATATYPE o0 = v0, o1 = v1, o2 = v2, o3 = v3, o4 = v4, o5 = v5, o6 = v6, o7 = v7;
    
    v0 = a; v1 = b; v2 = c; v3 = d; v4 = e; v5 = f; v6 = g; v7 = h;
    kivi(v0,v1,v2,v3,v4,v5,v6,v7);
    
    if ( NE(o0,v0) || NE(o1,v1) || NE(o2,v2) || NE(o3,v3) ||
         NE(o4,v4) || NE(o5,v5) || NE(o6,v6) || NE(o7,v7) ) {
      fprintf(stderr, "Error: %d%d%d%d%d%d%d%d => %d%d%d%d%d%d%d%d vs %d%d%d%d%d%d%d%d\n",
              BIT0(a),BIT0(b),BIT0(c),BIT0(d),BIT0(e),BIT0(f),BIT0(g),BIT0(h),
              BIT0(o0),BIT0(o1),BIT0(o2),BIT0(o3),BIT0(o4),BIT0(o5),BIT0(o6),BIT0(o7),
              BIT0(v0),BIT0(v1),BIT0(v2),BIT0(v3),BIT0(v4),BIT0(v5),BIT0(v6),BIT0(v7));
      nbErr++;
    }
  }
  if (nbErr) {
    printf("Verif (base) completed. %d error%s found.\n", nbErr,nbErr>1?"s":"");
  } else {
    printf("Verif (base) completed. No errors.\n");
  }
}

/* A random test is nice because it in the previous test, the registers
   are filled with 0s or 1s. Here, they'll be filled with random bits.
   This helps catch errors in the pshufb/d for example. */
#define NB_TESTS 100000
void verif_rand() {
  int nbErr = 0;
  DATATYPE a, b, c, d, e, f, g, h,
    v0, v1, v2, v3, v4, v5, v6, v7;

  for (int i = 0; i < NB_TESTS; i++) {
#ifdef STD
    a = rand(); b = rand(); c = rand(); d = rand();
    e = rand(); f = rand(); g = rand(); h = rand();
#elif defined(SSE)
    a = _mm_set_epi64x(rand(),rand()); b = _mm_set_epi64x(rand(),rand());
    c = _mm_set_epi64x(rand(),rand()); d = _mm_set_epi64x(rand(),rand());
    e = _mm_set_epi64x(rand(),rand()); f = _mm_set_epi64x(rand(),rand());
    g = _mm_set_epi64x(rand(),rand()); h = _mm_set_epi64x(rand(),rand());
#elif defined(AVX)
    a = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    b = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    c = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    d = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    e = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    f = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    g = _mm256_set_epi64x(rand(),rand(),rand(),rand());
    h = _mm256_set_epi64x(rand(),rand(),rand(),rand());
#endif
    v0 = a; v1 = b; v2 = c; v3 = d; v4 = e; v5 = f; v6 = g; v7 = h;
    usuba(v0,v1,v2,v3,v4,v5,v6,v7);
    DATATYPE o0 = v0, o1 = v1, o2 = v2, o3 = v3, o4 = v4, o5 = v5, o6 = v6, o7 = v7;
    
    v0 = a; v1 = b; v2 = c; v3 = d; v4 = e; v5 = f; v6 = g; v7 = h;
    kivi(v0,v1,v2,v3,v4,v5,v6,v7);
    
    if ( NE(o0,v0) || NE(o1,v1) || NE(o2,v2) || NE(o3,v3) ||
         NE(o4,v4) || NE(o5,v5) || NE(o6,v6) || NE(o7,v7) ) {
      nbErr++;
    }
  }
  if (nbErr) {
    printf("Verif (rand) completed. %d error%s found.\n", nbErr,nbErr>1?"s":"");
  } else {
    printf("Verif (rand) completed. No errors.\n");
  }
}


#endif

#ifdef USUBA
#define test_fun usuba
#elif defined(KIVI)
#define test_fun kivi
#else
#error Please define USUBA or KIVI.
#endif

#define NB_LOOP 100000000
void speed() {
  DATATYPE v0, v1, v2, v3, v4, v5, v6, v7;
  v0 = v1 = v2 = v3 = v4 = v5 = v6 = v7 = ONES;
  
  /* Warming up the caches */
  for (int i = 0; i < 10000; i++)
    test_fun(v0,v1,v2,v3,v4,v5,v6,v7);
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN sbox");
#endif
    test_fun(v0,v1,v2,v3,v4,v5,v6,v7);
  }
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-END");
#endif
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP);
  print(); /* prints the output to /dev/null to prevent wrong optimizations */
}



int main() {
  #ifdef VERIF
  verif_base();
  verif_rand();
  #endif
  speed();
}
