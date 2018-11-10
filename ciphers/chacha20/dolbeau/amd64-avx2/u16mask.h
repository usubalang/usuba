/*
u16.h version $Date$
D. J. Bernstein
Romain Dolbeau
Public domain.
*/

#define VEC16_ROT(a,imm) _mm512_rol_epi32(a, imm)

#define VEC16_LINE1(a,b,c,d)                                             \
  x_##a = _mm512_add_epi32(x_##a, x_##b); x_##d = VEC16_ROT(_mm512_xor_si512(x_##d, x_##a), 16)
#define VEC16_LINE2(a,b,c,d)                                             \
  x_##c = _mm512_add_epi32(x_##c, x_##d); x_##b = VEC16_ROT(_mm512_xor_si512(x_##b, x_##c), 12)
#define VEC16_LINE3(a,b,c,d)                                             \
  x_##a = _mm512_add_epi32(x_##a, x_##b); x_##d = VEC16_ROT(_mm512_xor_si512(x_##d, x_##a),  8)
#define VEC16_LINE4(a,b,c,d)                                             \
  x_##c = _mm512_add_epi32(x_##c, x_##d); x_##b = VEC16_ROT(_mm512_xor_si512(x_##b, x_##c),  7)

#define VEC16_4L1(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) \
	{ __m512i t0, t1, t2, t3;				   \
		x_##a1 = _mm512_add_epi32(x_##a1, x_##b1);	   \
		x_##a2 = _mm512_add_epi32(x_##a2, x_##b2);	   \
		x_##a3 = _mm512_add_epi32(x_##a3, x_##b3);	   \
		x_##a4 = _mm512_add_epi32(x_##a4, x_##b4);	   \
		t0 = _mm512_xor_si512(x_##d1, x_##a1);		   \
		t1 = _mm512_xor_si512(x_##d2, x_##a2);		   \
		t2 = _mm512_xor_si512(x_##d3, x_##a3);		   \
		t3 = _mm512_xor_si512(x_##d4, x_##a4);		   \
		x_##d1 = VEC16_ROT(t0, 16);			   \
		x_##d2 = VEC16_ROT(t1, 16);			   \
		x_##d3 = VEC16_ROT(t2, 16);			   \
		x_##d4 = VEC16_ROT(t3, 16);			   \
	}
#define VEC16_4L2(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) \
	{ __m512i t0, t1, t2, t3;				   \
		x_##c1 = _mm512_add_epi32(x_##c1, x_##d1);	   \
		x_##c2 = _mm512_add_epi32(x_##c2, x_##d2);	   \
		x_##c3 = _mm512_add_epi32(x_##c3, x_##d3);	   \
		x_##c4 = _mm512_add_epi32(x_##c4, x_##d4);	   \
		t0 = _mm512_xor_si512(x_##b1, x_##c1);		   \
		t1 = _mm512_xor_si512(x_##b2, x_##c2);		   \
		t2 = _mm512_xor_si512(x_##b3, x_##c3);		   \
		t3 = _mm512_xor_si512(x_##b4, x_##c4);		   \
		x_##b1 = VEC16_ROT(t0, 12);			   \
		x_##b2 = VEC16_ROT(t1, 12);			   \
		x_##b3 = VEC16_ROT(t2, 12);			   \
		x_##b4 = VEC16_ROT(t3, 12);			   \
	}
#define VEC16_4L3(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) \
	{ __m512i t0, t1, t2, t3;				   \
		x_##a1 = _mm512_add_epi32(x_##a1, x_##b1);	   \
		x_##a2 = _mm512_add_epi32(x_##a2, x_##b2);	   \
		x_##a3 = _mm512_add_epi32(x_##a3, x_##b3);	   \
		x_##a4 = _mm512_add_epi32(x_##a4, x_##b4);	   \
		t0 = _mm512_xor_si512(x_##d1, x_##a1);		   \
		t1 = _mm512_xor_si512(x_##d2, x_##a2);		   \
		t2 = _mm512_xor_si512(x_##d3, x_##a3);		   \
		t3 = _mm512_xor_si512(x_##d4, x_##a4);		   \
		x_##d1 = VEC16_ROT(t0, 8);			   \
		x_##d2 = VEC16_ROT(t1, 8);			   \
		x_##d3 = VEC16_ROT(t2, 8);			   \
		x_##d4 = VEC16_ROT(t3, 8);			   \
	}
#define VEC16_4L4(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) \
	{ __m512i t0, t1, t2, t3;				   \
		x_##c1 = _mm512_add_epi32(x_##c1, x_##d1);	   \
		x_##c2 = _mm512_add_epi32(x_##c2, x_##d2);	   \
		x_##c3 = _mm512_add_epi32(x_##c3, x_##d3);	   \
		x_##c4 = _mm512_add_epi32(x_##c4, x_##d4);	   \
		t0 = _mm512_xor_si512(x_##b1, x_##c1);		   \
		t1 = _mm512_xor_si512(x_##b2, x_##c2);		   \
		t2 = _mm512_xor_si512(x_##b3, x_##c3);		   \
		t3 = _mm512_xor_si512(x_##b4, x_##c4);		   \
		x_##b1 = VEC16_ROT(t0, 7);			   \
		x_##b2 = VEC16_ROT(t1, 7);			   \
		x_##b3 = VEC16_ROT(t2, 7);			   \
		x_##b4 = VEC16_ROT(t3, 7);			   \
	}

#define VEC16_ROUND_SEQ(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)     \
  VEC16_LINE1(a1,b1,c1,d1);                                              \
  VEC16_LINE1(a2,b2,c2,d2);                                              \
  VEC16_LINE1(a3,b3,c3,d3);                                              \
  VEC16_LINE1(a4,b4,c4,d4);                                              \
  VEC16_LINE2(a1,b1,c1,d1);                                              \
  VEC16_LINE2(a2,b2,c2,d2);                                              \
  VEC16_LINE2(a3,b3,c3,d3);                                              \
  VEC16_LINE2(a4,b4,c4,d4);                                              \
  VEC16_LINE3(a1,b1,c1,d1);                                              \
  VEC16_LINE3(a2,b2,c2,d2);                                              \
  VEC16_LINE3(a3,b3,c3,d3);                                              \
  VEC16_LINE3(a4,b4,c4,d4);                                              \
  VEC16_LINE4(a1,b1,c1,d1);                                              \
  VEC16_LINE4(a2,b2,c2,d2);                                              \
  VEC16_LINE4(a3,b3,c3,d3);                                              \
  VEC16_LINE4(a4,b4,c4,d4)

#define VEC16_ROUND_INTER(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)     \
	VEC16_4L1(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)\
	VEC16_4L2(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)\
	VEC16_4L3(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)\
	VEC16_4L4(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)

/* SEQ seems faster than INTER on KNL, and nearly identical on SKX */
#define VEC16_ROUND(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) VEC16_ROUND_SEQ(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4)

  if (!bytes) return;
if (bytes>=64) {
	u32 todov = (bytes/64);
	u32 todo = todov*64;
  /* constant for shuffling bytes (replacing multiple-of-8 rotates) */
  u32 in12, in13;
  /* the naive way seems as fast (if not a bit faster) than the vector way */
  __m512i x_0 = _mm512_set1_epi32(x[0]);
  __m512i x_1 = _mm512_set1_epi32(x[1]);
  __m512i x_2 = _mm512_set1_epi32(x[2]);
  __m512i x_3 = _mm512_set1_epi32(x[3]);
  __m512i x_4 = _mm512_set1_epi32(x[4]);
  __m512i x_5 = _mm512_set1_epi32(x[5]);
  __m512i x_6 = _mm512_set1_epi32(x[6]);
  __m512i x_7 = _mm512_set1_epi32(x[7]);
  __m512i x_8 = _mm512_set1_epi32(x[8]);
  __m512i x_9 = _mm512_set1_epi32(x[9]);
  __m512i x_10 = _mm512_set1_epi32(x[10]);
  __m512i x_11 = _mm512_set1_epi32(x[11]);
  __m512i x_12;// = _mm512_set1_epi32(x[12]); /* useless */
  __m512i x_13;// = _mm512_set1_epi32(x[13]); /* useless */
  __m512i x_14 = _mm512_set1_epi32(x[14]);
  __m512i x_15 = _mm512_set1_epi32(x[15]);
  __m512i orig0 = x_0;
  __m512i orig1 = x_1;
  __m512i orig2 = x_2;
  __m512i orig3 = x_3;
  __m512i orig4 = x_4;
  __m512i orig5 = x_5;
  __m512i orig6 = x_6;
  __m512i orig7 = x_7;
  __m512i orig8 = x_8;
  __m512i orig9 = x_9;
  __m512i orig10 = x_10;
  __m512i orig11 = x_11;
  __m512i orig12;// = x_12; /* useless */
  __m512i orig13;// = x_13; /* useless */
  __m512i orig14 = x_14;
  __m512i orig15 = x_15;
  __m512i t_0;
  __m512i t_1;
  __m512i t_2;
  __m512i t_3;
  __m512i t_4;
  __m512i t_5;
  __m512i t_6;
  __m512i t_7;
  __m512i t_8;
  __m512i t_9;
  __m512i t_10;
  __m512i t_11;
  __m512i t_12;
  __m512i t_13;
  __m512i t_14;
  __m512i t_15;

  {
    x_0 = orig0;
    x_1 = orig1;
    x_2 = orig2;
    x_3 = orig3;
    x_4 = orig4;
    x_5 = orig5;
    x_6 = orig6;
    x_7 = orig7;
    x_8 = orig8;
    x_9 = orig9;
    x_10 = orig10;
    x_11 = orig11;
    //x_12 = orig12; /* useless */
    //x_13 = orig13; /* useless */
    x_14 = orig14;
    x_15 = orig15;

    const __m512i permute = _mm512_set_epi64(7,5,3,1,6,4,2,0);
    const __m512i addv12 = _mm512_set_epi64(7,6,5,4,3,2,1,0);
    const __m512i addv13 = _mm512_set_epi64(15,14,13,12,11,10,9,8);
    __m512i t12, t13;
    in12 = x[12];
    in13 = x[13]; // see arrays above for the address translation
    u64 in1213 = ((u64)in12) | (((u64)in13) << 32);

    x_12 = _mm512_broadcastq_epi64(_mm_cvtsi64_si128(in1213));
    x_13 = _mm512_broadcastq_epi64(_mm_cvtsi64_si128(in1213));
    t12 = _mm512_add_epi64(addv12, x_12);
    t13 = _mm512_add_epi64(addv13, x_13);
    x_12 = _mm512_unpacklo_epi32(t12, t13);
    x_13 = _mm512_unpackhi_epi32(t12, t13);
    t12 = _mm512_unpacklo_epi32(x_12, x_13);
    t13 = _mm512_unpackhi_epi32(x_12, x_13);
    x_12 = _mm512_permutexvar_epi64(permute, t12);
    x_13 = _mm512_permutexvar_epi64(permute, t13);

    orig12 = x_12;
    orig13 = x_13;

    in1213 += todov;
    
    x[12] = in1213 & 0xFFFFFFFF;
    x[13] = (in1213>>32)&0xFFFFFFFF;

    for (i = 0 ; i < ROUNDS ; i+=2) {
      VEC16_ROUND( 0, 4, 8,12, 1, 5, 9,13, 2, 6,10,14, 3, 7,11,15);
      VEC16_ROUND( 0, 5,10,15, 1, 6,11,12, 2, 7, 8,13, 3, 4, 9,14);
    }

#define ALLSUMS						\
    {							\
	    x_0 = _mm512_add_epi32(x_0, orig0);		\
	    x_1 = _mm512_add_epi32(x_1, orig1);		\
	    x_2 = _mm512_add_epi32(x_2, orig2);		\
	    x_3 = _mm512_add_epi32(x_3, orig3);		\
	    x_4 = _mm512_add_epi32(x_4, orig4);		\
	    x_5 = _mm512_add_epi32(x_5, orig5);		\
	    x_6 = _mm512_add_epi32(x_6, orig6);		\
	    x_7 = _mm512_add_epi32(x_7, orig7);		\
	    x_8 = _mm512_add_epi32(x_8, orig8);		\
	    x_9 = _mm512_add_epi32(x_9, orig9);		\
	    x_10 = _mm512_add_epi32(x_10, orig10);	\
	    x_11 = _mm512_add_epi32(x_11, orig11);	\
	    x_12 = _mm512_add_epi32(x_12, orig12);	\
	    x_13 = _mm512_add_epi32(x_13, orig13);	\
	    x_14 = _mm512_add_epi32(x_14, orig14);	\
	    x_15 = _mm512_add_epi32(x_15, orig15);	\
    }

#define ALLTRANS						\
	{						\
		__m512i t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15; \
		t0 = _mm512_unpacklo_epi32(x_0,x_1);			\
		t1 = _mm512_unpackhi_epi32(x_0,x_1);			\
		t2 = _mm512_unpacklo_epi32(x_2,x_3);			\
		t3 = _mm512_unpackhi_epi32(x_2,x_3);			\
		t4 = _mm512_unpacklo_epi32(x_4,x_5);			\
		t5 = _mm512_unpackhi_epi32(x_4,x_5);			\
		t6 = _mm512_unpacklo_epi32(x_6,x_7);			\
		t7 = _mm512_unpackhi_epi32(x_6,x_7);			\
		t8 = _mm512_unpacklo_epi32(x_8,x_9);			\
		t9 = _mm512_unpackhi_epi32(x_8,x_9);			\
		t10 = _mm512_unpacklo_epi32(x_10,x_11);			\
		t11 = _mm512_unpackhi_epi32(x_10,x_11);			\
		t12 = _mm512_unpacklo_epi32(x_12,x_13);			\
		t13 = _mm512_unpackhi_epi32(x_12,x_13);			\
		t14 = _mm512_unpacklo_epi32(x_14,x_15);			\
		t15 = _mm512_unpackhi_epi32(x_14,x_15);			\
									\
		x_0 = _mm512_unpacklo_epi64(t0,t2);			\
		x_1 = _mm512_unpackhi_epi64(t0,t2);			\
		x_2 = _mm512_unpacklo_epi64(t1,t3);			\
		x_3 = _mm512_unpackhi_epi64(t1,t3);			\
		x_4 = _mm512_unpacklo_epi64(t4,t6);			\
		x_5 = _mm512_unpackhi_epi64(t4,t6);			\
		x_6 = _mm512_unpacklo_epi64(t5,t7);			\
		x_7 = _mm512_unpackhi_epi64(t5,t7);			\
		x_8 = _mm512_unpacklo_epi64(t8,t10);			\
		x_9 = _mm512_unpackhi_epi64(t8,t10);			\
		x_10 = _mm512_unpacklo_epi64(t9,t11);			\
		x_11 = _mm512_unpackhi_epi64(t9,t11);			\
		x_12 = _mm512_unpacklo_epi64(t12,t14);			\
		x_13 = _mm512_unpackhi_epi64(t12,t14);			\
		x_14 = _mm512_unpacklo_epi64(t13,t15);			\
		x_15 = _mm512_unpackhi_epi64(t13,t15);			\
									\
		t0 = _mm512_shuffle_i32x4(x_0, x_4, 0x88);		\
		t1 = _mm512_shuffle_i32x4(x_1, x_5, 0x88);		\
		t2 = _mm512_shuffle_i32x4(x_2, x_6, 0x88);		\
		t3 = _mm512_shuffle_i32x4(x_3, x_7, 0x88);		\
		t4 = _mm512_shuffle_i32x4(x_0, x_4, 0xdd);		\
		t5 = _mm512_shuffle_i32x4(x_1, x_5, 0xdd);		\
		t6 = _mm512_shuffle_i32x4(x_2, x_6, 0xdd);		\
		t7 = _mm512_shuffle_i32x4(x_3, x_7, 0xdd);		\
		t8 = _mm512_shuffle_i32x4(x_8, x_12, 0x88);		\
		t9 = _mm512_shuffle_i32x4(x_9, x_13, 0x88);		\
		t10 = _mm512_shuffle_i32x4(x_10, x_14, 0x88);		\
		t11 = _mm512_shuffle_i32x4(x_11, x_15, 0x88);		\
		t12 = _mm512_shuffle_i32x4(x_8, x_12, 0xdd);		\
		t13 = _mm512_shuffle_i32x4(x_9, x_13, 0xdd);		\
		t14 = _mm512_shuffle_i32x4(x_10, x_14, 0xdd);		\
		t15 = _mm512_shuffle_i32x4(x_11, x_15, 0xdd);		\
									\
		x_0 = _mm512_shuffle_i32x4(t0, t8, 0x88);		\
		x_1 = _mm512_shuffle_i32x4(t1, t9, 0x88);		\
		x_2 = _mm512_shuffle_i32x4(t2, t10, 0x88);		\
		x_3 = _mm512_shuffle_i32x4(t3, t11, 0x88);		\
		x_4 = _mm512_shuffle_i32x4(t4, t12, 0x88);		\
		x_5 = _mm512_shuffle_i32x4(t5, t13, 0x88);		\
		x_6 = _mm512_shuffle_i32x4(t6, t14, 0x88);		\
		x_7 = _mm512_shuffle_i32x4(t7, t15, 0x88);		\
		x_8 = _mm512_shuffle_i32x4(t0, t8, 0xdd);		\
		x_9 = _mm512_shuffle_i32x4(t1, t9, 0xdd);		\
		x_10 = _mm512_shuffle_i32x4(t2, t10, 0xdd);		\
		x_11 = _mm512_shuffle_i32x4(t3, t11, 0xdd);		\
		x_12 = _mm512_shuffle_i32x4(t4, t12, 0xdd);		\
		x_13 = _mm512_shuffle_i32x4(t5, t13, 0xdd);		\
		x_14 = _mm512_shuffle_i32x4(t6, t14, 0xdd);		\
		x_15 = _mm512_shuffle_i32x4(t7, t15, 0xdd);		\
	}
    
#define ALLXORSTORE							\
    {									\
	    switch (todov) {						\
	    case 16: { x_15 = _mm512_xor_si512(x_15, _mm512_loadu_si512((const long long*)(m+64*15))); _mm512_storeu_si512((long long*)(out+64*15), x_15); } \
	    case 15: { x_14 = _mm512_xor_si512(x_14, _mm512_loadu_si512((const long long*)(m+64*14))); _mm512_storeu_si512((long long*)(out+64*14), x_14); } \
	    case 14: { x_13 = _mm512_xor_si512(x_13, _mm512_loadu_si512((const long long*)(m+64*13))); _mm512_storeu_si512((long long*)(out+64*13), x_13); } \
	    case 13: { x_12 = _mm512_xor_si512(x_12, _mm512_loadu_si512((const long long*)(m+64*12))); _mm512_storeu_si512((long long*)(out+64*12), x_12); } \
	    case 12: { x_11 = _mm512_xor_si512(x_11, _mm512_loadu_si512((const long long*)(m+64*11))); _mm512_storeu_si512((long long*)(out+64*11), x_11); } \
	    case 11: { x_10 = _mm512_xor_si512(x_10, _mm512_loadu_si512((const long long*)(m+64*10))); _mm512_storeu_si512((long long*)(out+64*10), x_10); } \
	    case 10: { x_9 = _mm512_xor_si512(x_9, _mm512_loadu_si512((const long long*)(m+64*9))); _mm512_storeu_si512((long long*)(out+64*9), x_9); } \
	    case 9: { x_8 = _mm512_xor_si512(x_8, _mm512_loadu_si512((const long long*)(m+64*8))); _mm512_storeu_si512((long long*)(out+64*8), x_8); } \
	    case 8: { x_7 = _mm512_xor_si512(x_7, _mm512_loadu_si512((const long long*)(m+64*7))); _mm512_storeu_si512((long long*)(out+64*7), x_7); } \
	    case 7: { x_6 = _mm512_xor_si512(x_6, _mm512_loadu_si512((const long long*)(m+64*6))); _mm512_storeu_si512((long long*)(out+64*6), x_6); } \
	    case 6: { x_5 = _mm512_xor_si512(x_5, _mm512_loadu_si512((const long long*)(m+64*5))); _mm512_storeu_si512((long long*)(out+64*5), x_5); } \
	    case 5: { x_4 = _mm512_xor_si512(x_4, _mm512_loadu_si512((const long long*)(m+64*4))); _mm512_storeu_si512((long long*)(out+64*4), x_4); } \
	    case 4: { x_3 = _mm512_xor_si512(x_3, _mm512_loadu_si512((const long long*)(m+64*3))); _mm512_storeu_si512((long long*)(out+64*3), x_3); } \
	    case 3: { x_2 = _mm512_xor_si512(x_2, _mm512_loadu_si512((const long long*)(m+64*2))); _mm512_storeu_si512((long long*)(out+64*2), x_2); } \
	    case 2: { x_1 = _mm512_xor_si512(x_1, _mm512_loadu_si512((const long long*)(m+64*1))); _mm512_storeu_si512((long long*)(out+64*1), x_1); } \
	    case 1: { x_0 = _mm512_xor_si512(x_0, _mm512_loadu_si512((const long long*)(m+64*0))); _mm512_storeu_si512((long long*)(out+64*0), x_0); } \
	    }								\
    }

#define DOALL				\
    {					\
	  ALLSUMS			\
	  ALLTRANS			\
	  ALLXORSTORE			\
    }

    DOALL

#undef ALLSUMS
#undef ALLTRANS
#undef ALLXORSTORE
#undef DOALL

    bytes -= todo;
    out += todo;
    m += todo;
  }
 }
#undef VEC16_ROT
#undef VEC16_LINE1
#undef VEC16_LINE2
#undef VEC16_LINE3
#undef VEC16_LINE4
#undef VEC16_4L1
#undef VEC16_4L2
#undef VEC16_4L3
#undef VEC16_4L4
#undef VEC16_ROUND
#undef VEC16_ROUND_SEQ
#undef VEC16_ROUND_INTER
