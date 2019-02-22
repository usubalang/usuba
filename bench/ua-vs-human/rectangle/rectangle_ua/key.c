/* 
   Part of this code was sent to me by Wentao Zhang. 
   (I'm guessing he or one of his team wrote it)
   Original header said: 本文件包含RECTANGLE密码算法的密钥编排相关的函数定义。
   

 */

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


#define ROUND_NUMBER       25
#define BLOCK_WORD_NUMBER  4



uint32_t RC[ROUND_NUMBER] = 
  {
    0x01, 0x02, 0x04, 0x09, 0x12, 0x05, 0x0b, 0x16,
    0x0c, 0x19, 0x13, 0x07, 0x0f, 0x1f, 0x1e, 0x1c,
    0x18, 0x11, 0x03, 0x06, 0x0d, 0x1b, 0x17, 0x0e, 0x1d
  };


#define key_out(w0, w1, w2, w3, n)                              \
  {                                                             \
	subKey[n*BLOCK_WORD_NUMBER + 0] = (uint16_t)(w0 & 0xffff);  \
	subKey[n*BLOCK_WORD_NUMBER + 1] = (uint16_t)(w1 & 0xffff);  \
	subKey[n*BLOCK_WORD_NUMBER + 2] = (uint16_t)(w2 & 0xffff);  \
	subKey[n*BLOCK_WORD_NUMBER + 3] = (uint16_t)(w3 & 0xffff);  \
  }

#define key80_in(w0, w1, w2, w3, w4, x2)        \
  {                                             \
    w0 = (((uint16_t*)x2)[0]);                  \
	w1 = (((uint16_t*)x2)[1]);                  \
	w2 = (((uint16_t*)x2)[2]);                  \
	w3 = (((uint16_t*)x2)[3]);                  \
	w4 = (((uint16_t*)x2)[4]);                  \
  }

#define key80_sbox(w0, w1, w2, w3)                      \
  {                                                     \
	t1 = ~w1; t2 = w0 & t1; t3 = w2 ^ w3; e = t2 ^ t3;  \
	t5 = w3 | t1; t6 = w0 ^ t5; f = w2 ^ t6;            \
	t8 = w1 ^ w2; t9 = t3 & t6; h = t8 ^ t9;            \
	t11 = e | t8; g = t6 ^ t11;                         \
	w0 = (w0 & 0xfff0) | (e & 0x000f);                  \
	w1 = (w1 & 0xfff0) | (f & 0x000f);                  \
	w2 = (w2 & 0xfff0) | (g & 0x000f);                  \
	w3 = (w3 & 0xfff0) | (h & 0x000f);                  \
  }


#define rol16(a,b) ((a << b) | ((a&0xFFFF) >> (16-b)))
#define key80_rol(w0, w1, w2, w3, w4)           \
  {                                             \
   w1 ^= rol16(w0, 8);                          \
   w4 ^= rol16(w3, 12);                         \
   }

#define key80_round(w0, w1, w2, w3, w4, n)      \
  {                                             \
   key_out(w0, w1, w2, w3, n);                  \
   key80_sbox(w0, w1, w2, w3);                  \
   key80_rol(w0, w1, w2, w3, w4);               \
   w1 ^= RC[n];                                 \
   }

#define key80_lround(w0, w1, w2, w3, w4, n)     \
  {                                             \
	key_out(w0, w1, w2, w3, n);                 \
  }

static inline void key80(uint8_t *userKey, uint16_t *subKey)
{
  uint16_t k0, k1, k2, k3, k4;
  uint16_t t1, t2, t3, t5, t6, t8, t9, t11;
  uint16_t e, f, g, h;

  key80_in(k0, k1, k2, k3, k4, userKey);
  key80_round(k0, k1, k2, k3, k4, 0);
  key80_round(k1, k2, k3, k4, k0, 1);
  key80_round(k2, k3, k4, k0, k1, 2);
  key80_round(k3, k4, k0, k1, k2, 3);
  key80_round(k4, k0, k1, k2, k3, 4);
  key80_round(k0, k1, k2, k3, k4, 5);
  key80_round(k1, k2, k3, k4, k0, 6);
  key80_round(k2, k3, k4, k0, k1, 7);
  key80_round(k3, k4, k0, k1, k2, 8);
  key80_round(k4, k0, k1, k2, k3, 9);
  key80_round(k0, k1, k2, k3, k4, 10);
  key80_round(k1, k2, k3, k4, k0, 11);
  key80_round(k2, k3, k4, k0, k1, 12);
  key80_round(k3, k4, k0, k1, k2, 13);
  key80_round(k4, k0, k1, k2, k3, 14);
  key80_round(k0, k1, k2, k3, k4, 15);
  key80_round(k1, k2, k3, k4, k0, 16);
  key80_round(k2, k3, k4, k0, k1, 17);
  key80_round(k3, k4, k0, k1, k2, 18);
  key80_round(k4, k0, k1, k2, k3, 19);
  key80_round(k0, k1, k2, k3, k4, 20);
  key80_round(k1, k2, k3, k4, k0, 21);
  key80_round(k2, k3, k4, k0, k1, 22);
  key80_round(k3, k4, k0, k1, k2, 23);
  key80_round(k4, k0, k1, k2, k3, 24);
  key80_lround(k0, k1, k2, k3, k4, 25);
}


void Key_Schedule(unsigned char *Seedkey, 
                  uint16_t *Subkey)
{
  key80(Seedkey, Subkey);
}
