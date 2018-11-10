#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>
#include <string.h>
#include <time.h>

#define MAKE_VERIF_FUN1(BUFF_SIZE,UA_CALL,REF_CALL)                     \
  void verif() {                                                        \
    __m128i data[BUFF_SIZE];                                            \
                                                                        \
    for (int i = 0; i < 10000; i++) {                                   \
                                                                        \
      for (int i = 0; i < BUFF_SIZE*2; i++)                             \
        ((uint64_t*)data)[i] = rand();                                  \
      __m128i input_copy[BUFF_SIZE];                                    \
      memcpy(input_copy,data,BUFF_SIZE*16);                             \
                                                                        \
      UA_CALL;                                                          \
      __m128i ua_output[BUFF_SIZE];                                     \
      memcpy(ua_output,data,BUFF_SIZE*16);                              \
                                                                        \
      memcpy(data,input_copy,BUFF_SIZE*16);                             \
      REF_CALL;                                                         \
                                                                        \
      if (memcmp(ua_output,data,BUFF_SIZE*16) != 0) {                   \
        fprintf(stderr, "Error: functions not equivalent.\n");          \
        exit(EXIT_FAILURE);                                             \
      }                                                                 \
    }                                                                   \
  }                                                                     \

  
  

/* name: the name of the function to generate (will be "speed_##name")
         the input buffer is always called "data" and has type __128i.
   BUFF_SIZE: the size of the buffer to transpose (in __m128i)
   NB_LOOP: how many iteration to the bench
   FUN_CALL: how to call the transposition */
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


#include "ortho.h"
#define ortho_ua orthogonalize


/* ********************************* AES ******************************* */
#ifdef AES
#define NB_LOOP 100000000

#include "ortho_aes.c"
#define ortho_ref(data) bitslice(data[0],data[1],data[2],data[3],\
                                 data[4],data[5],data[6],data[7]);

MAKE_VERIF_FUN1(8,ortho_ua(data,8,3,0),ortho_ref(data))
MAKE_SPEED_FUN1(ua,8,NB_LOOP,ortho_ua(data,8,3,0))
MAKE_SPEED_FUN1(ref,8,NB_LOOP,ortho_ref(data))

/* ******************************* Serpent ***************************** */
#elif defined(Serpent)
#define NB_LOOP 100000000

#include "ortho_serpent.c"
#define ortho_ref(data) TRANSPOSE4(data[0],data[1],data[2],data[3])

MAKE_VERIF_FUN1(4,ortho_ua(data,4,2,5),ortho_ref(data))
MAKE_SPEED_FUN1(ua,4,NB_LOOP,ortho_ua(data,4,2,5))
MAKE_SPEED_FUN1(ref,4,NB_LOOP,ortho_ref(data))

/* ********************************* DES ******************************* */
#elif defined(DES)
#define NB_LOOP 5000000

#include "ortho_des.c"
#define ortho_ref(data) ortho_128x64(data)

MAKE_VERIF_FUN1(64,ortho_ua(data,64,6,0),ortho_ref(data))
MAKE_SPEED_FUN1(ua,64,NB_LOOP,ortho_ua(data,64,6,0))
MAKE_SPEED_FUN1(ref,64,NB_LOOP,ortho_ref(data))

#endif


int main() {
  srand(time(NULL));
  
  speed_ua();
  speed_ref();
}
