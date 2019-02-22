/** @file key.cpp
  * @brief 本文件包含RECTANGLE密码算法的密钥编排相关的函数定义。
  */
#include "rectangle.h"

using namespace std;

/** @brief RECTANGLE-80 经过S盒的列的个数*/
#define SBOXN_80 4            

/** @brief RECTANGLE-80 广义Feistel结构中，右边梯子上循环移位参数*/
#define a_80  8
/** @brief RECTANGLE-80 广义Feistel结构中，左边梯子上循环移位参数*/
#define b_80  12              

/** @brief RECTANGLE-128 经过S盒的列的个数*/
#define SBOXN_128 8           

/** @brief RECTANGLE-128 广义Feistel结构中，右边梯子上循环移位参数*/
#define a_128  8 
/** @brief RECTANGLE-128 广义Feistel结构中，左边梯子上循环移位参数*/
#define b_128  16             

/** @brief RECTANGLE-80 经过S盒的列的掩码 */
#define SM_80 (0x000f)
/** @brief RECTANGLE-80 不经过S盒的列的掩码 */
#define WM_80 (0xfff0)		  

/** @brief RECTANGLE-128 经过S盒的列的掩码 */
#define SM_128 (0x000000ff)
/** @brief RECTANGLE-128 不经过S盒的列的掩码 */
#define WM_128 (0xffffff00)   

/** @brief 轮常量数组，这里我们事先用函数 rc() 生成这个数组，通过查表使用轮常量*/
u32 RC[ROUND_NUMBER] = 
{
	0x01,
	0x02,
	0x04,
	0x09,
	0x12,
	0x05,
	0x0b,
	0x16,
	0x0c,
	0x19,
	0x13,
	0x07,
	0x0f,
	0x1f,
	0x1e,
	0x1c,
	0x18,
	0x11,
	0x03,
	0x06,
	0x0d,
	0x1b,
	0x17,
	0x0e,
	0x1d
};

/** @brief 生成轮常量的 LFSR 的初始状态*/
#define RC0 0x1

/** @brief 生成轮常量的 LFSR */
#define rc_round(n)                                                    \
{                                                                      \
	RC[n] = ((RC[n-1]<<1) | (((RC[n-1]>>2)^(RC[n-1]>>4)) & 0x1))&0x1f; \
	}

/** @brief 生成轮常量的函数 */
void rc()
{
#if 0 //生成轮常量的查表，并打印。
	ofstream fout;
	string fn;

	fn = "RC.txt";
	fout.open(fn.c_str());
	fout << endl;

	RC[0] = RC0;
	fout << setw(8) << "i" << setw(8) << "RC[i]" << endl;
	fout << setw(8) << 0 << setw(4) << "0x" << setw(2) << hex << setfill('0') << RC[0] << dec << setfill(' ') << endl;
	for(int i=1; i<RN; i++)
	{
		rc_round(i);
		fout << setw(8) << i << setw(4) << "0x" << setw(2) << hex << setfill('0') << RC[i] << dec << setfill(' ') << endl;
	}
	fout.close();
#endif

#if 1 //生成轮常量的查表，但不打印。
	RC[0] = RC0;
	rc_round(1);	rc_round(2);	rc_round(3);	rc_round(4);	rc_round(5);
	rc_round(6);	rc_round(7);	rc_round(8);	rc_round(9);	rc_round(10);
	rc_round(11);	rc_round(12);	rc_round(13);	rc_round(14);	rc_round(15);
	rc_round(16);	rc_round(17);	rc_round(18);	rc_round(19);	rc_round(20);
	rc_round(21);	rc_round(22);	rc_round(23);	rc_round(24);
#endif
}

/** @brief 轮常量加 */
#define key_rc(w0, n)                                                  \
{					                                                   \
	w0 ^= RC[n];	                                                   \
}

/** @brief 输出轮密钥 */
#define key_out(w0, w1, w2, w3, n)                                     \
{                                                                      \
	subKey[n*BLOCK_WORD_NUMBER + 0] = (u16)(w0 & 0xffff);              \
	subKey[n*BLOCK_WORD_NUMBER + 1] = (u16)(w1 & 0xffff);              \
	subKey[n*BLOCK_WORD_NUMBER + 2] = (u16)(w2 & 0xffff);              \
	subKey[n*BLOCK_WORD_NUMBER + 3] = (u16)(w3 & 0xffff);              \
}

#define word16_in0(x) ((u16*)(x))[0]
#define word16_in1(x) ((u16*)(x))[1]
#define word16_in2(x) ((u16*)(x))[2]
#define word16_in3(x) ((u16*)(x))[3]
#define word16_in4(x) ((u16*)(x))[4]

/** @brief 将80比特主密钥装载到状态寄存器 */
#define key80_in(w0, w1, w2, w3, w4, x2)                               \
{                                                                      \
	w0 = word16_in0(x2);                                               \
	w1 = word16_in1(x2);                                               \
	w2 = word16_in2(x2);                                               \
	w3 = word16_in3(x2);                                               \
	w4 = word16_in4(x2);                                               \
}

/** @brief RECTANGLE-80 的密钥状态的5个分支中，有4个分支的4列经过S盒变换 */
#define key80_sbox(w0, w1, w2, w3)                                     \
{                                                                      \
	t1 = ~w1; t2 = w0 & t1; t3 = w2 ^ w3; e = t2 ^ t3;                 \
	t5 = w3 | t1; t6 = w0 ^ t5; f = w2 ^ t6;                           \
	t8 = w1 ^ w2; t9 = t3 & t6; h = t8 ^ t9;                           \
	t11 = e | t8; g = t6 ^ t11;                                        \
	w0 = (w0 & WM_80) | (e & SM_80);                                   \
	w1 = (w1 & WM_80) | (f & SM_80);                                   \
	w2 = (w2 & WM_80) | (g & SM_80);                                   \
	w3 = (w3 & WM_80) | (h & SM_80);                                   \
}

/** @brief RECTANGLE-80 的密钥编排的一轮5-分支Feistel变换 */
#define key80_rol(w0, w1, w2, w3, w4)                                  \
{                                                                      \
	t0 = rol16(w0, a_80);			                                   \
	t1 = rol16(w3, b_80);			                                   \
	w1 ^= t0;						                                   \
	w4 ^= t1; 					                                       \
}

/** @brief RECTANGLE-80 的密钥编排的一轮*/
#define key80_round(w0, w1, w2, w3, w4, n)                             \
{                                                                      \
	key_out(w0, w1, w2, w3, n);                                        \
	key80_sbox(w0, w1, w2, w3);                                        \
	key80_rol(w0, w1, w2, w3, w4);                                     \
	key_rc(w1, n);                                                     \
}

/** @brief RECTANGLE-80 的最后一轮子密钥*/
#define key80_lround(w0, w1, w2, w3, w4, n)                            \
{                                                                      \
	key_out(w0, w1, w2, w3, n);                                        \
}

/** @brief RECTANGLE-80 的密钥编排*/
inline void key80(u8 *userKey, u16 *subKey)
{
	u16 k0, k1, k2, k3, k4;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;
	u16 e, f, g, h;

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

/** @brief 将变量 @a x 的第 @a n 个32-比特字取出 */
#define word32_in(x, n) (((u32*)(x))[n])

/** @brief 将128比特主密钥装载到状态寄存器 */
#define key128_in(w0, w1, w2, w3, x2)                                  \
{                                                                      \
	w0 = word32_in(x2, 0);                                             \
	w1 = word32_in(x2, 1);                                             \
	w2 = word32_in(x2, 2);                                             \
	w3 = word32_in(x2, 3);                                             \
}

/** @brief RECTANGLE-128 的密钥状态的4个分支的8列经过S盒变换 */
#define key128_sbox(w0, w1, w2, w3)                                    \
{                                                                      \
	t1 = ~w1; t2 = w0 & t1; t3 = w2 ^ w3; e = t2 ^ t3;                 \
	t5 = w3 | t1; t6 = w0 ^ t5; f = w2 ^ t6;                           \
	t8 = w1 ^ w2; t9 = t3 & t6; h = t8 ^ t9;                           \
	t11 = e | t8; g = t6 ^ t11;                                        \
	w0 = (w0 & WM_128) | (e & SM_128);                                 \
	w1 = (w1 & WM_128) | (f & SM_128);                                 \
	w2 = (w2 & WM_128) | (g & SM_128);                                 \
	w3 = (w3 & WM_128) | (h & SM_128);                                 \
}

/** @brief RECTANGLE-128 的密钥编排的一轮4-分支Feistel变换 */
#define key128_rol(w0, w1, w2, w3)                                     \
{                                                                      \
	t0 = rol32(w0, a_128);				                               \
	t1 = rol32(w2, b_128);				                               \
	w1 ^= t0;						                                   \
	w3 ^= t1; 						                                   \
}

/** @brief RECTANGLE-128 的密钥编排的一轮 */
#define key128_round(w0, w1, w2, w3, n)                                \
{                                                                      \
	key_out(w0, w1, w2, w3, n);                                        \
	key128_sbox(w0, w1, w2, w3);                                       \
	key128_rol(w0, w1, w2, w3);                                        \
	key_rc(w1, n);                                                     \
}

/** @brief RECTANGLE-128 的最后一轮子密钥 */
#define key128_lround(w0, w1, w2, w3, n)                               \
{                                                                      \
	key_out(w0, w1, w2, w3, n);                                        \
}

/** @brief RECTANGLE-128 的密钥编排 */
inline void key128(u8 *userKey, u16 *subKey)
{
	u32 k0, k1, k2, k3;
	u32 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;
	u32 e, f, g, h;

	key128_in(k0, k1, k2, k3, userKey);
	key128_round(k0, k1, k2, k3, 0);
	key128_round(k1, k2, k3, k0, 1);
	key128_round(k2, k3, k0, k1, 2);
	key128_round(k3, k0, k1, k2, 3);
	key128_round(k0, k1, k2, k3, 4);
	key128_round(k1, k2, k3, k0, 5);
	key128_round(k2, k3, k0, k1, 6);
	key128_round(k3, k0, k1, k2, 7);
	key128_round(k0, k1, k2, k3, 8);
	key128_round(k1, k2, k3, k0, 9);
	key128_round(k2, k3, k0, k1, 10);
	key128_round(k3, k0, k1, k2, 11);
	key128_round(k0, k1, k2, k3, 12);
	key128_round(k1, k2, k3, k0, 13);
	key128_round(k2, k3, k0, k1, 14);
	key128_round(k3, k0, k1, k2, 15);
	key128_round(k0, k1, k2, k3, 16);
	key128_round(k1, k2, k3, k0, 17);
	key128_round(k2, k3, k0, k1, 18);
	key128_round(k3, k0, k1, k2, 19);
	key128_round(k0, k1, k2, k3, 20);
	key128_round(k1, k2, k3, k0, 21);
	key128_round(k2, k3, k0, k1, 22);
	key128_round(k3, k0, k1, k2, 23);
	key128_round(k0, k1, k2, k3, 24);
	key128_lround(k1, k2, k3, k0, 25);
}


void Key_Schedule(
	unsigned char *Seedkey, 
	int KeyLen, 
	unsigned char Direction, 
	unsigned char *Subkey)
{
	switch(KeyLen)
	{
	case  80: key80(Seedkey, (u16 *)Subkey); break;
	case 128: key128(Seedkey, (u16 *)Subkey); break;
	default: printf("密钥长度错误，应当是80或128（以比特计）。\n"); exit(1);
	}
}
