/* copy.c */

/* 
 * COPY stream cipher (does nothing, but in an API compliant way)
 *
 * Author: Christophe De Canni\`ere, K.U.Leuven.
 */

/* ------------------------------------------------------------------------- */

#include "ecrypt-sync.h"
#include <string.h>

/* ------------------------------------------------------------------------- */

void ECRYPT_init(void)
{ }

/* ------------------------------------------------------------------------- */

void ECRYPT_keysetup(
  ECRYPT_ctx* ctx, 
  const u8* key, 
  u32 keysize,
  u32 ivsize)
{ }

/* ------------------------------------------------------------------------- */

void ECRYPT_ivsetup(
  ECRYPT_ctx* ctx, 
  const u8* iv)
{ }

/* ------------------------------------------------------------------------- */

void ECRYPT_process_bytes(
  int action,
  ECRYPT_ctx* ctx, 
  const u8* input, 
  u8* output, 
  u32 msglen)
{ 
  memmove(output, input, msglen);
}

/* ------------------------------------------------------------------------- */
