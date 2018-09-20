#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "stream.h"

//#include "t/crypto_stream_aes128ctr.h"
//#include "t/crypto_stream.h"


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
