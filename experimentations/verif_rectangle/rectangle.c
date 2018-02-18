#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>


void print128hex (const __m128i v) {
  uint8_t a[16];
  _mm_store_si128 ((__m128i*)a, v);
  for (int i = 0; i < 16; i++)
    printf("%02X",a[i]);
  puts("");  
}

void print64bin (const uint64_t n) {
  for (int i = 1; i <= 64; i++)
    printf("%lu",(n>>(64-i)) & 1);
}
void print8bin (const uint8_t n) {
  for (int i = 1; i <= 8; i++)
    printf("%d",(n>>(8-i)) & 1);
}

void print128bin (const __m128i v) {
  uint8_t out[16];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i < 16; i++) {
    print8bin(out[i]);
  }
  puts("");
}



void real_ortho_128x128(__m128i data[4]) {

  __m128i mask_l[3] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL)
  
  };

  __m128i mask_r[3] = {
    _mm_set1_epi64x(0x5555555555555555UL),
    _mm_set1_epi64x(0x3333333333333333UL),
    _mm_set1_epi64x(0x0f0f0f0f0f0f0f0fUL)
  };
  
  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 4; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
        data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
      }
  }
  
  for (int i = 0; i < 4; i++)
    data[i] =  _mm_shuffle_epi8(data[i],_mm_set_epi8(15,11,7,3,
                                                     14,10,6,2,
                                                     13,9,5,1,
                                                     12,8,4,0));  
}


/* Do NOT change the order of those define/include */

/* defining "BENCH" or "STD" */
/* (will impact the .h functions loaded by the .h) */
#define NO_RUNTIME
/* including the architecture specific .h */
#include "SSE.h"

/* auxiliary functions */
void SubColumn__ (/*inputs*/ DATATYPE a0,DATATYPE a1,DATATYPE a2,DATATYPE a3, /*outputs*/ DATATYPE* b0,DATATYPE* b1,DATATYPE* b2,DATATYPE* b3) {
  
  // Variables declaration
  DATATYPE t1;
  DATATYPE t11;
  DATATYPE t2;
  DATATYPE t3;
  DATATYPE t5;
  DATATYPE t6;
  DATATYPE t8;
  DATATYPE t9;


  // Instructions (body)
  t1 = NOT(a1);
  t2 = AND(a0,t1);
  t3 = XOR(a2,a3);
  *b0 = XOR(t2,t3);
  t5 = OR(a3,t1);
  t6 = XOR(a0,t5);
  *b1 = XOR(a2,t6);
  t8 = XOR(a1,a2);
  t9 = AND(t3,t6);
  *b3 = XOR(t8,t9);
  t11 = OR(*b0,t8);
  *b2 = XOR(t6,t11);

}

void RL1__(/*input*/ DATATYPE input__, /*outputs*/ DATATYPE* out__) {
   *out__ = PERMUT_16(input__,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0);
}

void RL12__(/*input*/ DATATYPE input__, /*outputs*/ DATATYPE* out__) {
   *out__ = PERMUT_16(input__,12,13,14,15,0,1,2,3,4,5,6,7,8,9,10,11);
}

void RL13__(/*input*/ DATATYPE input__, /*outputs*/ DATATYPE* out__) {
   *out__ = PERMUT_16(input__,13,14,15,0,1,2,3,4,5,6,7,8,9,10,11,12);
}

/* main function */
void Rectangle__ (/*inputs*/ DATATYPE plain__[4],DATATYPE key__[25][4], /*outputs*/ DATATYPE cipher__[4]) {
  
  // Variables declaration


  // Instructions (body)
  plain__[0] = XOR(plain__[0],key__[0][0]);
  plain__[1] = XOR(plain__[1],key__[0][1]);
  plain__[2] = XOR(plain__[2],key__[0][2]);
  plain__[3] = XOR(plain__[3],key__[0][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[1][0]);
  plain__[1] = XOR(plain__[1],key__[1][1]);
  plain__[2] = XOR(plain__[2],key__[1][2]);
  plain__[3] = XOR(plain__[3],key__[1][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[2][0]);
  plain__[1] = XOR(plain__[1],key__[2][1]);
  plain__[2] = XOR(plain__[2],key__[2][2]);
  plain__[3] = XOR(plain__[3],key__[2][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[3][0]);
  plain__[1] = XOR(plain__[1],key__[3][1]);
  plain__[2] = XOR(plain__[2],key__[3][2]);
  plain__[3] = XOR(plain__[3],key__[3][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[4][0]);
  plain__[1] = XOR(plain__[1],key__[4][1]);
  plain__[2] = XOR(plain__[2],key__[4][2]);
  plain__[3] = XOR(plain__[3],key__[4][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[5][0]);
  plain__[1] = XOR(plain__[1],key__[5][1]);
  plain__[2] = XOR(plain__[2],key__[5][2]);
  plain__[3] = XOR(plain__[3],key__[5][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[6][0]);
  plain__[1] = XOR(plain__[1],key__[6][1]);
  plain__[2] = XOR(plain__[2],key__[6][2]);
  plain__[3] = XOR(plain__[3],key__[6][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[7][0]);
  plain__[1] = XOR(plain__[1],key__[7][1]);
  plain__[2] = XOR(plain__[2],key__[7][2]);
  plain__[3] = XOR(plain__[3],key__[7][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[8][0]);
  plain__[1] = XOR(plain__[1],key__[8][1]);
  plain__[2] = XOR(plain__[2],key__[8][2]);
  plain__[3] = XOR(plain__[3],key__[8][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[9][0]);
  plain__[1] = XOR(plain__[1],key__[9][1]);
  plain__[2] = XOR(plain__[2],key__[9][2]);
  plain__[3] = XOR(plain__[3],key__[9][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[10][0]);
  plain__[1] = XOR(plain__[1],key__[10][1]);
  plain__[2] = XOR(plain__[2],key__[10][2]);
  plain__[3] = XOR(plain__[3],key__[10][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[11][0]);
  plain__[1] = XOR(plain__[1],key__[11][1]);
  plain__[2] = XOR(plain__[2],key__[11][2]);
  plain__[3] = XOR(plain__[3],key__[11][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[12][0]);
  plain__[1] = XOR(plain__[1],key__[12][1]);
  plain__[2] = XOR(plain__[2],key__[12][2]);
  plain__[3] = XOR(plain__[3],key__[12][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[13][0]);
  plain__[1] = XOR(plain__[1],key__[13][1]);
  plain__[2] = XOR(plain__[2],key__[13][2]);
  plain__[3] = XOR(plain__[3],key__[13][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[14][0]);
  plain__[1] = XOR(plain__[1],key__[14][1]);
  plain__[2] = XOR(plain__[2],key__[14][2]);
  plain__[3] = XOR(plain__[3],key__[14][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[15][0]);
  plain__[1] = XOR(plain__[1],key__[15][1]);
  plain__[2] = XOR(plain__[2],key__[15][2]);
  plain__[3] = XOR(plain__[3],key__[15][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[16][0]);
  plain__[1] = XOR(plain__[1],key__[16][1]);
  plain__[2] = XOR(plain__[2],key__[16][2]);
  plain__[3] = XOR(plain__[3],key__[16][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[17][0]);
  plain__[1] = XOR(plain__[1],key__[17][1]);
  plain__[2] = XOR(plain__[2],key__[17][2]);
  plain__[3] = XOR(plain__[3],key__[17][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[18][0]);
  plain__[1] = XOR(plain__[1],key__[18][1]);
  plain__[2] = XOR(plain__[2],key__[18][2]);
  plain__[3] = XOR(plain__[3],key__[18][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[19][0]);
  plain__[1] = XOR(plain__[1],key__[19][1]);
  plain__[2] = XOR(plain__[2],key__[19][2]);
  plain__[3] = XOR(plain__[3],key__[19][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[20][0]);
  plain__[1] = XOR(plain__[1],key__[20][1]);
  plain__[2] = XOR(plain__[2],key__[20][2]);
  plain__[3] = XOR(plain__[3],key__[20][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[21][0]);
  plain__[1] = XOR(plain__[1],key__[21][1]);
  plain__[2] = XOR(plain__[2],key__[21][2]);
  plain__[3] = XOR(plain__[3],key__[21][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[22][0]);
  plain__[1] = XOR(plain__[1],key__[22][1]);
  plain__[2] = XOR(plain__[2],key__[22][2]);
  plain__[3] = XOR(plain__[3],key__[22][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[23][0]);
  plain__[1] = XOR(plain__[1],key__[23][1]);
  plain__[2] = XOR(plain__[2],key__[23][2]);
  plain__[3] = XOR(plain__[3],key__[23][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  plain__[0] = XOR(plain__[0],key__[24][0]);
  plain__[1] = XOR(plain__[1],key__[24][1]);
  plain__[2] = XOR(plain__[2],key__[24][2]);
  plain__[3] = XOR(plain__[3],key__[24][3]);
  SubColumn__(plain__[0],plain__[1],plain__[2],plain__[3],&plain__[0],&plain__[1],&plain__[2],&plain__[3]);
  RL1__(plain__[1],&plain__[1]);
  RL12__(plain__[2],&plain__[2]);
  RL13__(plain__[3],&plain__[3]);
  cipher__[0] = plain__[0];
  cipher__[1] = plain__[1];
  cipher__[2] = plain__[2];
  cipher__[3] = plain__[3];

}
#define NB_LOOP 10000000

int main() {

  srand(time(NULL));

  __m128i plain[8], cipher[8];
  
  uint8_t plain_std[16] = { 0x54, 0x77, 0x6F, 0x20, 0x4F, 0x6E, 0x65, 0x20,
                            0x4E, 0x69, 0x6E, 0x65, 0x20, 0x54, 0x77, 0x6F };
  for (int i = 0; i < 8; i++)
    plain[i] = _mm_load_si128((__m128i*)plain_std);
  real_ortho_128x128(plain);

  
  __m128i key[25][4];
  for (int i = 0; i < 25; i++) {
    for (int j = 0; j < 4; j++) {
      key[i][j] = _mm_set_epi64x(rand(), rand());
    }
  }

  /* Warming up the caches */
  for (int i = 0; i < 10000; i++) {
    real_ortho_128x128(plain);
    Rectangle__(plain,key,cipher);
    real_ortho_128x128(cipher);
  }
   
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    Rectangle__(plain,key,cipher);
  }
  timer = _rdtsc() - timer;
  printf("Just Rectangle (no transpo): %lu        => %.2f cycle/byte\n",timer/NB_LOOP,(double)timer/NB_LOOP/(16.*8));
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    real_ortho_128x128(plain);
    Rectangle__(plain,key,cipher);
    real_ortho_128x128(cipher);
  }
  timer = _rdtsc() - timer;
  printf("Rectangle with transpo: %lu        => %.2f cycle/byte\n",timer/NB_LOOP,(double)timer/NB_LOOP/(16.*8));
  return 0;
}
