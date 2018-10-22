#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>

#include "ortho_aes.c"
#define ortho_ref(data) bitslice(data[0],data[1],data[2],data[3],\
                                 data[4],data[5],data[6],data[7]);


#include "ortho.h"
#define ortho_ua orthogonalize


#define MAKE_SPEED_FUN1(name,BUFF_SIZE,NB_LOOP,FUN_CALL)        \
  void speed_##name() {                                         \
    __m128i data[BUFF_SIZE];                                    \
                                                                \
    /* Initializing the data  */                                \
    for (int i = 0; i < BUFF_SIZE*2; i++)                       \
      ((uint64_t*)data)[i] = rand();                            \
                                                                \
    /* Warming up the cache */                                  \
    for (int i = 0; i < 10000; i++)                             \
      FUN_CALL;                                                 \
                                                                \
    /* The actual mesure */                                     \
    uint64_t timer = _rdtsc();                                  \
    for (int i = 0; i < NB_LOOP; i++)                           \
      FUN_CALL;                                                 \
    timer = _rdtsc() - timer;                                   \
                                                                \
    /* Printing the result */                                   \
    printf("%3s: %lu cycles\n", #name,timer / NB_LOOP);         \
    FILE* FP = fopen("/dev/null","w");                          \
    fwrite(data,BUFF_SIZE,8,FP);                                \
  }

#define NB_LOOP 100000000

MAKE_SPEED_FUN1(ua,8,NB_LOOP,ortho_ua(data,8,3,0))
MAKE_SPEED_FUN1(ref,8,NB_LOOP,ortho_ref(data))

int main() {
  speed_ua();
  speed_ref();
}
