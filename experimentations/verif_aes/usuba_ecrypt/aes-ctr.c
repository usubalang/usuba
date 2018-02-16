
#include <x86intrin.h>
#include "ecrypt-sync.h"

#include "aes_bs.c"
#include "key_sched.c"

void ECRYPT_init(void) {}

void ECRYPT_keysetup(
                     ECRYPT_ctx* ctx, 
                     const u8* key, 
                     u32 keysize,
                     u32 ivsize)
{ 
  int i, j;
  char* sched_key = key_sched(key);

  __m128i key_ortho[11][8];/* = malloc(11 * 8 * sizeof(**key_ortho)); */
  for (i = 0; i < 11; i++) {
    for (j = 0; j < 8; j++)
      key_ortho[i][j] = _mm_load_si128((__m128i*)&sched_key[i*16]);
    orthogonalize(key_ortho[i]);
  }

  memcpy(ctx->key,key_ortho,sizeof(ctx->key));
}

void ECRYPT_ivsetup(
  ECRYPT_ctx* ctx, 
  const u8* iv) { 
      memcpy(ctx->counter, iv, 16);
}


void ECRYPT_process_bytes(
  int action,
  ECRYPT_ctx* ctx, 
  const u8* input, 
  u8* output, 
  u32 msglen) {
  int i, j;
  
  u8 keystream[16*8];
  
  for ( ; msglen >= 16*8; msglen -= 16*8, input += 16*8, output += 16*8) {
    /* Note that the call to aes_encrypt increments the counter */
    aes_encrypt(ctx->counter,ctx->key,(__m128i*)keystream,8);

    for (i = 0; i < 8; i++) {
      for (j = 0; j < 4; j++) {
        ((u32*)output)[i*4+j] = ((u32*)input)[i*4+j] ^ ((u32*)keystream)[i*4+j];
      }
    }
  }

  /* the remaining "full" blocks */
  int full_blocks = msglen/16;
  aes_encrypt(ctx->counter,ctx->key,(__m128i*)keystream,full_blocks+(msglen%16?1:0));
  for (i = 0; i < full_blocks; i++) {
    for (j = 0; j < 4; j++) {
      ((u32*)output)[i*4+j] = ((u32*)input)[i*4+j] ^ ((u32*)keystream)[i*4+j];
    }
  }
  output += 16 * full_blocks;
  input  += 16 * full_blocks;

  /* the finale bytes of the last block */
  for (i = 0; i < msglen; i++)
    output[i] = input[i] ^ keystream[i+full_blocks*16];

  
}
