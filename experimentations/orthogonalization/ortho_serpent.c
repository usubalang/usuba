
#define TRANSPOSE4(row0, row1, row2, row3)                  \
  do {                                                      \
    __m128 tmp3, tmp2, tmp1, tmp0;                          \
    tmp0 = _mm_unpacklo_ps((__m128)(row0), (__m128)(row1)); \
    tmp2 = _mm_unpacklo_ps((__m128)(row2), (__m128)(row3)); \
    tmp1 = _mm_unpackhi_ps((__m128)(row0), (__m128)(row1)); \
    tmp3 = _mm_unpackhi_ps((__m128)(row2), (__m128)(row3)); \
    row0 = (__m128i)_mm_movelh_ps(tmp0, tmp2);              \
    row1 = (__m128i)_mm_movehl_ps(tmp2, tmp0);              \
    row2 = (__m128i)_mm_movelh_ps(tmp1, tmp3);              \
    row3 = (__m128i)_mm_movehl_ps(tmp3, tmp1);              \
  } while (0)

/* #define TRANSPOSE4(row0, row1, row2, row3)      \ */
/*     do {                                        \ */
/*       __m128i tmp0, tmp1, tmp2, tmp3;            \ */
/*       tmp0 = _mm_unpacklo_epi32(row0, row1);    \ */
/*       tmp1 = _mm_unpacklo_epi32(row2, row3);    \ */
/*       tmp2 = _mm_unpackhi_epi32(row0, row1);    \ */
/*       tmp3 = _mm_unpackhi_epi32(row2, row3);    \ */
/*       row0 = _mm_unpacklo_epi64(tmp0, tmp1);    \ */
/*       row1 = _mm_unpackhi_epi64(tmp0, tmp1);    \ */
/*       row2 = _mm_unpacklo_epi64(tmp2, tmp3);    \ */
/*       row3 = _mm_unpackhi_epi64(tmp2, tmp3);    \ */
    /* } while (0) */
