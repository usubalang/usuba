/** @file crypt.cpp
  * @brief 本文件包含RECTANGLE密码算法的加密、解密函数定义。
  */
#include "rectangle.h"

/** @brief 将变量  @a x 的第 @a n 个16-比特字取出 */
#  define word16_in(x,n)    (*((u16*)(x)+(n)))
/** @brief 将16-比特字 @a v 插入到变量 @a x 的第 @a n 个字的位置 */
#  define word16_out(x,n,v) (*((u16*)(x)+(n)) = (v))

/** @brief RECTANGLE的ShiftRow的第1行的行移位参数 */
#define ROL16_1  1
/** @brief RECTANGLE的ShiftRow的第2行的行移位参数 */
#define ROL16_2 12
/** @brief RECTANGLE的ShiftRow的第3行的行移位参数 */
#define ROL16_3 13

/** @brief 从 @a ip 地址开始，将一个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 一个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放RECTANGLE状态矩阵的第 0 行的寄存器
 *  @param [out] x1 存放RECTANGLE状态矩阵的第 1 行的寄存器
 *  @param [out] x2 存放RECTANGLE状态矩阵的第 2 行的寄存器
 *  @param [out] x3 存放RECTANGLE状态矩阵的第 3 行的寄存器
 */
#define input_1Block(x0, x1, x2, x3, ip)                                                                                      \
{                                                                                                                             \
	x0 = word16_in(ip, 0);                                                                                                    \
	x1 = word16_in(ip, 1);                                                                                                    \
	x2 = word16_in(ip, 2);                                                                                                    \
	x3 = word16_in(ip, 3);                                                                                                    \
};

/** @brief 从 @a op 地址开始，将 @a x0, @a x1, @a x2, @a x3 依次装载到一个分组的第0、1、2、3个16-比特字中。
 *
 *  @param [ in] x0 存放RECTANGLE状态矩阵的第 0 行的寄存器
 *  @param [ in] x1 存放RECTANGLE状态矩阵的第 1 行的寄存器
 *  @param [ in] x2 存放RECTANGLE状态矩阵的第 2 行的寄存器
 *  @param [ in] x3 存放RECTANGLE状态矩阵的第 3 行的寄存器
 *  @param [out] op 一个8-字节分组在内存中的输出起始地址
 */
#define output_1Block(x0, x1, x2, x3, op)                                                                                     \
{                                                                                                                             \
	word16_out(op, 0, x0);                                                                                                    \
	word16_out(op, 1, x1);                                                                                                    \
	word16_out(op, 2, x2);                                                                                                    \
	word16_out(op, 3, x3);                                                                                                    \
};

/** @brief RECTANGLE加密算法的S盒层（SubColumn）使用通用指令进行比特切片实现的指令序列。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序生成。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a S盒第 0 个比特位置的输入，即RECTANGLE密码状态的第 0 行作为输入
 *  @param [ in] b S盒第 1 个比特位置的输入，即RECTANGLE密码状态的第 1 行作为输入
 *  @param [ in] c S盒第 2 个比特位置的输入，即RECTANGLE密码状态的第 2 行作为输入
 *  @param [ in] d S盒第 3 个比特位置的输入，即RECTANGLE密码状态的第 3 行作为输入
 *  @param [out] e S盒第 0 个比特位置的输出，即RECTANGLE密码状态的第 0 行作为输出
 *  @param [out] f S盒第 1 个比特位置的输出，即RECTANGLE密码状态的第 1 行作为输出
 *  @param [out] g S盒第 2 个比特位置的输出，即RECTANGLE密码状态的第 2 行作为输出
 *  @param [out] h S盒第 3 个比特位置的输出，即RECTANGLE密码状态的第 3 行作为输出
 */
#define forward_sbox_1Block(a, b, c, d, e, f, g, h)                                                                           \
{                                                                                                                             \
	t1 = ~b;                                                                                                                  \
	t2 = d | t1;                                                                                                              \
	t3 = a ^ t2;                                                                                                              \
	f = c ^ t3; t5 = a & t1; t6 = c ^ d;                                                                                      \
	e = t5 ^ t6; t8 = b ^ c;                                                                                                  \
	t9 = t3 & t6;                                                                                                             \
	h = t8 ^ t9; t11 = e | t8;                                                                                                \
	g = t3 ^ t11;                                                                                                             \
}

/** @brief RECTANGLE加密算法的P置换层（ShiftRow）使用通用指令进行比特切片实现的指令序列。
 *
 *  @param [in,out] x0 ShiftRow第 0 行的输入，并在原地执行循环左       0 位，得到第 0 行的输出
 *  @param [in,out] x1 ShiftRow第 1 行的输入，并在原地执行循环左 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 ShiftRow第 2 行的输入，并在原地执行循环左 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 ShiftRow第 3 行的输入，并在原地执行循环左 ROL16_3 位，得到第 3 行的输出
 */
#define forward_permutation_1Block(x0, x1, x2, x3)                                                                            \
	{                                                                                                                         \
	x1 = rol16(x1, ROL16_1);                                                                                                  \
	x2 = rol16(x2, ROL16_2);                                                                                                  \
	x3 = rol16(x3, ROL16_3);                                                                                                  \
};

/** @brief RECTANGLE加密算法的轮密钥加（AddRoundKey）使用通用指令进行比特切片实现的指令序列。
 *
 *  @param [in,out] x0 RECTANGLE状态矩阵的第 0 行，并在原地执行密钥加，得到第 0 行的输出
 *  @param [in,out] x1 RECTANGLE状态矩阵的第 1 行，并在原地执行密钥加，得到第 1 行的输出
 *  @param [in,out] x2 RECTANGLE状态矩阵的第 2 行，并在原地执行密钥加，得到第 2 行的输出
 *  @param [in,out] x3 RECTANGLE状态矩阵的第 3 行，并在原地执行密钥加，得到第 3 行的输出
 *  @param [    in] kp 轮子密钥在内存中的起始地址
 */
#define forward_keyxor_1Block(x0, x1, x2, x3, kp)                                                                             \
	{                                                                                                                         \
	x0 ^= (kp)[0];                                                                                                            \
	x1 ^= (kp)[1];                                                                                                            \
	x2 ^= (kp)[2];                                                                                                            \
	x3 ^= (kp)[3];                                                                                                            \
}

/** @brief RECTANGLE加密算法的轮函数使用通用指令，处理一个分组。
 *
 *  RECTANGLE加密算法的轮函数是依次执行以下变换:
 *      - AddRoundKey   对应于forward_keyxor_1Block()
 *      - SubColumn     对应于forward_sbox_1Block()
 *      - ShiftRow      对应于forward_permutation_1Block()
 *
 *  @param [ in] a  一轮密码状态的第 0 行输入
 *  @param [ in] b  一轮密码状态的第 1 行输入
 *  @param [ in] c  一轮密码状态的第 2 行输入
 *  @param [ in] d  一轮密码状态的第 3 行输入
 *  @param [out] e  一轮密码状态的第 0 行输出
 *  @param [out] f  一轮密码状态的第 1 行输出
 *  @param [out] g  一轮密码状态的第 2 行输出
 *  @param [out] h  一轮密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define forward_round_1Block(a, b, c, d, e, f, g, h, kp)        \
  {                                                             \
	forward_keyxor_1Block(a, b, c, d, kp);                      \
	forward_sbox_1Block(a, b, c, d, e, f, g, h);                \
	forward_permutation_1Block(e, f, g, h);                     \
  }

/** @brief RECTANGLE加密算法的最后一轮密钥加
 *
 *  RECTANGLE加密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define forward_last_round_1Block(a, b, c, d, kp)   forward_keyxor_1Block(a, b, c, d, kp);

/** @brief RECTANGLE加密算法加密一个分组
 *
 *  RECTANGLE加密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现展开全部轮函数，避免变量的赋值。其中：
 *
 *  - @a r0  一轮密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a r1  一轮密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a r2  一轮密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a r3  一轮密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a r4  一轮密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a r5  一轮密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a r6  一轮密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a r7  一轮密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入分组的起始地址
 *  - @a out 输出分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
 */
#define encrypt_1Block                                                  \
  {                                                                     \
    input_1Block(r0, r1, r2, r3, in);                                   \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  0 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  1 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  2 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  3 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  4 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  5 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  6 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  7 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  8 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  9 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 10 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 11 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 12 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 13 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 14 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 15 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 16 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 17 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 18 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 19 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 20 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 21 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 22 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp + 23 * BLOCK_WORD_NUMBER); \
	forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp + 24 * BLOCK_WORD_NUMBER); \
	forward_last_round_1Block(r4, r5, r6, r7, kp + 25 * BLOCK_WORD_NUMBER); \
	output_1Block(r4, r5, r6, r7, out);                                 \
  }


/** @brief RECTANGLE加密一个分组指定轮数
 *
 *  执行 @a rn 个相同的加密轮函数（除轮密钥不同），没有最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现 2 轮展开，避免变量的赋值。其中：
 *
 *  - @a r0  一轮密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a r1  一轮密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a r2  一轮密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a r3  一轮密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a r4  一轮密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a r5  一轮密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a r6  一轮密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a r7  一轮密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入分组的起始地址
 *  - @a out 输出分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
 */
#define encrypt_1Block_variousRound(rn)																					      \
{																														      \
	input_1Block(r0, r1, r2, r3, in); 																					      \
	int even_rn = (rn)>>1;																								      \
	int last_rn = (rn)&1;																								      \
	int ri = 0;																											      \
	for (ri = 0; ri < even_rn; ri++)																					      \
	{																													      \
		forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);					      \
		forward_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp +  ((ri<<1) + 1) * BLOCK_WORD_NUMBER);					      \
	}																													      \
	if (1 == last_rn)																									      \
	{																													      \
		forward_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);					      \
		output_1Block(r4, r5, r6, r7, out);																				      \
	}																													      \
	else																												      \
	{																													      \
		output_1Block(r0, r1, r2, r3, out);																				      \
	}																													      \
}

/** @brief RECTANGLE解密算法的S盒层（inverse SubColumn）使用通用指令进行比特切片实现的指令序列。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序生成。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a 逆S盒第 0 个比特位置的输入，即RECTANGLE密码状态的第 0 行作为输入
 *  @param [ in] b 逆S盒第 1 个比特位置的输入，即RECTANGLE密码状态的第 1 行作为输入
 *  @param [ in] c 逆S盒第 2 个比特位置的输入，即RECTANGLE密码状态的第 2 行作为输入
 *  @param [ in] d 逆S盒第 3 个比特位置的输入，即RECTANGLE密码状态的第 3 行作为输入
 *  @param [out] e 逆S盒第 0 个比特位置的输出，即RECTANGLE密码状态的第 0 行作为输出
 *  @param [out] f 逆S盒第 1 个比特位置的输出，即RECTANGLE密码状态的第 1 行作为输出
 *  @param [out] g 逆S盒第 2 个比特位置的输出，即RECTANGLE密码状态的第 2 行作为输出
 *  @param [out] h 逆S盒第 3 个比特位置的输出，即RECTANGLE密码状态的第 3 行作为输出
 */
#define invert_sbox_1Block(a, b, c, d, e, f, g, h)                                                                            \
{                                                                                                                             \
	t1 = a ^ b; t2 = a | d; t3 = c ^ t2; g = b ^ t3;                                                                          \
	t5 = a & t3; t6 = d ^ g; f = t5 ^ t6;                                                                                     \
	t8 = ~f; t9 = t3 | t8; h = t1 ^ t9;                                                                                       \
	t11 = t8 | h; e = t3 ^ t11;                                                                                               \
}

/** @brief RECTANGLE解密算法的P置换层（inverse ShiftRow）使用通用指令进行比特切片实现的指令序列。
 *
 *  @param [in,out] x0 inverse ShiftRow第 0 行的输入，并在原地执行循环右       0 位，得到第 0 行的输出
 *  @param [in,out] x1 inverse ShiftRow第 1 行的输入，并在原地执行循环右 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 inverse ShiftRow第 2 行的输入，并在原地执行循环右 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 inverse ShiftRow第 3 行的输入，并在原地执行循环右 ROL16_3 位，得到第 3 行的输出
 */
#define invert_permutation_1Block(x0, x1, x2, x3)                                                                             \
	{                                                                                                                         \
	x1 = ror16(x1, ROL16_1);                                                                                                  \
	x2 = ror16(x2, ROL16_2);                                                                                                  \
	x3 = ror16(x3, ROL16_3);                                                                                                  \
};

/** @brief RECTANGLE解密算法的轮密钥加（inverse AddRoundKey）使用通用指令进行比特切片实现的指令序列。
 *  与RECTANGLE加密算法的轮密钥加相同。
 *  @param [in,out] x0 RECTANGLE状态矩阵的第 0 行，并在原地执行密钥加，得到第 0 行的输出
 *  @param [in,out] x1 RECTANGLE状态矩阵的第 1 行，并在原地执行密钥加，得到第 1 行的输出
 *  @param [in,out] x2 RECTANGLE状态矩阵的第 2 行，并在原地执行密钥加，得到第 2 行的输出
 *  @param [in,out] x3 RECTANGLE状态矩阵的第 3 行，并在原地执行密钥加，得到第 3 行的输出
 *  @param [    in] kp 轮子密钥在内存中的起始地址
 */
#define invert_keyxor_1Block(x0, x1, x2, x3, kp) forward_keyxor_1Block(x0, x1, x2, x3, kp)

/** @brief RECTANGLE解密算法的轮函数使用通用指令进行比特切片实现的指令序列。
 *
 *  RECTANGLE解密算法的轮函数是依次执行以下变换:
 *      - inverse AddRoundKey   对应于invert_keyxor_1Block()
 *      - inverse ShiftRow      对应于invert_permutation_1Block()
 *      - inverse SubColumn     对应于invert_sbox_1Block()
 *
 *  @param [ in] a  一轮密码状态的第 0 行输入
 *  @param [ in] b  一轮密码状态的第 1 行输入
 *  @param [ in] c  一轮密码状态的第 2 行输入
 *  @param [ in] d  一轮密码状态的第 3 行输入
 *  @param [out] e  一轮密码状态的第 0 行输出
 *  @param [out] f  一轮密码状态的第 1 行输出
 *  @param [out] g  一轮密码状态的第 2 行输出
 *  @param [out] h  一轮密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define invert_round_1Block(a, b, c, d, e, f, g, h, kp)                                                                       \
	{                                                                                                                         \
	invert_keyxor_1Block(a, b, c, d, kp);                                                                                     \
	invert_permutation_1Block(a, b, c, d);                                                                                    \
	invert_sbox_1Block(a, b, c, d, e, f, g, h);                                                                               \
}

/** @brief RECTANGLE解密算法的最后一轮密钥加
 *
 *  RECTANGLE解密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define invert_last_round_1Block(a, b, c, d, kp)   invert_keyxor_1Block(a, b, c, d, kp);

/** @brief RECTANGLE解密算法解密一个分组
 *
 *  RECTANGLE的解密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现全轮展开，避免变量的赋值。其中：

 *  - @a r0  一轮密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a r1  一轮密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a r2  一轮密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a r3  一轮密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a r4  一轮密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a r5  一轮密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a r6  一轮密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a r7  一轮密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入分组的起始地址
 *  - @a out 输出分组的起始地址
 *  - @a kp  扩展密钥在内存中的终止地址
 */
#define decrypt_1Block                                                                                                        \
{																					                                          \
	input_1Block(r0, r1, r2, r3, in);												                                          \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp -  0 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp -  1 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp -  2 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp -  3 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp -  4 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp -  5 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp -  6 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp -  7 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp -  8 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp -  9 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 10 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 11 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 12 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 13 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 14 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 15 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 16 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 17 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 18 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 19 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 20 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 21 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 22 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r4, r5, r6, r7, r0, r1, r2, r3, kp - 23 * BLOCK_WORD_NUMBER);                                         \
	invert_round_1Block(r0, r1, r2, r3, r4, r5, r6, r7, kp - 24 * BLOCK_WORD_NUMBER);                                         \
	invert_last_round_1Block(r4, r5, r6, r7, kp - 25 * BLOCK_WORD_NUMBER);			                                          \
	output_1Block(r4, r5, r6, r7, out);												                                          \
}

#if (EI>=SSE)

/** @brief 从 @a ip 地址开始，将8个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 8 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23, @a xmm45, @a xmm67 中
 *      - 将 8 个分组进行重组，使得8个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故8个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 8个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放8个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放8个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放8个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放8个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_8Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadu_si128((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_loadu_si128((__m128i *)(ip + (2 * 16)));		                                                              \
	xmm67 = _mm_loadu_si128((__m128i *)(ip + (3 * 16)));		                                                              \
	xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);					                                                              \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	xmm46 = _mm_unpacklo_epi64(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi64(xmm45, xmm67);					                                                              \
	xmm45 = _mm_unpacklo_epi16(xmm46, xmm57);					                                                              \
	xmm67 = _mm_unpackhi_epi16(xmm46, xmm57);					                                                              \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);					                                                              \
}

/** @brief 从 @a ip 地址开始，将7个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 7 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23, @a xmm45, @a xmm67 中
 *      - 将 7 个分组进行重组，使得7个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故7个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 7个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放7个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放7个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放7个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放7个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_7Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadu_si128((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_loadu_si128((__m128i *)(ip + (2 * 16)));		                                                              \
	xmm67 = _mm_loadl_epi64((__m128i *)(ip + (3 * 16)));		                                                              \
	xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);					                                                              \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	xmm46 = _mm_unpacklo_epi64(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi64(xmm45, xmm67);					                                                              \
	xmm45 = _mm_unpacklo_epi16(xmm46, xmm57);					                                                              \
	xmm67 = _mm_unpackhi_epi16(xmm46, xmm57);					                                                              \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);					                                                              \
}

/** @brief 从 @a ip 地址开始，将6个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 6 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23, @a xmm45 中, @a xmm67 寄存器置零。
 *      - 将 6 个分组进行重组，使得6个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故6个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 6个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放6个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放6个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放6个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放6个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_6Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadu_si128((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_loadu_si128((__m128i *)(ip + (2 * 16)));		                                                              \
	xmm67 = _mm_setzero_si128();							                                                                  \
	xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);					                                                              \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	xmm46 = _mm_unpacklo_epi64(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi64(xmm45, xmm67);					                                                              \
	xmm45 = _mm_unpacklo_epi16(xmm46, xmm57);					                                                              \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);					                                                              \
}

/** @brief 从 @a ip 地址开始，将5个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 5 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23, @a xmm45 中, @a xmm67 寄存器置零。
 *      - 将 5 个分组进行重组，使得5个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故5个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 5个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放5个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放5个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放5个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放5个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_5Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadu_si128((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_loadl_epi64((__m128i *)(ip + (2 * 16)));		                                                              \
	xmm67 = _mm_setzero_si128();							                                                                  \
	xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);					                                                              \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	xmm45 = _mm_unpacklo_epi16(xmm45, xmm67);					                                                              \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);					                                                              \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);					                                                              \
}

/** @brief 从 @a ip 地址开始，将4个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 4 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23 中, @a xmm45 寄存器置零。
 *      - 将 4 个分组进行重组，使得4个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故4个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 4个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放4个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放4个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放4个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放4个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_4Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadu_si128((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_setzero_si128();							                                                                  \
	xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);					                                                              \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm45);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm45);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm45);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm45);					                                                              \
}

/** @brief 从 @a ip 地址开始，将3个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 3 个分组按顺序装载在 128 比特寄存器 @a xmm01, @a xmm23 中, @a xmm45 寄存器置零。
 *      - 将 3 个分组进行重组，使得3个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故3个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 3个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放3个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放3个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放3个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放3个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_3Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip + (0 * 16)));		                                                              \
	xmm23 = _mm_loadl_epi64((__m128i *)(ip + (1 * 16)));		                                                              \
	xmm45 = _mm_setzero_si128();							                                                                  \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm45);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm01, xmm13);					                                                              \
	xmm23 = _mm_unpacklo_epi16(xmm23, xmm45);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm45);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm45);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm45);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm45);					                                                              \
}

/** @brief 从 @a ip 地址开始，将2个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 2 个分组按顺序装载在 128 比特寄存器 @a xmm01 中, @a xmm23 寄存器置零。
 *      - 将 2 个分组进行重组，使得2个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故2个分组的各行在寄存器中也是有序的。
 *
 *  @param [ in] ip 2个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放2个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [out] x1 存放2个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [out] x2 存放2个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [out] x3 存放2个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 */
#define input_2Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	xmm01 = _mm_loadu_si128((__m128i *)(ip +  (0 * 16)));		                                                              \
	xmm23 = _mm_setzero_si128();							                                                                  \
	xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);					                                                              \
	xmm01 = _mm_unpacklo_epi16(xmm01, xmm13);					                                                              \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);					                                                              \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);					                                                              \
	x0    = _mm_unpacklo_epi64(xmm02, xmm23);					                                                              \
	x1    = _mm_unpackhi_epi64(xmm02, xmm23);					                                                              \
	x2    = _mm_unpacklo_epi64(xmm13, xmm23);					                                                              \
	x3    = _mm_unpackhi_epi64(xmm13, xmm23);					                                                              \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 8 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的8个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 8 个分组进行重组，使得为连续的8个输出分组。
 *      - 将 8 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放8个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放8个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放8个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放8个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 8个8-字节分组在内存中的输出起始地址
 */
#define output_8Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm45 = _mm_unpackhi_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	xmm67 = _mm_unpackhi_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	x2    = _mm_unpacklo_epi32(xmm45, xmm67);			                                                                      \
	x3    = _mm_unpackhi_epi32(xmm45, xmm67);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (1 * 16)), x1);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (2 * 16)), x2);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (3 * 16)), x3);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 7 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的7个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 7 个分组进行重组，使得为连续的7个输出分组。
 *      - 将 7 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放7个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放7个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放7个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放7个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 7个8-字节分组在内存中的输出起始地址
 */
#define output_7Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm45 = _mm_unpackhi_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	xmm67 = _mm_unpackhi_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	x2    = _mm_unpacklo_epi32(xmm45, xmm67);			                                                                      \
	x3    = _mm_unpackhi_epi32(xmm45, xmm67);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (1 * 16)), x1);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (2 * 16)), x2);	                                                                      \
	_mm_storel_epi64((__m128i *)(op + (3 * 16)), x3);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 6 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的6个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 6 个分组进行重组，使得为连续的6个输出分组。
 *      - 将 6 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放6个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放6个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放6个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放6个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 6个8-字节分组在内存中的输出起始地址
 */
#define output_6Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm45 = _mm_unpackhi_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	xmm67 = _mm_unpackhi_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	x2    = _mm_unpacklo_epi32(xmm45, xmm67);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (1 * 16)), x1);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (2 * 16)), x2);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 5 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的5个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 5 个分组进行重组，使得为连续的5个输出分组。
 *      - 将 5 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放5个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放5个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放5个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放5个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 5个8-字节分组在内存中的输出起始地址
 */
#define output_5Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm45 = _mm_unpackhi_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	xmm67 = _mm_unpackhi_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	x2    = _mm_unpacklo_epi32(xmm45, xmm67);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (1 * 16)), x1);	                                                                      \
	_mm_storel_epi64((__m128i *)(op + (2 * 16)), x2);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 4 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的4个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 4 个分组进行重组，使得为连续的4个输出分组。
 *      - 将 4 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放4个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放4个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放4个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放4个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 4个8-字节分组在内存中的输出起始地址
 */
#define output_4Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storeu_si128((__m128i *)(op + (1 * 16)), x1);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 3 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的3个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 3 个分组进行重组，使得为连续的3个输出分组。
 *      - 将 3 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放3个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放3个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放3个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放3个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 3个8-字节分组在内存中的输出起始地址
 */
#define output_3Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);			                                                                      \
	_mm_storeu_si128((__m128i *)(op + (0 * 16)), x0);	                                                                      \
	_mm_storel_epi64((__m128i *)(op + (1 * 16)), x1);	                                                                      \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 2 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的2个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 2 个分组进行重组，使得为连续的2个输出分组。
 *      - 将 2 个分组按顺序存储在从 @a op 开始的输出地址上
 *  
 *  分组的重组使用 unpacklo\\hi_epi32\\16 来实现。
 *
 *  @param [ in] x0 存放2个RECTANGLE状态矩阵的第 0 行的128-比特寄存器
 *  @param [ in] x1 存放2个RECTANGLE状态矩阵的第 1 行的128-比特寄存器
 *  @param [ in] x2 存放2个RECTANGLE状态矩阵的第 2 行的128-比特寄存器
 *  @param [ in] x3 存放2个RECTANGLE状态矩阵的第 3 行的128-比特寄存器
 *  @param [out] op 2个8-字节分组在内存中的输出起始地址
 */
#define output_2Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	xmm01 = _mm_unpacklo_epi16(x0, x1);			                                                                              \
	xmm23 = _mm_unpacklo_epi16(x2, x3);			                                                                              \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);			                                                                      \
	_mm_storeu_si128((__m128i *)(op +  (0 * 16)), x0);	                                                                      \
}

/** @brief RECTANGLE加密算法的S盒层（SubColumn）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序生成。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a S盒第 0 个比特位置的输入，即RECTANGLE的 8 个密码状态的第 0 行作为输入
 *  @param [ in] b S盒第 1 个比特位置的输入，即RECTANGLE的 8 个密码状态的第 1 行作为输入
 *  @param [ in] c S盒第 2 个比特位置的输入，即RECTANGLE的 8 个密码状态的第 2 行作为输入
 *  @param [ in] d S盒第 3 个比特位置的输入，即RECTANGLE的 8 个密码状态的第 3 行作为输入
 *  @param [out] e S盒第 0 个比特位置的输出，即RECTANGLE的 8 个密码状态的第 0 行作为输出
 *  @param [out] f S盒第 1 个比特位置的输出，即RECTANGLE的 8 个密码状态的第 1 行作为输出
 *  @param [out] g S盒第 2 个比特位置的输出，即RECTANGLE的 8 个密码状态的第 2 行作为输出
 *  @param [out] h S盒第 3 个比特位置的输出，即RECTANGLE的 8 个密码状态的第 3 行作为输出
 */
#define forward_sbox_8Block(a, b, c, d, e, f, g, h)                                                                           \
	{ 												                                                                          \
	tmm1  = _mm_xor_si128(    b, all1 );                                                                                      \
	tmm2  = _mm_or_si128 (    d, tmm1 );                                                                                      \
	tmm3  = _mm_xor_si128(    a, tmm2 );                                                                                      \
	   f  = _mm_xor_si128(    c, tmm3 );                                                                                      \
	tmm5  = _mm_and_si128(    a, tmm1 );                                                                                      \
	tmm6  = _mm_xor_si128(    c,    d );                                                                                      \
	   e  = _mm_xor_si128( tmm5, tmm6 );                                                                                      \
	tmm8  = _mm_xor_si128 (   b,    c );                                                                                      \
	tmm9  = _mm_and_si128( tmm3, tmm6 );                                                                                      \
	   h  = _mm_xor_si128( tmm8, tmm9 );                                                                                      \
	tmm11 = _mm_or_si128 (    e, tmm8 );                                                                                      \
	   g  = _mm_xor_si128( tmm3, tmm11);                                                                                      \
};

/** @brief RECTANGLE加密算法的P置换层（ShiftRow）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  在SSE指令集中，add 指令较 slli 指令的延迟短，吞吐量大，故使用 add(x,x) 来实现左移1位：slli(x,1)
 *
 *  @param [in,out] x0 ShiftRow第 0 行的输入，并在原地执行循环左       0 位，得到第 0 行的输出
 *  @param [in,out] x1 ShiftRow第 1 行的输入，并在原地执行循环左 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 ShiftRow第 2 行的输入，并在原地执行循环左 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 ShiftRow第 3 行的输入，并在原地执行循环左 ROL16_3 位，得到第 3 行的输出
 */
#define forward_permutation_8Block(x0, x1, x2, x3)                                                                            \
	{                                                                                                                         \
	x1 = _mm_or_si128(_mm_add_epi16 (x1,      x1), _mm_srli_epi16(x1, 16 - ROL16_1));                                         \
	x2 = _mm_or_si128(_mm_slli_epi16(x2, ROL16_2), _mm_srli_epi16(x2, 16 - ROL16_2));                                         \
	x3 = _mm_or_si128(_mm_slli_epi16(x3, ROL16_3), _mm_srli_epi16(x3, 16 - ROL16_3));                                         \
};

/** @brief RECTANGLE加密算法的轮密钥加（AddRoundKey）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 * 
 *  要首先广播每一行的密钥：_mm_set1_epi16。
 *
 *  @param [in,out] x0 RECTANGLE状态矩阵的第 0 行，并在原地执行密钥加，得到第 0 行的输出
 *  @param [in,out] x1 RECTANGLE状态矩阵的第 1 行，并在原地执行密钥加，得到第 1 行的输出
 *  @param [in,out] x2 RECTANGLE状态矩阵的第 2 行，并在原地执行密钥加，得到第 2 行的输出
 *  @param [in,out] x3 RECTANGLE状态矩阵的第 3 行，并在原地执行密钥加，得到第 3 行的输出
 *  @param [    in] kp 轮子密钥在内存中的起始地址
 */
#define forward_keyxor_8Block(x0, x1, x2, x3, kp)                                                                             \
	{                                                                                                                         \
	kmm0 = _mm_set1_epi16((kp)[0]);                                                                                           \
	kmm1 = _mm_set1_epi16((kp)[1]);                                                                                           \
	kmm2 = _mm_set1_epi16((kp)[2]);                                                                                           \
	kmm3 = _mm_set1_epi16((kp)[3]);                                                                                           \
	x0 	 = _mm_xor_si128(x0, kmm0);                                                                                           \
	x1 	 = _mm_xor_si128(x1, kmm1);                                                                                           \
	x2 	 = _mm_xor_si128(x2, kmm2);                                                                                           \
	x3 	 = _mm_xor_si128(x3, kmm3);                                                                                           \
}

/** @brief RECTANGLE加密算法的轮函数使用 SSE 指令，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE加密算法的轮函数是依次执行以下变换:
 *      - AddRoundKey   对应于forward_keyxor_8Block()
 *      - SubColumn     对应于forward_sbox_8Block()
 *      - ShiftRow      对应于forward_permutation_8Block()
 *
 *  @param [ in] a  一轮8个密码状态的第 0 行输入
 *  @param [ in] b  一轮8个密码状态的第 1 行输入
 *  @param [ in] c  一轮8个密码状态的第 2 行输入
 *  @param [ in] d  一轮8个密码状态的第 3 行输入
 *  @param [out] e  一轮8个密码状态的第 0 行输出
 *  @param [out] f  一轮8个密码状态的第 1 行输出
 *  @param [out] g  一轮8个密码状态的第 2 行输出
 *  @param [out] h  一轮8个密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define forward_round_8Block(a, b, c, d, e, f, g, h, kp)                                                                      \
	{                                                                                                                         \
	forward_keyxor_8Block(a, b, c, d, kp);                                                                                    \
	forward_sbox_8Block(a, b, c, d, e, f, g, h);                                                                              \
	forward_permutation_8Block(e, f, g, h);                                                                                   \
}

/** @brief RECTANGLE加密算法的最后一轮密钥加，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE加密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮 8 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮 8 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮 8 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮 8 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define forward_last_round_8Block(a, b, c, d, kp)   forward_keyxor_8Block(a, b, c, d, kp);

/** @brief RECTANGLE加密算法加密 @a n 个分组， 其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE加密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现展开全部轮函数，避免变量的赋值。其中：
 *
 *  - @a xmm0  一轮 @a n 个密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm1  一轮 @a n 个密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm2  一轮 @a n 个密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm3  一轮 @a n 个密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm4  一轮 @a n 个密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm5  一轮 @a n 个密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm6  一轮 @a n 个密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm7  一轮 @a n 个密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入 @a n 个分组的起始地址
 *  - @a out 输出 @a n 分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
 *
 *  @param   [in] n 分组的个数，其中 @ n 在集合 {8, 7, 6, 5, 4, 3, 2} 中
 */
// #include "SSE.h"

// /* auxiliary functions */
// void SubColumn__ (/*inputs*/ DATATYPE a0,DATATYPE a1,DATATYPE a2,DATATYPE a3, /*outputs*/ DATATYPE* b0,DATATYPE* b1,DATATYPE* b2,DATATYPE* b3) {
  
//   // Variables declaration
//   DATATYPE t1;
//   DATATYPE t11;
//   DATATYPE t2;
//   DATATYPE t3;
//   DATATYPE t5;
//   DATATYPE t6;
//   DATATYPE t8;
//   DATATYPE t9;


//   // Instructions (body)
//   t1 = NOT(a1);
//   t3 = XOR(a2,a3);
//   t8 = XOR(a1,a2);
//   t2 = AND(a0,t1);
//   t5 = OR(a3,t1);
//   *b0 = XOR(t2,t3);
//   t6 = XOR(a0,t5);
//   t11 = OR(*b0,t8);
//   *b1 = XOR(a2,t6);
//   t9 = AND(t3,t6);
//   *b2 = XOR(t6,t11);
//   *b3 = XOR(t8,t9);

// }

// /* main function */
// #define RectUA(plain__0,plain__1,plain__2,plain__3,key,cipher) {
  
//   // Variables declaration
//   DATATYPE _tmp1_[4];
//   DATATYPE _tmp2_[4];
//   DATATYPE tmp__[4];


//   // Instructions (body)
//   tmp__[0] = plain__0;
//   tmp__[1] = plain__1;
//   tmp__[2] = plain__2;
//   tmp__[3] = plain__3;
//   #pragma clang loop unroll(full)
//   for (int i = 0; i <= 24; i++) {
//     _tmp1_[0] = XOR(tmp__[0],key__[i*4+0]);
//     _tmp1_[1] = XOR(tmp__[1],key__[i*4+1]);
//     _tmp1_[2] = XOR(tmp__[2],key__[i*4+2]);
//     _tmp1_[3] = XOR(tmp__[3],key__[i*4+3]);
//     SubColumn__(_tmp1_[0],_tmp1_[1],_tmp1_[2],_tmp1_[3],&_tmp2_[0],&_tmp2_[1],&_tmp2_[2],&_tmp2_[3]);
//     tmp__[0] = _tmp2_[0];
//     tmp__[1] = L_ROTATE(_tmp2_[1],1,16);
//     tmp__[2] = L_ROTATE(_tmp2_[2],12,16);
//     tmp__[3] = L_ROTATE(_tmp2_[3],13,16);
//   }
//   cipher__[0] = XOR(tmp__[0],key__[25*4+0]);
//   cipher__[1] = XOR(tmp__[1],key__[25*4+1]);
//   cipher__[2] = XOR(tmp__[2],key__[25*4+2]);
//   cipher__[3] = XOR(tmp__[3],key__[25*4+3]);

// }

#define encrypt_8Blocks(n)                                              \
  {                                                                     \
	input_##n##Blocks(xmm0, xmm1, xmm2, xmm3, in);                      \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  0 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  1 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  2 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  3 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  4 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  5 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  6 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  7 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  8 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  9 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 10 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 11 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 12 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 13 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 14 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 15 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 16 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 17 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 18 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 19 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 20 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 21 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 22 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp + 23 * BLOCK_WORD_NUMBER); \
	forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp + 24 * BLOCK_WORD_NUMBER); \
	forward_last_round_8Block(xmm4, xmm5, xmm6, xmm7, kp + 25 * BLOCK_WORD_NUMBER); \
	output_##n##Blocks(xmm4, xmm5, xmm6, xmm7, out);                    \
  }

/** @brief RECTANGLE加密 @a n 个分组指定轮数，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  执行 @a rn 个相同的加密轮函数（除轮密钥不同），没有最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现 2 轮展开，避免变量的赋值。其中：
 *
 *  - @a xmm0  一轮 @a n 密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm1  一轮 @a n 密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm2  一轮 @a n 密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm3  一轮 @a n 密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm4  一轮 @a n 密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm5  一轮 @a n 密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm6  一轮 @a n 密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm7  一轮 @a n 密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入分组的起始地址
 *  - @a out 输出分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
  *
 *  @param   [in] n  分组的个数，其中 @ n 在集合 {8, 7, 6, 5, 4, 3, 2} 中
 *  @param   [in] rn 所指定的轮数
*/
#define encrypt_8Blocks_variousRound(n, rn)																				      \
{																														      \
	input_##n##Blocks(xmm0, xmm1, xmm2, xmm3, in);																		      \
	int even_rn = (rn)>>1;																								      \
	int last_rn = (rn)&1;																								      \
	int ri = 0;																											      \
	for (ri = 0; ri < even_rn; ri++)																					      \
	{																													      \
	    forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);        \
	    forward_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp +  ((ri<<1) + 1) * BLOCK_WORD_NUMBER);        \
	}																													      \
	if (1 == last_rn)																									      \
	{																													      \
		forward_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);        \
		output_##n##Blocks(xmm4, xmm5, xmm6, xmm7, out);											                          \
	}																													      \
	else																												      \
	{																													      \
		output_##n##Blocks(xmm0, xmm1, xmm2, xmm3, out);											                          \
	}																													      \
}

/** @brief RECTANGLE解密算法的S盒层（inverse SubColumn）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序的一个扩展版本生成。
 *  由于 SSE 和 AVX 指令集中包含 andnot 指令，这个实现中加入可以使用这个指令。
 *  经过实际的测试，在若干个相同长度(12 个项)的指令序列中，这一序列的执行时间最低。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a 逆S盒第 0 个比特位置的输入，即RECTANGLE密码状态的第 0 行作为输入
 *  @param [ in] b 逆S盒第 1 个比特位置的输入，即RECTANGLE密码状态的第 1 行作为输入
 *  @param [ in] c 逆S盒第 2 个比特位置的输入，即RECTANGLE密码状态的第 2 行作为输入
 *  @param [ in] d 逆S盒第 3 个比特位置的输入，即RECTANGLE密码状态的第 3 行作为输入
 *  @param [out] e 逆S盒第 0 个比特位置的输出，即RECTANGLE密码状态的第 0 行作为输出
 *  @param [out] f 逆S盒第 1 个比特位置的输出，即RECTANGLE密码状态的第 1 行作为输出
 *  @param [out] g 逆S盒第 2 个比特位置的输出，即RECTANGLE密码状态的第 2 行作为输出
 *  @param [out] h 逆S盒第 3 个比特位置的输出，即RECTANGLE密码状态的第 3 行作为输出
 */
#define invert_sbox_8Block(a, b, c, d, e, f, g, h)                                                                            \
{                                                                                                                             \
	tmm1 = _mm_or_si128 (   a,    d) ;                                                                                        \
	tmm2 = _mm_xor_si128(   a,    d) ;                                                                                        \
	tmm3 = _mm_andnot_si128(c,    a) ;                                                                                        \
	tmm4 = _mm_xor_si128(   c, tmm1) ;                                                                                        \
	g    = _mm_xor_si128(   b, tmm4) ;                                                                                        \
	tmm6 = _mm_xor_si128(tmm4, all1) ;                                                                                        \
	tmm7 = _mm_xor_si128(   d,    g) ;                                                                                        \
	f    = _mm_xor_si128(tmm3, tmm7) ;                                                                                        \
	tmm9 = _mm_or_si128 (tmm6, tmm7) ;                                                                                        \
	h    = _mm_xor_si128(tmm2, tmm9) ;                                                                                        \
	tmm11= _mm_andnot_si128(h,    f) ;                                                                                        \
	e    = _mm_xor_si128(tmm6, tmm11);                                                                                        \
};

/** @brief RECTANGLE解密算法的P置换层（inverse ShiftRow）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  考虑到 x64 平台一个时钟周期内可以并行运行无依赖的指令，
 *  故这里将最后一行循环右移 13 位通过循环左移 3 位来实现。而循环左移 3 位通过 add(x,x) 来实现。
 *  虽然看上去所需的指令增加了，但是由于将 add 指令穿插在之前的 srl 和 sll 指令直接，可以有利于并行。
 *  从而节省所需的CPU周期数。
 *
 *  @param [in,out] x0 inverse ShiftRow第 0 行的输入，并在原地执行循环右       0 位，得到第 0 行的输出
 *  @param [in,out] x1 inverse ShiftRow第 1 行的输入，并在原地执行循环右 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 inverse ShiftRow第 2 行的输入，并在原地执行循环右 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 inverse ShiftRow第 3 行的输入，并在原地执行循环右 ROL16_3 位，得到第 3 行的输出
 */
#define invert_permutation_8Block(x0, x1, x2, x3)                                                                             \
{                                                                                                                             \
	tmm1 = _mm_srli_epi16(x1  ,      ROL16_1);                                                                                \
	tmm2 = _mm_slli_epi16(x1  , 16 - ROL16_1);                                                                                \
	tmm3 = _mm_add_epi16 (x3  ,           x3);                                                                                \
	x1   = _mm_or_si128  (tmm1,         tmm2);                                                                                \
	tmm1 = _mm_srli_epi16(x2  ,      ROL16_2);                                                                                \
	tmm2 = _mm_slli_epi16(x2  , 16 - ROL16_2);                                                                                \
	tmm3 = _mm_add_epi16 (tmm3,         tmm3);                                                                                \
	x3   = _mm_srli_epi16(x3  ,      ROL16_3);                                                                                \
	tmm3 = _mm_add_epi16 (tmm3,         tmm3);                                                                                \
	x2   = _mm_or_si128  (tmm1,         tmm2);                                                                                \
	x3   = _mm_or_si128  (x3  ,         tmm3);                                                                                \
};

/** @brief RECTANGLE解密算法的轮密钥加（inverse AddRoundKey）使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *  
 *  与RECTANGLE加密算法的轮密钥加相同。
 *  @param [in,out] x0 一轮 8 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] x1 一轮 8 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] x2 一轮 8 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] x3 一轮 8 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define invert_keyxor_8Block(x0, x1, x2, x3, kp) forward_keyxor_8Block(x0, x1, x2, x3, kp)

/** @brief RECTANGLE解密算法的轮函数使用 SSE 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE解密算法的轮函数是依次执行以下变换:
 *      - inverse AddRoundKey   对应于invert_keyxor_8Block()
 *      - inverse ShiftRow      对应于invert_permutation_8Block()
 *      - inverse SubColumn     对应于invert_sbox_8Block()
 *
 *  @param [ in] a  一轮 8 个密码状态的第 0 行输入
 *  @param [ in] b  一轮 8 个密码状态的第 1 行输入
 *  @param [ in] c  一轮 8 个密码状态的第 2 行输入
 *  @param [ in] d  一轮 8 个密码状态的第 3 行输入
 *  @param [out] e  一轮 8 个密码状态的第 0 行输出
 *  @param [out] f  一轮 8 个密码状态的第 1 行输出
 *  @param [out] g  一轮 8 个密码状态的第 2 行输出
 *  @param [out] h  一轮 8 个密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define invert_round_8Block(a, b, c, d, e, f, g, h, kp)                                                                       \
	{                                                                                                                         \
	invert_keyxor_8Block(a, b, c, d, kp);                                                                                     \
	invert_permutation_8Block(a, b, c, d);                                                                                    \
	invert_sbox_8Block(a, b, c, d, e, f, g, h);                                                                               \
}

/** @brief RECTANGLE解密算法的最后一轮密钥加，并行处理 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE解密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮 8 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮 8 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮 8 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮 8 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define invert_last_round_8Block(a, b, c, d, kp)   invert_keyxor_8Block(a, b, c, d, kp);

/** @brief RECTANGLE解密算法解密 @a n 个分组，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 *
 *  RECTANGLE的解密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现全轮展开，避免变量的赋值。其中：

 *  - @a xmm0  一轮 8 个密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm1  一轮 8 个密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm2  一轮 8 个密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm3  一轮 8 个密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm4  一轮 8 个密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm5  一轮 8 个密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm6  一轮 8 个密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm7  一轮 8 个密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a   in  输入分组的起始地址
 *  - @a  out  输出分组的起始地址
 *  - @a   kp  扩展密钥在内存中的终止地址
 *
 *  @param [ in]  n  并行处理的分组个数，其中 @ a n 在集合 {8, 7, 6, 5, 4, 3, 2 }中。
 */ 
#define decrypt_8Blocks(n)                                                                                                    \
{                                                                                                                             \
	input_##n##Blocks(xmm0, xmm1, xmm2, xmm3, in);											                                  \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp -  0 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp -  1 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp -  2 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp -  3 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp -  4 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp -  5 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp -  6 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp -  7 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp -  8 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp -  9 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 10 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 11 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 12 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 13 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 14 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 15 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 16 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 17 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 18 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 19 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 20 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 21 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 22 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, kp - 23 * BLOCK_WORD_NUMBER);                         \
	invert_round_8Block(xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, kp - 24 * BLOCK_WORD_NUMBER);                         \
	invert_last_round_8Block(xmm4, xmm5, xmm6, xmm7, kp - 25 * BLOCK_WORD_NUMBER);			                                  \
	output_##n##Blocks(xmm4, xmm5, xmm6, xmm7, out);											                              \
}
#endif

#if (EI==AVX)

/** @brief 将 16 个分组进行重组，使得 16 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_epi64\\32\\16 来实现，考虑到加密的输出要按输入的顺序存放，
 *  故 16 个分组的各行在寄存器中也是有序的。
 *  @note  由于 AVX 指令操作 256-比特寄存器，但是 高128-比特 和 低128-比特不会跨越，会独立的进行操作。
 *         即：各分组在 256-比特寄存器中并不是完全有序的，但这并不影响操作，在输出重组后会重新有序。
 *
 *  @note  在进行 15 ~ 9 个分组的重组时，使用相同的一串指令。这与使用 SSE 指令时稍有不同。
 *         在使用 SSE 指令时，重组较少的分组时，可以节省一部分指令。所以重组 8、7、6、5、4、3、2 个分组的代码均不同。
 *         但是在使用 AVX 指令时，由于上面的原因，即：
 *         AVX 指令操作 256-比特寄存器，但是 高128-比特 和 低128-比特不会跨越，会独立的进行操作。
 *         而进行 15 ~ 9 个分组的重组时，低 128-比特 是占满的，所以不能再重组 16 个分组的指令序列基础上减少。
 *         所以，重组 16 ~ 9 个分组使用相同的一串指令序列。
 *
 *  @param [out] x0 存放 16 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 16 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 16 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 16 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_unpack_16Blocks(x0, x1, x2, x3)							                                                      \
{																		                                                      \
	ymm02 = _mm256_unpacklo_epi64(ymm01, ymm23);					                                                          \
	ymm13 = _mm256_unpackhi_epi64(ymm01, ymm23);					                                                          \
	ymm01 = _mm256_unpacklo_epi16(ymm02, ymm13);					                                                          \
	ymm23 = _mm256_unpackhi_epi16(ymm02, ymm13);					                                                          \
	ymm02 = _mm256_unpacklo_epi32(ymm01, ymm23);					                                                          \
	ymm13 = _mm256_unpackhi_epi32(ymm01, ymm23);					                                                          \
	ymm46 = _mm256_unpacklo_epi64(ymm45, ymm67);					                                                          \
	ymm57 = _mm256_unpackhi_epi64(ymm45, ymm67);					                                                          \
	ymm45 = _mm256_unpacklo_epi16(ymm46, ymm57);					                                                          \
	ymm67 = _mm256_unpackhi_epi16(ymm46, ymm57);					                                                          \
	ymm46 = _mm256_unpacklo_epi32(ymm45, ymm67);					                                                          \
	ymm57 = _mm256_unpackhi_epi32(ymm45, ymm67);					                                                          \
	x0    = _mm256_unpacklo_epi64(ymm02, ymm46);					                                                          \
	x1    = _mm256_unpackhi_epi64(ymm02, ymm46);					                                                          \
	x2    = _mm256_unpacklo_epi64(ymm13, ymm57);					                                                          \
	x3    = _mm256_unpackhi_epi64(ymm13, ymm57);					                                                          \
}

/** @brief 从 @a ip 地址开始，将 16 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 16 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45, @a ymm67 中
 *      - 将 16 个分组进行重组，使得 16 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 16 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 16个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 16个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 16个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 16个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_16Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_loadu_si256((__m256i *)(ip + (2 * 32)));		                                                              \
	ymm67 = _mm256_loadu_si256((__m256i *)(ip + (3 * 32)));		                                                              \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 15 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 15 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45, @a ymm67 中
 *      - 将 15 个分组进行重组，使得 15 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 15个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 15 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 15 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 15 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 15 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_15Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_loadu_si256((__m256i *)(ip + (2 * 32)));		                                                              \
	ymm67 = _mm256_maskload_epi64((__int64 *)(ip + (3 * 32)), mask0fff);                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 14 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 14 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45, @a ymm67 中
 *      - 将 14 个分组进行重组，使得 14 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 14 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 14 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 14 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 14 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 14 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_14Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_loadu_si256((__m256i *)(ip + (2 * 32)));		                                                              \
	ymm67 = _mm256_maskload_epi64((__int64 *)(ip + (3 * 32)), mask00ff);                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 13 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 13 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45, @a ymm67 中
 *      - 将 13 个分组进行重组，使得 13 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 13 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 13 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 13 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 13 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 13 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_13Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_loadu_si256((__m256i *)(ip + (2 * 32)));		                                                              \
	ymm67 = _mm256_maskload_epi64((__int64 *)(ip + (3 * 32)), mask000f);                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 12 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 12 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45 中, 将 @a ymm67 寄存器置零
 *      - 将 12 个分组进行重组，使得 12 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 12 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 12 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 12 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 12 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 12 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_12Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_loadu_si256((__m256i *)(ip + (2 * 32)));		                                                              \
	ymm67 = _mm256_setzero_si256();		                                                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 11 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 11 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45 中, 将 @a ymm67 寄存器置零
 *      - 将 11 个分组进行重组，使得 11 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 11 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 11 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 11 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 11 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 11 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_11Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_maskload_epi64((__int64 *)(ip + (2 * 32)), mask0fff);                                                      \
	ymm67 = _mm256_setzero_si256();		                                                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 10 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 10 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45 中, 将 @a ymm67 寄存器置零
 *      - 将 10 个分组进行重组，使得 10 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 10 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 10 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 10 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 10 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 10 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_10Blocks(x0, x1, x2, x3, ip)				                                                                      \
{														                                                                      \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_maskload_epi64((__int64 *)(ip + (2 * 32)), mask00ff);                                                      \
	ymm67 = _mm256_setzero_si256();		                                                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
}

/** @brief 从 @a ip 地址开始，将 9 个分组的第0、1、2、3个16-比特字依次装载到 @a x0, @a x1, @a x2, @a x3 中。
 *	
 *  输入需要两个步骤：
 *      - 将 9 个分组按顺序装载在 256 比特寄存器 @a ymm01, @a ymm23, @a ymm45 中, 将 @a ymm67 寄存器置零
 *      - 将 9 个分组进行重组，使得 9 个分组的第0、1、2、3个16-比特字分别存放在到 @a x0, @a x1, @a x2, @a x3 中。
 *
 *  @param [ in] ip 9 个8-字节分组在内存中的输入起始地址
 *  @param [out] x0 存放 9 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [out] x1 存放 9 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [out] x2 存放 9 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [out] x3 存放 9 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define input_9Blocks(x0, x1, x2, x3, ip)                                                                                     \
{                                                                                                                             \
	ymm01 = _mm256_loadu_si256((__m256i *)(ip + (0 * 32)));		                                                              \
	ymm23 = _mm256_loadu_si256((__m256i *)(ip + (1 * 32)));		                                                              \
	ymm45 = _mm256_maskload_epi64((__int64 *)(ip + (2 * 32)), mask000f);                                                      \
	ymm67 = _mm256_setzero_si256();		                                                                                      \
	input_unpack_16Blocks(x0, x1, x2, x3)                                                                                     \
};

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 16 个分组的第0、1、2、3个16-比特字
 *         进行重组，重组为连续的 16 个输出分组放到 @a x0, @a x1, @a x2, @a x3 中。
 *  
 *  分组的重组使用 unpacklo\\hi_32\\16 来实现
 *
 *  @note  在进行 15 ~ 9 个分组的重组时，使用相同的一串指令。这与使用 SSE 指令时稍有不同。
 *         在使用 SSE 指令时，重组较少的分组时，可以节省一部分指令。所以重组 8、7、6、5、4、3、2 个分组的代码均不同。
 *         但是在使用 AVX 指令时，由于上面的原因，即：
 *         AVX 指令操作 256-比特寄存器，但是 高128-比特 和 低128-比特不会跨越，会独立的进行操作。
 *         而进行 15 ~ 9 个分组的重组时，低 128-比特 是占满的，所以不能再重组 16 个分组的指令序列基础上减少。
 *         所以，重组 16 ~ 9 个分组使用相同的一串指令序列。
 *
 *  @param [in,out] x0 存放 16 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [in,out] x1 存放 16 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [in,out] x2 存放 16 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [in,out] x3 存放 16 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 */
#define output_unpack_16Blocks(x0, x1, x2, x3)							                                                      \
{																		                                                      \
	ymm01 = _mm256_unpacklo_epi16(x0, x1);			                                                                          \
	ymm45 = _mm256_unpackhi_epi16(x0, x1);			                                                                          \
	ymm23 = _mm256_unpacklo_epi16(x2, x3);			                                                                          \
	ymm67 = _mm256_unpackhi_epi16(x2, x3);			                                                                          \
	x0    = _mm256_unpacklo_epi32(ymm01, ymm23);			                                                                  \
	x1    = _mm256_unpackhi_epi32(ymm01, ymm23);			                                                                  \
	x2    = _mm256_unpacklo_epi32(ymm45, ymm67);			                                                                  \
	x3    = _mm256_unpackhi_epi32(ymm45, ymm67);			                                                                  \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 16 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 16 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 16 个分组进行重组，使得为连续的 16 个输出分组。
 *      - 将 16 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 16 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 16 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 16 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 16 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 16 个8-字节分组在内存中的输出起始地址
 */
#define output_16Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (2 * 32)), x2);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (3 * 32)), x3);	                                                                  \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 15 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 15 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 15 个分组进行重组，使得为连续的 15 个输出分组。
 *      - 将 15 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 15 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 15 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 15 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 15 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 15 个8-字节分组在内存中的输出起始地址
 */
#define output_15Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (2 * 32)), x2);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (3 * 32)), mask0fff, x3);                                                        \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 14 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 14 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 14 个分组进行重组，使得为连续的 14 个输出分组。
 *      - 将 14 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 14 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 14 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 14 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 14 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 14 个8-字节分组在内存中的输出起始地址
 */
#define output_14Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (2 * 32)), x2);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (3 * 32)), mask00ff, x3);                                                        \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 13 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 13 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 13 个分组进行重组，使得为连续的 13 个输出分组。
 *      - 将 13 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 13 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 13 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 13 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 13 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 13 个8-字节分组在内存中的输出起始地址
 */
#define output_13Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (2 * 32)), x2);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (3 * 32)), mask000f, x3);                                                        \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 12 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 12 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 12 个分组进行重组，使得为连续的 12 个输出分组。
 *      - 将 12 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 12 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 12 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 12 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 12 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 12 个8-字节分组在内存中的输出起始地址
 */
#define output_12Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (2 * 32)), x2);	                                                                  \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 11 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 11 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 11 个分组进行重组，使得为连续的 11 个输出分组。
 *      - 将 11 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 11 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 11 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 11 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 11 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 11 个8-字节分组在内存中的输出起始地址
 */
#define output_11Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (2 * 32)), mask0fff, x2);                                                        \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 10 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 10 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 10 个分组进行重组，使得为连续的 10 个输出分组。
 *      - 将 10 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 10 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 10 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 10 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 10 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 10 个8-字节分组在内存中的输出起始地址
 */
#define output_10Blocks(x0, x1, x2, x3, op)		                                                                              \
{												                                                                              \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (2 * 32)), mask00ff, x2);                                                        \
}

/** @brief 将 @a x0, @a x1, @a x2, @a x3 中所保持的 9 个分组的第0、1、2、3个16-比特字
 *  进行重组，重组为连续的 9 个输出分组，依次存储到从 @a op 开始的输出地址上。
 *	
 *  输出需要两个步骤：
 *      - 将存放在到 @a x0, @a x1, @a x2, @a x3 中的 9 个分组进行重组，使得为连续的 9 个输出分组。
 *      - 将 9 个分组按顺序存储在从 @a op 开始的输出地址上
 *
 *  @param [ in] x0 存放 9 个RECTANGLE状态矩阵的第 0 行的 256-比特寄存器
 *  @param [ in] x1 存放 9 个RECTANGLE状态矩阵的第 1 行的 256-比特寄存器
 *  @param [ in] x2 存放 9 个RECTANGLE状态矩阵的第 2 行的 256-比特寄存器
 *  @param [ in] x3 存放 9 个RECTANGLE状态矩阵的第 3 行的 256-比特寄存器
 *  @param [out] op 9 个8-字节分组在内存中的输出起始地址
 */
#define output_9Blocks(x0, x1, x2, x3, op)                                                                                    \
{                                                                                                                             \
	output_unpack_16Blocks(x0, x1, x2, x3)                                                                                    \
	_mm256_storeu_si256((__m256i *)(op + (0 * 32)), x0);	                                                                  \
	_mm256_storeu_si256((__m256i *)(op + (1 * 32)), x1);	                                                                  \
	_mm256_maskstore_epi64((__int64 *) (op + (2 * 32)), mask000f, x2);                                                        \
};

/** @brief RECTANGLE加密算法的S盒层（SubColumn）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序生成。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a S盒第 0 个比特位置的输入，即RECTANGLE的 16 个密码状态的第 0 行作为输入
 *  @param [ in] b S盒第 1 个比特位置的输入，即RECTANGLE的 16 个密码状态的第 1 行作为输入
 *  @param [ in] c S盒第 2 个比特位置的输入，即RECTANGLE的 16 个密码状态的第 2 行作为输入
 *  @param [ in] d S盒第 3 个比特位置的输入，即RECTANGLE的 16 个密码状态的第 3 行作为输入
 *  @param [out] e S盒第 0 个比特位置的输出，即RECTANGLE的 16 个密码状态的第 0 行作为输出
 *  @param [out] f S盒第 1 个比特位置的输出，即RECTANGLE的 16 个密码状态的第 1 行作为输出
 *  @param [out] g S盒第 2 个比特位置的输出，即RECTANGLE的 16 个密码状态的第 2 行作为输出
 *  @param [out] h S盒第 3 个比特位置的输出，即RECTANGLE的 16 个密码状态的第 3 行作为输出
 */
#define forward_sbox_16Block(a, b, c, d, e, f, g, h)                                                                          \
	{ 												                                                                          \
	smm1  = _mm256_xor_si256(    b, all1_si256 );                                                                             \
	smm2  = _mm256_or_si256 (    d,       smm1 );                                                                             \
	smm3  = _mm256_xor_si256(    a,       smm2 );                                                                             \
	f     = _mm256_xor_si256(    c,       smm3 );                                                                             \
	smm5  = _mm256_and_si256(    a,       smm1 );                                                                             \
	smm6  = _mm256_xor_si256(    c,          d );                                                                             \
	e     = _mm256_xor_si256( smm5,       smm6 );                                                                             \
	smm8  = _mm256_xor_si256(    b,          c );                                                                             \
	smm9  = _mm256_and_si256( smm3,       smm6 );                                                                             \
	h     = _mm256_xor_si256( smm8,       smm9 );                                                                             \
	smm11 = _mm256_or_si256 (    e,       smm8 );                                                                             \
	g     = _mm256_xor_si256( smm3,       smm11);                                                                             \
};

/** @brief RECTANGLE加密算法的P置换层（ShiftRow）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *
 *  在AVX指令集中，add 指令较 slli 指令的延迟短，吞吐量大，故使用 add(x,x) 来实现左移1位：slli(x,1)
 *
 *  @param [in,out] x0 ShiftRow第 0 行的输入，并在原地执行循环左       0 位，得到第 0 行的输出
 *  @param [in,out] x1 ShiftRow第 1 行的输入，并在原地执行循环左 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 ShiftRow第 2 行的输入，并在原地执行循环左 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 ShiftRow第 3 行的输入，并在原地执行循环左 ROL16_3 位，得到第 3 行的输出
 */
#define forward_permutation_16Block(x0, x1, x2, x3)                                                                           \
	{                                                                                                                         \
	x1 = _mm256_or_si256(_mm256_add_epi16 (x1,      x1), _mm256_srli_epi16(x1, 16 - ROL16_1));                                \
	x2 = _mm256_or_si256(_mm256_slli_epi16(x2, ROL16_2), _mm256_srli_epi16(x2, 16 - ROL16_2));                                \
	x3 = _mm256_or_si256(_mm256_slli_epi16(x3, ROL16_3), _mm256_srli_epi16(x3, 16 - ROL16_3));                                \
};

/** @brief RECTANGLE加密算法的轮密钥加（AddRoundKey）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 * 
 *  要首先广播每一行的密钥：_mm256_set1_epi16。
 *
 *  @param [in,out] x0 RECTANGLE状态矩阵的第 0 行，并在原地执行密钥加，得到第 0 行的输出
 *  @param [in,out] x1 RECTANGLE状态矩阵的第 1 行，并在原地执行密钥加，得到第 1 行的输出
 *  @param [in,out] x2 RECTANGLE状态矩阵的第 2 行，并在原地执行密钥加，得到第 2 行的输出
 *  @param [in,out] x3 RECTANGLE状态矩阵的第 3 行，并在原地执行密钥加，得到第 3 行的输出
 *  @param [    in] kp 轮子密钥在内存中的起始地址
 */
#define forward_keyxor_16Block(x0, x1, x2, x3, kp)                                                                            \
	{                                                                                                                         \
	lmm0 = _mm256_set1_epi16((kp)[0]);                                                                                        \
	lmm1 = _mm256_set1_epi16((kp)[1]);                                                                                        \
	lmm2 = _mm256_set1_epi16((kp)[2]);                                                                                        \
	lmm3 = _mm256_set1_epi16((kp)[3]);                                                                                        \
	x0   = _mm256_xor_si256(x0, lmm0);	                                                                                      \
	x1   = _mm256_xor_si256(x1, lmm1);	                                                                                      \
	x2   = _mm256_xor_si256(x2, lmm2);	                                                                                      \
	x3   = _mm256_xor_si256(x3, lmm3);	                                                                                      \
}

/** @brief RECTANGLE加密算法的轮函数使用 AVX 指令，并行处理 @a n 个分组，
 *         其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 *
 *  RECTANGLE加密算法的轮函数是依次执行以下变换:
 *      - AddRoundKey   对应于forward_keyxor_16Block()
 *      - SubColumn     对应于forward_sbox_16Block()
 *      - ShiftRow      对应于forward_permutation_16Block()
 *
 *  @param [ in] a  一轮 16 个密码状态的第 0 行输入
 *  @param [ in] b  一轮 16 个密码状态的第 1 行输入
 *  @param [ in] c  一轮 16 个密码状态的第 2 行输入
 *  @param [ in] d  一轮 16 个密码状态的第 3 行输入
 *  @param [out] e  一轮 16 个密码状态的第 0 行输出
 *  @param [out] f  一轮 16 个密码状态的第 1 行输出
 *  @param [out] g  一轮 16 个密码状态的第 2 行输出
 *  @param [out] h  一轮 16 个密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define forward_round_16Block(a, b, c, d, e, f, g, h, kp)                                                                     \
	{                                                                                                                         \
	forward_keyxor_16Block(a, b, c, d, kp);                                                                                   \
	forward_sbox_16Block(a, b, c, d, e, f, g, h);                                                                             \
	forward_permutation_16Block(e, f, g, h);                                                                                  \
}

/** @brief RECTANGLE加密算法的最后一轮密钥加，并行处理 @a n 个分组，
 *         其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 *
 *  RECTANGLE加密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮 16 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮 16 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮 16 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮 16 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define forward_last_round_16Block(a, b, c, d, kp)   forward_keyxor_16Block(a, b, c, d, kp);

/** @brief RECTANGLE加密算法加密 @a n 个分组，其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 *
 *  RECTANGLE加密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现展开全部轮函数，避免变量的赋值。其中：
 *
 *  - @a ymm0  一轮 @a n 个密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm1  一轮 @a n 个密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm2  一轮 @a n 个密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm3  一轮 @a n 个密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm4  一轮 @a n 个密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm5  一轮 @a n 个密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm6  一轮 @a n 个密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm7  一轮 @a n 个密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入 @a n 个分组的起始地址
 *  - @a out 输出 @a n 分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
 *
 *  @param   [in] n 分组的个数，其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中
 */
#define encrypt_16Blocks(n)                                                                                                   \
{                                                                                                                             \
	input_##n##Blocks(ymm0, ymm1, ymm2, ymm3, in);											                                  \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  0 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  1 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  2 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  3 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  4 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  5 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  6 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  7 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  8 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  9 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 10 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 11 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 12 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 13 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 14 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 15 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 16 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 17 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 18 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 19 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 20 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 21 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 22 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp + 23 * BLOCK_WORD_NUMBER);                       \
	forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp + 24 * BLOCK_WORD_NUMBER);                       \
	forward_last_round_16Block(ymm4, ymm5, ymm6, ymm7, kp + 25 * BLOCK_WORD_NUMBER);			                              \
	output_##n##Blocks(ymm4, ymm5, ymm6, ymm7, out);											                              \
}

/** @brief RECTANGLE加密 @a n 个分组指定轮数，其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中
 *
 *  执行 @a rn 个相同的加密轮函数（除轮密钥不同），没有最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现 2 轮展开，避免变量的赋值。其中：
 *
 *  - @a xmm0  一轮 @a n 密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm1  一轮 @a n 密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm2  一轮 @a n 密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm3  一轮 @a n 密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a xmm4  一轮 @a n 密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm5  一轮 @a n 密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm6  一轮 @a n 密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a xmm7  一轮 @a n 密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a in  输入分组的起始地址
 *  - @a out 输出分组的起始地址
 *  - @a kp  扩展密钥在内存中的起始地址
 *
 *  @param   [in] n  分组的个数，其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中
 *  @param   [in] rn 所指定的轮数
 */
#define encrypt_16Blocks_variousRound(n, rn)																			      \
{																														      \
	input_##n##Blocks(ymm0, ymm1, ymm2, ymm3, in);																		      \
	int even_rn = (rn)>>1;																								      \
	int last_rn = (rn)&1;																								      \
	int ri = 0;																											      \
	for (ri = 0; ri < even_rn; ri++)																					      \
	{																													      \
	    forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);       \
	    forward_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp +  ((ri<<1) + 1) * BLOCK_WORD_NUMBER);       \
	}																													      \
	if (1 == last_rn)																									      \
	{																													      \
		forward_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp +  ((ri<<1) + 0) * BLOCK_WORD_NUMBER);       \
		output_##n##Blocks(ymm4, ymm5, ymm6, ymm7, out);											                          \
	}																													      \
	else																												      \
	{																													      \
		output_##n##Blocks(ymm0, ymm1, ymm2, ymm3, out);											                          \
	}																													      \
}

/** @brief RECTANGLE解密算法的S盒层（inverse SubColumn）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *
 *  这个指令序列由Gladman早在1998年优化实现Serpent的S盒指令执行序列时就公布的一个C语言程序的一个扩展版本生成。
 *  由于 SSE 和 AVX 指令集中包含 andnot 指令，这个实现中加入可以使用这个指令。
 *  经过实际的测试，在若干个相同长度(12 个项)的指令序列中，这一序列的执行时间最低。
 *  @see http://www.gladman.me.uk/
 * 
 *  @param [ in] a 逆S盒第 0 个比特位置的输入，即RECTANGLE密码状态的第 0 行作为输入
 *  @param [ in] b 逆S盒第 1 个比特位置的输入，即RECTANGLE密码状态的第 1 行作为输入
 *  @param [ in] c 逆S盒第 2 个比特位置的输入，即RECTANGLE密码状态的第 2 行作为输入
 *  @param [ in] d 逆S盒第 3 个比特位置的输入，即RECTANGLE密码状态的第 3 行作为输入
 *  @param [out] e 逆S盒第 0 个比特位置的输出，即RECTANGLE密码状态的第 0 行作为输出
 *  @param [out] f 逆S盒第 1 个比特位置的输出，即RECTANGLE密码状态的第 1 行作为输出
 *  @param [out] g 逆S盒第 2 个比特位置的输出，即RECTANGLE密码状态的第 2 行作为输出
 *  @param [out] h 逆S盒第 3 个比特位置的输出，即RECTANGLE密码状态的第 3 行作为输出
 */
#define invert_sbox_16Block(a, b, c, d, e, f, g, h)                                                                           \
{                                                                                                                             \
	smm1 = _mm256_or_si256    (   a,          d );                                                                            \
	smm2 = _mm256_xor_si256   (   a,          d );                                                                            \
	smm3 = _mm256_andnot_si256(   c,          a );                                                                            \
	smm4 = _mm256_xor_si256   (   c,       smm1 );                                                                            \
	g    = _mm256_xor_si256   (   b,       smm4 );                                                                            \
	smm6 = _mm256_xor_si256   (smm4, all1_si256 );                                                                            \
	smm7 = _mm256_xor_si256   (   d,          g );                                                                            \
	f    = _mm256_xor_si256   (smm3,       smm7 );                                                                            \
	smm9 = _mm256_or_si256    (smm6,       smm7 );                                                                            \
	h    = _mm256_xor_si256   (smm2,       smm9 );                                                                            \
	smm11= _mm256_andnot_si256(   h,          f );                                                                            \
	e    = _mm256_xor_si256   (smm6,       smm11);                                                                            \
};

/** @brief RECTANGLE解密算法的P置换层（inverse ShiftRow）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *
 *  考虑到 x64 平台一个时钟周期内可以并行运行无依赖的指令，
 *  故这里将最后一行循环右移 13 位通过循环左移 3 位来实现。而循环左移 3 位通过 add(x,x) 来实现。
 *  虽然看上去所需的指令增加了，但是由于将 add 指令穿插在之前的 srl 和 sll 指令直接，可以有利于并行。
 *  从而节省所需的CPU周期数。
 *
 *  @param [in,out] x0 inverse ShiftRow第 0 行的输入，并在原地执行循环右       0 位，得到第 0 行的输出
 *  @param [in,out] x1 inverse ShiftRow第 1 行的输入，并在原地执行循环右 ROL16_1 位，得到第 1 行的输出
 *  @param [in,out] x2 inverse ShiftRow第 2 行的输入，并在原地执行循环右 ROL16_2 位，得到第 2 行的输出
 *  @param [in,out] x3 inverse ShiftRow第 3 行的输入，并在原地执行循环右 ROL16_3 位，得到第 3 行的输出
 */
#define invert_permutation_16Block(x0, x1, x2, x3)                                                                            \
{                                                                                                                             \
	smm1 = _mm256_srli_epi16(   x1,      ROL16_1 );                                                                           \
	smm2 = _mm256_slli_epi16(   x1, 16 - ROL16_1 );                                                                           \
	smm3 = _mm256_add_epi16 (   x3,           x3 );                                                                           \
	x1   = _mm256_or_si256  ( smm1,         smm2 );                                                                           \
	smm1 = _mm256_srli_epi16(   x2,      ROL16_2 );                                                                           \
	smm2 = _mm256_slli_epi16(   x2, 16 - ROL16_2 );                                                                           \
	smm3 = _mm256_add_epi16 ( smm3,         smm3 );                                                                           \
	x3   = _mm256_srli_epi16(   x3,      ROL16_3 );                                                                           \
	smm3 = _mm256_add_epi16 ( smm3,         smm3 );                                                                           \
	x2   = _mm256_or_si256  ( smm1,         smm2 );                                                                           \
	x3   = _mm256_or_si256  (   x3,         smm3 );                                                                           \
};

/** @brief RECTANGLE解密算法的轮密钥加（inverse AddRoundKey）使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *  
 *  与RECTANGLE加密算法的轮密钥加相同。
 *  @param [in,out] x0 一轮 16 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] x1 一轮 16 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] x2 一轮 16 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] x3 一轮 16 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define invert_keyxor_16Block(x0, x1, x2, x3, kp) forward_keyxor_16Block(x0, x1, x2, x3, kp)

/** @brief RECTANGLE解密算法的轮函数使用 AVX 指令进行比特切片实现的指令序列，
 *         并行处理 @a n 个分组，其中 @ a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9}中。
 *
 *  RECTANGLE解密算法的轮函数是依次执行以下变换:
 *      - inverse AddRoundKey   对应于invert_keyxor_16Block()
 *      - inverse ShiftRow      对应于invert_permutation_16Block()
 *      - inverse SubColumn     对应于invert_sbox_16Block()
 *
 *  @param [ in] a  一轮 16 个密码状态的第 0 行输入
 *  @param [ in] b  一轮 16 个密码状态的第 1 行输入
 *  @param [ in] c  一轮 16 个密码状态的第 2 行输入
 *  @param [ in] d  一轮 16 个密码状态的第 3 行输入
 *  @param [out] e  一轮 16 个密码状态的第 0 行输出
 *  @param [out] f  一轮 16 个密码状态的第 1 行输出
 *  @param [out] g  一轮 16 个密码状态的第 2 行输出
 *  @param [out] h  一轮 16 个密码状态的第 3 行输出
 *  @param [ in] kp 轮子密钥在内存中的起始地址
 */
#define invert_round_16Block(a, b, c, d, e, f, g, h, kp)                                                                      \
{                                                                                                                             \
	invert_keyxor_16Block(a, b, c, d, kp);                                                                                    \
	invert_permutation_16Block(a, b, c, d);                                                                                   \
	invert_sbox_16Block(a, b, c, d, e, f, g, h);                                                                              \
}

/** @brief RECTANGLE解密算法的最后一轮密钥加，并行处理 @a n 个分组,
 *         其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 *
 *  RECTANGLE解密算法的最后再次执行 AddRoundKey
 *
 *  @param [in,out] a  一轮 16 个密码状态的第 0 行输入，经过原地的与轮子密钥异或得到第 0 行输出
 *  @param [in,out] b  一轮 16 个密码状态的第 1 行输入，经过原地的与轮子密钥异或得到第 1 行输出
 *  @param [in,out] c  一轮 16 个密码状态的第 2 行输入，经过原地的与轮子密钥异或得到第 2 行输出
 *  @param [in,out] d  一轮 16 个密码状态的第 3 行输入，经过原地的与轮子密钥异或得到第 3 行输出
 *  @param [    in] kp 最后一轮子密钥在内存中的起始地址
 */
#define invert_last_round_16Block(a, b, c, d, kp)   invert_keyxor_16Block(a, b, c, d, kp);

/** @brief RECTANGLE解密算法解密 @a n 个分组，其中 @ n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 *
 *  RECTANGLE的解密算法共包含 25 个相同的轮函数（除轮密钥不同），以及最后一轮密钥加。
 *  考虑到x64平台指令缓存较大，本实现全轮展开，避免变量的赋值。其中：

 *  - @a ymm0  一轮 @a n 个密码状态的第 0 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm1  一轮 @a n 个密码状态的第 1 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm2  一轮 @a n 个密码状态的第 2 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm3  一轮 @a n 个密码状态的第 3 行输入（偶数轮）或输出（奇数轮）
 *  - @a ymm4  一轮 @a n 个密码状态的第 0 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm5  一轮 @a n 个密码状态的第 1 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm6  一轮 @a n 个密码状态的第 2 行输入（奇数轮）或输出（偶数轮）
 *  - @a ymm7  一轮 @a n 个密码状态的第 3 行输入（奇数轮）或输出（偶数轮）
 *  - @a   in  输入分组的起始地址
 *  - @a  out  输出分组的起始地址
 *  - @a   kp  扩展密钥在内存中的终止地址
 * 
 *  @param [ in] n 处理的分组个数，其中 @a n 在集合 {16, 15, 14, 13, 12, 11, 10, 9} 中。
 */ 
#define decrypt_16Blocks(n)                                                                                                   \
{                                                                                                                             \
	input_##n##Blocks(ymm0, ymm1, ymm2, ymm3, in);											                                  \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp -  0 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp -  1 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp -  2 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp -  3 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp -  4 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp -  5 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp -  6 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp -  7 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp -  8 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp -  9 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 10 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 11 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 12 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 13 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 14 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 15 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 16 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 17 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 18 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 19 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 20 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 21 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 22 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm4, ymm5, ymm6, ymm7, ymm0, ymm1, ymm2, ymm3, kp - 23 * BLOCK_WORD_NUMBER);                        \
	invert_round_16Block(ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7, kp - 24 * BLOCK_WORD_NUMBER);                        \
	invert_last_round_16Block(ymm4, ymm5, ymm6, ymm7, kp - 25 * BLOCK_WORD_NUMBER);			                                  \
	output_##n##Blocks(ymm4, ymm5, ymm6, ymm7, out);											                              \
}
#endif

#if (EI==GEN)
/**
 * 对给定个数的数据块使用通用指令集进行加密
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void encrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < dataLengthInBlock; di++)
	{
		encrypt_1Block;
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
}

/**
 * 对给定个数的数据块使用通用指令集进行解密
 *
 * @param  [ in] in                 待解密数据块的首地址
 * @param  [out] out                解密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待解密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void decrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = ((u16 *)Key) + ROUND_NUMBER * BLOCK_WORD_NUMBER;

	u64 di;
	for (di = 0; di < (dataLengthInBlock); di++)
	{
		decrypt_1Block;
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
}
 
/**
 * 对给定个数的数据块使用通用指令集进行加密指定轮数
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 * @param  [ in] CryptRound         加密轮数
 */
inline void encrypt_variousRound(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key, int CryptRound)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < dataLengthInBlock; di++)
	{
		encrypt_1Block_variousRound(CryptRound);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
}

#elif (EI==SSE)
/**
 * 对给定个数的数据块使用 通用指令集 和 SSE指令集 进行加密
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void encrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>3); di++)
	{
		encrypt_8Blocks(8);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	// switch(dataLengthInBlock&0x7)
	// {
	// case 0: break;
	// case 1: encrypt_1Block; break;
	// case 2: encrypt_8Blocks(2); break;
	// case 3: encrypt_8Blocks(3); break;
	// case 4: encrypt_8Blocks(4); break;
	// case 5: encrypt_8Blocks(5); break;
	// case 6: encrypt_8Blocks(6); break;
	// case 7: encrypt_8Blocks(7); break;
	// }
}

/**
 * 对给定个数的数据块使用 通用指令集 和 SSE指令集 进行解密
 *
 * @param  [ in] in                 待解密数据块的首地址
 * @param  [out] out                解密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待解密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void decrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = ((u16 *)Key) + ROUND_NUMBER * BLOCK_WORD_NUMBER;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>3); di++)
	{
		decrypt_8Blocks(8);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	// switch(dataLengthInBlock&0x7)
	// {
	// case 0: break;
	// case 1: decrypt_1Block; break;
	// case 2: decrypt_8Blocks(2); break;
	// case 3: decrypt_8Blocks(3); break;
	// case 4: decrypt_8Blocks(4); break;
	// case 5: decrypt_8Blocks(5); break;
	// case 6: decrypt_8Blocks(6); break;
	// case 7: decrypt_8Blocks(7); break;
	// }
}

/**
 * 对给定个数的数据块使用 通用指令集 和 SSE指令集 进行加密指定轮数
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 * @param  [ in] CryptRound         加密轮数
 */
inline void encrypt_variousRound(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key, int CryptRound)
{
	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>3); di++)
	{
		encrypt_8Blocks_variousRound(8,CryptRound);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	// switch(dataLengthInBlock&0x7)
	// {
	// case 0: break;
	// case 1: encrypt_1Block_variousRound(CryptRound); break;
	// case 2: encrypt_8Blocks_variousRound(2, CryptRound); break;
	// case 3: encrypt_8Blocks_variousRound(3, CryptRound); break;
	// case 4: encrypt_8Blocks_variousRound(4, CryptRound); break;
	// case 5: encrypt_8Blocks_variousRound(5, CryptRound); break;
	// case 6: encrypt_8Blocks_variousRound(6, CryptRound); break;
	// case 7: encrypt_8Blocks_variousRound(7, CryptRound); break;
	// }
}

#elif (EI==AVX)
/**
 * 对给定个数的数据块使用 通用指令集、SSE指令集和 AVX指令集 进行加密
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void encrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	__m256i ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7;
	__m256i ymm01, ymm13, ymm02, ymm23, ymm45, ymm57, ymm46, ymm67;
	__m256i lmm0, lmm1, lmm2, lmm3;
	__m256i smm0, smm1, smm2, smm3, smm4, smm5, smm6, smm7, smm8, smm9, smm10, smm11;

	__m256i all1_si256 = _mm256_set1_epi16(0xffff);
	__m256i   mask0fff = _mm256_set_epi64x(0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask00ff = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask000f = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL);

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>4); di++)
	{
		encrypt_16Blocks(16);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	switch(dataLengthInBlock&0xf)
	{
	case  0: break;
	case  1: encrypt_1Block; break;
	case  2: encrypt_8Blocks  (2); break;
	case  3: encrypt_8Blocks  (3); break;
	case  4: encrypt_8Blocks  (4); break;
	case  5: encrypt_8Blocks  (5); break;
	case  6: encrypt_8Blocks  (6); break;
	case  7: encrypt_8Blocks  (7); break;
	case  8: encrypt_8Blocks  (8); break;
	case  9: encrypt_16Blocks (9); break;
	case 10: encrypt_16Blocks(10); break;
	case 11: encrypt_16Blocks(11); break;
	case 12: encrypt_16Blocks(12); break;
	case 13: encrypt_16Blocks(13); break;
	case 14: encrypt_16Blocks(14); break;
	case 15: encrypt_16Blocks(15); break;
	}
}

/**
 * 对给定个数的数据块使用 通用指令集、SSE指令集和 AVX指令集 进行解密
 *
 * @param  [ in] in                 待解密数据块的首地址
 * @param  [out] out                解密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待解密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 */
inline void decrypt(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	__m256i ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7;
	__m256i ymm01, ymm13, ymm02, ymm23, ymm45, ymm57, ymm46, ymm67;
	__m256i lmm0, lmm1, lmm2, lmm3;
	__m256i smm0, smm1, smm2, smm3, smm4, smm5, smm6, smm7, smm8, smm9, smm10, smm11;

	__m256i all1_si256 = _mm256_set1_epi16(0xffff);
	__m256i   mask0fff = _mm256_set_epi64x(0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask00ff = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask000f = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL);

	u16 *kp = ((u16 *)Key) + ROUND_NUMBER * BLOCK_WORD_NUMBER;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>4); di++)
	{
		decrypt_16Blocks(16);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	switch(dataLengthInBlock&0xf)
	{
	case  0: break;
	case  1: decrypt_1Block; break;
	case  2: decrypt_8Blocks  (2); break;
	case  3: decrypt_8Blocks  (3); break;
	case  4: decrypt_8Blocks  (4); break;
	case  5: decrypt_8Blocks  (5); break;
	case  6: decrypt_8Blocks  (6); break;
	case  7: decrypt_8Blocks  (7); break;
	case  8: decrypt_8Blocks  (8); break;
	case  9: decrypt_16Blocks (9); break;
	case 10: decrypt_16Blocks(10); break;
	case 11: decrypt_16Blocks(11); break;
	case 12: decrypt_16Blocks(12); break;
	case 13: decrypt_16Blocks(13); break;
	case 14: decrypt_16Blocks(14); break;
	case 15: decrypt_16Blocks(15); break;
	}
}

/**
 * 对给定个数的数据块使用 通用指令集、SSE指令集和 AVX指令集 进行加密指定轮数
 *
 * @param  [ in] in                 待加密数据块的首地址
 * @param  [out] out                加密后的数据块被存放的首地址
 * @param  [ in] dataLengthInBlock  待加密数据长度（以分组个数计）
 * @param  [ in] Key                扩展好的密钥
 * @param  [ in] CryptRound         加密轮数
 */
inline void encrypt_variousRound(u8 *in, u8 *out, u64 dataLengthInBlock, u8 *Key, int CryptRound)
{
	u16 r0, r1, r2, r3, r4, r5, r6, r7;
	u16 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11;

	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7;
	__m128i xmm01, xmm13, xmm02, xmm23, xmm45, xmm57, xmm46, xmm67;
	__m128i kmm0, kmm1, kmm2, kmm3;
	__m128i tmm0, tmm1, tmm2, tmm3, tmm4, tmm5, tmm6, tmm7, tmm8, tmm9, tmm10, tmm11;

	__m128i all1 = _mm_set1_epi16(0xffff);

	__m256i ymm0, ymm1, ymm2, ymm3, ymm4, ymm5, ymm6, ymm7;
	__m256i ymm01, ymm13, ymm02, ymm23, ymm45, ymm57, ymm46, ymm67;
	__m256i lmm0, lmm1, lmm2, lmm3;
	__m256i smm0, smm1, smm2, smm3, smm4, smm5, smm6, smm7, smm8, smm9, smm10, smm11;

	__m256i all1_si256 = _mm256_set1_epi16(0xffff);
	__m256i   mask0fff = _mm256_set_epi64x(0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask00ff = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL);
	__m256i   mask000f = _mm256_set_epi64x(0x0000000000000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL, 0xffffffffffffffffULL);

	u16 *kp = (u16 *)Key;

	u64 di;
	for (di = 0; di < (dataLengthInBlock>>4); di++)
	{
		encrypt_16Blocks_variousRound(16, CryptRound);
		in  = in  + ParallelN*BLOCK_BYTE_NUMBER;
		out = out + ParallelN*BLOCK_BYTE_NUMBER;
	}
	switch(dataLengthInBlock&0xf)
	{
	case  0: break;
	case  1: encrypt_1Block_variousRound(CryptRound); break;
	case  2: encrypt_8Blocks_variousRound  (2, CryptRound); break;
	case  3: encrypt_8Blocks_variousRound  (3, CryptRound); break;
	case  4: encrypt_8Blocks_variousRound  (4, CryptRound); break;
	case  5: encrypt_8Blocks_variousRound  (5, CryptRound); break;
	case  6: encrypt_8Blocks_variousRound  (6, CryptRound); break;
	case  7: encrypt_8Blocks_variousRound  (7, CryptRound); break;
	case  8: encrypt_8Blocks_variousRound  (8, CryptRound); break;
	case  9: encrypt_16Blocks_variousRound (9, CryptRound); break;
	case 10: encrypt_16Blocks_variousRound(10, CryptRound); break;
	case 11: encrypt_16Blocks_variousRound(11, CryptRound); break;
	case 12: encrypt_16Blocks_variousRound(12, CryptRound); break;
	case 13: encrypt_16Blocks_variousRound(13, CryptRound); break;
	case 14: encrypt_16Blocks_variousRound(14, CryptRound); break;
	case 15: encrypt_16Blocks_variousRound(15, CryptRound); break;
	}
}

#else
#    error  Should set EI to be GEN, SSE or AVX.
#endif


int Crypt_Enc_Block(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *key,
	int keylen)
{
	encrypt(input, output, in_len>>3, key);
	*out_len = in_len;
	return SUCCESS;
}

int Crypt_Dec_Block(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *key,
	int keylen)
{
	decrypt(input, output, in_len>>3, key);
	*out_len = in_len;
	return SUCCESS;
}

int Crypt_Enc_Block_Round(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *key,
	int keylen,
	int CryptRound)
{
	if ((in_len&(BLOCK_BYTE_NUMBER-1)) != 0)
	{
		printf("消息长度应当是 %d 的倍数（以字节计）;\n", BLOCK_BYTE_NUMBER);
		return FAILURE;
	}

	if (CryptRound > ROUND_NUMBER)
	{
		printf("轮数应当小于总轮数 %d;\n", ROUND_NUMBER);
		return FAILURE;
	}

	encrypt_variousRound(input, output, in_len>>3, key, CryptRound);
	*out_len = in_len;
	return SUCCESS;
}

int rectangle_ecb_enc(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *Seedkey,
	int KeyLen)
{
	if ((in_len&(BLOCK_BYTE_NUMBER-1)) != 0)
	{
		printf("消息长度应当是 %d 的倍数（以字节计）;\n", BLOCK_BYTE_NUMBER);
		return FAILURE;
	}

	ctx_t ctx;
	Key_Schedule(Seedkey, KeyLen, ENC, ctx.key);
	return Crypt_Enc_Block(input, in_len, output, out_len, ctx.key, KeyLen);
}

int rectangle_ecb_dec(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *Seedkey,
	int KeyLen)
{
	if ((in_len&(BLOCK_BYTE_NUMBER-1)) != 0)
	{
		printf("消息长度应当是 %d 的倍数（以字节计）;\n", BLOCK_BYTE_NUMBER);
		return FAILURE;
	}

	ctx_t ctx;
	Key_Schedule(Seedkey, KeyLen, DEC, ctx.key);
	return Crypt_Dec_Block(input, in_len, output, out_len, ctx.key, KeyLen);
}

