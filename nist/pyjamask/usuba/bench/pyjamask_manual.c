#include <stdint.h>

#define STATE_SIZE_128       4
#define NB_ROUNDS_128       14
#define NB_ROUNDS_KS        14

#define COL_M0        0xa3861085
#define COL_M1        0x63417021
#define COL_M2        0x692cf280
#define COL_M3        0x48a54813


volatile uint32_t __rand = 0;
static uint32_t get_random() {
  return __rand;
}

#define right_rotate(row) \
    row = (row >> 1) | (row << 31);

uint32_t mat_mult(uint32_t mat_col, uint32_t vec) {
  int i;
  uint32_t mask, res=0;

  for (i = 31; i>=0; i--) {
    mask = -((vec >> i) & 1);
    res ^= mask & mat_col;
    right_rotate(mat_col);
  }

  return res;
}

void mix_rows_128(uint32_t *state) {
  state[0] = mat_mult(COL_M0, state[0]);
  state[1] = mat_mult(COL_M1, state[1]);
  state[2] = mat_mult(COL_M2, state[2]);
  state[3] = mat_mult(COL_M3, state[3]);
}

void add_round_key_128(uint32_t *state, const uint32_t *round_key, int r) {
  state[0] ^= round_key[4*r+0];
  state[1] ^= round_key[4*r+1];
  state[2] ^= round_key[4*r+2];
  state[3] ^= round_key[4*r+3];
}

void isw_mult(uint32_t state[MASKING_ORDER][STATE_SIZE_128], int r, int x, int y) {
  int i,j;
  uint32_t rnd;

  for (i=0; i<MASKING_ORDER; i++) {
    state[i][r] = 0;
  }

  for (i=0; i<MASKING_ORDER; i++) {
    state[i][r] ^= state[i][x] & state[i][y];

    for (j=i+1; j<MASKING_ORDER; j++) {
      rnd = get_random();
      state[i][r] ^= rnd;
      state[j][r] ^= (rnd ^ (state[i][x] & state[j][y])) ^ (state[j][x] & state[i][y]);
    }
  }
}

void masked_sub_bytes_128(uint32_t state[MASKING_ORDER][STATE_SIZE_128]) {
  int i;

  for (i=0; i<MASKING_ORDER; i++) {
    state[i][0] ^= state[i][3];
  }

  isw_mult(state,3,0,1);
  isw_mult(state,0,1,2);
  isw_mult(state,1,2,3);
  isw_mult(state,2,0,3);

  for (i=0; i<MASKING_ORDER; i++) {
    state[i][2] ^= state[i][1];
    state[i][1] ^= state[i][0];

    // swap state[i][2] <-> state[i][3]
    state[i][2] ^= state[i][3];
    state[i][3] ^= state[i][2];
    state[i][2] ^= state[i][3];
  }
  state[0][2] = ~state[0][2];
}

void masked_pyjamask_128_enc(uint32_t state[MASKING_ORDER][STATE_SIZE_128],
                             uint32_t round_keys[MASKING_ORDER][4*(NB_ROUNDS_KS+1)]) {
  int i, r;


  // Initial AddRoundKey
  for (i=0; i<MASKING_ORDER; i++) {
    add_round_key_128(state[i], round_keys[i], 0);
  }

  // Main loop
  for (r=1; r<=NB_ROUNDS_128; r++) {
    masked_sub_bytes_128(state);

    for (i=0; i<MASKING_ORDER; i++) {
      mix_rows_128(state[i]);
      add_round_key_128(state[i], round_keys[i], r);
    }
  }
}

/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  uint32_t plaintext__[MASKING_ORDER][4] = { 0 };
  uint32_t key__[MASKING_ORDER][15*4] = { 0 };
  /* fun call */
  masked_pyjamask_128_enc(plaintext__, key__);

  /* Returning the number of encrypted bytes */
  return 16;
}
