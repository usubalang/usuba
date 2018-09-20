/*
 * Serpent Cipher 8-way parallel algorithm (x86_64/SSE2)
 *
 * Copyright (C) 2011-2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 */

#ifdef __x86_64

.file "serpent_sse2.S"
.text

#define CTX %rdi

/**********************************************************************
  8-way SSE2 serpent (x86_64, xmm0-xmm15 available)
 **********************************************************************/
#define RA1 %xmm0
#define RB1 %xmm1
#define RC1 %xmm2
#define RD1 %xmm3
#define RE1 %xmm4

#define RA2 %xmm5
#define RB2 %xmm6
#define RC2 %xmm7
#define RD2 %xmm8
#define RE2 %xmm9

#define RNOT %xmm10

#define RK0 %xmm11
#define RK1 %xmm12
#define RK2 %xmm13
#define RK3 %xmm14

#define S0_1(x0,x1,x2,x3,x4) \
	movdqa x3,		x4; \
	por x0,			x3; \
	pxor x4,		x0; \
	pxor x2,		x4; \
	pxor RNOT,		x4; \
	pxor x1,		x3; \
	pand x0,		x1; \
	pxor x4,		x1; \
	pxor x0,		x2;
#define S0_2(x0,x1,x2,x3,x4) \
	pxor x3,		x0; \
	por x0,			x4; \
	pxor x2,		x0; \
	pand x1,		x2; \
	pxor x2,		x3; \
	pxor RNOT,		x1; \
	pxor x4,		x2; \
	pxor x2,		x1;

#define S1_1(x0,x1,x2,x3,x4) \
	movdqa x1,		x4; \
	pxor x0,		x1; \
	pxor x3,		x0; \
	pxor RNOT,		x3; \
	pand x1,		x4; \
	por x1,			x0; \
	pxor x2,		x3; \
	pxor x3,		x0; \
	pxor x3,		x1;
#define S1_2(x0,x1,x2,x3,x4) \
	pxor x4,		x3; \
	por x4,			x1; \
	pxor x2,		x4; \
	pand x0,		x2; \
	pxor x1,		x2; \
	por x0,			x1; \
	pxor RNOT,		x0; \
	pxor x2,		x0; \
	pxor x1,		x4;

#define S2_1(x0,x1,x2,x3,x4) \
	pxor RNOT,		x3; \
	pxor x0,		x1; \
	movdqa x0,		x4; \
	pand x2,		x0; \
	pxor x3,		x0; \
	por x4,			x3; \
	pxor x1,		x2; \
	pxor x1,		x3; \
	pand x0,		x1;
#define S2_2(x0,x1,x2,x3,x4) \
	pxor x2,		x0; \
	pand x3,		x2; \
	por x1,			x3; \
	pxor RNOT,		x0; \
	pxor x0,		x3; \
	pxor x0,		x4; \
	pxor x2,		x0; \
	por x2,			x1;

#define S3_1(x0,x1,x2,x3,x4) \
	movdqa x1,		x4; \
	pxor x3,		x1; \
	por x0,			x3; \
	pand x0,		x4; \
	pxor x2,		x0; \
	pxor x1,		x2; \
	pand x3,		x1; \
	pxor x3,		x2; \
	por x4,			x0; \
	pxor x3,		x4;
#define S3_2(x0,x1,x2,x3,x4) \
	pxor x0,		x1; \
	pand x3,		x0; \
	pand x4,		x3; \
	pxor x2,		x3; \
	por x1,			x4; \
	pand x1,		x2; \
	pxor x3,		x4; \
	pxor x3,		x0; \
	pxor x2,		x3;

#define S4_1(x0,x1,x2,x3,x4) \
	movdqa x3,		x4; \
	pand x0,		x3; \
	pxor x4,		x0; \
	pxor x2,		x3; \
	por x4,			x2; \
	pxor x1,		x0; \
	pxor x3,		x4; \
	por x0,			x2; \
	pxor x1,		x2;
#define S4_2(x0,x1,x2,x3,x4) \
	pand x0,		x1; \
	pxor x4,		x1; \
	pand x2,		x4; \
	pxor x3,		x2; \
	pxor x0,		x4; \
	por x1,			x3; \
	pxor RNOT,		x1; \
	pxor x0,		x3;

#define S5_1(x0,x1,x2,x3,x4) \
	movdqa x1,		x4; \
	por x0,			x1; \
	pxor x1,		x2; \
	pxor RNOT,		x3; \
	pxor x0,		x4; \
	pxor x2,		x0; \
	pand x4,		x1; \
	por x3,			x4; \
	pxor x0,		x4;
#define S5_2(x0,x1,x2,x3,x4) \
	pand x3,		x0; \
	pxor x3,		x1; \
	pxor x2,		x3; \
	pxor x1,		x0; \
	pand x4,		x2; \
	pxor x2,		x1; \
	pand x0,		x2; \
	pxor x2,		x3;

#define S6_1(x0,x1,x2,x3,x4) \
	movdqa x1,		x4; \
	pxor x0,		x3; \
	pxor x2,		x1; \
	pxor x0,		x2; \
	pand x3,		x0; \
	por x3,			x1; \
	pxor RNOT,		x4; \
	pxor x1,		x0; \
	pxor x2,		x1;
#define S6_2(x0,x1,x2,x3,x4) \
	pxor x4,		x3; \
	pxor x0,		x4; \
	pand x0,		x2; \
	pxor x1,		x4; \
	pxor x3,		x2; \
	pand x1,		x3; \
	pxor x0,		x3; \
	pxor x2,		x1;

#define S7_1(x0,x1,x2,x3,x4) \
	pxor RNOT,		x1; \
	movdqa x1,		x4; \
	pxor RNOT,		x0; \
	pand x2,		x1; \
	pxor x3,		x1; \
	por x4,			x3; \
	pxor x2,		x4; \
	pxor x3,		x2; \
	pxor x0,		x3; \
	por x1,			x0;
#define S7_2(x0,x1,x2,x3,x4) \
	pand x0,		x2; \
	pxor x4,		x0; \
	pxor x3,		x4; \
	pand x0,		x3; \
	pxor x1,		x4; \
	pxor x4,		x2; \
	pxor x1,		x3; \
	por x0,			x4; \
	pxor x1,		x4;

#define SI0_1(x0,x1,x2,x3,x4) \
	movdqa x3,		x4; \
	pxor x0,		x1; \
	por x1,			x3; \
	pxor x1,		x4; \
	pxor RNOT,		x0; \
	pxor x3,		x2; \
	pxor x0,		x3; \
	pand x1,		x0; \
	pxor x2,		x0;
#define SI0_2(x0,x1,x2,x3,x4) \
	pand x3,		x2; \
	pxor x4,		x3; \
	pxor x3,		x2; \
	pxor x3,		x1; \
	pand x0,		x3; \
	pxor x0,		x1; \
	pxor x2,		x0; \
	pxor x3,		x4;

#define SI1_1(x0,x1,x2,x3,x4) \
	pxor x3,		x1; \
	movdqa x0,		x4; \
	pxor x2,		x0; \
	pxor RNOT,		x2; \
	por x1,			x4; \
	pxor x3,		x4; \
	pand x1,		x3; \
	pxor x2,		x1; \
	pand x4,		x2;
#define SI1_2(x0,x1,x2,x3,x4) \
	pxor x1,		x4; \
	por x3,			x1; \
	pxor x0,		x3; \
	pxor x0,		x2; \
	por x4,			x0; \
	pxor x4,		x2; \
	pxor x0,		x1; \
	pxor x1,		x4;

#define SI2_1(x0,x1,x2,x3,x4) \
	pxor x1,		x2; \
	movdqa x3,		x4; \
	pxor RNOT,		x3; \
	por x2,			x3; \
	pxor x4,		x2; \
	pxor x0,		x4; \
	pxor x1,		x3; \
	por x2,			x1; \
	pxor x0,		x2;
#define SI2_2(x0,x1,x2,x3,x4) \
	pxor x4,		x1; \
	por x3,			x4; \
	pxor x3,		x2; \
	pxor x2,		x4; \
	pand x1,		x2; \
	pxor x3,		x2; \
	pxor x4,		x3; \
	pxor x0,		x4;

#define SI3_1(x0,x1,x2,x3,x4) \
	pxor x1,		x2; \
	movdqa x1,		x4; \
	pand x2,		x1; \
	pxor x0,		x1; \
	por x4,			x0; \
	pxor x3,		x4; \
	pxor x3,		x0; \
	por x1,			x3; \
	pxor x2,		x1;
#define SI3_2(x0,x1,x2,x3,x4) \
	pxor x3,		x1; \
	pxor x2,		x0; \
	pxor x3,		x2; \
	pand x1,		x3; \
	pxor x0,		x1; \
	pand x2,		x0; \
	pxor x3,		x4; \
	pxor x0,		x3; \
	pxor x1,		x0;

#define SI4_1(x0,x1,x2,x3,x4) \
	pxor x3,		x2; \
	movdqa x0,		x4; \
	pand x1,		x0; \
	pxor x2,		x0; \
	por x3,			x2; \
	pxor RNOT,		x4; \
	pxor x0,		x1; \
	pxor x2,		x0; \
	pand x4,		x2;
#define SI4_2(x0,x1,x2,x3,x4) \
	pxor x0,		x2; \
	por x4,			x0; \
	pxor x3,		x0; \
	pand x2,		x3; \
	pxor x3,		x4; \
	pxor x1,		x3; \
	pand x0,		x1; \
	pxor x1,		x4; \
	pxor x3,		x0;

#define SI5_1(x0,x1,x2,x3,x4) \
	movdqa x1,		x4; \
	por x2,			x1; \
	pxor x4,		x2; \
	pxor x3,		x1; \
	pand x4,		x3; \
	pxor x3,		x2; \
	por x0,			x3; \
	pxor RNOT,		x0; \
	pxor x2,		x3; \
	por x0,			x2;
#define SI5_2(x0,x1,x2,x3,x4) \
	pxor x1,		x4; \
	pxor x4,		x2; \
	pand x0,		x4; \
	pxor x1,		x0; \
	pxor x3,		x1; \
	pand x2,		x0; \
	pxor x3,		x2; \
	pxor x2,		x0; \
	pxor x4,		x2; \
	pxor x3,		x4;

#define SI6_1(x0,x1,x2,x3,x4) \
	pxor x2,		x0; \
	movdqa x0,		x4; \
	pand x3,		x0; \
	pxor x3,		x2; \
	pxor x2,		x0; \
	pxor x1,		x3; \
	por x4,			x2; \
	pxor x3,		x2; \
	pand x0,		x3;
#define SI6_2(x0,x1,x2,x3,x4) \
	pxor RNOT,		x0; \
	pxor x1,		x3; \
	pand x2,		x1; \
	pxor x0,		x4; \
	pxor x4,		x3; \
	pxor x2,		x4; \
	pxor x1,		x0; \
	pxor x0,		x2;

#define SI7_1(x0,x1,x2,x3,x4) \
	movdqa x3,		x4; \
	pand x0,		x3; \
	pxor x2,		x0; \
	por x4,			x2; \
	pxor x1,		x4; \
	pxor RNOT,		x4; \
	por x3,			x1; \
	pxor x0,		x4; \
	pandn x2,		x0; \
	pxor x1,		x0;
#define SI7_2(x0,x1,x2,x3,x4) \
	pand x2,		x1; \
	pxor x2,		x3; \
	pxor x3,		x4; \
	pand x3,		x2; \
	por x0,			x3; \
	pxor x4,		x1; \
	pxor x4,		x3; \
	pand x0,		x4; \
	pxor x2,		x4;

#define get_key(i,j,t) \
	movd (4*(i)+(j))*4(CTX), t; \
	pshufd $0, t, t;

#define K2(x0,x1,x2,x3,x4,i) \
	get_key(i,0,RK0); \
	get_key(i,1,RK1); \
	get_key(i,2,RK2); \
	get_key(i,3,RK3); \
	pxor RK0,		x0 ## 1; \
	pxor RK1,		x1 ## 1; \
	pxor RK2,		x2 ## 1; \
	pxor RK3,		x3 ## 1;

#define LK2(x0,x1,x2,x3,x4,i) \
	movdqa x0 ## 1,		x4 ## 1; \
	pslld $13,		x0 ## 1; \
	psrld $(32 - 13),	x4 ## 1; \
	por x4 ## 1,		x0 ## 1; \
	pxor x0 ## 1,		x1 ## 1; \
	movdqa x2 ## 1,		x4 ## 1; \
	pslld $3,		x2 ## 1; \
	psrld $(32 - 3),	x4 ## 1; \
	por x4 ## 1,		x2 ## 1; \
	pxor x2 ## 1,		x1 ## 1; \
	movdqa x1 ## 1,		x4 ## 1; \
	pslld $1,		x1 ## 1; \
	psrld $(32 - 1),	x4 ## 1; \
	por x4 ## 1,		x1 ## 1; \
	movdqa x0 ## 1,		x4 ## 1; \
	pslld $3,		x4 ## 1; \
	pxor x2 ## 1,		x3 ## 1; \
	pxor x4 ## 1,		x3 ## 1; \
	movdqa x3 ## 1,		x4 ## 1; \
	get_key(i,1,RK1); \
	pslld $7,		x3 ## 1; \
	psrld $(32 - 7),	x4 ## 1; \
	por x4 ## 1,		x3 ## 1; \
	movdqa x1 ## 1,		x4 ## 1; \
		get_key(i,3,RK3); \
	pslld $7,		x4 ## 1; \
	pxor x1 ## 1,		x0 ## 1; \
	pxor x3 ## 1,		x0 ## 1; \
	pxor x3 ## 1,		x2 ## 1; \
	pxor x4 ## 1,		x2 ## 1; \
	get_key(i,0,RK0); \
	    get_key(i,2,RK2); \
	pxor RK1,		x1 ## 1; \
	pxor RK3,		x3 ## 1; \
	movdqa x0 ## 1,		x4 ## 1; \
	pslld $5,		x0 ## 1; \
	psrld $(32 - 5),	x4 ## 1; \
	por x4 ## 1,		x0 ## 1; \
	movdqa x2 ## 1,		x4 ## 1; \
	pslld $22,		x2 ## 1; \
	psrld $(32 - 22),	x4 ## 1; \
	por x4 ## 1,		x2 ## 1; \
	pxor RK0,		x0 ## 1; \
	pxor RK2,		x2 ## 1;

#define S(SBOX,x0,x1,x2,x3,x4) \
	SBOX ## _1(x0 ## 1, x1 ## 1, x2 ## 1, x3 ## 1, x4 ## 1); \
	SBOX ## _2(x0 ## 1, x1 ## 1, x2 ## 1, x3 ## 1, x4 ## 1);

#define transpose_4x4(x0,x1,x2,x3,t0,t1,t2) \
	movdqa x0,		t2; \
	punpckldq x1,		x0; \
	punpckhdq x1,		t2; \
	movdqa x2,		t1; \
	punpckhdq x3,		x2; \
	punpckldq x3,		t1; \
	movdqa x0,		x1; \
	punpcklqdq t1,		x0; \
	punpckhqdq t1,		x1; \
	movdqa t2,		x3; \
	punpcklqdq x2,		t2; \
	punpckhqdq x2,		x3; \
	movdqa t2,		x2;

#define read_blocks(in,x0,x1,x2,x3,t0,t1,t2) \
	movdqu (0*4*4)(in),	x0; \
	movdqu (1*4*4)(in),	x1; \
	movdqu (2*4*4)(in),	x2; \
	movdqu (3*4*4)(in),	x3; \
	\
	transpose_4x4(x0,x1,x2,x3,t0,t1,t2)

#define write_blocks(out,x0,x1,x2,x3,t0,t1,t2) \
	transpose_4x4(x0,x1,x2,x3,t0,t1,t2) \
	\
	movdqu x0,		(0*4*4)(out); \
	movdqu x1,		(1*4*4)(out); \
	movdqu x2,		(2*4*4)(out); \
	movdqu x3,		(3*4*4)(out);

.align 8
.global serpent_enc_blk8
.type   serpent_enc_blk8,@function;

serpent_enc_blk8:
	/* input:
	 *	%rdi: ctx, CTX
	 *	%rsi: dst
	 *	%rdx: src
	 */

	pcmpeqd RNOT, RNOT;
    
	leaq (4*4)(%rdx), %rax;
	read_blocks(%rdx,RA1,RB1,RC1,RD1,RK0,RK1,RK2);

				 K2(RA,RB,RC,RD,RE,0);
	S(S0,RA,RB,RC,RD,RE);	LK2(RC,RB,RD,RA,RE,1);
	S(S1,RC,RB,RD,RA,RE);	LK2(RE,RD,RA,RC,RB,2);
	S(S2,RE,RD,RA,RC,RB);	LK2(RB,RD,RE,RC,RA,3);
	S(S3,RB,RD,RE,RC,RA);	LK2(RC,RA,RD,RB,RE,4);
	S(S4,RC,RA,RD,RB,RE);	LK2(RA,RD,RB,RE,RC,5);
	S(S5,RA,RD,RB,RE,RC);	LK2(RC,RA,RD,RE,RB,6);
	S(S6,RC,RA,RD,RE,RB);	LK2(RD,RB,RA,RE,RC,7);
	S(S7,RD,RB,RA,RE,RC);	LK2(RC,RA,RE,RD,RB,8);
	S(S0,RC,RA,RE,RD,RB);	LK2(RE,RA,RD,RC,RB,9);
	S(S1,RE,RA,RD,RC,RB);	LK2(RB,RD,RC,RE,RA,10);
	S(S2,RB,RD,RC,RE,RA);	LK2(RA,RD,RB,RE,RC,11);
	S(S3,RA,RD,RB,RE,RC);	LK2(RE,RC,RD,RA,RB,12);
	S(S4,RE,RC,RD,RA,RB);	LK2(RC,RD,RA,RB,RE,13);
	S(S5,RC,RD,RA,RB,RE);	LK2(RE,RC,RD,RB,RA,14);
	S(S6,RE,RC,RD,RB,RA);	LK2(RD,RA,RC,RB,RE,15);
	S(S7,RD,RA,RC,RB,RE);	LK2(RE,RC,RB,RD,RA,16);
	S(S0,RE,RC,RB,RD,RA);	LK2(RB,RC,RD,RE,RA,17);
	S(S1,RB,RC,RD,RE,RA);	LK2(RA,RD,RE,RB,RC,18);
	S(S2,RA,RD,RE,RB,RC);	LK2(RC,RD,RA,RB,RE,19);
	S(S3,RC,RD,RA,RB,RE);	LK2(RB,RE,RD,RC,RA,20);
	S(S4,RB,RE,RD,RC,RA);	LK2(RE,RD,RC,RA,RB,21);
	S(S5,RE,RD,RC,RA,RB);	LK2(RB,RE,RD,RA,RC,22);
	S(S6,RB,RE,RD,RA,RC);	LK2(RD,RC,RE,RA,RB,23);
	S(S7,RD,RC,RE,RA,RB);	LK2(RB,RE,RA,RD,RC,24);
	S(S0,RB,RE,RA,RD,RC);	LK2(RA,RE,RD,RB,RC,25);
	S(S1,RA,RE,RD,RB,RC);	LK2(RC,RD,RB,RA,RE,26);
	S(S2,RC,RD,RB,RA,RE);	LK2(RE,RD,RC,RA,RB,27);
	S(S3,RE,RD,RC,RA,RB);	LK2(RA,RB,RD,RE,RC,28);
	S(S4,RA,RB,RD,RE,RC);	LK2(RB,RD,RE,RC,RA,29);
	S(S5,RB,RD,RE,RC,RA);	LK2(RA,RB,RD,RC,RE,30);
	S(S6,RA,RB,RD,RC,RE);	LK2(RD,RE,RB,RC,RA,31);
	S(S7,RD,RE,RB,RC,RA);	 K2(RA,RB,RC,RD,RE,32);
    
	leaq (4*4)(%rsi), %rax;
	write_blocks(%rsi,RA1,RB1,RC1,RD1,RK0,RK1,RK2);

	ret;

#endif
