/*
u8.h version $Date: 2014/09/24 12:09:52 $
D. J. Bernstein
Romain Dolbeau
Public domain.
*/

#define likely(x)       __builtin_expect((x),1)
#define unlikely(x)     __builtin_expect((x),0)

  if (unlikely(!bytes)) return;
  u32 in12, in13;
  
  /* the naive way seems as fast (if not a bit faster) than the vector way */
  __m256i state__[16];
  
  __m256i orig0;
  __m256i orig1;
  __m256i orig2;
  __m256i orig3;
  __m256i orig4;
  __m256i orig5;
  __m256i orig6;
  __m256i orig7;
  __m256i orig8;
  __m256i orig9;
  __m256i orig10;
  __m256i orig11;
  __m256i orig12;// = x_12; /* useless */
  __m256i orig13;// = x_13; /* useless */
  __m256i orig14;
  __m256i orig15;
  
  state__[0] = orig0 = _mm256_set1_epi32(x[0]);
  state__[1] = orig1 = _mm256_set1_epi32(x[1]);
  state__[2] = orig2 = _mm256_set1_epi32(x[2]);
  state__[3] = orig3 = _mm256_set1_epi32(x[3]);
  state__[4] = orig4 = _mm256_set1_epi32(x[4]);
  state__[5] = orig5 = _mm256_set1_epi32(x[5]);
  state__[6] = orig6 = _mm256_set1_epi32(x[6]);
  state__[7] = orig7 = _mm256_set1_epi32(x[7]);
  state__[8] = orig8 = _mm256_set1_epi32(x[8]);
  state__[9] = orig9 = _mm256_set1_epi32(x[9]);
  state__[10] = orig10 = _mm256_set1_epi32(x[10]);
  state__[11] = orig11 = _mm256_set1_epi32(x[11]);
  state__[14] = orig14 = _mm256_set1_epi32(x[14]);
  state__[15] = orig15 = _mm256_set1_epi32(x[15]);

  while (bytes > 0) {
    state__[0] =  orig0;
    state__[1] =  orig1;
    state__[2] =  orig2;
    state__[3] =  orig3;
    state__[4] =  orig4;
    state__[5] =  orig5;
    state__[6] =  orig6;
    state__[7] =  orig7;
    state__[8] =  orig8;
    state__[9] =  orig9;
    state__[10] = orig10;
    state__[11] = orig11;
    state__[14] = orig14;
    state__[15] = orig15;

    const __m256i addv12 = _mm256_set_epi64x(3,2,1,0);
    const __m256i addv13 = _mm256_set_epi64x(7,6,5,4);
    const __m256i permute = _mm256_set_epi32(7,6,3,2,5,4,1,0);
    __m256i t12, t13;
    in12 = x[12];
    in13 = x[13];
    u64 in1213 = ((u64)in12) | (((u64)in13) << 32);
    state__[12] = _mm256_broadcastq_epi64(_mm_cvtsi64_si128(in1213));
    state__[13] = _mm256_broadcastq_epi64(_mm_cvtsi64_si128(in1213));

    t12 = _mm256_add_epi64(addv12, state__[12]);
    t13 = _mm256_add_epi64(addv13, state__[13]);

    state__[12] = _mm256_unpacklo_epi32(t12, t13);
    state__[13] = _mm256_unpackhi_epi32(t12, t13);

    t12 = _mm256_unpacklo_epi32(state__[12], state__[13]);
    t13 = _mm256_unpackhi_epi32(state__[12], state__[13]);

    /* required because unpack* are intra-lane */
    state__[12] = _mm256_permutevar8x32_epi32(t12, permute);
    state__[13] = _mm256_permutevar8x32_epi32(t13, permute);
    orig12 = state__[12];
    orig13 = state__[13];

    in1213 += 8;
    
    x[12] = in1213 & 0xFFFFFFFF;
    x[13] = (in1213>>32)&0xFFFFFFFF;

    for (i = 0 ; i < ROUNDS ; i+=2) {
      DR__AVX(state__,state__);
    }

    if (likely(bytes >= 512)) {
  __m256i t_0, t_1, t_2, t_3, t_4, t_5, t_6, t_7,
    t_8, t_9, t_10, t_11, t_12, t_13, t_14, t_15;

#define ONEQUAD_UNPCK(a,b,c,d)                              \
  {                                                         \
    state__[a] = _mm256_add_epi32(state__[a], orig##a);     \
    state__[b] = _mm256_add_epi32(state__[b], orig##b);     \
    state__[c] = _mm256_add_epi32(state__[c], orig##c);     \
    state__[d] = _mm256_add_epi32(state__[d], orig##d);     \
    t_##a = _mm256_unpacklo_epi32(state__[a], state__[b]);  \
    t_##b = _mm256_unpacklo_epi32(state__[c], state__[d]);  \
    t_##c = _mm256_unpackhi_epi32(state__[a], state__[b]);  \
    t_##d = _mm256_unpackhi_epi32(state__[c], state__[d]);  \
    state__[a] = _mm256_unpacklo_epi64(t_##a, t_##b);       \
    state__[b] = _mm256_unpackhi_epi64(t_##a, t_##b);       \
    state__[c] = _mm256_unpacklo_epi64(t_##c, t_##d);       \
    state__[d] = _mm256_unpackhi_epi64(t_##c, t_##d);       \
  }
#define ONEOCTO(a,b,c,d,a2,b2,c2,d2)                                    \
    {                                                                   \
      ONEQUAD_UNPCK(a,b,c,d);                                           \
      ONEQUAD_UNPCK(a2,b2,c2,d2);                                       \
      t_##a  = _mm256_permute2x128_si256(state__[a], state__[a2], 0x20);          \
      t_##a2 = _mm256_permute2x128_si256(state__[a], state__[a2], 0x31);          \
      t_##b  = _mm256_permute2x128_si256(state__[b], state__[b2], 0x20);          \
      t_##b2 = _mm256_permute2x128_si256(state__[b], state__[b2], 0x31);          \
      t_##c  = _mm256_permute2x128_si256(state__[c], state__[c2], 0x20);          \
      t_##c2 = _mm256_permute2x128_si256(state__[c], state__[c2], 0x31);          \
      t_##d  = _mm256_permute2x128_si256(state__[d], state__[d2], 0x20);          \
      t_##d2 = _mm256_permute2x128_si256(state__[d], state__[d2], 0x31);          \
      t_##a  = _mm256_xor_si256(t_##a , _mm256_loadu_si256((__m256i*)(m+  0))); \
      t_##b  = _mm256_xor_si256(t_##b , _mm256_loadu_si256((__m256i*)(m+ 64))); \
      t_##c  = _mm256_xor_si256(t_##c , _mm256_loadu_si256((__m256i*)(m+128))); \
      t_##d  = _mm256_xor_si256(t_##d , _mm256_loadu_si256((__m256i*)(m+192))); \
      t_##a2 = _mm256_xor_si256(t_##a2, _mm256_loadu_si256((__m256i*)(m+256))); \
      t_##b2 = _mm256_xor_si256(t_##b2, _mm256_loadu_si256((__m256i*)(m+320))); \
      t_##c2 = _mm256_xor_si256(t_##c2, _mm256_loadu_si256((__m256i*)(m+384))); \
      t_##d2 = _mm256_xor_si256(t_##d2, _mm256_loadu_si256((__m256i*)(m+448))); \
      _mm256_storeu_si256((__m256i*)(out+  0), t_##a );                  \
      _mm256_storeu_si256((__m256i*)(out+ 64), t_##b );                  \
      _mm256_storeu_si256((__m256i*)(out+128), t_##c );                  \
      _mm256_storeu_si256((__m256i*)(out+192), t_##d );                  \
      _mm256_storeu_si256((__m256i*)(out+256), t_##a2);                  \
      _mm256_storeu_si256((__m256i*)(out+320), t_##b2);                  \
      _mm256_storeu_si256((__m256i*)(out+384), t_##c2);                  \
      _mm256_storeu_si256((__m256i*)(out+448), t_##d2);                  \
    }
    
    ONEOCTO(0,1,2,3,4,5,6,7);
    m+=32;
    out+=32;
    ONEOCTO(8,9,10,11,12,13,14,15);
    m-=32;
    out-=32;
    
#undef ONEQUAD
#undef ONEQUAD_TRANSPOSE
#undef ONEQUAD_UNPCK
#undef ONEOCTO

    bytes -= 512;
    out += 512;
    m += 512;

    } else {
#define A(i) state__[i] = _mm256_add_epi32(state__[i],orig##i)
    A(0); A(1); A(2);  A(3);  A(4);  A(5);  A(6);  A(7);
    A(8); A(9); A(10); A(11); A(12); A(13); A(14); A(15);
    __m256i cipher[16];
    for (int i = 0; i < 2; i++) {
      Transpose_8_8(&state__[i*8+0],&state__[i*8+1],&state__[i*8+2],&state__[i*8+3],
                    &state__[i*8+4],&state__[i*8+5],&state__[i*8+6],&state__[i*8+7]);
      cipher[i+0]  = state__[i*8+0];
      cipher[i+2]  = state__[i*8+1];
      cipher[i+4]  = state__[i*8+2];
      cipher[i+6]  = state__[i*8+3];
      cipher[i+8]  = state__[i*8+4];
      cipher[i+10] = state__[i*8+5];
      cipher[i+12] = state__[i*8+6];
      cipher[i+14] = state__[i*8+7];
    }
    #define end_xor(type)                                                   \
    for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {    \
      *((type*)out) = *((type*)out_state_char) ^ *((type*)m);           \
      out += sizeof(type);                                              \
      out_state_char += sizeof(type);                                   \
      m += sizeof(type);                                                \
    }
    unsigned long encrypted = bytes > 512 ? 512 : bytes;
    bytes -= encrypted;
    unsigned char* out_state_char = (unsigned char*)cipher;
    end_xor(unsigned long);
    end_xor(unsigned int);
    end_xor(unsigned char);
    
    }
  }
#undef VEC8_ROT
#undef VEC8_QUARTERROUND
#undef VEC8_QUARTERROUND_NAIVE
#undef VEC8_QUARTERROUND_SHUFFLE
#undef VEC8_QUARTERROUND_SHUFFLE2
#undef VEC8_LINE1
#undef VEC8_LINE2
#undef VEC8_LINE3
#undef VEC8_LINE4
#undef VEC8_ROUND
#undef VEC8_ROUND_SEQ
#undef VEC8_ROUND_HALF
#undef VEC8_ROUND_HALFANDHALF

