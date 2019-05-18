#include <stdint.h>

void AddRoundKey(uint64_t plain[64], uint64_t key[64]) {
  for (int i = 0; i < 64; i++)
    plain[i] ^= key[i];
}

void SubColumn(uint64_t* a0,  uint64_t* a1,  uint64_t* a2,  uint64_t* a3) {
  uint64_t t1, t2, t3, t5, t6, t8, t9, t11;
  t1 = ~*a1;
  t2 = *a0 & t1;
  t3 = *a2 ^ *a3;
  uint64_t a0_tmp = *a0;
  *a0 = t2 ^ t3;
  t5 = *a3 | t1;
  t6 = a0_tmp ^ t5;
  uint64_t a1_tmp = *a1;
  *a1 = *a2 ^ t6;
  t8 = a1_tmp ^ *a2;
  t9 = t3 & t6;
  *a3 = t8 ^ t9;
  t11 = *a0 | t8;
  *a2 = t6 ^ t11;
}

void ShiftRow(uint64_t a[64]) {
  int rot[] = { 0, 1, 12, 13 };
  for (int k = 1; k < 4; k++) {
    uint64_t tmp[16];
    for (int i = 0; i < 16; i++)
      tmp[i] = a[k*16+(16+rot[k]+i)%16];
    for (int i = 0; i < 16; i++)
      a[k*16+i] = tmp[i];
  }
}


void Rectangle__(uint64_t plain[64], uint64_t key[26][64], uint64_t cipher[64]) {

  for (int i = 0; i < 25; i++) {
    AddRoundKey(plain,key[i]);
    for (int j = 0; j < 16; j++)
      SubColumn(&plain[j], &plain[j+16], &plain[j+32], &plain[j+48]);
    ShiftRow(plain);
  }

  for (int i = 0; i < 64; i++)
    cipher[i] = plain[i] ^ key[25][i];
  
}
