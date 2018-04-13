# Author: Peter Schwabe, ported from an assembly implementation by Emilia Käsper
# Date: 2009-03-19
# Public domain

@include "common.pq"
 
int64 arg1
int64 arg2
input arg1
input arg2

int64 r11_caller
int64 r12_caller
int64 r13_caller
int64 r14_caller
int64 r15_caller
int64 rbx_caller
int64 rbp_caller
caller r11_caller
caller r12_caller
caller r13_caller
caller r14_caller
caller r15_caller
caller rbx_caller
caller rbp_caller

int64 sboxp

int64 c
int64 k

int64 x0
int64 x1
int64 x2
int64 x3
int64 e
int64 q0
int64 q1
int64 q2
int64 q3

int6464 xmm0
int6464 xmm1
int6464 xmm2
int6464 xmm3
int6464 xmm4
int6464 xmm5
int6464 xmm6
int6464 xmm7
int6464 xmm8
int6464 xmm9
int6464 xmm10
int6464 xmm11
int6464 xmm12
int6464 xmm13
int6464 xmm14
int6464 xmm15
int6464 t

enter ECRYPT_keysetup

c = arg1
k = arg2

bitslicekey0(k, c)

keyexpbs1(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15,c)
keyexpbs(xmm0, xmm1, xmm4, xmm6, xmm3, xmm7, xmm2, xmm5, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm1 ^= RCON, 2,c)
keyexpbs(xmm0, xmm1, xmm3, xmm2, xmm6, xmm5, xmm4, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm6 ^= RCON, 3,c)
keyexpbs(xmm0, xmm1, xmm6, xmm4, xmm2, xmm7, xmm3, xmm5, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm3 ^= RCON, 4,c)

keyexpbs(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm3 ^= RCON, 5,c)
keyexpbs(xmm0, xmm1, xmm4, xmm6, xmm3, xmm7, xmm2, xmm5, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm5 ^= RCON, 6,c)
keyexpbs(xmm0, xmm1, xmm3, xmm2, xmm6, xmm5, xmm4, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm3 ^= RCON, 7,c)
keyexpbs(xmm0, xmm1, xmm6, xmm4, xmm2, xmm7, xmm3, xmm5, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm7 ^= RCON, 8,c)

keyexpbs(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0 ^= RCON;\xmm1 ^= RCON;\xmm6 ^= RCON;\xmm3 ^= RCON, 9,c)
keyexpbs10(xmm0, xmm1, xmm4, xmm6, xmm3, xmm7, xmm2, xmm5, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15,c)

leave

