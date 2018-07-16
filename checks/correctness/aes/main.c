#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "stream.h"


void test() {
  /* unsigned char key[16]       = { 0 }; */
  /* unsigned char iv[16]        = { 0 }; */
  unsigned char key[16] = { 0x54, 0x68, 0x61, 0x74, 0x73, 0x20, 0x6D, 0x79,
                            0x20, 0x4B, 0x75, 0x6E, 0x67, 0x20, 0x46, 0x75 };
  unsigned char iv[16]  = { 0x54, 0x77, 0x6F, 0x20, 0x4F, 0x6E, 0x65, 0x20,
                            0x4E, 0x69, 0x6E, 0x65, 0x20, 0x54, 0x77, 0x6F };
  unsigned char input[16*64] = { 0 };
  unsigned char output[16*64];
  crypto_stream_xor(output,input,64*16,iv,key);
  for (int i = 0; i < 16; i++) {
    printf("%02x",output[i]);
  }
}


int main() {
  
  unsigned char key[16] = { 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
                            0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
  unsigned char iv[16]  = { 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
                            0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };

  FILE* fp_in  = fopen("input.txt","rb");
  FILE* fp_out = fopen("out_c.txt","wb");

  fseek(fp_in, 0, SEEK_END);
  long fsize = ftell(fp_in);
  rewind(fp_in);

  unsigned char* input = aligned_alloc(32, fsize);
  unsigned char* output = aligned_alloc(32, fsize);
  fread(input, fsize, 1, fp_in);
  fclose(fp_in);
  
  crypto_stream_xor(output,input,fsize,iv,key);

  fwrite(output, fsize, 1, fp_out);
  fclose(fp_out);

}
