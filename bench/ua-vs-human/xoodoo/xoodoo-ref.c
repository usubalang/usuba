/*
Implementation by Ronny Van Keer, hereby denoted as "the implementer".

For more information, feedback or questions, please refer to our website:
https://keccak.team/

To the extent possible under law, the implementer has waived all copyright
and related or neighboring rights to the source code in this file.
http://creativecommons.org/publicdomain/zero/1.0/
*/

/* #define VERBOSE_LEVEL    0 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include "xoodoo-ref.h"


/* ---------------------------------------------------------------- */

#if defined(VERBOSE_LEVEL)

#else

#define Dump(text, a, level)

#endif


static void Xoodoo_Round( tXoodooLane * a, tXoodooLane rc )
{
    unsigned int x, y;
    tXoodooLane    b[NLANES];
    tXoodooLane    p[NCOLUMS];
    tXoodooLane    e[NCOLUMS];

    /* Theta: Column Parity Mixer */
    for (x=0; x<NCOLUMS; ++x)
        p[x] = a[index(x,0)] ^ a[index(x,1)] ^ a[index(x,2)];
    for (x=0; x<NCOLUMS; ++x)
        e[x] = ROTL32(p[(x-1)%4], 5) ^ ROTL32(p[(x-1)%4], 14);
    for (x=0; x<NCOLUMS; ++x)
        for (y=0; y<NROWS; ++y)
            a[index(x,y)] ^= e[x];
    Dump("Theta", a, 2);

    /* Rho-west: plane shift */
    for (x=0; x<NCOLUMS; ++x) {
        b[index(x,0)] = a[index(x,0)];
        b[index(x,1)] = a[index(x-1,1)];
        b[index(x,2)] = ROTL32(a[index(x,2)], 11);
    }
    memcpy( a, b, sizeof(b) );
    Dump("Rho-west", a, 2);

    /* Iota: round constant */
    a[0] ^= rc;
    Dump("Iota", a, 2);

    /* Chi: non linear layer */
    for (x=0; x<NCOLUMS; ++x)
        for (y=0; y<NROWS; ++y)
            b[index(x,y)] = a[index(x,y)] ^ (~a[index(x,y+1)] & a[index(x,y+2)]);
    memcpy( a, b, sizeof(b) );
    Dump("Chi", a, 2);

    /* Rho-east: plane shift */
    for (x=0; x<NCOLUMS; ++x) {
        b[index(x,0)] = a[index(x,0)];
        b[index(x,1)] = ROTL32(a[index(x,1)], 1);
        b[index(x,2)] = ROTL32(a[index(x+2,2)], 8);
    }
    memcpy( a, b, sizeof(b) );
    Dump("Rho-east", a, 2);

}

static const uint32_t    RC[MAXROUNDS] = {
    _rc12,
    _rc11,
    _rc10,
    _rc9,
    _rc8,
    _rc7,
    _rc6,
    _rc5,
    _rc4,
    _rc3,
    _rc2,
    _rc1
};

void Xoodoo_Permute_Nrounds(tXoodooLane a[NLANES], uint32_t nr )
{
    unsigned int    i;

    for (i = MAXROUNDS - nr; i < MAXROUNDS; ++i ) {
        Xoodoo_Round( a, RC[i] );
        Dump("Round", a, 1);
    }
    Dump("Permutation", a, 0);

}

void Xoodoo_Permute_12rounds( uint32_t * state)
{
    Xoodoo_Permute_Nrounds( state, 12 );
}


/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  uint32_t input__[3*4] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Outputs */
  /* Primitive call */
  Xoodoo_Permute_12rounds(input__);

  // Uncomment for debug
  /* for (int i = 0; i < 3; i++) { */
  /*   printf("%08x %08x %08x %08x\n", */
  /*          input__[i*4], input__[i*4+1], input__[i*4+2], input__[i*4+3]); */
  /* } */

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (input__));

  /* Returning the number of encrypted bytes */
  return 48;
}
