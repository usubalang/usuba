

#define OutBasisChange(b7, b1, b4, b2, b6, b5, b0, b3, \
		       t0, t1, t2, t3, t4, t5, t6, t7) \
	vpxor    b7, b0, t0;    \
	vpxor    b1, b6, t1;    \
	vpxor    b4, t0, t2;    \
	vpxor    b6, b0, t4;    \
	vpxor    b0, t1, b0;    \
	\
	vpxor    b5, t1, b1;    \
	vpxor    b5, b2, b7;    \
	vpxor    b2, b3, b6;    \
	vpxor    t2, b7, b2;    \
	vpxor    b3, b7, b4;    \
	\
	vpxor    t4, b4, b3;

#define InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7, t5) \
	vpxor    b6, b5, b5;    \
	vpxor    b1, b2, b2;    \
	vpxor    b0, b5, t5;    \
	vpxor    b2, b6, b6;    \
	vpxor    b0, b3, b3;    \
	\
	vpxor    b3, b6, b6;    \
	vpxor    b7, b3, b3;    \
	vpxor    t5, b7, b7;    \
	vpxor    b4, b3, b3;    \
	vpxor    t5, b4, b4;    \
	\
	vpxor    b1, b3, b3;    \
	vpxor    b7, b2, b2;    \
	vpxor    t5, b1, b1;

#define Mul_GF4_N(x0, x1, y0, y1, t0) \
	vpxor    y0, y1, t0;    \
	vpand    x0, t0, t0;    \
	vpxor    x1, x0, x0;    \
	vpand    y1, x0, x0;    \
	vpand    y0, x1, x1;    \
	vpxor    x0, x1, x1;    \
	vpxor    t0, x0, x0;

#define Mul_GF4(x0, x1, i0, i1, y0, y1, t0) \
	vpxor    y0, y1, t0;    \
	vpand    i0, t0, t0;    \
	vpxor    i0, i1, x0;    \
	vpand    y1, x0, x0;    \
	vpand    i1, y0, x1;    \
	vpxor    x1, x0, x0;    \
	vpxor    t0, x1, x1;

#define Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, \
		   y0, y1, y2, y3, t0, t1, t2, t3) \
	Mul_GF4(t0, t1, x0, x1, y0, y1, t2);\
	vpxor    x2, x0, x0;    \
	vpxor    x3, x1, x1;    \
	vpxor    y2, y0, y0;    \
	vpxor    y3, y1, y1;    \
	Mul_GF4_N(x0, x1, y0, y1, t3);\
	Mul_GF4(x2, x3, x2, x3, y2, y3, t2);\
	vpxor    x0, x2, x2;    \
	vpxor    t0, x0, x0;    \
	vpxor    x1, x3, x3;    \
	vpxor    t1, x1, x1;    \
	vpxor    x4, x6, t0;    \
	vpxor    x5, x7, t1;    \
	Mul_GF4_N(t0, t1, y0, y1, t3);\
	Mul_GF4(x6, x7, x6, x7, y2, y3, t2);\
	vpxor    y2, y0, y0;    \
	vpxor    y3, y1, y1;    \
	Mul_GF4(x4, x5, x4, x5, y0, y1, t3);\
	vpxor    t0, x4, x4;    \
	vpxor    t0, x6, x6;    \
	vpxor    t1, x5, x5;    \
	vpxor    t1, x7, x7;

#define Inv_GF256(x0,  x1, x2, x3, x4, x5, x6, x7, \
		  t0, t1, t2, t3, s0, s1, s2, s3) \
	vpxor    x4, x6, t3;    \
	vpxor    x5, x7, t2;    \
	vpxor    x1, x3, t1;    \
	vpxor    x7, x6, s1;    \
	vpxor    x0, x2, s0;    \
	\
	vpxor    t3, t2, s3;    \
	vpand    t2, t1, t0;    \
	vpor     t1, t2, t2;    \
	vpand    t3, s0, s2;    \
	vpor     s0, t3, t3;    \
	vpxor    t1, s0, s0;    \
	vpand    s0, s3, s3;    \
	vpxor    x3, x2, s0;    \
	vpand    s0, s1, s1;    \
	vpxor    s1, t3, t3;    \
	vpxor    s1, t2, t2;    \
	vpxor    x4, x5, s1;    \
	vpxor    x1, x0, s0;    \
	vpor     s1, s0, t1;    \
	vpand    s0, s1, s1;    \
	vpxor    s1, t0, t0;    \
	vpxor    s3, t3, t3;    \
	vpxor    s2, t2, t2;    \
	vpxor    s3, t1, t1;    \
	vpxor    s2, t0, t0;    \
	vpxor    s2, t1, t1;    \
	vpand    x7, x3, s0;    \
	vpand    x6, x2, s1;    \
	vpand    x5, x1, s2;    \
	vpor     x4, x0, s3;    \
	vpxor    s0, t3, t3;    \
	vpxor    s1, t2, t2;    \
	vpxor    s2, t1, t1;    \
	vpxor    s3, t0, t0;    \
	\
	vpxor    t3, t2, s0;    \
	vpand    t1, t3, t3;    \
	vpxor    t0, t3, s2;    \
	vpand    s0, s2, s3;    \
	vpxor    t2, s3, s3;    \
	vpxor    t1, t0, s1;    \
	vpxor    t2, t3, t3;    \
	vpand    t3, s1, s1;    \
	vpxor    t0, s1, s1;    \
	vpxor    s1, t1, t1;    \
	vpxor    s2, s1, t2;    \
	vpand    t0, t2, t2;    \
	vpxor    t2, t1, t1;    \
	vpxor    t2, s2, s2;    \
	vpand    s3, s2, s2;    \
	vpxor    s0, s2, s2;    \
	\
	Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, \
		   s3, s2, s1, t1, s0, t0, t2, t3);


#define _subbytes(b0, b1, b2, b3, b4, b5, b6, b7, \
	t0, t1, t2, t3, s0, s1, s2, s3) \
	InBasisChange(b0, b1, b2, b3, b4, b5, b6, b7, t0); \
	Inv_GF256(b6, t0, b0, b3, b7, b1, b4, b2, b5, t1, t2, t3, s0, s1, s2, s3); \
	OutBasisChange(b7, b1, b4, b2, b6, t0, b0, b3, b5, t1, t2, t3, s0, s1, s2, s3);

.align 8
.global sbox
.type   sbox,@function;

sbox:
	/* input:
	 *	xmm0-7: 8 input/output registers
	*/

	_subbytes(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
		 %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15);
    
    
	ret;
