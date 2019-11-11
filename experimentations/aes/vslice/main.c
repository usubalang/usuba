
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

// For debugging purposes
void print16bin(uint16_t x) {
  for(int i = 0; i < 16; i++) {
    printf("%x",(x >> (15-i)) & 1);
  }
}


#include "aes.c"

#include "key_sched.c"


void transpose(uint8_t data[8]) {

  uint8_t mask_l[3] = { 0xaa, 0xcc, 0xf0 };

  uint8_t mask_r[3] = { 0x55, 0x33, 0x0f };

  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint8_t u = data[j + k] & mask_l[i];
        uint8_t v = data[j + k] & mask_r[i];
        uint8_t x = data[j + n + k] & mask_l[i];
        uint8_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

void reorder(uint8_t data[16]) {
  uint8_t tmp[16];
  memcpy(tmp,data,16);
  uint8_t pattern[16] = { 0, 4,  8, 12,
                          1, 5,  9, 13,
                          2, 6, 10, 14,
                          3, 7, 11, 15 };
  for (int i = 0; i < 16; i++)
    data[i] = tmp[pattern[i]];
}

int main() {
  char key_base[16] = "Thats my Kung Fu";
  char* sched_key = key_sched(key_base);
  for (int i = 0; i < 11; i++) {
    reorder(&sched_key[i*16]);
    transpose(&sched_key[i*16]);
    transpose(&sched_key[i*16+8]);
  }
  uint16_t key[11][8];
  for (int i = 0; i < 11; i++)
    for (int j = 0; j < 8; j++) {
      key[i][j] = ((uint16_t)sched_key[i*16+j] << 8) | ((uint16_t)sched_key[i*16+8+j] & 0xff);
    }


  char plain_u8[16] = "Two One Nine Two";
  reorder(plain_u8);
  transpose(plain_u8);
  transpose(&plain_u8[8]);
  uint16_t plain[16];
  for (int i = 0; i < 8; i++)
    plain[i] = ((uint16_t)plain_u8[i] << 8) | ((uint16_t)plain_u8[i+8] & 0xff);


  uint16_t cipher[8];

  AES__(plain,key,cipher);

  char cipher_u8[16];
  for (int i = 0; i < 8; i++) {
    cipher_u8[i]   = cipher[i] >> 8;
    cipher_u8[i+8] = cipher[i] & 0xff;
  }
  transpose(cipher_u8);
  transpose(&cipher_u8[8]);
  reorder(cipher_u8);


  char expected[16] = { 0x29, 0xc3, 0x50, 0x5f, 0x57, 0x14, 0x20, 0xf6,
                        0x40, 0x22, 0x99, 0xb3, 0x1a, 0x02, 0xd7, 0x3a };

  if (memcmp(expected,cipher_u8,16) != 0) {
    fprintf(stderr, "Error!\n");
    fprintf(stderr, "Expected: ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",expected[i] & 0xff);
    fprintf(stderr, "\nGot:      ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",cipher_u8[i] & 0xff);
    fprintf(stderr,"\n");
    exit(EXIT_FAILURE);
  } else {
    fprintf(stderr, "AES vslice seems OK.\n");
    return EXIT_SUCCESS;
  }
}
