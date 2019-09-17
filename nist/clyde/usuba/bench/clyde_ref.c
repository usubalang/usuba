/* Spook Reference Implementation v1
 *
 * Written in 2019 at UCLouvain (Belgium) by Olivier Bronchain, Gaetan Cassiers
 * and Charles Momin.
 * To the extent possible under law, the author(s) have dedicated all copyright
 * and related and neighboring rights to this software to the public domain
 * worldwide. This software is distributed without any warranty.
 *
 * You should have received a copy of the CC0 Public Domain Dedication along with
 * this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
 */
#include <string.h>
#include <stdint.h>

#define CLYDE128_NBYTES 16


/* Content of utils.c is inlined here */
// XOR buffers src1 and src2 into buffer dest (all buffers contain n bytes).
void xor_bytes(unsigned char* dest, const unsigned char* src1,
               const unsigned char* src2, unsigned long long n) {
  for (unsigned long long i = 0; i < n; i++) {
    dest[i] = src1[i] ^ src2[i];
  }
}

// Rotate right x by amount c.
// We use right rotation of integers for the lboxes while the specification
// tells left rotation of bitstrings due to the bitsting -> integer
// little-endian mapping used in Spook.
uint32_t rotr(uint32_t x, unsigned int c) { return (x >> c) | (x << (32 - c)); }

// Convert 4 bytes into a uint32. Bytes are in little-endian.
uint32_t le32u_dec(const unsigned char bytes[4]) {
  uint32_t res = 0;
  for (unsigned int col = 0; col < 4; col++) {
    res |= ((uint32_t)bytes[col]) << 8 * col;
  }
  return res;
}

// Convert a uint32 into 4 bytes. Bytes are in little-endian.
void le32u_enc(unsigned char bytes[4], uint32_t x) {
  for (unsigned int i = 0; i < 4; i++) {
    bytes[i] = x >> 8 * i;
  }
}


#define CLYDE_128_NS 6                // Number of steps
#define CLYDE_128_NR 2 * CLYDE_128_NS // Number of rounds

#define LS_ROWS 4      // Rows in the LS design
#define LS_ROW_BYTES 4 // number of bytes per row in the LS design

static void sbox_layer(uint32_t* state);
static void lbox(uint32_t* x, uint32_t* y);
static void lbox_layer(uint32_t* state);
static void bytes2state(uint32_t* state, const unsigned char* byte);
static void state2bytes(unsigned char* bytes, const uint32_t* state);
static void xor_ls_state(uint32_t* state, const uint32_t* x);
static void add_rc(uint32_t state[LS_ROWS], unsigned int round,
                   unsigned int shift);
static void tweakey(unsigned char tk[3][CLYDE128_NBYTES],
                    const unsigned char* k, const unsigned char* t);

// Round constants for Clyde-128
static const uint32_t clyde128_rc[CLYDE_128_NR][LS_ROWS] = {
  { 1, 0, 0, 0 }, // 0
  { 0, 1, 0, 0 }, // 1
  { 0, 0, 1, 0 }, // 2
  { 0, 0, 0, 1 }, // 3
  { 1, 1, 0, 0 }, // 4
  { 0, 1, 1, 0 }, // 5
  { 0, 0, 1, 1 }, // 6
  { 1, 1, 0, 1 }, // 7
  { 1, 0, 1, 0 }, // 8
  { 0, 1, 0, 1 }, // 9
  { 1, 1, 1, 0 }, // 10
  { 0, 1, 1, 1 }  // 11
};

// Apply a S-box layer to a Clyde-128 state.
static void sbox_layer(uint32_t* state) {
  uint32_t y1 = (state[0] & state[1]) ^ state[2];
  uint32_t y0 = (state[3] & state[0]) ^ state[1];
  uint32_t y3 = (y1 & state[3]) ^ state[0];
  uint32_t y2 = (y0 & y1) ^ state[3];
  state[0] = y0;
  state[1] = y1;
  state[2] = y2;
  state[3] = y3;
}

// Apply a L-box to a pair of Clyde-128 rows.
static void lbox(uint32_t* x, uint32_t* y) {
  uint32_t a, b, c, d;
  a = *x ^ rotr(*x, 12);
  b = *y ^ rotr(*y, 12);
  a = a ^ rotr(a, 3);
  b = b ^ rotr(b, 3);
  a = a ^ rotr(*x, 17);
  b = b ^ rotr(*y, 17);
  c = a ^ rotr(a, 31);
  d = b ^ rotr(b, 31);
  a = a ^ rotr(d, 26);
  b = b ^ rotr(c, 25);
  a = a ^ rotr(c, 15);
  b = b ^ rotr(d, 15);
  *x = a;
  *y = b;
}

// Apply a L-box layer to a Clyde-128 state.
static void lbox_layer(uint32_t* state) {
  lbox(&state[0], &state[1]);
  lbox(&state[2], &state[3]);
}

// Convert bytes to a Clyde-128 state. Bytes are in ordered by row (first-row
// first), and in little-endian order inside a row.
static void bytes2state(uint32_t* state, const unsigned char* bytes) {
  for (unsigned int row = 0; row < LS_ROWS; row++) {
    state[row] = le32u_dec(bytes + 4 * row);
  }
}

// Convert Clyde-128 state to bytes. Bytes are in ordered by row (first-row
// first), and in little-endian order inside a row.
static void state2bytes(unsigned char* bytes, const uint32_t* state) {
  for (unsigned int row = 0; row < LS_ROWS; row++) {
    le32u_enc(bytes + 4 * row, state[row]);
  }
}

// XOR the Clyde-128 state x into state.
static void xor_ls_state(uint32_t* state, const uint32_t* x) {
  for (unsigned int i = 0; i < LS_ROWS; i++) {
    state[i] ^= x[i];
  }
}

// XOR the Clyde-128 round constant of given round into state, left shifting
// each constant by shift.
static void add_rc(uint32_t state[LS_ROWS], unsigned int round,
                   unsigned int shift) {
  for (unsigned int i = 0; i < LS_ROWS; i++) {
    state[i] ^= clyde128_rc[round][i] << shift;
  }
}

// Key schedule for Clyde-128. Generate 3 Clyde-128 states from key k and tweak
// t.
static void tweakey(unsigned char tk[3][CLYDE128_NBYTES],
                    const unsigned char* k, const unsigned char* t) {
  const unsigned char* t0 = t;
  const unsigned char* t1 = t + CLYDE128_NBYTES / 2;
  unsigned char tx[CLYDE128_NBYTES / 2];
  xor_bytes(tx, t0, t1, CLYDE128_NBYTES / 2);
  // TK[0]
  xor_bytes(tk[0], k, t, CLYDE128_NBYTES);
  // TK[1]
  xor_bytes(tk[1], k, tx, CLYDE128_NBYTES / 2);
  xor_bytes(tk[1] + CLYDE128_NBYTES / 2, k + CLYDE128_NBYTES / 2, t0,
            CLYDE128_NBYTES / 2);
  // TK[2]
  xor_bytes(tk[2], k, t1, CLYDE128_NBYTES / 2);
  xor_bytes(tk[2] + CLYDE128_NBYTES / 2, k + CLYDE128_NBYTES / 2, tx,
            CLYDE128_NBYTES / 2);
}


// Clyde-128 TBC.
// Output in buffer c the TBC for block m, tweak t and key k.
// All buffers have length CLYDE128_NBYTES.
void clyde128_encrypt(unsigned char* c, uint32_t* state,
                      const unsigned char* t, const unsigned char* k) {
  // Key schedule
  unsigned char tkb[3][CLYDE128_NBYTES];
  uint32_t tk[3][LS_ROWS];
  tweakey(tkb, k, t);
  bytes2state(tk[0], tkb[0]);
  bytes2state(tk[1], tkb[1]);
  bytes2state(tk[2], tkb[2]);

  // Datapath
  xor_ls_state(state, tk[0]);
  for (unsigned int s = 0; s < CLYDE_128_NS; s++) {
    for (unsigned int rho = 0; rho < 2; rho++) {
      unsigned int r = 2 * s + rho;
      sbox_layer(state);
      lbox_layer(state);
      add_rc(state, r, 0);
    }
    xor_ls_state(state, tk[(s + 1) % 3]);
  }
  state2bytes(c, state);
}


/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  uint32_t state__[4] = { 0 };
  unsigned char key__[4*4] = { 0 };
  unsigned char tweak__[4*4] = { 0 };
  /* outputs */
  unsigned char cipher__[4*4] = { 0 };
  /* fun call */
  clyde128_encrypt(cipher__, state__, key__, tweak__);

  /* Returning the number of encrypted bytes */
  return 16;
}
