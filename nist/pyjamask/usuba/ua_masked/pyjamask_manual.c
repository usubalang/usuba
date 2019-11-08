#include <stdint.h>

#define STATE_SIZE_128       4
#define NB_ROUNDS_128       14
#define NB_ROUNDS_KS        14

#define COL_M0        0xa3861085
#define COL_M1        0x63417021
#define COL_M2        0x692cf280
#define COL_M3        0x48a54813
#define COL_MK        0xb881b9ca

#define WITH_CONST_ADD       0
#define WOUT_CONST_ADD       1

#define KS_CONSTANT_0   0x00000080
#define KS_CONSTANT_1   0x00006a00
#define KS_CONSTANT_2   0x003f0000
#define KS_CONSTANT_3   0x24000000

#define KS_ROT_GAP1            8
#define KS_ROT_GAP2           15
#define KS_ROT_GAP3           18


volatile uint32_t __rand = 0;
static uint32_t get_random() {
  return __rand;
}


//==============================================================================
//=== Common functions
//==============================================================================

static void load_state(const uint8_t *plaintext, uint32_t *state, int state_size)
{
    int i;

    for (i=0; i<state_size; i++)
    {
        state[i] =                   plaintext[4*i+0];
        state[i] = (state[i] << 8) | plaintext[4*i+1];
        state[i] = (state[i] << 8) | plaintext[4*i+2];
        state[i] = (state[i] << 8) | plaintext[4*i+3];
    }
}

static void unload_state(uint8_t *ciphertext, const uint32_t *state, int state_size)
{
    int i;

    for (i=0; i<state_size; i++)
    {
        ciphertext [4*i+0] = (uint8_t) (state[i] >> 24);
        ciphertext [4*i+1] = (uint8_t) (state[i] >> 16);
        ciphertext [4*i+2] = (uint8_t) (state[i] >>  8);
        ciphertext [4*i+3] = (uint8_t) (state[i] >>  0);
    }
}

//==============================================================================
//=== Masking functions
//==============================================================================

static void mask_state_128(uint32_t state[MASKING_ORDER][STATE_SIZE_128])
{
    int i,j;

    for (i=1; i<MASKING_ORDER; i++)
    {
        for (j=0; j<STATE_SIZE_128; j++)
        {
            state[i][j] = get_random();
            state[0][j] ^= state[i][j];
        }
    }
}

static void unmask_state_128(uint32_t state[MASKING_ORDER][STATE_SIZE_128])
{
    int i,j;

    for (i=1; i<MASKING_ORDER; i++)
    {
        for (j=0; j<STATE_SIZE_128; j++)
        {
            state[0][j] ^= state[i][j];
            state[i][j]  = 0;
        }
    }
}

#define right_rotate(row) \
    row = (row >> 1) | (row << 31);

#define left_rotate(row,n)			\
  row = (row >> n) | (row << (32-n));

static uint32_t mat_mult(uint32_t mat_col, uint32_t vec) {
  int i;
  uint32_t mask, res=0;

  for (i = 31; i>=0; i--) {
    mask = -((vec >> i) & 1);
    res ^= mask & mat_col;
    right_rotate(mat_col);
  }

  return res;
}


//==============================================================================
//=== Key schedule
//==============================================================================


static void ks_mix_comlumns(const uint32_t *ks_prev, uint32_t *ks_next)
{
    uint32_t tmp;

    tmp = ks_prev[0] ^ ks_prev[1] ^ ks_prev[2] ^ ks_prev[3];

    ks_next[0] = ks_prev[0] ^ tmp;
    ks_next[1] = ks_prev[1] ^ tmp;
    ks_next[2] = ks_prev[2] ^ tmp;
    ks_next[3] = ks_prev[3] ^ tmp;
}

static void ks_mix_rotate_rows(uint32_t *ks_state)
{
    ks_state[0] = mat_mult(COL_MK, ks_state[0]);
    left_rotate(ks_state[1],KS_ROT_GAP1)
    left_rotate(ks_state[2],KS_ROT_GAP2)
    left_rotate(ks_state[3],KS_ROT_GAP3)
}

static void ks_add_constant(uint32_t *ks_state, const uint32_t ctr)
{
    ks_state[0] ^= KS_CONSTANT_0 ^ ctr;
    ks_state[1] ^= KS_CONSTANT_1;
    ks_state[2] ^= KS_CONSTANT_2;
    ks_state[3] ^= KS_CONSTANT_3;
}

static void key_schedule(uint32_t* ks_state, uint8_t mode)
{
    int r;

    for (r=0; r<NB_ROUNDS_KS; r++)
    {
        ks_state += 4;

        ks_mix_comlumns(ks_state-4, ks_state);
        ks_mix_rotate_rows(ks_state);

        if (mode == WITH_CONST_ADD)
        {
            ks_add_constant(ks_state,r);
        }
    }
}


static void mix_rows_128(uint32_t *state) {
  state[0] = mat_mult(COL_M0, state[0]);
  state[1] = mat_mult(COL_M1, state[1]);
  state[2] = mat_mult(COL_M2, state[2]);
  state[3] = mat_mult(COL_M3, state[3]);
}

static void add_round_key_128(uint32_t *state, const uint32_t *round_key, int r) {
  state[0] ^= round_key[4*r+0];
  state[1] ^= round_key[4*r+1];
  state[2] ^= round_key[4*r+2];
  state[3] ^= round_key[4*r+3];
}

static void isw_mult(uint32_t state[MASKING_ORDER][STATE_SIZE_128], int r, int x, int y) {
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

static void masked_sub_bytes_128(uint32_t state[MASKING_ORDER][STATE_SIZE_128]) {
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

#ifdef FULL_REF
void masked_pyjamask_128_enc(const uint8_t *plaintext, const uint8_t masked_key[MASKING_ORDER][16], uint8_t *ciphertext)
{
    int i, r;

    uint32_t state[MASKING_ORDER][STATE_SIZE_128];
    uint32_t round_keys[MASKING_ORDER][4*(NB_ROUNDS_KS+1)];

    // Load masked key

    for (i=0; i<MASKING_ORDER; i++)
    {
        load_state(masked_key[i], round_keys[i], 4);
    }

    // Key schedule

    key_schedule(round_keys[0], WITH_CONST_ADD);

    for (i=1; i<MASKING_ORDER; i++)
    {
        key_schedule(round_keys[i], WOUT_CONST_ADD);
    }

    // Load and mask state

    load_state(plaintext, state[0], STATE_SIZE_128);
    mask_state_128(state);

    // Initial AddRoundKey

    for (i=0; i<MASKING_ORDER; i++)
    {
        add_round_key_128(state[i], round_keys[i], 0);
    }

    // Main loop

    for (r=1; r<=NB_ROUNDS_128; r++)
    {
        masked_sub_bytes_128(state);

        for (i=0; i<MASKING_ORDER; i++)
        {
            mix_rows_128(state[i]);
            add_round_key_128(state[i], round_keys[i], r);
        }
    }

    // Unmask and unload state

    unmask_state_128(state);
    unload_state(ciphertext, state[0], STATE_SIZE_128);
}

#else

void pyjamask(uint32_t state[MASKING_ORDER][STATE_SIZE_128],
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

#endif
