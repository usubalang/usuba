/*
===============================================================================

    Reference implementation of Pyjamask block ciphers in C

    Copyright (C) 2019  Dahmun Goudarzi, Jérémy Jean, Stefan Kölbl,
    Thomas Peyrin, Matthieu Rivain, Yu Sasaki, Siang Meng Sim

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

===============================================================================
 */

#include <stdint.h>

//==============================================================================
//=== Parameters
//==============================================================================

#define STATE_SIZE_128       4

#define NB_ROUNDS_128       14
#define NB_ROUNDS_KS        14

//==============================================================================
//=== Macros
//==============================================================================

#define right_rotate(row) \
    row = (row >> 1) | (row << 31);

#define left_rotate(row,n) \
    row = (row >> n) | (row << (32-n));

//==============================================================================
//=== Constants
//==============================================================================

#define COL_M0          0xa3861085
#define COL_M1          0x63417021
#define COL_M2          0x692cf280
#define COL_M3          0x48a54813
#define COL_MK          0xb881b9ca

#define KS_CONSTANT_0   0x00000080
#define KS_CONSTANT_1   0x00006a00
#define KS_CONSTANT_2   0x003f0000
#define KS_CONSTANT_3   0x24000000


//==============================================================================
//=== Common functions
//==============================================================================

uint32_t mat_mult(uint32_t mat_col, uint32_t vec)
{
    int i;
    uint32_t mask, res=0;

    for (i = 31; i>=0; i--)
    {
        mask = -((vec >> i) & 1);
        res ^= mask & mat_col;
        right_rotate(mat_col);
    }

    return res;
}


//==============================================================================
//=== Pyjamask-128 (encryption)
//==============================================================================

void mix_rows_128(uint32_t *state)
{
    state[0] = mat_mult(COL_M0, state[0]);
    state[1] = mat_mult(COL_M1, state[1]);
    state[2] = mat_mult(COL_M2, state[2]);
    state[3] = mat_mult(COL_M3, state[3]);
}

void sub_bytes_128(uint32_t *state)
{
    state[0] ^= state[3];
    state[3] ^= state[0] & state[1];
    state[0] ^= state[1] & state[2];
    state[1] ^= state[2] & state[3];
    state[2] ^= state[0] & state[3];
    state[2] ^= state[1];
    state[1] ^= state[0];
    state[3] = ~state[3];

    // swap state[2] <-> state[3]
    state[2] ^= state[3];
    state[3] ^= state[2];
    state[2] ^= state[3];
}

void add_round_key_128(uint32_t *state, const uint32_t *round_key, int r)
{
    state[0] ^= round_key[4*r+0];
    state[1] ^= round_key[4*r+1];
    state[2] ^= round_key[4*r+2];
    state[3] ^= round_key[4*r+3];
}

void pyjamask_128_enc(uint32_t state[STATE_SIZE_128], uint32_t round_keys[4*(NB_ROUNDS_KS+1)],
                      uint32_t ciphertext[STATE_SIZE_128])
{
    int r;

    for (r=0; r<NB_ROUNDS_128; r++)
    {
        add_round_key_128(state, round_keys, r);
        sub_bytes_128(state);
        mix_rows_128(state);
    }

    add_round_key_128(state, round_keys, NB_ROUNDS_128);

    for (int i = 0; i < STATE_SIZE_128; i++)
      ciphertext[i] = state[i];
}

/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  uint32_t plaintext__[4] = { 0 };
  uint32_t key__[15*4] = { 0 };
  /* outputs */
  uint32_t ciphertext__[4] = { 0 };
  /* fun call */
  pyjamask_128_enc(plaintext__, key__,ciphertext__);

  /* Returning the number of encrypted bytes */
  return 16;
}
