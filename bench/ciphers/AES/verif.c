#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "key_sched.c"
#include "aes.c"

void test() {
  char k0[16]  = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  char kff[16] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 };
  char ki[16]  = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
  
  char* key = key_sched(k0);
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 16; j++)
      printf("%02x ",key[i*16+j]&0xff);
    printf("\n");
  }

  printf("\n\n");

  key = key_sched(kff);
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 16; j++)
      printf("%02x ",key[i*16+j]&0xff);
    printf("\n");
  }

  printf("\n\n");

  key = key_sched(ki);
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 16; j++)
      printf("%02x ",key[i*16+j]&0xff);
    printf("\n");
  }

  printf("\n\n");

  
}


int main() {

  char k0[16] = { 0 };
  //char k0[16] = { 0x54, 0x68, 0x61, 0x74, 0x73, 0x20, 0x6D, 0x79,
  //                0x20, 0x4B, 0x75, 0x6E, 0x67, 0x20, 0x46, 0x75 };
  char* key = key_sched(k0);

  unsigned long* key_ortho = malloc(1408 * sizeof *key_ortho);
  for (int i = 0; i < 1408; i++)
    key_ortho[i] = (key[i/8] >> (7-i%8)) & 1 ? -1 : 0;
  
  for (int i = 0; i < 16; i++) {
    char c = 0;
    for (int j = 0; j < 8; j++)
      c |= (key_ortho[i*8+j] & 1) << (7-j);
    printf("%02x",c&0xff);
  }
  printf("\n");

  //char p[16] = { 0x54, 0x77, 0x6F, 0x20, 0x4F, 0x6E, 0x65, 0x20,
  //               0x4E, 0x69, 0x6E, 0x65, 0x20, 0x54, 0x77, 0x6F };
  char p[16] = { 0 };
  unsigned long* plain_ortho = malloc(128 * sizeof *plain_ortho);
  for (int i = 0; i < 128; i++) {
    plain_ortho[i] = (p[i/8] >> (7-i%8)) & 1 ? -1 : 0;
  }
  
  for (int i = 0; i < 16; i++) {
    char c = 0;
    for (int j = 0; j < 8; j++)
      c |= (plain_ortho[i*8+j] & 1) << (7-j);
    printf("%02x",c&0xff);
  }
  printf("\n");

  unsigned long ciphertext[128];
  AES__(plain_ortho,key_ortho,ciphertext);

  // Should print: 66e94bd4ef8a2c3b884cfa59ca342b2e
  for (int i = 0; i < 16; i++) {
    char c = 0;
    for (int j = 0; j < 8; j++)
      c |= (ciphertext[i*8+j] & 1) << (7-j);
    printf("%02x",c&0xff);
  }
  printf("\n");

  return 0;
}
