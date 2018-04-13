
# qhasm: int64 action

# qhasm: int64 c

# qhasm: int64 inp

# qhasm: int64 outp

# qhasm: int64 len

# qhasm: input action

# qhasm: input c

# qhasm: input inp

# qhasm: input outp

# qhasm: input len

# qhasm: int64 lensav

# qhasm: int6464 xmm0

# qhasm: int6464 xmm1

# qhasm: int6464 xmm2

# qhasm: int6464 xmm3

# qhasm: int6464 xmm4

# qhasm: int6464 xmm5

# qhasm: int6464 xmm6

# qhasm: int6464 xmm7

# qhasm: int6464 xmm8

# qhasm: int6464 xmm9

# qhasm: int6464 xmm10

# qhasm: int6464 xmm11

# qhasm: int6464 xmm12

# qhasm: int6464 xmm13

# qhasm: int6464 xmm14

# qhasm: int6464 xmm15

# qhasm: int6464 t

# qhasm: stack1024 bl

# qhasm: int64 blp

# qhasm: int64 b

# qhasm: enter ECRYPT_process_bytes
.text
.p2align 5
.globl _ECRYPT_process_bytes
.globl ECRYPT_process_bytes
_ECRYPT_process_bytes:
ECRYPT_process_bytes:
mov %rsp,%r11
and $31,%r11
add $128,%r11
sub %r11,%rsp

# qhasm: unsigned>? len-0
# asm 1: cmp  $0,<len=int64#5
# asm 2: cmp  $0,<len=%r8
cmp  $0,%r8
# comment:fp stack unchanged by jump

# qhasm: goto enc_block if unsigned>
ja ._enc_block
# comment:fp stack unchanged by fallthrough

# qhasm: enc_block:
._enc_block:

# qhasm: xmm0 = *(int128 *) (c + 1408)
# asm 1: movdqa 1408(<c=int64#2),>xmm0=int6464#1
# asm 2: movdqa 1408(<c=%rsi),>xmm0=%xmm0
movdqa 1408(%rsi),%xmm0

# qhasm: xmm1 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm1=int6464#2
# asm 2: movdqa <xmm0=%xmm0,>xmm1=%xmm1
movdqa %xmm0,%xmm1

# qhasm: xmm2 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm2=int6464#3
# asm 2: movdqa <xmm0=%xmm0,>xmm2=%xmm2
movdqa %xmm0,%xmm2

# qhasm: xmm3 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm3=int6464#4
# asm 2: movdqa <xmm0=%xmm0,>xmm3=%xmm3
movdqa %xmm0,%xmm3

# qhasm: xmm4 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm4=int6464#5
# asm 2: movdqa <xmm0=%xmm0,>xmm4=%xmm4
movdqa %xmm0,%xmm4

# qhasm: xmm5 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm5=int6464#6
# asm 2: movdqa <xmm0=%xmm0,>xmm5=%xmm5
movdqa %xmm0,%xmm5

# qhasm: xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm6=int6464#7
# asm 2: movdqa <xmm0=%xmm0,>xmm6=%xmm6
movdqa %xmm0,%xmm6

# qhasm: xmm7 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm0=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm: int32323232 xmm1 += CTRINC1
# asm 1: paddd  CTRINC1,<xmm1=int6464#2
# asm 2: paddd  CTRINC1,<xmm1=%xmm1
paddd  CTRINC1,%xmm1

# qhasm: int32323232 xmm2 += CTRINC2
# asm 1: paddd  CTRINC2,<xmm2=int6464#3
# asm 2: paddd  CTRINC2,<xmm2=%xmm2
paddd  CTRINC2,%xmm2

# qhasm: int32323232 xmm3 += CTRINC3
# asm 1: paddd  CTRINC3,<xmm3=int6464#4
# asm 2: paddd  CTRINC3,<xmm3=%xmm3
paddd  CTRINC3,%xmm3

# qhasm: int32323232 xmm4 += CTRINC4
# asm 1: paddd  CTRINC4,<xmm4=int6464#5
# asm 2: paddd  CTRINC4,<xmm4=%xmm4
paddd  CTRINC4,%xmm4

# qhasm: int32323232 xmm5 += CTRINC5
# asm 1: paddd  CTRINC5,<xmm5=int6464#6
# asm 2: paddd  CTRINC5,<xmm5=%xmm5
paddd  CTRINC5,%xmm5

# qhasm: int32323232 xmm6 += CTRINC6
# asm 1: paddd  CTRINC6,<xmm6=int6464#7
# asm 2: paddd  CTRINC6,<xmm6=%xmm6
paddd  CTRINC6,%xmm6

# qhasm: int32323232 xmm7 += CTRINC7
# asm 1: paddd  CTRINC7,<xmm7=int6464#8
# asm 2: paddd  CTRINC7,<xmm7=%xmm7
paddd  CTRINC7,%xmm7

# qhasm: shuffle bytes of xmm0 by M0
# asm 1: pshufb M0,<xmm0=int6464#1
# asm 2: pshufb M0,<xmm0=%xmm0
pshufb M0,%xmm0

# qhasm: shuffle bytes of xmm1 by M0
# asm 1: pshufb M0,<xmm1=int6464#2
# asm 2: pshufb M0,<xmm1=%xmm1
pshufb M0,%xmm1

# qhasm: shuffle bytes of xmm2 by M0
# asm 1: pshufb M0,<xmm2=int6464#3
# asm 2: pshufb M0,<xmm2=%xmm2
pshufb M0,%xmm2

# qhasm: shuffle bytes of xmm3 by M0
# asm 1: pshufb M0,<xmm3=int6464#4
# asm 2: pshufb M0,<xmm3=%xmm3
pshufb M0,%xmm3

# qhasm: shuffle bytes of xmm4 by M0
# asm 1: pshufb M0,<xmm4=int6464#5
# asm 2: pshufb M0,<xmm4=%xmm4
pshufb M0,%xmm4

# qhasm: shuffle bytes of xmm5 by M0
# asm 1: pshufb M0,<xmm5=int6464#6
# asm 2: pshufb M0,<xmm5=%xmm5
pshufb M0,%xmm5

# qhasm: shuffle bytes of xmm6 by M0
# asm 1: pshufb M0,<xmm6=int6464#7
# asm 2: pshufb M0,<xmm6=%xmm6
pshufb M0,%xmm6

# qhasm: shuffle bytes of xmm7 by M0
# asm 1: pshufb M0,<xmm7=int6464#8
# asm 2: pshufb M0,<xmm7=%xmm7
pshufb M0,%xmm7

# qhasm:     xmm8 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm8=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm8=%xmm8
movdqa %xmm6,%xmm8

# qhasm:     uint6464 xmm8 >>= 1
# asm 1: psrlq $1,<xmm8=int6464#9
# asm 2: psrlq $1,<xmm8=%xmm8
psrlq $1,%xmm8

# qhasm:     xmm8 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm8=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<xmm8=%xmm8
pxor  %xmm7,%xmm8

# qhasm:     xmm8 &= BS0
# asm 1: pand  BS0,<xmm8=int6464#9
# asm 2: pand  BS0,<xmm8=%xmm8
pand  BS0,%xmm8

# qhasm:     xmm7 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm8=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:     uint6464 xmm8 <<= 1
# asm 1: psllq $1,<xmm8=int6464#9
# asm 2: psllq $1,<xmm8=%xmm8
psllq $1,%xmm8

# qhasm:     xmm6 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm8=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:     xmm8 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm8=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>xmm8=%xmm8
movdqa %xmm4,%xmm8

# qhasm:     uint6464 xmm8 >>= 1
# asm 1: psrlq $1,<xmm8=int6464#9
# asm 2: psrlq $1,<xmm8=%xmm8
psrlq $1,%xmm8

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm8 &= BS0
# asm 1: pand  BS0,<xmm8=int6464#9
# asm 2: pand  BS0,<xmm8=%xmm8
pand  BS0,%xmm8

# qhasm:     xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:     uint6464 xmm8 <<= 1
# asm 1: psllq $1,<xmm8=int6464#9
# asm 2: psllq $1,<xmm8=%xmm8
psllq $1,%xmm8

# qhasm:     xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:     xmm8 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm8=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>xmm8=%xmm8
movdqa %xmm2,%xmm8

# qhasm:     uint6464 xmm8 >>= 1
# asm 1: psrlq $1,<xmm8=int6464#9
# asm 2: psrlq $1,<xmm8=%xmm8
psrlq $1,%xmm8

# qhasm:     xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm8
pxor  %xmm3,%xmm8

# qhasm:     xmm8 &= BS0
# asm 1: pand  BS0,<xmm8=int6464#9
# asm 2: pand  BS0,<xmm8=%xmm8
pand  BS0,%xmm8

# qhasm:     xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:     uint6464 xmm8 <<= 1
# asm 1: psllq $1,<xmm8=int6464#9
# asm 2: psllq $1,<xmm8=%xmm8
psllq $1,%xmm8

# qhasm:     xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:     xmm8 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm8=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>xmm8=%xmm8
movdqa %xmm0,%xmm8

# qhasm:     uint6464 xmm8 >>= 1
# asm 1: psrlq $1,<xmm8=int6464#9
# asm 2: psrlq $1,<xmm8=%xmm8
psrlq $1,%xmm8

# qhasm:     xmm8 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm8=int6464#9
# asm 2: pxor  <xmm1=%xmm1,<xmm8=%xmm8
pxor  %xmm1,%xmm8

# qhasm:     xmm8 &= BS0
# asm 1: pand  BS0,<xmm8=int6464#9
# asm 2: pand  BS0,<xmm8=%xmm8
pand  BS0,%xmm8

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     uint6464 xmm8 <<= 1
# asm 1: psllq $1,<xmm8=int6464#9
# asm 2: psllq $1,<xmm8=%xmm8
psllq $1,%xmm8

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#9
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm8
movdqa %xmm5,%xmm8

# qhasm:     uint6464 xmm8 >>= 2
# asm 1: psrlq $2,<xmm8=int6464#9
# asm 2: psrlq $2,<xmm8=%xmm8
psrlq $2,%xmm8

# qhasm:     xmm8 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm8=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<xmm8=%xmm8
pxor  %xmm7,%xmm8

# qhasm:     xmm8 &= BS1
# asm 1: pand  BS1,<xmm8=int6464#9
# asm 2: pand  BS1,<xmm8=%xmm8
pand  BS1,%xmm8

# qhasm:     xmm7 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm8=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:     uint6464 xmm8 <<= 2
# asm 1: psllq $2,<xmm8=int6464#9
# asm 2: psllq $2,<xmm8=%xmm8
psllq $2,%xmm8

# qhasm:     xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:     xmm8 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm8=int6464#9
# asm 2: movdqa <xmm4=%xmm4,>xmm8=%xmm8
movdqa %xmm4,%xmm8

# qhasm:     uint6464 xmm8 >>= 2
# asm 1: psrlq $2,<xmm8=int6464#9
# asm 2: psrlq $2,<xmm8=%xmm8
psrlq $2,%xmm8

# qhasm:     xmm8 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm8=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<xmm8=%xmm8
pxor  %xmm6,%xmm8

# qhasm:     xmm8 &= BS1
# asm 1: pand  BS1,<xmm8=int6464#9
# asm 2: pand  BS1,<xmm8=%xmm8
pand  BS1,%xmm8

# qhasm:     xmm6 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm8=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:     uint6464 xmm8 <<= 2
# asm 1: psllq $2,<xmm8=int6464#9
# asm 2: psllq $2,<xmm8=%xmm8
psllq $2,%xmm8

# qhasm:     xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:     xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm8
movdqa %xmm1,%xmm8

# qhasm:     uint6464 xmm8 >>= 2
# asm 1: psrlq $2,<xmm8=int6464#9
# asm 2: psrlq $2,<xmm8=%xmm8
psrlq $2,%xmm8

# qhasm:     xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#9
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm8
pxor  %xmm3,%xmm8

# qhasm:     xmm8 &= BS1
# asm 1: pand  BS1,<xmm8=int6464#9
# asm 2: pand  BS1,<xmm8=%xmm8
pand  BS1,%xmm8

# qhasm:     xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:     uint6464 xmm8 <<= 2
# asm 1: psllq $2,<xmm8=int6464#9
# asm 2: psllq $2,<xmm8=%xmm8
psllq $2,%xmm8

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm8 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm8=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>xmm8=%xmm8
movdqa %xmm0,%xmm8

# qhasm:     uint6464 xmm8 >>= 2
# asm 1: psrlq $2,<xmm8=int6464#9
# asm 2: psrlq $2,<xmm8=%xmm8
psrlq $2,%xmm8

# qhasm:     xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#9
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm8
pxor  %xmm2,%xmm8

# qhasm:     xmm8 &= BS1
# asm 1: pand  BS1,<xmm8=int6464#9
# asm 2: pand  BS1,<xmm8=%xmm8
pand  BS1,%xmm8

# qhasm:     xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:     uint6464 xmm8 <<= 2
# asm 1: psllq $2,<xmm8=int6464#9
# asm 2: psllq $2,<xmm8=%xmm8
psllq $2,%xmm8

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm8 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm8=int6464#9
# asm 2: movdqa <xmm3=%xmm3,>xmm8=%xmm8
movdqa %xmm3,%xmm8

# qhasm:     uint6464 xmm8 >>= 4
# asm 1: psrlq $4,<xmm8=int6464#9
# asm 2: psrlq $4,<xmm8=%xmm8
psrlq $4,%xmm8

# qhasm:     xmm8 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm8=int6464#9
# asm 2: pxor  <xmm7=%xmm7,<xmm8=%xmm8
pxor  %xmm7,%xmm8

# qhasm:     xmm8 &= BS2
# asm 1: pand  BS2,<xmm8=int6464#9
# asm 2: pand  BS2,<xmm8=%xmm8
pand  BS2,%xmm8

# qhasm:     xmm7 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm8=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:     uint6464 xmm8 <<= 4
# asm 1: psllq $4,<xmm8=int6464#9
# asm 2: psllq $4,<xmm8=%xmm8
psllq $4,%xmm8

# qhasm:     xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm8,<xmm3=%xmm3
pxor  %xmm8,%xmm3

# qhasm:     xmm8 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm8=int6464#9
# asm 2: movdqa <xmm2=%xmm2,>xmm8=%xmm8
movdqa %xmm2,%xmm8

# qhasm:     uint6464 xmm8 >>= 4
# asm 1: psrlq $4,<xmm8=int6464#9
# asm 2: psrlq $4,<xmm8=%xmm8
psrlq $4,%xmm8

# qhasm:     xmm8 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm8=int6464#9
# asm 2: pxor  <xmm6=%xmm6,<xmm8=%xmm8
pxor  %xmm6,%xmm8

# qhasm:     xmm8 &= BS2
# asm 1: pand  BS2,<xmm8=int6464#9
# asm 2: pand  BS2,<xmm8=%xmm8
pand  BS2,%xmm8

# qhasm:     xmm6 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm8=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:     uint6464 xmm8 <<= 4
# asm 1: psllq $4,<xmm8=int6464#9
# asm 2: psllq $4,<xmm8=%xmm8
psllq $4,%xmm8

# qhasm:     xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm2=%xmm2
pxor  %xmm8,%xmm2

# qhasm:     xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#9
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm8
movdqa %xmm1,%xmm8

# qhasm:     uint6464 xmm8 >>= 4
# asm 1: psrlq $4,<xmm8=int6464#9
# asm 2: psrlq $4,<xmm8=%xmm8
psrlq $4,%xmm8

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm8 &= BS2
# asm 1: pand  BS2,<xmm8=int6464#9
# asm 2: pand  BS2,<xmm8=%xmm8
pand  BS2,%xmm8

# qhasm:     xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm8,<xmm5=%xmm5
pxor  %xmm8,%xmm5

# qhasm:     uint6464 xmm8 <<= 4
# asm 1: psllq $4,<xmm8=int6464#9
# asm 2: psllq $4,<xmm8=%xmm8
psllq $4,%xmm8

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm8 = xmm0
# asm 1: movdqa <xmm0=int6464#1,>xmm8=int6464#9
# asm 2: movdqa <xmm0=%xmm0,>xmm8=%xmm8
movdqa %xmm0,%xmm8

# qhasm:     uint6464 xmm8 >>= 4
# asm 1: psrlq $4,<xmm8=int6464#9
# asm 2: psrlq $4,<xmm8=%xmm8
psrlq $4,%xmm8

# qhasm:     xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm8=%xmm8
pxor  %xmm4,%xmm8

# qhasm:     xmm8 &= BS2
# asm 1: pand  BS2,<xmm8=int6464#9
# asm 2: pand  BS2,<xmm8=%xmm8
pand  BS2,%xmm8

# qhasm:     xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:     uint6464 xmm8 <<= 4
# asm 1: psllq $4,<xmm8=int6464#9
# asm 2: psllq $4,<xmm8=%xmm8
psllq $4,%xmm8

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm0 ^= *(int128 *)(c + 0)
# asm 1: pxor 0(<c=int64#2),<xmm0=int6464#1
# asm 2: pxor 0(<c=%rsi),<xmm0=%xmm0
pxor 0(%rsi),%xmm0

# qhasm:     shuffle bytes of xmm0 by SR
# asm 1: pshufb SR,<xmm0=int6464#1
# asm 2: pshufb SR,<xmm0=%xmm0
pshufb SR,%xmm0

# qhasm:     xmm1 ^= *(int128 *)(c + 16)
# asm 1: pxor 16(<c=int64#2),<xmm1=int6464#2
# asm 2: pxor 16(<c=%rsi),<xmm1=%xmm1
pxor 16(%rsi),%xmm1

# qhasm:     shuffle bytes of xmm1 by SR
# asm 1: pshufb SR,<xmm1=int6464#2
# asm 2: pshufb SR,<xmm1=%xmm1
pshufb SR,%xmm1

# qhasm:     xmm2 ^= *(int128 *)(c + 32)
# asm 1: pxor 32(<c=int64#2),<xmm2=int6464#3
# asm 2: pxor 32(<c=%rsi),<xmm2=%xmm2
pxor 32(%rsi),%xmm2

# qhasm:     shuffle bytes of xmm2 by SR
# asm 1: pshufb SR,<xmm2=int6464#3
# asm 2: pshufb SR,<xmm2=%xmm2
pshufb SR,%xmm2

# qhasm:     xmm3 ^= *(int128 *)(c + 48)
# asm 1: pxor 48(<c=int64#2),<xmm3=int6464#4
# asm 2: pxor 48(<c=%rsi),<xmm3=%xmm3
pxor 48(%rsi),%xmm3

# qhasm:     shuffle bytes of xmm3 by SR
# asm 1: pshufb SR,<xmm3=int6464#4
# asm 2: pshufb SR,<xmm3=%xmm3
pshufb SR,%xmm3

# qhasm:     xmm4 ^= *(int128 *)(c + 64)
# asm 1: pxor 64(<c=int64#2),<xmm4=int6464#5
# asm 2: pxor 64(<c=%rsi),<xmm4=%xmm4
pxor 64(%rsi),%xmm4

# qhasm:     shuffle bytes of xmm4 by SR
# asm 1: pshufb SR,<xmm4=int6464#5
# asm 2: pshufb SR,<xmm4=%xmm4
pshufb SR,%xmm4

# qhasm:     xmm5 ^= *(int128 *)(c + 80)
# asm 1: pxor 80(<c=int64#2),<xmm5=int6464#6
# asm 2: pxor 80(<c=%rsi),<xmm5=%xmm5
pxor 80(%rsi),%xmm5

# qhasm:     shuffle bytes of xmm5 by SR
# asm 1: pshufb SR,<xmm5=int6464#6
# asm 2: pshufb SR,<xmm5=%xmm5
pshufb SR,%xmm5

# qhasm:     xmm6 ^= *(int128 *)(c + 96)
# asm 1: pxor 96(<c=int64#2),<xmm6=int6464#7
# asm 2: pxor 96(<c=%rsi),<xmm6=%xmm6
pxor 96(%rsi),%xmm6

# qhasm:     shuffle bytes of xmm6 by SR
# asm 1: pshufb SR,<xmm6=int6464#7
# asm 2: pshufb SR,<xmm6=%xmm6
pshufb SR,%xmm6

# qhasm:     xmm7 ^= *(int128 *)(c + 112)
# asm 1: pxor 112(<c=int64#2),<xmm7=int6464#8
# asm 2: pxor 112(<c=%rsi),<xmm7=%xmm7
pxor 112(%rsi),%xmm7

# qhasm:     shuffle bytes of xmm7 by SR
# asm 1: pshufb SR,<xmm7=int6464#8
# asm 2: pshufb SR,<xmm7=%xmm7
pshufb SR,%xmm7

# qhasm:       xmm5 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm5=int6464#6
# asm 2: pxor  <xmm6=%xmm6,<xmm5=%xmm5
pxor  %xmm6,%xmm5

# qhasm:       xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm1,<xmm2=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm5=int6464#6
# asm 2: pxor  <xmm0=%xmm0,<xmm5=%xmm5
pxor  %xmm0,%xmm5

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm6=int6464#7
# asm 2: pxor  <xmm2=%xmm2,<xmm6=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm3=int6464#4
# asm 2: pxor  <xmm0=%xmm0,<xmm3=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#4
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm3
pxor  %xmm7,%xmm3

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm3=int6464#4
# asm 2: pxor  <xmm4=%xmm4,<xmm3=%xmm3
pxor  %xmm4,%xmm3

# qhasm:       xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm7=int6464#8
# asm 2: pxor  <xmm5=%xmm5,<xmm7=%xmm7
pxor  %xmm5,%xmm7

# qhasm:       xmm3 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm3=int6464#4
# asm 2: pxor  <xmm1=%xmm1,<xmm3=%xmm3
pxor  %xmm1,%xmm3

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm2=int6464#3
# asm 2: pxor  <xmm7=%xmm7,<xmm2=%xmm2
pxor  %xmm7,%xmm2

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm11 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm11=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm11=%xmm8
movdqa %xmm7,%xmm8

# qhasm:       xmm10 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm10=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm10=%xmm9
movdqa %xmm1,%xmm9

# qhasm:       xmm9 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm9=int6464#11
# asm 2: movdqa <xmm5=%xmm5,>xmm9=%xmm10
movdqa %xmm5,%xmm10

# qhasm:       xmm13 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm13=int6464#12
# asm 2: movdqa <xmm2=%xmm2,>xmm13=%xmm11
movdqa %xmm2,%xmm11

# qhasm:       xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#13
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm12
movdqa %xmm6,%xmm12

# qhasm:       xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm9
pxor  %xmm2,%xmm9

# qhasm:       xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm9=int6464#11
# asm 2: pxor  <xmm3=%xmm3,<xmm9=%xmm10
pxor  %xmm3,%xmm10

# qhasm:       xmm13 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm13=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm13=%xmm11
pxor  %xmm4,%xmm11

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:       xmm14 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm14=int6464#14
# asm 2: movdqa <xmm11=%xmm8,>xmm14=%xmm13
movdqa %xmm8,%xmm13

# qhasm:       xmm8 = xmm10
# asm 1: movdqa <xmm10=int6464#10,>xmm8=int6464#15
# asm 2: movdqa <xmm10=%xmm9,>xmm8=%xmm14
movdqa %xmm9,%xmm14

# qhasm:       xmm15 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm15=int6464#16
# asm 2: movdqa <xmm11=%xmm8,>xmm15=%xmm15
movdqa %xmm8,%xmm15

# qhasm:       xmm10 |= xmm9
# asm 1: por   <xmm9=int6464#11,<xmm10=int6464#10
# asm 2: por   <xmm9=%xmm10,<xmm10=%xmm9
por   %xmm10,%xmm9

# qhasm:       xmm11 |= xmm12
# asm 1: por   <xmm12=int6464#13,<xmm11=int6464#9
# asm 2: por   <xmm12=%xmm12,<xmm11=%xmm8
por   %xmm12,%xmm8

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm15=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm14 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm14=int6464#14
# asm 2: pand  <xmm12=%xmm12,<xmm14=%xmm13
pand  %xmm12,%xmm13

# qhasm:       xmm8 &= xmm9
# asm 1: pand  <xmm9=int6464#11,<xmm8=int6464#15
# asm 2: pand  <xmm9=%xmm10,<xmm8=%xmm14
pand  %xmm10,%xmm14

# qhasm:       xmm12 ^= xmm9
# asm 1: pxor  <xmm9=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm9=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:       xmm15 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm15=int6464#16
# asm 2: pand  <xmm12=%xmm12,<xmm15=%xmm15
pand  %xmm12,%xmm15

# qhasm:       xmm12 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm12=int6464#11
# asm 2: movdqa <xmm3=%xmm3,>xmm12=%xmm10
movdqa %xmm3,%xmm10

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm10
pxor  %xmm0,%xmm10

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#11,<xmm13=int6464#12
# asm 2: pand  <xmm12=%xmm10,<xmm13=%xmm11
pand  %xmm10,%xmm11

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm11=int6464#9
# asm 2: pxor  <xmm13=%xmm11,<xmm11=%xmm8
pxor  %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm13 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm13=int6464#11
# asm 2: movdqa <xmm7=%xmm7,>xmm13=%xmm10
movdqa %xmm7,%xmm10

# qhasm:       xmm13 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm13=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm13=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm12 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm12=int6464#12
# asm 2: movdqa <xmm5=%xmm5,>xmm12=%xmm11
movdqa %xmm5,%xmm11

# qhasm:       xmm9 = xmm13
# asm 1: movdqa <xmm13=int6464#11,>xmm9=int6464#13
# asm 2: movdqa <xmm13=%xmm10,>xmm9=%xmm12
movdqa %xmm10,%xmm12

# qhasm:       xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm11
pxor  %xmm6,%xmm11

# qhasm:       xmm9 |= xmm12
# asm 1: por   <xmm12=int6464#12,<xmm9=int6464#13
# asm 2: por   <xmm12=%xmm11,<xmm9=%xmm12
por   %xmm11,%xmm12

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#12,<xmm13=int6464#11
# asm 2: pand  <xmm12=%xmm11,<xmm13=%xmm10
pand  %xmm11,%xmm10

# qhasm:       xmm8 ^= xmm13
# asm 1: pxor  <xmm13=int6464#11,<xmm8=int6464#15
# asm 2: pxor  <xmm13=%xmm10,<xmm8=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#9
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm10=int6464#10
# asm 2: pxor  <xmm14=%xmm13,<xmm10=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm9 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm8 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm8=int6464#15
# asm 2: pxor  <xmm14=%xmm13,<xmm8=%xmm14
pxor  %xmm13,%xmm14

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm12 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm12=int6464#11
# asm 2: movdqa <xmm2=%xmm2,>xmm12=%xmm10
movdqa %xmm2,%xmm10

# qhasm:       xmm13 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm13=int6464#12
# asm 2: movdqa <xmm4=%xmm4,>xmm13=%xmm11
movdqa %xmm4,%xmm11

# qhasm:       xmm14 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm14=int6464#14
# asm 2: movdqa <xmm1=%xmm1,>xmm14=%xmm13
movdqa %xmm1,%xmm13

# qhasm:       xmm15 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm15=int6464#16
# asm 2: movdqa <xmm7=%xmm7,>xmm15=%xmm15
movdqa %xmm7,%xmm15

# qhasm:       xmm12 &= xmm3
# asm 1: pand  <xmm3=int6464#4,<xmm12=int6464#11
# asm 2: pand  <xmm3=%xmm3,<xmm12=%xmm10
pand  %xmm3,%xmm10

# qhasm:       xmm13 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm13=int6464#12
# asm 2: pand  <xmm0=%xmm0,<xmm13=%xmm11
pand  %xmm0,%xmm11

# qhasm:       xmm14 &= xmm5
# asm 1: pand  <xmm5=int6464#6,<xmm14=int6464#14
# asm 2: pand  <xmm5=%xmm5,<xmm14=%xmm13
pand  %xmm5,%xmm13

# qhasm:       xmm15 |= xmm6
# asm 1: por   <xmm6=int6464#7,<xmm15=int6464#16
# asm 2: por   <xmm6=%xmm6,<xmm15=%xmm15
por   %xmm6,%xmm15

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm11=int6464#9
# asm 2: pxor  <xmm12=%xmm10,<xmm11=%xmm8
pxor  %xmm10,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm8 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm8=int6464#15
# asm 2: pxor  <xmm15=%xmm15,<xmm8=%xmm14
pxor  %xmm15,%xmm14

# qhasm:       xmm12 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm12=int6464#11
# asm 2: movdqa <xmm11=%xmm8,>xmm12=%xmm10
movdqa %xmm8,%xmm10

# qhasm:       xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm12=int6464#11
# asm 2: pxor  <xmm10=%xmm9,<xmm12=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm11 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm11=int6464#9
# asm 2: pand  <xmm9=%xmm12,<xmm11=%xmm8
pand  %xmm12,%xmm8

# qhasm:       xmm14 = xmm8
# asm 1: movdqa <xmm8=int6464#15,>xmm14=int6464#12
# asm 2: movdqa <xmm8=%xmm14,>xmm14=%xmm11
movdqa %xmm14,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm11=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm15 = xmm12
# asm 1: movdqa <xmm12=int6464#11,>xmm15=int6464#14
# asm 2: movdqa <xmm12=%xmm10,>xmm15=%xmm13
movdqa %xmm10,%xmm13

# qhasm:       xmm15 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm15=int6464#14
# asm 2: pand  <xmm14=%xmm11,<xmm15=%xmm13
pand  %xmm11,%xmm13

# qhasm:       xmm15 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm15=int6464#14
# asm 2: pxor  <xmm10=%xmm9,<xmm15=%xmm13
pxor  %xmm9,%xmm13

# qhasm:       xmm13 = xmm9
# asm 1: movdqa <xmm9=int6464#13,>xmm13=int6464#16
# asm 2: movdqa <xmm9=%xmm12,>xmm13=%xmm15
movdqa %xmm12,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm11 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm11=int6464#9
# asm 2: pxor  <xmm10=%xmm9,<xmm11=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm13 &= xmm11
# asm 1: pand  <xmm11=int6464#9,<xmm13=int6464#16
# asm 2: pand  <xmm11=%xmm8,<xmm13=%xmm15
pand  %xmm8,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm13=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm10 = xmm14
# asm 1: movdqa <xmm14=int6464#12,>xmm10=int6464#9
# asm 2: movdqa <xmm14=%xmm11,>xmm10=%xmm8
movdqa %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm10=int6464#9
# asm 2: pxor  <xmm13=%xmm15,<xmm10=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 &= xmm8
# asm 1: pand  <xmm8=int6464#15,<xmm10=int6464#9
# asm 2: pand  <xmm8=%xmm14,<xmm10=%xmm8
pand  %xmm14,%xmm8

# qhasm:       xmm9 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm9=int6464#13
# asm 2: pxor  <xmm10=%xmm8,<xmm9=%xmm12
pxor  %xmm8,%xmm12

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm10=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm14=int6464#12
# asm 2: pand  <xmm15=%xmm13,<xmm14=%xmm11
pand  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm14=int6464#12
# asm 2: pxor  <xmm12=%xmm10,<xmm14=%xmm11
pxor  %xmm10,%xmm11

# qhasm:         xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm8
movdqa %xmm6,%xmm8

# qhasm:         xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#10
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm9
movdqa %xmm5,%xmm9

# qhasm:           xmm10 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm10=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm10=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm10 &= xmm6
# asm 1: pand  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pand  <xmm6=%xmm6,<xmm10=%xmm10
pand  %xmm6,%xmm10

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm6 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm6=int6464#7
# asm 2: pand  <xmm14=%xmm11,<xmm6=%xmm6
pand  %xmm11,%xmm6

# qhasm:           xmm5 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm5=int6464#6
# asm 2: pand  <xmm15=%xmm13,<xmm5=%xmm5
pand  %xmm13,%xmm5

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm5 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm5=int6464#6
# asm 2: pxor  <xmm10=%xmm10,<xmm5=%xmm5
pxor  %xmm10,%xmm5

# qhasm:         xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#10
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm9
pxor  %xmm3,%xmm9

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pand  <xmm0=%xmm0,<xmm10=%xmm10
pand  %xmm0,%xmm10

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm0=int6464#1
# asm 2: pand  <xmm9=%xmm12,<xmm0=%xmm0
pand  %xmm12,%xmm0

# qhasm:           xmm3 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm3=int6464#4
# asm 2: pand  <xmm13=%xmm15,<xmm3=%xmm3
pand  %xmm15,%xmm3

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm3 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm3=int6464#4
# asm 2: pxor  <xmm10=%xmm10,<xmm3=%xmm3
pxor  %xmm10,%xmm3

# qhasm:         xmm6 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm12=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:         xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm9,<xmm5=%xmm5
pxor  %xmm9,%xmm5

# qhasm:         xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm9,<xmm3=%xmm3
pxor  %xmm9,%xmm3

# qhasm:         xmm12 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm12=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm12=%xmm8
movdqa %xmm7,%xmm8

# qhasm:         xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm9
movdqa %xmm1,%xmm9

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm12=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm12=%xmm8
pxor  %xmm4,%xmm8

# qhasm:         xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm9
pxor  %xmm2,%xmm9

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pand  <xmm4=%xmm4,<xmm10=%xmm10
pand  %xmm4,%xmm10

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm4 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm4=int6464#5
# asm 2: pand  <xmm9=%xmm12,<xmm4=%xmm4
pand  %xmm12,%xmm4

# qhasm:           xmm2 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm2=int6464#3
# asm 2: pand  <xmm13=%xmm15,<xmm2=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#3
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm2
pxor  %xmm10,%xmm2

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm7
# asm 1: pand  <xmm7=int6464#8,<xmm11=int6464#11
# asm 2: pand  <xmm7=%xmm7,<xmm11=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm7 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm7=int6464#8
# asm 2: pand  <xmm14=%xmm11,<xmm7=%xmm7
pand  %xmm11,%xmm7

# qhasm:           xmm1 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm1=int6464#2
# asm 2: pand  <xmm15=%xmm13,<xmm1=%xmm1
pand  %xmm13,%xmm1

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm1=int6464#2
# asm 2: pxor  <xmm11=%xmm10,<xmm1=%xmm1
pxor  %xmm10,%xmm1

# qhasm:         xmm7 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm12=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm12=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:         xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:         xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm0,<xmm7=%xmm7
pxor  %xmm0,%xmm7

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm1=int6464#2
# asm 2: pxor  <xmm6=%xmm6,<xmm1=%xmm1
pxor  %xmm6,%xmm1

# qhasm:       xmm4 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm4=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm4=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm6 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm6=int6464#7
# asm 2: pxor  <xmm0=%xmm0,<xmm6=%xmm6
pxor  %xmm0,%xmm6

# qhasm:       xmm0 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm0=int6464#1
# asm 2: pxor  <xmm1=%xmm1,<xmm0=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm5 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm5=int6464#6
# asm 2: pxor  <xmm2=%xmm2,<xmm5=%xmm5
pxor  %xmm2,%xmm5

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm3=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm3=int6464#4
# asm 2: pxor  <xmm5=%xmm5,<xmm3=%xmm3
pxor  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:     xmm8 = shuffle dwords of xmm0 by 0x93
# asm 1: pshufd $0x93,<xmm0=int6464#1,>xmm8=int6464#9
# asm 2: pshufd $0x93,<xmm0=%xmm0,>xmm8=%xmm8
pshufd $0x93,%xmm0,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm1 by 0x93
# asm 1: pshufd $0x93,<xmm1=int6464#2,>xmm9=int6464#10
# asm 2: pshufd $0x93,<xmm1=%xmm1,>xmm9=%xmm9
pshufd $0x93,%xmm1,%xmm9

# qhasm:     xmm10 = shuffle dwords of xmm4 by 0x93
# asm 1: pshufd $0x93,<xmm4=int6464#5,>xmm10=int6464#11
# asm 2: pshufd $0x93,<xmm4=%xmm4,>xmm10=%xmm10
pshufd $0x93,%xmm4,%xmm10

# qhasm:     xmm11 = shuffle dwords of xmm6 by 0x93
# asm 1: pshufd $0x93,<xmm6=int6464#7,>xmm11=int6464#12
# asm 2: pshufd $0x93,<xmm6=%xmm6,>xmm11=%xmm11
pshufd $0x93,%xmm6,%xmm11

# qhasm:     xmm12 = shuffle dwords of xmm3 by 0x93
# asm 1: pshufd $0x93,<xmm3=int6464#4,>xmm12=int6464#13
# asm 2: pshufd $0x93,<xmm3=%xmm3,>xmm12=%xmm12
pshufd $0x93,%xmm3,%xmm12

# qhasm:     xmm13 = shuffle dwords of xmm7 by 0x93
# asm 1: pshufd $0x93,<xmm7=int6464#8,>xmm13=int6464#14
# asm 2: pshufd $0x93,<xmm7=%xmm7,>xmm13=%xmm13
pshufd $0x93,%xmm7,%xmm13

# qhasm:     xmm14 = shuffle dwords of xmm2 by 0x93
# asm 1: pshufd $0x93,<xmm2=int6464#3,>xmm14=int6464#15
# asm 2: pshufd $0x93,<xmm2=%xmm2,>xmm14=%xmm14
pshufd $0x93,%xmm2,%xmm14

# qhasm:     xmm15 = shuffle dwords of xmm5 by 0x93
# asm 1: pshufd $0x93,<xmm5=int6464#6,>xmm15=int6464#16
# asm 2: pshufd $0x93,<xmm5=%xmm5,>xmm15=%xmm15
pshufd $0x93,%xmm5,%xmm15

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm4 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm4=int6464#5
# asm 2: pxor  <xmm10=%xmm10,<xmm4=%xmm4
pxor  %xmm10,%xmm4

# qhasm:     xmm6 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm6=int6464#7
# asm 2: pxor  <xmm11=%xmm11,<xmm6=%xmm6
pxor  %xmm11,%xmm6

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm2 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pxor  <xmm14=%xmm14,<xmm2=%xmm2
pxor  %xmm14,%xmm2

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm10 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:     xmm9 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm9=int6464#10
# asm 2: pxor  <xmm5=%xmm5,<xmm9=%xmm9
pxor  %xmm5,%xmm9

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#13
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm12
pxor  %xmm6,%xmm12

# qhasm:     xmm13 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm13=int6464#14
# asm 2: pxor  <xmm3=%xmm3,<xmm13=%xmm13
pxor  %xmm3,%xmm13

# qhasm:     xmm11 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm11=int6464#12
# asm 2: pxor  <xmm5=%xmm5,<xmm11=%xmm11
pxor  %xmm5,%xmm11

# qhasm:     xmm14 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm14=int6464#15
# asm 2: pxor  <xmm7=%xmm7,<xmm14=%xmm14
pxor  %xmm7,%xmm14

# qhasm:     xmm15 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm15=int6464#16
# asm 2: pxor  <xmm2=%xmm2,<xmm15=%xmm15
pxor  %xmm2,%xmm15

# qhasm:     xmm12 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm12=int6464#13
# asm 2: pxor  <xmm5=%xmm5,<xmm12=%xmm12
pxor  %xmm5,%xmm12

# qhasm:     xmm0 = shuffle dwords of xmm0 by 0x4E
# asm 1: pshufd $0x4E,<xmm0=int6464#1,>xmm0=int6464#1
# asm 2: pshufd $0x4E,<xmm0=%xmm0,>xmm0=%xmm0
pshufd $0x4E,%xmm0,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm1 by 0x4E
# asm 1: pshufd $0x4E,<xmm1=int6464#2,>xmm1=int6464#2
# asm 2: pshufd $0x4E,<xmm1=%xmm1,>xmm1=%xmm1
pshufd $0x4E,%xmm1,%xmm1

# qhasm:     xmm4 = shuffle dwords of xmm4 by 0x4E
# asm 1: pshufd $0x4E,<xmm4=int6464#5,>xmm4=int6464#5
# asm 2: pshufd $0x4E,<xmm4=%xmm4,>xmm4=%xmm4
pshufd $0x4E,%xmm4,%xmm4

# qhasm:     xmm6 = shuffle dwords of xmm6 by 0x4E
# asm 1: pshufd $0x4E,<xmm6=int6464#7,>xmm6=int6464#7
# asm 2: pshufd $0x4E,<xmm6=%xmm6,>xmm6=%xmm6
pshufd $0x4E,%xmm6,%xmm6

# qhasm:     xmm3 = shuffle dwords of xmm3 by 0x4E
# asm 1: pshufd $0x4E,<xmm3=int6464#4,>xmm3=int6464#4
# asm 2: pshufd $0x4E,<xmm3=%xmm3,>xmm3=%xmm3
pshufd $0x4E,%xmm3,%xmm3

# qhasm:     xmm7 = shuffle dwords of xmm7 by 0x4E
# asm 1: pshufd $0x4E,<xmm7=int6464#8,>xmm7=int6464#8
# asm 2: pshufd $0x4E,<xmm7=%xmm7,>xmm7=%xmm7
pshufd $0x4E,%xmm7,%xmm7

# qhasm:     xmm2 = shuffle dwords of xmm2 by 0x4E
# asm 1: pshufd $0x4E,<xmm2=int6464#3,>xmm2=int6464#3
# asm 2: pshufd $0x4E,<xmm2=%xmm2,>xmm2=%xmm2
pshufd $0x4E,%xmm2,%xmm2

# qhasm:     xmm5 = shuffle dwords of xmm5 by 0x4E
# asm 1: pshufd $0x4E,<xmm5=int6464#6,>xmm5=int6464#6
# asm 2: pshufd $0x4E,<xmm5=%xmm5,>xmm5=%xmm5
pshufd $0x4E,%xmm5,%xmm5

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm10 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pxor  <xmm4=%xmm4,<xmm10=%xmm10
pxor  %xmm4,%xmm10

# qhasm:     xmm11 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm11=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm11=%xmm11
pxor  %xmm6,%xmm11

# qhasm:     xmm12 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm12=int6464#13
# asm 2: pxor  <xmm3=%xmm3,<xmm12=%xmm12
pxor  %xmm3,%xmm12

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm14 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm14=int6464#15
# asm 2: pxor  <xmm2=%xmm2,<xmm14=%xmm14
pxor  %xmm2,%xmm14

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm8 ^= *(int128 *)(c + 128)
# asm 1: pxor 128(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 128(<c=%rsi),<xmm8=%xmm8
pxor 128(%rsi),%xmm8

# qhasm:     shuffle bytes of xmm8 by SR
# asm 1: pshufb SR,<xmm8=int6464#9
# asm 2: pshufb SR,<xmm8=%xmm8
pshufb SR,%xmm8

# qhasm:     xmm9 ^= *(int128 *)(c + 144)
# asm 1: pxor 144(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 144(<c=%rsi),<xmm9=%xmm9
pxor 144(%rsi),%xmm9

# qhasm:     shuffle bytes of xmm9 by SR
# asm 1: pshufb SR,<xmm9=int6464#10
# asm 2: pshufb SR,<xmm9=%xmm9
pshufb SR,%xmm9

# qhasm:     xmm10 ^= *(int128 *)(c + 160)
# asm 1: pxor 160(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 160(<c=%rsi),<xmm10=%xmm10
pxor 160(%rsi),%xmm10

# qhasm:     shuffle bytes of xmm10 by SR
# asm 1: pshufb SR,<xmm10=int6464#11
# asm 2: pshufb SR,<xmm10=%xmm10
pshufb SR,%xmm10

# qhasm:     xmm11 ^= *(int128 *)(c + 176)
# asm 1: pxor 176(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 176(<c=%rsi),<xmm11=%xmm11
pxor 176(%rsi),%xmm11

# qhasm:     shuffle bytes of xmm11 by SR
# asm 1: pshufb SR,<xmm11=int6464#12
# asm 2: pshufb SR,<xmm11=%xmm11
pshufb SR,%xmm11

# qhasm:     xmm12 ^= *(int128 *)(c + 192)
# asm 1: pxor 192(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 192(<c=%rsi),<xmm12=%xmm12
pxor 192(%rsi),%xmm12

# qhasm:     shuffle bytes of xmm12 by SR
# asm 1: pshufb SR,<xmm12=int6464#13
# asm 2: pshufb SR,<xmm12=%xmm12
pshufb SR,%xmm12

# qhasm:     xmm13 ^= *(int128 *)(c + 208)
# asm 1: pxor 208(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 208(<c=%rsi),<xmm13=%xmm13
pxor 208(%rsi),%xmm13

# qhasm:     shuffle bytes of xmm13 by SR
# asm 1: pshufb SR,<xmm13=int6464#14
# asm 2: pshufb SR,<xmm13=%xmm13
pshufb SR,%xmm13

# qhasm:     xmm14 ^= *(int128 *)(c + 224)
# asm 1: pxor 224(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 224(<c=%rsi),<xmm14=%xmm14
pxor 224(%rsi),%xmm14

# qhasm:     shuffle bytes of xmm14 by SR
# asm 1: pshufb SR,<xmm14=int6464#15
# asm 2: pshufb SR,<xmm14=%xmm14
pshufb SR,%xmm14

# qhasm:     xmm15 ^= *(int128 *)(c + 240)
# asm 1: pxor 240(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 240(<c=%rsi),<xmm15=%xmm15
pxor 240(%rsi),%xmm15

# qhasm:     shuffle bytes of xmm15 by SR
# asm 1: pshufb SR,<xmm15=int6464#16
# asm 2: pshufb SR,<xmm15=%xmm15
pshufb SR,%xmm15

# qhasm:       xmm13 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm13=int6464#14
# asm 2: pxor  <xmm14=%xmm14,<xmm13=%xmm13
pxor  %xmm14,%xmm13

# qhasm:       xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm9,<xmm10=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm13=int6464#14
# asm 2: pxor  <xmm8=%xmm8,<xmm13=%xmm13
pxor  %xmm8,%xmm13

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm14=int6464#15
# asm 2: pxor  <xmm10=%xmm10,<xmm14=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm11=int6464#12
# asm 2: pxor  <xmm8=%xmm8,<xmm11=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#12
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm11
pxor  %xmm15,%xmm11

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm11=int6464#12
# asm 2: pxor  <xmm12=%xmm12,<xmm11=%xmm11
pxor  %xmm12,%xmm11

# qhasm:       xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm15=int6464#16
# asm 2: pxor  <xmm13=%xmm13,<xmm15=%xmm15
pxor  %xmm13,%xmm15

# qhasm:       xmm11 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm11=int6464#12
# asm 2: pxor  <xmm9=%xmm9,<xmm11=%xmm11
pxor  %xmm9,%xmm11

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm10=int6464#11
# asm 2: pxor  <xmm15=%xmm15,<xmm10=%xmm10
pxor  %xmm15,%xmm10

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm3 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm3=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm3=%xmm0
movdqa %xmm15,%xmm0

# qhasm:       xmm2 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm2=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm2=%xmm1
movdqa %xmm9,%xmm1

# qhasm:       xmm1 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm1=int6464#3
# asm 2: movdqa <xmm13=%xmm13,>xmm1=%xmm2
movdqa %xmm13,%xmm2

# qhasm:       xmm5 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm5=int6464#4
# asm 2: movdqa <xmm10=%xmm10,>xmm5=%xmm3
movdqa %xmm10,%xmm3

# qhasm:       xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#5
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm4
movdqa %xmm14,%xmm4

# qhasm:       xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm0
pxor  %xmm12,%xmm0

# qhasm:       xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm1
pxor  %xmm10,%xmm1

# qhasm:       xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm1=int6464#3
# asm 2: pxor  <xmm11=%xmm11,<xmm1=%xmm2
pxor  %xmm11,%xmm2

# qhasm:       xmm5 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm5=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm5=%xmm3
pxor  %xmm12,%xmm3

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       xmm6 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm6=int6464#6
# asm 2: movdqa <xmm3=%xmm0,>xmm6=%xmm5
movdqa %xmm0,%xmm5

# qhasm:       xmm0 = xmm2
# asm 1: movdqa <xmm2=int6464#2,>xmm0=int6464#7
# asm 2: movdqa <xmm2=%xmm1,>xmm0=%xmm6
movdqa %xmm1,%xmm6

# qhasm:       xmm7 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm3=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       xmm2 |= xmm1
# asm 1: por   <xmm1=int6464#3,<xmm2=int6464#2
# asm 2: por   <xmm1=%xmm2,<xmm2=%xmm1
por   %xmm2,%xmm1

# qhasm:       xmm3 |= xmm4
# asm 1: por   <xmm4=int6464#5,<xmm3=int6464#1
# asm 2: por   <xmm4=%xmm4,<xmm3=%xmm0
por   %xmm4,%xmm0

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm7=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm6 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm6=int6464#6
# asm 2: pand  <xmm4=%xmm4,<xmm6=%xmm5
pand  %xmm4,%xmm5

# qhasm:       xmm0 &= xmm1
# asm 1: pand  <xmm1=int6464#3,<xmm0=int6464#7
# asm 2: pand  <xmm1=%xmm2,<xmm0=%xmm6
pand  %xmm2,%xmm6

# qhasm:       xmm4 ^= xmm1
# asm 1: pxor  <xmm1=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm1=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:       xmm7 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm7=int6464#8
# asm 2: pand  <xmm4=%xmm4,<xmm7=%xmm7
pand  %xmm4,%xmm7

# qhasm:       xmm4 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm4=int6464#3
# asm 2: movdqa <xmm11=%xmm11,>xmm4=%xmm2
movdqa %xmm11,%xmm2

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#3,<xmm5=int6464#4
# asm 2: pand  <xmm4=%xmm2,<xmm5=%xmm3
pand  %xmm2,%xmm3

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm3=int6464#1
# asm 2: pxor  <xmm5=%xmm3,<xmm3=%xmm0
pxor  %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm5 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm5=int6464#3
# asm 2: movdqa <xmm15=%xmm15,>xmm5=%xmm2
movdqa %xmm15,%xmm2

# qhasm:       xmm5 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm5=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm5=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm4 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm4=int6464#4
# asm 2: movdqa <xmm13=%xmm13,>xmm4=%xmm3
movdqa %xmm13,%xmm3

# qhasm:       xmm1 = xmm5
# asm 1: movdqa <xmm5=int6464#3,>xmm1=int6464#5
# asm 2: movdqa <xmm5=%xmm2,>xmm1=%xmm4
movdqa %xmm2,%xmm4

# qhasm:       xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm3
pxor  %xmm14,%xmm3

# qhasm:       xmm1 |= xmm4
# asm 1: por   <xmm4=int6464#4,<xmm1=int6464#5
# asm 2: por   <xmm4=%xmm3,<xmm1=%xmm4
por   %xmm3,%xmm4

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#4,<xmm5=int6464#3
# asm 2: pand  <xmm4=%xmm3,<xmm5=%xmm2
pand  %xmm3,%xmm2

# qhasm:       xmm0 ^= xmm5
# asm 1: pxor  <xmm5=int6464#3,<xmm0=int6464#7
# asm 2: pxor  <xmm5=%xmm2,<xmm0=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#1
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm2=int6464#2
# asm 2: pxor  <xmm6=%xmm5,<xmm2=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm1 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm0 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm0=int6464#7
# asm 2: pxor  <xmm6=%xmm5,<xmm0=%xmm6
pxor  %xmm5,%xmm6

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm4 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm4=int6464#3
# asm 2: movdqa <xmm10=%xmm10,>xmm4=%xmm2
movdqa %xmm10,%xmm2

# qhasm:       xmm5 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm5=int6464#4
# asm 2: movdqa <xmm12=%xmm12,>xmm5=%xmm3
movdqa %xmm12,%xmm3

# qhasm:       xmm6 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm6=int6464#6
# asm 2: movdqa <xmm9=%xmm9,>xmm6=%xmm5
movdqa %xmm9,%xmm5

# qhasm:       xmm7 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm7=int6464#8
# asm 2: movdqa <xmm15=%xmm15,>xmm7=%xmm7
movdqa %xmm15,%xmm7

# qhasm:       xmm4 &= xmm11
# asm 1: pand  <xmm11=int6464#12,<xmm4=int6464#3
# asm 2: pand  <xmm11=%xmm11,<xmm4=%xmm2
pand  %xmm11,%xmm2

# qhasm:       xmm5 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm5=int6464#4
# asm 2: pand  <xmm8=%xmm8,<xmm5=%xmm3
pand  %xmm8,%xmm3

# qhasm:       xmm6 &= xmm13
# asm 1: pand  <xmm13=int6464#14,<xmm6=int6464#6
# asm 2: pand  <xmm13=%xmm13,<xmm6=%xmm5
pand  %xmm13,%xmm5

# qhasm:       xmm7 |= xmm14
# asm 1: por   <xmm14=int6464#15,<xmm7=int6464#8
# asm 2: por   <xmm14=%xmm14,<xmm7=%xmm7
por   %xmm14,%xmm7

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm3=int6464#1
# asm 2: pxor  <xmm4=%xmm2,<xmm3=%xmm0
pxor  %xmm2,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm0 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm0=int6464#7
# asm 2: pxor  <xmm7=%xmm7,<xmm0=%xmm6
pxor  %xmm7,%xmm6

# qhasm:       xmm4 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm4=int6464#3
# asm 2: movdqa <xmm3=%xmm0,>xmm4=%xmm2
movdqa %xmm0,%xmm2

# qhasm:       xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm4=int6464#3
# asm 2: pxor  <xmm2=%xmm1,<xmm4=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm3 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm3=int6464#1
# asm 2: pand  <xmm1=%xmm4,<xmm3=%xmm0
pand  %xmm4,%xmm0

# qhasm:       xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#7,>xmm6=int6464#4
# asm 2: movdqa <xmm0=%xmm6,>xmm6=%xmm3
movdqa %xmm6,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm3=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm7 = xmm4
# asm 1: movdqa <xmm4=int6464#3,>xmm7=int6464#6
# asm 2: movdqa <xmm4=%xmm2,>xmm7=%xmm5
movdqa %xmm2,%xmm5

# qhasm:       xmm7 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm7=int6464#6
# asm 2: pand  <xmm6=%xmm3,<xmm7=%xmm5
pand  %xmm3,%xmm5

# qhasm:       xmm7 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm7=int6464#6
# asm 2: pxor  <xmm2=%xmm1,<xmm7=%xmm5
pxor  %xmm1,%xmm5

# qhasm:       xmm5 = xmm1
# asm 1: movdqa <xmm1=int6464#5,>xmm5=int6464#8
# asm 2: movdqa <xmm1=%xmm4,>xmm5=%xmm7
movdqa %xmm4,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm3 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm3=int6464#1
# asm 2: pxor  <xmm2=%xmm1,<xmm3=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm5 &= xmm3
# asm 1: pand  <xmm3=int6464#1,<xmm5=int6464#8
# asm 2: pand  <xmm3=%xmm0,<xmm5=%xmm7
pand  %xmm0,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm5=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm2 = xmm6
# asm 1: movdqa <xmm6=int6464#4,>xmm2=int6464#1
# asm 2: movdqa <xmm6=%xmm3,>xmm2=%xmm0
movdqa %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm2=int6464#1
# asm 2: pxor  <xmm5=%xmm7,<xmm2=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 &= xmm0
# asm 1: pand  <xmm0=int6464#7,<xmm2=int6464#1
# asm 2: pand  <xmm0=%xmm6,<xmm2=%xmm0
pand  %xmm6,%xmm0

# qhasm:       xmm1 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm1=int6464#5
# asm 2: pxor  <xmm2=%xmm0,<xmm1=%xmm4
pxor  %xmm0,%xmm4

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm2=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm6=int6464#4
# asm 2: pand  <xmm7=%xmm5,<xmm6=%xmm3
pand  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm6=int6464#4
# asm 2: pxor  <xmm4=%xmm2,<xmm6=%xmm3
pxor  %xmm2,%xmm3

# qhasm:         xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm0
movdqa %xmm14,%xmm0

# qhasm:         xmm0 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm0=int6464#2
# asm 2: movdqa <xmm13=%xmm13,>xmm0=%xmm1
movdqa %xmm13,%xmm1

# qhasm:           xmm2 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm2=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm2=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm2 &= xmm14
# asm 1: pand  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pand  <xmm14=%xmm14,<xmm2=%xmm2
pand  %xmm14,%xmm2

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm14 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm14=int6464#15
# asm 2: pand  <xmm6=%xmm3,<xmm14=%xmm14
pand  %xmm3,%xmm14

# qhasm:           xmm13 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm13=int6464#14
# asm 2: pand  <xmm7=%xmm5,<xmm13=%xmm13
pand  %xmm5,%xmm13

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm13 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm13=int6464#14
# asm 2: pxor  <xmm2=%xmm2,<xmm13=%xmm13
pxor  %xmm2,%xmm13

# qhasm:         xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#2
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm1
pxor  %xmm11,%xmm1

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pand  <xmm8=%xmm8,<xmm2=%xmm2
pand  %xmm8,%xmm2

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm8=int6464#9
# asm 2: pand  <xmm1=%xmm4,<xmm8=%xmm8
pand  %xmm4,%xmm8

# qhasm:           xmm11 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm11=int6464#12
# asm 2: pand  <xmm5=%xmm7,<xmm11=%xmm11
pand  %xmm7,%xmm11

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm11 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm11=int6464#12
# asm 2: pxor  <xmm2=%xmm2,<xmm11=%xmm11
pxor  %xmm2,%xmm11

# qhasm:         xmm14 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm4=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:         xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm1,<xmm13=%xmm13
pxor  %xmm1,%xmm13

# qhasm:         xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm1,<xmm11=%xmm11
pxor  %xmm1,%xmm11

# qhasm:         xmm4 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm4=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm4=%xmm0
movdqa %xmm15,%xmm0

# qhasm:         xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm1
movdqa %xmm9,%xmm1

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm4=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm4=%xmm0
pxor  %xmm12,%xmm0

# qhasm:         xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm1
pxor  %xmm10,%xmm1

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pand  <xmm12=%xmm12,<xmm2=%xmm2
pand  %xmm12,%xmm2

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm12 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm12=int6464#13
# asm 2: pand  <xmm1=%xmm4,<xmm12=%xmm12
pand  %xmm4,%xmm12

# qhasm:           xmm10 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm10=int6464#11
# asm 2: pand  <xmm5=%xmm7,<xmm10=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#11
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm10
pxor  %xmm2,%xmm10

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm15
# asm 1: pand  <xmm15=int6464#16,<xmm3=int6464#3
# asm 2: pand  <xmm15=%xmm15,<xmm3=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm15 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm15=int6464#16
# asm 2: pand  <xmm6=%xmm3,<xmm15=%xmm15
pand  %xmm3,%xmm15

# qhasm:           xmm9 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm9=int6464#10
# asm 2: pand  <xmm7=%xmm5,<xmm9=%xmm9
pand  %xmm5,%xmm9

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm9=int6464#10
# asm 2: pxor  <xmm3=%xmm2,<xmm9=%xmm9
pxor  %xmm2,%xmm9

# qhasm:         xmm15 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm4=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm4=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:         xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:         xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm8,<xmm15=%xmm15
pxor  %xmm8,%xmm15

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm9=int6464#10
# asm 2: pxor  <xmm14=%xmm14,<xmm9=%xmm9
pxor  %xmm14,%xmm9

# qhasm:       xmm12 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm12=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm12=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm14 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm14=int6464#15
# asm 2: pxor  <xmm8=%xmm8,<xmm14=%xmm14
pxor  %xmm8,%xmm14

# qhasm:       xmm8 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm8=int6464#9
# asm 2: pxor  <xmm9=%xmm9,<xmm8=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm13 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm13=int6464#14
# asm 2: pxor  <xmm10=%xmm10,<xmm13=%xmm13
pxor  %xmm10,%xmm13

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm11=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm11=int6464#12
# asm 2: pxor  <xmm13=%xmm13,<xmm11=%xmm11
pxor  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:     xmm0 = shuffle dwords of xmm8 by 0x93
# asm 1: pshufd $0x93,<xmm8=int6464#9,>xmm0=int6464#1
# asm 2: pshufd $0x93,<xmm8=%xmm8,>xmm0=%xmm0
pshufd $0x93,%xmm8,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm9 by 0x93
# asm 1: pshufd $0x93,<xmm9=int6464#10,>xmm1=int6464#2
# asm 2: pshufd $0x93,<xmm9=%xmm9,>xmm1=%xmm1
pshufd $0x93,%xmm9,%xmm1

# qhasm:     xmm2 = shuffle dwords of xmm12 by 0x93
# asm 1: pshufd $0x93,<xmm12=int6464#13,>xmm2=int6464#3
# asm 2: pshufd $0x93,<xmm12=%xmm12,>xmm2=%xmm2
pshufd $0x93,%xmm12,%xmm2

# qhasm:     xmm3 = shuffle dwords of xmm14 by 0x93
# asm 1: pshufd $0x93,<xmm14=int6464#15,>xmm3=int6464#4
# asm 2: pshufd $0x93,<xmm14=%xmm14,>xmm3=%xmm3
pshufd $0x93,%xmm14,%xmm3

# qhasm:     xmm4 = shuffle dwords of xmm11 by 0x93
# asm 1: pshufd $0x93,<xmm11=int6464#12,>xmm4=int6464#5
# asm 2: pshufd $0x93,<xmm11=%xmm11,>xmm4=%xmm4
pshufd $0x93,%xmm11,%xmm4

# qhasm:     xmm5 = shuffle dwords of xmm15 by 0x93
# asm 1: pshufd $0x93,<xmm15=int6464#16,>xmm5=int6464#6
# asm 2: pshufd $0x93,<xmm15=%xmm15,>xmm5=%xmm5
pshufd $0x93,%xmm15,%xmm5

# qhasm:     xmm6 = shuffle dwords of xmm10 by 0x93
# asm 1: pshufd $0x93,<xmm10=int6464#11,>xmm6=int6464#7
# asm 2: pshufd $0x93,<xmm10=%xmm10,>xmm6=%xmm6
pshufd $0x93,%xmm10,%xmm6

# qhasm:     xmm7 = shuffle dwords of xmm13 by 0x93
# asm 1: pshufd $0x93,<xmm13=int6464#14,>xmm7=int6464#8
# asm 2: pshufd $0x93,<xmm13=%xmm13,>xmm7=%xmm7
pshufd $0x93,%xmm13,%xmm7

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm12 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm12=int6464#13
# asm 2: pxor  <xmm2=%xmm2,<xmm12=%xmm12
pxor  %xmm2,%xmm12

# qhasm:     xmm14 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm14=int6464#15
# asm 2: pxor  <xmm3=%xmm3,<xmm14=%xmm14
pxor  %xmm3,%xmm14

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm10 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pxor  <xmm6=%xmm6,<xmm10=%xmm10
pxor  %xmm6,%xmm10

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm2 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:     xmm1 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm1=int6464#2
# asm 2: pxor  <xmm13=%xmm13,<xmm1=%xmm1
pxor  %xmm13,%xmm1

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#5
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm4
pxor  %xmm14,%xmm4

# qhasm:     xmm5 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm5=int6464#6
# asm 2: pxor  <xmm11=%xmm11,<xmm5=%xmm5
pxor  %xmm11,%xmm5

# qhasm:     xmm3 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm3=int6464#4
# asm 2: pxor  <xmm13=%xmm13,<xmm3=%xmm3
pxor  %xmm13,%xmm3

# qhasm:     xmm6 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm6=int6464#7
# asm 2: pxor  <xmm15=%xmm15,<xmm6=%xmm6
pxor  %xmm15,%xmm6

# qhasm:     xmm7 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm7=int6464#8
# asm 2: pxor  <xmm10=%xmm10,<xmm7=%xmm7
pxor  %xmm10,%xmm7

# qhasm:     xmm4 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm4=int6464#5
# asm 2: pxor  <xmm13=%xmm13,<xmm4=%xmm4
pxor  %xmm13,%xmm4

# qhasm:     xmm8 = shuffle dwords of xmm8 by 0x4E
# asm 1: pshufd $0x4E,<xmm8=int6464#9,>xmm8=int6464#9
# asm 2: pshufd $0x4E,<xmm8=%xmm8,>xmm8=%xmm8
pshufd $0x4E,%xmm8,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm9 by 0x4E
# asm 1: pshufd $0x4E,<xmm9=int6464#10,>xmm9=int6464#10
# asm 2: pshufd $0x4E,<xmm9=%xmm9,>xmm9=%xmm9
pshufd $0x4E,%xmm9,%xmm9

# qhasm:     xmm12 = shuffle dwords of xmm12 by 0x4E
# asm 1: pshufd $0x4E,<xmm12=int6464#13,>xmm12=int6464#13
# asm 2: pshufd $0x4E,<xmm12=%xmm12,>xmm12=%xmm12
pshufd $0x4E,%xmm12,%xmm12

# qhasm:     xmm14 = shuffle dwords of xmm14 by 0x4E
# asm 1: pshufd $0x4E,<xmm14=int6464#15,>xmm14=int6464#15
# asm 2: pshufd $0x4E,<xmm14=%xmm14,>xmm14=%xmm14
pshufd $0x4E,%xmm14,%xmm14

# qhasm:     xmm11 = shuffle dwords of xmm11 by 0x4E
# asm 1: pshufd $0x4E,<xmm11=int6464#12,>xmm11=int6464#12
# asm 2: pshufd $0x4E,<xmm11=%xmm11,>xmm11=%xmm11
pshufd $0x4E,%xmm11,%xmm11

# qhasm:     xmm15 = shuffle dwords of xmm15 by 0x4E
# asm 1: pshufd $0x4E,<xmm15=int6464#16,>xmm15=int6464#16
# asm 2: pshufd $0x4E,<xmm15=%xmm15,>xmm15=%xmm15
pshufd $0x4E,%xmm15,%xmm15

# qhasm:     xmm10 = shuffle dwords of xmm10 by 0x4E
# asm 1: pshufd $0x4E,<xmm10=int6464#11,>xmm10=int6464#11
# asm 2: pshufd $0x4E,<xmm10=%xmm10,>xmm10=%xmm10
pshufd $0x4E,%xmm10,%xmm10

# qhasm:     xmm13 = shuffle dwords of xmm13 by 0x4E
# asm 1: pshufd $0x4E,<xmm13=int6464#14,>xmm13=int6464#14
# asm 2: pshufd $0x4E,<xmm13=%xmm13,>xmm13=%xmm13
pshufd $0x4E,%xmm13,%xmm13

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm2 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pxor  <xmm12=%xmm12,<xmm2=%xmm2
pxor  %xmm12,%xmm2

# qhasm:     xmm3 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm3=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm3=%xmm3
pxor  %xmm14,%xmm3

# qhasm:     xmm4 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm4=int6464#5
# asm 2: pxor  <xmm11=%xmm11,<xmm4=%xmm4
pxor  %xmm11,%xmm4

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm6 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm6=int6464#7
# asm 2: pxor  <xmm10=%xmm10,<xmm6=%xmm6
pxor  %xmm10,%xmm6

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm0 ^= *(int128 *)(c + 256)
# asm 1: pxor 256(<c=int64#2),<xmm0=int6464#1
# asm 2: pxor 256(<c=%rsi),<xmm0=%xmm0
pxor 256(%rsi),%xmm0

# qhasm:     shuffle bytes of xmm0 by SR
# asm 1: pshufb SR,<xmm0=int6464#1
# asm 2: pshufb SR,<xmm0=%xmm0
pshufb SR,%xmm0

# qhasm:     xmm1 ^= *(int128 *)(c + 272)
# asm 1: pxor 272(<c=int64#2),<xmm1=int6464#2
# asm 2: pxor 272(<c=%rsi),<xmm1=%xmm1
pxor 272(%rsi),%xmm1

# qhasm:     shuffle bytes of xmm1 by SR
# asm 1: pshufb SR,<xmm1=int6464#2
# asm 2: pshufb SR,<xmm1=%xmm1
pshufb SR,%xmm1

# qhasm:     xmm2 ^= *(int128 *)(c + 288)
# asm 1: pxor 288(<c=int64#2),<xmm2=int6464#3
# asm 2: pxor 288(<c=%rsi),<xmm2=%xmm2
pxor 288(%rsi),%xmm2

# qhasm:     shuffle bytes of xmm2 by SR
# asm 1: pshufb SR,<xmm2=int6464#3
# asm 2: pshufb SR,<xmm2=%xmm2
pshufb SR,%xmm2

# qhasm:     xmm3 ^= *(int128 *)(c + 304)
# asm 1: pxor 304(<c=int64#2),<xmm3=int6464#4
# asm 2: pxor 304(<c=%rsi),<xmm3=%xmm3
pxor 304(%rsi),%xmm3

# qhasm:     shuffle bytes of xmm3 by SR
# asm 1: pshufb SR,<xmm3=int6464#4
# asm 2: pshufb SR,<xmm3=%xmm3
pshufb SR,%xmm3

# qhasm:     xmm4 ^= *(int128 *)(c + 320)
# asm 1: pxor 320(<c=int64#2),<xmm4=int6464#5
# asm 2: pxor 320(<c=%rsi),<xmm4=%xmm4
pxor 320(%rsi),%xmm4

# qhasm:     shuffle bytes of xmm4 by SR
# asm 1: pshufb SR,<xmm4=int6464#5
# asm 2: pshufb SR,<xmm4=%xmm4
pshufb SR,%xmm4

# qhasm:     xmm5 ^= *(int128 *)(c + 336)
# asm 1: pxor 336(<c=int64#2),<xmm5=int6464#6
# asm 2: pxor 336(<c=%rsi),<xmm5=%xmm5
pxor 336(%rsi),%xmm5

# qhasm:     shuffle bytes of xmm5 by SR
# asm 1: pshufb SR,<xmm5=int6464#6
# asm 2: pshufb SR,<xmm5=%xmm5
pshufb SR,%xmm5

# qhasm:     xmm6 ^= *(int128 *)(c + 352)
# asm 1: pxor 352(<c=int64#2),<xmm6=int6464#7
# asm 2: pxor 352(<c=%rsi),<xmm6=%xmm6
pxor 352(%rsi),%xmm6

# qhasm:     shuffle bytes of xmm6 by SR
# asm 1: pshufb SR,<xmm6=int6464#7
# asm 2: pshufb SR,<xmm6=%xmm6
pshufb SR,%xmm6

# qhasm:     xmm7 ^= *(int128 *)(c + 368)
# asm 1: pxor 368(<c=int64#2),<xmm7=int6464#8
# asm 2: pxor 368(<c=%rsi),<xmm7=%xmm7
pxor 368(%rsi),%xmm7

# qhasm:     shuffle bytes of xmm7 by SR
# asm 1: pshufb SR,<xmm7=int6464#8
# asm 2: pshufb SR,<xmm7=%xmm7
pshufb SR,%xmm7

# qhasm:       xmm5 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm5=int6464#6
# asm 2: pxor  <xmm6=%xmm6,<xmm5=%xmm5
pxor  %xmm6,%xmm5

# qhasm:       xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm1,<xmm2=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm5=int6464#6
# asm 2: pxor  <xmm0=%xmm0,<xmm5=%xmm5
pxor  %xmm0,%xmm5

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm6=int6464#7
# asm 2: pxor  <xmm2=%xmm2,<xmm6=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm3=int6464#4
# asm 2: pxor  <xmm0=%xmm0,<xmm3=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#4
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm3
pxor  %xmm7,%xmm3

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm3=int6464#4
# asm 2: pxor  <xmm4=%xmm4,<xmm3=%xmm3
pxor  %xmm4,%xmm3

# qhasm:       xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm7=int6464#8
# asm 2: pxor  <xmm5=%xmm5,<xmm7=%xmm7
pxor  %xmm5,%xmm7

# qhasm:       xmm3 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm3=int6464#4
# asm 2: pxor  <xmm1=%xmm1,<xmm3=%xmm3
pxor  %xmm1,%xmm3

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm2=int6464#3
# asm 2: pxor  <xmm7=%xmm7,<xmm2=%xmm2
pxor  %xmm7,%xmm2

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm11 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm11=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm11=%xmm8
movdqa %xmm7,%xmm8

# qhasm:       xmm10 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm10=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm10=%xmm9
movdqa %xmm1,%xmm9

# qhasm:       xmm9 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm9=int6464#11
# asm 2: movdqa <xmm5=%xmm5,>xmm9=%xmm10
movdqa %xmm5,%xmm10

# qhasm:       xmm13 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm13=int6464#12
# asm 2: movdqa <xmm2=%xmm2,>xmm13=%xmm11
movdqa %xmm2,%xmm11

# qhasm:       xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#13
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm12
movdqa %xmm6,%xmm12

# qhasm:       xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm9
pxor  %xmm2,%xmm9

# qhasm:       xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm9=int6464#11
# asm 2: pxor  <xmm3=%xmm3,<xmm9=%xmm10
pxor  %xmm3,%xmm10

# qhasm:       xmm13 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm13=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm13=%xmm11
pxor  %xmm4,%xmm11

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:       xmm14 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm14=int6464#14
# asm 2: movdqa <xmm11=%xmm8,>xmm14=%xmm13
movdqa %xmm8,%xmm13

# qhasm:       xmm8 = xmm10
# asm 1: movdqa <xmm10=int6464#10,>xmm8=int6464#15
# asm 2: movdqa <xmm10=%xmm9,>xmm8=%xmm14
movdqa %xmm9,%xmm14

# qhasm:       xmm15 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm15=int6464#16
# asm 2: movdqa <xmm11=%xmm8,>xmm15=%xmm15
movdqa %xmm8,%xmm15

# qhasm:       xmm10 |= xmm9
# asm 1: por   <xmm9=int6464#11,<xmm10=int6464#10
# asm 2: por   <xmm9=%xmm10,<xmm10=%xmm9
por   %xmm10,%xmm9

# qhasm:       xmm11 |= xmm12
# asm 1: por   <xmm12=int6464#13,<xmm11=int6464#9
# asm 2: por   <xmm12=%xmm12,<xmm11=%xmm8
por   %xmm12,%xmm8

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm15=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm14 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm14=int6464#14
# asm 2: pand  <xmm12=%xmm12,<xmm14=%xmm13
pand  %xmm12,%xmm13

# qhasm:       xmm8 &= xmm9
# asm 1: pand  <xmm9=int6464#11,<xmm8=int6464#15
# asm 2: pand  <xmm9=%xmm10,<xmm8=%xmm14
pand  %xmm10,%xmm14

# qhasm:       xmm12 ^= xmm9
# asm 1: pxor  <xmm9=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm9=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:       xmm15 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm15=int6464#16
# asm 2: pand  <xmm12=%xmm12,<xmm15=%xmm15
pand  %xmm12,%xmm15

# qhasm:       xmm12 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm12=int6464#11
# asm 2: movdqa <xmm3=%xmm3,>xmm12=%xmm10
movdqa %xmm3,%xmm10

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm10
pxor  %xmm0,%xmm10

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#11,<xmm13=int6464#12
# asm 2: pand  <xmm12=%xmm10,<xmm13=%xmm11
pand  %xmm10,%xmm11

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm11=int6464#9
# asm 2: pxor  <xmm13=%xmm11,<xmm11=%xmm8
pxor  %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm13 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm13=int6464#11
# asm 2: movdqa <xmm7=%xmm7,>xmm13=%xmm10
movdqa %xmm7,%xmm10

# qhasm:       xmm13 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm13=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm13=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm12 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm12=int6464#12
# asm 2: movdqa <xmm5=%xmm5,>xmm12=%xmm11
movdqa %xmm5,%xmm11

# qhasm:       xmm9 = xmm13
# asm 1: movdqa <xmm13=int6464#11,>xmm9=int6464#13
# asm 2: movdqa <xmm13=%xmm10,>xmm9=%xmm12
movdqa %xmm10,%xmm12

# qhasm:       xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm11
pxor  %xmm6,%xmm11

# qhasm:       xmm9 |= xmm12
# asm 1: por   <xmm12=int6464#12,<xmm9=int6464#13
# asm 2: por   <xmm12=%xmm11,<xmm9=%xmm12
por   %xmm11,%xmm12

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#12,<xmm13=int6464#11
# asm 2: pand  <xmm12=%xmm11,<xmm13=%xmm10
pand  %xmm11,%xmm10

# qhasm:       xmm8 ^= xmm13
# asm 1: pxor  <xmm13=int6464#11,<xmm8=int6464#15
# asm 2: pxor  <xmm13=%xmm10,<xmm8=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#9
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm10=int6464#10
# asm 2: pxor  <xmm14=%xmm13,<xmm10=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm9 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm8 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm8=int6464#15
# asm 2: pxor  <xmm14=%xmm13,<xmm8=%xmm14
pxor  %xmm13,%xmm14

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm12 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm12=int6464#11
# asm 2: movdqa <xmm2=%xmm2,>xmm12=%xmm10
movdqa %xmm2,%xmm10

# qhasm:       xmm13 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm13=int6464#12
# asm 2: movdqa <xmm4=%xmm4,>xmm13=%xmm11
movdqa %xmm4,%xmm11

# qhasm:       xmm14 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm14=int6464#14
# asm 2: movdqa <xmm1=%xmm1,>xmm14=%xmm13
movdqa %xmm1,%xmm13

# qhasm:       xmm15 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm15=int6464#16
# asm 2: movdqa <xmm7=%xmm7,>xmm15=%xmm15
movdqa %xmm7,%xmm15

# qhasm:       xmm12 &= xmm3
# asm 1: pand  <xmm3=int6464#4,<xmm12=int6464#11
# asm 2: pand  <xmm3=%xmm3,<xmm12=%xmm10
pand  %xmm3,%xmm10

# qhasm:       xmm13 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm13=int6464#12
# asm 2: pand  <xmm0=%xmm0,<xmm13=%xmm11
pand  %xmm0,%xmm11

# qhasm:       xmm14 &= xmm5
# asm 1: pand  <xmm5=int6464#6,<xmm14=int6464#14
# asm 2: pand  <xmm5=%xmm5,<xmm14=%xmm13
pand  %xmm5,%xmm13

# qhasm:       xmm15 |= xmm6
# asm 1: por   <xmm6=int6464#7,<xmm15=int6464#16
# asm 2: por   <xmm6=%xmm6,<xmm15=%xmm15
por   %xmm6,%xmm15

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm11=int6464#9
# asm 2: pxor  <xmm12=%xmm10,<xmm11=%xmm8
pxor  %xmm10,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm8 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm8=int6464#15
# asm 2: pxor  <xmm15=%xmm15,<xmm8=%xmm14
pxor  %xmm15,%xmm14

# qhasm:       xmm12 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm12=int6464#11
# asm 2: movdqa <xmm11=%xmm8,>xmm12=%xmm10
movdqa %xmm8,%xmm10

# qhasm:       xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm12=int6464#11
# asm 2: pxor  <xmm10=%xmm9,<xmm12=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm11 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm11=int6464#9
# asm 2: pand  <xmm9=%xmm12,<xmm11=%xmm8
pand  %xmm12,%xmm8

# qhasm:       xmm14 = xmm8
# asm 1: movdqa <xmm8=int6464#15,>xmm14=int6464#12
# asm 2: movdqa <xmm8=%xmm14,>xmm14=%xmm11
movdqa %xmm14,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm11=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm15 = xmm12
# asm 1: movdqa <xmm12=int6464#11,>xmm15=int6464#14
# asm 2: movdqa <xmm12=%xmm10,>xmm15=%xmm13
movdqa %xmm10,%xmm13

# qhasm:       xmm15 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm15=int6464#14
# asm 2: pand  <xmm14=%xmm11,<xmm15=%xmm13
pand  %xmm11,%xmm13

# qhasm:       xmm15 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm15=int6464#14
# asm 2: pxor  <xmm10=%xmm9,<xmm15=%xmm13
pxor  %xmm9,%xmm13

# qhasm:       xmm13 = xmm9
# asm 1: movdqa <xmm9=int6464#13,>xmm13=int6464#16
# asm 2: movdqa <xmm9=%xmm12,>xmm13=%xmm15
movdqa %xmm12,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm11 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm11=int6464#9
# asm 2: pxor  <xmm10=%xmm9,<xmm11=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm13 &= xmm11
# asm 1: pand  <xmm11=int6464#9,<xmm13=int6464#16
# asm 2: pand  <xmm11=%xmm8,<xmm13=%xmm15
pand  %xmm8,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm13=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm10 = xmm14
# asm 1: movdqa <xmm14=int6464#12,>xmm10=int6464#9
# asm 2: movdqa <xmm14=%xmm11,>xmm10=%xmm8
movdqa %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm10=int6464#9
# asm 2: pxor  <xmm13=%xmm15,<xmm10=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 &= xmm8
# asm 1: pand  <xmm8=int6464#15,<xmm10=int6464#9
# asm 2: pand  <xmm8=%xmm14,<xmm10=%xmm8
pand  %xmm14,%xmm8

# qhasm:       xmm9 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm9=int6464#13
# asm 2: pxor  <xmm10=%xmm8,<xmm9=%xmm12
pxor  %xmm8,%xmm12

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm10=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm14=int6464#12
# asm 2: pand  <xmm15=%xmm13,<xmm14=%xmm11
pand  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm14=int6464#12
# asm 2: pxor  <xmm12=%xmm10,<xmm14=%xmm11
pxor  %xmm10,%xmm11

# qhasm:         xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm8
movdqa %xmm6,%xmm8

# qhasm:         xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#10
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm9
movdqa %xmm5,%xmm9

# qhasm:           xmm10 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm10=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm10=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm10 &= xmm6
# asm 1: pand  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pand  <xmm6=%xmm6,<xmm10=%xmm10
pand  %xmm6,%xmm10

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm6 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm6=int6464#7
# asm 2: pand  <xmm14=%xmm11,<xmm6=%xmm6
pand  %xmm11,%xmm6

# qhasm:           xmm5 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm5=int6464#6
# asm 2: pand  <xmm15=%xmm13,<xmm5=%xmm5
pand  %xmm13,%xmm5

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm5 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm5=int6464#6
# asm 2: pxor  <xmm10=%xmm10,<xmm5=%xmm5
pxor  %xmm10,%xmm5

# qhasm:         xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#10
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm9
pxor  %xmm3,%xmm9

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pand  <xmm0=%xmm0,<xmm10=%xmm10
pand  %xmm0,%xmm10

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm0=int6464#1
# asm 2: pand  <xmm9=%xmm12,<xmm0=%xmm0
pand  %xmm12,%xmm0

# qhasm:           xmm3 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm3=int6464#4
# asm 2: pand  <xmm13=%xmm15,<xmm3=%xmm3
pand  %xmm15,%xmm3

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm3 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm3=int6464#4
# asm 2: pxor  <xmm10=%xmm10,<xmm3=%xmm3
pxor  %xmm10,%xmm3

# qhasm:         xmm6 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm12=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:         xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm9,<xmm5=%xmm5
pxor  %xmm9,%xmm5

# qhasm:         xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm9,<xmm3=%xmm3
pxor  %xmm9,%xmm3

# qhasm:         xmm12 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm12=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm12=%xmm8
movdqa %xmm7,%xmm8

# qhasm:         xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm9
movdqa %xmm1,%xmm9

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm12=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm12=%xmm8
pxor  %xmm4,%xmm8

# qhasm:         xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm9
pxor  %xmm2,%xmm9

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pand  <xmm4=%xmm4,<xmm10=%xmm10
pand  %xmm4,%xmm10

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm4 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm4=int6464#5
# asm 2: pand  <xmm9=%xmm12,<xmm4=%xmm4
pand  %xmm12,%xmm4

# qhasm:           xmm2 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm2=int6464#3
# asm 2: pand  <xmm13=%xmm15,<xmm2=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#3
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm2
pxor  %xmm10,%xmm2

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm7
# asm 1: pand  <xmm7=int6464#8,<xmm11=int6464#11
# asm 2: pand  <xmm7=%xmm7,<xmm11=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm7 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm7=int6464#8
# asm 2: pand  <xmm14=%xmm11,<xmm7=%xmm7
pand  %xmm11,%xmm7

# qhasm:           xmm1 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm1=int6464#2
# asm 2: pand  <xmm15=%xmm13,<xmm1=%xmm1
pand  %xmm13,%xmm1

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm1=int6464#2
# asm 2: pxor  <xmm11=%xmm10,<xmm1=%xmm1
pxor  %xmm10,%xmm1

# qhasm:         xmm7 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm12=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm12=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:         xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:         xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm0,<xmm7=%xmm7
pxor  %xmm0,%xmm7

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm1=int6464#2
# asm 2: pxor  <xmm6=%xmm6,<xmm1=%xmm1
pxor  %xmm6,%xmm1

# qhasm:       xmm4 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm4=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm4=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm6 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm6=int6464#7
# asm 2: pxor  <xmm0=%xmm0,<xmm6=%xmm6
pxor  %xmm0,%xmm6

# qhasm:       xmm0 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm0=int6464#1
# asm 2: pxor  <xmm1=%xmm1,<xmm0=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm5 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm5=int6464#6
# asm 2: pxor  <xmm2=%xmm2,<xmm5=%xmm5
pxor  %xmm2,%xmm5

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm3=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm3=int6464#4
# asm 2: pxor  <xmm5=%xmm5,<xmm3=%xmm3
pxor  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:     xmm8 = shuffle dwords of xmm0 by 0x93
# asm 1: pshufd $0x93,<xmm0=int6464#1,>xmm8=int6464#9
# asm 2: pshufd $0x93,<xmm0=%xmm0,>xmm8=%xmm8
pshufd $0x93,%xmm0,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm1 by 0x93
# asm 1: pshufd $0x93,<xmm1=int6464#2,>xmm9=int6464#10
# asm 2: pshufd $0x93,<xmm1=%xmm1,>xmm9=%xmm9
pshufd $0x93,%xmm1,%xmm9

# qhasm:     xmm10 = shuffle dwords of xmm4 by 0x93
# asm 1: pshufd $0x93,<xmm4=int6464#5,>xmm10=int6464#11
# asm 2: pshufd $0x93,<xmm4=%xmm4,>xmm10=%xmm10
pshufd $0x93,%xmm4,%xmm10

# qhasm:     xmm11 = shuffle dwords of xmm6 by 0x93
# asm 1: pshufd $0x93,<xmm6=int6464#7,>xmm11=int6464#12
# asm 2: pshufd $0x93,<xmm6=%xmm6,>xmm11=%xmm11
pshufd $0x93,%xmm6,%xmm11

# qhasm:     xmm12 = shuffle dwords of xmm3 by 0x93
# asm 1: pshufd $0x93,<xmm3=int6464#4,>xmm12=int6464#13
# asm 2: pshufd $0x93,<xmm3=%xmm3,>xmm12=%xmm12
pshufd $0x93,%xmm3,%xmm12

# qhasm:     xmm13 = shuffle dwords of xmm7 by 0x93
# asm 1: pshufd $0x93,<xmm7=int6464#8,>xmm13=int6464#14
# asm 2: pshufd $0x93,<xmm7=%xmm7,>xmm13=%xmm13
pshufd $0x93,%xmm7,%xmm13

# qhasm:     xmm14 = shuffle dwords of xmm2 by 0x93
# asm 1: pshufd $0x93,<xmm2=int6464#3,>xmm14=int6464#15
# asm 2: pshufd $0x93,<xmm2=%xmm2,>xmm14=%xmm14
pshufd $0x93,%xmm2,%xmm14

# qhasm:     xmm15 = shuffle dwords of xmm5 by 0x93
# asm 1: pshufd $0x93,<xmm5=int6464#6,>xmm15=int6464#16
# asm 2: pshufd $0x93,<xmm5=%xmm5,>xmm15=%xmm15
pshufd $0x93,%xmm5,%xmm15

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm4 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm4=int6464#5
# asm 2: pxor  <xmm10=%xmm10,<xmm4=%xmm4
pxor  %xmm10,%xmm4

# qhasm:     xmm6 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm6=int6464#7
# asm 2: pxor  <xmm11=%xmm11,<xmm6=%xmm6
pxor  %xmm11,%xmm6

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm2 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pxor  <xmm14=%xmm14,<xmm2=%xmm2
pxor  %xmm14,%xmm2

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm10 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:     xmm9 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm9=int6464#10
# asm 2: pxor  <xmm5=%xmm5,<xmm9=%xmm9
pxor  %xmm5,%xmm9

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#13
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm12
pxor  %xmm6,%xmm12

# qhasm:     xmm13 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm13=int6464#14
# asm 2: pxor  <xmm3=%xmm3,<xmm13=%xmm13
pxor  %xmm3,%xmm13

# qhasm:     xmm11 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm11=int6464#12
# asm 2: pxor  <xmm5=%xmm5,<xmm11=%xmm11
pxor  %xmm5,%xmm11

# qhasm:     xmm14 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm14=int6464#15
# asm 2: pxor  <xmm7=%xmm7,<xmm14=%xmm14
pxor  %xmm7,%xmm14

# qhasm:     xmm15 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm15=int6464#16
# asm 2: pxor  <xmm2=%xmm2,<xmm15=%xmm15
pxor  %xmm2,%xmm15

# qhasm:     xmm12 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm12=int6464#13
# asm 2: pxor  <xmm5=%xmm5,<xmm12=%xmm12
pxor  %xmm5,%xmm12

# qhasm:     xmm0 = shuffle dwords of xmm0 by 0x4E
# asm 1: pshufd $0x4E,<xmm0=int6464#1,>xmm0=int6464#1
# asm 2: pshufd $0x4E,<xmm0=%xmm0,>xmm0=%xmm0
pshufd $0x4E,%xmm0,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm1 by 0x4E
# asm 1: pshufd $0x4E,<xmm1=int6464#2,>xmm1=int6464#2
# asm 2: pshufd $0x4E,<xmm1=%xmm1,>xmm1=%xmm1
pshufd $0x4E,%xmm1,%xmm1

# qhasm:     xmm4 = shuffle dwords of xmm4 by 0x4E
# asm 1: pshufd $0x4E,<xmm4=int6464#5,>xmm4=int6464#5
# asm 2: pshufd $0x4E,<xmm4=%xmm4,>xmm4=%xmm4
pshufd $0x4E,%xmm4,%xmm4

# qhasm:     xmm6 = shuffle dwords of xmm6 by 0x4E
# asm 1: pshufd $0x4E,<xmm6=int6464#7,>xmm6=int6464#7
# asm 2: pshufd $0x4E,<xmm6=%xmm6,>xmm6=%xmm6
pshufd $0x4E,%xmm6,%xmm6

# qhasm:     xmm3 = shuffle dwords of xmm3 by 0x4E
# asm 1: pshufd $0x4E,<xmm3=int6464#4,>xmm3=int6464#4
# asm 2: pshufd $0x4E,<xmm3=%xmm3,>xmm3=%xmm3
pshufd $0x4E,%xmm3,%xmm3

# qhasm:     xmm7 = shuffle dwords of xmm7 by 0x4E
# asm 1: pshufd $0x4E,<xmm7=int6464#8,>xmm7=int6464#8
# asm 2: pshufd $0x4E,<xmm7=%xmm7,>xmm7=%xmm7
pshufd $0x4E,%xmm7,%xmm7

# qhasm:     xmm2 = shuffle dwords of xmm2 by 0x4E
# asm 1: pshufd $0x4E,<xmm2=int6464#3,>xmm2=int6464#3
# asm 2: pshufd $0x4E,<xmm2=%xmm2,>xmm2=%xmm2
pshufd $0x4E,%xmm2,%xmm2

# qhasm:     xmm5 = shuffle dwords of xmm5 by 0x4E
# asm 1: pshufd $0x4E,<xmm5=int6464#6,>xmm5=int6464#6
# asm 2: pshufd $0x4E,<xmm5=%xmm5,>xmm5=%xmm5
pshufd $0x4E,%xmm5,%xmm5

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm10 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pxor  <xmm4=%xmm4,<xmm10=%xmm10
pxor  %xmm4,%xmm10

# qhasm:     xmm11 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm11=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm11=%xmm11
pxor  %xmm6,%xmm11

# qhasm:     xmm12 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm12=int6464#13
# asm 2: pxor  <xmm3=%xmm3,<xmm12=%xmm12
pxor  %xmm3,%xmm12

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm14 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm14=int6464#15
# asm 2: pxor  <xmm2=%xmm2,<xmm14=%xmm14
pxor  %xmm2,%xmm14

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm8 ^= *(int128 *)(c + 384)
# asm 1: pxor 384(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 384(<c=%rsi),<xmm8=%xmm8
pxor 384(%rsi),%xmm8

# qhasm:     shuffle bytes of xmm8 by SR
# asm 1: pshufb SR,<xmm8=int6464#9
# asm 2: pshufb SR,<xmm8=%xmm8
pshufb SR,%xmm8

# qhasm:     xmm9 ^= *(int128 *)(c + 400)
# asm 1: pxor 400(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 400(<c=%rsi),<xmm9=%xmm9
pxor 400(%rsi),%xmm9

# qhasm:     shuffle bytes of xmm9 by SR
# asm 1: pshufb SR,<xmm9=int6464#10
# asm 2: pshufb SR,<xmm9=%xmm9
pshufb SR,%xmm9

# qhasm:     xmm10 ^= *(int128 *)(c + 416)
# asm 1: pxor 416(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 416(<c=%rsi),<xmm10=%xmm10
pxor 416(%rsi),%xmm10

# qhasm:     shuffle bytes of xmm10 by SR
# asm 1: pshufb SR,<xmm10=int6464#11
# asm 2: pshufb SR,<xmm10=%xmm10
pshufb SR,%xmm10

# qhasm:     xmm11 ^= *(int128 *)(c + 432)
# asm 1: pxor 432(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 432(<c=%rsi),<xmm11=%xmm11
pxor 432(%rsi),%xmm11

# qhasm:     shuffle bytes of xmm11 by SR
# asm 1: pshufb SR,<xmm11=int6464#12
# asm 2: pshufb SR,<xmm11=%xmm11
pshufb SR,%xmm11

# qhasm:     xmm12 ^= *(int128 *)(c + 448)
# asm 1: pxor 448(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 448(<c=%rsi),<xmm12=%xmm12
pxor 448(%rsi),%xmm12

# qhasm:     shuffle bytes of xmm12 by SR
# asm 1: pshufb SR,<xmm12=int6464#13
# asm 2: pshufb SR,<xmm12=%xmm12
pshufb SR,%xmm12

# qhasm:     xmm13 ^= *(int128 *)(c + 464)
# asm 1: pxor 464(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 464(<c=%rsi),<xmm13=%xmm13
pxor 464(%rsi),%xmm13

# qhasm:     shuffle bytes of xmm13 by SR
# asm 1: pshufb SR,<xmm13=int6464#14
# asm 2: pshufb SR,<xmm13=%xmm13
pshufb SR,%xmm13

# qhasm:     xmm14 ^= *(int128 *)(c + 480)
# asm 1: pxor 480(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 480(<c=%rsi),<xmm14=%xmm14
pxor 480(%rsi),%xmm14

# qhasm:     shuffle bytes of xmm14 by SR
# asm 1: pshufb SR,<xmm14=int6464#15
# asm 2: pshufb SR,<xmm14=%xmm14
pshufb SR,%xmm14

# qhasm:     xmm15 ^= *(int128 *)(c + 496)
# asm 1: pxor 496(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 496(<c=%rsi),<xmm15=%xmm15
pxor 496(%rsi),%xmm15

# qhasm:     shuffle bytes of xmm15 by SR
# asm 1: pshufb SR,<xmm15=int6464#16
# asm 2: pshufb SR,<xmm15=%xmm15
pshufb SR,%xmm15

# qhasm:       xmm13 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm13=int6464#14
# asm 2: pxor  <xmm14=%xmm14,<xmm13=%xmm13
pxor  %xmm14,%xmm13

# qhasm:       xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm9,<xmm10=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm13=int6464#14
# asm 2: pxor  <xmm8=%xmm8,<xmm13=%xmm13
pxor  %xmm8,%xmm13

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm14=int6464#15
# asm 2: pxor  <xmm10=%xmm10,<xmm14=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm11=int6464#12
# asm 2: pxor  <xmm8=%xmm8,<xmm11=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#12
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm11
pxor  %xmm15,%xmm11

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm11=int6464#12
# asm 2: pxor  <xmm12=%xmm12,<xmm11=%xmm11
pxor  %xmm12,%xmm11

# qhasm:       xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm15=int6464#16
# asm 2: pxor  <xmm13=%xmm13,<xmm15=%xmm15
pxor  %xmm13,%xmm15

# qhasm:       xmm11 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm11=int6464#12
# asm 2: pxor  <xmm9=%xmm9,<xmm11=%xmm11
pxor  %xmm9,%xmm11

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm10=int6464#11
# asm 2: pxor  <xmm15=%xmm15,<xmm10=%xmm10
pxor  %xmm15,%xmm10

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm3 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm3=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm3=%xmm0
movdqa %xmm15,%xmm0

# qhasm:       xmm2 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm2=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm2=%xmm1
movdqa %xmm9,%xmm1

# qhasm:       xmm1 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm1=int6464#3
# asm 2: movdqa <xmm13=%xmm13,>xmm1=%xmm2
movdqa %xmm13,%xmm2

# qhasm:       xmm5 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm5=int6464#4
# asm 2: movdqa <xmm10=%xmm10,>xmm5=%xmm3
movdqa %xmm10,%xmm3

# qhasm:       xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#5
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm4
movdqa %xmm14,%xmm4

# qhasm:       xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm0
pxor  %xmm12,%xmm0

# qhasm:       xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm1
pxor  %xmm10,%xmm1

# qhasm:       xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm1=int6464#3
# asm 2: pxor  <xmm11=%xmm11,<xmm1=%xmm2
pxor  %xmm11,%xmm2

# qhasm:       xmm5 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm5=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm5=%xmm3
pxor  %xmm12,%xmm3

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       xmm6 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm6=int6464#6
# asm 2: movdqa <xmm3=%xmm0,>xmm6=%xmm5
movdqa %xmm0,%xmm5

# qhasm:       xmm0 = xmm2
# asm 1: movdqa <xmm2=int6464#2,>xmm0=int6464#7
# asm 2: movdqa <xmm2=%xmm1,>xmm0=%xmm6
movdqa %xmm1,%xmm6

# qhasm:       xmm7 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm3=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       xmm2 |= xmm1
# asm 1: por   <xmm1=int6464#3,<xmm2=int6464#2
# asm 2: por   <xmm1=%xmm2,<xmm2=%xmm1
por   %xmm2,%xmm1

# qhasm:       xmm3 |= xmm4
# asm 1: por   <xmm4=int6464#5,<xmm3=int6464#1
# asm 2: por   <xmm4=%xmm4,<xmm3=%xmm0
por   %xmm4,%xmm0

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm7=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm6 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm6=int6464#6
# asm 2: pand  <xmm4=%xmm4,<xmm6=%xmm5
pand  %xmm4,%xmm5

# qhasm:       xmm0 &= xmm1
# asm 1: pand  <xmm1=int6464#3,<xmm0=int6464#7
# asm 2: pand  <xmm1=%xmm2,<xmm0=%xmm6
pand  %xmm2,%xmm6

# qhasm:       xmm4 ^= xmm1
# asm 1: pxor  <xmm1=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm1=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:       xmm7 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm7=int6464#8
# asm 2: pand  <xmm4=%xmm4,<xmm7=%xmm7
pand  %xmm4,%xmm7

# qhasm:       xmm4 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm4=int6464#3
# asm 2: movdqa <xmm11=%xmm11,>xmm4=%xmm2
movdqa %xmm11,%xmm2

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#3,<xmm5=int6464#4
# asm 2: pand  <xmm4=%xmm2,<xmm5=%xmm3
pand  %xmm2,%xmm3

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm3=int6464#1
# asm 2: pxor  <xmm5=%xmm3,<xmm3=%xmm0
pxor  %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm5 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm5=int6464#3
# asm 2: movdqa <xmm15=%xmm15,>xmm5=%xmm2
movdqa %xmm15,%xmm2

# qhasm:       xmm5 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm5=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm5=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm4 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm4=int6464#4
# asm 2: movdqa <xmm13=%xmm13,>xmm4=%xmm3
movdqa %xmm13,%xmm3

# qhasm:       xmm1 = xmm5
# asm 1: movdqa <xmm5=int6464#3,>xmm1=int6464#5
# asm 2: movdqa <xmm5=%xmm2,>xmm1=%xmm4
movdqa %xmm2,%xmm4

# qhasm:       xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm3
pxor  %xmm14,%xmm3

# qhasm:       xmm1 |= xmm4
# asm 1: por   <xmm4=int6464#4,<xmm1=int6464#5
# asm 2: por   <xmm4=%xmm3,<xmm1=%xmm4
por   %xmm3,%xmm4

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#4,<xmm5=int6464#3
# asm 2: pand  <xmm4=%xmm3,<xmm5=%xmm2
pand  %xmm3,%xmm2

# qhasm:       xmm0 ^= xmm5
# asm 1: pxor  <xmm5=int6464#3,<xmm0=int6464#7
# asm 2: pxor  <xmm5=%xmm2,<xmm0=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#1
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm2=int6464#2
# asm 2: pxor  <xmm6=%xmm5,<xmm2=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm1 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm0 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm0=int6464#7
# asm 2: pxor  <xmm6=%xmm5,<xmm0=%xmm6
pxor  %xmm5,%xmm6

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm4 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm4=int6464#3
# asm 2: movdqa <xmm10=%xmm10,>xmm4=%xmm2
movdqa %xmm10,%xmm2

# qhasm:       xmm5 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm5=int6464#4
# asm 2: movdqa <xmm12=%xmm12,>xmm5=%xmm3
movdqa %xmm12,%xmm3

# qhasm:       xmm6 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm6=int6464#6
# asm 2: movdqa <xmm9=%xmm9,>xmm6=%xmm5
movdqa %xmm9,%xmm5

# qhasm:       xmm7 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm7=int6464#8
# asm 2: movdqa <xmm15=%xmm15,>xmm7=%xmm7
movdqa %xmm15,%xmm7

# qhasm:       xmm4 &= xmm11
# asm 1: pand  <xmm11=int6464#12,<xmm4=int6464#3
# asm 2: pand  <xmm11=%xmm11,<xmm4=%xmm2
pand  %xmm11,%xmm2

# qhasm:       xmm5 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm5=int6464#4
# asm 2: pand  <xmm8=%xmm8,<xmm5=%xmm3
pand  %xmm8,%xmm3

# qhasm:       xmm6 &= xmm13
# asm 1: pand  <xmm13=int6464#14,<xmm6=int6464#6
# asm 2: pand  <xmm13=%xmm13,<xmm6=%xmm5
pand  %xmm13,%xmm5

# qhasm:       xmm7 |= xmm14
# asm 1: por   <xmm14=int6464#15,<xmm7=int6464#8
# asm 2: por   <xmm14=%xmm14,<xmm7=%xmm7
por   %xmm14,%xmm7

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm3=int6464#1
# asm 2: pxor  <xmm4=%xmm2,<xmm3=%xmm0
pxor  %xmm2,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm0 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm0=int6464#7
# asm 2: pxor  <xmm7=%xmm7,<xmm0=%xmm6
pxor  %xmm7,%xmm6

# qhasm:       xmm4 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm4=int6464#3
# asm 2: movdqa <xmm3=%xmm0,>xmm4=%xmm2
movdqa %xmm0,%xmm2

# qhasm:       xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm4=int6464#3
# asm 2: pxor  <xmm2=%xmm1,<xmm4=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm3 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm3=int6464#1
# asm 2: pand  <xmm1=%xmm4,<xmm3=%xmm0
pand  %xmm4,%xmm0

# qhasm:       xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#7,>xmm6=int6464#4
# asm 2: movdqa <xmm0=%xmm6,>xmm6=%xmm3
movdqa %xmm6,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm3=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm7 = xmm4
# asm 1: movdqa <xmm4=int6464#3,>xmm7=int6464#6
# asm 2: movdqa <xmm4=%xmm2,>xmm7=%xmm5
movdqa %xmm2,%xmm5

# qhasm:       xmm7 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm7=int6464#6
# asm 2: pand  <xmm6=%xmm3,<xmm7=%xmm5
pand  %xmm3,%xmm5

# qhasm:       xmm7 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm7=int6464#6
# asm 2: pxor  <xmm2=%xmm1,<xmm7=%xmm5
pxor  %xmm1,%xmm5

# qhasm:       xmm5 = xmm1
# asm 1: movdqa <xmm1=int6464#5,>xmm5=int6464#8
# asm 2: movdqa <xmm1=%xmm4,>xmm5=%xmm7
movdqa %xmm4,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm3 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm3=int6464#1
# asm 2: pxor  <xmm2=%xmm1,<xmm3=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm5 &= xmm3
# asm 1: pand  <xmm3=int6464#1,<xmm5=int6464#8
# asm 2: pand  <xmm3=%xmm0,<xmm5=%xmm7
pand  %xmm0,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm5=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm2 = xmm6
# asm 1: movdqa <xmm6=int6464#4,>xmm2=int6464#1
# asm 2: movdqa <xmm6=%xmm3,>xmm2=%xmm0
movdqa %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm2=int6464#1
# asm 2: pxor  <xmm5=%xmm7,<xmm2=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 &= xmm0
# asm 1: pand  <xmm0=int6464#7,<xmm2=int6464#1
# asm 2: pand  <xmm0=%xmm6,<xmm2=%xmm0
pand  %xmm6,%xmm0

# qhasm:       xmm1 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm1=int6464#5
# asm 2: pxor  <xmm2=%xmm0,<xmm1=%xmm4
pxor  %xmm0,%xmm4

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm2=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm6=int6464#4
# asm 2: pand  <xmm7=%xmm5,<xmm6=%xmm3
pand  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm6=int6464#4
# asm 2: pxor  <xmm4=%xmm2,<xmm6=%xmm3
pxor  %xmm2,%xmm3

# qhasm:         xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm0
movdqa %xmm14,%xmm0

# qhasm:         xmm0 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm0=int6464#2
# asm 2: movdqa <xmm13=%xmm13,>xmm0=%xmm1
movdqa %xmm13,%xmm1

# qhasm:           xmm2 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm2=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm2=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm2 &= xmm14
# asm 1: pand  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pand  <xmm14=%xmm14,<xmm2=%xmm2
pand  %xmm14,%xmm2

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm14 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm14=int6464#15
# asm 2: pand  <xmm6=%xmm3,<xmm14=%xmm14
pand  %xmm3,%xmm14

# qhasm:           xmm13 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm13=int6464#14
# asm 2: pand  <xmm7=%xmm5,<xmm13=%xmm13
pand  %xmm5,%xmm13

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm13 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm13=int6464#14
# asm 2: pxor  <xmm2=%xmm2,<xmm13=%xmm13
pxor  %xmm2,%xmm13

# qhasm:         xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#2
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm1
pxor  %xmm11,%xmm1

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pand  <xmm8=%xmm8,<xmm2=%xmm2
pand  %xmm8,%xmm2

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm8=int6464#9
# asm 2: pand  <xmm1=%xmm4,<xmm8=%xmm8
pand  %xmm4,%xmm8

# qhasm:           xmm11 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm11=int6464#12
# asm 2: pand  <xmm5=%xmm7,<xmm11=%xmm11
pand  %xmm7,%xmm11

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm11 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm11=int6464#12
# asm 2: pxor  <xmm2=%xmm2,<xmm11=%xmm11
pxor  %xmm2,%xmm11

# qhasm:         xmm14 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm4=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:         xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm1,<xmm13=%xmm13
pxor  %xmm1,%xmm13

# qhasm:         xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm1,<xmm11=%xmm11
pxor  %xmm1,%xmm11

# qhasm:         xmm4 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm4=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm4=%xmm0
movdqa %xmm15,%xmm0

# qhasm:         xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm1
movdqa %xmm9,%xmm1

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm4=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm4=%xmm0
pxor  %xmm12,%xmm0

# qhasm:         xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm1
pxor  %xmm10,%xmm1

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pand  <xmm12=%xmm12,<xmm2=%xmm2
pand  %xmm12,%xmm2

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm12 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm12=int6464#13
# asm 2: pand  <xmm1=%xmm4,<xmm12=%xmm12
pand  %xmm4,%xmm12

# qhasm:           xmm10 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm10=int6464#11
# asm 2: pand  <xmm5=%xmm7,<xmm10=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#11
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm10
pxor  %xmm2,%xmm10

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm15
# asm 1: pand  <xmm15=int6464#16,<xmm3=int6464#3
# asm 2: pand  <xmm15=%xmm15,<xmm3=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm15 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm15=int6464#16
# asm 2: pand  <xmm6=%xmm3,<xmm15=%xmm15
pand  %xmm3,%xmm15

# qhasm:           xmm9 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm9=int6464#10
# asm 2: pand  <xmm7=%xmm5,<xmm9=%xmm9
pand  %xmm5,%xmm9

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm9=int6464#10
# asm 2: pxor  <xmm3=%xmm2,<xmm9=%xmm9
pxor  %xmm2,%xmm9

# qhasm:         xmm15 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm4=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm4=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:         xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:         xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm8,<xmm15=%xmm15
pxor  %xmm8,%xmm15

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm9=int6464#10
# asm 2: pxor  <xmm14=%xmm14,<xmm9=%xmm9
pxor  %xmm14,%xmm9

# qhasm:       xmm12 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm12=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm12=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm14 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm14=int6464#15
# asm 2: pxor  <xmm8=%xmm8,<xmm14=%xmm14
pxor  %xmm8,%xmm14

# qhasm:       xmm8 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm8=int6464#9
# asm 2: pxor  <xmm9=%xmm9,<xmm8=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm13 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm13=int6464#14
# asm 2: pxor  <xmm10=%xmm10,<xmm13=%xmm13
pxor  %xmm10,%xmm13

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm11=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm11=int6464#12
# asm 2: pxor  <xmm13=%xmm13,<xmm11=%xmm11
pxor  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:     xmm0 = shuffle dwords of xmm8 by 0x93
# asm 1: pshufd $0x93,<xmm8=int6464#9,>xmm0=int6464#1
# asm 2: pshufd $0x93,<xmm8=%xmm8,>xmm0=%xmm0
pshufd $0x93,%xmm8,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm9 by 0x93
# asm 1: pshufd $0x93,<xmm9=int6464#10,>xmm1=int6464#2
# asm 2: pshufd $0x93,<xmm9=%xmm9,>xmm1=%xmm1
pshufd $0x93,%xmm9,%xmm1

# qhasm:     xmm2 = shuffle dwords of xmm12 by 0x93
# asm 1: pshufd $0x93,<xmm12=int6464#13,>xmm2=int6464#3
# asm 2: pshufd $0x93,<xmm12=%xmm12,>xmm2=%xmm2
pshufd $0x93,%xmm12,%xmm2

# qhasm:     xmm3 = shuffle dwords of xmm14 by 0x93
# asm 1: pshufd $0x93,<xmm14=int6464#15,>xmm3=int6464#4
# asm 2: pshufd $0x93,<xmm14=%xmm14,>xmm3=%xmm3
pshufd $0x93,%xmm14,%xmm3

# qhasm:     xmm4 = shuffle dwords of xmm11 by 0x93
# asm 1: pshufd $0x93,<xmm11=int6464#12,>xmm4=int6464#5
# asm 2: pshufd $0x93,<xmm11=%xmm11,>xmm4=%xmm4
pshufd $0x93,%xmm11,%xmm4

# qhasm:     xmm5 = shuffle dwords of xmm15 by 0x93
# asm 1: pshufd $0x93,<xmm15=int6464#16,>xmm5=int6464#6
# asm 2: pshufd $0x93,<xmm15=%xmm15,>xmm5=%xmm5
pshufd $0x93,%xmm15,%xmm5

# qhasm:     xmm6 = shuffle dwords of xmm10 by 0x93
# asm 1: pshufd $0x93,<xmm10=int6464#11,>xmm6=int6464#7
# asm 2: pshufd $0x93,<xmm10=%xmm10,>xmm6=%xmm6
pshufd $0x93,%xmm10,%xmm6

# qhasm:     xmm7 = shuffle dwords of xmm13 by 0x93
# asm 1: pshufd $0x93,<xmm13=int6464#14,>xmm7=int6464#8
# asm 2: pshufd $0x93,<xmm13=%xmm13,>xmm7=%xmm7
pshufd $0x93,%xmm13,%xmm7

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm12 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm12=int6464#13
# asm 2: pxor  <xmm2=%xmm2,<xmm12=%xmm12
pxor  %xmm2,%xmm12

# qhasm:     xmm14 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm14=int6464#15
# asm 2: pxor  <xmm3=%xmm3,<xmm14=%xmm14
pxor  %xmm3,%xmm14

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm10 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pxor  <xmm6=%xmm6,<xmm10=%xmm10
pxor  %xmm6,%xmm10

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm2 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:     xmm1 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm1=int6464#2
# asm 2: pxor  <xmm13=%xmm13,<xmm1=%xmm1
pxor  %xmm13,%xmm1

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#5
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm4
pxor  %xmm14,%xmm4

# qhasm:     xmm5 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm5=int6464#6
# asm 2: pxor  <xmm11=%xmm11,<xmm5=%xmm5
pxor  %xmm11,%xmm5

# qhasm:     xmm3 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm3=int6464#4
# asm 2: pxor  <xmm13=%xmm13,<xmm3=%xmm3
pxor  %xmm13,%xmm3

# qhasm:     xmm6 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm6=int6464#7
# asm 2: pxor  <xmm15=%xmm15,<xmm6=%xmm6
pxor  %xmm15,%xmm6

# qhasm:     xmm7 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm7=int6464#8
# asm 2: pxor  <xmm10=%xmm10,<xmm7=%xmm7
pxor  %xmm10,%xmm7

# qhasm:     xmm4 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm4=int6464#5
# asm 2: pxor  <xmm13=%xmm13,<xmm4=%xmm4
pxor  %xmm13,%xmm4

# qhasm:     xmm8 = shuffle dwords of xmm8 by 0x4E
# asm 1: pshufd $0x4E,<xmm8=int6464#9,>xmm8=int6464#9
# asm 2: pshufd $0x4E,<xmm8=%xmm8,>xmm8=%xmm8
pshufd $0x4E,%xmm8,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm9 by 0x4E
# asm 1: pshufd $0x4E,<xmm9=int6464#10,>xmm9=int6464#10
# asm 2: pshufd $0x4E,<xmm9=%xmm9,>xmm9=%xmm9
pshufd $0x4E,%xmm9,%xmm9

# qhasm:     xmm12 = shuffle dwords of xmm12 by 0x4E
# asm 1: pshufd $0x4E,<xmm12=int6464#13,>xmm12=int6464#13
# asm 2: pshufd $0x4E,<xmm12=%xmm12,>xmm12=%xmm12
pshufd $0x4E,%xmm12,%xmm12

# qhasm:     xmm14 = shuffle dwords of xmm14 by 0x4E
# asm 1: pshufd $0x4E,<xmm14=int6464#15,>xmm14=int6464#15
# asm 2: pshufd $0x4E,<xmm14=%xmm14,>xmm14=%xmm14
pshufd $0x4E,%xmm14,%xmm14

# qhasm:     xmm11 = shuffle dwords of xmm11 by 0x4E
# asm 1: pshufd $0x4E,<xmm11=int6464#12,>xmm11=int6464#12
# asm 2: pshufd $0x4E,<xmm11=%xmm11,>xmm11=%xmm11
pshufd $0x4E,%xmm11,%xmm11

# qhasm:     xmm15 = shuffle dwords of xmm15 by 0x4E
# asm 1: pshufd $0x4E,<xmm15=int6464#16,>xmm15=int6464#16
# asm 2: pshufd $0x4E,<xmm15=%xmm15,>xmm15=%xmm15
pshufd $0x4E,%xmm15,%xmm15

# qhasm:     xmm10 = shuffle dwords of xmm10 by 0x4E
# asm 1: pshufd $0x4E,<xmm10=int6464#11,>xmm10=int6464#11
# asm 2: pshufd $0x4E,<xmm10=%xmm10,>xmm10=%xmm10
pshufd $0x4E,%xmm10,%xmm10

# qhasm:     xmm13 = shuffle dwords of xmm13 by 0x4E
# asm 1: pshufd $0x4E,<xmm13=int6464#14,>xmm13=int6464#14
# asm 2: pshufd $0x4E,<xmm13=%xmm13,>xmm13=%xmm13
pshufd $0x4E,%xmm13,%xmm13

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm2 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pxor  <xmm12=%xmm12,<xmm2=%xmm2
pxor  %xmm12,%xmm2

# qhasm:     xmm3 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm3=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm3=%xmm3
pxor  %xmm14,%xmm3

# qhasm:     xmm4 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm4=int6464#5
# asm 2: pxor  <xmm11=%xmm11,<xmm4=%xmm4
pxor  %xmm11,%xmm4

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm6 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm6=int6464#7
# asm 2: pxor  <xmm10=%xmm10,<xmm6=%xmm6
pxor  %xmm10,%xmm6

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm0 ^= *(int128 *)(c + 512)
# asm 1: pxor 512(<c=int64#2),<xmm0=int6464#1
# asm 2: pxor 512(<c=%rsi),<xmm0=%xmm0
pxor 512(%rsi),%xmm0

# qhasm:     shuffle bytes of xmm0 by SR
# asm 1: pshufb SR,<xmm0=int6464#1
# asm 2: pshufb SR,<xmm0=%xmm0
pshufb SR,%xmm0

# qhasm:     xmm1 ^= *(int128 *)(c + 528)
# asm 1: pxor 528(<c=int64#2),<xmm1=int6464#2
# asm 2: pxor 528(<c=%rsi),<xmm1=%xmm1
pxor 528(%rsi),%xmm1

# qhasm:     shuffle bytes of xmm1 by SR
# asm 1: pshufb SR,<xmm1=int6464#2
# asm 2: pshufb SR,<xmm1=%xmm1
pshufb SR,%xmm1

# qhasm:     xmm2 ^= *(int128 *)(c + 544)
# asm 1: pxor 544(<c=int64#2),<xmm2=int6464#3
# asm 2: pxor 544(<c=%rsi),<xmm2=%xmm2
pxor 544(%rsi),%xmm2

# qhasm:     shuffle bytes of xmm2 by SR
# asm 1: pshufb SR,<xmm2=int6464#3
# asm 2: pshufb SR,<xmm2=%xmm2
pshufb SR,%xmm2

# qhasm:     xmm3 ^= *(int128 *)(c + 560)
# asm 1: pxor 560(<c=int64#2),<xmm3=int6464#4
# asm 2: pxor 560(<c=%rsi),<xmm3=%xmm3
pxor 560(%rsi),%xmm3

# qhasm:     shuffle bytes of xmm3 by SR
# asm 1: pshufb SR,<xmm3=int6464#4
# asm 2: pshufb SR,<xmm3=%xmm3
pshufb SR,%xmm3

# qhasm:     xmm4 ^= *(int128 *)(c + 576)
# asm 1: pxor 576(<c=int64#2),<xmm4=int6464#5
# asm 2: pxor 576(<c=%rsi),<xmm4=%xmm4
pxor 576(%rsi),%xmm4

# qhasm:     shuffle bytes of xmm4 by SR
# asm 1: pshufb SR,<xmm4=int6464#5
# asm 2: pshufb SR,<xmm4=%xmm4
pshufb SR,%xmm4

# qhasm:     xmm5 ^= *(int128 *)(c + 592)
# asm 1: pxor 592(<c=int64#2),<xmm5=int6464#6
# asm 2: pxor 592(<c=%rsi),<xmm5=%xmm5
pxor 592(%rsi),%xmm5

# qhasm:     shuffle bytes of xmm5 by SR
# asm 1: pshufb SR,<xmm5=int6464#6
# asm 2: pshufb SR,<xmm5=%xmm5
pshufb SR,%xmm5

# qhasm:     xmm6 ^= *(int128 *)(c + 608)
# asm 1: pxor 608(<c=int64#2),<xmm6=int6464#7
# asm 2: pxor 608(<c=%rsi),<xmm6=%xmm6
pxor 608(%rsi),%xmm6

# qhasm:     shuffle bytes of xmm6 by SR
# asm 1: pshufb SR,<xmm6=int6464#7
# asm 2: pshufb SR,<xmm6=%xmm6
pshufb SR,%xmm6

# qhasm:     xmm7 ^= *(int128 *)(c + 624)
# asm 1: pxor 624(<c=int64#2),<xmm7=int6464#8
# asm 2: pxor 624(<c=%rsi),<xmm7=%xmm7
pxor 624(%rsi),%xmm7

# qhasm:     shuffle bytes of xmm7 by SR
# asm 1: pshufb SR,<xmm7=int6464#8
# asm 2: pshufb SR,<xmm7=%xmm7
pshufb SR,%xmm7

# qhasm:       xmm5 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm5=int6464#6
# asm 2: pxor  <xmm6=%xmm6,<xmm5=%xmm5
pxor  %xmm6,%xmm5

# qhasm:       xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm1,<xmm2=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm5=int6464#6
# asm 2: pxor  <xmm0=%xmm0,<xmm5=%xmm5
pxor  %xmm0,%xmm5

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm6=int6464#7
# asm 2: pxor  <xmm2=%xmm2,<xmm6=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm3=int6464#4
# asm 2: pxor  <xmm0=%xmm0,<xmm3=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#4
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm3
pxor  %xmm7,%xmm3

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm3=int6464#4
# asm 2: pxor  <xmm4=%xmm4,<xmm3=%xmm3
pxor  %xmm4,%xmm3

# qhasm:       xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm7=int6464#8
# asm 2: pxor  <xmm5=%xmm5,<xmm7=%xmm7
pxor  %xmm5,%xmm7

# qhasm:       xmm3 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm3=int6464#4
# asm 2: pxor  <xmm1=%xmm1,<xmm3=%xmm3
pxor  %xmm1,%xmm3

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm2=int6464#3
# asm 2: pxor  <xmm7=%xmm7,<xmm2=%xmm2
pxor  %xmm7,%xmm2

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm11 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm11=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm11=%xmm8
movdqa %xmm7,%xmm8

# qhasm:       xmm10 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm10=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm10=%xmm9
movdqa %xmm1,%xmm9

# qhasm:       xmm9 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm9=int6464#11
# asm 2: movdqa <xmm5=%xmm5,>xmm9=%xmm10
movdqa %xmm5,%xmm10

# qhasm:       xmm13 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm13=int6464#12
# asm 2: movdqa <xmm2=%xmm2,>xmm13=%xmm11
movdqa %xmm2,%xmm11

# qhasm:       xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#13
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm12
movdqa %xmm6,%xmm12

# qhasm:       xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm9
pxor  %xmm2,%xmm9

# qhasm:       xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm9=int6464#11
# asm 2: pxor  <xmm3=%xmm3,<xmm9=%xmm10
pxor  %xmm3,%xmm10

# qhasm:       xmm13 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm13=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm13=%xmm11
pxor  %xmm4,%xmm11

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:       xmm14 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm14=int6464#14
# asm 2: movdqa <xmm11=%xmm8,>xmm14=%xmm13
movdqa %xmm8,%xmm13

# qhasm:       xmm8 = xmm10
# asm 1: movdqa <xmm10=int6464#10,>xmm8=int6464#15
# asm 2: movdqa <xmm10=%xmm9,>xmm8=%xmm14
movdqa %xmm9,%xmm14

# qhasm:       xmm15 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm15=int6464#16
# asm 2: movdqa <xmm11=%xmm8,>xmm15=%xmm15
movdqa %xmm8,%xmm15

# qhasm:       xmm10 |= xmm9
# asm 1: por   <xmm9=int6464#11,<xmm10=int6464#10
# asm 2: por   <xmm9=%xmm10,<xmm10=%xmm9
por   %xmm10,%xmm9

# qhasm:       xmm11 |= xmm12
# asm 1: por   <xmm12=int6464#13,<xmm11=int6464#9
# asm 2: por   <xmm12=%xmm12,<xmm11=%xmm8
por   %xmm12,%xmm8

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm15=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm14 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm14=int6464#14
# asm 2: pand  <xmm12=%xmm12,<xmm14=%xmm13
pand  %xmm12,%xmm13

# qhasm:       xmm8 &= xmm9
# asm 1: pand  <xmm9=int6464#11,<xmm8=int6464#15
# asm 2: pand  <xmm9=%xmm10,<xmm8=%xmm14
pand  %xmm10,%xmm14

# qhasm:       xmm12 ^= xmm9
# asm 1: pxor  <xmm9=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm9=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:       xmm15 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm15=int6464#16
# asm 2: pand  <xmm12=%xmm12,<xmm15=%xmm15
pand  %xmm12,%xmm15

# qhasm:       xmm12 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm12=int6464#11
# asm 2: movdqa <xmm3=%xmm3,>xmm12=%xmm10
movdqa %xmm3,%xmm10

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm10
pxor  %xmm0,%xmm10

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#11,<xmm13=int6464#12
# asm 2: pand  <xmm12=%xmm10,<xmm13=%xmm11
pand  %xmm10,%xmm11

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm11=int6464#9
# asm 2: pxor  <xmm13=%xmm11,<xmm11=%xmm8
pxor  %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm13 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm13=int6464#11
# asm 2: movdqa <xmm7=%xmm7,>xmm13=%xmm10
movdqa %xmm7,%xmm10

# qhasm:       xmm13 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm13=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm13=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm12 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm12=int6464#12
# asm 2: movdqa <xmm5=%xmm5,>xmm12=%xmm11
movdqa %xmm5,%xmm11

# qhasm:       xmm9 = xmm13
# asm 1: movdqa <xmm13=int6464#11,>xmm9=int6464#13
# asm 2: movdqa <xmm13=%xmm10,>xmm9=%xmm12
movdqa %xmm10,%xmm12

# qhasm:       xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm11
pxor  %xmm6,%xmm11

# qhasm:       xmm9 |= xmm12
# asm 1: por   <xmm12=int6464#12,<xmm9=int6464#13
# asm 2: por   <xmm12=%xmm11,<xmm9=%xmm12
por   %xmm11,%xmm12

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#12,<xmm13=int6464#11
# asm 2: pand  <xmm12=%xmm11,<xmm13=%xmm10
pand  %xmm11,%xmm10

# qhasm:       xmm8 ^= xmm13
# asm 1: pxor  <xmm13=int6464#11,<xmm8=int6464#15
# asm 2: pxor  <xmm13=%xmm10,<xmm8=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#9
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm10=int6464#10
# asm 2: pxor  <xmm14=%xmm13,<xmm10=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm9 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm8 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm8=int6464#15
# asm 2: pxor  <xmm14=%xmm13,<xmm8=%xmm14
pxor  %xmm13,%xmm14

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm12 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm12=int6464#11
# asm 2: movdqa <xmm2=%xmm2,>xmm12=%xmm10
movdqa %xmm2,%xmm10

# qhasm:       xmm13 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm13=int6464#12
# asm 2: movdqa <xmm4=%xmm4,>xmm13=%xmm11
movdqa %xmm4,%xmm11

# qhasm:       xmm14 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm14=int6464#14
# asm 2: movdqa <xmm1=%xmm1,>xmm14=%xmm13
movdqa %xmm1,%xmm13

# qhasm:       xmm15 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm15=int6464#16
# asm 2: movdqa <xmm7=%xmm7,>xmm15=%xmm15
movdqa %xmm7,%xmm15

# qhasm:       xmm12 &= xmm3
# asm 1: pand  <xmm3=int6464#4,<xmm12=int6464#11
# asm 2: pand  <xmm3=%xmm3,<xmm12=%xmm10
pand  %xmm3,%xmm10

# qhasm:       xmm13 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm13=int6464#12
# asm 2: pand  <xmm0=%xmm0,<xmm13=%xmm11
pand  %xmm0,%xmm11

# qhasm:       xmm14 &= xmm5
# asm 1: pand  <xmm5=int6464#6,<xmm14=int6464#14
# asm 2: pand  <xmm5=%xmm5,<xmm14=%xmm13
pand  %xmm5,%xmm13

# qhasm:       xmm15 |= xmm6
# asm 1: por   <xmm6=int6464#7,<xmm15=int6464#16
# asm 2: por   <xmm6=%xmm6,<xmm15=%xmm15
por   %xmm6,%xmm15

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm11=int6464#9
# asm 2: pxor  <xmm12=%xmm10,<xmm11=%xmm8
pxor  %xmm10,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm8 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm8=int6464#15
# asm 2: pxor  <xmm15=%xmm15,<xmm8=%xmm14
pxor  %xmm15,%xmm14

# qhasm:       xmm12 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm12=int6464#11
# asm 2: movdqa <xmm11=%xmm8,>xmm12=%xmm10
movdqa %xmm8,%xmm10

# qhasm:       xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm12=int6464#11
# asm 2: pxor  <xmm10=%xmm9,<xmm12=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm11 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm11=int6464#9
# asm 2: pand  <xmm9=%xmm12,<xmm11=%xmm8
pand  %xmm12,%xmm8

# qhasm:       xmm14 = xmm8
# asm 1: movdqa <xmm8=int6464#15,>xmm14=int6464#12
# asm 2: movdqa <xmm8=%xmm14,>xmm14=%xmm11
movdqa %xmm14,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm11=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm15 = xmm12
# asm 1: movdqa <xmm12=int6464#11,>xmm15=int6464#14
# asm 2: movdqa <xmm12=%xmm10,>xmm15=%xmm13
movdqa %xmm10,%xmm13

# qhasm:       xmm15 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm15=int6464#14
# asm 2: pand  <xmm14=%xmm11,<xmm15=%xmm13
pand  %xmm11,%xmm13

# qhasm:       xmm15 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm15=int6464#14
# asm 2: pxor  <xmm10=%xmm9,<xmm15=%xmm13
pxor  %xmm9,%xmm13

# qhasm:       xmm13 = xmm9
# asm 1: movdqa <xmm9=int6464#13,>xmm13=int6464#16
# asm 2: movdqa <xmm9=%xmm12,>xmm13=%xmm15
movdqa %xmm12,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm11 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm11=int6464#9
# asm 2: pxor  <xmm10=%xmm9,<xmm11=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm13 &= xmm11
# asm 1: pand  <xmm11=int6464#9,<xmm13=int6464#16
# asm 2: pand  <xmm11=%xmm8,<xmm13=%xmm15
pand  %xmm8,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm13=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm10 = xmm14
# asm 1: movdqa <xmm14=int6464#12,>xmm10=int6464#9
# asm 2: movdqa <xmm14=%xmm11,>xmm10=%xmm8
movdqa %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm10=int6464#9
# asm 2: pxor  <xmm13=%xmm15,<xmm10=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 &= xmm8
# asm 1: pand  <xmm8=int6464#15,<xmm10=int6464#9
# asm 2: pand  <xmm8=%xmm14,<xmm10=%xmm8
pand  %xmm14,%xmm8

# qhasm:       xmm9 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm9=int6464#13
# asm 2: pxor  <xmm10=%xmm8,<xmm9=%xmm12
pxor  %xmm8,%xmm12

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm10=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm14=int6464#12
# asm 2: pand  <xmm15=%xmm13,<xmm14=%xmm11
pand  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm14=int6464#12
# asm 2: pxor  <xmm12=%xmm10,<xmm14=%xmm11
pxor  %xmm10,%xmm11

# qhasm:         xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm8
movdqa %xmm6,%xmm8

# qhasm:         xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#10
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm9
movdqa %xmm5,%xmm9

# qhasm:           xmm10 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm10=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm10=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm10 &= xmm6
# asm 1: pand  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pand  <xmm6=%xmm6,<xmm10=%xmm10
pand  %xmm6,%xmm10

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm6 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm6=int6464#7
# asm 2: pand  <xmm14=%xmm11,<xmm6=%xmm6
pand  %xmm11,%xmm6

# qhasm:           xmm5 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm5=int6464#6
# asm 2: pand  <xmm15=%xmm13,<xmm5=%xmm5
pand  %xmm13,%xmm5

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm5 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm5=int6464#6
# asm 2: pxor  <xmm10=%xmm10,<xmm5=%xmm5
pxor  %xmm10,%xmm5

# qhasm:         xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#10
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm9
pxor  %xmm3,%xmm9

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pand  <xmm0=%xmm0,<xmm10=%xmm10
pand  %xmm0,%xmm10

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm0=int6464#1
# asm 2: pand  <xmm9=%xmm12,<xmm0=%xmm0
pand  %xmm12,%xmm0

# qhasm:           xmm3 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm3=int6464#4
# asm 2: pand  <xmm13=%xmm15,<xmm3=%xmm3
pand  %xmm15,%xmm3

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm3 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm3=int6464#4
# asm 2: pxor  <xmm10=%xmm10,<xmm3=%xmm3
pxor  %xmm10,%xmm3

# qhasm:         xmm6 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm12=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:         xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm9,<xmm5=%xmm5
pxor  %xmm9,%xmm5

# qhasm:         xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm9,<xmm3=%xmm3
pxor  %xmm9,%xmm3

# qhasm:         xmm12 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm12=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm12=%xmm8
movdqa %xmm7,%xmm8

# qhasm:         xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm9
movdqa %xmm1,%xmm9

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm12=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm12=%xmm8
pxor  %xmm4,%xmm8

# qhasm:         xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm9
pxor  %xmm2,%xmm9

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pand  <xmm4=%xmm4,<xmm10=%xmm10
pand  %xmm4,%xmm10

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm4 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm4=int6464#5
# asm 2: pand  <xmm9=%xmm12,<xmm4=%xmm4
pand  %xmm12,%xmm4

# qhasm:           xmm2 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm2=int6464#3
# asm 2: pand  <xmm13=%xmm15,<xmm2=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#3
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm2
pxor  %xmm10,%xmm2

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm7
# asm 1: pand  <xmm7=int6464#8,<xmm11=int6464#11
# asm 2: pand  <xmm7=%xmm7,<xmm11=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm7 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm7=int6464#8
# asm 2: pand  <xmm14=%xmm11,<xmm7=%xmm7
pand  %xmm11,%xmm7

# qhasm:           xmm1 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm1=int6464#2
# asm 2: pand  <xmm15=%xmm13,<xmm1=%xmm1
pand  %xmm13,%xmm1

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm1=int6464#2
# asm 2: pxor  <xmm11=%xmm10,<xmm1=%xmm1
pxor  %xmm10,%xmm1

# qhasm:         xmm7 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm12=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm12=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:         xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:         xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm0,<xmm7=%xmm7
pxor  %xmm0,%xmm7

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm1=int6464#2
# asm 2: pxor  <xmm6=%xmm6,<xmm1=%xmm1
pxor  %xmm6,%xmm1

# qhasm:       xmm4 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm4=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm4=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm6 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm6=int6464#7
# asm 2: pxor  <xmm0=%xmm0,<xmm6=%xmm6
pxor  %xmm0,%xmm6

# qhasm:       xmm0 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm0=int6464#1
# asm 2: pxor  <xmm1=%xmm1,<xmm0=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm5 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm5=int6464#6
# asm 2: pxor  <xmm2=%xmm2,<xmm5=%xmm5
pxor  %xmm2,%xmm5

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm3=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm3=int6464#4
# asm 2: pxor  <xmm5=%xmm5,<xmm3=%xmm3
pxor  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:     xmm8 = shuffle dwords of xmm0 by 0x93
# asm 1: pshufd $0x93,<xmm0=int6464#1,>xmm8=int6464#9
# asm 2: pshufd $0x93,<xmm0=%xmm0,>xmm8=%xmm8
pshufd $0x93,%xmm0,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm1 by 0x93
# asm 1: pshufd $0x93,<xmm1=int6464#2,>xmm9=int6464#10
# asm 2: pshufd $0x93,<xmm1=%xmm1,>xmm9=%xmm9
pshufd $0x93,%xmm1,%xmm9

# qhasm:     xmm10 = shuffle dwords of xmm4 by 0x93
# asm 1: pshufd $0x93,<xmm4=int6464#5,>xmm10=int6464#11
# asm 2: pshufd $0x93,<xmm4=%xmm4,>xmm10=%xmm10
pshufd $0x93,%xmm4,%xmm10

# qhasm:     xmm11 = shuffle dwords of xmm6 by 0x93
# asm 1: pshufd $0x93,<xmm6=int6464#7,>xmm11=int6464#12
# asm 2: pshufd $0x93,<xmm6=%xmm6,>xmm11=%xmm11
pshufd $0x93,%xmm6,%xmm11

# qhasm:     xmm12 = shuffle dwords of xmm3 by 0x93
# asm 1: pshufd $0x93,<xmm3=int6464#4,>xmm12=int6464#13
# asm 2: pshufd $0x93,<xmm3=%xmm3,>xmm12=%xmm12
pshufd $0x93,%xmm3,%xmm12

# qhasm:     xmm13 = shuffle dwords of xmm7 by 0x93
# asm 1: pshufd $0x93,<xmm7=int6464#8,>xmm13=int6464#14
# asm 2: pshufd $0x93,<xmm7=%xmm7,>xmm13=%xmm13
pshufd $0x93,%xmm7,%xmm13

# qhasm:     xmm14 = shuffle dwords of xmm2 by 0x93
# asm 1: pshufd $0x93,<xmm2=int6464#3,>xmm14=int6464#15
# asm 2: pshufd $0x93,<xmm2=%xmm2,>xmm14=%xmm14
pshufd $0x93,%xmm2,%xmm14

# qhasm:     xmm15 = shuffle dwords of xmm5 by 0x93
# asm 1: pshufd $0x93,<xmm5=int6464#6,>xmm15=int6464#16
# asm 2: pshufd $0x93,<xmm5=%xmm5,>xmm15=%xmm15
pshufd $0x93,%xmm5,%xmm15

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm4 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm4=int6464#5
# asm 2: pxor  <xmm10=%xmm10,<xmm4=%xmm4
pxor  %xmm10,%xmm4

# qhasm:     xmm6 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm6=int6464#7
# asm 2: pxor  <xmm11=%xmm11,<xmm6=%xmm6
pxor  %xmm11,%xmm6

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm2 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pxor  <xmm14=%xmm14,<xmm2=%xmm2
pxor  %xmm14,%xmm2

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm10 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:     xmm9 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm9=int6464#10
# asm 2: pxor  <xmm5=%xmm5,<xmm9=%xmm9
pxor  %xmm5,%xmm9

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#13
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm12
pxor  %xmm6,%xmm12

# qhasm:     xmm13 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm13=int6464#14
# asm 2: pxor  <xmm3=%xmm3,<xmm13=%xmm13
pxor  %xmm3,%xmm13

# qhasm:     xmm11 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm11=int6464#12
# asm 2: pxor  <xmm5=%xmm5,<xmm11=%xmm11
pxor  %xmm5,%xmm11

# qhasm:     xmm14 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm14=int6464#15
# asm 2: pxor  <xmm7=%xmm7,<xmm14=%xmm14
pxor  %xmm7,%xmm14

# qhasm:     xmm15 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm15=int6464#16
# asm 2: pxor  <xmm2=%xmm2,<xmm15=%xmm15
pxor  %xmm2,%xmm15

# qhasm:     xmm12 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm12=int6464#13
# asm 2: pxor  <xmm5=%xmm5,<xmm12=%xmm12
pxor  %xmm5,%xmm12

# qhasm:     xmm0 = shuffle dwords of xmm0 by 0x4E
# asm 1: pshufd $0x4E,<xmm0=int6464#1,>xmm0=int6464#1
# asm 2: pshufd $0x4E,<xmm0=%xmm0,>xmm0=%xmm0
pshufd $0x4E,%xmm0,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm1 by 0x4E
# asm 1: pshufd $0x4E,<xmm1=int6464#2,>xmm1=int6464#2
# asm 2: pshufd $0x4E,<xmm1=%xmm1,>xmm1=%xmm1
pshufd $0x4E,%xmm1,%xmm1

# qhasm:     xmm4 = shuffle dwords of xmm4 by 0x4E
# asm 1: pshufd $0x4E,<xmm4=int6464#5,>xmm4=int6464#5
# asm 2: pshufd $0x4E,<xmm4=%xmm4,>xmm4=%xmm4
pshufd $0x4E,%xmm4,%xmm4

# qhasm:     xmm6 = shuffle dwords of xmm6 by 0x4E
# asm 1: pshufd $0x4E,<xmm6=int6464#7,>xmm6=int6464#7
# asm 2: pshufd $0x4E,<xmm6=%xmm6,>xmm6=%xmm6
pshufd $0x4E,%xmm6,%xmm6

# qhasm:     xmm3 = shuffle dwords of xmm3 by 0x4E
# asm 1: pshufd $0x4E,<xmm3=int6464#4,>xmm3=int6464#4
# asm 2: pshufd $0x4E,<xmm3=%xmm3,>xmm3=%xmm3
pshufd $0x4E,%xmm3,%xmm3

# qhasm:     xmm7 = shuffle dwords of xmm7 by 0x4E
# asm 1: pshufd $0x4E,<xmm7=int6464#8,>xmm7=int6464#8
# asm 2: pshufd $0x4E,<xmm7=%xmm7,>xmm7=%xmm7
pshufd $0x4E,%xmm7,%xmm7

# qhasm:     xmm2 = shuffle dwords of xmm2 by 0x4E
# asm 1: pshufd $0x4E,<xmm2=int6464#3,>xmm2=int6464#3
# asm 2: pshufd $0x4E,<xmm2=%xmm2,>xmm2=%xmm2
pshufd $0x4E,%xmm2,%xmm2

# qhasm:     xmm5 = shuffle dwords of xmm5 by 0x4E
# asm 1: pshufd $0x4E,<xmm5=int6464#6,>xmm5=int6464#6
# asm 2: pshufd $0x4E,<xmm5=%xmm5,>xmm5=%xmm5
pshufd $0x4E,%xmm5,%xmm5

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm10 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pxor  <xmm4=%xmm4,<xmm10=%xmm10
pxor  %xmm4,%xmm10

# qhasm:     xmm11 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm11=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm11=%xmm11
pxor  %xmm6,%xmm11

# qhasm:     xmm12 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm12=int6464#13
# asm 2: pxor  <xmm3=%xmm3,<xmm12=%xmm12
pxor  %xmm3,%xmm12

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm14 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm14=int6464#15
# asm 2: pxor  <xmm2=%xmm2,<xmm14=%xmm14
pxor  %xmm2,%xmm14

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm8 ^= *(int128 *)(c + 640)
# asm 1: pxor 640(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 640(<c=%rsi),<xmm8=%xmm8
pxor 640(%rsi),%xmm8

# qhasm:     shuffle bytes of xmm8 by SR
# asm 1: pshufb SR,<xmm8=int6464#9
# asm 2: pshufb SR,<xmm8=%xmm8
pshufb SR,%xmm8

# qhasm:     xmm9 ^= *(int128 *)(c + 656)
# asm 1: pxor 656(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 656(<c=%rsi),<xmm9=%xmm9
pxor 656(%rsi),%xmm9

# qhasm:     shuffle bytes of xmm9 by SR
# asm 1: pshufb SR,<xmm9=int6464#10
# asm 2: pshufb SR,<xmm9=%xmm9
pshufb SR,%xmm9

# qhasm:     xmm10 ^= *(int128 *)(c + 672)
# asm 1: pxor 672(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 672(<c=%rsi),<xmm10=%xmm10
pxor 672(%rsi),%xmm10

# qhasm:     shuffle bytes of xmm10 by SR
# asm 1: pshufb SR,<xmm10=int6464#11
# asm 2: pshufb SR,<xmm10=%xmm10
pshufb SR,%xmm10

# qhasm:     xmm11 ^= *(int128 *)(c + 688)
# asm 1: pxor 688(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 688(<c=%rsi),<xmm11=%xmm11
pxor 688(%rsi),%xmm11

# qhasm:     shuffle bytes of xmm11 by SR
# asm 1: pshufb SR,<xmm11=int6464#12
# asm 2: pshufb SR,<xmm11=%xmm11
pshufb SR,%xmm11

# qhasm:     xmm12 ^= *(int128 *)(c + 704)
# asm 1: pxor 704(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 704(<c=%rsi),<xmm12=%xmm12
pxor 704(%rsi),%xmm12

# qhasm:     shuffle bytes of xmm12 by SR
# asm 1: pshufb SR,<xmm12=int6464#13
# asm 2: pshufb SR,<xmm12=%xmm12
pshufb SR,%xmm12

# qhasm:     xmm13 ^= *(int128 *)(c + 720)
# asm 1: pxor 720(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 720(<c=%rsi),<xmm13=%xmm13
pxor 720(%rsi),%xmm13

# qhasm:     shuffle bytes of xmm13 by SR
# asm 1: pshufb SR,<xmm13=int6464#14
# asm 2: pshufb SR,<xmm13=%xmm13
pshufb SR,%xmm13

# qhasm:     xmm14 ^= *(int128 *)(c + 736)
# asm 1: pxor 736(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 736(<c=%rsi),<xmm14=%xmm14
pxor 736(%rsi),%xmm14

# qhasm:     shuffle bytes of xmm14 by SR
# asm 1: pshufb SR,<xmm14=int6464#15
# asm 2: pshufb SR,<xmm14=%xmm14
pshufb SR,%xmm14

# qhasm:     xmm15 ^= *(int128 *)(c + 752)
# asm 1: pxor 752(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 752(<c=%rsi),<xmm15=%xmm15
pxor 752(%rsi),%xmm15

# qhasm:     shuffle bytes of xmm15 by SR
# asm 1: pshufb SR,<xmm15=int6464#16
# asm 2: pshufb SR,<xmm15=%xmm15
pshufb SR,%xmm15

# qhasm:       xmm13 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm13=int6464#14
# asm 2: pxor  <xmm14=%xmm14,<xmm13=%xmm13
pxor  %xmm14,%xmm13

# qhasm:       xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm9,<xmm10=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm13=int6464#14
# asm 2: pxor  <xmm8=%xmm8,<xmm13=%xmm13
pxor  %xmm8,%xmm13

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm14=int6464#15
# asm 2: pxor  <xmm10=%xmm10,<xmm14=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm11=int6464#12
# asm 2: pxor  <xmm8=%xmm8,<xmm11=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#12
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm11
pxor  %xmm15,%xmm11

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm11=int6464#12
# asm 2: pxor  <xmm12=%xmm12,<xmm11=%xmm11
pxor  %xmm12,%xmm11

# qhasm:       xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm15=int6464#16
# asm 2: pxor  <xmm13=%xmm13,<xmm15=%xmm15
pxor  %xmm13,%xmm15

# qhasm:       xmm11 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm11=int6464#12
# asm 2: pxor  <xmm9=%xmm9,<xmm11=%xmm11
pxor  %xmm9,%xmm11

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm10=int6464#11
# asm 2: pxor  <xmm15=%xmm15,<xmm10=%xmm10
pxor  %xmm15,%xmm10

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm3 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm3=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm3=%xmm0
movdqa %xmm15,%xmm0

# qhasm:       xmm2 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm2=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm2=%xmm1
movdqa %xmm9,%xmm1

# qhasm:       xmm1 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm1=int6464#3
# asm 2: movdqa <xmm13=%xmm13,>xmm1=%xmm2
movdqa %xmm13,%xmm2

# qhasm:       xmm5 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm5=int6464#4
# asm 2: movdqa <xmm10=%xmm10,>xmm5=%xmm3
movdqa %xmm10,%xmm3

# qhasm:       xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#5
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm4
movdqa %xmm14,%xmm4

# qhasm:       xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm0
pxor  %xmm12,%xmm0

# qhasm:       xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm1
pxor  %xmm10,%xmm1

# qhasm:       xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm1=int6464#3
# asm 2: pxor  <xmm11=%xmm11,<xmm1=%xmm2
pxor  %xmm11,%xmm2

# qhasm:       xmm5 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm5=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm5=%xmm3
pxor  %xmm12,%xmm3

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       xmm6 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm6=int6464#6
# asm 2: movdqa <xmm3=%xmm0,>xmm6=%xmm5
movdqa %xmm0,%xmm5

# qhasm:       xmm0 = xmm2
# asm 1: movdqa <xmm2=int6464#2,>xmm0=int6464#7
# asm 2: movdqa <xmm2=%xmm1,>xmm0=%xmm6
movdqa %xmm1,%xmm6

# qhasm:       xmm7 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm3=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       xmm2 |= xmm1
# asm 1: por   <xmm1=int6464#3,<xmm2=int6464#2
# asm 2: por   <xmm1=%xmm2,<xmm2=%xmm1
por   %xmm2,%xmm1

# qhasm:       xmm3 |= xmm4
# asm 1: por   <xmm4=int6464#5,<xmm3=int6464#1
# asm 2: por   <xmm4=%xmm4,<xmm3=%xmm0
por   %xmm4,%xmm0

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm7=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm6 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm6=int6464#6
# asm 2: pand  <xmm4=%xmm4,<xmm6=%xmm5
pand  %xmm4,%xmm5

# qhasm:       xmm0 &= xmm1
# asm 1: pand  <xmm1=int6464#3,<xmm0=int6464#7
# asm 2: pand  <xmm1=%xmm2,<xmm0=%xmm6
pand  %xmm2,%xmm6

# qhasm:       xmm4 ^= xmm1
# asm 1: pxor  <xmm1=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm1=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:       xmm7 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm7=int6464#8
# asm 2: pand  <xmm4=%xmm4,<xmm7=%xmm7
pand  %xmm4,%xmm7

# qhasm:       xmm4 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm4=int6464#3
# asm 2: movdqa <xmm11=%xmm11,>xmm4=%xmm2
movdqa %xmm11,%xmm2

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#3,<xmm5=int6464#4
# asm 2: pand  <xmm4=%xmm2,<xmm5=%xmm3
pand  %xmm2,%xmm3

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm3=int6464#1
# asm 2: pxor  <xmm5=%xmm3,<xmm3=%xmm0
pxor  %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm5 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm5=int6464#3
# asm 2: movdqa <xmm15=%xmm15,>xmm5=%xmm2
movdqa %xmm15,%xmm2

# qhasm:       xmm5 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm5=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm5=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm4 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm4=int6464#4
# asm 2: movdqa <xmm13=%xmm13,>xmm4=%xmm3
movdqa %xmm13,%xmm3

# qhasm:       xmm1 = xmm5
# asm 1: movdqa <xmm5=int6464#3,>xmm1=int6464#5
# asm 2: movdqa <xmm5=%xmm2,>xmm1=%xmm4
movdqa %xmm2,%xmm4

# qhasm:       xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm3
pxor  %xmm14,%xmm3

# qhasm:       xmm1 |= xmm4
# asm 1: por   <xmm4=int6464#4,<xmm1=int6464#5
# asm 2: por   <xmm4=%xmm3,<xmm1=%xmm4
por   %xmm3,%xmm4

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#4,<xmm5=int6464#3
# asm 2: pand  <xmm4=%xmm3,<xmm5=%xmm2
pand  %xmm3,%xmm2

# qhasm:       xmm0 ^= xmm5
# asm 1: pxor  <xmm5=int6464#3,<xmm0=int6464#7
# asm 2: pxor  <xmm5=%xmm2,<xmm0=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#1
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm2=int6464#2
# asm 2: pxor  <xmm6=%xmm5,<xmm2=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm1 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm0 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm0=int6464#7
# asm 2: pxor  <xmm6=%xmm5,<xmm0=%xmm6
pxor  %xmm5,%xmm6

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm4 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm4=int6464#3
# asm 2: movdqa <xmm10=%xmm10,>xmm4=%xmm2
movdqa %xmm10,%xmm2

# qhasm:       xmm5 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm5=int6464#4
# asm 2: movdqa <xmm12=%xmm12,>xmm5=%xmm3
movdqa %xmm12,%xmm3

# qhasm:       xmm6 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm6=int6464#6
# asm 2: movdqa <xmm9=%xmm9,>xmm6=%xmm5
movdqa %xmm9,%xmm5

# qhasm:       xmm7 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm7=int6464#8
# asm 2: movdqa <xmm15=%xmm15,>xmm7=%xmm7
movdqa %xmm15,%xmm7

# qhasm:       xmm4 &= xmm11
# asm 1: pand  <xmm11=int6464#12,<xmm4=int6464#3
# asm 2: pand  <xmm11=%xmm11,<xmm4=%xmm2
pand  %xmm11,%xmm2

# qhasm:       xmm5 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm5=int6464#4
# asm 2: pand  <xmm8=%xmm8,<xmm5=%xmm3
pand  %xmm8,%xmm3

# qhasm:       xmm6 &= xmm13
# asm 1: pand  <xmm13=int6464#14,<xmm6=int6464#6
# asm 2: pand  <xmm13=%xmm13,<xmm6=%xmm5
pand  %xmm13,%xmm5

# qhasm:       xmm7 |= xmm14
# asm 1: por   <xmm14=int6464#15,<xmm7=int6464#8
# asm 2: por   <xmm14=%xmm14,<xmm7=%xmm7
por   %xmm14,%xmm7

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm3=int6464#1
# asm 2: pxor  <xmm4=%xmm2,<xmm3=%xmm0
pxor  %xmm2,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm0 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm0=int6464#7
# asm 2: pxor  <xmm7=%xmm7,<xmm0=%xmm6
pxor  %xmm7,%xmm6

# qhasm:       xmm4 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm4=int6464#3
# asm 2: movdqa <xmm3=%xmm0,>xmm4=%xmm2
movdqa %xmm0,%xmm2

# qhasm:       xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm4=int6464#3
# asm 2: pxor  <xmm2=%xmm1,<xmm4=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm3 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm3=int6464#1
# asm 2: pand  <xmm1=%xmm4,<xmm3=%xmm0
pand  %xmm4,%xmm0

# qhasm:       xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#7,>xmm6=int6464#4
# asm 2: movdqa <xmm0=%xmm6,>xmm6=%xmm3
movdqa %xmm6,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm3=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm7 = xmm4
# asm 1: movdqa <xmm4=int6464#3,>xmm7=int6464#6
# asm 2: movdqa <xmm4=%xmm2,>xmm7=%xmm5
movdqa %xmm2,%xmm5

# qhasm:       xmm7 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm7=int6464#6
# asm 2: pand  <xmm6=%xmm3,<xmm7=%xmm5
pand  %xmm3,%xmm5

# qhasm:       xmm7 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm7=int6464#6
# asm 2: pxor  <xmm2=%xmm1,<xmm7=%xmm5
pxor  %xmm1,%xmm5

# qhasm:       xmm5 = xmm1
# asm 1: movdqa <xmm1=int6464#5,>xmm5=int6464#8
# asm 2: movdqa <xmm1=%xmm4,>xmm5=%xmm7
movdqa %xmm4,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm3 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm3=int6464#1
# asm 2: pxor  <xmm2=%xmm1,<xmm3=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm5 &= xmm3
# asm 1: pand  <xmm3=int6464#1,<xmm5=int6464#8
# asm 2: pand  <xmm3=%xmm0,<xmm5=%xmm7
pand  %xmm0,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm5=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm2 = xmm6
# asm 1: movdqa <xmm6=int6464#4,>xmm2=int6464#1
# asm 2: movdqa <xmm6=%xmm3,>xmm2=%xmm0
movdqa %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm2=int6464#1
# asm 2: pxor  <xmm5=%xmm7,<xmm2=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 &= xmm0
# asm 1: pand  <xmm0=int6464#7,<xmm2=int6464#1
# asm 2: pand  <xmm0=%xmm6,<xmm2=%xmm0
pand  %xmm6,%xmm0

# qhasm:       xmm1 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm1=int6464#5
# asm 2: pxor  <xmm2=%xmm0,<xmm1=%xmm4
pxor  %xmm0,%xmm4

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm2=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm6=int6464#4
# asm 2: pand  <xmm7=%xmm5,<xmm6=%xmm3
pand  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm6=int6464#4
# asm 2: pxor  <xmm4=%xmm2,<xmm6=%xmm3
pxor  %xmm2,%xmm3

# qhasm:         xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm0
movdqa %xmm14,%xmm0

# qhasm:         xmm0 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm0=int6464#2
# asm 2: movdqa <xmm13=%xmm13,>xmm0=%xmm1
movdqa %xmm13,%xmm1

# qhasm:           xmm2 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm2=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm2=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm2 &= xmm14
# asm 1: pand  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pand  <xmm14=%xmm14,<xmm2=%xmm2
pand  %xmm14,%xmm2

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm14 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm14=int6464#15
# asm 2: pand  <xmm6=%xmm3,<xmm14=%xmm14
pand  %xmm3,%xmm14

# qhasm:           xmm13 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm13=int6464#14
# asm 2: pand  <xmm7=%xmm5,<xmm13=%xmm13
pand  %xmm5,%xmm13

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm13 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm13=int6464#14
# asm 2: pxor  <xmm2=%xmm2,<xmm13=%xmm13
pxor  %xmm2,%xmm13

# qhasm:         xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#2
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm1
pxor  %xmm11,%xmm1

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pand  <xmm8=%xmm8,<xmm2=%xmm2
pand  %xmm8,%xmm2

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm8=int6464#9
# asm 2: pand  <xmm1=%xmm4,<xmm8=%xmm8
pand  %xmm4,%xmm8

# qhasm:           xmm11 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm11=int6464#12
# asm 2: pand  <xmm5=%xmm7,<xmm11=%xmm11
pand  %xmm7,%xmm11

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm11 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm11=int6464#12
# asm 2: pxor  <xmm2=%xmm2,<xmm11=%xmm11
pxor  %xmm2,%xmm11

# qhasm:         xmm14 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm4=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:         xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm1,<xmm13=%xmm13
pxor  %xmm1,%xmm13

# qhasm:         xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm1,<xmm11=%xmm11
pxor  %xmm1,%xmm11

# qhasm:         xmm4 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm4=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm4=%xmm0
movdqa %xmm15,%xmm0

# qhasm:         xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm1
movdqa %xmm9,%xmm1

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm4=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm4=%xmm0
pxor  %xmm12,%xmm0

# qhasm:         xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm1
pxor  %xmm10,%xmm1

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pand  <xmm12=%xmm12,<xmm2=%xmm2
pand  %xmm12,%xmm2

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm12 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm12=int6464#13
# asm 2: pand  <xmm1=%xmm4,<xmm12=%xmm12
pand  %xmm4,%xmm12

# qhasm:           xmm10 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm10=int6464#11
# asm 2: pand  <xmm5=%xmm7,<xmm10=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#11
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm10
pxor  %xmm2,%xmm10

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm15
# asm 1: pand  <xmm15=int6464#16,<xmm3=int6464#3
# asm 2: pand  <xmm15=%xmm15,<xmm3=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm15 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm15=int6464#16
# asm 2: pand  <xmm6=%xmm3,<xmm15=%xmm15
pand  %xmm3,%xmm15

# qhasm:           xmm9 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm9=int6464#10
# asm 2: pand  <xmm7=%xmm5,<xmm9=%xmm9
pand  %xmm5,%xmm9

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm9=int6464#10
# asm 2: pxor  <xmm3=%xmm2,<xmm9=%xmm9
pxor  %xmm2,%xmm9

# qhasm:         xmm15 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm4=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm4=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:         xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:         xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm8,<xmm15=%xmm15
pxor  %xmm8,%xmm15

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm9=int6464#10
# asm 2: pxor  <xmm14=%xmm14,<xmm9=%xmm9
pxor  %xmm14,%xmm9

# qhasm:       xmm12 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm12=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm12=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm14 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm14=int6464#15
# asm 2: pxor  <xmm8=%xmm8,<xmm14=%xmm14
pxor  %xmm8,%xmm14

# qhasm:       xmm8 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm8=int6464#9
# asm 2: pxor  <xmm9=%xmm9,<xmm8=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm13 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm13=int6464#14
# asm 2: pxor  <xmm10=%xmm10,<xmm13=%xmm13
pxor  %xmm10,%xmm13

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm11=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm11=int6464#12
# asm 2: pxor  <xmm13=%xmm13,<xmm11=%xmm11
pxor  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:     xmm0 = shuffle dwords of xmm8 by 0x93
# asm 1: pshufd $0x93,<xmm8=int6464#9,>xmm0=int6464#1
# asm 2: pshufd $0x93,<xmm8=%xmm8,>xmm0=%xmm0
pshufd $0x93,%xmm8,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm9 by 0x93
# asm 1: pshufd $0x93,<xmm9=int6464#10,>xmm1=int6464#2
# asm 2: pshufd $0x93,<xmm9=%xmm9,>xmm1=%xmm1
pshufd $0x93,%xmm9,%xmm1

# qhasm:     xmm2 = shuffle dwords of xmm12 by 0x93
# asm 1: pshufd $0x93,<xmm12=int6464#13,>xmm2=int6464#3
# asm 2: pshufd $0x93,<xmm12=%xmm12,>xmm2=%xmm2
pshufd $0x93,%xmm12,%xmm2

# qhasm:     xmm3 = shuffle dwords of xmm14 by 0x93
# asm 1: pshufd $0x93,<xmm14=int6464#15,>xmm3=int6464#4
# asm 2: pshufd $0x93,<xmm14=%xmm14,>xmm3=%xmm3
pshufd $0x93,%xmm14,%xmm3

# qhasm:     xmm4 = shuffle dwords of xmm11 by 0x93
# asm 1: pshufd $0x93,<xmm11=int6464#12,>xmm4=int6464#5
# asm 2: pshufd $0x93,<xmm11=%xmm11,>xmm4=%xmm4
pshufd $0x93,%xmm11,%xmm4

# qhasm:     xmm5 = shuffle dwords of xmm15 by 0x93
# asm 1: pshufd $0x93,<xmm15=int6464#16,>xmm5=int6464#6
# asm 2: pshufd $0x93,<xmm15=%xmm15,>xmm5=%xmm5
pshufd $0x93,%xmm15,%xmm5

# qhasm:     xmm6 = shuffle dwords of xmm10 by 0x93
# asm 1: pshufd $0x93,<xmm10=int6464#11,>xmm6=int6464#7
# asm 2: pshufd $0x93,<xmm10=%xmm10,>xmm6=%xmm6
pshufd $0x93,%xmm10,%xmm6

# qhasm:     xmm7 = shuffle dwords of xmm13 by 0x93
# asm 1: pshufd $0x93,<xmm13=int6464#14,>xmm7=int6464#8
# asm 2: pshufd $0x93,<xmm13=%xmm13,>xmm7=%xmm7
pshufd $0x93,%xmm13,%xmm7

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm12 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm12=int6464#13
# asm 2: pxor  <xmm2=%xmm2,<xmm12=%xmm12
pxor  %xmm2,%xmm12

# qhasm:     xmm14 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm14=int6464#15
# asm 2: pxor  <xmm3=%xmm3,<xmm14=%xmm14
pxor  %xmm3,%xmm14

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm10 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pxor  <xmm6=%xmm6,<xmm10=%xmm10
pxor  %xmm6,%xmm10

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm2 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:     xmm1 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm1=int6464#2
# asm 2: pxor  <xmm13=%xmm13,<xmm1=%xmm1
pxor  %xmm13,%xmm1

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#5
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm4
pxor  %xmm14,%xmm4

# qhasm:     xmm5 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm5=int6464#6
# asm 2: pxor  <xmm11=%xmm11,<xmm5=%xmm5
pxor  %xmm11,%xmm5

# qhasm:     xmm3 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm3=int6464#4
# asm 2: pxor  <xmm13=%xmm13,<xmm3=%xmm3
pxor  %xmm13,%xmm3

# qhasm:     xmm6 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm6=int6464#7
# asm 2: pxor  <xmm15=%xmm15,<xmm6=%xmm6
pxor  %xmm15,%xmm6

# qhasm:     xmm7 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm7=int6464#8
# asm 2: pxor  <xmm10=%xmm10,<xmm7=%xmm7
pxor  %xmm10,%xmm7

# qhasm:     xmm4 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm4=int6464#5
# asm 2: pxor  <xmm13=%xmm13,<xmm4=%xmm4
pxor  %xmm13,%xmm4

# qhasm:     xmm8 = shuffle dwords of xmm8 by 0x4E
# asm 1: pshufd $0x4E,<xmm8=int6464#9,>xmm8=int6464#9
# asm 2: pshufd $0x4E,<xmm8=%xmm8,>xmm8=%xmm8
pshufd $0x4E,%xmm8,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm9 by 0x4E
# asm 1: pshufd $0x4E,<xmm9=int6464#10,>xmm9=int6464#10
# asm 2: pshufd $0x4E,<xmm9=%xmm9,>xmm9=%xmm9
pshufd $0x4E,%xmm9,%xmm9

# qhasm:     xmm12 = shuffle dwords of xmm12 by 0x4E
# asm 1: pshufd $0x4E,<xmm12=int6464#13,>xmm12=int6464#13
# asm 2: pshufd $0x4E,<xmm12=%xmm12,>xmm12=%xmm12
pshufd $0x4E,%xmm12,%xmm12

# qhasm:     xmm14 = shuffle dwords of xmm14 by 0x4E
# asm 1: pshufd $0x4E,<xmm14=int6464#15,>xmm14=int6464#15
# asm 2: pshufd $0x4E,<xmm14=%xmm14,>xmm14=%xmm14
pshufd $0x4E,%xmm14,%xmm14

# qhasm:     xmm11 = shuffle dwords of xmm11 by 0x4E
# asm 1: pshufd $0x4E,<xmm11=int6464#12,>xmm11=int6464#12
# asm 2: pshufd $0x4E,<xmm11=%xmm11,>xmm11=%xmm11
pshufd $0x4E,%xmm11,%xmm11

# qhasm:     xmm15 = shuffle dwords of xmm15 by 0x4E
# asm 1: pshufd $0x4E,<xmm15=int6464#16,>xmm15=int6464#16
# asm 2: pshufd $0x4E,<xmm15=%xmm15,>xmm15=%xmm15
pshufd $0x4E,%xmm15,%xmm15

# qhasm:     xmm10 = shuffle dwords of xmm10 by 0x4E
# asm 1: pshufd $0x4E,<xmm10=int6464#11,>xmm10=int6464#11
# asm 2: pshufd $0x4E,<xmm10=%xmm10,>xmm10=%xmm10
pshufd $0x4E,%xmm10,%xmm10

# qhasm:     xmm13 = shuffle dwords of xmm13 by 0x4E
# asm 1: pshufd $0x4E,<xmm13=int6464#14,>xmm13=int6464#14
# asm 2: pshufd $0x4E,<xmm13=%xmm13,>xmm13=%xmm13
pshufd $0x4E,%xmm13,%xmm13

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm2 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pxor  <xmm12=%xmm12,<xmm2=%xmm2
pxor  %xmm12,%xmm2

# qhasm:     xmm3 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm3=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm3=%xmm3
pxor  %xmm14,%xmm3

# qhasm:     xmm4 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm4=int6464#5
# asm 2: pxor  <xmm11=%xmm11,<xmm4=%xmm4
pxor  %xmm11,%xmm4

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm6 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm6=int6464#7
# asm 2: pxor  <xmm10=%xmm10,<xmm6=%xmm6
pxor  %xmm10,%xmm6

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm0 ^= *(int128 *)(c + 768)
# asm 1: pxor 768(<c=int64#2),<xmm0=int6464#1
# asm 2: pxor 768(<c=%rsi),<xmm0=%xmm0
pxor 768(%rsi),%xmm0

# qhasm:     shuffle bytes of xmm0 by SR
# asm 1: pshufb SR,<xmm0=int6464#1
# asm 2: pshufb SR,<xmm0=%xmm0
pshufb SR,%xmm0

# qhasm:     xmm1 ^= *(int128 *)(c + 784)
# asm 1: pxor 784(<c=int64#2),<xmm1=int6464#2
# asm 2: pxor 784(<c=%rsi),<xmm1=%xmm1
pxor 784(%rsi),%xmm1

# qhasm:     shuffle bytes of xmm1 by SR
# asm 1: pshufb SR,<xmm1=int6464#2
# asm 2: pshufb SR,<xmm1=%xmm1
pshufb SR,%xmm1

# qhasm:     xmm2 ^= *(int128 *)(c + 800)
# asm 1: pxor 800(<c=int64#2),<xmm2=int6464#3
# asm 2: pxor 800(<c=%rsi),<xmm2=%xmm2
pxor 800(%rsi),%xmm2

# qhasm:     shuffle bytes of xmm2 by SR
# asm 1: pshufb SR,<xmm2=int6464#3
# asm 2: pshufb SR,<xmm2=%xmm2
pshufb SR,%xmm2

# qhasm:     xmm3 ^= *(int128 *)(c + 816)
# asm 1: pxor 816(<c=int64#2),<xmm3=int6464#4
# asm 2: pxor 816(<c=%rsi),<xmm3=%xmm3
pxor 816(%rsi),%xmm3

# qhasm:     shuffle bytes of xmm3 by SR
# asm 1: pshufb SR,<xmm3=int6464#4
# asm 2: pshufb SR,<xmm3=%xmm3
pshufb SR,%xmm3

# qhasm:     xmm4 ^= *(int128 *)(c + 832)
# asm 1: pxor 832(<c=int64#2),<xmm4=int6464#5
# asm 2: pxor 832(<c=%rsi),<xmm4=%xmm4
pxor 832(%rsi),%xmm4

# qhasm:     shuffle bytes of xmm4 by SR
# asm 1: pshufb SR,<xmm4=int6464#5
# asm 2: pshufb SR,<xmm4=%xmm4
pshufb SR,%xmm4

# qhasm:     xmm5 ^= *(int128 *)(c + 848)
# asm 1: pxor 848(<c=int64#2),<xmm5=int6464#6
# asm 2: pxor 848(<c=%rsi),<xmm5=%xmm5
pxor 848(%rsi),%xmm5

# qhasm:     shuffle bytes of xmm5 by SR
# asm 1: pshufb SR,<xmm5=int6464#6
# asm 2: pshufb SR,<xmm5=%xmm5
pshufb SR,%xmm5

# qhasm:     xmm6 ^= *(int128 *)(c + 864)
# asm 1: pxor 864(<c=int64#2),<xmm6=int6464#7
# asm 2: pxor 864(<c=%rsi),<xmm6=%xmm6
pxor 864(%rsi),%xmm6

# qhasm:     shuffle bytes of xmm6 by SR
# asm 1: pshufb SR,<xmm6=int6464#7
# asm 2: pshufb SR,<xmm6=%xmm6
pshufb SR,%xmm6

# qhasm:     xmm7 ^= *(int128 *)(c + 880)
# asm 1: pxor 880(<c=int64#2),<xmm7=int6464#8
# asm 2: pxor 880(<c=%rsi),<xmm7=%xmm7
pxor 880(%rsi),%xmm7

# qhasm:     shuffle bytes of xmm7 by SR
# asm 1: pshufb SR,<xmm7=int6464#8
# asm 2: pshufb SR,<xmm7=%xmm7
pshufb SR,%xmm7

# qhasm:       xmm5 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm5=int6464#6
# asm 2: pxor  <xmm6=%xmm6,<xmm5=%xmm5
pxor  %xmm6,%xmm5

# qhasm:       xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm1,<xmm2=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm5=int6464#6
# asm 2: pxor  <xmm0=%xmm0,<xmm5=%xmm5
pxor  %xmm0,%xmm5

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm6=int6464#7
# asm 2: pxor  <xmm2=%xmm2,<xmm6=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm3=int6464#4
# asm 2: pxor  <xmm0=%xmm0,<xmm3=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#4
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm3
pxor  %xmm7,%xmm3

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm3=int6464#4
# asm 2: pxor  <xmm4=%xmm4,<xmm3=%xmm3
pxor  %xmm4,%xmm3

# qhasm:       xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm7=int6464#8
# asm 2: pxor  <xmm5=%xmm5,<xmm7=%xmm7
pxor  %xmm5,%xmm7

# qhasm:       xmm3 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm3=int6464#4
# asm 2: pxor  <xmm1=%xmm1,<xmm3=%xmm3
pxor  %xmm1,%xmm3

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm2=int6464#3
# asm 2: pxor  <xmm7=%xmm7,<xmm2=%xmm2
pxor  %xmm7,%xmm2

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm11 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm11=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm11=%xmm8
movdqa %xmm7,%xmm8

# qhasm:       xmm10 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm10=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm10=%xmm9
movdqa %xmm1,%xmm9

# qhasm:       xmm9 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm9=int6464#11
# asm 2: movdqa <xmm5=%xmm5,>xmm9=%xmm10
movdqa %xmm5,%xmm10

# qhasm:       xmm13 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm13=int6464#12
# asm 2: movdqa <xmm2=%xmm2,>xmm13=%xmm11
movdqa %xmm2,%xmm11

# qhasm:       xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#13
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm12
movdqa %xmm6,%xmm12

# qhasm:       xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm9
pxor  %xmm2,%xmm9

# qhasm:       xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm9=int6464#11
# asm 2: pxor  <xmm3=%xmm3,<xmm9=%xmm10
pxor  %xmm3,%xmm10

# qhasm:       xmm13 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm13=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm13=%xmm11
pxor  %xmm4,%xmm11

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:       xmm14 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm14=int6464#14
# asm 2: movdqa <xmm11=%xmm8,>xmm14=%xmm13
movdqa %xmm8,%xmm13

# qhasm:       xmm8 = xmm10
# asm 1: movdqa <xmm10=int6464#10,>xmm8=int6464#15
# asm 2: movdqa <xmm10=%xmm9,>xmm8=%xmm14
movdqa %xmm9,%xmm14

# qhasm:       xmm15 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm15=int6464#16
# asm 2: movdqa <xmm11=%xmm8,>xmm15=%xmm15
movdqa %xmm8,%xmm15

# qhasm:       xmm10 |= xmm9
# asm 1: por   <xmm9=int6464#11,<xmm10=int6464#10
# asm 2: por   <xmm9=%xmm10,<xmm10=%xmm9
por   %xmm10,%xmm9

# qhasm:       xmm11 |= xmm12
# asm 1: por   <xmm12=int6464#13,<xmm11=int6464#9
# asm 2: por   <xmm12=%xmm12,<xmm11=%xmm8
por   %xmm12,%xmm8

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm15=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm14 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm14=int6464#14
# asm 2: pand  <xmm12=%xmm12,<xmm14=%xmm13
pand  %xmm12,%xmm13

# qhasm:       xmm8 &= xmm9
# asm 1: pand  <xmm9=int6464#11,<xmm8=int6464#15
# asm 2: pand  <xmm9=%xmm10,<xmm8=%xmm14
pand  %xmm10,%xmm14

# qhasm:       xmm12 ^= xmm9
# asm 1: pxor  <xmm9=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm9=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:       xmm15 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm15=int6464#16
# asm 2: pand  <xmm12=%xmm12,<xmm15=%xmm15
pand  %xmm12,%xmm15

# qhasm:       xmm12 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm12=int6464#11
# asm 2: movdqa <xmm3=%xmm3,>xmm12=%xmm10
movdqa %xmm3,%xmm10

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm10
pxor  %xmm0,%xmm10

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#11,<xmm13=int6464#12
# asm 2: pand  <xmm12=%xmm10,<xmm13=%xmm11
pand  %xmm10,%xmm11

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm11=int6464#9
# asm 2: pxor  <xmm13=%xmm11,<xmm11=%xmm8
pxor  %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm13 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm13=int6464#11
# asm 2: movdqa <xmm7=%xmm7,>xmm13=%xmm10
movdqa %xmm7,%xmm10

# qhasm:       xmm13 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm13=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm13=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm12 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm12=int6464#12
# asm 2: movdqa <xmm5=%xmm5,>xmm12=%xmm11
movdqa %xmm5,%xmm11

# qhasm:       xmm9 = xmm13
# asm 1: movdqa <xmm13=int6464#11,>xmm9=int6464#13
# asm 2: movdqa <xmm13=%xmm10,>xmm9=%xmm12
movdqa %xmm10,%xmm12

# qhasm:       xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm11
pxor  %xmm6,%xmm11

# qhasm:       xmm9 |= xmm12
# asm 1: por   <xmm12=int6464#12,<xmm9=int6464#13
# asm 2: por   <xmm12=%xmm11,<xmm9=%xmm12
por   %xmm11,%xmm12

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#12,<xmm13=int6464#11
# asm 2: pand  <xmm12=%xmm11,<xmm13=%xmm10
pand  %xmm11,%xmm10

# qhasm:       xmm8 ^= xmm13
# asm 1: pxor  <xmm13=int6464#11,<xmm8=int6464#15
# asm 2: pxor  <xmm13=%xmm10,<xmm8=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#9
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm10=int6464#10
# asm 2: pxor  <xmm14=%xmm13,<xmm10=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm9 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm8 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm8=int6464#15
# asm 2: pxor  <xmm14=%xmm13,<xmm8=%xmm14
pxor  %xmm13,%xmm14

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm12 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm12=int6464#11
# asm 2: movdqa <xmm2=%xmm2,>xmm12=%xmm10
movdqa %xmm2,%xmm10

# qhasm:       xmm13 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm13=int6464#12
# asm 2: movdqa <xmm4=%xmm4,>xmm13=%xmm11
movdqa %xmm4,%xmm11

# qhasm:       xmm14 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm14=int6464#14
# asm 2: movdqa <xmm1=%xmm1,>xmm14=%xmm13
movdqa %xmm1,%xmm13

# qhasm:       xmm15 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm15=int6464#16
# asm 2: movdqa <xmm7=%xmm7,>xmm15=%xmm15
movdqa %xmm7,%xmm15

# qhasm:       xmm12 &= xmm3
# asm 1: pand  <xmm3=int6464#4,<xmm12=int6464#11
# asm 2: pand  <xmm3=%xmm3,<xmm12=%xmm10
pand  %xmm3,%xmm10

# qhasm:       xmm13 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm13=int6464#12
# asm 2: pand  <xmm0=%xmm0,<xmm13=%xmm11
pand  %xmm0,%xmm11

# qhasm:       xmm14 &= xmm5
# asm 1: pand  <xmm5=int6464#6,<xmm14=int6464#14
# asm 2: pand  <xmm5=%xmm5,<xmm14=%xmm13
pand  %xmm5,%xmm13

# qhasm:       xmm15 |= xmm6
# asm 1: por   <xmm6=int6464#7,<xmm15=int6464#16
# asm 2: por   <xmm6=%xmm6,<xmm15=%xmm15
por   %xmm6,%xmm15

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm11=int6464#9
# asm 2: pxor  <xmm12=%xmm10,<xmm11=%xmm8
pxor  %xmm10,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm8 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm8=int6464#15
# asm 2: pxor  <xmm15=%xmm15,<xmm8=%xmm14
pxor  %xmm15,%xmm14

# qhasm:       xmm12 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm12=int6464#11
# asm 2: movdqa <xmm11=%xmm8,>xmm12=%xmm10
movdqa %xmm8,%xmm10

# qhasm:       xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm12=int6464#11
# asm 2: pxor  <xmm10=%xmm9,<xmm12=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm11 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm11=int6464#9
# asm 2: pand  <xmm9=%xmm12,<xmm11=%xmm8
pand  %xmm12,%xmm8

# qhasm:       xmm14 = xmm8
# asm 1: movdqa <xmm8=int6464#15,>xmm14=int6464#12
# asm 2: movdqa <xmm8=%xmm14,>xmm14=%xmm11
movdqa %xmm14,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm11=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm15 = xmm12
# asm 1: movdqa <xmm12=int6464#11,>xmm15=int6464#14
# asm 2: movdqa <xmm12=%xmm10,>xmm15=%xmm13
movdqa %xmm10,%xmm13

# qhasm:       xmm15 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm15=int6464#14
# asm 2: pand  <xmm14=%xmm11,<xmm15=%xmm13
pand  %xmm11,%xmm13

# qhasm:       xmm15 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm15=int6464#14
# asm 2: pxor  <xmm10=%xmm9,<xmm15=%xmm13
pxor  %xmm9,%xmm13

# qhasm:       xmm13 = xmm9
# asm 1: movdqa <xmm9=int6464#13,>xmm13=int6464#16
# asm 2: movdqa <xmm9=%xmm12,>xmm13=%xmm15
movdqa %xmm12,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm11 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm11=int6464#9
# asm 2: pxor  <xmm10=%xmm9,<xmm11=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm13 &= xmm11
# asm 1: pand  <xmm11=int6464#9,<xmm13=int6464#16
# asm 2: pand  <xmm11=%xmm8,<xmm13=%xmm15
pand  %xmm8,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm13=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm10 = xmm14
# asm 1: movdqa <xmm14=int6464#12,>xmm10=int6464#9
# asm 2: movdqa <xmm14=%xmm11,>xmm10=%xmm8
movdqa %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm10=int6464#9
# asm 2: pxor  <xmm13=%xmm15,<xmm10=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 &= xmm8
# asm 1: pand  <xmm8=int6464#15,<xmm10=int6464#9
# asm 2: pand  <xmm8=%xmm14,<xmm10=%xmm8
pand  %xmm14,%xmm8

# qhasm:       xmm9 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm9=int6464#13
# asm 2: pxor  <xmm10=%xmm8,<xmm9=%xmm12
pxor  %xmm8,%xmm12

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm10=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm14=int6464#12
# asm 2: pand  <xmm15=%xmm13,<xmm14=%xmm11
pand  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm14=int6464#12
# asm 2: pxor  <xmm12=%xmm10,<xmm14=%xmm11
pxor  %xmm10,%xmm11

# qhasm:         xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm8
movdqa %xmm6,%xmm8

# qhasm:         xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#10
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm9
movdqa %xmm5,%xmm9

# qhasm:           xmm10 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm10=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm10=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm10 &= xmm6
# asm 1: pand  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pand  <xmm6=%xmm6,<xmm10=%xmm10
pand  %xmm6,%xmm10

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm6 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm6=int6464#7
# asm 2: pand  <xmm14=%xmm11,<xmm6=%xmm6
pand  %xmm11,%xmm6

# qhasm:           xmm5 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm5=int6464#6
# asm 2: pand  <xmm15=%xmm13,<xmm5=%xmm5
pand  %xmm13,%xmm5

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm5 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm5=int6464#6
# asm 2: pxor  <xmm10=%xmm10,<xmm5=%xmm5
pxor  %xmm10,%xmm5

# qhasm:         xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#10
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm9
pxor  %xmm3,%xmm9

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pand  <xmm0=%xmm0,<xmm10=%xmm10
pand  %xmm0,%xmm10

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm0=int6464#1
# asm 2: pand  <xmm9=%xmm12,<xmm0=%xmm0
pand  %xmm12,%xmm0

# qhasm:           xmm3 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm3=int6464#4
# asm 2: pand  <xmm13=%xmm15,<xmm3=%xmm3
pand  %xmm15,%xmm3

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm3 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm3=int6464#4
# asm 2: pxor  <xmm10=%xmm10,<xmm3=%xmm3
pxor  %xmm10,%xmm3

# qhasm:         xmm6 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm12=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:         xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm9,<xmm5=%xmm5
pxor  %xmm9,%xmm5

# qhasm:         xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm9,<xmm3=%xmm3
pxor  %xmm9,%xmm3

# qhasm:         xmm12 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm12=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm12=%xmm8
movdqa %xmm7,%xmm8

# qhasm:         xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm9
movdqa %xmm1,%xmm9

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm12=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm12=%xmm8
pxor  %xmm4,%xmm8

# qhasm:         xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm9
pxor  %xmm2,%xmm9

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pand  <xmm4=%xmm4,<xmm10=%xmm10
pand  %xmm4,%xmm10

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm4 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm4=int6464#5
# asm 2: pand  <xmm9=%xmm12,<xmm4=%xmm4
pand  %xmm12,%xmm4

# qhasm:           xmm2 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm2=int6464#3
# asm 2: pand  <xmm13=%xmm15,<xmm2=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#3
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm2
pxor  %xmm10,%xmm2

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm7
# asm 1: pand  <xmm7=int6464#8,<xmm11=int6464#11
# asm 2: pand  <xmm7=%xmm7,<xmm11=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm7 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm7=int6464#8
# asm 2: pand  <xmm14=%xmm11,<xmm7=%xmm7
pand  %xmm11,%xmm7

# qhasm:           xmm1 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm1=int6464#2
# asm 2: pand  <xmm15=%xmm13,<xmm1=%xmm1
pand  %xmm13,%xmm1

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm1=int6464#2
# asm 2: pxor  <xmm11=%xmm10,<xmm1=%xmm1
pxor  %xmm10,%xmm1

# qhasm:         xmm7 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm12=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm12=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:         xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:         xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm0,<xmm7=%xmm7
pxor  %xmm0,%xmm7

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm1=int6464#2
# asm 2: pxor  <xmm6=%xmm6,<xmm1=%xmm1
pxor  %xmm6,%xmm1

# qhasm:       xmm4 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm4=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm4=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm6 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm6=int6464#7
# asm 2: pxor  <xmm0=%xmm0,<xmm6=%xmm6
pxor  %xmm0,%xmm6

# qhasm:       xmm0 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm0=int6464#1
# asm 2: pxor  <xmm1=%xmm1,<xmm0=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm5 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm5=int6464#6
# asm 2: pxor  <xmm2=%xmm2,<xmm5=%xmm5
pxor  %xmm2,%xmm5

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm3=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm3=int6464#4
# asm 2: pxor  <xmm5=%xmm5,<xmm3=%xmm3
pxor  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:     xmm8 = shuffle dwords of xmm0 by 0x93
# asm 1: pshufd $0x93,<xmm0=int6464#1,>xmm8=int6464#9
# asm 2: pshufd $0x93,<xmm0=%xmm0,>xmm8=%xmm8
pshufd $0x93,%xmm0,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm1 by 0x93
# asm 1: pshufd $0x93,<xmm1=int6464#2,>xmm9=int6464#10
# asm 2: pshufd $0x93,<xmm1=%xmm1,>xmm9=%xmm9
pshufd $0x93,%xmm1,%xmm9

# qhasm:     xmm10 = shuffle dwords of xmm4 by 0x93
# asm 1: pshufd $0x93,<xmm4=int6464#5,>xmm10=int6464#11
# asm 2: pshufd $0x93,<xmm4=%xmm4,>xmm10=%xmm10
pshufd $0x93,%xmm4,%xmm10

# qhasm:     xmm11 = shuffle dwords of xmm6 by 0x93
# asm 1: pshufd $0x93,<xmm6=int6464#7,>xmm11=int6464#12
# asm 2: pshufd $0x93,<xmm6=%xmm6,>xmm11=%xmm11
pshufd $0x93,%xmm6,%xmm11

# qhasm:     xmm12 = shuffle dwords of xmm3 by 0x93
# asm 1: pshufd $0x93,<xmm3=int6464#4,>xmm12=int6464#13
# asm 2: pshufd $0x93,<xmm3=%xmm3,>xmm12=%xmm12
pshufd $0x93,%xmm3,%xmm12

# qhasm:     xmm13 = shuffle dwords of xmm7 by 0x93
# asm 1: pshufd $0x93,<xmm7=int6464#8,>xmm13=int6464#14
# asm 2: pshufd $0x93,<xmm7=%xmm7,>xmm13=%xmm13
pshufd $0x93,%xmm7,%xmm13

# qhasm:     xmm14 = shuffle dwords of xmm2 by 0x93
# asm 1: pshufd $0x93,<xmm2=int6464#3,>xmm14=int6464#15
# asm 2: pshufd $0x93,<xmm2=%xmm2,>xmm14=%xmm14
pshufd $0x93,%xmm2,%xmm14

# qhasm:     xmm15 = shuffle dwords of xmm5 by 0x93
# asm 1: pshufd $0x93,<xmm5=int6464#6,>xmm15=int6464#16
# asm 2: pshufd $0x93,<xmm5=%xmm5,>xmm15=%xmm15
pshufd $0x93,%xmm5,%xmm15

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm4 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm4=int6464#5
# asm 2: pxor  <xmm10=%xmm10,<xmm4=%xmm4
pxor  %xmm10,%xmm4

# qhasm:     xmm6 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm6=int6464#7
# asm 2: pxor  <xmm11=%xmm11,<xmm6=%xmm6
pxor  %xmm11,%xmm6

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm2 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pxor  <xmm14=%xmm14,<xmm2=%xmm2
pxor  %xmm14,%xmm2

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm10 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:     xmm9 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm9=int6464#10
# asm 2: pxor  <xmm5=%xmm5,<xmm9=%xmm9
pxor  %xmm5,%xmm9

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#13
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm12
pxor  %xmm6,%xmm12

# qhasm:     xmm13 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm13=int6464#14
# asm 2: pxor  <xmm3=%xmm3,<xmm13=%xmm13
pxor  %xmm3,%xmm13

# qhasm:     xmm11 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm11=int6464#12
# asm 2: pxor  <xmm5=%xmm5,<xmm11=%xmm11
pxor  %xmm5,%xmm11

# qhasm:     xmm14 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm14=int6464#15
# asm 2: pxor  <xmm7=%xmm7,<xmm14=%xmm14
pxor  %xmm7,%xmm14

# qhasm:     xmm15 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm15=int6464#16
# asm 2: pxor  <xmm2=%xmm2,<xmm15=%xmm15
pxor  %xmm2,%xmm15

# qhasm:     xmm12 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm12=int6464#13
# asm 2: pxor  <xmm5=%xmm5,<xmm12=%xmm12
pxor  %xmm5,%xmm12

# qhasm:     xmm0 = shuffle dwords of xmm0 by 0x4E
# asm 1: pshufd $0x4E,<xmm0=int6464#1,>xmm0=int6464#1
# asm 2: pshufd $0x4E,<xmm0=%xmm0,>xmm0=%xmm0
pshufd $0x4E,%xmm0,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm1 by 0x4E
# asm 1: pshufd $0x4E,<xmm1=int6464#2,>xmm1=int6464#2
# asm 2: pshufd $0x4E,<xmm1=%xmm1,>xmm1=%xmm1
pshufd $0x4E,%xmm1,%xmm1

# qhasm:     xmm4 = shuffle dwords of xmm4 by 0x4E
# asm 1: pshufd $0x4E,<xmm4=int6464#5,>xmm4=int6464#5
# asm 2: pshufd $0x4E,<xmm4=%xmm4,>xmm4=%xmm4
pshufd $0x4E,%xmm4,%xmm4

# qhasm:     xmm6 = shuffle dwords of xmm6 by 0x4E
# asm 1: pshufd $0x4E,<xmm6=int6464#7,>xmm6=int6464#7
# asm 2: pshufd $0x4E,<xmm6=%xmm6,>xmm6=%xmm6
pshufd $0x4E,%xmm6,%xmm6

# qhasm:     xmm3 = shuffle dwords of xmm3 by 0x4E
# asm 1: pshufd $0x4E,<xmm3=int6464#4,>xmm3=int6464#4
# asm 2: pshufd $0x4E,<xmm3=%xmm3,>xmm3=%xmm3
pshufd $0x4E,%xmm3,%xmm3

# qhasm:     xmm7 = shuffle dwords of xmm7 by 0x4E
# asm 1: pshufd $0x4E,<xmm7=int6464#8,>xmm7=int6464#8
# asm 2: pshufd $0x4E,<xmm7=%xmm7,>xmm7=%xmm7
pshufd $0x4E,%xmm7,%xmm7

# qhasm:     xmm2 = shuffle dwords of xmm2 by 0x4E
# asm 1: pshufd $0x4E,<xmm2=int6464#3,>xmm2=int6464#3
# asm 2: pshufd $0x4E,<xmm2=%xmm2,>xmm2=%xmm2
pshufd $0x4E,%xmm2,%xmm2

# qhasm:     xmm5 = shuffle dwords of xmm5 by 0x4E
# asm 1: pshufd $0x4E,<xmm5=int6464#6,>xmm5=int6464#6
# asm 2: pshufd $0x4E,<xmm5=%xmm5,>xmm5=%xmm5
pshufd $0x4E,%xmm5,%xmm5

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm10 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pxor  <xmm4=%xmm4,<xmm10=%xmm10
pxor  %xmm4,%xmm10

# qhasm:     xmm11 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm11=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm11=%xmm11
pxor  %xmm6,%xmm11

# qhasm:     xmm12 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm12=int6464#13
# asm 2: pxor  <xmm3=%xmm3,<xmm12=%xmm12
pxor  %xmm3,%xmm12

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm14 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm14=int6464#15
# asm 2: pxor  <xmm2=%xmm2,<xmm14=%xmm14
pxor  %xmm2,%xmm14

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm8 ^= *(int128 *)(c + 896)
# asm 1: pxor 896(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 896(<c=%rsi),<xmm8=%xmm8
pxor 896(%rsi),%xmm8

# qhasm:     shuffle bytes of xmm8 by SR
# asm 1: pshufb SR,<xmm8=int6464#9
# asm 2: pshufb SR,<xmm8=%xmm8
pshufb SR,%xmm8

# qhasm:     xmm9 ^= *(int128 *)(c + 912)
# asm 1: pxor 912(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 912(<c=%rsi),<xmm9=%xmm9
pxor 912(%rsi),%xmm9

# qhasm:     shuffle bytes of xmm9 by SR
# asm 1: pshufb SR,<xmm9=int6464#10
# asm 2: pshufb SR,<xmm9=%xmm9
pshufb SR,%xmm9

# qhasm:     xmm10 ^= *(int128 *)(c + 928)
# asm 1: pxor 928(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 928(<c=%rsi),<xmm10=%xmm10
pxor 928(%rsi),%xmm10

# qhasm:     shuffle bytes of xmm10 by SR
# asm 1: pshufb SR,<xmm10=int6464#11
# asm 2: pshufb SR,<xmm10=%xmm10
pshufb SR,%xmm10

# qhasm:     xmm11 ^= *(int128 *)(c + 944)
# asm 1: pxor 944(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 944(<c=%rsi),<xmm11=%xmm11
pxor 944(%rsi),%xmm11

# qhasm:     shuffle bytes of xmm11 by SR
# asm 1: pshufb SR,<xmm11=int6464#12
# asm 2: pshufb SR,<xmm11=%xmm11
pshufb SR,%xmm11

# qhasm:     xmm12 ^= *(int128 *)(c + 960)
# asm 1: pxor 960(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 960(<c=%rsi),<xmm12=%xmm12
pxor 960(%rsi),%xmm12

# qhasm:     shuffle bytes of xmm12 by SR
# asm 1: pshufb SR,<xmm12=int6464#13
# asm 2: pshufb SR,<xmm12=%xmm12
pshufb SR,%xmm12

# qhasm:     xmm13 ^= *(int128 *)(c + 976)
# asm 1: pxor 976(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 976(<c=%rsi),<xmm13=%xmm13
pxor 976(%rsi),%xmm13

# qhasm:     shuffle bytes of xmm13 by SR
# asm 1: pshufb SR,<xmm13=int6464#14
# asm 2: pshufb SR,<xmm13=%xmm13
pshufb SR,%xmm13

# qhasm:     xmm14 ^= *(int128 *)(c + 992)
# asm 1: pxor 992(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 992(<c=%rsi),<xmm14=%xmm14
pxor 992(%rsi),%xmm14

# qhasm:     shuffle bytes of xmm14 by SR
# asm 1: pshufb SR,<xmm14=int6464#15
# asm 2: pshufb SR,<xmm14=%xmm14
pshufb SR,%xmm14

# qhasm:     xmm15 ^= *(int128 *)(c + 1008)
# asm 1: pxor 1008(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 1008(<c=%rsi),<xmm15=%xmm15
pxor 1008(%rsi),%xmm15

# qhasm:     shuffle bytes of xmm15 by SR
# asm 1: pshufb SR,<xmm15=int6464#16
# asm 2: pshufb SR,<xmm15=%xmm15
pshufb SR,%xmm15

# qhasm:       xmm13 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm13=int6464#14
# asm 2: pxor  <xmm14=%xmm14,<xmm13=%xmm13
pxor  %xmm14,%xmm13

# qhasm:       xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm9,<xmm10=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm13=int6464#14
# asm 2: pxor  <xmm8=%xmm8,<xmm13=%xmm13
pxor  %xmm8,%xmm13

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm14=int6464#15
# asm 2: pxor  <xmm10=%xmm10,<xmm14=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm11=int6464#12
# asm 2: pxor  <xmm8=%xmm8,<xmm11=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#12
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm11
pxor  %xmm15,%xmm11

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm11=int6464#12
# asm 2: pxor  <xmm12=%xmm12,<xmm11=%xmm11
pxor  %xmm12,%xmm11

# qhasm:       xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm15=int6464#16
# asm 2: pxor  <xmm13=%xmm13,<xmm15=%xmm15
pxor  %xmm13,%xmm15

# qhasm:       xmm11 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm11=int6464#12
# asm 2: pxor  <xmm9=%xmm9,<xmm11=%xmm11
pxor  %xmm9,%xmm11

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm10=int6464#11
# asm 2: pxor  <xmm15=%xmm15,<xmm10=%xmm10
pxor  %xmm15,%xmm10

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm3 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm3=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm3=%xmm0
movdqa %xmm15,%xmm0

# qhasm:       xmm2 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm2=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm2=%xmm1
movdqa %xmm9,%xmm1

# qhasm:       xmm1 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm1=int6464#3
# asm 2: movdqa <xmm13=%xmm13,>xmm1=%xmm2
movdqa %xmm13,%xmm2

# qhasm:       xmm5 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm5=int6464#4
# asm 2: movdqa <xmm10=%xmm10,>xmm5=%xmm3
movdqa %xmm10,%xmm3

# qhasm:       xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#5
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm4
movdqa %xmm14,%xmm4

# qhasm:       xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm0
pxor  %xmm12,%xmm0

# qhasm:       xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm1
pxor  %xmm10,%xmm1

# qhasm:       xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm1=int6464#3
# asm 2: pxor  <xmm11=%xmm11,<xmm1=%xmm2
pxor  %xmm11,%xmm2

# qhasm:       xmm5 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm5=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm5=%xmm3
pxor  %xmm12,%xmm3

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       xmm6 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm6=int6464#6
# asm 2: movdqa <xmm3=%xmm0,>xmm6=%xmm5
movdqa %xmm0,%xmm5

# qhasm:       xmm0 = xmm2
# asm 1: movdqa <xmm2=int6464#2,>xmm0=int6464#7
# asm 2: movdqa <xmm2=%xmm1,>xmm0=%xmm6
movdqa %xmm1,%xmm6

# qhasm:       xmm7 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm3=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       xmm2 |= xmm1
# asm 1: por   <xmm1=int6464#3,<xmm2=int6464#2
# asm 2: por   <xmm1=%xmm2,<xmm2=%xmm1
por   %xmm2,%xmm1

# qhasm:       xmm3 |= xmm4
# asm 1: por   <xmm4=int6464#5,<xmm3=int6464#1
# asm 2: por   <xmm4=%xmm4,<xmm3=%xmm0
por   %xmm4,%xmm0

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm7=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm6 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm6=int6464#6
# asm 2: pand  <xmm4=%xmm4,<xmm6=%xmm5
pand  %xmm4,%xmm5

# qhasm:       xmm0 &= xmm1
# asm 1: pand  <xmm1=int6464#3,<xmm0=int6464#7
# asm 2: pand  <xmm1=%xmm2,<xmm0=%xmm6
pand  %xmm2,%xmm6

# qhasm:       xmm4 ^= xmm1
# asm 1: pxor  <xmm1=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm1=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:       xmm7 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm7=int6464#8
# asm 2: pand  <xmm4=%xmm4,<xmm7=%xmm7
pand  %xmm4,%xmm7

# qhasm:       xmm4 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm4=int6464#3
# asm 2: movdqa <xmm11=%xmm11,>xmm4=%xmm2
movdqa %xmm11,%xmm2

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#3,<xmm5=int6464#4
# asm 2: pand  <xmm4=%xmm2,<xmm5=%xmm3
pand  %xmm2,%xmm3

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm3=int6464#1
# asm 2: pxor  <xmm5=%xmm3,<xmm3=%xmm0
pxor  %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm5 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm5=int6464#3
# asm 2: movdqa <xmm15=%xmm15,>xmm5=%xmm2
movdqa %xmm15,%xmm2

# qhasm:       xmm5 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm5=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm5=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm4 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm4=int6464#4
# asm 2: movdqa <xmm13=%xmm13,>xmm4=%xmm3
movdqa %xmm13,%xmm3

# qhasm:       xmm1 = xmm5
# asm 1: movdqa <xmm5=int6464#3,>xmm1=int6464#5
# asm 2: movdqa <xmm5=%xmm2,>xmm1=%xmm4
movdqa %xmm2,%xmm4

# qhasm:       xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm3
pxor  %xmm14,%xmm3

# qhasm:       xmm1 |= xmm4
# asm 1: por   <xmm4=int6464#4,<xmm1=int6464#5
# asm 2: por   <xmm4=%xmm3,<xmm1=%xmm4
por   %xmm3,%xmm4

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#4,<xmm5=int6464#3
# asm 2: pand  <xmm4=%xmm3,<xmm5=%xmm2
pand  %xmm3,%xmm2

# qhasm:       xmm0 ^= xmm5
# asm 1: pxor  <xmm5=int6464#3,<xmm0=int6464#7
# asm 2: pxor  <xmm5=%xmm2,<xmm0=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#1
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm2=int6464#2
# asm 2: pxor  <xmm6=%xmm5,<xmm2=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm1 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm0 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm0=int6464#7
# asm 2: pxor  <xmm6=%xmm5,<xmm0=%xmm6
pxor  %xmm5,%xmm6

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm4 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm4=int6464#3
# asm 2: movdqa <xmm10=%xmm10,>xmm4=%xmm2
movdqa %xmm10,%xmm2

# qhasm:       xmm5 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm5=int6464#4
# asm 2: movdqa <xmm12=%xmm12,>xmm5=%xmm3
movdqa %xmm12,%xmm3

# qhasm:       xmm6 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm6=int6464#6
# asm 2: movdqa <xmm9=%xmm9,>xmm6=%xmm5
movdqa %xmm9,%xmm5

# qhasm:       xmm7 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm7=int6464#8
# asm 2: movdqa <xmm15=%xmm15,>xmm7=%xmm7
movdqa %xmm15,%xmm7

# qhasm:       xmm4 &= xmm11
# asm 1: pand  <xmm11=int6464#12,<xmm4=int6464#3
# asm 2: pand  <xmm11=%xmm11,<xmm4=%xmm2
pand  %xmm11,%xmm2

# qhasm:       xmm5 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm5=int6464#4
# asm 2: pand  <xmm8=%xmm8,<xmm5=%xmm3
pand  %xmm8,%xmm3

# qhasm:       xmm6 &= xmm13
# asm 1: pand  <xmm13=int6464#14,<xmm6=int6464#6
# asm 2: pand  <xmm13=%xmm13,<xmm6=%xmm5
pand  %xmm13,%xmm5

# qhasm:       xmm7 |= xmm14
# asm 1: por   <xmm14=int6464#15,<xmm7=int6464#8
# asm 2: por   <xmm14=%xmm14,<xmm7=%xmm7
por   %xmm14,%xmm7

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm3=int6464#1
# asm 2: pxor  <xmm4=%xmm2,<xmm3=%xmm0
pxor  %xmm2,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm0 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm0=int6464#7
# asm 2: pxor  <xmm7=%xmm7,<xmm0=%xmm6
pxor  %xmm7,%xmm6

# qhasm:       xmm4 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm4=int6464#3
# asm 2: movdqa <xmm3=%xmm0,>xmm4=%xmm2
movdqa %xmm0,%xmm2

# qhasm:       xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm4=int6464#3
# asm 2: pxor  <xmm2=%xmm1,<xmm4=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm3 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm3=int6464#1
# asm 2: pand  <xmm1=%xmm4,<xmm3=%xmm0
pand  %xmm4,%xmm0

# qhasm:       xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#7,>xmm6=int6464#4
# asm 2: movdqa <xmm0=%xmm6,>xmm6=%xmm3
movdqa %xmm6,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm3=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm7 = xmm4
# asm 1: movdqa <xmm4=int6464#3,>xmm7=int6464#6
# asm 2: movdqa <xmm4=%xmm2,>xmm7=%xmm5
movdqa %xmm2,%xmm5

# qhasm:       xmm7 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm7=int6464#6
# asm 2: pand  <xmm6=%xmm3,<xmm7=%xmm5
pand  %xmm3,%xmm5

# qhasm:       xmm7 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm7=int6464#6
# asm 2: pxor  <xmm2=%xmm1,<xmm7=%xmm5
pxor  %xmm1,%xmm5

# qhasm:       xmm5 = xmm1
# asm 1: movdqa <xmm1=int6464#5,>xmm5=int6464#8
# asm 2: movdqa <xmm1=%xmm4,>xmm5=%xmm7
movdqa %xmm4,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm3 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm3=int6464#1
# asm 2: pxor  <xmm2=%xmm1,<xmm3=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm5 &= xmm3
# asm 1: pand  <xmm3=int6464#1,<xmm5=int6464#8
# asm 2: pand  <xmm3=%xmm0,<xmm5=%xmm7
pand  %xmm0,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm5=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm2 = xmm6
# asm 1: movdqa <xmm6=int6464#4,>xmm2=int6464#1
# asm 2: movdqa <xmm6=%xmm3,>xmm2=%xmm0
movdqa %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm2=int6464#1
# asm 2: pxor  <xmm5=%xmm7,<xmm2=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 &= xmm0
# asm 1: pand  <xmm0=int6464#7,<xmm2=int6464#1
# asm 2: pand  <xmm0=%xmm6,<xmm2=%xmm0
pand  %xmm6,%xmm0

# qhasm:       xmm1 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm1=int6464#5
# asm 2: pxor  <xmm2=%xmm0,<xmm1=%xmm4
pxor  %xmm0,%xmm4

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm2=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm6=int6464#4
# asm 2: pand  <xmm7=%xmm5,<xmm6=%xmm3
pand  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm6=int6464#4
# asm 2: pxor  <xmm4=%xmm2,<xmm6=%xmm3
pxor  %xmm2,%xmm3

# qhasm:         xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm0
movdqa %xmm14,%xmm0

# qhasm:         xmm0 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm0=int6464#2
# asm 2: movdqa <xmm13=%xmm13,>xmm0=%xmm1
movdqa %xmm13,%xmm1

# qhasm:           xmm2 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm2=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm2=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm2 &= xmm14
# asm 1: pand  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pand  <xmm14=%xmm14,<xmm2=%xmm2
pand  %xmm14,%xmm2

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm14 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm14=int6464#15
# asm 2: pand  <xmm6=%xmm3,<xmm14=%xmm14
pand  %xmm3,%xmm14

# qhasm:           xmm13 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm13=int6464#14
# asm 2: pand  <xmm7=%xmm5,<xmm13=%xmm13
pand  %xmm5,%xmm13

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm13 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm13=int6464#14
# asm 2: pxor  <xmm2=%xmm2,<xmm13=%xmm13
pxor  %xmm2,%xmm13

# qhasm:         xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#2
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm1
pxor  %xmm11,%xmm1

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pand  <xmm8=%xmm8,<xmm2=%xmm2
pand  %xmm8,%xmm2

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm8=int6464#9
# asm 2: pand  <xmm1=%xmm4,<xmm8=%xmm8
pand  %xmm4,%xmm8

# qhasm:           xmm11 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm11=int6464#12
# asm 2: pand  <xmm5=%xmm7,<xmm11=%xmm11
pand  %xmm7,%xmm11

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm11 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm11=int6464#12
# asm 2: pxor  <xmm2=%xmm2,<xmm11=%xmm11
pxor  %xmm2,%xmm11

# qhasm:         xmm14 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm4=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:         xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm1,<xmm13=%xmm13
pxor  %xmm1,%xmm13

# qhasm:         xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm1,<xmm11=%xmm11
pxor  %xmm1,%xmm11

# qhasm:         xmm4 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm4=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm4=%xmm0
movdqa %xmm15,%xmm0

# qhasm:         xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm1
movdqa %xmm9,%xmm1

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm4=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm4=%xmm0
pxor  %xmm12,%xmm0

# qhasm:         xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm1
pxor  %xmm10,%xmm1

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pand  <xmm12=%xmm12,<xmm2=%xmm2
pand  %xmm12,%xmm2

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm12 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm12=int6464#13
# asm 2: pand  <xmm1=%xmm4,<xmm12=%xmm12
pand  %xmm4,%xmm12

# qhasm:           xmm10 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm10=int6464#11
# asm 2: pand  <xmm5=%xmm7,<xmm10=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#11
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm10
pxor  %xmm2,%xmm10

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm15
# asm 1: pand  <xmm15=int6464#16,<xmm3=int6464#3
# asm 2: pand  <xmm15=%xmm15,<xmm3=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm15 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm15=int6464#16
# asm 2: pand  <xmm6=%xmm3,<xmm15=%xmm15
pand  %xmm3,%xmm15

# qhasm:           xmm9 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm9=int6464#10
# asm 2: pand  <xmm7=%xmm5,<xmm9=%xmm9
pand  %xmm5,%xmm9

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm9=int6464#10
# asm 2: pxor  <xmm3=%xmm2,<xmm9=%xmm9
pxor  %xmm2,%xmm9

# qhasm:         xmm15 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm4=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm4=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:         xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:         xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm8,<xmm15=%xmm15
pxor  %xmm8,%xmm15

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm9=int6464#10
# asm 2: pxor  <xmm14=%xmm14,<xmm9=%xmm9
pxor  %xmm14,%xmm9

# qhasm:       xmm12 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm12=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm12=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm14 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm14=int6464#15
# asm 2: pxor  <xmm8=%xmm8,<xmm14=%xmm14
pxor  %xmm8,%xmm14

# qhasm:       xmm8 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm8=int6464#9
# asm 2: pxor  <xmm9=%xmm9,<xmm8=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm13 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm13=int6464#14
# asm 2: pxor  <xmm10=%xmm10,<xmm13=%xmm13
pxor  %xmm10,%xmm13

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm11=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm11=int6464#12
# asm 2: pxor  <xmm13=%xmm13,<xmm11=%xmm11
pxor  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:     xmm0 = shuffle dwords of xmm8 by 0x93
# asm 1: pshufd $0x93,<xmm8=int6464#9,>xmm0=int6464#1
# asm 2: pshufd $0x93,<xmm8=%xmm8,>xmm0=%xmm0
pshufd $0x93,%xmm8,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm9 by 0x93
# asm 1: pshufd $0x93,<xmm9=int6464#10,>xmm1=int6464#2
# asm 2: pshufd $0x93,<xmm9=%xmm9,>xmm1=%xmm1
pshufd $0x93,%xmm9,%xmm1

# qhasm:     xmm2 = shuffle dwords of xmm12 by 0x93
# asm 1: pshufd $0x93,<xmm12=int6464#13,>xmm2=int6464#3
# asm 2: pshufd $0x93,<xmm12=%xmm12,>xmm2=%xmm2
pshufd $0x93,%xmm12,%xmm2

# qhasm:     xmm3 = shuffle dwords of xmm14 by 0x93
# asm 1: pshufd $0x93,<xmm14=int6464#15,>xmm3=int6464#4
# asm 2: pshufd $0x93,<xmm14=%xmm14,>xmm3=%xmm3
pshufd $0x93,%xmm14,%xmm3

# qhasm:     xmm4 = shuffle dwords of xmm11 by 0x93
# asm 1: pshufd $0x93,<xmm11=int6464#12,>xmm4=int6464#5
# asm 2: pshufd $0x93,<xmm11=%xmm11,>xmm4=%xmm4
pshufd $0x93,%xmm11,%xmm4

# qhasm:     xmm5 = shuffle dwords of xmm15 by 0x93
# asm 1: pshufd $0x93,<xmm15=int6464#16,>xmm5=int6464#6
# asm 2: pshufd $0x93,<xmm15=%xmm15,>xmm5=%xmm5
pshufd $0x93,%xmm15,%xmm5

# qhasm:     xmm6 = shuffle dwords of xmm10 by 0x93
# asm 1: pshufd $0x93,<xmm10=int6464#11,>xmm6=int6464#7
# asm 2: pshufd $0x93,<xmm10=%xmm10,>xmm6=%xmm6
pshufd $0x93,%xmm10,%xmm6

# qhasm:     xmm7 = shuffle dwords of xmm13 by 0x93
# asm 1: pshufd $0x93,<xmm13=int6464#14,>xmm7=int6464#8
# asm 2: pshufd $0x93,<xmm13=%xmm13,>xmm7=%xmm7
pshufd $0x93,%xmm13,%xmm7

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm12 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm12=int6464#13
# asm 2: pxor  <xmm2=%xmm2,<xmm12=%xmm12
pxor  %xmm2,%xmm12

# qhasm:     xmm14 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm14=int6464#15
# asm 2: pxor  <xmm3=%xmm3,<xmm14=%xmm14
pxor  %xmm3,%xmm14

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm10 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pxor  <xmm6=%xmm6,<xmm10=%xmm10
pxor  %xmm6,%xmm10

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm8,<xmm1=%xmm1
pxor  %xmm8,%xmm1

# qhasm:     xmm2 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:     xmm1 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm1=int6464#2
# asm 2: pxor  <xmm13=%xmm13,<xmm1=%xmm1
pxor  %xmm13,%xmm1

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#5
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm4
pxor  %xmm14,%xmm4

# qhasm:     xmm5 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm5=int6464#6
# asm 2: pxor  <xmm11=%xmm11,<xmm5=%xmm5
pxor  %xmm11,%xmm5

# qhasm:     xmm3 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm3=int6464#4
# asm 2: pxor  <xmm13=%xmm13,<xmm3=%xmm3
pxor  %xmm13,%xmm3

# qhasm:     xmm6 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm6=int6464#7
# asm 2: pxor  <xmm15=%xmm15,<xmm6=%xmm6
pxor  %xmm15,%xmm6

# qhasm:     xmm7 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm7=int6464#8
# asm 2: pxor  <xmm10=%xmm10,<xmm7=%xmm7
pxor  %xmm10,%xmm7

# qhasm:     xmm4 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm4=int6464#5
# asm 2: pxor  <xmm13=%xmm13,<xmm4=%xmm4
pxor  %xmm13,%xmm4

# qhasm:     xmm8 = shuffle dwords of xmm8 by 0x4E
# asm 1: pshufd $0x4E,<xmm8=int6464#9,>xmm8=int6464#9
# asm 2: pshufd $0x4E,<xmm8=%xmm8,>xmm8=%xmm8
pshufd $0x4E,%xmm8,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm9 by 0x4E
# asm 1: pshufd $0x4E,<xmm9=int6464#10,>xmm9=int6464#10
# asm 2: pshufd $0x4E,<xmm9=%xmm9,>xmm9=%xmm9
pshufd $0x4E,%xmm9,%xmm9

# qhasm:     xmm12 = shuffle dwords of xmm12 by 0x4E
# asm 1: pshufd $0x4E,<xmm12=int6464#13,>xmm12=int6464#13
# asm 2: pshufd $0x4E,<xmm12=%xmm12,>xmm12=%xmm12
pshufd $0x4E,%xmm12,%xmm12

# qhasm:     xmm14 = shuffle dwords of xmm14 by 0x4E
# asm 1: pshufd $0x4E,<xmm14=int6464#15,>xmm14=int6464#15
# asm 2: pshufd $0x4E,<xmm14=%xmm14,>xmm14=%xmm14
pshufd $0x4E,%xmm14,%xmm14

# qhasm:     xmm11 = shuffle dwords of xmm11 by 0x4E
# asm 1: pshufd $0x4E,<xmm11=int6464#12,>xmm11=int6464#12
# asm 2: pshufd $0x4E,<xmm11=%xmm11,>xmm11=%xmm11
pshufd $0x4E,%xmm11,%xmm11

# qhasm:     xmm15 = shuffle dwords of xmm15 by 0x4E
# asm 1: pshufd $0x4E,<xmm15=int6464#16,>xmm15=int6464#16
# asm 2: pshufd $0x4E,<xmm15=%xmm15,>xmm15=%xmm15
pshufd $0x4E,%xmm15,%xmm15

# qhasm:     xmm10 = shuffle dwords of xmm10 by 0x4E
# asm 1: pshufd $0x4E,<xmm10=int6464#11,>xmm10=int6464#11
# asm 2: pshufd $0x4E,<xmm10=%xmm10,>xmm10=%xmm10
pshufd $0x4E,%xmm10,%xmm10

# qhasm:     xmm13 = shuffle dwords of xmm13 by 0x4E
# asm 1: pshufd $0x4E,<xmm13=int6464#14,>xmm13=int6464#14
# asm 2: pshufd $0x4E,<xmm13=%xmm13,>xmm13=%xmm13
pshufd $0x4E,%xmm13,%xmm13

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm2 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pxor  <xmm12=%xmm12,<xmm2=%xmm2
pxor  %xmm12,%xmm2

# qhasm:     xmm3 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm3=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm3=%xmm3
pxor  %xmm14,%xmm3

# qhasm:     xmm4 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm4=int6464#5
# asm 2: pxor  <xmm11=%xmm11,<xmm4=%xmm4
pxor  %xmm11,%xmm4

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm6 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm6=int6464#7
# asm 2: pxor  <xmm10=%xmm10,<xmm6=%xmm6
pxor  %xmm10,%xmm6

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm0 ^= *(int128 *)(c + 1024)
# asm 1: pxor 1024(<c=int64#2),<xmm0=int6464#1
# asm 2: pxor 1024(<c=%rsi),<xmm0=%xmm0
pxor 1024(%rsi),%xmm0

# qhasm:     shuffle bytes of xmm0 by SR
# asm 1: pshufb SR,<xmm0=int6464#1
# asm 2: pshufb SR,<xmm0=%xmm0
pshufb SR,%xmm0

# qhasm:     xmm1 ^= *(int128 *)(c + 1040)
# asm 1: pxor 1040(<c=int64#2),<xmm1=int6464#2
# asm 2: pxor 1040(<c=%rsi),<xmm1=%xmm1
pxor 1040(%rsi),%xmm1

# qhasm:     shuffle bytes of xmm1 by SR
# asm 1: pshufb SR,<xmm1=int6464#2
# asm 2: pshufb SR,<xmm1=%xmm1
pshufb SR,%xmm1

# qhasm:     xmm2 ^= *(int128 *)(c + 1056)
# asm 1: pxor 1056(<c=int64#2),<xmm2=int6464#3
# asm 2: pxor 1056(<c=%rsi),<xmm2=%xmm2
pxor 1056(%rsi),%xmm2

# qhasm:     shuffle bytes of xmm2 by SR
# asm 1: pshufb SR,<xmm2=int6464#3
# asm 2: pshufb SR,<xmm2=%xmm2
pshufb SR,%xmm2

# qhasm:     xmm3 ^= *(int128 *)(c + 1072)
# asm 1: pxor 1072(<c=int64#2),<xmm3=int6464#4
# asm 2: pxor 1072(<c=%rsi),<xmm3=%xmm3
pxor 1072(%rsi),%xmm3

# qhasm:     shuffle bytes of xmm3 by SR
# asm 1: pshufb SR,<xmm3=int6464#4
# asm 2: pshufb SR,<xmm3=%xmm3
pshufb SR,%xmm3

# qhasm:     xmm4 ^= *(int128 *)(c + 1088)
# asm 1: pxor 1088(<c=int64#2),<xmm4=int6464#5
# asm 2: pxor 1088(<c=%rsi),<xmm4=%xmm4
pxor 1088(%rsi),%xmm4

# qhasm:     shuffle bytes of xmm4 by SR
# asm 1: pshufb SR,<xmm4=int6464#5
# asm 2: pshufb SR,<xmm4=%xmm4
pshufb SR,%xmm4

# qhasm:     xmm5 ^= *(int128 *)(c + 1104)
# asm 1: pxor 1104(<c=int64#2),<xmm5=int6464#6
# asm 2: pxor 1104(<c=%rsi),<xmm5=%xmm5
pxor 1104(%rsi),%xmm5

# qhasm:     shuffle bytes of xmm5 by SR
# asm 1: pshufb SR,<xmm5=int6464#6
# asm 2: pshufb SR,<xmm5=%xmm5
pshufb SR,%xmm5

# qhasm:     xmm6 ^= *(int128 *)(c + 1120)
# asm 1: pxor 1120(<c=int64#2),<xmm6=int6464#7
# asm 2: pxor 1120(<c=%rsi),<xmm6=%xmm6
pxor 1120(%rsi),%xmm6

# qhasm:     shuffle bytes of xmm6 by SR
# asm 1: pshufb SR,<xmm6=int6464#7
# asm 2: pshufb SR,<xmm6=%xmm6
pshufb SR,%xmm6

# qhasm:     xmm7 ^= *(int128 *)(c + 1136)
# asm 1: pxor 1136(<c=int64#2),<xmm7=int6464#8
# asm 2: pxor 1136(<c=%rsi),<xmm7=%xmm7
pxor 1136(%rsi),%xmm7

# qhasm:     shuffle bytes of xmm7 by SR
# asm 1: pshufb SR,<xmm7=int6464#8
# asm 2: pshufb SR,<xmm7=%xmm7
pshufb SR,%xmm7

# qhasm:       xmm5 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm5=int6464#6
# asm 2: pxor  <xmm6=%xmm6,<xmm5=%xmm5
pxor  %xmm6,%xmm5

# qhasm:       xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm1,<xmm2=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm5=int6464#6
# asm 2: pxor  <xmm0=%xmm0,<xmm5=%xmm5
pxor  %xmm0,%xmm5

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm6=int6464#7
# asm 2: pxor  <xmm2=%xmm2,<xmm6=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm3=int6464#4
# asm 2: pxor  <xmm0=%xmm0,<xmm3=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#4
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm3
pxor  %xmm7,%xmm3

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm3=int6464#4
# asm 2: pxor  <xmm4=%xmm4,<xmm3=%xmm3
pxor  %xmm4,%xmm3

# qhasm:       xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm7=int6464#8
# asm 2: pxor  <xmm5=%xmm5,<xmm7=%xmm7
pxor  %xmm5,%xmm7

# qhasm:       xmm3 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm3=int6464#4
# asm 2: pxor  <xmm1=%xmm1,<xmm3=%xmm3
pxor  %xmm1,%xmm3

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm2=int6464#3
# asm 2: pxor  <xmm7=%xmm7,<xmm2=%xmm2
pxor  %xmm7,%xmm2

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm11 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm11=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm11=%xmm8
movdqa %xmm7,%xmm8

# qhasm:       xmm10 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm10=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm10=%xmm9
movdqa %xmm1,%xmm9

# qhasm:       xmm9 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm9=int6464#11
# asm 2: movdqa <xmm5=%xmm5,>xmm9=%xmm10
movdqa %xmm5,%xmm10

# qhasm:       xmm13 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm13=int6464#12
# asm 2: movdqa <xmm2=%xmm2,>xmm13=%xmm11
movdqa %xmm2,%xmm11

# qhasm:       xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#13
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm12
movdqa %xmm6,%xmm12

# qhasm:       xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm8
pxor  %xmm4,%xmm8

# qhasm:       xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm9
pxor  %xmm2,%xmm9

# qhasm:       xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm9=int6464#11
# asm 2: pxor  <xmm3=%xmm3,<xmm9=%xmm10
pxor  %xmm3,%xmm10

# qhasm:       xmm13 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm13=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm13=%xmm11
pxor  %xmm4,%xmm11

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:       xmm14 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm14=int6464#14
# asm 2: movdqa <xmm11=%xmm8,>xmm14=%xmm13
movdqa %xmm8,%xmm13

# qhasm:       xmm8 = xmm10
# asm 1: movdqa <xmm10=int6464#10,>xmm8=int6464#15
# asm 2: movdqa <xmm10=%xmm9,>xmm8=%xmm14
movdqa %xmm9,%xmm14

# qhasm:       xmm15 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm15=int6464#16
# asm 2: movdqa <xmm11=%xmm8,>xmm15=%xmm15
movdqa %xmm8,%xmm15

# qhasm:       xmm10 |= xmm9
# asm 1: por   <xmm9=int6464#11,<xmm10=int6464#10
# asm 2: por   <xmm9=%xmm10,<xmm10=%xmm9
por   %xmm10,%xmm9

# qhasm:       xmm11 |= xmm12
# asm 1: por   <xmm12=int6464#13,<xmm11=int6464#9
# asm 2: por   <xmm12=%xmm12,<xmm11=%xmm8
por   %xmm12,%xmm8

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm15=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm14 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm14=int6464#14
# asm 2: pand  <xmm12=%xmm12,<xmm14=%xmm13
pand  %xmm12,%xmm13

# qhasm:       xmm8 &= xmm9
# asm 1: pand  <xmm9=int6464#11,<xmm8=int6464#15
# asm 2: pand  <xmm9=%xmm10,<xmm8=%xmm14
pand  %xmm10,%xmm14

# qhasm:       xmm12 ^= xmm9
# asm 1: pxor  <xmm9=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm9=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:       xmm15 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm15=int6464#16
# asm 2: pand  <xmm12=%xmm12,<xmm15=%xmm15
pand  %xmm12,%xmm15

# qhasm:       xmm12 = xmm3
# asm 1: movdqa <xmm3=int6464#4,>xmm12=int6464#11
# asm 2: movdqa <xmm3=%xmm3,>xmm12=%xmm10
movdqa %xmm3,%xmm10

# qhasm:       xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm10
pxor  %xmm0,%xmm10

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#11,<xmm13=int6464#12
# asm 2: pand  <xmm12=%xmm10,<xmm13=%xmm11
pand  %xmm10,%xmm11

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm11=int6464#9
# asm 2: pxor  <xmm13=%xmm11,<xmm11=%xmm8
pxor  %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm13 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm13=int6464#11
# asm 2: movdqa <xmm7=%xmm7,>xmm13=%xmm10
movdqa %xmm7,%xmm10

# qhasm:       xmm13 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm13=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm13=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm12 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm12=int6464#12
# asm 2: movdqa <xmm5=%xmm5,>xmm12=%xmm11
movdqa %xmm5,%xmm11

# qhasm:       xmm9 = xmm13
# asm 1: movdqa <xmm13=int6464#11,>xmm9=int6464#13
# asm 2: movdqa <xmm13=%xmm10,>xmm9=%xmm12
movdqa %xmm10,%xmm12

# qhasm:       xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm11
pxor  %xmm6,%xmm11

# qhasm:       xmm9 |= xmm12
# asm 1: por   <xmm12=int6464#12,<xmm9=int6464#13
# asm 2: por   <xmm12=%xmm11,<xmm9=%xmm12
por   %xmm11,%xmm12

# qhasm:       xmm13 &= xmm12
# asm 1: pand  <xmm12=int6464#12,<xmm13=int6464#11
# asm 2: pand  <xmm12=%xmm11,<xmm13=%xmm10
pand  %xmm11,%xmm10

# qhasm:       xmm8 ^= xmm13
# asm 1: pxor  <xmm13=int6464#11,<xmm8=int6464#15
# asm 2: pxor  <xmm13=%xmm10,<xmm8=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#9
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm10=int6464#10
# asm 2: pxor  <xmm14=%xmm13,<xmm10=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm9 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm8 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm8=int6464#15
# asm 2: pxor  <xmm14=%xmm13,<xmm8=%xmm14
pxor  %xmm13,%xmm14

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm12 = xmm2
# asm 1: movdqa <xmm2=int6464#3,>xmm12=int6464#11
# asm 2: movdqa <xmm2=%xmm2,>xmm12=%xmm10
movdqa %xmm2,%xmm10

# qhasm:       xmm13 = xmm4
# asm 1: movdqa <xmm4=int6464#5,>xmm13=int6464#12
# asm 2: movdqa <xmm4=%xmm4,>xmm13=%xmm11
movdqa %xmm4,%xmm11

# qhasm:       xmm14 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm14=int6464#14
# asm 2: movdqa <xmm1=%xmm1,>xmm14=%xmm13
movdqa %xmm1,%xmm13

# qhasm:       xmm15 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm15=int6464#16
# asm 2: movdqa <xmm7=%xmm7,>xmm15=%xmm15
movdqa %xmm7,%xmm15

# qhasm:       xmm12 &= xmm3
# asm 1: pand  <xmm3=int6464#4,<xmm12=int6464#11
# asm 2: pand  <xmm3=%xmm3,<xmm12=%xmm10
pand  %xmm3,%xmm10

# qhasm:       xmm13 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm13=int6464#12
# asm 2: pand  <xmm0=%xmm0,<xmm13=%xmm11
pand  %xmm0,%xmm11

# qhasm:       xmm14 &= xmm5
# asm 1: pand  <xmm5=int6464#6,<xmm14=int6464#14
# asm 2: pand  <xmm5=%xmm5,<xmm14=%xmm13
pand  %xmm5,%xmm13

# qhasm:       xmm15 |= xmm6
# asm 1: por   <xmm6=int6464#7,<xmm15=int6464#16
# asm 2: por   <xmm6=%xmm6,<xmm15=%xmm15
por   %xmm6,%xmm15

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm11=int6464#9
# asm 2: pxor  <xmm12=%xmm10,<xmm11=%xmm8
pxor  %xmm10,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#12,<xmm10=int6464#10
# asm 2: pxor  <xmm13=%xmm11,<xmm10=%xmm9
pxor  %xmm11,%xmm9

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#14,<xmm9=int6464#13
# asm 2: pxor  <xmm14=%xmm13,<xmm9=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm8 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm8=int6464#15
# asm 2: pxor  <xmm15=%xmm15,<xmm8=%xmm14
pxor  %xmm15,%xmm14

# qhasm:       xmm12 = xmm11
# asm 1: movdqa <xmm11=int6464#9,>xmm12=int6464#11
# asm 2: movdqa <xmm11=%xmm8,>xmm12=%xmm10
movdqa %xmm8,%xmm10

# qhasm:       xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm12=int6464#11
# asm 2: pxor  <xmm10=%xmm9,<xmm12=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm11 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm11=int6464#9
# asm 2: pand  <xmm9=%xmm12,<xmm11=%xmm8
pand  %xmm12,%xmm8

# qhasm:       xmm14 = xmm8
# asm 1: movdqa <xmm8=int6464#15,>xmm14=int6464#12
# asm 2: movdqa <xmm8=%xmm14,>xmm14=%xmm11
movdqa %xmm14,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm11=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm15 = xmm12
# asm 1: movdqa <xmm12=int6464#11,>xmm15=int6464#14
# asm 2: movdqa <xmm12=%xmm10,>xmm15=%xmm13
movdqa %xmm10,%xmm13

# qhasm:       xmm15 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm15=int6464#14
# asm 2: pand  <xmm14=%xmm11,<xmm15=%xmm13
pand  %xmm11,%xmm13

# qhasm:       xmm15 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm15=int6464#14
# asm 2: pxor  <xmm10=%xmm9,<xmm15=%xmm13
pxor  %xmm9,%xmm13

# qhasm:       xmm13 = xmm9
# asm 1: movdqa <xmm9=int6464#13,>xmm13=int6464#16
# asm 2: movdqa <xmm9=%xmm12,>xmm13=%xmm15
movdqa %xmm12,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm11 ^= xmm10
# asm 1: pxor  <xmm10=int6464#10,<xmm11=int6464#9
# asm 2: pxor  <xmm10=%xmm9,<xmm11=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm13 &= xmm11
# asm 1: pand  <xmm11=int6464#9,<xmm13=int6464#16
# asm 2: pand  <xmm11=%xmm8,<xmm13=%xmm15
pand  %xmm8,%xmm15

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#15,<xmm13=int6464#16
# asm 2: pxor  <xmm8=%xmm14,<xmm13=%xmm15
pxor  %xmm14,%xmm15

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm9=int6464#13
# asm 2: pxor  <xmm13=%xmm15,<xmm9=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm10 = xmm14
# asm 1: movdqa <xmm14=int6464#12,>xmm10=int6464#9
# asm 2: movdqa <xmm14=%xmm11,>xmm10=%xmm8
movdqa %xmm11,%xmm8

# qhasm:       xmm10 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm10=int6464#9
# asm 2: pxor  <xmm13=%xmm15,<xmm10=%xmm8
pxor  %xmm15,%xmm8

# qhasm:       xmm10 &= xmm8
# asm 1: pand  <xmm8=int6464#15,<xmm10=int6464#9
# asm 2: pand  <xmm8=%xmm14,<xmm10=%xmm8
pand  %xmm14,%xmm8

# qhasm:       xmm9 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm9=int6464#13
# asm 2: pxor  <xmm10=%xmm8,<xmm9=%xmm12
pxor  %xmm8,%xmm12

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#9,<xmm14=int6464#12
# asm 2: pxor  <xmm10=%xmm8,<xmm14=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm14=int6464#12
# asm 2: pand  <xmm15=%xmm13,<xmm14=%xmm11
pand  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm12
# asm 1: pxor  <xmm12=int6464#11,<xmm14=int6464#12
# asm 2: pxor  <xmm12=%xmm10,<xmm14=%xmm11
pxor  %xmm10,%xmm11

# qhasm:         xmm12 = xmm6
# asm 1: movdqa <xmm6=int6464#7,>xmm12=int6464#9
# asm 2: movdqa <xmm6=%xmm6,>xmm12=%xmm8
movdqa %xmm6,%xmm8

# qhasm:         xmm8 = xmm5
# asm 1: movdqa <xmm5=int6464#6,>xmm8=int6464#10
# asm 2: movdqa <xmm5=%xmm5,>xmm8=%xmm9
movdqa %xmm5,%xmm9

# qhasm:           xmm10 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm10=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm10=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm10 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm10 &= xmm6
# asm 1: pand  <xmm6=int6464#7,<xmm10=int6464#11
# asm 2: pand  <xmm6=%xmm6,<xmm10=%xmm10
pand  %xmm6,%xmm10

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm6 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm6=int6464#7
# asm 2: pand  <xmm14=%xmm11,<xmm6=%xmm6
pand  %xmm11,%xmm6

# qhasm:           xmm5 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm5=int6464#6
# asm 2: pand  <xmm15=%xmm13,<xmm5=%xmm5
pand  %xmm13,%xmm5

# qhasm:           xmm6 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm6=int6464#7
# asm 2: pxor  <xmm5=%xmm5,<xmm6=%xmm6
pxor  %xmm5,%xmm6

# qhasm:           xmm5 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm5=int6464#6
# asm 2: pxor  <xmm10=%xmm10,<xmm5=%xmm5
pxor  %xmm10,%xmm5

# qhasm:         xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm8 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm8=int6464#10
# asm 2: pxor  <xmm3=%xmm3,<xmm8=%xmm9
pxor  %xmm3,%xmm9

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm0
# asm 1: pand  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pand  <xmm0=%xmm0,<xmm10=%xmm10
pand  %xmm0,%xmm10

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm0=int6464#1
# asm 2: pand  <xmm9=%xmm12,<xmm0=%xmm0
pand  %xmm12,%xmm0

# qhasm:           xmm3 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm3=int6464#4
# asm 2: pand  <xmm13=%xmm15,<xmm3=%xmm3
pand  %xmm15,%xmm3

# qhasm:           xmm0 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm0=int6464#1
# asm 2: pxor  <xmm3=%xmm3,<xmm0=%xmm0
pxor  %xmm3,%xmm0

# qhasm:           xmm3 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm3=int6464#4
# asm 2: pxor  <xmm10=%xmm10,<xmm3=%xmm3
pxor  %xmm10,%xmm3

# qhasm:         xmm6 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm6=int6464#7
# asm 2: pxor  <xmm12=%xmm8,<xmm6=%xmm6
pxor  %xmm8,%xmm6

# qhasm:         xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm5 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm5=int6464#6
# asm 2: pxor  <xmm8=%xmm9,<xmm5=%xmm5
pxor  %xmm9,%xmm5

# qhasm:         xmm3 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm3=int6464#4
# asm 2: pxor  <xmm8=%xmm9,<xmm3=%xmm3
pxor  %xmm9,%xmm3

# qhasm:         xmm12 = xmm7
# asm 1: movdqa <xmm7=int6464#8,>xmm12=int6464#9
# asm 2: movdqa <xmm7=%xmm7,>xmm12=%xmm8
movdqa %xmm7,%xmm8

# qhasm:         xmm8 = xmm1
# asm 1: movdqa <xmm1=int6464#2,>xmm8=int6464#10
# asm 2: movdqa <xmm1=%xmm1,>xmm8=%xmm9
movdqa %xmm1,%xmm9

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm12=int6464#9
# asm 2: pxor  <xmm4=%xmm4,<xmm12=%xmm8
pxor  %xmm4,%xmm8

# qhasm:         xmm8 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm8=int6464#10
# asm 2: pxor  <xmm2=%xmm2,<xmm8=%xmm9
pxor  %xmm2,%xmm9

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm12
# asm 1: pand  <xmm12=int6464#9,<xmm11=int6464#11
# asm 2: pand  <xmm12=%xmm8,<xmm11=%xmm10
pand  %xmm8,%xmm10

# qhasm:           xmm12 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm12=int6464#9
# asm 2: pxor  <xmm8=%xmm9,<xmm12=%xmm8
pxor  %xmm9,%xmm8

# qhasm:           xmm12 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm12=int6464#9
# asm 2: pand  <xmm14=%xmm11,<xmm12=%xmm8
pand  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm8=int6464#10
# asm 2: pand  <xmm15=%xmm13,<xmm8=%xmm9
pand  %xmm13,%xmm9

# qhasm:           xmm8 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm8=int6464#10
# asm 2: pxor  <xmm12=%xmm8,<xmm8=%xmm9
pxor  %xmm8,%xmm9

# qhasm:           xmm12 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm12=int6464#9
# asm 2: pxor  <xmm11=%xmm10,<xmm12=%xmm8
pxor  %xmm10,%xmm8

# qhasm:           xmm10 = xmm13
# asm 1: movdqa <xmm13=int6464#16,>xmm10=int6464#11
# asm 2: movdqa <xmm13=%xmm15,>xmm10=%xmm10
movdqa %xmm15,%xmm10

# qhasm:           xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm12,<xmm10=%xmm10
pxor  %xmm12,%xmm10

# qhasm:           xmm10 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pand  <xmm4=%xmm4,<xmm10=%xmm10
pand  %xmm4,%xmm10

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm4 &= xmm9
# asm 1: pand  <xmm9=int6464#13,<xmm4=int6464#5
# asm 2: pand  <xmm9=%xmm12,<xmm4=%xmm4
pand  %xmm12,%xmm4

# qhasm:           xmm2 &= xmm13
# asm 1: pand  <xmm13=int6464#16,<xmm2=int6464#3
# asm 2: pand  <xmm13=%xmm15,<xmm2=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm2=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:           xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#3
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm2
pxor  %xmm10,%xmm2

# qhasm:         xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#16,<xmm15=int6464#14
# asm 2: pxor  <xmm13=%xmm15,<xmm15=%xmm13
pxor  %xmm15,%xmm13

# qhasm:         xmm14 ^= xmm9
# asm 1: pxor  <xmm9=int6464#13,<xmm14=int6464#12
# asm 2: pxor  <xmm9=%xmm12,<xmm14=%xmm11
pxor  %xmm12,%xmm11

# qhasm:           xmm11 = xmm15
# asm 1: movdqa <xmm15=int6464#14,>xmm11=int6464#11
# asm 2: movdqa <xmm15=%xmm13,>xmm11=%xmm10
movdqa %xmm13,%xmm10

# qhasm:           xmm11 ^= xmm14
# asm 1: pxor  <xmm14=int6464#12,<xmm11=int6464#11
# asm 2: pxor  <xmm14=%xmm11,<xmm11=%xmm10
pxor  %xmm11,%xmm10

# qhasm:           xmm11 &= xmm7
# asm 1: pand  <xmm7=int6464#8,<xmm11=int6464#11
# asm 2: pand  <xmm7=%xmm7,<xmm11=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm7 &= xmm14
# asm 1: pand  <xmm14=int6464#12,<xmm7=int6464#8
# asm 2: pand  <xmm14=%xmm11,<xmm7=%xmm7
pand  %xmm11,%xmm7

# qhasm:           xmm1 &= xmm15
# asm 1: pand  <xmm15=int6464#14,<xmm1=int6464#2
# asm 2: pand  <xmm15=%xmm13,<xmm1=%xmm1
pand  %xmm13,%xmm1

# qhasm:           xmm7 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm7=int6464#8
# asm 2: pxor  <xmm1=%xmm1,<xmm7=%xmm7
pxor  %xmm1,%xmm7

# qhasm:           xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#11,<xmm1=int6464#2
# asm 2: pxor  <xmm11=%xmm10,<xmm1=%xmm1
pxor  %xmm10,%xmm1

# qhasm:         xmm7 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm7=int6464#8
# asm 2: pxor  <xmm12=%xmm8,<xmm7=%xmm7
pxor  %xmm8,%xmm7

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm12=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:         xmm1 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm8=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:         xmm2 ^= xmm8
# asm 1: pxor  <xmm8=int6464#10,<xmm2=int6464#3
# asm 2: pxor  <xmm8=%xmm9,<xmm2=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm0,<xmm7=%xmm7
pxor  %xmm0,%xmm7

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm1=int6464#2
# asm 2: pxor  <xmm6=%xmm6,<xmm1=%xmm1
pxor  %xmm6,%xmm1

# qhasm:       xmm4 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm4=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm4=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm6 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm6=int6464#7
# asm 2: pxor  <xmm0=%xmm0,<xmm6=%xmm6
pxor  %xmm0,%xmm6

# qhasm:       xmm0 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm0=int6464#1
# asm 2: pxor  <xmm1=%xmm1,<xmm0=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm1=int6464#2
# asm 2: pxor  <xmm5=%xmm5,<xmm1=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm5 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm5=int6464#6
# asm 2: pxor  <xmm2=%xmm2,<xmm5=%xmm5
pxor  %xmm2,%xmm5

# qhasm:       xmm4 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm4=int6464#5
# asm 2: pxor  <xmm5=%xmm5,<xmm4=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm2 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm3=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm3=int6464#4
# asm 2: pxor  <xmm5=%xmm5,<xmm3=%xmm3
pxor  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm6=int6464#7
# asm 2: pxor  <xmm3=%xmm3,<xmm6=%xmm6
pxor  %xmm3,%xmm6

# qhasm:     xmm8 = shuffle dwords of xmm0 by 0x93
# asm 1: pshufd $0x93,<xmm0=int6464#1,>xmm8=int6464#9
# asm 2: pshufd $0x93,<xmm0=%xmm0,>xmm8=%xmm8
pshufd $0x93,%xmm0,%xmm8

# qhasm:     xmm9 = shuffle dwords of xmm1 by 0x93
# asm 1: pshufd $0x93,<xmm1=int6464#2,>xmm9=int6464#10
# asm 2: pshufd $0x93,<xmm1=%xmm1,>xmm9=%xmm9
pshufd $0x93,%xmm1,%xmm9

# qhasm:     xmm10 = shuffle dwords of xmm4 by 0x93
# asm 1: pshufd $0x93,<xmm4=int6464#5,>xmm10=int6464#11
# asm 2: pshufd $0x93,<xmm4=%xmm4,>xmm10=%xmm10
pshufd $0x93,%xmm4,%xmm10

# qhasm:     xmm11 = shuffle dwords of xmm6 by 0x93
# asm 1: pshufd $0x93,<xmm6=int6464#7,>xmm11=int6464#12
# asm 2: pshufd $0x93,<xmm6=%xmm6,>xmm11=%xmm11
pshufd $0x93,%xmm6,%xmm11

# qhasm:     xmm12 = shuffle dwords of xmm3 by 0x93
# asm 1: pshufd $0x93,<xmm3=int6464#4,>xmm12=int6464#13
# asm 2: pshufd $0x93,<xmm3=%xmm3,>xmm12=%xmm12
pshufd $0x93,%xmm3,%xmm12

# qhasm:     xmm13 = shuffle dwords of xmm7 by 0x93
# asm 1: pshufd $0x93,<xmm7=int6464#8,>xmm13=int6464#14
# asm 2: pshufd $0x93,<xmm7=%xmm7,>xmm13=%xmm13
pshufd $0x93,%xmm7,%xmm13

# qhasm:     xmm14 = shuffle dwords of xmm2 by 0x93
# asm 1: pshufd $0x93,<xmm2=int6464#3,>xmm14=int6464#15
# asm 2: pshufd $0x93,<xmm2=%xmm2,>xmm14=%xmm14
pshufd $0x93,%xmm2,%xmm14

# qhasm:     xmm15 = shuffle dwords of xmm5 by 0x93
# asm 1: pshufd $0x93,<xmm5=int6464#6,>xmm15=int6464#16
# asm 2: pshufd $0x93,<xmm5=%xmm5,>xmm15=%xmm15
pshufd $0x93,%xmm5,%xmm15

# qhasm:     xmm0 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm0=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm0=%xmm0
pxor  %xmm8,%xmm0

# qhasm:     xmm1 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm1=int6464#2
# asm 2: pxor  <xmm9=%xmm9,<xmm1=%xmm1
pxor  %xmm9,%xmm1

# qhasm:     xmm4 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm4=int6464#5
# asm 2: pxor  <xmm10=%xmm10,<xmm4=%xmm4
pxor  %xmm10,%xmm4

# qhasm:     xmm6 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm6=int6464#7
# asm 2: pxor  <xmm11=%xmm11,<xmm6=%xmm6
pxor  %xmm11,%xmm6

# qhasm:     xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm3
pxor  %xmm12,%xmm3

# qhasm:     xmm7 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm7=int6464#8
# asm 2: pxor  <xmm13=%xmm13,<xmm7=%xmm7
pxor  %xmm13,%xmm7

# qhasm:     xmm2 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pxor  <xmm14=%xmm14,<xmm2=%xmm2
pxor  %xmm14,%xmm2

# qhasm:     xmm5 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm5=int6464#6
# asm 2: pxor  <xmm15=%xmm15,<xmm5=%xmm5
pxor  %xmm15,%xmm5

# qhasm:     xmm8 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm8=int6464#9
# asm 2: pxor  <xmm5=%xmm5,<xmm8=%xmm8
pxor  %xmm5,%xmm8

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm10 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm1=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:     xmm9 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm9=int6464#10
# asm 2: pxor  <xmm5=%xmm5,<xmm9=%xmm9
pxor  %xmm5,%xmm9

# qhasm:     xmm11 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm11=int6464#12
# asm 2: pxor  <xmm4=%xmm4,<xmm11=%xmm11
pxor  %xmm4,%xmm11

# qhasm:     xmm12 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm12=int6464#13
# asm 2: pxor  <xmm6=%xmm6,<xmm12=%xmm12
pxor  %xmm6,%xmm12

# qhasm:     xmm13 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm13=int6464#14
# asm 2: pxor  <xmm3=%xmm3,<xmm13=%xmm13
pxor  %xmm3,%xmm13

# qhasm:     xmm11 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm11=int6464#12
# asm 2: pxor  <xmm5=%xmm5,<xmm11=%xmm11
pxor  %xmm5,%xmm11

# qhasm:     xmm14 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm14=int6464#15
# asm 2: pxor  <xmm7=%xmm7,<xmm14=%xmm14
pxor  %xmm7,%xmm14

# qhasm:     xmm15 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm15=int6464#16
# asm 2: pxor  <xmm2=%xmm2,<xmm15=%xmm15
pxor  %xmm2,%xmm15

# qhasm:     xmm12 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm12=int6464#13
# asm 2: pxor  <xmm5=%xmm5,<xmm12=%xmm12
pxor  %xmm5,%xmm12

# qhasm:     xmm0 = shuffle dwords of xmm0 by 0x4E
# asm 1: pshufd $0x4E,<xmm0=int6464#1,>xmm0=int6464#1
# asm 2: pshufd $0x4E,<xmm0=%xmm0,>xmm0=%xmm0
pshufd $0x4E,%xmm0,%xmm0

# qhasm:     xmm1 = shuffle dwords of xmm1 by 0x4E
# asm 1: pshufd $0x4E,<xmm1=int6464#2,>xmm1=int6464#2
# asm 2: pshufd $0x4E,<xmm1=%xmm1,>xmm1=%xmm1
pshufd $0x4E,%xmm1,%xmm1

# qhasm:     xmm4 = shuffle dwords of xmm4 by 0x4E
# asm 1: pshufd $0x4E,<xmm4=int6464#5,>xmm4=int6464#5
# asm 2: pshufd $0x4E,<xmm4=%xmm4,>xmm4=%xmm4
pshufd $0x4E,%xmm4,%xmm4

# qhasm:     xmm6 = shuffle dwords of xmm6 by 0x4E
# asm 1: pshufd $0x4E,<xmm6=int6464#7,>xmm6=int6464#7
# asm 2: pshufd $0x4E,<xmm6=%xmm6,>xmm6=%xmm6
pshufd $0x4E,%xmm6,%xmm6

# qhasm:     xmm3 = shuffle dwords of xmm3 by 0x4E
# asm 1: pshufd $0x4E,<xmm3=int6464#4,>xmm3=int6464#4
# asm 2: pshufd $0x4E,<xmm3=%xmm3,>xmm3=%xmm3
pshufd $0x4E,%xmm3,%xmm3

# qhasm:     xmm7 = shuffle dwords of xmm7 by 0x4E
# asm 1: pshufd $0x4E,<xmm7=int6464#8,>xmm7=int6464#8
# asm 2: pshufd $0x4E,<xmm7=%xmm7,>xmm7=%xmm7
pshufd $0x4E,%xmm7,%xmm7

# qhasm:     xmm2 = shuffle dwords of xmm2 by 0x4E
# asm 1: pshufd $0x4E,<xmm2=int6464#3,>xmm2=int6464#3
# asm 2: pshufd $0x4E,<xmm2=%xmm2,>xmm2=%xmm2
pshufd $0x4E,%xmm2,%xmm2

# qhasm:     xmm5 = shuffle dwords of xmm5 by 0x4E
# asm 1: pshufd $0x4E,<xmm5=int6464#6,>xmm5=int6464#6
# asm 2: pshufd $0x4E,<xmm5=%xmm5,>xmm5=%xmm5
pshufd $0x4E,%xmm5,%xmm5

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm9 ^= xmm1
# asm 1: pxor  <xmm1=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm1=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:     xmm10 ^= xmm4
# asm 1: pxor  <xmm4=int6464#5,<xmm10=int6464#11
# asm 2: pxor  <xmm4=%xmm4,<xmm10=%xmm10
pxor  %xmm4,%xmm10

# qhasm:     xmm11 ^= xmm6
# asm 1: pxor  <xmm6=int6464#7,<xmm11=int6464#12
# asm 2: pxor  <xmm6=%xmm6,<xmm11=%xmm11
pxor  %xmm6,%xmm11

# qhasm:     xmm12 ^= xmm3
# asm 1: pxor  <xmm3=int6464#4,<xmm12=int6464#13
# asm 2: pxor  <xmm3=%xmm3,<xmm12=%xmm12
pxor  %xmm3,%xmm12

# qhasm:     xmm13 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm13=int6464#14
# asm 2: pxor  <xmm7=%xmm7,<xmm13=%xmm13
pxor  %xmm7,%xmm13

# qhasm:     xmm14 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm14=int6464#15
# asm 2: pxor  <xmm2=%xmm2,<xmm14=%xmm14
pxor  %xmm2,%xmm14

# qhasm:     xmm15 ^= xmm5
# asm 1: pxor  <xmm5=int6464#6,<xmm15=int6464#16
# asm 2: pxor  <xmm5=%xmm5,<xmm15=%xmm15
pxor  %xmm5,%xmm15

# qhasm:     xmm8 ^= *(int128 *)(c + 1152)
# asm 1: pxor 1152(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 1152(<c=%rsi),<xmm8=%xmm8
pxor 1152(%rsi),%xmm8

# qhasm:     shuffle bytes of xmm8 by SRM0
# asm 1: pshufb SRM0,<xmm8=int6464#9
# asm 2: pshufb SRM0,<xmm8=%xmm8
pshufb SRM0,%xmm8

# qhasm:     xmm9 ^= *(int128 *)(c + 1168)
# asm 1: pxor 1168(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 1168(<c=%rsi),<xmm9=%xmm9
pxor 1168(%rsi),%xmm9

# qhasm:     shuffle bytes of xmm9 by SRM0
# asm 1: pshufb SRM0,<xmm9=int6464#10
# asm 2: pshufb SRM0,<xmm9=%xmm9
pshufb SRM0,%xmm9

# qhasm:     xmm10 ^= *(int128 *)(c + 1184)
# asm 1: pxor 1184(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 1184(<c=%rsi),<xmm10=%xmm10
pxor 1184(%rsi),%xmm10

# qhasm:     shuffle bytes of xmm10 by SRM0
# asm 1: pshufb SRM0,<xmm10=int6464#11
# asm 2: pshufb SRM0,<xmm10=%xmm10
pshufb SRM0,%xmm10

# qhasm:     xmm11 ^= *(int128 *)(c + 1200)
# asm 1: pxor 1200(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 1200(<c=%rsi),<xmm11=%xmm11
pxor 1200(%rsi),%xmm11

# qhasm:     shuffle bytes of xmm11 by SRM0
# asm 1: pshufb SRM0,<xmm11=int6464#12
# asm 2: pshufb SRM0,<xmm11=%xmm11
pshufb SRM0,%xmm11

# qhasm:     xmm12 ^= *(int128 *)(c + 1216)
# asm 1: pxor 1216(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 1216(<c=%rsi),<xmm12=%xmm12
pxor 1216(%rsi),%xmm12

# qhasm:     shuffle bytes of xmm12 by SRM0
# asm 1: pshufb SRM0,<xmm12=int6464#13
# asm 2: pshufb SRM0,<xmm12=%xmm12
pshufb SRM0,%xmm12

# qhasm:     xmm13 ^= *(int128 *)(c + 1232)
# asm 1: pxor 1232(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 1232(<c=%rsi),<xmm13=%xmm13
pxor 1232(%rsi),%xmm13

# qhasm:     shuffle bytes of xmm13 by SRM0
# asm 1: pshufb SRM0,<xmm13=int6464#14
# asm 2: pshufb SRM0,<xmm13=%xmm13
pshufb SRM0,%xmm13

# qhasm:     xmm14 ^= *(int128 *)(c + 1248)
# asm 1: pxor 1248(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 1248(<c=%rsi),<xmm14=%xmm14
pxor 1248(%rsi),%xmm14

# qhasm:     shuffle bytes of xmm14 by SRM0
# asm 1: pshufb SRM0,<xmm14=int6464#15
# asm 2: pshufb SRM0,<xmm14=%xmm14
pshufb SRM0,%xmm14

# qhasm:     xmm15 ^= *(int128 *)(c + 1264)
# asm 1: pxor 1264(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 1264(<c=%rsi),<xmm15=%xmm15
pxor 1264(%rsi),%xmm15

# qhasm:     shuffle bytes of xmm15 by SRM0
# asm 1: pshufb SRM0,<xmm15=int6464#16
# asm 2: pshufb SRM0,<xmm15=%xmm15
pshufb SRM0,%xmm15

# qhasm:       xmm13 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm13=int6464#14
# asm 2: pxor  <xmm14=%xmm14,<xmm13=%xmm13
pxor  %xmm14,%xmm13

# qhasm:       xmm10 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm10=int6464#11
# asm 2: pxor  <xmm9=%xmm9,<xmm10=%xmm10
pxor  %xmm9,%xmm10

# qhasm:       xmm13 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm13=int6464#14
# asm 2: pxor  <xmm8=%xmm8,<xmm13=%xmm13
pxor  %xmm8,%xmm13

# qhasm:       xmm14 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm14=int6464#15
# asm 2: pxor  <xmm10=%xmm10,<xmm14=%xmm14
pxor  %xmm10,%xmm14

# qhasm:       xmm11 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm11=int6464#12
# asm 2: pxor  <xmm8=%xmm8,<xmm11=%xmm11
pxor  %xmm8,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:       xmm11 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm11=int6464#12
# asm 2: pxor  <xmm15=%xmm15,<xmm11=%xmm11
pxor  %xmm15,%xmm11

# qhasm:       xmm11 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm11=int6464#12
# asm 2: pxor  <xmm12=%xmm12,<xmm11=%xmm11
pxor  %xmm12,%xmm11

# qhasm:       xmm15 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm15=int6464#16
# asm 2: pxor  <xmm13=%xmm13,<xmm15=%xmm15
pxor  %xmm13,%xmm15

# qhasm:       xmm11 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm11=int6464#12
# asm 2: pxor  <xmm9=%xmm9,<xmm11=%xmm11
pxor  %xmm9,%xmm11

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm10=int6464#11
# asm 2: pxor  <xmm15=%xmm15,<xmm10=%xmm10
pxor  %xmm15,%xmm10

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm3 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm3=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm3=%xmm0
movdqa %xmm15,%xmm0

# qhasm:       xmm2 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm2=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm2=%xmm1
movdqa %xmm9,%xmm1

# qhasm:       xmm1 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm1=int6464#3
# asm 2: movdqa <xmm13=%xmm13,>xmm1=%xmm2
movdqa %xmm13,%xmm2

# qhasm:       xmm5 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm5=int6464#4
# asm 2: movdqa <xmm10=%xmm10,>xmm5=%xmm3
movdqa %xmm10,%xmm3

# qhasm:       xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#5
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm4
movdqa %xmm14,%xmm4

# qhasm:       xmm3 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm3=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm3=%xmm0
pxor  %xmm12,%xmm0

# qhasm:       xmm2 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm2=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm2=%xmm1
pxor  %xmm10,%xmm1

# qhasm:       xmm1 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm1=int6464#3
# asm 2: pxor  <xmm11=%xmm11,<xmm1=%xmm2
pxor  %xmm11,%xmm2

# qhasm:       xmm5 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm5=int6464#4
# asm 2: pxor  <xmm12=%xmm12,<xmm5=%xmm3
pxor  %xmm12,%xmm3

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#5
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm4
pxor  %xmm8,%xmm4

# qhasm:       xmm6 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm6=int6464#6
# asm 2: movdqa <xmm3=%xmm0,>xmm6=%xmm5
movdqa %xmm0,%xmm5

# qhasm:       xmm0 = xmm2
# asm 1: movdqa <xmm2=int6464#2,>xmm0=int6464#7
# asm 2: movdqa <xmm2=%xmm1,>xmm0=%xmm6
movdqa %xmm1,%xmm6

# qhasm:       xmm7 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm7=int6464#8
# asm 2: movdqa <xmm3=%xmm0,>xmm7=%xmm7
movdqa %xmm0,%xmm7

# qhasm:       xmm2 |= xmm1
# asm 1: por   <xmm1=int6464#3,<xmm2=int6464#2
# asm 2: por   <xmm1=%xmm2,<xmm2=%xmm1
por   %xmm2,%xmm1

# qhasm:       xmm3 |= xmm4
# asm 1: por   <xmm4=int6464#5,<xmm3=int6464#1
# asm 2: por   <xmm4=%xmm4,<xmm3=%xmm0
por   %xmm4,%xmm0

# qhasm:       xmm7 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm7=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm7=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm6 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm6=int6464#6
# asm 2: pand  <xmm4=%xmm4,<xmm6=%xmm5
pand  %xmm4,%xmm5

# qhasm:       xmm0 &= xmm1
# asm 1: pand  <xmm1=int6464#3,<xmm0=int6464#7
# asm 2: pand  <xmm1=%xmm2,<xmm0=%xmm6
pand  %xmm2,%xmm6

# qhasm:       xmm4 ^= xmm1
# asm 1: pxor  <xmm1=int6464#3,<xmm4=int6464#5
# asm 2: pxor  <xmm1=%xmm2,<xmm4=%xmm4
pxor  %xmm2,%xmm4

# qhasm:       xmm7 &= xmm4
# asm 1: pand  <xmm4=int6464#5,<xmm7=int6464#8
# asm 2: pand  <xmm4=%xmm4,<xmm7=%xmm7
pand  %xmm4,%xmm7

# qhasm:       xmm4 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm4=int6464#3
# asm 2: movdqa <xmm11=%xmm11,>xmm4=%xmm2
movdqa %xmm11,%xmm2

# qhasm:       xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#3
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm2
pxor  %xmm8,%xmm2

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#3,<xmm5=int6464#4
# asm 2: pand  <xmm4=%xmm2,<xmm5=%xmm3
pand  %xmm2,%xmm3

# qhasm:       xmm3 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm3=int6464#1
# asm 2: pxor  <xmm5=%xmm3,<xmm3=%xmm0
pxor  %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm5 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm5=int6464#3
# asm 2: movdqa <xmm15=%xmm15,>xmm5=%xmm2
movdqa %xmm15,%xmm2

# qhasm:       xmm5 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm5=int6464#3
# asm 2: pxor  <xmm9=%xmm9,<xmm5=%xmm2
pxor  %xmm9,%xmm2

# qhasm:       xmm4 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm4=int6464#4
# asm 2: movdqa <xmm13=%xmm13,>xmm4=%xmm3
movdqa %xmm13,%xmm3

# qhasm:       xmm1 = xmm5
# asm 1: movdqa <xmm5=int6464#3,>xmm1=int6464#5
# asm 2: movdqa <xmm5=%xmm2,>xmm1=%xmm4
movdqa %xmm2,%xmm4

# qhasm:       xmm4 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm4=int6464#4
# asm 2: pxor  <xmm14=%xmm14,<xmm4=%xmm3
pxor  %xmm14,%xmm3

# qhasm:       xmm1 |= xmm4
# asm 1: por   <xmm4=int6464#4,<xmm1=int6464#5
# asm 2: por   <xmm4=%xmm3,<xmm1=%xmm4
por   %xmm3,%xmm4

# qhasm:       xmm5 &= xmm4
# asm 1: pand  <xmm4=int6464#4,<xmm5=int6464#3
# asm 2: pand  <xmm4=%xmm3,<xmm5=%xmm2
pand  %xmm3,%xmm2

# qhasm:       xmm0 ^= xmm5
# asm 1: pxor  <xmm5=int6464#3,<xmm0=int6464#7
# asm 2: pxor  <xmm5=%xmm2,<xmm0=%xmm6
pxor  %xmm2,%xmm6

# qhasm:       xmm3 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm3=int6464#1
# asm 2: pxor  <xmm7=%xmm7,<xmm3=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm2=int6464#2
# asm 2: pxor  <xmm6=%xmm5,<xmm2=%xmm1
pxor  %xmm5,%xmm1

# qhasm:       xmm1 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm7=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm0 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm0=int6464#7
# asm 2: pxor  <xmm6=%xmm5,<xmm0=%xmm6
pxor  %xmm5,%xmm6

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm4 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm4=int6464#3
# asm 2: movdqa <xmm10=%xmm10,>xmm4=%xmm2
movdqa %xmm10,%xmm2

# qhasm:       xmm5 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm5=int6464#4
# asm 2: movdqa <xmm12=%xmm12,>xmm5=%xmm3
movdqa %xmm12,%xmm3

# qhasm:       xmm6 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm6=int6464#6
# asm 2: movdqa <xmm9=%xmm9,>xmm6=%xmm5
movdqa %xmm9,%xmm5

# qhasm:       xmm7 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm7=int6464#8
# asm 2: movdqa <xmm15=%xmm15,>xmm7=%xmm7
movdqa %xmm15,%xmm7

# qhasm:       xmm4 &= xmm11
# asm 1: pand  <xmm11=int6464#12,<xmm4=int6464#3
# asm 2: pand  <xmm11=%xmm11,<xmm4=%xmm2
pand  %xmm11,%xmm2

# qhasm:       xmm5 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm5=int6464#4
# asm 2: pand  <xmm8=%xmm8,<xmm5=%xmm3
pand  %xmm8,%xmm3

# qhasm:       xmm6 &= xmm13
# asm 1: pand  <xmm13=int6464#14,<xmm6=int6464#6
# asm 2: pand  <xmm13=%xmm13,<xmm6=%xmm5
pand  %xmm13,%xmm5

# qhasm:       xmm7 |= xmm14
# asm 1: por   <xmm14=int6464#15,<xmm7=int6464#8
# asm 2: por   <xmm14=%xmm14,<xmm7=%xmm7
por   %xmm14,%xmm7

# qhasm:       xmm3 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm3=int6464#1
# asm 2: pxor  <xmm4=%xmm2,<xmm3=%xmm0
pxor  %xmm2,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#4,<xmm2=int6464#2
# asm 2: pxor  <xmm5=%xmm3,<xmm2=%xmm1
pxor  %xmm3,%xmm1

# qhasm:       xmm1 ^= xmm6
# asm 1: pxor  <xmm6=int6464#6,<xmm1=int6464#5
# asm 2: pxor  <xmm6=%xmm5,<xmm1=%xmm4
pxor  %xmm5,%xmm4

# qhasm:       xmm0 ^= xmm7
# asm 1: pxor  <xmm7=int6464#8,<xmm0=int6464#7
# asm 2: pxor  <xmm7=%xmm7,<xmm0=%xmm6
pxor  %xmm7,%xmm6

# qhasm:       xmm4 = xmm3
# asm 1: movdqa <xmm3=int6464#1,>xmm4=int6464#3
# asm 2: movdqa <xmm3=%xmm0,>xmm4=%xmm2
movdqa %xmm0,%xmm2

# qhasm:       xmm4 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm4=int6464#3
# asm 2: pxor  <xmm2=%xmm1,<xmm4=%xmm2
pxor  %xmm1,%xmm2

# qhasm:       xmm3 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm3=int6464#1
# asm 2: pand  <xmm1=%xmm4,<xmm3=%xmm0
pand  %xmm4,%xmm0

# qhasm:       xmm6 = xmm0
# asm 1: movdqa <xmm0=int6464#7,>xmm6=int6464#4
# asm 2: movdqa <xmm0=%xmm6,>xmm6=%xmm3
movdqa %xmm6,%xmm3

# qhasm:       xmm6 ^= xmm3
# asm 1: pxor  <xmm3=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm3=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm7 = xmm4
# asm 1: movdqa <xmm4=int6464#3,>xmm7=int6464#6
# asm 2: movdqa <xmm4=%xmm2,>xmm7=%xmm5
movdqa %xmm2,%xmm5

# qhasm:       xmm7 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm7=int6464#6
# asm 2: pand  <xmm6=%xmm3,<xmm7=%xmm5
pand  %xmm3,%xmm5

# qhasm:       xmm7 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm7=int6464#6
# asm 2: pxor  <xmm2=%xmm1,<xmm7=%xmm5
pxor  %xmm1,%xmm5

# qhasm:       xmm5 = xmm1
# asm 1: movdqa <xmm1=int6464#5,>xmm5=int6464#8
# asm 2: movdqa <xmm1=%xmm4,>xmm5=%xmm7
movdqa %xmm4,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm3 ^= xmm2
# asm 1: pxor  <xmm2=int6464#2,<xmm3=int6464#1
# asm 2: pxor  <xmm2=%xmm1,<xmm3=%xmm0
pxor  %xmm1,%xmm0

# qhasm:       xmm5 &= xmm3
# asm 1: pand  <xmm3=int6464#1,<xmm5=int6464#8
# asm 2: pand  <xmm3=%xmm0,<xmm5=%xmm7
pand  %xmm0,%xmm7

# qhasm:       xmm5 ^= xmm0
# asm 1: pxor  <xmm0=int6464#7,<xmm5=int6464#8
# asm 2: pxor  <xmm0=%xmm6,<xmm5=%xmm7
pxor  %xmm6,%xmm7

# qhasm:       xmm1 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm1=int6464#5
# asm 2: pxor  <xmm5=%xmm7,<xmm1=%xmm4
pxor  %xmm7,%xmm4

# qhasm:       xmm2 = xmm6
# asm 1: movdqa <xmm6=int6464#4,>xmm2=int6464#1
# asm 2: movdqa <xmm6=%xmm3,>xmm2=%xmm0
movdqa %xmm3,%xmm0

# qhasm:       xmm2 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm2=int6464#1
# asm 2: pxor  <xmm5=%xmm7,<xmm2=%xmm0
pxor  %xmm7,%xmm0

# qhasm:       xmm2 &= xmm0
# asm 1: pand  <xmm0=int6464#7,<xmm2=int6464#1
# asm 2: pand  <xmm0=%xmm6,<xmm2=%xmm0
pand  %xmm6,%xmm0

# qhasm:       xmm1 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm1=int6464#5
# asm 2: pxor  <xmm2=%xmm0,<xmm1=%xmm4
pxor  %xmm0,%xmm4

# qhasm:       xmm6 ^= xmm2
# asm 1: pxor  <xmm2=int6464#1,<xmm6=int6464#4
# asm 2: pxor  <xmm2=%xmm0,<xmm6=%xmm3
pxor  %xmm0,%xmm3

# qhasm:       xmm6 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm6=int6464#4
# asm 2: pand  <xmm7=%xmm5,<xmm6=%xmm3
pand  %xmm5,%xmm3

# qhasm:       xmm6 ^= xmm4
# asm 1: pxor  <xmm4=int6464#3,<xmm6=int6464#4
# asm 2: pxor  <xmm4=%xmm2,<xmm6=%xmm3
pxor  %xmm2,%xmm3

# qhasm:         xmm4 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm4=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm4=%xmm0
movdqa %xmm14,%xmm0

# qhasm:         xmm0 = xmm13
# asm 1: movdqa <xmm13=int6464#14,>xmm0=int6464#2
# asm 2: movdqa <xmm13=%xmm13,>xmm0=%xmm1
movdqa %xmm13,%xmm1

# qhasm:           xmm2 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm2=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm2=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm2 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm2=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm2=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm2 &= xmm14
# asm 1: pand  <xmm14=int6464#15,<xmm2=int6464#3
# asm 2: pand  <xmm14=%xmm14,<xmm2=%xmm2
pand  %xmm14,%xmm2

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm14 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm14=int6464#15
# asm 2: pand  <xmm6=%xmm3,<xmm14=%xmm14
pand  %xmm3,%xmm14

# qhasm:           xmm13 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm13=int6464#14
# asm 2: pand  <xmm7=%xmm5,<xmm13=%xmm13
pand  %xmm5,%xmm13

# qhasm:           xmm14 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm14=int6464#15
# asm 2: pxor  <xmm13=%xmm13,<xmm14=%xmm14
pxor  %xmm13,%xmm14

# qhasm:           xmm13 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm13=int6464#14
# asm 2: pxor  <xmm2=%xmm2,<xmm13=%xmm13
pxor  %xmm2,%xmm13

# qhasm:         xmm4 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm4=int6464#1
# asm 2: pxor  <xmm8=%xmm8,<xmm4=%xmm0
pxor  %xmm8,%xmm0

# qhasm:         xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#2
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm1
pxor  %xmm11,%xmm1

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm8
# asm 1: pand  <xmm8=int6464#9,<xmm2=int6464#3
# asm 2: pand  <xmm8=%xmm8,<xmm2=%xmm2
pand  %xmm8,%xmm2

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm8 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm8=int6464#9
# asm 2: pand  <xmm1=%xmm4,<xmm8=%xmm8
pand  %xmm4,%xmm8

# qhasm:           xmm11 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm11=int6464#12
# asm 2: pand  <xmm5=%xmm7,<xmm11=%xmm11
pand  %xmm7,%xmm11

# qhasm:           xmm8 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm8=int6464#9
# asm 2: pxor  <xmm11=%xmm11,<xmm8=%xmm8
pxor  %xmm11,%xmm8

# qhasm:           xmm11 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm11=int6464#12
# asm 2: pxor  <xmm2=%xmm2,<xmm11=%xmm11
pxor  %xmm2,%xmm11

# qhasm:         xmm14 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm4=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:         xmm8 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm4=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:         xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm1,<xmm13=%xmm13
pxor  %xmm1,%xmm13

# qhasm:         xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm1,<xmm11=%xmm11
pxor  %xmm1,%xmm11

# qhasm:         xmm4 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm4=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm4=%xmm0
movdqa %xmm15,%xmm0

# qhasm:         xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#2
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm1
movdqa %xmm9,%xmm1

# qhasm:         xmm4 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm4=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm4=%xmm0
pxor  %xmm12,%xmm0

# qhasm:         xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#2
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm1
pxor  %xmm10,%xmm1

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm4
# asm 1: pand  <xmm4=int6464#1,<xmm3=int6464#3
# asm 2: pand  <xmm4=%xmm0,<xmm3=%xmm2
pand  %xmm0,%xmm2

# qhasm:           xmm4 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm4=int6464#1
# asm 2: pxor  <xmm0=%xmm1,<xmm4=%xmm0
pxor  %xmm1,%xmm0

# qhasm:           xmm4 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm4=int6464#1
# asm 2: pand  <xmm6=%xmm3,<xmm4=%xmm0
pand  %xmm3,%xmm0

# qhasm:           xmm0 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm0=int6464#2
# asm 2: pand  <xmm7=%xmm5,<xmm0=%xmm1
pand  %xmm5,%xmm1

# qhasm:           xmm0 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm0=int6464#2
# asm 2: pxor  <xmm4=%xmm0,<xmm0=%xmm1
pxor  %xmm0,%xmm1

# qhasm:           xmm4 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm4=int6464#1
# asm 2: pxor  <xmm3=%xmm2,<xmm4=%xmm0
pxor  %xmm2,%xmm0

# qhasm:           xmm2 = xmm5
# asm 1: movdqa <xmm5=int6464#8,>xmm2=int6464#3
# asm 2: movdqa <xmm5=%xmm7,>xmm2=%xmm2
movdqa %xmm7,%xmm2

# qhasm:           xmm2 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm2=int6464#3
# asm 2: pxor  <xmm1=%xmm4,<xmm2=%xmm2
pxor  %xmm4,%xmm2

# qhasm:           xmm2 &= xmm12
# asm 1: pand  <xmm12=int6464#13,<xmm2=int6464#3
# asm 2: pand  <xmm12=%xmm12,<xmm2=%xmm2
pand  %xmm12,%xmm2

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm12 &= xmm1
# asm 1: pand  <xmm1=int6464#5,<xmm12=int6464#13
# asm 2: pand  <xmm1=%xmm4,<xmm12=%xmm12
pand  %xmm4,%xmm12

# qhasm:           xmm10 &= xmm5
# asm 1: pand  <xmm5=int6464#8,<xmm10=int6464#11
# asm 2: pand  <xmm5=%xmm7,<xmm10=%xmm10
pand  %xmm7,%xmm10

# qhasm:           xmm12 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm12=int6464#13
# asm 2: pxor  <xmm10=%xmm10,<xmm12=%xmm12
pxor  %xmm10,%xmm12

# qhasm:           xmm10 ^= xmm2
# asm 1: pxor  <xmm2=int6464#3,<xmm10=int6464#11
# asm 2: pxor  <xmm2=%xmm2,<xmm10=%xmm10
pxor  %xmm2,%xmm10

# qhasm:         xmm7 ^= xmm5
# asm 1: pxor  <xmm5=int6464#8,<xmm7=int6464#6
# asm 2: pxor  <xmm5=%xmm7,<xmm7=%xmm5
pxor  %xmm7,%xmm5

# qhasm:         xmm6 ^= xmm1
# asm 1: pxor  <xmm1=int6464#5,<xmm6=int6464#4
# asm 2: pxor  <xmm1=%xmm4,<xmm6=%xmm3
pxor  %xmm4,%xmm3

# qhasm:           xmm3 = xmm7
# asm 1: movdqa <xmm7=int6464#6,>xmm3=int6464#3
# asm 2: movdqa <xmm7=%xmm5,>xmm3=%xmm2
movdqa %xmm5,%xmm2

# qhasm:           xmm3 ^= xmm6
# asm 1: pxor  <xmm6=int6464#4,<xmm3=int6464#3
# asm 2: pxor  <xmm6=%xmm3,<xmm3=%xmm2
pxor  %xmm3,%xmm2

# qhasm:           xmm3 &= xmm15
# asm 1: pand  <xmm15=int6464#16,<xmm3=int6464#3
# asm 2: pand  <xmm15=%xmm15,<xmm3=%xmm2
pand  %xmm15,%xmm2

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm15 &= xmm6
# asm 1: pand  <xmm6=int6464#4,<xmm15=int6464#16
# asm 2: pand  <xmm6=%xmm3,<xmm15=%xmm15
pand  %xmm3,%xmm15

# qhasm:           xmm9 &= xmm7
# asm 1: pand  <xmm7=int6464#6,<xmm9=int6464#10
# asm 2: pand  <xmm7=%xmm5,<xmm9=%xmm9
pand  %xmm5,%xmm9

# qhasm:           xmm15 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm15=int6464#16
# asm 2: pxor  <xmm9=%xmm9,<xmm15=%xmm15
pxor  %xmm9,%xmm15

# qhasm:           xmm9 ^= xmm3
# asm 1: pxor  <xmm3=int6464#3,<xmm9=int6464#10
# asm 2: pxor  <xmm3=%xmm2,<xmm9=%xmm9
pxor  %xmm2,%xmm9

# qhasm:         xmm15 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm4=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:         xmm12 ^= xmm4
# asm 1: pxor  <xmm4=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm4=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:         xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm1,<xmm9=%xmm9
pxor  %xmm1,%xmm9

# qhasm:         xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#2,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm1,<xmm10=%xmm10
pxor  %xmm1,%xmm10

# qhasm:       xmm15 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm15=int6464#16
# asm 2: pxor  <xmm8=%xmm8,<xmm15=%xmm15
pxor  %xmm8,%xmm15

# qhasm:       xmm9 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm9=int6464#10
# asm 2: pxor  <xmm14=%xmm14,<xmm9=%xmm9
pxor  %xmm14,%xmm9

# qhasm:       xmm12 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm12=int6464#13
# asm 2: pxor  <xmm15=%xmm15,<xmm12=%xmm12
pxor  %xmm15,%xmm12

# qhasm:       xmm14 ^= xmm8
# asm 1: pxor  <xmm8=int6464#9,<xmm14=int6464#15
# asm 2: pxor  <xmm8=%xmm8,<xmm14=%xmm14
pxor  %xmm8,%xmm14

# qhasm:       xmm8 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm8=int6464#9
# asm 2: pxor  <xmm9=%xmm9,<xmm8=%xmm8
pxor  %xmm9,%xmm8

# qhasm:       xmm9 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm9=int6464#10
# asm 2: pxor  <xmm13=%xmm13,<xmm9=%xmm9
pxor  %xmm13,%xmm9

# qhasm:       xmm13 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm13=int6464#14
# asm 2: pxor  <xmm10=%xmm10,<xmm13=%xmm13
pxor  %xmm10,%xmm13

# qhasm:       xmm12 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm12=int6464#13
# asm 2: pxor  <xmm13=%xmm13,<xmm12=%xmm12
pxor  %xmm13,%xmm12

# qhasm:       xmm10 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm10=int6464#11
# asm 2: pxor  <xmm11=%xmm11,<xmm10=%xmm10
pxor  %xmm11,%xmm10

# qhasm:       xmm11 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm11=int6464#12
# asm 2: pxor  <xmm13=%xmm13,<xmm11=%xmm11
pxor  %xmm13,%xmm11

# qhasm:       xmm14 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm14=int6464#15
# asm 2: pxor  <xmm11=%xmm11,<xmm14=%xmm14
pxor  %xmm11,%xmm14

# qhasm:   xmm8 ^= *(int128 *)(c + 1280)
# asm 1: pxor 1280(<c=int64#2),<xmm8=int6464#9
# asm 2: pxor 1280(<c=%rsi),<xmm8=%xmm8
pxor 1280(%rsi),%xmm8

# qhasm:   xmm9 ^= *(int128 *)(c + 1296)
# asm 1: pxor 1296(<c=int64#2),<xmm9=int6464#10
# asm 2: pxor 1296(<c=%rsi),<xmm9=%xmm9
pxor 1296(%rsi),%xmm9

# qhasm:   xmm12 ^= *(int128 *)(c + 1312)
# asm 1: pxor 1312(<c=int64#2),<xmm12=int6464#13
# asm 2: pxor 1312(<c=%rsi),<xmm12=%xmm12
pxor 1312(%rsi),%xmm12

# qhasm:   xmm14 ^= *(int128 *)(c + 1328)
# asm 1: pxor 1328(<c=int64#2),<xmm14=int6464#15
# asm 2: pxor 1328(<c=%rsi),<xmm14=%xmm14
pxor 1328(%rsi),%xmm14

# qhasm:   xmm11 ^= *(int128 *)(c + 1344)
# asm 1: pxor 1344(<c=int64#2),<xmm11=int6464#12
# asm 2: pxor 1344(<c=%rsi),<xmm11=%xmm11
pxor 1344(%rsi),%xmm11

# qhasm:   xmm15 ^= *(int128 *)(c + 1360)
# asm 1: pxor 1360(<c=int64#2),<xmm15=int6464#16
# asm 2: pxor 1360(<c=%rsi),<xmm15=%xmm15
pxor 1360(%rsi),%xmm15

# qhasm:   xmm10 ^= *(int128 *)(c + 1376)
# asm 1: pxor 1376(<c=int64#2),<xmm10=int6464#11
# asm 2: pxor 1376(<c=%rsi),<xmm10=%xmm10
pxor 1376(%rsi),%xmm10

# qhasm:   xmm13 ^= *(int128 *)(c + 1392)
# asm 1: pxor 1392(<c=int64#2),<xmm13=int6464#14
# asm 2: pxor 1392(<c=%rsi),<xmm13=%xmm13
pxor 1392(%rsi),%xmm13

# qhasm:     xmm0 = xmm10
# asm 1: movdqa <xmm10=int6464#11,>xmm0=int6464#1
# asm 2: movdqa <xmm10=%xmm10,>xmm0=%xmm0
movdqa %xmm10,%xmm0

# qhasm:     uint6464 xmm0 >>= 1
# asm 1: psrlq $1,<xmm0=int6464#1
# asm 2: psrlq $1,<xmm0=%xmm0
psrlq $1,%xmm0

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm0 &= BS0
# asm 1: pand  BS0,<xmm0=int6464#1
# asm 2: pand  BS0,<xmm0=%xmm0
pand  BS0,%xmm0

# qhasm:     xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm0,<xmm13=%xmm13
pxor  %xmm0,%xmm13

# qhasm:     uint6464 xmm0 <<= 1
# asm 1: psllq $1,<xmm0=int6464#1
# asm 2: psllq $1,<xmm0=%xmm0
psllq $1,%xmm0

# qhasm:     xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm10=%xmm10
pxor  %xmm0,%xmm10

# qhasm:     xmm0 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm0=int6464#1
# asm 2: movdqa <xmm11=%xmm11,>xmm0=%xmm0
movdqa %xmm11,%xmm0

# qhasm:     uint6464 xmm0 >>= 1
# asm 1: psrlq $1,<xmm0=int6464#1
# asm 2: psrlq $1,<xmm0=%xmm0
psrlq $1,%xmm0

# qhasm:     xmm0 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm0=int6464#1
# asm 2: pxor  <xmm15=%xmm15,<xmm0=%xmm0
pxor  %xmm15,%xmm0

# qhasm:     xmm0 &= BS0
# asm 1: pand  BS0,<xmm0=int6464#1
# asm 2: pand  BS0,<xmm0=%xmm0
pand  BS0,%xmm0

# qhasm:     xmm15 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm0=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:     uint6464 xmm0 <<= 1
# asm 1: psllq $1,<xmm0=int6464#1
# asm 2: psllq $1,<xmm0=%xmm0
psllq $1,%xmm0

# qhasm:     xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm0,<xmm11=%xmm11
pxor  %xmm0,%xmm11

# qhasm:     xmm0 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm0=int6464#1
# asm 2: movdqa <xmm12=%xmm12,>xmm0=%xmm0
movdqa %xmm12,%xmm0

# qhasm:     uint6464 xmm0 >>= 1
# asm 1: psrlq $1,<xmm0=int6464#1
# asm 2: psrlq $1,<xmm0=%xmm0
psrlq $1,%xmm0

# qhasm:     xmm0 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm0=int6464#1
# asm 2: pxor  <xmm14=%xmm14,<xmm0=%xmm0
pxor  %xmm14,%xmm0

# qhasm:     xmm0 &= BS0
# asm 1: pand  BS0,<xmm0=int6464#1
# asm 2: pand  BS0,<xmm0=%xmm0
pand  BS0,%xmm0

# qhasm:     xmm14 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm0=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:     uint6464 xmm0 <<= 1
# asm 1: psllq $1,<xmm0=int6464#1
# asm 2: psllq $1,<xmm0=%xmm0
psllq $1,%xmm0

# qhasm:     xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:     xmm0 = xmm8
# asm 1: movdqa <xmm8=int6464#9,>xmm0=int6464#1
# asm 2: movdqa <xmm8=%xmm8,>xmm0=%xmm0
movdqa %xmm8,%xmm0

# qhasm:     uint6464 xmm0 >>= 1
# asm 1: psrlq $1,<xmm0=int6464#1
# asm 2: psrlq $1,<xmm0=%xmm0
psrlq $1,%xmm0

# qhasm:     xmm0 ^= xmm9
# asm 1: pxor  <xmm9=int6464#10,<xmm0=int6464#1
# asm 2: pxor  <xmm9=%xmm9,<xmm0=%xmm0
pxor  %xmm9,%xmm0

# qhasm:     xmm0 &= BS0
# asm 1: pand  BS0,<xmm0=int6464#1
# asm 2: pand  BS0,<xmm0=%xmm0
pand  BS0,%xmm0

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     uint6464 xmm0 <<= 1
# asm 1: psllq $1,<xmm0=int6464#1
# asm 2: psllq $1,<xmm0=%xmm0
psllq $1,%xmm0

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm0 = xmm15
# asm 1: movdqa <xmm15=int6464#16,>xmm0=int6464#1
# asm 2: movdqa <xmm15=%xmm15,>xmm0=%xmm0
movdqa %xmm15,%xmm0

# qhasm:     uint6464 xmm0 >>= 2
# asm 1: psrlq $2,<xmm0=int6464#1
# asm 2: psrlq $2,<xmm0=%xmm0
psrlq $2,%xmm0

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm0 &= BS1
# asm 1: pand  BS1,<xmm0=int6464#1
# asm 2: pand  BS1,<xmm0=%xmm0
pand  BS1,%xmm0

# qhasm:     xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm0,<xmm13=%xmm13
pxor  %xmm0,%xmm13

# qhasm:     uint6464 xmm0 <<= 2
# asm 1: psllq $2,<xmm0=int6464#1
# asm 2: psllq $2,<xmm0=%xmm0
psllq $2,%xmm0

# qhasm:     xmm15 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm0=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:     xmm0 = xmm11
# asm 1: movdqa <xmm11=int6464#12,>xmm0=int6464#1
# asm 2: movdqa <xmm11=%xmm11,>xmm0=%xmm0
movdqa %xmm11,%xmm0

# qhasm:     uint6464 xmm0 >>= 2
# asm 1: psrlq $2,<xmm0=int6464#1
# asm 2: psrlq $2,<xmm0=%xmm0
psrlq $2,%xmm0

# qhasm:     xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#1
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm0
pxor  %xmm10,%xmm0

# qhasm:     xmm0 &= BS1
# asm 1: pand  BS1,<xmm0=int6464#1
# asm 2: pand  BS1,<xmm0=%xmm0
pand  BS1,%xmm0

# qhasm:     xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm10=%xmm10
pxor  %xmm0,%xmm10

# qhasm:     uint6464 xmm0 <<= 2
# asm 1: psllq $2,<xmm0=int6464#1
# asm 2: psllq $2,<xmm0=%xmm0
psllq $2,%xmm0

# qhasm:     xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm0,<xmm11=%xmm11
pxor  %xmm0,%xmm11

# qhasm:     xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#1
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm0
movdqa %xmm9,%xmm0

# qhasm:     uint6464 xmm0 >>= 2
# asm 1: psrlq $2,<xmm0=int6464#1
# asm 2: psrlq $2,<xmm0=%xmm0
psrlq $2,%xmm0

# qhasm:     xmm0 ^= xmm14
# asm 1: pxor  <xmm14=int6464#15,<xmm0=int6464#1
# asm 2: pxor  <xmm14=%xmm14,<xmm0=%xmm0
pxor  %xmm14,%xmm0

# qhasm:     xmm0 &= BS1
# asm 1: pand  BS1,<xmm0=int6464#1
# asm 2: pand  BS1,<xmm0=%xmm0
pand  BS1,%xmm0

# qhasm:     xmm14 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm0=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:     uint6464 xmm0 <<= 2
# asm 1: psllq $2,<xmm0=int6464#1
# asm 2: psllq $2,<xmm0=%xmm0
psllq $2,%xmm0

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm0 = xmm8
# asm 1: movdqa <xmm8=int6464#9,>xmm0=int6464#1
# asm 2: movdqa <xmm8=%xmm8,>xmm0=%xmm0
movdqa %xmm8,%xmm0

# qhasm:     uint6464 xmm0 >>= 2
# asm 1: psrlq $2,<xmm0=int6464#1
# asm 2: psrlq $2,<xmm0=%xmm0
psrlq $2,%xmm0

# qhasm:     xmm0 ^= xmm12
# asm 1: pxor  <xmm12=int6464#13,<xmm0=int6464#1
# asm 2: pxor  <xmm12=%xmm12,<xmm0=%xmm0
pxor  %xmm12,%xmm0

# qhasm:     xmm0 &= BS1
# asm 1: pand  BS1,<xmm0=int6464#1
# asm 2: pand  BS1,<xmm0=%xmm0
pand  BS1,%xmm0

# qhasm:     xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:     uint6464 xmm0 <<= 2
# asm 1: psllq $2,<xmm0=int6464#1
# asm 2: psllq $2,<xmm0=%xmm0
psllq $2,%xmm0

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm:     xmm0 = xmm14
# asm 1: movdqa <xmm14=int6464#15,>xmm0=int6464#1
# asm 2: movdqa <xmm14=%xmm14,>xmm0=%xmm0
movdqa %xmm14,%xmm0

# qhasm:     uint6464 xmm0 >>= 4
# asm 1: psrlq $4,<xmm0=int6464#1
# asm 2: psrlq $4,<xmm0=%xmm0
psrlq $4,%xmm0

# qhasm:     xmm0 ^= xmm13
# asm 1: pxor  <xmm13=int6464#14,<xmm0=int6464#1
# asm 2: pxor  <xmm13=%xmm13,<xmm0=%xmm0
pxor  %xmm13,%xmm0

# qhasm:     xmm0 &= BS2
# asm 1: pand  BS2,<xmm0=int6464#1
# asm 2: pand  BS2,<xmm0=%xmm0
pand  BS2,%xmm0

# qhasm:     xmm13 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm13=int6464#14
# asm 2: pxor  <xmm0=%xmm0,<xmm13=%xmm13
pxor  %xmm0,%xmm13

# qhasm:     uint6464 xmm0 <<= 4
# asm 1: psllq $4,<xmm0=int6464#1
# asm 2: psllq $4,<xmm0=%xmm0
psllq $4,%xmm0

# qhasm:     xmm14 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm14=int6464#15
# asm 2: pxor  <xmm0=%xmm0,<xmm14=%xmm14
pxor  %xmm0,%xmm14

# qhasm:     xmm0 = xmm12
# asm 1: movdqa <xmm12=int6464#13,>xmm0=int6464#1
# asm 2: movdqa <xmm12=%xmm12,>xmm0=%xmm0
movdqa %xmm12,%xmm0

# qhasm:     uint6464 xmm0 >>= 4
# asm 1: psrlq $4,<xmm0=int6464#1
# asm 2: psrlq $4,<xmm0=%xmm0
psrlq $4,%xmm0

# qhasm:     xmm0 ^= xmm10
# asm 1: pxor  <xmm10=int6464#11,<xmm0=int6464#1
# asm 2: pxor  <xmm10=%xmm10,<xmm0=%xmm0
pxor  %xmm10,%xmm0

# qhasm:     xmm0 &= BS2
# asm 1: pand  BS2,<xmm0=int6464#1
# asm 2: pand  BS2,<xmm0=%xmm0
pand  BS2,%xmm0

# qhasm:     xmm10 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm10=int6464#11
# asm 2: pxor  <xmm0=%xmm0,<xmm10=%xmm10
pxor  %xmm0,%xmm10

# qhasm:     uint6464 xmm0 <<= 4
# asm 1: psllq $4,<xmm0=int6464#1
# asm 2: psllq $4,<xmm0=%xmm0
psllq $4,%xmm0

# qhasm:     xmm12 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm12=int6464#13
# asm 2: pxor  <xmm0=%xmm0,<xmm12=%xmm12
pxor  %xmm0,%xmm12

# qhasm:     xmm0 = xmm9
# asm 1: movdqa <xmm9=int6464#10,>xmm0=int6464#1
# asm 2: movdqa <xmm9=%xmm9,>xmm0=%xmm0
movdqa %xmm9,%xmm0

# qhasm:     uint6464 xmm0 >>= 4
# asm 1: psrlq $4,<xmm0=int6464#1
# asm 2: psrlq $4,<xmm0=%xmm0
psrlq $4,%xmm0

# qhasm:     xmm0 ^= xmm15
# asm 1: pxor  <xmm15=int6464#16,<xmm0=int6464#1
# asm 2: pxor  <xmm15=%xmm15,<xmm0=%xmm0
pxor  %xmm15,%xmm0

# qhasm:     xmm0 &= BS2
# asm 1: pand  BS2,<xmm0=int6464#1
# asm 2: pand  BS2,<xmm0=%xmm0
pand  BS2,%xmm0

# qhasm:     xmm15 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm15=int6464#16
# asm 2: pxor  <xmm0=%xmm0,<xmm15=%xmm15
pxor  %xmm0,%xmm15

# qhasm:     uint6464 xmm0 <<= 4
# asm 1: psllq $4,<xmm0=int6464#1
# asm 2: psllq $4,<xmm0=%xmm0
psllq $4,%xmm0

# qhasm:     xmm9 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm9=int6464#10
# asm 2: pxor  <xmm0=%xmm0,<xmm9=%xmm9
pxor  %xmm0,%xmm9

# qhasm:     xmm0 = xmm8
# asm 1: movdqa <xmm8=int6464#9,>xmm0=int6464#1
# asm 2: movdqa <xmm8=%xmm8,>xmm0=%xmm0
movdqa %xmm8,%xmm0

# qhasm:     uint6464 xmm0 >>= 4
# asm 1: psrlq $4,<xmm0=int6464#1
# asm 2: psrlq $4,<xmm0=%xmm0
psrlq $4,%xmm0

# qhasm:     xmm0 ^= xmm11
# asm 1: pxor  <xmm11=int6464#12,<xmm0=int6464#1
# asm 2: pxor  <xmm11=%xmm11,<xmm0=%xmm0
pxor  %xmm11,%xmm0

# qhasm:     xmm0 &= BS2
# asm 1: pand  BS2,<xmm0=int6464#1
# asm 2: pand  BS2,<xmm0=%xmm0
pand  BS2,%xmm0

# qhasm:     xmm11 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm11=int6464#12
# asm 2: pxor  <xmm0=%xmm0,<xmm11=%xmm11
pxor  %xmm0,%xmm11

# qhasm:     uint6464 xmm0 <<= 4
# asm 1: psllq $4,<xmm0=int6464#1
# asm 2: psllq $4,<xmm0=%xmm0
psllq $4,%xmm0

# qhasm:     xmm8 ^= xmm0
# asm 1: pxor  <xmm0=int6464#1,<xmm8=int6464#9
# asm 2: pxor  <xmm0=%xmm0,<xmm8=%xmm8
pxor  %xmm0,%xmm8

# qhasm: unsigned<? =? len-128
# asm 1: cmp  $128,<len=int64#5
# asm 2: cmp  $128,<len=%r8
cmp  $128,%r8
# comment:fp stack unchanged by jump

# qhasm: goto partial if unsigned<
jb ._partial
# comment:fp stack unchanged by jump

# qhasm: goto full if =
je ._full

# qhasm: *(uint32 *)(c + 1408) += 8
# asm 1: addl $8,1408(<c=int64#2)
# asm 2: addl $8,1408(<c=%rsi)
addl $8,1408(%rsi)

# qhasm: xmm8 ^= *(int128 *)(inp + 0)
# asm 1: pxor 0(<inp=int64#3),<xmm8=int6464#9
# asm 2: pxor 0(<inp=%rdx),<xmm8=%xmm8
pxor 0(%rdx),%xmm8

# qhasm: xmm9 ^= *(int128 *)(inp + 16)
# asm 1: pxor 16(<inp=int64#3),<xmm9=int6464#10
# asm 2: pxor 16(<inp=%rdx),<xmm9=%xmm9
pxor 16(%rdx),%xmm9

# qhasm: xmm12 ^= *(int128 *)(inp + 32)
# asm 1: pxor 32(<inp=int64#3),<xmm12=int6464#13
# asm 2: pxor 32(<inp=%rdx),<xmm12=%xmm12
pxor 32(%rdx),%xmm12

# qhasm: xmm14 ^= *(int128 *)(inp + 48)
# asm 1: pxor 48(<inp=int64#3),<xmm14=int6464#15
# asm 2: pxor 48(<inp=%rdx),<xmm14=%xmm14
pxor 48(%rdx),%xmm14

# qhasm: xmm11 ^= *(int128 *)(inp + 64)
# asm 1: pxor 64(<inp=int64#3),<xmm11=int6464#12
# asm 2: pxor 64(<inp=%rdx),<xmm11=%xmm11
pxor 64(%rdx),%xmm11

# qhasm: xmm15 ^= *(int128 *)(inp + 80)
# asm 1: pxor 80(<inp=int64#3),<xmm15=int6464#16
# asm 2: pxor 80(<inp=%rdx),<xmm15=%xmm15
pxor 80(%rdx),%xmm15

# qhasm: xmm10 ^= *(int128 *)(inp + 96)
# asm 1: pxor 96(<inp=int64#3),<xmm10=int6464#11
# asm 2: pxor 96(<inp=%rdx),<xmm10=%xmm10
pxor 96(%rdx),%xmm10

# qhasm: xmm13 ^= *(int128 *)(inp + 112)
# asm 1: pxor 112(<inp=int64#3),<xmm13=int6464#14
# asm 2: pxor 112(<inp=%rdx),<xmm13=%xmm13
pxor 112(%rdx),%xmm13

# qhasm: *(int128 *) (outp + 0) = xmm8
# asm 1: movdqa <xmm8=int6464#9,0(<outp=int64#4)
# asm 2: movdqa <xmm8=%xmm8,0(<outp=%rcx)
movdqa %xmm8,0(%rcx)

# qhasm: *(int128 *) (outp + 16) = xmm9
# asm 1: movdqa <xmm9=int6464#10,16(<outp=int64#4)
# asm 2: movdqa <xmm9=%xmm9,16(<outp=%rcx)
movdqa %xmm9,16(%rcx)

# qhasm: *(int128 *) (outp + 32) = xmm12
# asm 1: movdqa <xmm12=int6464#13,32(<outp=int64#4)
# asm 2: movdqa <xmm12=%xmm12,32(<outp=%rcx)
movdqa %xmm12,32(%rcx)

# qhasm: *(int128 *) (outp + 48) = xmm14
# asm 1: movdqa <xmm14=int6464#15,48(<outp=int64#4)
# asm 2: movdqa <xmm14=%xmm14,48(<outp=%rcx)
movdqa %xmm14,48(%rcx)

# qhasm: *(int128 *) (outp + 64) = xmm11
# asm 1: movdqa <xmm11=int6464#12,64(<outp=int64#4)
# asm 2: movdqa <xmm11=%xmm11,64(<outp=%rcx)
movdqa %xmm11,64(%rcx)

# qhasm: *(int128 *) (outp + 80) = xmm15
# asm 1: movdqa <xmm15=int6464#16,80(<outp=int64#4)
# asm 2: movdqa <xmm15=%xmm15,80(<outp=%rcx)
movdqa %xmm15,80(%rcx)

# qhasm: *(int128 *) (outp + 96) = xmm10
# asm 1: movdqa <xmm10=int6464#11,96(<outp=int64#4)
# asm 2: movdqa <xmm10=%xmm10,96(<outp=%rcx)
movdqa %xmm10,96(%rcx)

# qhasm: *(int128 *) (outp + 112) = xmm13
# asm 1: movdqa <xmm13=int6464#14,112(<outp=int64#4)
# asm 2: movdqa <xmm13=%xmm13,112(<outp=%rcx)
movdqa %xmm13,112(%rcx)

# qhasm: len -= 128
# asm 1: sub  $128,<len=int64#5
# asm 2: sub  $128,<len=%r8
sub  $128,%r8

# qhasm: inp += 128
# asm 1: add  $128,<inp=int64#3
# asm 2: add  $128,<inp=%rdx
add  $128,%rdx

# qhasm: outp += 128
# asm 1: add  $128,<outp=int64#4
# asm 2: add  $128,<outp=%rcx
add  $128,%rcx
# comment:fp stack unchanged by jump

# qhasm: goto enc_block
jmp ._enc_block

# qhasm: partial:
._partial:

# qhasm: lensav = len
# asm 1: mov  <len=int64#5,>lensav=int64#1
# asm 2: mov  <len=%r8,>lensav=%rdi
mov  %r8,%rdi

# qhasm: (uint32) len >>= 4
# asm 1: shr  $4,<len=int64#5d
# asm 2: shr  $4,<len=%r8d
shr  $4,%r8d

# qhasm: *(uint32 *)(c + 1408) += len
# asm 1: addl <len=int64#5d,1408(<c=int64#2)
# asm 2: addl <len=%r8d,1408(<c=%rsi)
addl %r8d,1408(%rsi)

# qhasm: blp = &bl
# asm 1: leaq <bl=stack1024#1,>blp=int64#2
# asm 2: leaq <bl=0(%rsp),>blp=%rsi
leaq 0(%rsp),%rsi

# qhasm: *(int128 *)(blp + 0) = xmm8
# asm 1: movdqa <xmm8=int6464#9,0(<blp=int64#2)
# asm 2: movdqa <xmm8=%xmm8,0(<blp=%rsi)
movdqa %xmm8,0(%rsi)

# qhasm: *(int128 *)(blp + 16) = xmm9
# asm 1: movdqa <xmm9=int6464#10,16(<blp=int64#2)
# asm 2: movdqa <xmm9=%xmm9,16(<blp=%rsi)
movdqa %xmm9,16(%rsi)

# qhasm: *(int128 *)(blp + 32) = xmm12
# asm 1: movdqa <xmm12=int6464#13,32(<blp=int64#2)
# asm 2: movdqa <xmm12=%xmm12,32(<blp=%rsi)
movdqa %xmm12,32(%rsi)

# qhasm: *(int128 *)(blp + 48) = xmm14
# asm 1: movdqa <xmm14=int6464#15,48(<blp=int64#2)
# asm 2: movdqa <xmm14=%xmm14,48(<blp=%rsi)
movdqa %xmm14,48(%rsi)

# qhasm: *(int128 *)(blp + 64) = xmm11
# asm 1: movdqa <xmm11=int6464#12,64(<blp=int64#2)
# asm 2: movdqa <xmm11=%xmm11,64(<blp=%rsi)
movdqa %xmm11,64(%rsi)

# qhasm: *(int128 *)(blp + 80) = xmm15
# asm 1: movdqa <xmm15=int6464#16,80(<blp=int64#2)
# asm 2: movdqa <xmm15=%xmm15,80(<blp=%rsi)
movdqa %xmm15,80(%rsi)

# qhasm: *(int128 *)(blp + 96) = xmm10
# asm 1: movdqa <xmm10=int6464#11,96(<blp=int64#2)
# asm 2: movdqa <xmm10=%xmm10,96(<blp=%rsi)
movdqa %xmm10,96(%rsi)

# qhasm: *(int128 *)(blp + 112) = xmm13
# asm 1: movdqa <xmm13=int6464#14,112(<blp=int64#2)
# asm 2: movdqa <xmm13=%xmm13,112(<blp=%rsi)
movdqa %xmm13,112(%rsi)

# qhasm: bytes:
._bytes:

# qhasm: =? lensav-0
# asm 1: cmp  $0,<lensav=int64#1
# asm 2: cmp  $0,<lensav=%rdi
cmp  $0,%rdi
# comment:fp stack unchanged by jump

# qhasm: goto end if =
je ._end

# qhasm: b = *(uint8 *)(blp + 0)
# asm 1: movzbq 0(<blp=int64#2),>b=int64#5
# asm 2: movzbq 0(<blp=%rsi),>b=%r8
movzbq 0(%rsi),%r8

# qhasm: (uint8) b ^= *(uint8 *)(inp + 0)
# asm 1: xorb 0(<inp=int64#3),<b=int64#5b
# asm 2: xorb 0(<inp=%rdx),<b=%r8b
xorb 0(%rdx),%r8b

# qhasm: *(uint8 *)(outp + 0) = b
# asm 1: movb   <b=int64#5b,0(<outp=int64#4)
# asm 2: movb   <b=%r8b,0(<outp=%rcx)
movb   %r8b,0(%rcx)

# qhasm: blp += 1
# asm 1: add  $1,<blp=int64#2
# asm 2: add  $1,<blp=%rsi
add  $1,%rsi

# qhasm: inp +=1
# asm 1: add  $1,<inp=int64#3
# asm 2: add  $1,<inp=%rdx
add  $1,%rdx

# qhasm: outp +=1
# asm 1: add  $1,<outp=int64#4
# asm 2: add  $1,<outp=%rcx
add  $1,%rcx

# qhasm: lensav -= 1
# asm 1: sub  $1,<lensav=int64#1
# asm 2: sub  $1,<lensav=%rdi
sub  $1,%rdi
# comment:fp stack unchanged by jump

# qhasm: goto bytes
jmp ._bytes

# qhasm: full:
._full:

# qhasm: *(uint32 *)(c + 1408) += 8
# asm 1: addl $8,1408(<c=int64#2)
# asm 2: addl $8,1408(<c=%rsi)
addl $8,1408(%rsi)

# qhasm: xmm8 ^= *(int128 *)(inp + 0)
# asm 1: pxor 0(<inp=int64#3),<xmm8=int6464#9
# asm 2: pxor 0(<inp=%rdx),<xmm8=%xmm8
pxor 0(%rdx),%xmm8

# qhasm: xmm9 ^= *(int128 *)(inp + 16)
# asm 1: pxor 16(<inp=int64#3),<xmm9=int6464#10
# asm 2: pxor 16(<inp=%rdx),<xmm9=%xmm9
pxor 16(%rdx),%xmm9

# qhasm: xmm12 ^= *(int128 *)(inp + 32)
# asm 1: pxor 32(<inp=int64#3),<xmm12=int6464#13
# asm 2: pxor 32(<inp=%rdx),<xmm12=%xmm12
pxor 32(%rdx),%xmm12

# qhasm: xmm14 ^= *(int128 *)(inp + 48)
# asm 1: pxor 48(<inp=int64#3),<xmm14=int6464#15
# asm 2: pxor 48(<inp=%rdx),<xmm14=%xmm14
pxor 48(%rdx),%xmm14

# qhasm: xmm11 ^= *(int128 *)(inp + 64)
# asm 1: pxor 64(<inp=int64#3),<xmm11=int6464#12
# asm 2: pxor 64(<inp=%rdx),<xmm11=%xmm11
pxor 64(%rdx),%xmm11

# qhasm: xmm15 ^= *(int128 *)(inp + 80)
# asm 1: pxor 80(<inp=int64#3),<xmm15=int6464#16
# asm 2: pxor 80(<inp=%rdx),<xmm15=%xmm15
pxor 80(%rdx),%xmm15

# qhasm: xmm10 ^= *(int128 *)(inp + 96)
# asm 1: pxor 96(<inp=int64#3),<xmm10=int6464#11
# asm 2: pxor 96(<inp=%rdx),<xmm10=%xmm10
pxor 96(%rdx),%xmm10

# qhasm: xmm13 ^= *(int128 *)(inp + 112)
# asm 1: pxor 112(<inp=int64#3),<xmm13=int6464#14
# asm 2: pxor 112(<inp=%rdx),<xmm13=%xmm13
pxor 112(%rdx),%xmm13

# qhasm: *(int128 *) (outp + 0) = xmm8
# asm 1: movdqa <xmm8=int6464#9,0(<outp=int64#4)
# asm 2: movdqa <xmm8=%xmm8,0(<outp=%rcx)
movdqa %xmm8,0(%rcx)

# qhasm: *(int128 *) (outp + 16) = xmm9
# asm 1: movdqa <xmm9=int6464#10,16(<outp=int64#4)
# asm 2: movdqa <xmm9=%xmm9,16(<outp=%rcx)
movdqa %xmm9,16(%rcx)

# qhasm: *(int128 *) (outp + 32) = xmm12
# asm 1: movdqa <xmm12=int6464#13,32(<outp=int64#4)
# asm 2: movdqa <xmm12=%xmm12,32(<outp=%rcx)
movdqa %xmm12,32(%rcx)

# qhasm: *(int128 *) (outp + 48) = xmm14
# asm 1: movdqa <xmm14=int6464#15,48(<outp=int64#4)
# asm 2: movdqa <xmm14=%xmm14,48(<outp=%rcx)
movdqa %xmm14,48(%rcx)

# qhasm: *(int128 *) (outp + 64) = xmm11
# asm 1: movdqa <xmm11=int6464#12,64(<outp=int64#4)
# asm 2: movdqa <xmm11=%xmm11,64(<outp=%rcx)
movdqa %xmm11,64(%rcx)

# qhasm: *(int128 *) (outp + 80) = xmm15
# asm 1: movdqa <xmm15=int6464#16,80(<outp=int64#4)
# asm 2: movdqa <xmm15=%xmm15,80(<outp=%rcx)
movdqa %xmm15,80(%rcx)

# qhasm: *(int128 *) (outp + 96) = xmm10
# asm 1: movdqa <xmm10=int6464#11,96(<outp=int64#4)
# asm 2: movdqa <xmm10=%xmm10,96(<outp=%rcx)
movdqa %xmm10,96(%rcx)

# qhasm: *(int128 *) (outp + 112) = xmm13
# asm 1: movdqa <xmm13=int6464#14,112(<outp=int64#4)
# asm 2: movdqa <xmm13=%xmm13,112(<outp=%rcx)
movdqa %xmm13,112(%rcx)
# comment:fp stack unchanged by fallthrough

# qhasm: end:
._end:

# qhasm: leave
add %r11,%rsp
mov %rdi,%rax
mov %rsi,%rdx
ret

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
.globl sbox
	.section	.rodata
	.p2align 6
	.type	sbox, @object
	.size	sbox, 256
sbox:
	.byte	99
	.byte	124
	.byte	119
	.byte	123
	.byte	-14
	.byte	107
	.byte	111
	.byte	-59
	.byte	48
	.byte	1
	.byte	103
	.byte	43
	.byte	-2
	.byte	-41
	.byte	-85
	.byte	118
	.byte	-54
	.byte	-126
	.byte	-55
	.byte	125
	.byte	-6
	.byte	89
	.byte	71
	.byte	-16
	.byte	-83
	.byte	-44
	.byte	-94
	.byte	-81
	.byte	-100
	.byte	-92
	.byte	114
	.byte	-64
	.byte	-73
	.byte	-3
	.byte	-109
	.byte	38
	.byte	54
	.byte	63
	.byte	-9
	.byte	-52
	.byte	52
	.byte	-91
	.byte	-27
	.byte	-15
	.byte	113
	.byte	-40
	.byte	49
	.byte	21
	.byte	4
	.byte	-57
	.byte	35
	.byte	-61
	.byte	24
	.byte	-106
	.byte	5
	.byte	-102
	.byte	7
	.byte	18
	.byte	-128
	.byte	-30
	.byte	-21
	.byte	39
	.byte	-78
	.byte	117
	.byte	9
	.byte	-125
	.byte	44
	.byte	26
	.byte	27
	.byte	110
	.byte	90
	.byte	-96
	.byte	82
	.byte	59
	.byte	-42
	.byte	-77
	.byte	41
	.byte	-29
	.byte	47
	.byte	-124
	.byte	83
	.byte	-47
	.byte	0
	.byte	-19
	.byte	32
	.byte	-4
	.byte	-79
	.byte	91
	.byte	106
	.byte	-53
	.byte	-66
	.byte	57
	.byte	74
	.byte	76
	.byte	88
	.byte	-49
	.byte	-48
	.byte	-17
	.byte	-86
	.byte	-5
	.byte	67
	.byte	77
	.byte	51
	.byte	-123
	.byte	69
	.byte	-7
	.byte	2
	.byte	127
	.byte	80
	.byte	60
	.byte	-97
	.byte	-88
	.byte	81
	.byte	-93
	.byte	64
	.byte	-113
	.byte	-110
	.byte	-99
	.byte	56
	.byte	-11
	.byte	-68
	.byte	-74
	.byte	-38
	.byte	33
	.byte	16
	.byte	-1
	.byte	-13
	.byte	-46
	.byte	-51
	.byte	12
	.byte	19
	.byte	-20
	.byte	95
	.byte	-105
	.byte	68
	.byte	23
	.byte	-60
	.byte	-89
	.byte	126
	.byte	61
	.byte	100
	.byte	93
	.byte	25
	.byte	115
	.byte	96
	.byte	-127
	.byte	79
	.byte	-36
	.byte	34
	.byte	42
	.byte	-112
	.byte	-120
	.byte	70
	.byte	-18
	.byte	-72
	.byte	20
	.byte	-34
	.byte	94
	.byte	11
	.byte	-37
	.byte	-32
	.byte	50
	.byte	58
	.byte	10
	.byte	73
	.byte	6
	.byte	36
	.byte	92
	.byte	-62
	.byte	-45
	.byte	-84
	.byte	98
	.byte	-111
	.byte	-107
	.byte	-28
	.byte	121
	.byte	-25
	.byte	-56
	.byte	55
	.byte	109
	.byte	-115
	.byte	-43
	.byte	78
	.byte	-87
	.byte	108
	.byte	86
	.byte	-12
	.byte	-22
	.byte	101
	.byte	122
	.byte	-82
	.byte	8
	.byte	-70
	.byte	120
	.byte	37
	.byte	46
	.byte	28
	.byte	-90
	.byte	-76
	.byte	-58
	.byte	-24
	.byte	-35
	.byte	116
	.byte	31
	.byte	75
	.byte	-67
	.byte	-117
	.byte	-118
	.byte	112
	.byte	62
	.byte	-75
	.byte	102
	.byte	72
	.byte	3
	.byte	-10
	.byte	14
	.byte	97
	.byte	53
	.byte	87
	.byte	-71
	.byte	-122
	.byte	-63
	.byte	29
	.byte	-98
	.byte	-31
	.byte	-8
	.byte	-104
	.byte	17
	.byte	105
	.byte	-39
	.byte	-114
	.byte	-108
	.byte	-101
	.byte	30
	.byte	-121
	.byte	-23
	.byte	-50
	.byte	85
	.byte	40
	.byte	-33
	.byte	-116
	.byte	-95
	.byte	-119
	.byte	13
	.byte	-65
	.byte	-26
	.byte	66
	.byte	104
	.byte	65
	.byte	-103
	.byte	45
	.byte	15
	.byte	-80
	.byte	84
	.byte	-69
	.byte	22

# qhasm: int64 ctxp

# qhasm: int64 iv

# qhasm: input ctxp

# qhasm: input iv

# qhasm: int6464 d

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

# qhasm: enter ECRYPT_init
.text
.p2align 5
.globl _ECRYPT_init
.globl ECRYPT_init
_ECRYPT_init:
ECRYPT_init:
mov %rsp,%r11
and $31,%r11
add $0,%r11
sub %r11,%rsp

# qhasm: leave
add %r11,%rsp
mov %rdi,%rax
mov %rsi,%rdx
ret

# qhasm: enter ECRYPT_ivsetup
.text
.p2align 5
.globl _ECRYPT_ivsetup
.globl ECRYPT_ivsetup
_ECRYPT_ivsetup:
ECRYPT_ivsetup:
mov %rsp,%r11
and $31,%r11
add $0,%r11
sub %r11,%rsp

# qhasm:   d = *(int128 *) (iv + 0)
# asm 1: movdqa 0(<iv=int64#2),>d=int6464#1
# asm 2: movdqa 0(<iv=%rsi),>d=%xmm0
movdqa 0(%rsi),%xmm0

# qhasm:   *(int128 *)(ctxp + 1408) = d
# asm 1: movdqa <d=int6464#1,1408(<ctxp=int64#1)
# asm 2: movdqa <d=%xmm0,1408(<ctxp=%rdi)
movdqa %xmm0,1408(%rdi)

# qhasm: leave
add %r11,%rsp
mov %rdi,%rax
mov %rsi,%rdx
ret
# Author: Emilia Käsper and Peter Schwabe
# Date: 2009-03-19
# Public domain

.data

.globl BM31
.globl BM30
.globl BM29
.globl BM28

.globl BM27
.globl BM26
.globl BM25
.globl BM24

.globl BM23
.globl BM22
.globl BM21
.globl BM20

.globl BM19
.globl BM18
.globl BM17
.globl BM16

.globl BM15
.globl BM14
.globl BM13
.globl BM12

.globl BM11
.globl BM10
.globl BM09
.globl BM08

.globl BM07
.globl BM06
.globl BM05
.globl BM04

.globl BM03
.globl BM02
.globl BM01
.globl BM00

.globl REVERS

.globl BIT063
.globl BIT064
.globl BIT127
.globl GCMPOL

.globl SWAP32
.globl M0SWAP
.globl RCON
.globl ROTB
.globl EXPB0
.globl ONE
.globl BS0
.globl BS1
.globl BS2
.globl CTRINC1
.globl CTRINC2
.globl CTRINC3
.globl CTRINC4
.globl CTRINC5
.globl CTRINC6
.globl CTRINC7
.globl RCTRINC1
.globl RCTRINC2
.globl RCTRINC3
.globl RCTRINC4
.globl RCTRINC5
.globl RCTRINC6
.globl RCTRINC7
.globl M0
.globl M0SR
.globl SRM0
.globl SR
.globl PTRMSK

.p2align 6
#.align 16

#.section .rodata

RCON: .int 0x00000000, 0x00000000, 0x00000000, 0xffffffff
ROTB: .int 0x0c000000, 0x00000000, 0x04000000, 0x08000000
EXPB0: .int 0x03030303, 0x07070707, 0x0b0b0b0b, 0x0f0f0f0f
CTRINC1: .int 0x00000001, 0x00000000, 0x00000000, 0x00000000
CTRINC2: .int 0x00000002, 0x00000000, 0x00000000, 0x00000000
CTRINC3: .int 0x00000003, 0x00000000, 0x00000000, 0x00000000
CTRINC4: .int 0x00000004, 0x00000000, 0x00000000, 0x00000000
CTRINC5: .int 0x00000005, 0x00000000, 0x00000000, 0x00000000
CTRINC6: .int 0x00000006, 0x00000000, 0x00000000, 0x00000000
CTRINC7: .int 0x00000007, 0x00000000, 0x00000000, 0x00000000

SWAP32: .int 0x00010203, 0x04050607, 0x08090a0b, 0x0c0d0e0f
RCTRINC1: .int 0x00000000, 0x00000000, 0x00000000, 0x00000001
RCTRINC2: .int 0x00000000, 0x00000000, 0x00000000, 0x00000002
RCTRINC3: .int 0x00000000, 0x00000000, 0x00000000, 0x00000003
RCTRINC4: .int 0x00000000, 0x00000000, 0x00000000, 0x00000004
RCTRINC5: .int 0x00000000, 0x00000000, 0x00000000, 0x00000005
RCTRINC6: .int 0x00000000, 0x00000000, 0x00000000, 0x00000006
RCTRINC7: .int 0x00000000, 0x00000000, 0x00000000, 0x00000007

REVERS: .quad 0x08090A0B0C0D0E0F, 0x0001020304050607

BIT063: .quad 0x0000000000000000, 0x0000000000000001
BIT064: .quad 0x8000000000000000, 0x0000000000000000
BIT127: .quad 0x0000000000000001, 0x0000000000000000
GCMPOL: .quad 0x0000000000000000, 0xE100000000000000

BM31: .quad 0x0000000100000001, 0x0000000100000001
BM30: .quad 0x0000000200000002, 0x0000000200000002
BM29: .quad 0x0000000400000004, 0x0000000400000004
BM28: .quad 0x0000000800000008, 0x0000000800000008

BM27: .quad 0x0000001000000010, 0x0000001000000010
BM26: .quad 0x0000002000000020, 0x0000002000000020
BM25: .quad 0x0000004000000040, 0x0000004000000040
BM24: .quad 0x0000008000000080, 0x0000008000000080

BM23: .quad 0x0000010000000100, 0x0000010000000100
BM22: .quad 0x0000020000000200, 0x0000020000000200
BM21: .quad 0x0000040000000400, 0x0000040000000400
BM20: .quad 0x0000080000000800, 0x0000080000000800

BM19: .quad 0x0000100000001000, 0x0000100000001000
BM18: .quad 0x0000200000002000, 0x0000200000002000
BM17: .quad 0x0000400000004000, 0x0000400000004000
BM16: .quad 0x0000800000008000, 0x0000800000008000

BM15: .quad 0x0001000000010000, 0x0001000000010000
BM14: .quad 0x0002000000020000, 0x0002000000020000
BM13: .quad 0x0004000000040000, 0x0004000000040000
BM12: .quad 0x0008000000080000, 0x0008000000080000

BM11: .quad 0x0010000000100000, 0x0010000000100000
BM10: .quad 0x0020000000200000, 0x0020000000200000
BM09: .quad 0x0040000000400000, 0x0040000000400000
BM08: .quad 0x0080000000800000, 0x0080000000800000

BM07: .quad 0x0100000001000000, 0x0100000001000000
BM06: .quad 0x0200000002000000, 0x0200000002000000
BM05: .quad 0x0400000004000000, 0x0400000004000000
BM04: .quad 0x0800000008000000, 0x0800000008000000

BM03: .quad 0x1000000010000000, 0x1000000010000000
BM02: .quad 0x2000000020000000, 0x2000000020000000
BM01: .quad 0x4000000040000000, 0x4000000040000000
BM00: .quad 0x8000000080000000, 0x8000000080000000

BS0: .quad 0x5555555555555555, 0x5555555555555555
BS1: .quad 0x3333333333333333, 0x3333333333333333
BS2: .quad 0x0f0f0f0f0f0f0f0f, 0x0f0f0f0f0f0f0f0f
ONE: .quad 0xffffffffffffffff, 0xffffffffffffffff
M0SWAP: .quad 0x0105090d0004080c , 0x03070b0f02060a0e
M0:  .quad 0x02060a0e03070b0f, 0x0004080c0105090d
M0SR:	.quad 0x0a0e02060f03070b, 0x0004080c05090d01
SRM0:	.quad 0x0304090e00050a0f, 0x01060b0c0207080d
SR: .quad 0x0504070600030201, 0x0f0e0d0c0a09080b
PTRMSK: .int 0xfffffff0, 0xffffffff


