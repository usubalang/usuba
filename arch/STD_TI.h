#ifndef STD_TI
#define STD_TI

#include <stdint.h>
#include <stdlib.h>

#ifndef TI
#error Undefined macro TI. Should be the number of shares (2,3,4,8).
#endif

#define CONCAT(x, y) x ## y
#define CONCAT2(x, y) CONCAT(x,y)

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#if BITS_PER_REG == 64
#error 64-bits TI not supported.
#endif

#define B BITS_PER_REG

/* TI specific stuffs */

#define L_SHIFT_BLOC(x,n,m,ti) (((x & m) << n) & m)
#define R_SHIFT_BLOC(x,n,m,ti) (((x & m) >> n) & m)
#define L_ROTATE_BLOC(x,n,m,ti) ((((x & m) << n) | ((x & m) >> (ti-n))) & m)
#define R_ROTATE_BLOC(x,n,m,ti) ((((x & m) >> n) | ((x & m) << (ti-n))) & m)

#define L_SHIFT_8(x,n) CONCAT2(ROTATE_8_,B)(x,n,L,SHIFT)
#define L_SHIFT_4(x,n) CONCAT2(ROTATE_4_,B)(x,n,L,SHIFT)
#define L_SHIFT_3(x,n) CONCAT2(ROTATE_3_,B)(x,n,L,SHIFT)
#define L_SHIFT_2(x,n) CONCAT2(ROTATE_2_,B)(x,n,L,SHIFT)

#define R_SHIFT_8(x,n) CONCAT2(ROTATE_8_,B)(x,n,L,SHIFT)
#define R_SHIFT_4(x,n) CONCAT2(ROTATE_4_,B)(x,n,L,SHIFT)
#define R_SHIFT_3(x,n) CONCAT2(ROTATE_3_,B)(x,n,L,SHIFT)
#define R_SHIFT_2(x,n) CONCAT2(ROTATE_2_,B)(x,n,L,SHIFT)

#define L_ROTATE_8(x,n) CONCAT2(ROTATE_8_,B)(x,n,L,ROTATE)
#define L_ROTATE_4(x,n) CONCAT2(ROTATE_4_,B)(x,n,L,ROTATE)
#define L_ROTATE_3(x,n) CONCAT2(ROTATE_3_,B)(x,n,L,ROTATE)
#define L_ROTATE_2(x,n) CONCAT2(ROTATE_2_,B)(x,n,L,ROTATE)

#define R_ROTATE_8(x,n) CONCAT2(ROTATE_8_,B)(x,n,L,ROTATE)
#define R_ROTATE_4(x,n) CONCAT2(ROTATE_4_,B)(x,n,L,ROTATE)
#define R_ROTATE_3(x,n) CONCAT2(ROTATE_3_,B)(x,n,L,ROTATE)
#define R_ROTATE_2(x,n) CONCAT2(ROTATE_2_,B)(x,n,L,ROTATE)

#define ROTATE_8_32(x,n,DIR,OP)                 \
  DIR##_##OP##_BLOC(x,n,0xFF,8) |               \
  DIR##_##OP##_BLOC(x,n,0xFF00,8) |             \
  DIR##_##OP##_BLOC(x,n,0xFF0000,8) |           \
  DIR##_##OP##_BLOC(x,n,0xFF000000,8)
#if BITS_PER_REG == 64
#define ROTATE_8_64(x,n,DIR,OP)                 \
  ROTATE_8_32(x,n,DIR,OP)                       \
  | DIR##_##OP##_BLOC(x,n,0xFF00000000,8)       \
  | DIR##_##OP##_BLOC(x,n,0xFF0000000000,8)     \
  | DIR##_##OP##_BLOC(x,n,0xFF000000000000,8)   \
  | DIR##_##OP##_BLOC(x,n,0xFF00000000000000,8)
#endif
    

#define ROTATE_4_32(x,n,DIR,OP)                 \
  DIR##_##OP##_BLOC(x,n,0xF,4) |                \
  DIR##_##OP##_BLOC(x,n,0xF0,4) |               \
  DIR##_##OP##_BLOC(x,n,0xF00,4) |              \
  DIR##_##OP##_BLOC(x,n,0xF000,4) |             \
  DIR##_##OP##_BLOC(x,n,0xF0000,4) |            \
  DIR##_##OP##_BLOC(x,n,0xF00000,4) |           \
  DIR##_##OP##_BLOC(x,n,0xF000000,4) |          \
  DIR##_##OP##_BLOC(x,n,0xF0000000,4)
#if BITS_PER_REG == 64
#define ROTATE_4_64(x,n,DIR,OP)                 \
  ROTATE_4_32(x,n,DIR,OP)                       \
  | DIR##_##OP##_BLOC(x,n,0xF00000000,4)        \
  | DIR##_##OP##_BLOC(x,n,0xF000000000,4)       \
  | DIR##_##OP##_BLOC(x,n,0xF0000000000,4)      \
  | DIR##_##OP##_BLOC(x,n,0xF00000000000,4)     \
  | DIR##_##OP##_BLOC(x,n,0xF000000000000,4)    \
  | DIR##_##OP##_BLOC(x,n,0xF0000000000000,4)   \
  | DIR##_##OP##_BLOC(x,n,0xF00000000000000,4)  \
  | DIR##_##OP##_BLOC(x,n,0xF000000000000000,4)
#endif
  

#define ROTATE_3_32(x,n,DIR,OP)                                \
  DIR##_##OP##_BLOC(x,n,0b111,3) |                          \
  DIR##_##OP##_BLOC(x,n,0b111000,3) |                       \
  DIR##_##OP##_BLOC(x,n,0b111000000,3) |                    \
  DIR##_##OP##_BLOC(x,n,0b111000000000,3) |                 \
  DIR##_##OP##_BLOC(x,n,0b111000000000000,3) |              \
  DIR##_##OP##_BLOC(x,n,0b111000000000000000,3) |           \
  DIR##_##OP##_BLOC(x,n,0b111000000000000000000,3) |        \
  DIR##_##OP##_BLOC(x,n,0b111000000000000000000000,3) |     \
  DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000,3) |  \
  DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000,3) 
#if BITS_PER_REG == 64
#define ROTATE_3_64(x,n,DIR,OP)                                         \
  ROTATE_3_32(x,n,DIR,OP)                                               \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000,3)        \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000,3)     \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000,3)  \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000000000000000,3) \
  | DIR##_##OP##_BLOC(x,n,0b111000000000000000000000000000000000000000000000000000000000000,3)
#endif

#define ROTATE_2_32(x,n,DIR,OP)                 \
  DIR##_##OP##_BLOC(x,n,0x3,2) |                \
  DIR##_##OP##_BLOC(x,n,0xC,2) |                \
  DIR##_##OP##_BLOC(x,n,0x30,2) |               \
  DIR##_##OP##_BLOC(x,n,0xC0,2) |               \
  DIR##_##OP##_BLOC(x,n,0x300,2) |              \
  DIR##_##OP##_BLOC(x,n,0xC00,2) |              \
  DIR##_##OP##_BLOC(x,n,0x3000,2) |             \
  DIR##_##OP##_BLOC(x,n,0xC000,2) |             \
  DIR##_##OP##_BLOC(x,n,0x30000,2) |            \
  DIR##_##OP##_BLOC(x,n,0xC0000,2) |            \
  DIR##_##OP##_BLOC(x,n,0x300000,2) |           \
  DIR##_##OP##_BLOC(x,n,0xC00000,2) |           \
  DIR##_##OP##_BLOC(x,n,0x3000000,2) |          \
  DIR##_##OP##_BLOC(x,n,0xC000000,2) |          \
  DIR##_##OP##_BLOC(x,n,0x30000000,2) |         \
  DIR##_##OP##_BLOC(x,n,0xC0000000,2)
#if BITS_PER_REG == 64
#define ROTATE_2_64(x,n,DIR,OP)                     \
  ROTATE_2_32(x,n,DIR,OP)                           \
  | DIR##_##OP##_BLOC(x,n,0x300000000,2)            \
  | DIR##_##OP##_BLOC(x,n,0xC00000000,2)            \
  | DIR##_##OP##_BLOC(x,n,0x3000000000,2)           \
  | DIR##_##OP##_BLOC(x,n,0xC000000000,2)           \
  | DIR##_##OP##_BLOC(x,n,0x30000000000,2)          \
  | DIR##_##OP##_BLOC(x,n,0xC0000000000,2)          \
  | DIR##_##OP##_BLOC(x,n,0x300000000000,2)         \
  | DIR##_##OP##_BLOC(x,n,0xC00000000000,2)         \
  | DIR##_##OP##_BLOC(x,n,0x3000000000000,2)        \
  | DIR##_##OP##_BLOC(x,n,0xC000000000000,2)        \
  | DIR##_##OP##_BLOC(x,n,0x30000000000000,2)       \
  | DIR##_##OP##_BLOC(x,n,0xC0000000000000,2)       \
  | DIR##_##OP##_BLOC(x,n,0x300000000000000,2)      \
  | DIR##_##OP##_BLOC(x,n,0xC00000000000000,2)      \
  | DIR##_##OP##_BLOC(x,n,0x3000000000000000,2)     \
  | DIR##_##OP##_BLOC(x,n,0xC000000000000000,2)
#endif

#if BITS_PER_REG == 32
#define ONE_2 0xAAAAAAAA
#define ONE_3 0b001001001001001001001001001001
#define ONE_4 0x11111111
#define ONE_8 0x01010101
#elif BITS_PER_REG == 64
#define ONE_2 0xAAAAAAAAAAAAAAAA
#define ONE_3 0b001001001001001001001001001001001001001001001001001001001001001
#define ONE_4 0x1111111111111111
#define ONE_8 0x0101010101010101
#endif

#define ONE CONCAT2(ONE_,TI)

#define L_SHIFT(a,b,c) CONCAT2(L_SHIFT_,TI)(a,b)
#define R_SHIFT(a,b,c) CONCAT2(R_SHIFT_,TI)(a,b)
#define L_ROTATE(a,b,c) CONCAT2(L_ROTATE_,TI)(a,b)
#define R_ROTATE(a,b,c) CONCAT2(R_ROTATE_,TI)(a,b)


/* General stuffs */

#define AND(a,b)  ((a) & (b))
#define OR(a,b)   ((a) | (b))
#define XOR(a,b)  ((a) ^ (b))
#define ANDN(a,b) (NOT(a) & (b))
#define NOT(a)    XOR(a,ONE)


#ifndef DATATYPE
#if BITS_PER_REG == 32
#define DATATYPE unsigned int
#else
#define DATATYPE uint64_t
#endif
#endif

#define SET_ALL_ONE()  -1
#define SET_ALL_ZERO() 0

#define RAND rand

#endif
