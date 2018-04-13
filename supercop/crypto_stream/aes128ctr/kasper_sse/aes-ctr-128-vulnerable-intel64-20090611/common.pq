# Author: Peter Schwabe, ported from an assembly implementation by Emilia Käsper
# Date: 2009-03-19
# Public domain

@define setH(i, a, t0, t1, m, o) ;\
  t0 = i ;\
  t0 &= m;\
  int32323232 t0 = (t0 == m)q~0:0;\
  ;\
  t1 = shuffle dwords of t0 by 0xff;\
  t1 &= *(int128 *) (a + 0);\
  o ^= t1;\
  ;\
  t1 = shuffle dwords of t0 by 0xaa;\
  t1 &= *(int128 *) (a + 512);\
  o ^= t1;\
  ;\
  t1 = shuffle dwords of t0 by 0x55;\
  t1 &= *(int128 *) (a + 1024);\
  o ^= t1;\
  ;\
  t1 = shuffle dwords of t0 by 0x00;\
  t1 &= *(int128 *) (a + 1536);\
  o ^= t1;\


@define setzero(i) ;\
  *(int128 *) (gfmtable + $ i*256 $) = zero;\


# Compute value for monomial i at table k
@define monomial(k, i) ;\
  *(uint64 *) (gfmtable + $ k*256 + 16 * (((i & 1) << 3) ^ ((i & 2) << 1) ^ ((i & 4) >> 1) ^ ((i & 8) >> 3)) $) = z1;\
  *(uint64 *) (gfmtable + $ k*256 + 16 * (((i & 1) << 3) ^ ((i & 2) << 1) ^ ((i & 4) >> 1) ^ ((i & 8) >> 3)) + 8 $) = z3;\
  ;\
  (uint64) bswap z1;\
  (uint64) bswap z3;\
  ;\
  carry1 = z1;\
  carry2 = z3;\
  ;\
  (uint32) carry1 &= 1 ;\
  (uint32) carry2 &= 1 ;\
  ;\
  (uint64) z1 >>= 1;\
  (uint64) z3 >>= 1;\
  ;\
  (uint64) bswap z1;\
  (uint64) bswap z3;\
  ;\
  carry1 <<= 7;\
  z3 ^= carry1;\
  carry2 *= red;\
  z1 ^= carry2;\


@define filltable0 ;\
  t0dq = *(int128 *) (gfmtable + $ 16 * 8 $);\
  t1dq = *(int128 *) (gfmtable + $ 16 * 4 $);\
  t2dq = *(int128 *) (gfmtable + $ 16 * 2 $);\
  t3dq = *(int128 *) (gfmtable + $ 16 * 1 $);\
  tmp = t0dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 16 * 12 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 16 * 14 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 16 * 10 $) = tmp;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ 16 * 11 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 16 * 9 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 16 * 13 $) = tmp;\
  tmp ^= t0dq;\
  *(int128 *) (gfmtable + $ 16 * 5 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 16 * 7 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 16 * 3 $) = tmp;\
  tmp ^= t3dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 16 * 6 $) = tmp;\
  tmp ^= t0dq;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ 16 * 15 $) = tmp;\


@define filltable1 ;\
  t0dq = *(int128 *) (gfmtable + $ 256 + 16 * 8 $);\
  t1dq = *(int128 *) (gfmtable + $ 256 + 16 * 4 $);\
  t2dq = *(int128 *) (gfmtable + $ 256 + 16 * 2 $);\
  t3dq = *(int128 *) (gfmtable + $ 256 + 16 * 1 $);\
  tmp = t0dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 12 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 14 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 10 $) = tmp;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 11 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 9 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 13 $) = tmp;\
  tmp ^= t0dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 5 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 7 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 3 $) = tmp;\
  tmp ^= t3dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 6 $) = tmp;\
  tmp ^= t0dq;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ 256 + 16 * 15 $) = tmp;\

@define filltable(i) ;\
  cbyte0 = t0dq;\
  t0dq <<= 8;\
  cbyte0 >>= 120;\
  carry0 = cbyte0[0];\
  cbyte0 = *(uint32 *) (redtable + carry0 * 4);\
  t0dq ^= cbyte0;\
  ;\
  cbyte1 = t1dq;\
  t1dq <<= 8;\
  cbyte1 >>= 120;\
  carry1 = cbyte1[0];\
  cbyte1 = *(uint32 *) (redtable + carry1 * 4);\
  t1dq ^= cbyte1;\
  ;\
  cbyte2 = t2dq;\
  t2dq <<= 8;\
  cbyte2 >>= 120;\
  carry2 = cbyte2[0];\
  cbyte2 = *(uint32 *) (redtable + carry2 * 4);\
  t2dq ^= cbyte2;\
  ;\
  cbyte3 = t3dq;\
  t3dq <<= 8;\
  cbyte3 >>= 120;\
  carry3 = cbyte3[0];\
  cbyte3 = *(uint32 *) (redtable + carry3 * 4);\
  t3dq ^= cbyte3;\
  ;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 8 $) = t0dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 4 $) = t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 2 $) = t2dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 1 $) = t3dq;\
  tmp = t0dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 12 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 14 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 10 $) = tmp;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 11 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 9 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 13 $) = tmp;\
  tmp ^= t0dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 5 $) = tmp;\
  tmp ^= t2dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 7 $) = tmp;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 3 $) = tmp;\
  tmp ^= t3dq;\
  tmp ^= t1dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 6 $) = tmp;\
  tmp ^= t0dq;\
  tmp ^= t3dq;\
  *(int128 *) (gfmtable + $ i * 256 + 16 * 15 $) = tmp;\


# Multiplies z1u, z3u with H and puts the result again in t0dql
# Needs a 0xf0f0f0f0f0f0f0f0 mask
@define multab(z1u,z3u,gfmtable,mask) ;\
  z3l = z3u;\
  z3u <<= 4;\
  z3u &= mask;\
  z3l &= mask;\
  ;\
  rbyte0u = z3u & 255;\
  rbyte0l = z3l & 255;\
  t0dql = *(int128 *)(gfmtable + 4096 + rbyte0l);\
  t0dqu = *(int128 *)(gfmtable + 4352 + rbyte0u);\
  ;\
  rbyte0u = (z3u >> 8) & 255;\
  rbyte0l = (z3l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 4608 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 4864 + rbyte0u);\
  ;\
  (uint64) z3u >>= 16;\
  (uint64) z3l >>= 16;\
  ;\
  rbyte0u = z3u & 255;\
  rbyte0l = z3l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 5120 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 5376 + rbyte0u);\
  ;\
  rbyte0u = (z3u >> 8) & 255;\
  rbyte0l = (z3l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 5632 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 5888 + rbyte0u);\
  ;\
  (uint64) z3u >>= 16;\
  (uint64) z3l >>= 16;\
  ;\
  rbyte0u = z3u & 255;\
  rbyte0l = z3l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 6144 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 6400 + rbyte0u);\
  ;\
  rbyte0u = (z3u >> 8) & 255;\
  rbyte0l = (z3l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 6656 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 6912 + rbyte0u);\
  ;\
  (uint64) z3u >>= 16;\
  (uint64) z3l >>= 16;\
  ;\
  rbyte0u = z3u & 255;\
  rbyte0l = z3l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 7168 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 7424 + rbyte0u);\
  ;\
  rbyte0u = (z3u >> 8) & 255;\
  rbyte0l = (z3l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 7680 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 7936 + rbyte0u);\
  ;\
  ;\
  z1l = z1u;\
  z1u <<= 4;\
  z1u &= mask;\
  z1l &= mask;\
  ;\
  rbyte0u = z1u & 255;\
  rbyte0l = z1l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 0 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 256 + rbyte0u);\
  ;\
  rbyte0u = (z1u >> 8) & 255;\
  rbyte0l = (z1l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 512 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 768 + rbyte0u);\
  ;\
  (uint64) z1u >>= 16;\
  (uint64) z1l >>= 16;\
  ;\
  rbyte0u = z1u & 255;\
  rbyte0l = z1l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 1024 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 1280 + rbyte0u);\
  ;\
  rbyte0u = (z1u >> 8) & 255;\
  rbyte0l = (z1l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 1536 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 1792 + rbyte0u);\
  ;\
  (uint64) z1u >>= 16;\
  (uint64) z1l >>= 16;\
  ;\
  rbyte0u = z1u & 255;\
  rbyte0l = z1l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 2048 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 2304 + rbyte0u);\
  ;\
  rbyte0u = (z1u >> 8) & 255;\
  rbyte0l = (z1l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 2560 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 2816 + rbyte0u);\
  ;\
  (uint64) z1u >>= 16;\
  (uint64) z1l >>= 16;\
  ;\
  rbyte0u = z1u & 255;\
  rbyte0l = z1l & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 3072 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 3328 + rbyte0u);\
  ;\
  rbyte0u = (z1u >> 8) & 255;\
  rbyte0l = (z1l >> 8) & 255;\
  uint32323232 t0dql ^= *(int128 *)(gfmtable + 3584 + rbyte0l);\
  uint32323232 t0dqu ^= *(int128 *)(gfmtable + 3840 + rbyte0u);\
  ;\
  t0dql ^= t0dqu;\

@define bitslicekey0(key, bskey) \
  xmm0 = *(int128 *) (key + 0);\
  shuffle bytes of xmm0 by M0;\
  xmm1 = xmm0;\
  xmm2 = xmm0;\
  xmm3 = xmm0;\
  xmm4 = xmm0;\
  xmm5 = xmm0;\
  xmm6 = xmm0;\
  xmm7 = xmm0;\
  ;\
  bitslice(xmm7, xmm6, xmm5, xmm4, xmm3, xmm2, xmm1, xmm0, t);\
  ;\
  *(int128 *) (bskey + 0) = xmm0;\
  *(int128 *) (bskey + 16) = xmm1;\
  *(int128 *) (bskey + 32) = xmm2;\
  *(int128 *) (bskey + 48) = xmm3;\
  *(int128 *) (bskey + 64) = xmm4;\
  *(int128 *) (bskey + 80) = xmm5;\
  *(int128 *) (bskey + 96) = xmm6;\
  *(int128 *) (bskey + 112) = xmm7;\


@define bitslicekey10(key, bskey) \
  xmm0 = *(int128 *) (key + 0);\
  xmm1 = xmm0;\
  xmm2 = xmm0;\
  xmm3 = xmm0;\
  xmm4 = xmm0;\
  xmm5 = xmm0;\
  xmm6 = xmm0;\
  xmm7 = xmm0;\
  ;\
  bitslice(xmm7, xmm6, xmm5, xmm4, xmm3, xmm2, xmm1, xmm0, t);\
  ;\
  xmm6 ^= ONE;\
  xmm5 ^= ONE;\
  xmm1 ^= ONE;\
  xmm0 ^= ONE;\
  ;\
  *(int128 *) (bskey + $   0 + 1280 $) = xmm0;\
  *(int128 *) (bskey + $  16 + 1280 $) = xmm1;\
  *(int128 *) (bskey + $  32 + 1280 $) = xmm2;\
  *(int128 *) (bskey + $  48 + 1280 $) = xmm3;\
  *(int128 *) (bskey + $  64 + 1280 $) = xmm4;\
  *(int128 *) (bskey + $  80 + 1280 $) = xmm5;\
  *(int128 *) (bskey + $  96 + 1280 $) = xmm6;\
  *(int128 *) (bskey + $ 112 + 1280 $) = xmm7;\
  

@define bitslicekey(i,key,bskey) \
  xmm0 = *(int128 *) (key + 0);\
  shuffle bytes of xmm0 by M0;\
  xmm1 = xmm0;\
  xmm2 = xmm0;\
  xmm3 = xmm0;\
  xmm4 = xmm0;\
  xmm5 = xmm0;\
  xmm6 = xmm0;\
  xmm7 = xmm0;\
  ;\
  bitslice(xmm7, xmm6, xmm5, xmm4, xmm3, xmm2, xmm1, xmm0, t);\
  ;\
  xmm6 ^= ONE;\
  xmm5 ^= ONE;\
  xmm1 ^= ONE;\
  xmm0 ^= ONE;\
  ;\
  *(int128 *) (bskey + $   0 + 128*i $) = xmm0;\
  *(int128 *) (bskey + $  16 + 128*i $) = xmm1;\
  *(int128 *) (bskey + $  32 + 128*i $) = xmm2;\
  *(int128 *) (bskey + $  48 + 128*i $) = xmm3;\
  *(int128 *) (bskey + $  64 + 128*i $) = xmm4;\
  *(int128 *) (bskey + $  80 + 128*i $) = xmm5;\
  *(int128 *) (bskey + $  96 + 128*i $) = xmm6;\
  *(int128 *) (bskey + $ 112 + 128*i $) = xmm7;\


@define rotbyte(x) \
  shuffle bytes of x by ROTB;\
  

@define keyexp(i, key) \
  e = (x3 >> 8) & 255;\
  e = *(uint8 *) (sboxp + e);\
  (uint32) e ^= $ ((1 << (i-1)) ^ 0x1b * ((1 << (i-1) >> 8))) & 0xff $;\
  ;\
  q3 = x3 & 255;\
  q3 = *(uint8 *) (sboxp + q3);\
  q3 <<= 24;\
  e ^= q3;\
  ;\
  (uint32) x3 <<<= 16;\
  ;\
  q2 = (x3 >> 8) & 255;\
  q2 = *(uint8 *) (sboxp + q2);\
  q2 <<= 16;\
  e ^= q2;\
  ;\
  q1 = x3 & 255;\
  (uint32) x3 <<<= 16;\
  q1 = *(uint8 *) (sboxp + q1);\
  q1 <<= 8;\
  e ^= q1;\
  ;\
  x0 ^= e;\
  ;\
  *(uint32 *) (key + 0) = x0;\
  x1 ^= x0;\
  *(uint32 *) (key + 4) = x1;\
  x2 ^= x1;\
  *(uint32 *) (key + 8) = x2;\
  x3 ^= x2;\
  *(uint32 *) (key + 12) = x3;\
 

@define keyexpbs1(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7, bskey) \
  rotbyte(b0);\
  rotbyte(b1);\
  rotbyte(b2);\
  rotbyte(b3);\
  rotbyte(b4);\
  rotbyte(b5);\
  rotbyte(b6);\
  rotbyte(b7);\
  ;\
  sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7);\
  ;\
  b0 ^= RCON;\
  shuffle bytes of b0 by EXPB0;\
  shuffle bytes of b1 by EXPB0;\
  shuffle bytes of b4 by EXPB0;\
  shuffle bytes of b6 by EXPB0;\
  shuffle bytes of b3 by EXPB0;\
  shuffle bytes of b7 by EXPB0;\
  shuffle bytes of b2 by EXPB0;\
  shuffle bytes of b5 by EXPB0;\
  ;\
  t0 = *(int128 *)(bskey + 0);\
  t1 = *(int128 *)(bskey + 16);\
  t2 = *(int128 *)(bskey + 32);\
  t3 = *(int128 *)(bskey + 48);\
  t4 = *(int128 *)(bskey + 64);\
  t5 = *(int128 *)(bskey + 80);\
  t6 = *(int128 *)(bskey + 96);\
  t7 = *(int128 *)(bskey + 112);\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  *(int128 *)(bskey + 128) = b0;\
  *(int128 *)(bskey + 144) = b1;\
  *(int128 *)(bskey + 160) = b4;\
  *(int128 *)(bskey + 176) = b6;\
  *(int128 *)(bskey + 192) = b3;\
  *(int128 *)(bskey + 208) = b7;\
  *(int128 *)(bskey + 224) = b2;\
  *(int128 *)(bskey + 240) = b5;\

@define keyexpbs10(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7, bskey) ;\
  b0 ^= ONE;\
  b1 ^= ONE;\
  b5 ^= ONE;\
  b6 ^= ONE;\
  rotbyte(b0);\
  rotbyte(b1);\
  rotbyte(b2);\
  rotbyte(b3);\
  rotbyte(b4);\
  rotbyte(b5);\
  rotbyte(b6);\
  rotbyte(b7);\
  ;\
  sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7);\
  ;\
  b1 ^= RCON;\
  b4 ^= RCON;\
  b3 ^= RCON;\
  b7 ^= RCON;\
  shuffle bytes of b0 by EXPB0;\
  shuffle bytes of b1 by EXPB0;\
  shuffle bytes of b4 by EXPB0;\
  shuffle bytes of b6 by EXPB0;\
  shuffle bytes of b3 by EXPB0;\
  shuffle bytes of b7 by EXPB0;\
  shuffle bytes of b2 by EXPB0;\
  shuffle bytes of b5 by EXPB0;\
  ;\
  t0 = *(int128 *)(bskey + $ 9 * 128 + 0 $);\
  t1 = *(int128 *)(bskey + $ 9 * 128 + 16 $);\
  t2 = *(int128 *)(bskey + $ 9 * 128 + 32 $);\
  t3 = *(int128 *)(bskey + $ 9 * 128 + 48 $);\
  t4 = *(int128 *)(bskey + $ 9 * 128 + 64 $);\
  t5 = *(int128 *)(bskey + $ 9 * 128 + 80 $);\
  t6 = *(int128 *)(bskey + $ 9 * 128 + 96 $);\
  t7 = *(int128 *)(bskey + $ 9 * 128 + 112 $);\
  ;\
  t0 ^= ONE;\
  t1 ^= ONE;\
  t5 ^= ONE;\
  t6 ^= ONE;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  shuffle bytes of b0 by M0;\
  shuffle bytes of b1 by M0;\
  shuffle bytes of b2 by M0;\
  shuffle bytes of b3 by M0;\
  shuffle bytes of b4 by M0;\
  shuffle bytes of b5 by M0;\
  shuffle bytes of b6 by M0;\
  shuffle bytes of b7 by M0;\
  ;\
  *(int128 *)(bskey + 1280) = b0;\
  *(int128 *)(bskey + 1296) = b1;\
  *(int128 *)(bskey + 1312) = b4;\
  *(int128 *)(bskey + 1328) = b6;\
  *(int128 *)(bskey + 1344) = b3;\
  *(int128 *)(bskey + 1360) = b7;\
  *(int128 *)(bskey + 1376) = b2;\
  *(int128 *)(bskey + 1392) = b5;\


@define keyexpbs(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7, rcon, i, bskey) \
  b0 ^= ONE;\
  b1 ^= ONE;\
  b5 ^= ONE;\
  b6 ^= ONE;\
  rotbyte(b0);\
  rotbyte(b1);\
  rotbyte(b2);\
  rotbyte(b3);\
  rotbyte(b4);\
  rotbyte(b5);\
  rotbyte(b6);\
  rotbyte(b7);\
  ;\
  sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7);\
  ;\
  rcon;\
  shuffle bytes of b0 by EXPB0;\
  shuffle bytes of b1 by EXPB0;\
  shuffle bytes of b4 by EXPB0;\
  shuffle bytes of b6 by EXPB0;\
  shuffle bytes of b3 by EXPB0;\
  shuffle bytes of b7 by EXPB0;\
  shuffle bytes of b2 by EXPB0;\
  shuffle bytes of b5 by EXPB0;\
  ;\
  t0 = *(int128 *)(bskey + $ (i-1) * 128 + 0 $);\
  t1 = *(int128 *)(bskey + $ (i-1) * 128 + 16 $);\
  t2 = *(int128 *)(bskey + $ (i-1) * 128 + 32 $);\
  t3 = *(int128 *)(bskey + $ (i-1) * 128 + 48 $);\
  t4 = *(int128 *)(bskey + $ (i-1) * 128 + 64 $);\
  t5 = *(int128 *)(bskey + $ (i-1) * 128 + 80 $);\
  t6 = *(int128 *)(bskey + $ (i-1) * 128 + 96 $);\
  t7 = *(int128 *)(bskey + $ (i-1) * 128 + 112 $);\
  ;\
  t0 ^= ONE;\
  t1 ^= ONE;\
  t5 ^= ONE;\
  t6 ^= ONE;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  uint32323232 t0 >>= 8;\
  uint32323232 t1 >>= 8;\
  uint32323232 t2 >>= 8;\
  uint32323232 t3 >>= 8;\
  uint32323232 t4 >>= 8;\
  uint32323232 t5 >>= 8;\
  uint32323232 t6 >>= 8;\
  uint32323232 t7 >>= 8;\
  ;\
  b0 ^= t0;\
  b1 ^= t1;\
  b4 ^= t2;\
  b6 ^= t3;\
  b3 ^= t4;\
  b7 ^= t5;\
  b2 ^= t6;\
  b5 ^= t7;\
  ;\
  *(int128 *)(bskey + $ i*128 + 0 $) = b0;\
  *(int128 *)(bskey + $ i*128 + 16 $) = b1;\
  *(int128 *)(bskey + $ i*128 + 32 $) = b4;\
  *(int128 *)(bskey + $ i*128 + 48 $) = b6;\
  *(int128 *)(bskey + $ i*128 + 64 $) = b3;\
  *(int128 *)(bskey + $ i*128 + 80 $) = b7;\
  *(int128 *)(bskey + $ i*128 + 96 $) = b2;\
  *(int128 *)(bskey + $ i*128 + 112 $) = b5;\


@define shiftrows(x0, x1, x2, x3, x4, x5, x6, x7, i, M, bskey) \
	x0 ^= *(int128 *)(bskey + $ 128*(i-1) + 0 $);\
	shuffle bytes of x0 by M;\
	x1 ^= *(int128 *)(bskey + $ 128*(i-1) + 16 $);\
	shuffle bytes of x1 by M;\
	x2 ^= *(int128 *)(bskey + $ 128*(i-1) + 32 $);\
	shuffle bytes of x2 by M;\
	x3 ^= *(int128 *)(bskey + $ 128*(i-1) + 48 $);\
	shuffle bytes of x3 by M;\
	x4 ^= *(int128 *)(bskey + $ 128*(i-1) + 64 $);\
	shuffle bytes of x4 by M;\
	x5 ^= *(int128 *)(bskey + $ 128*(i-1) + 80 $);\
	shuffle bytes of x5 by M;\
	x6 ^= *(int128 *)(bskey + $ 128*(i-1) + 96 $);\
	shuffle bytes of x6 by M;\
	x7 ^= *(int128 *)(bskey + $ 128*(i-1) + 112 $);\
	shuffle bytes of x7 by M;\


@define mixcolumns(x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2, t3, t4, t5, t6, t7) \
	t0 = shuffle dwords of x0 by 0x93;\
	t1 = shuffle dwords of x1 by 0x93;\
	t2 = shuffle dwords of x2 by 0x93;\
	t3 = shuffle dwords of x3 by 0x93;\
	t4 = shuffle dwords of x4 by 0x93;\
	t5 = shuffle dwords of x5 by 0x93;\
	t6 = shuffle dwords of x6 by 0x93;\
	t7 = shuffle dwords of x7 by 0x93;\
	;\
	x0 ^= t0;\
	x1 ^= t1;\
	x2 ^= t2;\
	x3 ^= t3;\
	x4 ^= t4;\
	x5 ^= t5;\
	x6 ^= t6;\
	x7 ^= t7;\
	;\
	t0 ^= x7;\
	t1 ^= x0;\
	t2 ^= x1;\
	t1 ^= x7;\
	t3 ^= x2;\
	t4 ^= x3;\
	t5 ^= x4;\
	t3 ^= x7;\
	t6 ^= x5;\
	t7 ^= x6;\
	t4 ^= x7;\
	;\
	x0 = shuffle dwords of x0 by 0x4E;\
	x1 = shuffle dwords of x1 by 0x4E;\
	x2 = shuffle dwords of x2 by 0x4E;\
	x3 = shuffle dwords of x3 by 0x4E;\
	x4 = shuffle dwords of x4 by 0x4E;\
	x5 = shuffle dwords of x5 by 0x4E;\
	x6 = shuffle dwords of x6 by 0x4E;\
	x7 = shuffle dwords of x7 by 0x4E;\
	;\
	t0 ^= x0;\
	t1 ^= x1;\
	t2 ^= x2;\
	t3 ^= x3;\
	t4 ^= x4;\
	t5 ^= x5;\
	t6 ^= x6;\
	t7 ^= x7;\
	
@define aesround(i, b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7, bskey) \
	shiftrows(b0, b1, b2, b3, b4, b5, b6, b7, i, SR, bskey);\
	sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7);\
	mixcolumns(b0, b1, b4, b6, b3, b7, b2, b5, t0, t1, t2, t3, t4, t5, t6, t7);\

@define lastround(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7, bskey) \
	shiftrows(b0, b1, b2, b3, b4, b5, b6, b7, 10, SRM0, bskey);\
	sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, t4, t5, t6, t7);\
	b0 ^= *(int128 *)(bskey + $ 128*10 $);\
	b1 ^= *(int128 *)(bskey + $ 128*10+16 $);\
	b4 ^= *(int128 *)(bskey + $ 128*10+32 $);\
	b6 ^= *(int128 *)(bskey + $ 128*10+48 $);\
	b3 ^= *(int128 *)(bskey + $ 128*10+64 $);\
	b7 ^= *(int128 *)(bskey + $ 128*10+80 $);\
	b2 ^= *(int128 *)(bskey + $ 128*10+96 $);\
	b5 ^= *(int128 *)(bskey + $ 128*10+112 $);\

@define swapmove(a, b, n, m, t) \
	t = b;\
	uint6464 t >>= n;\
	t ^= a;\
	t &= m;\
	a ^= t;\
	uint6464 t <<= n;\
	b ^= t;\

@define bitslice(x0, x1, x2, x3, x4, x5, x6, x7, t) \
	swapmove(x0, x1, 1, BS0, t);\
	swapmove(x2, x3, 1, BS0, t);\
	swapmove(x4, x5, 1, BS0, t);\
	swapmove(x6, x7, 1, BS0, t);\
	;\
	swapmove(x0, x2, 2, BS1, t);\
	swapmove(x1, x3, 2, BS1, t);\
	swapmove(x4, x6, 2, BS1, t);\
	swapmove(x5, x7, 2, BS1, t);\
	;\
	swapmove(x0, x4, 4, BS2, t);\
	swapmove(x1, x5, 4, BS2, t);\
	swapmove(x2, x6, 4, BS2, t);\
	swapmove(x3, x7, 4, BS2, t);\

@define sbox(b0, b1, b2, b3, b4, b5, b6, b7, t0, t1, t2, t3, s0, s1, s2, s3) \
	InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7); \
	Inv_GF256(b6, b5, b0, b3, b7, b1, b4, b2, t0, t1, t2, t3, s0, s1, s2, s3); \
	OutBasisChange(b7, b1, b4, b2, b6, b5, b0, b3); \

@define InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7) \
	b5 ^= b6;\
	b2 ^= b1;\
	b5 ^= b0;\
	b6 ^= b2;\
	b3 ^= b0;\
	;\
	b6 ^= b3;\
	b3 ^= b7;\
	b3 ^= b4;\
	b7 ^= b5;\
	b3 ^= b1;\
	;\
	b4 ^= b5;\
	b2 ^= b7;\
	b1 ^= b5;\
 
@define OutBasisChange(b0, b1, b2, b3, b4, b5, b6, b7) \
	b0 ^= b6;\
	b1 ^= b4;\
	b2 ^= b0;\
	b4 ^= b6;\
	b6 ^= b1;\
	;\
	b1 ^= b5;\
	b5 ^= b3;\
	b2 ^= b5;\
	b3 ^= b7;\
	b7 ^= b5;\
	;\
	b4 ^= b7;\
	
@define Mul_GF4(x0, x1, y0, y1, t0) \
	t0 = y0;\
	t0 ^= y1;\
	t0 &= x0;\
	x0 ^= x1;\
	x0 &= y1;\
	x1 &= y0;\
	x0 ^= x1;\
	x1 ^= t0;\
	
@define Mul_GF4_N(x0, x1, y0, y1, t0) \
	t0 = y0;\
	t0 ^= y1;\
	t0 &= x0;\
	x0 ^= x1;\
	x0 &= y1;\
	x1 &= y0;\
	x1 ^= x0;\
	x0 ^= t0;\
	
@define Mul_GF4_2(x0, x1, x2, x3, y0, y1, t0, t1) \
	t0 = y0;\
	t0 ^= y1;\
	t1 = t0;\
	t0 &= x0;\
	t1 &= x2;\
	x0 ^= x1;\
	x2 ^= x3;\
	x0 &= y1;\
	x2 &= y1;\
	x1 &= y0;\
	x3 &= y0;\
	x0 ^= x1;\
	x2 ^= x3;\
	x1 ^= t0;\
	x3 ^= t1;\
	
@define Mul_GF16(x0, x1, x2, x3, y0, y1, y2, y3, t0, t1, t2, t3) \
	t0 = x0;\
	t1 = x1;\
	Mul_GF4(x0, x1, y0, y1, t2);\
	t0 ^= x2;\
	t1 ^= x3;\
	y0 ^= y2;\
	y1 ^= y3;\
	Mul_GF4_N(t0, t1, y0, y1, t2);\
	Mul_GF4(x2, x3, y2, y3, t3);\
	;\
	x0 ^= t0;\
	x2 ^= t0;\
	x1 ^= t1;\
	x3 ^= t1;\
			
@define Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, t0, t1, t2, t3) \
	t0 = x0;\
	t1 = x1;\
	Mul_GF4(x0, x1, y0, y1, t2);\
	t0 ^= x2;\
	t1 ^= x3;\
	y0 ^= y2;\
	y1 ^= y3;\
	Mul_GF4_N(t0, t1, y0, y1, t3);\
	Mul_GF4(x2, x3, y2, y3, t2);\
	;\
	x0 ^= t0;\
	x2 ^= t0;\
	x1 ^= t1;\
	x3 ^= t1;\
	;\
	t0 = x4;\
	t1 = x5;\
	t0 ^= x6;\
	t1 ^= x7;\
	Mul_GF4_N(t0, t1, y0, y1, t3);\
	Mul_GF4(x6, x7, y2, y3, t2);\
	y0 ^= y2;\
	y1 ^= y3;\
	Mul_GF4(x4, x5, y0, y1, t3);\
	;\
	x4 ^= t0;\
	x6 ^= t0;\
	x5 ^= t1;\
	x7 ^= t1;\
	
@define Inv_GF16(x0, x1, x2, x3, t0, t1, t2, t3) \
	t0 = x1;\
	t1 = x0;\
	t0 &= x3;\
	t1 |= x2;\
	t2 = x1;\
	t3 = x0;\
	t2 |= x2;\
	t3 |= x3;\
	t2 ^= t3;\
	;\
	t0 ^= t2;\
	t1 ^= t2;\
	;\
	Mul_GF4_2(x0, x1, x2, x3, t1, t0, t2, t3);\

	
@define Inv_GF256(x0,  x1, x2, x3, x4, x5, x6, x7, t0, t1, t2, t3, s0, s1, s2, s3) \
	t3 = x4;\
	t2 = x5;\
	t1 = x1;\
	s1 = x7;\
	s0 = x0;\
	;\
	t3 ^= x6;\
	t2 ^= x7;\
	t1 ^= x3;\
	s1 ^= x6;\
	s0 ^= x2;\
	;\
	s2 = t3;\
	t0 = t2;\
	s3 = t3;\
	;\
	t2 |= t1;\
	t3 |= s0;\
	s3 ^= t0;\
	s2 &= s0;\
	t0 &= t1;\
	s0 ^= t1;\
	s3 &= s0;\
	s0 = x3;\
	s0 ^= x2;\
	s1 &= s0;\
	t3 ^= s1;\
	t2 ^= s1;\
	s1 = x4;\
	s1 ^= x5;\
	s0 = x1;\
	t1 = s1;\
	s0 ^= x0;\
	t1 |= s0;\
	s1 &= s0;\
	t0 ^= s1;\
	t3 ^= s3;\
	t2 ^= s2;\
	t1 ^= s3;\
	t0 ^= s2;\
	t1 ^= s2;\
	s0 = x7;\
	s1 = x6;\
	s2 = x5;\
	s3 = x4;\
	s0 &= x3;\
	s1 &= x2;\
	s2 &= x1;\
	s3 |= x0;\
	t3 ^= s0;\
	t2 ^= s1;\
	t1 ^= s2;\
	t0 ^= s3;\
  ;\
  s0 = t3;\
  s0 ^= t2;\
  t3 &= t1;\
  s2 = t0;\
  s2 ^= t3;\
  s3 = s0;\
  s3 &= s2;\
  s3 ^= t2;\
  s1 = t1;\
  s1 ^= t0;\
  t3 ^= t2;\
  s1 &= t3;\
  s1 ^= t0;\
  t1 ^= s1;\
  t2 = s2;\
  t2 ^= s1;\
  t2 &= t0;\
  t1 ^= t2;\
  s2 ^= t2;\
  s2 &= s3;\
  s2 ^= s0;\
  ;\
  Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, s3, s2, s1, t1, s0, t0, t2, t3);\
  	
  
