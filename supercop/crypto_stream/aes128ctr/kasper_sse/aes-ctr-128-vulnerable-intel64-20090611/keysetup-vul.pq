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

stack64 r11_caller_stack
stack64 r12_caller_stack

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
int6464 t

stack128 key_stack
int64 keyp

enter ECRYPT_keysetup

r11_caller_stack = r11_caller
#r12_caller_stack = r12_caller

c = arg1
k = arg2

sboxp = &sbox
keyp = &key_stack

x0 = *(uint32 *) (k + 0)
x1 = *(uint32 *) (k + 4)
x2 = *(uint32 *) (k + 8)
x3 = *(uint32 *) (k + 12)
*(uint32 *) (keyp + 0) = x0
*(uint32 *) (keyp + 4) = x1
*(uint32 *) (keyp + 8) = x2
*(uint32 *) (keyp + 12) = x3

bitslicekey0(keyp, c)
keyexp(1,keyp)
bitslicekey(1,keyp,c)
keyexp(2,keyp)
bitslicekey(2,keyp,c)
keyexp(3,keyp)
bitslicekey(3,keyp,c)
keyexp(4,keyp)
bitslicekey(4,keyp,c)
keyexp(5,keyp)
bitslicekey(5,keyp,c)
keyexp(6,keyp)
bitslicekey(6,keyp,c)
keyexp(7,keyp)
bitslicekey(7,keyp,c)
keyexp(8,keyp)
bitslicekey(8,keyp,c)
keyexp(9,keyp)
bitslicekey(9,keyp,c)
keyexp(10,keyp)
bitslicekey10(keyp,c)

r11_caller = r11_caller_stack 
#r12_caller = r12_caller_stack 

leave

