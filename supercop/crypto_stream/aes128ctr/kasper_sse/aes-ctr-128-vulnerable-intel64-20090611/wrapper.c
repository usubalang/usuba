#include "ecrypt-sync-ae.h"
#include <string.h>
#include <stdio.h>

extern void ECRYPT_keysetup(ECRYPT_AE_ctx *ctx, const u8 *key, const u32 keysize, const u32 ivsize);
extern void process_bytes(int action, const ECRYPT_AE_ctx *ctx, const u8 *input, const u8 *output, u32 len);
extern void finalmul(ECRYPT_AE_ctx *ctx, u8 *mac, u8 *ey0);
extern void tablesetup(ECRYPT_AE_ctx *ctx, const u8 *h);
extern void authenticate(ECRYPT_AE_ctx *ctx, const u8 *cipher, u32 len);


void ECRYPT_init()
{
    ;
}

void ECRYPT_AE_ivsetup(ECRYPT_AE_ctx* ctx, const u8* iv)
{
    memcpy(&ctx->counter, iv, 12);
    *(((unsigned char *)&ctx->counter) + 12) = 0;
    *(((unsigned char *)&ctx->counter) + 13) = 0;
    *(((unsigned char *)&ctx->counter) + 14) = 0;
    *(((unsigned char *)&ctx->counter) + 15) = 2;
    memset(&ctx->authtag, 0, 16);
    ctx->totallen = 0;
}

void ECRYPT_AE_keysetup(ECRYPT_AE_ctx* ctx, const u8* key, u32 keysize, u32 ivsize, u32 macsize)
{
    unsigned char h[16] = {0};
    unsigned int i;

    memset(&ctx->counter, 0, 16);

    ECRYPT_keysetup(ctx, key, 16, 12);
    process_bytes(0, ctx, h, h, 16);
    tablesetup(ctx, h); 
}

/* action 0 = encrypt; action 1 = decrypt; */
void ECRYPT_AE_process_bytes( int action, ECRYPT_AE_ctx* ctx, const u8* input, u8* output, u32 msglen)
{   

              
    if(action == 0)
    {
        process_bytes(0, ctx, input, output, msglen);
        authenticate(ctx, output, msglen);
    }
    else
    {
        authenticate(ctx, input, msglen);
        process_bytes(0, ctx, input, output, msglen);
    }
}

void ECRYPT_AE_finalize(ECRYPT_AE_ctx* ctx, u8* mac)
{
    unsigned char ey0[16] = {0};
    *(((unsigned char *)&ctx->counter) + 12) = 0;
    *(((unsigned char *)&ctx->counter) + 13) = 0;
    *(((unsigned char *)&ctx->counter) + 14) = 0;
    *(((unsigned char *)&ctx->counter) + 15) = 1;
    process_bytes(0, ctx, ey0, ey0, 16);
    finalmul(ctx, mac, ey0); 
}
