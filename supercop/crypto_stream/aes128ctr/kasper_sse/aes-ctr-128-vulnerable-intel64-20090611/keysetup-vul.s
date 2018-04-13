
# qhasm: int64 arg1

# qhasm: int64 arg2

# qhasm: input arg1

# qhasm: input arg2

# qhasm: int64 r11_caller

# qhasm: int64 r12_caller

# qhasm: int64 r13_caller

# qhasm: int64 r14_caller

# qhasm: int64 r15_caller

# qhasm: int64 rbx_caller

# qhasm: int64 rbp_caller

# qhasm: caller r11_caller

# qhasm: caller r12_caller

# qhasm: caller r13_caller

# qhasm: caller r14_caller

# qhasm: caller r15_caller

# qhasm: caller rbx_caller

# qhasm: caller rbp_caller

# qhasm: stack64 r11_caller_stack

# qhasm: stack64 r12_caller_stack

# qhasm: int64 sboxp

# qhasm: int64 c

# qhasm: int64 k

# qhasm: int64 x0

# qhasm: int64 x1

# qhasm: int64 x2

# qhasm: int64 x3

# qhasm: int64 e

# qhasm: int64 q0

# qhasm: int64 q1

# qhasm: int64 q2

# qhasm: int64 q3

# qhasm: int6464 xmm0

# qhasm: int6464 xmm1

# qhasm: int6464 xmm2

# qhasm: int6464 xmm3

# qhasm: int6464 xmm4

# qhasm: int6464 xmm5

# qhasm: int6464 xmm6

# qhasm: int6464 xmm7

# qhasm: int6464 t

# qhasm: stack128 key_stack

# qhasm: int64 keyp

# qhasm: enter ECRYPT_keysetup
.text
.p2align 5
.globl _ECRYPT_keysetup
.globl ECRYPT_keysetup
_ECRYPT_keysetup:
ECRYPT_keysetup:
mov %rsp,%r11
and $31,%r11
add $64,%r11
sub %r11,%rsp

# qhasm: r11_caller_stack = r11_caller
# asm 1: movq <r11_caller=int64#9,>r11_caller_stack=stack64#1
# asm 2: movq <r11_caller=%r11,>r11_caller_stack=32(%rsp)
movq %r11,32(%rsp)

# qhasm: c = arg1
# asm 1: mov  <arg1=int64#1,>c=int64#4
# asm 2: mov  <arg1=%rdi,>c=%rcx
mov  %rdi,%rcx

# qhasm: k = arg2
# asm 1: mov  <arg2=int64#2,>k=int64#1
# asm 2: mov  <arg2=%rsi,>k=%rdi
mov  %rsi,%rdi

# qhasm: sboxp = &sbox
# asm 1: lea  sbox(%rip),>sboxp=int64#2
# asm 2: lea  sbox(%rip),>sboxp=%rsi
lea  sbox(%rip),%rsi

# qhasm: keyp = &key_stack
# asm 1: leaq <key_stack=stack128#1,>keyp=int64#5
# asm 2: leaq <key_stack=0(%rsp),>keyp=%r8
leaq 0(%rsp),%r8

# qhasm: x0 = *(uint32 *) (k + 0)
# asm 1: movl   0(<k=int64#1),>x0=int64#6d
# asm 2: movl   0(<k=%rdi),>x0=%r9d
movl   0(%rdi),%r9d

# qhasm: x1 = *(uint32 *) (k + 4)
# asm 1: movl   4(<k=int64#1),>x1=int64#7d
# asm 2: movl   4(<k=%rdi),>x1=%eax
movl   4(%rdi),%eax

# qhasm: x2 = *(uint32 *) (k + 8)
# asm 1: movl   8(<k=int64#1),>x2=int64#8d
# asm 2: movl   8(<k=%rdi),>x2=%r10d
movl   8(%rdi),%r10d

# qhasm: x3 = *(uint32 *) (k + 12)
# asm 1: movl   12(<k=int64#1),>x3=int64#3d
# asm 2: movl   12(<k=%rdi),>x3=%edx
movl   12(%rdi),%edx

# qhasm: *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm: *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm: *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm: *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   *(int128 *) (c + 0) = xmm0
# asm 1: movdqa <xmm0=int6464#1,0(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,0(<c=%rcx)
movdqa %xmm0,0(%rcx)

# qhasm:   *(int128 *) (c + 16) = xmm1
# asm 1: movdqa <xmm1=int6464#2,16(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,16(<c=%rcx)
movdqa %xmm1,16(%rcx)

# qhasm:   *(int128 *) (c + 32) = xmm2
# asm 1: movdqa <xmm2=int6464#3,32(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,32(<c=%rcx)
movdqa %xmm2,32(%rcx)

# qhasm:   *(int128 *) (c + 48) = xmm3
# asm 1: movdqa <xmm3=int6464#4,48(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,48(<c=%rcx)
movdqa %xmm3,48(%rcx)

# qhasm:   *(int128 *) (c + 64) = xmm4
# asm 1: movdqa <xmm4=int6464#5,64(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,64(<c=%rcx)
movdqa %xmm4,64(%rcx)

# qhasm:   *(int128 *) (c + 80) = xmm5
# asm 1: movdqa <xmm5=int6464#6,80(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,80(<c=%rcx)
movdqa %xmm5,80(%rcx)

# qhasm:   *(int128 *) (c + 96) = xmm6
# asm 1: movdqa <xmm6=int6464#7,96(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,96(<c=%rcx)
movdqa %xmm6,96(%rcx)

# qhasm:   *(int128 *) (c + 112) = xmm7
# asm 1: movdqa <xmm7=int6464#8,112(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,112(<c=%rcx)
movdqa %xmm7,112(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 1
# asm 1: xor  $1,<e=int64#9d
# asm 2: xor  $1,<e=%r11d
xor  $1,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 128) = xmm0
# asm 1: movdqa <xmm0=int6464#1,128(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,128(<c=%rcx)
movdqa %xmm0,128(%rcx)

# qhasm:   *(int128 *) (c + 144) = xmm1
# asm 1: movdqa <xmm1=int6464#2,144(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,144(<c=%rcx)
movdqa %xmm1,144(%rcx)

# qhasm:   *(int128 *) (c + 160) = xmm2
# asm 1: movdqa <xmm2=int6464#3,160(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,160(<c=%rcx)
movdqa %xmm2,160(%rcx)

# qhasm:   *(int128 *) (c + 176) = xmm3
# asm 1: movdqa <xmm3=int6464#4,176(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,176(<c=%rcx)
movdqa %xmm3,176(%rcx)

# qhasm:   *(int128 *) (c + 192) = xmm4
# asm 1: movdqa <xmm4=int6464#5,192(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,192(<c=%rcx)
movdqa %xmm4,192(%rcx)

# qhasm:   *(int128 *) (c + 208) = xmm5
# asm 1: movdqa <xmm5=int6464#6,208(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,208(<c=%rcx)
movdqa %xmm5,208(%rcx)

# qhasm:   *(int128 *) (c + 224) = xmm6
# asm 1: movdqa <xmm6=int6464#7,224(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,224(<c=%rcx)
movdqa %xmm6,224(%rcx)

# qhasm:   *(int128 *) (c + 240) = xmm7
# asm 1: movdqa <xmm7=int6464#8,240(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,240(<c=%rcx)
movdqa %xmm7,240(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 2
# asm 1: xor  $2,<e=int64#9d
# asm 2: xor  $2,<e=%r11d
xor  $2,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 256) = xmm0
# asm 1: movdqa <xmm0=int6464#1,256(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,256(<c=%rcx)
movdqa %xmm0,256(%rcx)

# qhasm:   *(int128 *) (c + 272) = xmm1
# asm 1: movdqa <xmm1=int6464#2,272(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,272(<c=%rcx)
movdqa %xmm1,272(%rcx)

# qhasm:   *(int128 *) (c + 288) = xmm2
# asm 1: movdqa <xmm2=int6464#3,288(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,288(<c=%rcx)
movdqa %xmm2,288(%rcx)

# qhasm:   *(int128 *) (c + 304) = xmm3
# asm 1: movdqa <xmm3=int6464#4,304(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,304(<c=%rcx)
movdqa %xmm3,304(%rcx)

# qhasm:   *(int128 *) (c + 320) = xmm4
# asm 1: movdqa <xmm4=int6464#5,320(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,320(<c=%rcx)
movdqa %xmm4,320(%rcx)

# qhasm:   *(int128 *) (c + 336) = xmm5
# asm 1: movdqa <xmm5=int6464#6,336(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,336(<c=%rcx)
movdqa %xmm5,336(%rcx)

# qhasm:   *(int128 *) (c + 352) = xmm6
# asm 1: movdqa <xmm6=int6464#7,352(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,352(<c=%rcx)
movdqa %xmm6,352(%rcx)

# qhasm:   *(int128 *) (c + 368) = xmm7
# asm 1: movdqa <xmm7=int6464#8,368(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,368(<c=%rcx)
movdqa %xmm7,368(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 4
# asm 1: xor  $4,<e=int64#9d
# asm 2: xor  $4,<e=%r11d
xor  $4,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 384) = xmm0
# asm 1: movdqa <xmm0=int6464#1,384(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,384(<c=%rcx)
movdqa %xmm0,384(%rcx)

# qhasm:   *(int128 *) (c + 400) = xmm1
# asm 1: movdqa <xmm1=int6464#2,400(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,400(<c=%rcx)
movdqa %xmm1,400(%rcx)

# qhasm:   *(int128 *) (c + 416) = xmm2
# asm 1: movdqa <xmm2=int6464#3,416(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,416(<c=%rcx)
movdqa %xmm2,416(%rcx)

# qhasm:   *(int128 *) (c + 432) = xmm3
# asm 1: movdqa <xmm3=int6464#4,432(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,432(<c=%rcx)
movdqa %xmm3,432(%rcx)

# qhasm:   *(int128 *) (c + 448) = xmm4
# asm 1: movdqa <xmm4=int6464#5,448(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,448(<c=%rcx)
movdqa %xmm4,448(%rcx)

# qhasm:   *(int128 *) (c + 464) = xmm5
# asm 1: movdqa <xmm5=int6464#6,464(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,464(<c=%rcx)
movdqa %xmm5,464(%rcx)

# qhasm:   *(int128 *) (c + 480) = xmm6
# asm 1: movdqa <xmm6=int6464#7,480(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,480(<c=%rcx)
movdqa %xmm6,480(%rcx)

# qhasm:   *(int128 *) (c + 496) = xmm7
# asm 1: movdqa <xmm7=int6464#8,496(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,496(<c=%rcx)
movdqa %xmm7,496(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 8
# asm 1: xor  $8,<e=int64#9d
# asm 2: xor  $8,<e=%r11d
xor  $8,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 512) = xmm0
# asm 1: movdqa <xmm0=int6464#1,512(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,512(<c=%rcx)
movdqa %xmm0,512(%rcx)

# qhasm:   *(int128 *) (c + 528) = xmm1
# asm 1: movdqa <xmm1=int6464#2,528(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,528(<c=%rcx)
movdqa %xmm1,528(%rcx)

# qhasm:   *(int128 *) (c + 544) = xmm2
# asm 1: movdqa <xmm2=int6464#3,544(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,544(<c=%rcx)
movdqa %xmm2,544(%rcx)

# qhasm:   *(int128 *) (c + 560) = xmm3
# asm 1: movdqa <xmm3=int6464#4,560(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,560(<c=%rcx)
movdqa %xmm3,560(%rcx)

# qhasm:   *(int128 *) (c + 576) = xmm4
# asm 1: movdqa <xmm4=int6464#5,576(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,576(<c=%rcx)
movdqa %xmm4,576(%rcx)

# qhasm:   *(int128 *) (c + 592) = xmm5
# asm 1: movdqa <xmm5=int6464#6,592(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,592(<c=%rcx)
movdqa %xmm5,592(%rcx)

# qhasm:   *(int128 *) (c + 608) = xmm6
# asm 1: movdqa <xmm6=int6464#7,608(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,608(<c=%rcx)
movdqa %xmm6,608(%rcx)

# qhasm:   *(int128 *) (c + 624) = xmm7
# asm 1: movdqa <xmm7=int6464#8,624(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,624(<c=%rcx)
movdqa %xmm7,624(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 16
# asm 1: xor  $16,<e=int64#9d
# asm 2: xor  $16,<e=%r11d
xor  $16,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 640) = xmm0
# asm 1: movdqa <xmm0=int6464#1,640(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,640(<c=%rcx)
movdqa %xmm0,640(%rcx)

# qhasm:   *(int128 *) (c + 656) = xmm1
# asm 1: movdqa <xmm1=int6464#2,656(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,656(<c=%rcx)
movdqa %xmm1,656(%rcx)

# qhasm:   *(int128 *) (c + 672) = xmm2
# asm 1: movdqa <xmm2=int6464#3,672(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,672(<c=%rcx)
movdqa %xmm2,672(%rcx)

# qhasm:   *(int128 *) (c + 688) = xmm3
# asm 1: movdqa <xmm3=int6464#4,688(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,688(<c=%rcx)
movdqa %xmm3,688(%rcx)

# qhasm:   *(int128 *) (c + 704) = xmm4
# asm 1: movdqa <xmm4=int6464#5,704(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,704(<c=%rcx)
movdqa %xmm4,704(%rcx)

# qhasm:   *(int128 *) (c + 720) = xmm5
# asm 1: movdqa <xmm5=int6464#6,720(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,720(<c=%rcx)
movdqa %xmm5,720(%rcx)

# qhasm:   *(int128 *) (c + 736) = xmm6
# asm 1: movdqa <xmm6=int6464#7,736(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,736(<c=%rcx)
movdqa %xmm6,736(%rcx)

# qhasm:   *(int128 *) (c + 752) = xmm7
# asm 1: movdqa <xmm7=int6464#8,752(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,752(<c=%rcx)
movdqa %xmm7,752(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 32
# asm 1: xor  $32,<e=int64#9d
# asm 2: xor  $32,<e=%r11d
xor  $32,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 768) = xmm0
# asm 1: movdqa <xmm0=int6464#1,768(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,768(<c=%rcx)
movdqa %xmm0,768(%rcx)

# qhasm:   *(int128 *) (c + 784) = xmm1
# asm 1: movdqa <xmm1=int6464#2,784(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,784(<c=%rcx)
movdqa %xmm1,784(%rcx)

# qhasm:   *(int128 *) (c + 800) = xmm2
# asm 1: movdqa <xmm2=int6464#3,800(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,800(<c=%rcx)
movdqa %xmm2,800(%rcx)

# qhasm:   *(int128 *) (c + 816) = xmm3
# asm 1: movdqa <xmm3=int6464#4,816(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,816(<c=%rcx)
movdqa %xmm3,816(%rcx)

# qhasm:   *(int128 *) (c + 832) = xmm4
# asm 1: movdqa <xmm4=int6464#5,832(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,832(<c=%rcx)
movdqa %xmm4,832(%rcx)

# qhasm:   *(int128 *) (c + 848) = xmm5
# asm 1: movdqa <xmm5=int6464#6,848(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,848(<c=%rcx)
movdqa %xmm5,848(%rcx)

# qhasm:   *(int128 *) (c + 864) = xmm6
# asm 1: movdqa <xmm6=int6464#7,864(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,864(<c=%rcx)
movdqa %xmm6,864(%rcx)

# qhasm:   *(int128 *) (c + 880) = xmm7
# asm 1: movdqa <xmm7=int6464#8,880(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,880(<c=%rcx)
movdqa %xmm7,880(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 64
# asm 1: xor  $64,<e=int64#9d
# asm 2: xor  $64,<e=%r11d
xor  $64,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 896) = xmm0
# asm 1: movdqa <xmm0=int6464#1,896(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,896(<c=%rcx)
movdqa %xmm0,896(%rcx)

# qhasm:   *(int128 *) (c + 912) = xmm1
# asm 1: movdqa <xmm1=int6464#2,912(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,912(<c=%rcx)
movdqa %xmm1,912(%rcx)

# qhasm:   *(int128 *) (c + 928) = xmm2
# asm 1: movdqa <xmm2=int6464#3,928(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,928(<c=%rcx)
movdqa %xmm2,928(%rcx)

# qhasm:   *(int128 *) (c + 944) = xmm3
# asm 1: movdqa <xmm3=int6464#4,944(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,944(<c=%rcx)
movdqa %xmm3,944(%rcx)

# qhasm:   *(int128 *) (c + 960) = xmm4
# asm 1: movdqa <xmm4=int6464#5,960(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,960(<c=%rcx)
movdqa %xmm4,960(%rcx)

# qhasm:   *(int128 *) (c + 976) = xmm5
# asm 1: movdqa <xmm5=int6464#6,976(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,976(<c=%rcx)
movdqa %xmm5,976(%rcx)

# qhasm:   *(int128 *) (c + 992) = xmm6
# asm 1: movdqa <xmm6=int6464#7,992(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,992(<c=%rcx)
movdqa %xmm6,992(%rcx)

# qhasm:   *(int128 *) (c + 1008) = xmm7
# asm 1: movdqa <xmm7=int6464#8,1008(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,1008(<c=%rcx)
movdqa %xmm7,1008(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 128
# asm 1: xor  $128,<e=int64#9d
# asm 2: xor  $128,<e=%r11d
xor  $128,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 1024) = xmm0
# asm 1: movdqa <xmm0=int6464#1,1024(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,1024(<c=%rcx)
movdqa %xmm0,1024(%rcx)

# qhasm:   *(int128 *) (c + 1040) = xmm1
# asm 1: movdqa <xmm1=int6464#2,1040(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,1040(<c=%rcx)
movdqa %xmm1,1040(%rcx)

# qhasm:   *(int128 *) (c + 1056) = xmm2
# asm 1: movdqa <xmm2=int6464#3,1056(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,1056(<c=%rcx)
movdqa %xmm2,1056(%rcx)

# qhasm:   *(int128 *) (c + 1072) = xmm3
# asm 1: movdqa <xmm3=int6464#4,1072(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,1072(<c=%rcx)
movdqa %xmm3,1072(%rcx)

# qhasm:   *(int128 *) (c + 1088) = xmm4
# asm 1: movdqa <xmm4=int6464#5,1088(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,1088(<c=%rcx)
movdqa %xmm4,1088(%rcx)

# qhasm:   *(int128 *) (c + 1104) = xmm5
# asm 1: movdqa <xmm5=int6464#6,1104(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,1104(<c=%rcx)
movdqa %xmm5,1104(%rcx)

# qhasm:   *(int128 *) (c + 1120) = xmm6
# asm 1: movdqa <xmm6=int6464#7,1120(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,1120(<c=%rcx)
movdqa %xmm6,1120(%rcx)

# qhasm:   *(int128 *) (c + 1136) = xmm7
# asm 1: movdqa <xmm7=int6464#8,1136(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,1136(<c=%rcx)
movdqa %xmm7,1136(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 27
# asm 1: xor  $27,<e=int64#9d
# asm 2: xor  $27,<e=%r11d
xor  $27,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 1152) = xmm0
# asm 1: movdqa <xmm0=int6464#1,1152(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,1152(<c=%rcx)
movdqa %xmm0,1152(%rcx)

# qhasm:   *(int128 *) (c + 1168) = xmm1
# asm 1: movdqa <xmm1=int6464#2,1168(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,1168(<c=%rcx)
movdqa %xmm1,1168(%rcx)

# qhasm:   *(int128 *) (c + 1184) = xmm2
# asm 1: movdqa <xmm2=int6464#3,1184(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,1184(<c=%rcx)
movdqa %xmm2,1184(%rcx)

# qhasm:   *(int128 *) (c + 1200) = xmm3
# asm 1: movdqa <xmm3=int6464#4,1200(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,1200(<c=%rcx)
movdqa %xmm3,1200(%rcx)

# qhasm:   *(int128 *) (c + 1216) = xmm4
# asm 1: movdqa <xmm4=int6464#5,1216(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,1216(<c=%rcx)
movdqa %xmm4,1216(%rcx)

# qhasm:   *(int128 *) (c + 1232) = xmm5
# asm 1: movdqa <xmm5=int6464#6,1232(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,1232(<c=%rcx)
movdqa %xmm5,1232(%rcx)

# qhasm:   *(int128 *) (c + 1248) = xmm6
# asm 1: movdqa <xmm6=int6464#7,1248(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,1248(<c=%rcx)
movdqa %xmm6,1248(%rcx)

# qhasm:   *(int128 *) (c + 1264) = xmm7
# asm 1: movdqa <xmm7=int6464#8,1264(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,1264(<c=%rcx)
movdqa %xmm7,1264(%rcx)

# qhasm:   e = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>e=int64#1d
# asm 2: movzbl  <x3=%dh,>e=%edi
movzbl  %dh,%edi

# qhasm:   e = *(uint8 *) (sboxp + e)
# asm 1: movzbq (<sboxp=int64#2,<e=int64#1),>e=int64#9
# asm 2: movzbq (<sboxp=%rsi,<e=%rdi),>e=%r11
movzbq (%rsi,%rdi),%r11

# qhasm:   (uint32) e ^= 54
# asm 1: xor  $54,<e=int64#9d
# asm 2: xor  $54,<e=%r11d
xor  $54,%r11d

# qhasm:   q3 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q3=int64#1d
# asm 2: movzbl  <x3=%dl,>q3=%edi
movzbl  %dl,%edi

# qhasm:   q3 = *(uint8 *) (sboxp + q3)
# asm 1: movzbq (<sboxp=int64#2,<q3=int64#1),>q3=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q3=%rdi),>q3=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q3 <<= 24
# asm 1: shl  $24,<q3=int64#1
# asm 2: shl  $24,<q3=%rdi
shl  $24,%rdi

# qhasm:   e ^= q3
# asm 1: xor  <q3=int64#1,<e=int64#9
# asm 2: xor  <q3=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q2 = (x3 >> 8) & 255
# asm 1: movzbl  <x3=int64#3%next8,>q2=int64#1d
# asm 2: movzbl  <x3=%dh,>q2=%edi
movzbl  %dh,%edi

# qhasm:   q2 = *(uint8 *) (sboxp + q2)
# asm 1: movzbq (<sboxp=int64#2,<q2=int64#1),>q2=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q2=%rdi),>q2=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q2 <<= 16
# asm 1: shl  $16,<q2=int64#1
# asm 2: shl  $16,<q2=%rdi
shl  $16,%rdi

# qhasm:   e ^= q2
# asm 1: xor  <q2=int64#1,<e=int64#9
# asm 2: xor  <q2=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   q1 = x3 & 255
# asm 1: movzbl  <x3=int64#3b,>q1=int64#1d
# asm 2: movzbl  <x3=%dl,>q1=%edi
movzbl  %dl,%edi

# qhasm:   (uint32) x3 <<<= 16
# asm 1: rol  $16,<x3=int64#3d
# asm 2: rol  $16,<x3=%edx
rol  $16,%edx

# qhasm:   q1 = *(uint8 *) (sboxp + q1)
# asm 1: movzbq (<sboxp=int64#2,<q1=int64#1),>q1=int64#1
# asm 2: movzbq (<sboxp=%rsi,<q1=%rdi),>q1=%rdi
movzbq (%rsi,%rdi),%rdi

# qhasm:   q1 <<= 8
# asm 1: shl  $8,<q1=int64#1
# asm 2: shl  $8,<q1=%rdi
shl  $8,%rdi

# qhasm:   e ^= q1
# asm 1: xor  <q1=int64#1,<e=int64#9
# asm 2: xor  <q1=%rdi,<e=%r11
xor  %rdi,%r11

# qhasm:   x0 ^= e
# asm 1: xor  <e=int64#9,<x0=int64#6
# asm 2: xor  <e=%r11,<x0=%r9
xor  %r11,%r9

# qhasm:   *(uint32 *) (keyp + 0) = x0
# asm 1: movl   <x0=int64#6d,0(<keyp=int64#5)
# asm 2: movl   <x0=%r9d,0(<keyp=%r8)
movl   %r9d,0(%r8)

# qhasm:   x1 ^= x0
# asm 1: xor  <x0=int64#6,<x1=int64#7
# asm 2: xor  <x0=%r9,<x1=%rax
xor  %r9,%rax

# qhasm:   *(uint32 *) (keyp + 4) = x1
# asm 1: movl   <x1=int64#7d,4(<keyp=int64#5)
# asm 2: movl   <x1=%eax,4(<keyp=%r8)
movl   %eax,4(%r8)

# qhasm:   x2 ^= x1
# asm 1: xor  <x1=int64#7,<x2=int64#8
# asm 2: xor  <x1=%rax,<x2=%r10
xor  %rax,%r10

# qhasm:   *(uint32 *) (keyp + 8) = x2
# asm 1: movl   <x2=int64#8d,8(<keyp=int64#5)
# asm 2: movl   <x2=%r10d,8(<keyp=%r8)
movl   %r10d,8(%r8)

# qhasm:   x3 ^= x2
# asm 1: xor  <x2=int64#8,<x3=int64#3
# asm 2: xor  <x2=%r10,<x3=%rdx
xor  %r10,%rdx

# qhasm:   *(uint32 *) (keyp + 12) = x3
# asm 1: movl   <x3=int64#3d,12(<keyp=int64#5)
# asm 2: movl   <x3=%edx,12(<keyp=%r8)
movl   %edx,12(%r8)

# qhasm:   xmm0 = *(int128 *) (keyp + 0)
# asm 1: movdqa 0(<keyp=int64#5),>xmm0=int6464#1
# asm 2: movdqa 0(<keyp=%r8),>xmm0=%xmm0
movdqa 0(%r8),%xmm0

# qhasm:   xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm:   xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm:   xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm:   xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm:   xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm:   xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm:   xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       t = xmm6
# asm 1: movdqa <xmm6=int6464#7,>t=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>t=%xmm8
movdqa %xmm6,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 1
# asm 1: psrlq $1,<t=int6464#9
# asm 2: psrlq $1,<t=%xmm8
psrlq $1,%xmm8

# qhasm:       t ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<t=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<t=%xmm8
pxor  %xmm1,%xmm8

# qhasm:       t &= BS0
# asm 1: pand  BS0,<t=int6464#9
# asm 2: pand  BS0,<t=%xmm8
pand  BS0,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       uint6464 t <<= 1
# asm 1: psllq $1,<t=int6464#9
# asm 2: psllq $1,<t=%xmm8
psllq $1,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm5
# asm 1: movdqa <xmm5=int6464#6,>t=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>t=%xmm8
movdqa %xmm5,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       t = xmm4
# asm 1: movdqa <xmm4=int6464#5,>t=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>t=%xmm8
movdqa %xmm4,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<t=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<t=%xmm8
pxor  %xmm3,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 2
# asm 1: psrlq $2,<t=int6464#9
# asm 2: psrlq $2,<t=%xmm8
psrlq $2,%xmm8

# qhasm:       t ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<t=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<t=%xmm8
pxor  %xmm2,%xmm8

# qhasm:       t &= BS1
# asm 1: pand  BS1,<t=int6464#9
# asm 2: pand  BS1,<t=%xmm8
pand  BS1,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       uint6464 t <<= 2
# asm 1: psllq $2,<t=int6464#9
# asm 2: psllq $2,<t=%xmm8
psllq $2,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:       t = xmm3
# asm 1: movdqa <xmm3=int6464#4,>t=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>t=%xmm8
movdqa %xmm3,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<t=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<t=%xmm8
pxor  %xmm7,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm7 ^= t
# asm 1: pxor  <t=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <t=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm3 ^= t
# asm 1: pxor  <t=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <t=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:       t = xmm2
# asm 1: movdqa <xmm2=int6464#3,>t=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>t=%xmm8
movdqa %xmm2,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<t=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<t=%xmm8
pxor  %xmm6,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm6 ^= t
# asm 1: pxor  <t=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <t=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm2 ^= t
# asm 1: pxor  <t=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <t=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       t = xmm1
# asm 1: movdqa <xmm1=int6464#2,>t=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>t=%xmm8
movdqa %xmm1,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<t=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<t=%xmm8
pxor  %xmm5,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm5 ^= t
# asm 1: pxor  <t=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <t=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm1 ^= t
# asm 1: pxor  <t=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <t=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:       t = xmm0
# asm 1: movdqa <xmm0=int6464#1,>t=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>t=%xmm8
movdqa %xmm0,%xmm8

# qhasm:       uint6464 t >>= 4
# asm 1: psrlq $4,<t=int6464#9
# asm 2: psrlq $4,<t=%xmm8
psrlq $4,%xmm8

# qhasm:       t ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<t=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<t=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       t &= BS2
# asm 1: pand  BS2,<t=int6464#9
# asm 2: pand  BS2,<t=%xmm8
pand  BS2,%xmm8

# qhasm:       xmm4 ^= t
# asm 1: pxor  <t=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <t=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       uint6464 t <<= 4
# asm 1: psllq $4,<t=int6464#9
# asm 2: psllq $4,<t=%xmm8
psllq $4,%xmm8

# qhasm:       xmm0 ^= t
# asm 1: pxor  <t=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <t=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:   xmm6 ^= ONE
# asm 1: pxor  ONE,<xmm6=int6464#7
# asm 2: pxor  ONE,<xmm6=%xmm6
pxor  ONE,%xmm6

# qhasm:   xmm5 ^= ONE
# asm 1: pxor  ONE,<xmm5=int6464#6
# asm 2: pxor  ONE,<xmm5=%xmm5
pxor  ONE,%xmm5

# qhasm:   xmm1 ^= ONE
# asm 1: pxor  ONE,<xmm1=int6464#2
# asm 2: pxor  ONE,<xmm1=%xmm1
pxor  ONE,%xmm1

# qhasm:   xmm0 ^= ONE
# asm 1: pxor  ONE,<xmm0=int6464#1
# asm 2: pxor  ONE,<xmm0=%xmm0
pxor  ONE,%xmm0

# qhasm:   *(int128 *) (c + 1280) = xmm0
# asm 1: movdqa <xmm0=int6464#1,1280(<c=int64#4)
# asm 2: movdqa <xmm0=%xmm0,1280(<c=%rcx)
movdqa %xmm0,1280(%rcx)

# qhasm:   *(int128 *) (c + 1296) = xmm1
# asm 1: movdqa <xmm1=int6464#2,1296(<c=int64#4)
# asm 2: movdqa <xmm1=%xmm1,1296(<c=%rcx)
movdqa %xmm1,1296(%rcx)

# qhasm:   *(int128 *) (c + 1312) = xmm2
# asm 1: movdqa <xmm2=int6464#3,1312(<c=int64#4)
# asm 2: movdqa <xmm2=%xmm2,1312(<c=%rcx)
movdqa %xmm2,1312(%rcx)

# qhasm:   *(int128 *) (c + 1328) = xmm3
# asm 1: movdqa <xmm3=int6464#4,1328(<c=int64#4)
# asm 2: movdqa <xmm3=%xmm3,1328(<c=%rcx)
movdqa %xmm3,1328(%rcx)

# qhasm:   *(int128 *) (c + 1344) = xmm4
# asm 1: movdqa <xmm4=int6464#5,1344(<c=int64#4)
# asm 2: movdqa <xmm4=%xmm4,1344(<c=%rcx)
movdqa %xmm4,1344(%rcx)

# qhasm:   *(int128 *) (c + 1360) = xmm5
# asm 1: movdqa <xmm5=int6464#6,1360(<c=int64#4)
# asm 2: movdqa <xmm5=%xmm5,1360(<c=%rcx)
movdqa %xmm5,1360(%rcx)

# qhasm:   *(int128 *) (c + 1376) = xmm6
# asm 1: movdqa <xmm6=int6464#7,1376(<c=int64#4)
# asm 2: movdqa <xmm6=%xmm6,1376(<c=%rcx)
movdqa %xmm6,1376(%rcx)

# qhasm:   *(int128 *) (c + 1392) = xmm7
# asm 1: movdqa <xmm7=int6464#8,1392(<c=int64#4)
# asm 2: movdqa <xmm7=%xmm7,1392(<c=%rcx)
movdqa %xmm7,1392(%rcx)

# qhasm: r11_caller = r11_caller_stack
# asm 1: movq <r11_caller_stack=stack64#1,>r11_caller=int64#9
# asm 2: movq <r11_caller_stack=32(%rsp),>r11_caller=%r11
movq 32(%rsp),%r11

# qhasm: leave
add %r11,%rsp
mov %rdi,%rax
mov %rsi,%rdx
ret
