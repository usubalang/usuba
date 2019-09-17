#include <stdlib.h>
#include <stdint.h>

#include "drygascon128_ref.h"
#include "drysponge_ref.h"

/* Additional functions */
uint32_t bench_speed() {
  DRYSPONGE_t ctx;
  memset(ctx.c,0,40);
  ctx.rounds = 11;
  DRYSPONGE_g(&ctx);

  /* Returning the number of encrypted bytes */
  return 56;
}
