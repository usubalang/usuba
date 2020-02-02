
#include "bitslice.h"

void AES__ (__m128i plain__[8], __m128i key__[11][8], __m128i cipher__[8]);

void key_sched_128 (const unsigned char in[16], __m128i key[11][8]);

void encrypt_ecb(char* plain, const unsigned char* key, char* cipher, unsigned int length);

void encrypt_ctr(char* plain, const unsigned char* key, const unsigned char* iv,
                 char* cipher, unsigned int length);
