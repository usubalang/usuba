#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF
#include "skinny_reference.c"
#elif defined(UA_V)
#include "skinny_ua_vslice.c"
#define enc Skinny__
#else
#error Please define REF or UA_V
#endif



void test_skinny() {

  // This seemigly random input is produced by encrypting full 0s plain/tweakey
  uint8_t input[16]   = { 0xd7, 0x8c, 0x84, 0x05, 0xd3, 0x9c, 0x47, 0xd0,
                          0xdc, 0x90, 0xbb, 0xe9, 0x9b, 0xb6, 0x91, 0x75 };
  uint8_t tweakey[32] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                          0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
                          0x01, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
  uint8_t output[16]  = { 0 };

  enc(input, tweakey, output);

  uint8_t output_ref[16] = { 0x84, 0x27, 0x46, 0xbe, 0x9e, 0xae, 0x6b, 0x33,
                             0xfa, 0x9f, 0xf0, 0x00, 0x77, 0x4f, 0x2b, 0x63 };

  fprintf(stderr, "Expected: ");
  for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",output_ref[i]);
  fprintf(stderr, "\n");
    
  if (memcmp(output, output_ref, 16) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Got     : ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",output[i]);
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "Seems OK.\n");
  }  
}


int main() {
  test_skinny();
}
