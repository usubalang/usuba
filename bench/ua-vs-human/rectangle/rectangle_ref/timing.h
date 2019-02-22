/** @file timing.h
 * @brief 本文件包含对RECTANGLE密码算法的加密、解密、密钥编排算法的速度测试的函数接口。
 *
 * 测试加密、解密、密钥编排执行时间均值和标准差的方法： 进行初始采样1和正式采样2。
 *     - 首先执行初始采样1，得到采样1均值和采样1标准差。
 *     - 随后执行正式采样2，得到正式采样2均值和采样2标准差。
 *       在正式采样2过程中，只有一次采样的时间在采样1均值+/-采样1标准差范围内，才记为一次有效采样。
 *     - 采样2结束后，只有有效采样次数占采样2总采样次数的比例达到 90% 以上，并且采样2标准差小于均值的 10% 时，
 *       才认为时间测试成功，返回 TRUE。若测试不成功，重新采样测量。
 *       若连续测试10次都没有成功则将标准差的可接受限度放低 5%，再次重新采样测量，直到标准差的可接受限度
 *       降到了均值的 30% 时，仍没有测试成功。此时返回FALSE，测试失败。
 *
 * 对处理长消息的时钟周期数均值和标准差的测试比较耗时，因此只包含对处理长消息的最小时钟周期数的测试。
 */
#ifndef TIMING_H__
#define TIMING_H__

#include "rectangle.h"

/**
 * 通过CPUID读取CPU的时间戳：
 *     - 生成随机数时，用以得到每次不一样的种子；
 *     - 测试算法运行时间时，用以得到所消耗的CPU时钟周期数。
 */
#ifdef _MSC_VER
unsigned long CurrentProcessorNumber(void);
/**
 * 通过CPUID读取CPU的时间戳：
 *     - 生成随机数时，用以得到每次不一样的种子；
 *     - 测试算法运行时间时，用以得到所消耗的CPU时钟周期数。
 */
__inline unsigned long long read_tsc(void);
#endif

#ifdef __GNUC__
/**
 * 通过CPUID读取CPU的时间戳：
 *     - 生成随机数时，用以得到每次不一样的种子；
 *     - 测试算法运行时间时，用以得到所消耗的CPU时钟周期数。
 */
inline unsigned long long read_tsc(void);
#endif

/**
 * 将进程绑定到一个 CPU 上，减少测试时间的不准确性。
 */
void setCPUaffinity();

/** @brief 调用伪随机数发生器（PRNG）初始化数据。
 *
 *  @param [out]  buf 待填入随机数据的内存其起始地址
 *  @param [ in]  len 待填入的随机数据长度（以字节计）
 */
void block_rndfill(unsigned char *buf, const int len);


/**
 * 执行速度测试框架所需的基本开销。
 * 需要将正式测试时所得到的时间减去这里所得到的基本时间开销。
 *
 * @param [out]  av       对速度测试框架执行所需的时钟周期数进行采样，得到的平均值
 * @param [out]  sig      对速度测试框架执行所需的时钟周期数进行采样，得到的标准差
 * @return                测试成功返回 TRUE，测试失败返回 FALSE  
 */
int time_base(double *av, double *sig);

/**
 * @brief 用以测试密钥编排的平均执行速度。
 * 
 * 测试执行 8 次密钥编排所需的时钟周期均值和标准差
 *
 * @param [ in]  k_len    密钥的长度（以比特计），对于RECTANGLE此值为 80 或 128
 * @param [out]  av       对执行 8 次密钥编排所需的时钟周期数进行采样，得到的平均值
 * @param [out]  sig      对执行 8 次密钥编排所需的时钟周期数进行采样，得到的标准差
 * @return                测试成功返回 TRUE，测试失败返回 FALSE  
 */
int time_key8(unsigned int k_len, double *av, double *sig);

/**
 * @brief 用以测试加密算法加密指定长度消息的平均执行速度。
 * 
 * 测试执行 16 次加密算法加密指定长度消息所需的时钟周期均值和标准差
 *
 * @param [out]  av                对执行 16 次加密算法所需的时钟周期数进行采样，得到的平均值
 * @param [out]  sig               对执行 16 次加密算法所需的时钟周期数进行采样，得到的标准差
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         测试成功返回 TRUE，测试失败返回 FALSE  
 */
int time_enc16(double *av, double *sig, unsigned long long dataLengthInBytes);

/**
 * @brief 用以测试解密算法解密指定长度消息的平均执行速度。
 * 
 * 测试执行 16 次解密算法解密指定长度消息所需的时钟周期均值和标准差
 *
 * @param [out]  av                对执行 16 次解密算法所需的时钟周期数进行采样，得到的平均值
 * @param [out]  sig               对执行 16 次解密算法所需的时钟周期数进行采样，得到的标准差
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         测试成功返回 TRUE，测试失败返回 FALSE  
 */
int time_dec16(double *av, double *sig, unsigned long long dataLengthInBytes);

/**
 * @brief 用以测试执行密钥编排所需的最小时钟周期数。
 *
 * @param [ in]  k_len 密钥的长度（以比特计），对于RECTANGLE此值为 80 或 128
 * @return             执行所需的最小时钟周期数 
 */
double key_cycles(const unsigned long k_len);

/**
 * @brief 用以测试执行加密算法加密指定长度的短消息所需的最小时钟周期数。
 *
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         执行加密算法加密指定长度的短消息所需的最小时钟周期数 
 */
double enc_cycles(unsigned long long dataLengthInBytes);

/**
 * @brief 用以测试执行解密算法解密指定长度的短消息所需的最小时钟周期数。
 *
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         执行解密算法解密指定长度的短消息所需的最小时钟周期数 
 */
double dec_cycles(unsigned long long dataLengthInBytes);

/**
 * @brief 用以测试执行加密算法加密指定长度的长消息所需的最小时钟周期数。
 *
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         执行加密算法加密指定长度的长消息所需的最小时钟周期数 
 */
double enc_cycles_longMessage(unsigned long long dataLengthInBytes);

/**
 * @brief 用以测试执行解密算法解密指定长度的长消息所需的最小时钟周期数。
 *
 * @param [ in]  dataLengthInBytes 数据的长度（以字节计），对于RECTANGLE此值应为 8 的倍数
 * @return                         执行解密算法解密指定长度的长消息所需的最小时钟周期数
 */
double dec_cycles_longMessage(unsigned long long dataLengthInBytes);

/** @brief 进行时间测试的主函数入口 */
void timing();

#endif  //TIMING_H__