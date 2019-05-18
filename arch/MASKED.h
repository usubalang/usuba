/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#pragma once
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>

#ifndef MASKING_ORDER
#error MASKING_ORDER not defined.
#endif

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#if BITS_PER_REG == 16
#define DATATYPE uint16_t
#elif BITS_PER_REG == 32
#define DATATYPE uint32_t
#else
#define DATATYPE uint64_t
#endif
#endif

/* Defining 0 and 1 */
#define ZERO 0
#define ONES -1


/* Defining operators */

#define AND(r,a,b)  isw_mult(r,a,b)

#define OR(r,a,b) {                             \
    DATATYPE nota[MASKING_ORDER], notb[MASKING_ORDER], notr[MASKING_ORDER]; \
    NOT(nota,a);                                                        \
    NOT(notb,b);                                                        \
    AND(notr,nota,notb);                                                \
    NOT(r,notr);                                                        \
  }

#define XOR(r,a,b)                                                      \
  for (int i_In_Header = 0; i_In_Header < MASKING_ORDER; i_In_Header++) \
    r[i_In_Header] = a[i_In_Header] ^ b[i_In_Header];

#define NOT(r,a)                                                        \
  r[0] = ~a[0];                                                         \
  for (int i_In_Header = 1; i_In_Header < MASKING_ORDER; i_In_Header++) \
    r[i_In_Header] = a[i_In_Header];

#define ASGN(r,a)                                                       \
  for (int i_In_Header = 0; i_In_Header < MASKING_ORDER; i_In_Header++) \
    r[i_In_Header] = a[i_In_Header];



/* Multiplication and refresh */

static uint32_t get_random()
{
    srand(time(NULL));
    return (uint32_t) rand();
}


static void isw_mult(uint32_t *res, const uint32_t *op1, const uint32_t *op2)
{
    int i,j;
    uint32_t rnd;

    for (i=0; i<MASKING_ORDER; i++)
    {
        res[i] = 0;
    }

    for (i=0; i<MASKING_ORDER; i++)
    {
        res[i] ^= op1[i] & op2[i];
        
        for (j=i+1; j<MASKING_ORDER; j++)
        {
            rnd = get_random();
            res[i] ^= rnd;
            res[j] ^= (rnd ^ (op1[i] & op2[j])) ^ (op1[j] & op2[i]);
        }
    }
}


static void isw_refresh(uint32_t *res, const uint32_t *in)
{
    int i,j;
    uint32_t rnd;

    for (i=0; i<MASKING_ORDER; i++)
    {
        res[i] = in[i];
    }

    for (i=0; i<MASKING_ORDER; i++)
    {        
        for (j=i+1; j<MASKING_ORDER; j++)
        {
            rnd = get_random();
            res[i] ^= rnd;
            res[j] ^= rnd;
        }
    }
}

