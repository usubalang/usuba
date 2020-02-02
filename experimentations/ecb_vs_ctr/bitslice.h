#pragma once
#include <x86intrin.h>

#define swapmove(a, b, n, m, t)                 \
  t = _mm_srli_epi32(b,n);                      \
  t = _mm_xor_si128(t,a);                       \
  t = _mm_and_si128(t,m);                       \
  a = _mm_xor_si128(a,t);                       \
  t = _mm_slli_epi32(t,n);                      \
  b = _mm_xor_si128(b,t);

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7)    \
  {                                                 \
    __m128i t0, t1;                                 \
    t0 = _mm_set1_epi32(0x55555555);                \
    swapmove(x7, x6, 1, t0, t1);                    \
    swapmove(x5, x4, 1, t0, t1);                    \
    swapmove(x3, x2, 1, t0, t1);                    \
    swapmove(x1, x0, 1, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x33333333);                \
    swapmove(x7, x5, 2, t0, t1);                    \
    swapmove(x6, x4, 2, t0, t1);                    \
    swapmove(x3, x1, 2, t0, t1);                    \
    swapmove(x2, x0, 2, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x0f0f0f0f);                \
    swapmove(x7, x3, 4, t0, t1);                    \
    swapmove(x6, x2, 4, t0, t1);                    \
    swapmove(x5, x1, 4, t0, t1);                    \
    swapmove(x4, x0, 4, t0, t1);                    \
  }
