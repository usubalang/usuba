
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>
#include <sched.h>
#include <unistd.h>

#define NB_LOOP 100
#define NB_SEED 15

#include "des.h"


uint64_t rand_zero(uint64_t* state) {
  return 0UL;
}

uint64_t rand_full(uint64_t* state) {
  return -1UL;
}

uint64_t rand_ulong(uint64_t* state) {
  *state = *state * 6364136223846793005 + 1442695040888963407;
  return *state;
}

static uint64_t (*rand_)(uint64_t* state);

void orthogonalize(uint64_t* data, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
}

void unorthogonalize(uint64_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
}


#define KEY_SIZE   64

int main(int argc, char** argv) {

  uint64_t state;

  // Hardcoding a key for now...
  uint64_t key_std = 0x133457799BBCDFF1;
  unsigned long *key_ortho = malloc(64*sizeof *key_ortho);
  unsigned long *key_cst   = malloc(64*sizeof *key_cst);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = key_cst[63-i] = 0;
    else
      key_ortho[63-i] = key_cst[63-i] = -1;

  struct sched_param params;
  params.sched_priority = sched_get_priority_max(SCHED_FIFO);
  int ret = sched_setscheduler(getpid(), SCHED_FIFO, &params);
  if (ret != 0) {
    printf("Unsuccessful in setting thread realtime prio\n");
    return -1;
  }

  // Allocating various stuffs
  unsigned long *plain_ortho  = malloc(64*sizeof *plain_ortho);
  unsigned long *cipher_ortho = malloc(64*sizeof *cipher_ortho);
  uint64_t *plain_std = malloc(64*sizeof *plain_std);

  printf("loop\tseed\ttime\n");
  for (int i = 0; i < NB_LOOP; i++) {
    for (int seed = 0; seed < NB_SEED; seed++){

      if (seed == 0) {
        rand_ = &rand_zero;
      } else if (seed == 1) {
        rand_ = &rand_full;
      } else {
        rand_ = &rand_ulong;
      }

      state = 1 << seed;

      for (int i = 0; i < 64; i++) plain_std[i] = (*rand_)(&state);
      for (int i = 0; i < 64; i++) plain_std[i] ^= (*rand_)(&state);

      for (int i = 0; i < 64; i++){
        orthogonalize(plain_std, plain_ortho);
        des__(plain_ortho, key_ortho, cipher_ortho);
        unorthogonalize(cipher_ortho,plain_std);
      }

      orthogonalize(plain_std, plain_ortho);

      uint64_t timer = _rdtsc();
      for (int i = 0; i < 64; i++){
        des__(plain_ortho, key_ortho, cipher_ortho);
      }
      timer = _rdtsc() - timer;

      unorthogonalize(cipher_ortho,plain_std);
      printf("%d\t%d\t%ld\n", i, seed, timer);
    }
  }

  return 0;
}
