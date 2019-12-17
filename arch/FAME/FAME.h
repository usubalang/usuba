#pragma once

/* Configuration macros:

    - TI: the number of shares of the masking (1, 2, 4)

    - FD: the number of redundant slices (1, 2, 4)

    - PIPELINED: if defined, uses temporal redundancy

    - CORRECT: if defined, does fault correction by majority voting

    - X86: if defined, loads macros to execute on X86 (ie, without
      custom hardware)

    - NO_CUSTOM_INSTR: if defined, doesn't use custom instructions

    - GCC_SUPPORT: if defined, uses normal C instructions instead of
      custom ones, so that gcc can optimize them as it pleases. This
      simulates (ish) what would happen if we patched gcc to be aware
      of the semantics of our new instructions.

    - CHEATY_CUSTOM: if defined, uses normal assembly instructions
      instead of custom ones. This is just a trick to benchmark more
      realistic performances: the custom instructions are buggy
      (performance-wise) on the benchmark board, and using normal
      instruction instead gives more realistic performances.

    - COPROC_RAND: if defined, assumes the presence of a coprocessor
      generating 32 random bits every RANDOM_DELAY cycles.

    - RANDOM_DELAY: see COPROC_RAND

    - CST_RAND: if defined, assumes the presence of a coprocessor
      generating random bits faster than we consume them (ie, we can
      just read from a register without worrying ourselves with the
      availability of new random bytes).

 */

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#define DATATYPE unsigned int
#endif

#ifndef FD
#error FD not defined (should be 1, 2 or 4)
#endif

#ifndef TI
#error TI not defined (should be 1, 2 or 4)
#endif

#if FD != 4 && defined(CORRECT)
#error Cannot use error correcting with FD != 4
#endif

#ifdef CORRECT
#define MULT_CORRECT 1
#else
#define MULT_CORRECT 0
#endif

// Multiplication does fault checking by invoking FTCHK, which takes
// an immediate as input, which describe which version of FTCHK to
// call (this depends on FD).
#if FD == 1
#define IMM_FTCHK 0 /* no redundancy -> no fault check */
#elif FD == 2
#define IMM_FTCHK 0b0011
#elif FD == 4 && !defined(CORRECT)
#define IMM_FTCHK 0b0101
#elif FD == 4 && defined(CORRECT)
#define IMM_FTCHK 0b11101
#else
#error Dunno know what IMM_FTCHK to use...
#endif

#if !defined(FD) || (FD == 1)
#define SET_ALL_ONE()  -1
#define SET_ALL_ZERO() 0
#elif FD == 2
#define SET_ALL_ONE()  0x0000ffff
#define SET_ALL_ZERO() 0xffff0000
#elif FD == 4
#define SET_ALL_ONE()  0x00ff00ff
#define SET_ALL_ZERO() 0xff00ff00
#endif

#ifdef X86
#include <stdio.h>
#include <stdlib.h>
#endif

extern int fault_flags;

// loading custom instruction
#include "FAME_instrs.h"

// loading random
#include "FAME_rand.h"

// loading FD macros
#include "FAME_FD.h"

// loading TI macros
#include "FAME_TI.h"


// Finally defining AND/OR/XOR/NOT (which pretty much the only macros
// used directly by AES).
#define AND(a,b,c) TI_AND(a,b,c) /* a = b & c */
#define OR(a,b,c)  TI_OR(a,b,c)  /* a = b | c */
#define XOR(a,b,c) TI_XOR(a,b,c) /* a = b ^ c */
#define NOT(a,b)   TI_NOT(a,b)   /* a = ~b */
