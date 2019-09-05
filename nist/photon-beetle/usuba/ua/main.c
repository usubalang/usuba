#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "photon.c"
#define photon(text) Permutation(text,12)

#elif defined(UA_V)

#include "photon_ua_vslice.c"
void photon(unsigned char text[8][8]) {
  
  unsigned char output[8][8];
  Photon__(text,output);

  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 8; j++)
      text[i][j] = output[i][j];
}

#elif defined(UA_B)

#include "photon_ua_bitslice.c"
void photon(unsigned char text[8][8]) {
  uint64_t input[8][8][4];
  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 8; j++)
      for (int k = 0; k < 4; k++)
        input[i][j][3-k] = (text[i][j] >> k) & 1 ? -1 : 0;
  
  uint64_t output[8][8][4];
  Photon__(input,output);

  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 8; j++) {
      unsigned char tmp = 0;
      for (int k = 0; k < 4; k++)
        tmp |= (output[i][j][k] & 1) << (3-k);
      text[i][j] = tmp;      
    }
}

#else
#error Please define REF or UA_V
#endif




void test_photon() {

  // This seemigly random input is produced by encrypting full 0s plain
  unsigned char text[8][8] = {
    { 0x0, 0x1, 0x1, 0x6, 0x5, 0x9, 0x0, 0x7 },
    { 0xd, 0xb, 0xd, 0xa, 0x6, 0x5, 0x9, 0xc },
    { 0x2, 0xa, 0xf, 0x1, 0x7, 0x0, 0x4, 0xb },
    { 0xb, 0xa, 0x9, 0x3, 0xe, 0x7, 0x4, 0xb },
    { 0xa, 0x0, 0x5, 0xc, 0x1, 0xa, 0xb, 0x3 },
    { 0x8, 0xb, 0x8, 0xd, 0x4, 0x5, 0x8, 0x2 },
    { 0x6, 0x0, 0xd, 0xf, 0xf, 0x0, 0x4, 0xc },
    { 0x0, 0x6, 0x2, 0xd, 0x7, 0x2, 0xe, 0x5 } };

  photon(text);

  /* for (int i = 0; i < 8; i++) { */
  /*   for (int j = 0; j < 8; j++) { */
  /*     printf("0x%01x, ",text[i][j]&0xf); */
  /*   } */
  /*   printf("\n"); */
  /* } */
  
  unsigned char expected[8][8] = {
    { 0xb, 0xf, 0x1, 0xc, 0x0, 0x6, 0x6, 0x8 },
    { 0x1, 0x2, 0x2, 0x9, 0x9, 0xb, 0x6, 0xf },
    { 0x3, 0x9, 0xf, 0x6, 0xf, 0xc, 0x8, 0xa },
    { 0xa, 0x7, 0x2, 0xf, 0x7, 0xf, 0xc, 0x1 },
    { 0xf, 0x4, 0xf, 0xc, 0xa, 0x3, 0xe, 0x3 },
    { 0x7, 0xa, 0x0, 0x5, 0x6, 0xc, 0x6, 0x5 },
    { 0xc, 0x1, 0xd, 0x2, 0xa, 0x6, 0x3, 0xb },
    { 0xb, 0x4, 0x8, 0xf, 0x2, 0x5, 0x5, 0xd } };

  if (memcmp(text, expected, 64) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%01x",expected[i][j]&0xf);
      fprintf(stderr," ");
    }
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%01x",text[i][j]&0xf);
      fprintf(stderr," ");
    }
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_photon();
}
