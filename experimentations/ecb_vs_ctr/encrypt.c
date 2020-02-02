#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <string.h>

#include "header.h"

enum mode { NONE, ECB, CTR };

unsigned char key[16] = { 0 };
unsigned char iv[16]  = { 0 };


void encrypt_file(char* filename_in, char* filename_out, enum mode mode) {
  FILE* f_in = fopen(filename_in, "rb");
  if (f_in == NULL) {
    fprintf(stderr, "Failed to open %s.\n", filename_in);
    exit(EXIT_FAILURE);
  }
  fseek(f_in, 0, SEEK_END);
  int length = ftell(f_in);
  fseek(f_in, 0, SEEK_SET);
  char* input = malloc(length * sizeof(*input));
  fread(input, 1, length, f_in);
  fclose(f_in);

  char* output = malloc(length * sizeof(*output));

  if (mode == ECB) {
    encrypt_ecb(input, key, output, length);
  } else if (mode == CTR) {
    encrypt_ctr(input, key, iv, output, length);
  } else {
    fprintf(stderr, "Invalid mode NONE.\n");
    exit(EXIT_FAILURE);
  }

  FILE* f_out = fopen(filename_out, "wb");
  if (f_out == NULL) {
    fprintf(stderr, "Failed to open %s.\n", filename_in);
    exit(EXIT_FAILURE);
  }
  fwrite(output, 1, length, f_out);
}



int main(int argc, char** argv) {

  if (argc != 4) {
    fprintf(stderr, "3 arguments required. Provided: %d. Exiting.\n", argc-1);
    exit(EXIT_FAILURE);
  }

  enum mode mode = NONE;
  if (strncmp(argv[1],"ecb",3) == 0) {
    mode = ECB;
  } else if (strncmp(argv[1],"ctr",3) == 0) {
    mode = CTR;
  } else {
    fprintf(stderr, "Error. First argument is %s. Requires 'ecb' or 'ctr'.\n", argv[1]);
    exit(EXIT_FAILURE);
  }

  char* filename_in  = argv[2];
  char* filename_out = argv[3];

  encrypt_file(filename_in, filename_out, mode);

}
