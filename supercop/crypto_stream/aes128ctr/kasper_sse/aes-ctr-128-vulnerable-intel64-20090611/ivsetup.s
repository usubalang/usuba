
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
