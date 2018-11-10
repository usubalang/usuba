/*
u4.h version $Date: 2014/11/11 10:46:58 $
D. J. Bernstein
Romain Dolbeau
Public domain.
*/

#define likely(x)       __builtin_expect((x),1)
#define unlikely(x)     __builtin_expect((x),0)


  if (unlikely(!bytes)) return;
  u32 in12, in13;
  
    /* the naive way seems as fast (if not a bit faster) than the vector way */
  __m128i state__[16];
  
  __m128i orig0;
  __m128i orig1;
  __m128i orig2;
  __m128i orig3;
  __m128i orig4;
  __m128i orig5;
  __m128i orig6;
  __m128i orig7;
  __m128i orig8;
  __m128i orig9;
  __m128i orig10;
  __m128i orig11;
  __m128i orig12;// = x_12; /* useless */
  __m128i orig13;// = x_13; /* useless */
  __m128i orig14;
  __m128i orig15;
  
  state__[0]  = orig0  = _mm_set1_epi32(x[0]);
  state__[1]  = orig1  = _mm_set1_epi32(x[1]);
  state__[2]  = orig2  = _mm_set1_epi32(x[2]);
  state__[3]  = orig3  = _mm_set1_epi32(x[3]);
  state__[4]  = orig4  = _mm_set1_epi32(x[4]);
  state__[5]  = orig5  = _mm_set1_epi32(x[5]);
  state__[6]  = orig6  = _mm_set1_epi32(x[6]);
  state__[7]  = orig7  = _mm_set1_epi32(x[7]);
  state__[8]  = orig8  = _mm_set1_epi32(x[8]);
  state__[9]  = orig9  = _mm_set1_epi32(x[9]);
  state__[10] = orig10 = _mm_set1_epi32(x[10]);
  state__[11] = orig11 = _mm_set1_epi32(x[11]);
  state__[14] = orig14 = _mm_set1_epi32(x[14]);
  state__[15] = orig15 = _mm_set1_epi32(x[15]);

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


    const __m128i addv12 = _mm_set_epi64x(1,0);
    const __m128i addv13 = _mm_set_epi64x(3,2);
    __m128i t12, t13;
    in12 = x[12];
    in13 = x[13];
    u64 in1213 = ((u64)in12) | (((u64)in13) << 32);
    t12 = _mm_set1_epi64x(in1213);
    t13 = _mm_set1_epi64x(in1213);

    state__[12] = _mm_add_epi64(addv12, t12);
    state__[13] = _mm_add_epi64(addv13, t13);

    t12 = _mm_unpacklo_epi32(state__[12], state__[13]);
    t13 = _mm_unpackhi_epi32(state__[12], state__[13]);

    state__[12] = _mm_unpacklo_epi32(t12, t13);
    state__[13] = _mm_unpackhi_epi32(t12, t13);

    orig12 = state__[12];
    orig13 = state__[13];

    in1213 += 4;
    
    x[12] = in1213 & 0xFFFFFFFF;
    x[13] = (in1213>>32)&0xFFFFFFFF;

    Chacha20__(state__,state__);
    
#define ONEQUAD_TRANSPOSE(a,b,c,d)                                      \
    {                                                                   \
      __m128i t0, t1, t2, t3;                                           \
      state__[a] = _mm_add_epi32(state__[a], orig##a);                  \
      state__[b] = _mm_add_epi32(state__[b], orig##b);                  \
      state__[c] = _mm_add_epi32(state__[c], orig##c);                  \
      state__[d] = _mm_add_epi32(state__[d], orig##d);                  \
      t_##a = _mm_unpacklo_epi32(state__[a], state__[b]);                      \
      t_##b = _mm_unpacklo_epi32(state__[c], state__[d]);                      \
      t_##c = _mm_unpackhi_epi32(state__[a], state__[b]);                      \
      t_##d = _mm_unpackhi_epi32(state__[c], state__[d]);                      \
      state__[a] = _mm_unpacklo_epi64(t_##a, t_##b);                      \
      state__[b] = _mm_unpackhi_epi64(t_##a, t_##b);                      \
      state__[c] = _mm_unpacklo_epi64(t_##c, t_##d);                      \
      state__[d] = _mm_unpackhi_epi64(t_##c, t_##d);                      \
      t0 = _mm_xor_si128(state__[a], _mm_loadu_si128((__m128i*)(m+0)));       \
      _mm_storeu_si128((__m128i*)(out+0),t0);                            \
      t1 = _mm_xor_si128(state__[b], _mm_loadu_si128((__m128i*)(m+64)));      \
      _mm_storeu_si128((__m128i*)(out+64),t1);                           \
      t2 = _mm_xor_si128(state__[c], _mm_loadu_si128((__m128i*)(m+128)));     \
      _mm_storeu_si128((__m128i*)(out+128),t2);                          \
      t3 = _mm_xor_si128(state__[d], _mm_loadu_si128((__m128i*)(m+192)));     \
      _mm_storeu_si128((__m128i*)(out+192),t3);                          \
    }
    
#define ONEQUAD(a,b,c,d) ONEQUAD_TRANSPOSE(a,b,c,d)

    if (likely(bytes >= 256)) {
  __m128i t_0, t_1, t_2, t_3, t_4, t_5, t_6, t_7,
    t_8, t_9, t_10, t_11, t_12, t_13, t_14, t_15;
    ONEQUAD(0,1,2,3);
    m+=16;
    out+=16;
    ONEQUAD(4,5,6,7);
    m+=16;
    out+=16;
    ONEQUAD(8,9,10,11);
    m+=16;
    out+=16;
    ONEQUAD(12,13,14,15);
    m-=48;
    out-=48;
    
#undef ONEQUAD
#undef ONEQUAD_TRANSPOSE

    bytes -= 256;
    out += 256;
    m += 256;

    } else {

#define TRANSPOSE4(row0, row1, row2, row3)      \
    do {                                        \
      __m128i tmp0, tmp1, tmp2, tmp3;            \
      tmp0 = _mm_unpacklo_epi32(row0, row1);    \
      tmp1 = _mm_unpacklo_epi32(row2, row3);    \
      tmp2 = _mm_unpackhi_epi32(row0, row1);    \
      tmp3 = _mm_unpackhi_epi32(row2, row3);    \
      row0 = _mm_unpacklo_epi64(tmp0, tmp1);    \
      row1 = _mm_unpackhi_epi64(tmp0, tmp1);    \
      row2 = _mm_unpacklo_epi64(tmp2, tmp3);    \
      row3 = _mm_unpackhi_epi64(tmp2, tmp3);    \
    } while (0)
    
#define A(i) state__[i] = _mm_add_epi32(state__[i],orig##i)
    A(0); A(1); A(2);  A(3);  A(4);  A(5);  A(6);  A(7);
    A(8); A(9); A(10); A(11); A(12); A(13); A(14); A(15);
    __m128i cipher[16];
    for (int i = 0; i < 4; i++) {
      TRANSPOSE4(state__[i*4+0],state__[i*4+1],state__[i*4+2],state__[i*4+3]);
      cipher[i+0]  = state__[i*4+0];
      cipher[i+4]  = state__[i*4+1];
      cipher[i+8]  = state__[i*4+2];
      cipher[i+12] = state__[i*4+3];
    }
#define end_xor(type)                                                   \
    for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {    \
      *((type*)out) = *((type*)out_state_char) ^ *((type*)m);           \
      out += sizeof(type);                                              \
      out_state_char += sizeof(type);                                   \
      m += sizeof(type);                                                \
    }
    unsigned long encrypted = bytes > 256 ? 256 : bytes;
    bytes -= encrypted;
    unsigned char* out_state_char = (unsigned char*)cipher;
    end_xor(unsigned long);
    end_xor(unsigned int);
    end_xor(unsigned char);
    
    }
 }
#undef VEC4_ROT
#undef VEC4_QUARTERROUND
#undef VEC4_QUARTERROUND_SHUFFLE
