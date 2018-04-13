# Author: Peter Schwabe, ported from an assembly implementation by Emilia Käsper
# Date: 2009-03-19
# Public domain

@include "common.pq"

int64 action
int64 c
int64 inp
int64 outp
int64 len

input action
input c
input inp
input outp
input len

int64 lensav

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

stack1024 bl
int64 blp
int64 b

enter ECRYPT_process_bytes

# The following two lines are completely pointless
# except that they make the code run faster
unsigned>? len-0
goto enc_block if unsigned>

enc_block:

xmm0 = *(int128 *) (c + 1408)
xmm1 = xmm0
xmm2 = xmm0
xmm3 = xmm0
xmm4 = xmm0
xmm5 = xmm0
xmm6 = xmm0
xmm7 = xmm0

int32323232 xmm1 += CTRINC1
int32323232 xmm2 += CTRINC2
int32323232 xmm3 += CTRINC3
int32323232 xmm4 += CTRINC4
int32323232 xmm5 += CTRINC5
int32323232 xmm6 += CTRINC6
int32323232 xmm7 += CTRINC7

shuffle bytes of xmm0 by M0
shuffle bytes of xmm1 by M0
shuffle bytes of xmm2 by M0
shuffle bytes of xmm3 by M0
shuffle bytes of xmm4 by M0
shuffle bytes of xmm5 by M0
shuffle bytes of xmm6 by M0
shuffle bytes of xmm7 by M0

bitslice(xmm7, xmm6, xmm5, xmm4, xmm3, xmm2, xmm1, xmm0, xmm8)

aesround( 1, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, c)
aesround( 2, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, c)
aesround( 3, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, c)
aesround( 4, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, c)
aesround( 5, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, c)
aesround( 6, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, c)
aesround( 7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, c)
aesround( 8, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, c)
aesround( 9, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, c)
lastround( xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, c)

bitslice(xmm13, xmm10, xmm15, xmm11, xmm14, xmm12, xmm9, xmm8, xmm0)

unsigned<? =? len-128
goto partial if unsigned<
goto full if =

*(uint32 *)(c + 1408) += 8

xmm8 ^= *(int128 *)(inp + 0)
xmm9 ^= *(int128 *)(inp + 16)
xmm12 ^= *(int128 *)(inp + 32)
xmm14 ^= *(int128 *)(inp + 48)
xmm11 ^= *(int128 *)(inp + 64)
xmm15 ^= *(int128 *)(inp + 80)
xmm10 ^= *(int128 *)(inp + 96)
xmm13 ^= *(int128 *)(inp + 112)

*(int128 *) (outp + 0) = xmm8
*(int128 *) (outp + 16) = xmm9
*(int128 *) (outp + 32) = xmm12
*(int128 *) (outp + 48) = xmm14
*(int128 *) (outp + 64) = xmm11
*(int128 *) (outp + 80) = xmm15
*(int128 *) (outp + 96) = xmm10
*(int128 *) (outp + 112) = xmm13

len -= 128
inp += 128
outp += 128

goto enc_block
	
partial:

lensav = len
(uint32) len >>= 4
*(uint32 *)(c + 1408) += len
blp = &bl
*(int128 *)(blp + 0) = xmm8
*(int128 *)(blp + 16) = xmm9
*(int128 *)(blp + 32) = xmm12
*(int128 *)(blp + 48) = xmm14
*(int128 *)(blp + 64) = xmm11
*(int128 *)(blp + 80) = xmm15
*(int128 *)(blp + 96) = xmm10
*(int128 *)(blp + 112) = xmm13

bytes:

=? lensav-0
goto end if =

b = *(uint8 *)(blp + 0)
(uint8) b ^= *(uint8 *)(inp + 0)
*(uint8 *)(outp + 0) = b

blp += 1
inp +=1
outp +=1
lensav -= 1


goto bytes

full:

*(uint32 *)(c + 1408) += 8

xmm8 ^= *(int128 *)(inp + 0)
xmm9 ^= *(int128 *)(inp + 16)
xmm12 ^= *(int128 *)(inp + 32)
xmm14 ^= *(int128 *)(inp + 48)
xmm11 ^= *(int128 *)(inp + 64)
xmm15 ^= *(int128 *)(inp + 80)
xmm10 ^= *(int128 *)(inp + 96)
xmm13 ^= *(int128 *)(inp + 112)

*(int128 *) (outp + 0) = xmm8
*(int128 *) (outp + 16) = xmm9
*(int128 *) (outp + 32) = xmm12
*(int128 *) (outp + 48) = xmm14
*(int128 *) (outp + 64) = xmm11
*(int128 *) (outp + 80) = xmm15
*(int128 *) (outp + 96) = xmm10
*(int128 *) (outp + 112) = xmm13

end:

leave
