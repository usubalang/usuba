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



DATATYPE v0, v1, v2, v3, v4, v5, v6, v7;


#ifdef STD
#define D DATATYPE
#define FOR(x) for (D x = 0; x <= 1; x++)
#define INIT(n0,n1,n2,n3,n4,n5,n6,n7) v##n0 = a; v##n1 = b; v##n2 = c; v##n3 = d; \
                                      v##n4 = e; v##n5 = f; v##n6 = g; v##n7 = h;
#define INIT_DIRECT() INIT(0,1,2,3,4,5,6,7)
#define INIT_INV()    INIT(7,6,5,4,3,2,1,0)
#define BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h)                            \
  ((h&1) | ((g&1)<<1) | ((f&1)<<2) | ((e&1)<<3)                         \
   | ((d&1)<<4) | ((c&1)<<5) | ((b&1)<<6) | ((a&1)<<7))
#define BITS_TO_INT8_INV(a,b,c,d,e,f,g,h)                               \
  ((a&1) | ((b&1)<<1) | ((c&1)<<2) | ((d&1)<<3)                         \
   | ((e&1)<<4) | ((f&1)<<5) | ((g&1)<<6) | ((h&1)<<7))

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
  FOR(a) FOR(b) FOR(c) FOR(d)
    FOR(e) FOR(f) FOR(g) FOR(h) {
    #ifdef INV
    INIT_INV();
    sbox();
    int in  = BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h);
    int out = BITS_TO_INT8_INV(v0,v1,v2,v3,v4,v5,v6,v7);
    #else
    INIT_DIRECT();
    sbox();
    int in  = BITS_TO_INT8_DIRECT(a,b,c,d,e,f,g,h);
    int out = BITS_TO_INT8_DIRECT(v0,v1,v2,v3,v4,v5,v6,v7);
    #endif
    
    if ( aes_table[in] != out ) {
      fprintf(stderr, "Error: %ld%ld%ld%ld%ld%ld%ld%ld => %ld%ld%ld%ld%ld%ld%ld%ld"
                      "(expected %d)\n",
              a,b,c,d,e,f,g,h,
              v0&1,v1&1,v2&1,v3&1,v4&1,v5&1,v6&1,v7&1,
              aes_table[in]);
      nbErr++;
    }
  }
  if (nbErr) {
    printf("Verif completed. %d error%s found.", nbErr,nbErr>1?"s":"");
  } else {
    printf("Verif completed. No errors.\n");
  }
}
#else
#define verif() printf("Verif not implemeted for this arch.\n");
#endif

// Set SBOX to "usuba" or "kivi" (or anything else you define yourself)
#define NB_LOOP 100000000
void speed() {
  for (int i = 0; i < 10000; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN sbox");
#endif
    sbox();
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-END");
#endif
  }
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    sbox();
  }
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP);

  FILE* fp = fopen("/dev/null","w");
  print();
}

int main() {
  //verif();
  speed();
}
