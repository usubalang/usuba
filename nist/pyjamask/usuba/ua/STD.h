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

#ifndef STD
#define STD
#endif

#ifndef BITS_PER_REG
#define BITS_PER_REG 64
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

#define ZERO 0
#define ONES -1

#define SET_ALL_ONE()  -1
#define SET_ALL_ZERO() 0

#define AND(a,b)  ((a) & (b))
#define OR(a,b)   ((a) | (b))
#define XOR(a,b)  ((a) ^ (b))
#define ANDN(a,b) (~(a) & (b))
#define NOT(a)    (~(a))
