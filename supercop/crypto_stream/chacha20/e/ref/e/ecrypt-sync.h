#define crypto_stream_chacha20_e_ref_ECRYPT_VARIANT 1
#define crypto_stream_chacha20_e_ref_ECRYPT_API
/* ecrypt-sync.h */

/* 
 * Header file for synchronous stream ciphers without authentication
 * mechanism.
 * 
 * *** Please only edit parts marked with "[edit]". ***
 */

#ifndef crypto_stream_chacha20_e_ref_ECRYPT_SYNC
#define crypto_stream_chacha20_e_ref_ECRYPT_SYNC

#include "ecrypt-portable.h"

/* ------------------------------------------------------------------------- */

/* Cipher parameters */

/* 
 * The name of your cipher.
 */
#define crypto_stream_chacha20_e_ref_ECRYPT_NAME "ChaCha20"
#define crypto_stream_chacha20_e_ref_ECRYPT_PROFILE "_____"

/*
 * Specify which key and IV sizes are supported by your cipher. A user
 * should be able to enumerate the supported sizes by running the
 * following code:
 *
 * for (i = 0; crypto_stream_chacha20_e_ref_ECRYPT_KEYSIZE(i) <= crypto_stream_chacha20_e_ref_ECRYPT_MAXKEYSIZE; ++i)
 *   {
 *     keysize = crypto_stream_chacha20_e_ref_ECRYPT_KEYSIZE(i);
 *
 *     ...
 *   }
 *
 * All sizes are in bits.
 */

#define crypto_stream_chacha20_e_ref_ECRYPT_MAXKEYSIZE 256                 /* [edit] */
#define crypto_stream_chacha20_e_ref_ECRYPT_KEYSIZE(i) (128 + (i)*128)     /* [edit] */

#define crypto_stream_chacha20_e_ref_ECRYPT_MAXIVSIZE 64                   /* [edit] */
#define crypto_stream_chacha20_e_ref_ECRYPT_IVSIZE(i) (64 + (i)*64)        /* [edit] */

/* ------------------------------------------------------------------------- */

/* Data structures */

/* 
 * crypto_stream_chacha20_e_ref_ECRYPT_ctx is the structure containing the representation of the
 * internal state of your cipher. 
 */

typedef struct
{
  u32 input[16]; /* could be compressed */
  /* 
   * [edit]
   *
   * Put here all state variable needed during the encryption process.
   */
} crypto_stream_chacha20_e_ref_ECRYPT_ctx;

/* ------------------------------------------------------------------------- */

/* Mandatory functions */

/*
 * Key and message independent initialization. This function will be
 * called once when the program starts (e.g., to build expanded S-box
 * tables).
 */
void crypto_stream_chacha20_e_ref_ECRYPT_init();

/*
 * Key setup. It is the user's responsibility to select the values of
 * keysize and ivsize from the set of supported values specified
 * above.
 */
void crypto_stream_chacha20_e_ref_ECRYPT_keysetup(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* key, 
  u32 keysize,                /* Key size in bits. */ 
  u32 ivsize);                /* IV size in bits. */ 

/*
 * IV setup. After having called crypto_stream_chacha20_e_ref_ECRYPT_keysetup(), the user is
 * allowed to call crypto_stream_chacha20_e_ref_ECRYPT_ivsetup() different times in order to
 * encrypt/decrypt different messages with the same key but different
 * IV's.
 */
void crypto_stream_chacha20_e_ref_ECRYPT_ivsetup(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* iv);

/*
 * Encryption/decryption of arbitrary length messages.
 *
 * For efficiency reasons, the API provides two types of
 * encrypt/decrypt functions. The crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes() function
 * (declared here) encrypts byte strings of arbitrary length, while
 * the crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks() function (defined later) only accepts
 * lengths which are multiples of crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH.
 * 
 * The user is allowed to make multiple calls to
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks() to incrementally encrypt a long message,
 * but he is NOT allowed to make additional encryption calls once he
 * has called crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes() (unless he starts a new message
 * of course). For example, this sequence of calls is acceptable:
 *
 * crypto_stream_chacha20_e_ref_ECRYPT_keysetup();
 *
 * crypto_stream_chacha20_e_ref_ECRYPT_ivsetup();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes();
 *
 * crypto_stream_chacha20_e_ref_ECRYPT_ivsetup();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 *
 * crypto_stream_chacha20_e_ref_ECRYPT_ivsetup();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes();
 * 
 * The following sequence is not:
 *
 * crypto_stream_chacha20_e_ref_ECRYPT_keysetup();
 * crypto_stream_chacha20_e_ref_ECRYPT_ivsetup();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes();
 * crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks();
 */

void crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* plaintext, 
  u8* ciphertext, 
  u32 msglen);                /* Message length in bytes. */ 

void crypto_stream_chacha20_e_ref_ECRYPT_decrypt_bytes(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* ciphertext, 
  u8* plaintext, 
  u32 msglen);                /* Message length in bytes. */ 

/* ------------------------------------------------------------------------- */

/* Optional features */

/* 
 * For testing purposes it can sometimes be useful to have a function
 * which immediately generates keystream without having to provide it
 * with a zero plaintext. If your cipher cannot provide this function
 * (e.g., because it is not strictly a synchronous cipher), please
 * reset the crypto_stream_chacha20_e_ref_ECRYPT_GENERATES_KEYSTREAM flag.
 */

#define crypto_stream_chacha20_e_ref_ECRYPT_GENERATES_KEYSTREAM
#ifdef crypto_stream_chacha20_e_ref_ECRYPT_GENERATES_KEYSTREAM

void crypto_stream_chacha20_e_ref_ECRYPT_keystream_bytes(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx,
  u8* keystream,
  u32 length);                /* Length of keystream in bytes. */

#endif

/* ------------------------------------------------------------------------- */

/* Optional optimizations */

/* 
 * By default, the functions in this section are implemented using
 * calls to functions declared above. However, you might want to
 * implement them differently for performance reasons.
 */

/*
 * All-in-one encryption/decryption of (short) packets.
 *
 * The default definitions of these functions can be found in
 * "ecrypt-sync.c". If you want to implement them differently, please
 * undef the crypto_stream_chacha20_e_ref_ECRYPT_USES_DEFAULT_ALL_IN_ONE flag.
 */
#define crypto_stream_chacha20_e_ref_ECRYPT_USES_DEFAULT_ALL_IN_ONE        /* [edit] */

void crypto_stream_chacha20_e_ref_ECRYPT_encrypt_packet(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* iv,
  const u8* plaintext, 
  u8* ciphertext, 
  u32 msglen);

void crypto_stream_chacha20_e_ref_ECRYPT_decrypt_packet(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* iv,
  const u8* ciphertext, 
  u8* plaintext, 
  u32 msglen);

/*
 * Encryption/decryption of blocks.
 * 
 * By default, these functions are defined as macros. If you want to
 * provide a different implementation, please undef the
 * crypto_stream_chacha20_e_ref_ECRYPT_USES_DEFAULT_BLOCK_MACROS flag and implement the functions
 * declared below.
 */

#define crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH 64                  /* [edit] */

#define crypto_stream_chacha20_e_ref_ECRYPT_USES_DEFAULT_BLOCK_MACROS      /* [edit] */
#ifdef crypto_stream_chacha20_e_ref_ECRYPT_USES_DEFAULT_BLOCK_MACROS

#define crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks(ctx, plaintext, ciphertext, blocks)  \
  crypto_stream_chacha20_e_ref_ECRYPT_encrypt_bytes(ctx, plaintext, ciphertext,                 \
    (blocks) * crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH)

#define crypto_stream_chacha20_e_ref_ECRYPT_decrypt_blocks(ctx, ciphertext, plaintext, blocks)  \
  crypto_stream_chacha20_e_ref_ECRYPT_decrypt_bytes(ctx, ciphertext, plaintext,                 \
    (blocks) * crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH)

#ifdef crypto_stream_chacha20_e_ref_ECRYPT_GENERATES_KEYSTREAM

#define crypto_stream_chacha20_e_ref_ECRYPT_keystream_blocks(ctx, keystream, blocks)            \
  crypto_stream_chacha20_e_ref_ECRYPT_keystream_bytes(ctx, keystream,                        \
    (blocks) * crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH)

#endif

#else

void crypto_stream_chacha20_e_ref_ECRYPT_encrypt_blocks(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* plaintext, 
  u8* ciphertext, 
  u32 blocks);                /* Message length in blocks. */ 

void crypto_stream_chacha20_e_ref_ECRYPT_decrypt_blocks(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx, 
  const u8* ciphertext, 
  u8* plaintext, 
  u32 blocks);                /* Message length in blocks. */ 

#ifdef crypto_stream_chacha20_e_ref_ECRYPT_GENERATES_KEYSTREAM

void crypto_stream_chacha20_e_ref_ECRYPT_keystream_blocks(
  crypto_stream_chacha20_e_ref_ECRYPT_ctx* ctx,
  const u8* keystream,
  u32 blocks);                /* Keystream length in blocks. */ 

#endif

#endif

/*
 * If your cipher can be implemented in different ways, you can use
 * the crypto_stream_chacha20_e_ref_ECRYPT_VARIANT parameter to allow the user to choose between
 * them at compile time (e.g., gcc -Dcrypto_stream_chacha20_e_ref_ECRYPT_VARIANT=3 ...). Please
 * only use this possibility if you really think it could make a
 * significant difference and keep the number of variants
 * (crypto_stream_chacha20_e_ref_ECRYPT_MAXVARIANT) as small as possible (definitely not more than
 * 10). Note also that all variants should have exactly the same
 * external interface (i.e., the same crypto_stream_chacha20_e_ref_ECRYPT_BLOCKLENGTH, etc.). 
 */
#define crypto_stream_chacha20_e_ref_ECRYPT_MAXVARIANT 1                   /* [edit] */

#ifndef crypto_stream_chacha20_e_ref_ECRYPT_VARIANT
#define crypto_stream_chacha20_e_ref_ECRYPT_VARIANT 1
#endif

#if (crypto_stream_chacha20_e_ref_ECRYPT_VARIANT > crypto_stream_chacha20_e_ref_ECRYPT_MAXVARIANT)
#error this variant does not exist
#endif

/* ------------------------------------------------------------------------- */

#endif
