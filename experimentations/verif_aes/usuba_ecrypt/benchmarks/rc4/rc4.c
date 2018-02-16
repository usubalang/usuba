/* rc4.c */

/* 
 * RC4
 *
 * Author: Christophe De Canni\`ere, K.U.Leuven.
 */

/* ------------------------------------------------------------------------- */

#include "ecrypt-sync.h"

/* ------------------------------------------------------------------------- */

void ECRYPT_init(void)
{ }

/* ------------------------------------------------------------------------- */

void ECRYPT_keysetup(
  ECRYPT_ctx* ctx, 
  const u8* key, 
  u32 keysize,
  u32 ivsize)
{ 
  u32 i;

  ctx->keylen = (keysize + 7) / 8;

  for (i = 0; i < ctx->keylen; ++i)
    ctx->key[i] = key[i];
}

/* ------------------------------------------------------------------------- */

void ECRYPT_ivsetup(
  ECRYPT_ctx* ctx, 
  const u8* iv)
{
  u32 i, j;

#if (ECRYPT_VARIANT == 1)
  u8* s = (u8*)ctx->s;
#else
  u32* s = (u32*)ctx->s;
#endif
 
  for (i = 0; i < 256; ++i)
    s[i] = i;

  for (i = j = 0; i < 256; ++i)
    {
      u32 a;

      j = (j + (a = s[i]) + ctx->key[i % ctx->keylen]) & 0xFF;
      s[i] = s[j];
      s[j] = a;
    }

  ctx->i = 0;
  ctx->j = 0;
}

/* ------------------------------------------------------------------------- */

#define ITERATE(n)                                                            \
  do {                                                                        \
    u32 a, b;                                                                 \
                                                                              \
    i = (i + 1) & 0xFF;                                                       \
    j = (j + (a = s[i])) & 0xFF;                                              \
                                                                              \
    s[i] = b = s[j];                                                          \
    output[n] = s[(b + (s[j] = a)) & 0xFF];                                   \
  } while (0)

    
void ECRYPT_process_bytes(
  int action,
  ECRYPT_ctx* ctx, 
  const u8* input, 
  u8* output, 
  u32 msglen)
{ 
  u32 i = ctx->i;
  u32 j = ctx->j;

#if (ECRYPT_VARIANT == 1)
  u8* s = (u8*)ctx->s;
#else
  u32* s = (u32*)ctx->s;
#endif

  for ( ; (int)(msglen -= 16) >= 0; output += 16, input += 16)
    {
      ITERATE( 0); ITERATE( 1); ITERATE( 2); ITERATE( 3);
      ITERATE( 4); ITERATE( 5); ITERATE( 6); ITERATE( 7);

      ((u32*)output)[0] ^= ((u32*)input)[0];
      ((u32*)output)[1] ^= ((u32*)input)[1];

      ITERATE( 8); ITERATE( 9); ITERATE(10); ITERATE(11);
      ITERATE(12); ITERATE(13); ITERATE(14); ITERATE(15);

      ((u32*)output)[2] ^= ((u32*)input)[2];
      ((u32*)output)[3] ^= ((u32*)input)[3];
    }

  for (msglen += 16; msglen > 0; --msglen, ++output, ++input)
    {
      ITERATE(0);
      output[0] ^= input[0];
    }

  ctx->i = i;
  ctx->j = j;
}

/* ------------------------------------------------------------------------- */
