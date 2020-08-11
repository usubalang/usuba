/* MIT License
 *
 * Copyright (c) 2019 Gaëtan Cassiers
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

// NOTE(Darius Mercadier): the original file is available at
// https://git-crypto.elen.ucl.ac.be/spook/spook-he/-/blob/master/src/clyde_64bit.c.
// I've just reworked it a bit for my benchmarks, but the essence
// remains unchanged.

#include <string.h>
#include <stdint.h>

#define CLYDE128_NBYTES 16
#define LS_ROWS 4      // Rows in the LS design
typedef __attribute__((aligned(16))) uint64_t clyde128_state[LS_ROWS/2];


#define CLYDE_128_NS 6                // Number of steps
#define CLYDE_128_NR 2 * CLYDE_128_NS // Number of rounds

static const uint64_t clyde128_rc_mbx[CLYDE_128_NR][2] = {
  { 2, 0 }, // 0
  { 1, 0 }, // 1
  { 0, 2 }, // 2
  { 0, 1 }, // 3
  { 3, 0 }, // 4
  { 1, 2 }, // 5
  { 0, 3 }, // 6
  { 3, 1 }, // 7
  { 2, 2 }, // 8
  { 1, 1 }, // 9
  { 3, 2 }, // 10
  { 1, 3 }  // 11
};

#include <immintrin.h>
#define ROT64(x,n) ((uint64_t)(((x)>>(n))|((x)<<(64-(n)))))

static uint64_t lbox_enc(uint64_t c) {
  uint64_t a, b;
  a  = c ^ ROT64(c,24); // 0x0000000001000001
  a ^=     ROT64(a, 6); // 0x0000000041000041
  a ^=     ROT64(c,34); // 0x0000000441000041
  b  = a ^ ROT64(a,62); // 0x4000000551400051
  a ^=     ROT64(b,51); // 0x028a0004412a8a41
  a ^=     ROT64(b,30); // 0x56da0010112a8a40
  return a;
}
static void sbox_enc(uint64_t *a, uint64_t *b) {
    uint64_t s0 = (*a >> 1) & 0x5555555555555555LL;
    uint64_t s1 = (*a) & 0x5555555555555555LL;
    uint64_t s2 = (*b >> 1) & 0x5555555555555555LL;
    uint64_t s3 = (*b) & 0x5555555555555555LL;
    uint64_t y1 = (s0 & s1) ^ s2;
    uint64_t y0 = (s3 & s0) ^ s1;
    uint64_t y3 = (y1 & s3) ^ s0;
    uint64_t y2 = (y0 & y1) ^ s3;
    *a = (y0 << 1) | y1;
    *b = (y2 << 1) | y3;
}

#define MXB_ENC(x, y) (_pdep_u64((y), 0x5555555555555555LL) | _pdep_u64((x), 0xaaaaaaaaaaaaaaaaLL))
#define MXB_DECX(a) ((uint32_t) _pext_u64((a), 0xaaaaaaaaaaaaaaaaLL))
#define MXB_DECY(a) ((uint32_t) _pext_u64((a), 0x5555555555555555LL))

void clyde128_encrypt(uint64_t state[2], const uint64_t t[2], const uint64_t k_st[2]) {

  uint64_t t_a = t[0];
  uint64_t t_b = t[1];
  uint64_t k_a = k_st[0];
  uint64_t k_b = k_st[1];
  uint64_t t_x = t_a ^ t_b;
  uint64_t tk[3][2] = {
      { t_a ^ k_a, t_b ^ k_b },
      { t_x ^ k_a, t_a ^ k_b },
      { t_b ^ k_a, t_x ^ k_b }
  };

  // Datapath
  uint64_t s_a = state[0];
  uint64_t s_b = state[1];
  s_a ^= tk[0][0];
  s_b ^= tk[0][1];
  for (unsigned int s = 0; s < CLYDE_128_NS; s++) {
      unsigned int r = 2 * s;
      sbox_enc(&s_a, &s_b);
      s_a = lbox_enc(s_a);
      s_b = lbox_enc(s_b);
      s_a ^= clyde128_rc_mbx[r][0];
      s_b ^= clyde128_rc_mbx[r][1];
      sbox_enc(&s_a, &s_b);
      s_a = lbox_enc(s_a);
      s_b = lbox_enc(s_b);
      s_a ^= clyde128_rc_mbx[r+1][0];
      s_b ^= clyde128_rc_mbx[r+1][1];
      unsigned int off = (s+1)%3;
      s_a ^= tk[off][0];
      s_b ^= tk[off][1];
  }
  state[0] = s_a;
  state[1] = s_b;
}


/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  uint64_t state__[2] = { 0 };
  uint64_t key__[2] = { 0 };
  uint64_t tweak__[2] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (state__));
  asm volatile("" : "+m" (key__));
  asm volatile("" : "+m" (tweak__));

  /* Primitive call */
  clyde128_encrypt(state__, key__, tweak__);

  //  printf("%016lx %016lx\n", state__[0], state__[1]);

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (state__));

  /* Returning the number of encrypted bytes */
  return 16;
}
