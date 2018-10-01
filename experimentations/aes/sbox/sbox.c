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
#define print() fprintf(fp,"%ld%ld%ld%ld%ld%ld%ld%ld\n",v0,v1,v2,v3,v4,v5,v6,v7);
#elif defined(SSE)
#define print128(v) {                               \
    int64_t *v64 = (int64_t*) &v;                   \
    fprintf(fp,"%.16lx %.16lx\n", v64[1], v64[0]);   \
  }
#define p print128
#define print() p(v0); p(v1); p(v2); p(v3); p(v4); p(v5); p(v6); p(v7);
#elif defined(AVX)
#define print256(v) {                                                   \
    int64_t *v64 = (int64_t*) &v;                                       \
    fprintf(fp,"%.16lx %.16lx %.16lx %.16lx\n",v64[3],v64[2],v64[1],v64[0]); \
  }
#define p print256
#define print() p(v0); p(v1); p(v2); p(v3); p(v4); p(v5); p(v6); p(v7);
#endif



#ifdef USUBA
#include "usuba_base.c"
#elif defined(KIVI)
#define sbox(v7,v6,v5,v4,v3,v2,v1,v0)                                     \
__asm__ ("vpxor %6, %5, %5; vpxor %1, %2, %2; vpxor %0, %5, %%xmm8; vpxor %2, %6, %6; vpxor %0, %3, %3; vpxor %3, %6, %6; vpxor %7, %3, %3; vpxor %%xmm8, %7, %7; vpxor %4, %3, %3; vpxor %%xmm8, %4, %4; vpxor %1, %3, %3; vpxor %7, %2, %2; vpxor %%xmm8, %1, %1;; vpxor %7, %4, %%xmm11; vpxor %1, %2, %%xmm10; vpxor %%xmm8, %3, %%xmm9; vpxor %2, %4, %%xmm13; vpxor %6, %0, %%xmm12; vpxor %%xmm11, %%xmm10, %%xmm15; vpand %%xmm10, %%xmm9, %5; vpor %%xmm9, %%xmm10, %%xmm10; vpand %%xmm11, %%xmm12, %%xmm14; vpor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm9, %%xmm12, %%xmm12; vpand %%xmm12, %%xmm15, %%xmm15; vpxor %3, %0, %%xmm12; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %7, %1, %%xmm13; vpxor %%xmm8, %6, %%xmm12; vpor %%xmm13, %%xmm12, %%xmm9; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %5, %5; vpxor %%xmm15, %%xmm11, %%xmm11; vpxor %%xmm14, %%xmm10, %%xmm10; vpxor %%xmm15, %%xmm9, %%xmm9; vpxor %%xmm14, %5, %5; vpxor %%xmm14, %%xmm9, %%xmm9; vpand %2, %3, %%xmm12; vpand %4, %0, %%xmm13; vpand %1, %%xmm8, %%xmm14; vpor %7, %6, %%xmm15; vpxor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %%xmm14, %%xmm9, %%xmm9; vpxor %%xmm15, %5, %5; vpxor %%xmm11, %%xmm10, %%xmm12; vpand %%xmm9, %%xmm11, %%xmm11; vpxor %5, %%xmm11, %%xmm14; vpand %%xmm12, %%xmm14, %%xmm15; vpxor %%xmm10, %%xmm15, %%xmm15; vpxor %%xmm9, %5, %%xmm13; vpxor %%xmm10, %%xmm11, %%xmm11; vpand %%xmm11, %%xmm13, %%xmm13; vpxor %5, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm9, %%xmm9; vpxor %%xmm14, %%xmm13, %%xmm10; vpand %5, %%xmm10, %%xmm10; vpxor %%xmm10, %%xmm9, %%xmm9; vpxor %%xmm10, %%xmm14, %%xmm14; vpand %%xmm15, %%xmm14, %%xmm14; vpxor %%xmm12, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm10; vpand %6, %%xmm10, %%xmm10; vpxor %6, %%xmm8, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm8, %%xmm15, %5; vpxor %5, %%xmm12, %%xmm12; vpxor %%xmm10, %5, %5;; vpxor %0, %6, %6; vpxor %3, %%xmm8, %%xmm8; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %6, %%xmm11, %%xmm11; vpxor %%xmm8, %6, %6; vpand %%xmm14, %6, %6; vpand %%xmm15, %%xmm8, %%xmm8; vpxor %6, %%xmm8, %%xmm8; vpxor %%xmm11, %6, %6;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %0, %%xmm10, %%xmm10; vpxor %0, %3, %0; vpand %%xmm9, %0, %0; vpand %3, %%xmm13, %3; vpxor %3, %0, %0; vpxor %%xmm10, %3, %3;; vpxor %6, %0, %0; vpxor %%xmm12, %6, %6; vpxor %%xmm8, %3, %3; vpxor %5, %%xmm8, %%xmm8; vpxor %7, %4, %%xmm12; vpxor %1, %2, %5; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %%xmm12, %%xmm11, %%xmm11; vpxor %5, %%xmm12, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm15, %5, %5; vpxor %%xmm12, %5, %5; vpxor %%xmm11, %%xmm12, %%xmm12;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %4, %%xmm10, %%xmm10; vpxor %4, %2, %4; vpand %%xmm9, %4, %4; vpand %2, %%xmm13, %2; vpxor %2, %4, %4; vpxor %%xmm10, %2, %2;; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %7, %%xmm11, %%xmm11; vpxor %7, %1, %7; vpand %%xmm14, %7, %7; vpand %1, %%xmm15, %1; vpxor %1, %7, %7; vpxor %%xmm11, %1, %1;; vpxor %%xmm12, %7, %7; vpxor %%xmm12, %4, %4; vpxor %5, %1, %1; vpxor %5, %2, %2;;; vpxor %7, %0, %5; vpxor %1, %6, %%xmm9; vpxor %4, %5, %%xmm10; vpxor %6, %0, %%xmm12; vpxor %0, %%xmm9, %0; vpxor %%xmm8, %%xmm9, %1; vpxor %%xmm8, %2, %7; vpxor %2, %3, %6; vpxor %%xmm10, %7, %2; vpxor %3, %7, %4; vpxor %%xmm12, %4, %3;" : "+x" (v0), "+x" (v1), "+x" (v2), "+x" (v3), "+x" (v4), "+x" (v5), "+x" (v6), "+x" (v7) :: "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15");
#else
#error You need to defined USUBA or KIVI
#endif

/* register DATATYPE* v0 asm ("r14"); */
/* register DATATYPE* v1 asm ("r15"); */
/* register DATATYPE* v2 asm ("r8"); */
/* register DATATYPE* v3 asm ("r9"); */
/* register DATATYPE* v4 asm ("r10"); */
/* register DATATYPE* v5 asm ("r11"); */
/* register DATATYPE* v6 asm ("r12"); */
/* register DATATYPE* v7 asm ("r13"); */
/* DATATYPE v1, v2, v3, v4, v5, v6, v7; */



#if defined(VERIF)
#define D DATATYPE
#define FOR(x) for (x = ZERO, i_##x = 0; i_##x <= 1; i_##x++, x = ONES)
#define INIT(n0,n1,n2,n3,n4,n5,n6,n7) v##n0 = a; v##n1 = b; v##n2 = c; v##n3 = d; \
                                      v##n4 = e; v##n5 = f; v##n6 = g; v##n7 = h;
#define INIT_DIRECT() INIT(0,1,2,3,4,5,6,7)
#define INIT_INV()    INIT(7,6,5,4,3,2,1,0)
#define BIT0(x) (*((int*)&x)&1)
#define BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h)                            \
  ((BIT0(h)&1) | ((BIT0(g)&1)<<1) | ((BIT0(f)&1)<<2) | ((BIT0(e)&1)<<3) \
   | ((BIT0(d)&1)<<4) | ((BIT0(c)&1)<<5) | ((BIT0(b)&1)<<6) | ((BIT0(a)&1)<<7))
#define BITS_TO_INT8_INV(a,b,c,d,e,f,g,h)                               \
  ((BIT0(a)&1) | ((BIT0(b)&1)<<1) | ((BIT0(c)&1)<<2) | ((BIT0(d)&1)<<3) \
   | ((BIT0(e)&1)<<4) | ((BIT0(f)&1)<<5) | ((BIT0(g)&1)<<6) | ((BIT0(h)&1)<<7))


int aes_table[] = {
  99,  124, 119, 123, 242, 107, 111, 197, 48,  1,   103, 43,  254, 215, 171, 118,
  202, 130, 201, 125, 250, 89,  71,  240, 173, 212, 162, 175, 156, 164, 114, 192,
  183, 253, 147, 38,  54,  63,  247, 204, 52,  165, 229, 241, 113, 216, 49,  21,
  4,   199, 35,  195, 24,  150, 5,   154, 7,   18,  128, 226, 235, 39,  178, 117,
  9,   131, 44,  26,  27,  110, 90,  160, 82,  59,  214, 179, 41,  227, 47,  132,
  83,  209, 0,   237, 32,  252, 177, 91,  106, 203, 190, 57,  74,  76,  88,  207,
  208, 239, 170, 251, 67,  77,  51,  133, 69,  249, 2,   127, 80,  60,  159, 168,
  81,  163, 64,  143, 146, 157, 56,  245, 188, 182, 218, 33,  16,  255, 243, 210,
  205, 12,  19,  236, 95,  151, 68,  23,  196, 167, 126, 61,  100, 93,  25,  115,
  96,  129, 79,  220, 34,  42,  144, 136, 70,  238, 184, 20,  222, 94,  11,  219,
  224, 50,  58,  10,  73,  6,   36,  92,  194, 211, 172, 98,  145, 149, 228, 121,
  231, 200, 55,  109, 141, 213, 78,  169, 108, 86,  244, 234, 101, 122, 174, 8,
  186, 120, 37,  46,  28,  166, 180, 198, 232, 221, 116, 31,  75,  189, 139, 138,
  112, 62,  181, 102, 72,  3,   246, 14,  97,  53,  87,  185, 134, 193, 29,  158,
  225, 248, 152, 17,  105, 217, 142, 148, 155, 30,  135, 233, 206, 85,  40,  223,
  140, 161, 137, 13,  191, 230, 66,  104, 65,  153, 45,  15,  176, 84,  187, 22
};


void verif() {
  int nbErr = 0;
  DATATYPE a, b, c, d, e, f, g, h,
    v0, v1, v2, v3, v4, v5, v6, v7;
  int i_a, i_b, i_c, i_d, i_e, i_f, i_g, i_h;
  FOR(a) FOR(b) FOR(c) FOR(d)
    FOR(e) FOR(f) FOR(g) FOR(h) {
    #ifdef INV
    INIT_INV();
    sbox(v0,v1,v2,v3,v4,v5,v6,v7);
    int in  = BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h);
    int out = BITS_TO_INT8_INV(v0,v1,v2,v3,v4,v5,v6,v7);
    #else
    INIT_DIRECT();
    sbox(v0,v1,v2,v3,v4,v5,v6,v7);
    v1 = NOT(v1); v2 = NOT(v2); v6 = NOT(v6); v7 = NOT(v7);
    int in  = BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h);
    int out = BITS_TO_INT8_DIRECT(v0,v1,v2,v3,v4,v5,v6,v7);
    #endif
    
    if ( aes_table[in] != out ) {
      fprintf(stderr, "Error: %d%d%d%d%d%d%d%d => %d%d%d%d%d%d%d%d"
                      "(expected %d)\n",
              BIT0(a),BIT0(b),BIT0(c),BIT0(d),BIT0(e),BIT0(f),BIT0(g),BIT0(h),
              BIT0(v0),BIT0(v1),BIT0(v2),BIT0(v3),BIT0(v4),BIT0(v5),BIT0(v6),BIT0(v7),
              aes_table[in]);
      nbErr++;
    }
  }
  if (nbErr) {
    printf("Verif completed. %d error%s found.\n", nbErr,nbErr>1?"s":"");
  } else {
    printf("Verif completed. No errors.\n");
  }
}
#endif


#define NB_LOOP 100000000
void speed() {
  DATATYPE v0 = ONES, v1 = ONES, v2 = ONES, v3 = ONES,
    v4 = ONES, v5 = ONES, v6 = ONES, v7 = ONES;
  for (int i = 0; i < 10000; i++) {
    sbox(v0,v1,v2,v3,v4,v5,v6,v7);
  }
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN sbox");
#endif
    sbox(v0,v1,v2,v3,v4,v5,v6,v7);
  }
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-END");
#endif
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP);

  FILE* fp = fopen("/dev/null","w");
  print();
}



int main() {
  #ifdef VERIF
  verif();
  #endif
  speed();
}
