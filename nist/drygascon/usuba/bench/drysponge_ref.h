/**
DrySponge
Sebastien Riou, January 6th 2019
c99 ref implementation meant to fit in the supercop framework
*/
#ifndef __DRYSPONGE_H__
#define __DRYSPONGE_H__

#include "drysponge_common.h"


typedef struct DRYSPONGE_struct_t {
    uint8_t c[DRYSPONGE_CAPACITYSIZE];
    uint8_t x[DRYSPONGE_XSIZE];
    uint8_t r[DRYSPONGE_BLOCKSIZE];
    uint8_t *obuf;
    uint64_t fcnt;
    #ifdef DRYSPONGE_EXT
    DRYSPONGE_EXT_t ext;
    #endif
    unsigned int rounds;
} DRYSPONGE_t;


void DRYSPONGE_g(
    DRYSPONGE_t *const ctx
){
    memset(ctx->r,0,DRYSPONGE_BLOCKSIZE);
    for(unsigned int j = 0;j<ctx->rounds;j++){
        DRYSPONGE_CoreRound(ctx,j);
        for(unsigned int k=0;k<DRYSPONGE_ACCUMULATE_FACTOR;k++){
            uint8_t *cpart = ctx->c+4*k*DRYSPONGE_BLOCKSIZE32;
            for(unsigned int i=0;i<DRYSPONGE_BLOCKSIZE;i++){
                ctx->r[i]^=cpart[(i+k*4)%DRYSPONGE_BLOCKSIZE];
            }
        }
    }
}

#endif
