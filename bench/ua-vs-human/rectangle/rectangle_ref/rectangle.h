/** @file rectangle.h
  * @brief 本文件包含RECTANGLE密码算法的参数宏定义、各函数接口。
  */
#ifndef RECTANGLE_H__
#define RECTANGLE_H__

#include "rot.h"

/**
  * @def ROUND_NUMBER
  *                                 正常的轮数，定为25-round
  *	@def BLOCK_BIT_NUMBER
  *                                 分组长度（按比特计算），64比特        	 			   
  *	@def BLOCK_BYTE_NUMBER
  *                                 分组长度（按字节计算），8字节       					
  *	@def BLOCK_WORD_NUMBER
  *                                 分组长度（按字计算），4字（定义字长为16比特
  * @def EXTENDED_KEY_BYTE_NUMBER
  *                                 扩展密钥总长度，包括25轮子密钥和最后一轮的密钥
  */
#define ROUND_NUMBER                25
#define BLOCK_BIT_NUMBER            64
#define BLOCK_BYTE_NUMBER           8
#define BLOCK_WORD_NUMBER           4
#define EXTENDED_KEY_BYTE_NUMBER    ((ROUND_NUMBER+1)*BLOCK_BYTE_NUMBER)


/** 返回状态的枚举类型 */
enum RETURNEnum {
	SUCCESS,   /**< 0为返回成功 */
	FAILURE	   /**< 1为返回失败 */
};

/** 操作方向的枚举类型 */
enum DirectionEnum {
	ENC,  /**< 0为加密 */
	DEC   /**< 1为解密 */
};

/** 
 * 存放加密的上下文，包括密钥的长度，和扩展之后的轮密钥数组
 */
struct ctx_t
{
	/** 密钥长度，以比特计算 */
	int keylen;
	/** 扩展密钥存放在连续的数组当中 */
	unsigned char key[EXTENDED_KEY_BYTE_NUMBER];
};

/**
 * 对给定长度的数据块进行加密
 *
 * @param  [ in] input   待加密数据块的首地址
 * @param  [ in] in_len  待加密数据块长度（以字节计）
 * @param  [ in] key     加密密钥
 * @param  [ in] keylen  加密密钥长度（以字节计）
 * @param  [out] output  加密后的数据块被存放的首地址
 * @param  [out] out_len 加密后数据块的长度（以字节计）
 * @return 若加密成功，则返回0，否则返回非零数
 */
int Crypt_Enc_Block(
	unsigned char *input,
    int in_len,
    unsigned char *output,
    int *out_len,
    unsigned char *key,
    int keylen );

/**
 * 对给定长度的数据块进行解密
 *
 * @param  [ in] input   待解密数据块的首地址
 * @param  [ in] in_len  待解密数据块长度（以字节计）
 * @param  [ in] key     解密密钥
 * @param  [ in] keylen  解密密钥长度（以字节计）
 * @param  [out] output  解密后的数据块被存放的首地址
 * @param  [out] out_len 解密后数据块的长度（以字节计）
 * @return 若加密成功，则返回0，否则返回非零数
 */
int Crypt_Dec_Block(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *key,
	int keylen);

/**
 * 对给定长度的数据块进行特定轮的加密
 *
 * @param  [ in] input       待加密数据块的首地址
 * @param  [ in] in_len      待解密数据块长度（以字节计）
 * @param  [ in] key         解密密钥
 * @param  [ in] keylen      解密密钥长度（以字节计）
 * @param  [ in] CryptRound  加密轮数
 * @param  [out] output      解密后的数据块被存放的首地址
 * @param  [out] out_len     解密后数据块的长度（以字节计）
 * @return 若解密成功，则返回0，否则返回非零数
 */
int Crypt_Enc_Block_Round(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *key,
	int keylen,
	int CryptRound);

/**
 * 密钥编排算法
 *
 * @param  [ in] Seedkey   种子密钥，存储在字节数组中
 * @param  [ in] KeyLen    种子密钥比特长度
 * @param  [ in] Direction 密钥编排的方向，0为加密，1为解密
 * @param  [out] Subkey    产生的子密钥，存储在字节数组中
 */
void Key_Schedule(
	unsigned char *Seedkey, 
	int KeyLen, 
	unsigned char Direction, 
	unsigned char *Subkey);


/**
 * 对给定长度的数据块进行ECB模式加密
 *
 * @param  [ in] input     待加密数据块的首地址
 * @param  [ in] in_len    待加密数据块长度（以字节计）
 * @param  [out] output    加密后的数据块被存放的首地址
 * @param  [out] out_len   加密后数据块的长度（以字节计）
 * @param  [ in] Seedkey   种子密钥，存储在字节数组中
 * @param  [ in] KeyLen    种子密钥比特长度
 * @return 若加密成功，则返回0，否则返回非零数
 */
int rectangle_ecb_enc(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *Seedkey,
	int KeyLen);

/**
 * 对给定长度的数据块进行ECB模式解密
 *
 * @param  [ in] input     待解密数据块的首地址
 * @param  [ in] in_len    待解密数据块长度（以字节计）
 * @param  [out] output    解密后的数据块被存放的首地址
 * @param  [out] out_len   解密后数据块的长度（以字节计）
 * @param  [ in] Seedkey   种子密钥，存储在字节数组中
 * @param  [ in] KeyLen    种子密钥比特长度
 * @return 若加密成功，则返回0，否则返回非零数
 */
int rectangle_ecb_dec(
	unsigned char *input,
	int in_len,
	unsigned char *output,
	int *out_len,
	unsigned char *Seedkey,
	int KeyLen);


#endif //RECTANGLE_H__
