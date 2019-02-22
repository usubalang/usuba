/** @file timing.cpp
 *  @brief 本文件包含对RECTANGLE密码算法的加密、解密、密钥编排算法的速度测试函数定义。
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

#include "timing.h"
#include <sys/types.h>
#include <unistd.h>

using namespace std;

#ifdef _MSC_VER
#define DUAL_CORE

#if defined( DUAL_CORE )
#  define WINDOWS_LEAN_AND_MEAN
#  include <windows.h>
#endif
#include <string.h>
#include <math.h>

#include <intrin.h>
#pragma intrinsic( __rdtsc )

__inline unsigned long long read_tsc(void)
{
	return __rdtsc();
}

#if defined( _M_IX86 )
#if _M_IX86 == 500
#define PROCESSOR   "Pentium"
#elif _M_IX86 == 600
#define PROCESSOR   "P2/P3/P4"
#else
#define PROCESSOR   ""
#endif
#elif defined( _M_X64 )
#define PROCESSOR   "AMD64/EMT64"
#else
#define PROCESSOR   ""
#endif

#if defined( _WIN64 )

#define CurrentProcessorNumber GetCurrentProcessorNumber

#else

unsigned long CurrentProcessorNumber(void)
{
    __asm
    {
        mov     eax,1
        cpuid
        shr     ebx,24
        mov     eax, ebx
    }
}

#endif

void setCPUaffinity()
{
#if defined( DUAL_CORE ) && defined( _WIN32 )
    // 为了获得有效的CPU时钟周期数，需要将进程绑定到一个CPU上
    HANDLE ph;
    DWORD_PTR afp;
    DWORD_PTR afs;
    ph = GetCurrentProcess();
    if(GetProcessAffinityMask(ph, &afp, &afs))
    {
        afp &= (1 << CurrentProcessorNumber());
        if(!SetProcessAffinityMask(ph, afp))
        {
            printf("Couldn't set Process Affinity Mask\n\n");
        }
    }
    else
    {
        printf("Couldn't get Process Affinity Mask\n\n");
    }
#endif
}

#else
#ifdef __GNUC__
#include <sys/resource.h>
#include <x86intrin.h>
inline unsigned long long read_tsc(void)
{
#if defined(__i386__)
	unsigned long long cycles;
	__asm__ volatile (".byte 0x0f, 0x31" : "=A"(cycles));
	return cycles;
#else
#if defined(__x86_64__)
    return _rdtsc();
//	unsigned int hi, lo;
//	__asm__ volatile ("rdtsc" : "a="(lo), "=d"(hi));
//	return (((unsigned long long)lo) | ((unsigned long long)(hi)<<32));
#else
#error "Unsupported architecture for counting cycles"
#endif
#endif
}

void setCPUaffinity()
{
	cpu_set_t cpu_mask;
	CPU_SET(0x1, &cpu_mask);
	if(sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) == -1 )
	{
		printf("Impossible to set CPU affinity...\n");
	}
}
#endif
#endif

/**  @brief 一个伪随机数发生器（PRNG），为了初始化扩展密钥或待加解密的数据。
  *
  *  这个 PRNG 是 George Marsaglia 的带进位乘 PRNG （Multiply-With-Carry (MWC) PRNG）
  *  它串接两个 16-比特的带进位乘生成器（MWC generators）:
  *      x(n)=36969 * x(n-1) + carry mod 2^16
  *      y(n)=18000 * y(n-1) + carry mod 2^16
  *  来得到一个周期大概为 2^60 的 PRNG。
  *  我们使用处理器CPUID读取时间戳来对其初始化。 
  */
#define RAND(a,b) (((a = 36969 * (a & 65535) + (a >> 16)) << 16) + \
	(b = 18000 * (b & 65535) + (b >> 16))  )

void block_rndfill(unsigned char *buf, const int len)
{
	static unsigned long a[2], mt = 1, count = 4;
	static unsigned char r[4];
	int                  i;

	//  我们使用处理器CPUID读取时间戳来对其初始化。
	if(mt) { mt = 0; *(unsigned long long*)a = read_tsc(); }

	for(i = 0; i < len; ++i)
	{
		if(count == 4)
		{
			*(unsigned long*)r = RAND(a[0], a[1]);
			count = 0;
		}

		buf[i] = r[count++];
	}
}

/** 处理短消息所需的最小时钟周期的测量时，循环的次数 */
const int loops = 100;  

/** 处理长消息所需的最小时钟周期的测量时，循环的次数 */
const int loops_longMessage = 1;

/** 测试各函数执行所需的时钟周期数的均值和标准差时，采样1的总采样数 */
#define SAMPLE1  1000
/** 测试各函数执行所需的时钟周期数的均值和标准差时，采样2的总采样数 */
#define SAMPLE2 10000

/** 测试各函数执行所需的时钟周期数的均值和标准差时，测试成功返回值 */
#define TRUE  1
/** 测试各函数执行所需的时钟周期数的均值和标准差时，测试失败返回值 */
#define FALSE 0

int timeBase(double *av, double *sig)
{
	volatile int                 i, tol, lcnt, sam_cnt;
	volatile double              cy, av1, sig1;

	tol = 10; lcnt = sam_cnt = 0;
	while(!sam_cnt)
	{
		av1 = sig1 = 0.0;

		/** 执行初始采样1，得到采样1均值和采样1标准差 */
		for(i = 0; i < SAMPLE1; ++i)
		{
			cy = (volatile double)read_tsc();
			cy = (volatile double)read_tsc() - cy;

			av1 += cy;
			sig1 += cy * cy;
		}

		av1 /= SAMPLE1;
		sig1 = sqrt((sig1 - av1 * av1 * SAMPLE1) / SAMPLE1);
		sig1 = (sig1 < 0.05 * av1 ? 0.05 * av1 : sig1);

		/** 执行正式采样2，得到正式采样2均值和采样2标准差 */
		*av = *sig = 0.0;
		for(i = 0; i < SAMPLE2; ++i)
		{
			cy = (volatile double)read_tsc();
			cy = (volatile double)read_tsc() - cy;

			/** 采样2中，一次采样的时间只有在采样1均值+/-采样1标准差范围内，才记为一次有效采样 */
			if(cy > av1 - sig1 && cy < av1 + sig1)
			{
				*av += cy;
				*sig += cy * cy;
				sam_cnt++;
			}
		}

		/** 要求采样2有效采样次数占总采样次数的比例达到 90% 以上 **/
		if(10 * sam_cnt > 9 * SAMPLE2)
		{
			*av /= sam_cnt;
			*sig = sqrt((*sig - *av * *av * sam_cnt) / sam_cnt);

			/** 并且标准差要求小于均值的 10% -> 15% -> 20% -> 30% */
			if(*sig > (tol / 100.0) * *av)
				sam_cnt = 0;
		}
		else
		{
			/** 若连续测试10次都没有成功则将标准差的可接受限度放低 5%，再次重新采样测量 */
			if(lcnt++ == 10)
			{
				lcnt = 0; tol += 5;
				/** 直到标准差的可接受限度降到了均值的 30% 时，仍没有测试成功。此时返回FALSE，测试失败。*/
				if(tol > 30)
					return FALSE;
			}
			sam_cnt = 0;
		}
	}
	/** 测试成功，返回 TURE */
	return TRUE;
}

int time_key8(unsigned int k_len, double *av, double *sig)
{
	volatile int     i, tol, lcnt, sam_cnt;
	volatile double  cy, av1, sig1;
	unsigned char    userKey[8][16];
	unsigned char    subkey[EXTENDED_KEY_BYTE_NUMBER];

	block_rndfill(userKey[0], 8*16);

	tol = 10; lcnt = sam_cnt = 0;
	while(!sam_cnt)
	{
		av1 = sig1 = 0.0;

		/** 执行初始采样1，得到采样1均值和采样1标准差 */
		for(i = 0; i < SAMPLE1; ++i)
		{
			cy = (double)read_tsc();
			Key_Schedule(userKey[0], k_len, 0, subkey);
			Key_Schedule(userKey[1], k_len, 0, subkey);
			Key_Schedule(userKey[2], k_len, 0, subkey);
			Key_Schedule(userKey[3], k_len, 0, subkey);
			Key_Schedule(userKey[4], k_len, 0, subkey);
			Key_Schedule(userKey[5], k_len, 0, subkey);
			Key_Schedule(userKey[6], k_len, 0, subkey);
			Key_Schedule(userKey[7], k_len, 0, subkey);
			cy = (double)read_tsc() - cy;

			av1 += cy;
			sig1 += cy * cy;
		}

		av1 /= SAMPLE1;
		sig1 = sqrt((sig1 - av1 * av1 * SAMPLE1) / SAMPLE1);
		sig1 = (sig1 < 0.05 * av1 ? 0.05 * av1 : sig1);

		/** 执行正式采样2，得到正式采样2均值和采样2标准差 */
		*av = *sig = 0.0;
		for(i = 0; i < SAMPLE2; ++i)
		{
			cy = (double)read_tsc();
			Key_Schedule(userKey[0], k_len, 0, subkey);
			Key_Schedule(userKey[1], k_len, 0, subkey);
			Key_Schedule(userKey[2], k_len, 0, subkey);
			Key_Schedule(userKey[3], k_len, 0, subkey);
			Key_Schedule(userKey[4], k_len, 0, subkey);
			Key_Schedule(userKey[5], k_len, 0, subkey);
			Key_Schedule(userKey[6], k_len, 0, subkey);
			Key_Schedule(userKey[7], k_len, 0, subkey);
			cy = (double)read_tsc() - cy;

			/** 采样2中，一次采样的时间只有在采样1均值+/-采样1标准差范围内，才记为一次有效采样 */
			if(cy > av1 - sig1 && cy < av1 + sig1)
			{
				*av += cy;
				*sig += cy * cy;
				sam_cnt++;
			}
		}

		/** 要求采样2有效采样次数占总采样次数的比例达到 90% 以上 **/
		if(10 * sam_cnt > 9 * SAMPLE2)
		{
			*av /= sam_cnt;
			*sig = sqrt((*sig - *av * *av * sam_cnt) / sam_cnt);
			/** 并且标准差要求小于均值的 10% -> 15% -> 20% -> 30% */
			if(*sig > (tol / 100.0) * *av)
				sam_cnt = 0;
		}
		else
		{
			/** 若连续测试10次都没有成功则将标准差的可接受限度放低 5%，再次重新采样测量 */
			if(lcnt++ == 10)
			{
				lcnt = 0; tol += 5;
				/** 直到标准差的可接受限度降到了均值的 30% 时，仍没有测试成功。此时返回FALSE，测试失败。*/
				if(tol > 30)
					return FALSE;
			}
			sam_cnt = 0;
		}
	}

	/** 测试成功，返回 TURE */
	return TRUE;
}

int time_enc16(double *av, double *sig, unsigned long long dataLengthInBytes)
{
	volatile int       i, tol, lcnt, sam_cnt;
	volatile double    cy, av1, sig1;
	data_t             key[EXTENDED_KEY_BYTE_NUMBER];
	data_t             *pt[4];
	for (int i = 0; i < 4; i++)
	{
		pt[i] = new data_t[dataLengthInBytes];
		block_rndfill(pt[i], dataLengthInBytes);
	}

	int out_len;

	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	tol = 10; lcnt = sam_cnt = 0;
	while(!sam_cnt)
	{
		av1 = sig1 = 0.0;

		/** 执行初始采样1，得到采样1均值和采样1标准差 */
		for(i = 0; i < SAMPLE1; ++i)
		{
			cy = (double)read_tsc();
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			cy = (double)read_tsc() - cy;

			av1 += cy;
			sig1 += cy * cy;
		}

		av1 /= SAMPLE1;
		sig1 = sqrt((sig1 - av1 * av1 * SAMPLE1) / SAMPLE1);
		sig1 = (sig1 < 0.05 * av1 ? 0.05 * av1 : sig1);

		/** 执行正式采样2，得到正式采样2均值和采样2标准差 */
		*av = *sig = 0.0;
		for(i = 0; i < SAMPLE2; ++i)
		{
			cy = (double)read_tsc();
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Enc_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Enc_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Enc_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Enc_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			cy = (double)read_tsc() - cy;

			/** 采样2中，一次采样的时间只有在采样1均值+/-采样1标准差范围内，才记为一次有效采样 */
			if(cy > av1 - sig1 && cy < av1 + sig1)
			{
				*av += cy;
				*sig += cy * cy;
				sam_cnt++;
			}
		}

		/** 要求采样2有效采样次数占总采样次数的比例达到 90% 以上 **/
		if(10 * sam_cnt > 9 * SAMPLE2)
		{
			*av /= sam_cnt;
			*sig = sqrt((*sig - *av * *av * sam_cnt) / sam_cnt);
			/** 并且标准差要求小于均值的 10% -> 15% -> 20% -> 30% */
			if(*sig > (tol / 100.0) * *av)
				sam_cnt = 0;
		}
		else
		{
			/** 若连续测试10次都没有成功则将标准差的可接受限度放低 5%，再次重新采样测量 */
			if(lcnt++ == 10)
			{
				lcnt = 0; tol += 5;
				/** 直到标准差的可接受限度降到了均值的 30% 时，仍没有测试成功。此时返回FALSE，测试失败。*/
				if(tol > 30)
				{
					for (int i = 0; i < 4; i++)
					{
						delete [] pt[i];
					}
					return FALSE;
				}
			}
			sam_cnt = 0;
		}
	}
	for (int i = 0; i < 4; i++)
	{
		delete [] pt[i];
	}
	/** 测试成功，返回 TURE */
	return TRUE;
}

int time_dec16(double *av, double *sig, unsigned long long dataLengthInBytes)
{
	volatile int                 i, tol, lcnt, sam_cnt;
	volatile double              cy, av1, sig1;
	data_t       key[EXTENDED_KEY_BYTE_NUMBER];
	data_t       *pt[4];
	for (int i = 0; i < 4; i++)
	{
		pt[i] = new data_t[dataLengthInBytes];
		block_rndfill(pt[i], dataLengthInBytes);
	}

	int out_len;

	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	tol = 10; lcnt = sam_cnt = 0;
	while(!sam_cnt)
	{
		av1 = sig1 = 0.0;

		/** 执行初始采样1，得到采样1均值和采样1标准差 */
		for(i = 0; i < SAMPLE1; ++i)
		{
			cy = (double)read_tsc();
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			cy = (double)read_tsc() - cy;

			av1 += cy;
			sig1 += cy * cy;
		}

		av1 /= SAMPLE1;
		sig1 = sqrt((sig1 - av1 * av1 * SAMPLE1) / SAMPLE1);
		sig1 = (sig1 < 0.05 * av1 ? 0.05 * av1 : sig1);

		/** 执行正式采样2，得到正式采样2均值和采样2标准差 */
		*av = *sig = 0.0;
		for(i = 0; i < SAMPLE2; ++i)
		{
			cy = (double)read_tsc();
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			Crypt_Dec_Block(pt[0], dataLengthInBytes, pt[0], &out_len, key, 80);
			Crypt_Dec_Block(pt[1], dataLengthInBytes, pt[1], &out_len, key, 80);
			Crypt_Dec_Block(pt[2], dataLengthInBytes, pt[2], &out_len, key, 80);
			Crypt_Dec_Block(pt[3], dataLengthInBytes, pt[3], &out_len, key, 80);
			cy = (double)read_tsc() - cy;

			/** 采样2中，一次采样的时间只有在采样1均值+/-采样1标准差范围内，才记为一次有效采样 */
			if(cy > av1 - sig1 && cy < av1 + sig1)
			{
				*av += cy;
				*sig += cy * cy;
				sam_cnt++;
			}
		}

		/** 要求采样2有效采样次数占总采样次数的比例达到 90% 以上 **/
		if(10 * sam_cnt > 9 * SAMPLE2)
		{
			*av /= sam_cnt;
			*sig = sqrt((*sig - *av * *av * sam_cnt) / sam_cnt);
			/** 并且标准差要求小于均值的 10% -> 15% -> 20% -> 30% */
			if(*sig > (tol / 100.0) * *av)
				sam_cnt = 0;
		}
		else
		{
			/** 若连续测试10次都没有成功则将标准差的可接受限度放低 5%，再次重新采样测量 */
			if(lcnt++ == 10)
			{
				lcnt = 0; tol += 5;
				/** 直到标准差的可接受限度降到了均值的 30% 时，仍没有测试成功。此时返回FALSE，测试失败。*/
				if(tol > 30)
				{
					for (int i = 0; i < 4; i++)
					{
						delete [] pt[i];
					}
					return FALSE;
				}
			}
			sam_cnt = 0;
		}
	}
	for (int i = 0; i < 4; i++)
	{
		delete [] pt[i];
	}
	/** 测试成功，返回 TURE */
	return TRUE;
}

double enc_cycles(unsigned long long dataLengthInBytes)
{
	volatile double cy1, cy2, c1 = -1, c2 = -1;
	volatile int i;
	int out_len;
	data_t  key[EXTENDED_KEY_BYTE_NUMBER];
	data_t  *pt = new data_t[dataLengthInBytes];

	// 设置随机扩展密钥
	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	// 设置随机待处理数据
	block_rndfill(pt, dataLengthInBytes);   c1 = c2 = 0xffffffffffffffff;

	// 执行一次加密，去除第一次执行的不稳定性
	Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);

	for(i = 0; i < loops; ++i)
	{
		block_rndfill(pt, dataLengthInBytes);

		// 测试 1 次 和 9 次的加密所需时钟周期数，相减得到 8 次的加密所需时钟周期数
		cy1 = (volatile double)read_tsc();
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy1 = (volatile double)read_tsc() - cy1;

		cy2 = (volatile double)read_tsc();
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy2 = (volatile double)read_tsc() - cy2;

		/** 当循环了 10% 次之后，就比较稳定了 */
		if(i > (loops / 10))
		{
			/** 找到循环中的所需最小时钟周期数 */
			c1 = (c1 < cy1 ? c1 : cy1);
			c2 = (c2 < cy2 ? c2 : cy2);
		}
	}
	delete [] pt;
	/** 返回 1 次加密算法加密指定长度消息所需最小时钟周期数*/
	return ((c2 - c1) + 4.0) / 8.0;
}

double dec_cycles(unsigned long long dataLengthInBytes)
{
	volatile double cy1, cy2, c1 = -1, c2 = -1;
	volatile int i;
	int out_len;
	data_t  key[EXTENDED_KEY_BYTE_NUMBER];
	data_t  *pt = new data_t[dataLengthInBytes];

	// 设置随机扩展密钥
	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	// 设置随机待处理数据
	block_rndfill(pt, dataLengthInBytes);   c1 = c2 = 0xffffffffffffffff;

	// 执行一次解密，去除第一次执行的不稳定性
	Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);

	for(i = 0; i < loops; ++i)
	{
		block_rndfill(pt, dataLengthInBytes);

		// 测试 1 次 和 9 次的解密所需时钟周期数，相减得到 8 次的解密所需时钟周期数
		cy1 = (volatile double)read_tsc();
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy1 = (volatile double)read_tsc() - cy1;

		cy2 = (volatile double)read_tsc();
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
	    Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy2 = (volatile double)read_tsc() - cy2;

		/** 当循环了 10% 次之后，就比较稳定了 */
		if(i > (loops / 10))
		{
			/** 找到循环中的所需最小时钟周期数 */
			c1 = (c1 < cy1 ? c1 : cy1);
			c2 = (c2 < cy2 ? c2 : cy2);
		}
	}
	delete [] pt;
	/** 返回 1 次解密算法解密指定长度消息所需最小时钟周期数*/
	return ((c2 - c1) + 4.0) / 8.0;
}

double key_cycles(const unsigned long k_len)
{
	unsigned char    userKey[5][32];
	volatile double  cy1, cy2, c1 = -1, c2 = -1;
	volatile int     i;
	unsigned char    subkey[EXTENDED_KEY_BYTE_NUMBER];

	// 设置随机128-比特主密钥
	block_rndfill(userKey[0], 5*32);

	// 执行一次密钥编排，去除第一次执行的不稳定性
	Key_Schedule(userKey[0], k_len, 0, subkey); c1 = c2 = 0xffffffffffffffff;

	for(i = 0; i < loops; ++i)
	{
		// 测试 1 次 和 9 次的密钥编排所需时钟周期数，相减得到 4 次的密钥编排所需时钟周期数
		cy1 = (double)read_tsc();
		Key_Schedule(userKey[0], k_len, 0, subkey);
		cy1 = (double)read_tsc() - cy1;

		cy2 = (double)read_tsc();
		Key_Schedule(userKey[0], k_len, 0, subkey);
		Key_Schedule(userKey[1], k_len, 0, subkey);
		Key_Schedule(userKey[2], k_len, 0, subkey);
		Key_Schedule(userKey[3], k_len, 0, subkey);
		Key_Schedule(userKey[4], k_len, 0, subkey);
		cy2 = (double)read_tsc() - cy2;

		/** 当循环了 10% 次之后，就比较稳定了 */
		if(i > loops / 10)
		{
			/** 找到循环中的所需最小时钟周期数 */
			c1 = (c1 < cy1 ? c1 : cy1);
			c2 = (c2 < cy2 ? c2 : cy2);
		}
	}

	/** 返回 1 次密钥编排所需最小时钟周期数*/
	return ((c2 - c1) + 2.0) / 4.0;
}

double enc_cycles_longMessage(unsigned long long dataLengthInBytes)
{
	volatile double cy1, cy2, c1 = -1, c2 = -1;
	volatile int i;
	int out_len;
	data_t  key[EXTENDED_KEY_BYTE_NUMBER];
	data_t  *pt = new data_t[dataLengthInBytes];


	// 设置随机扩展密钥
	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	// 设置随机待处理数据
	block_rndfill(pt, dataLengthInBytes);   c1 = c2 = 0xffffffffffffffff;

	// 执行一次加密，去除第一次执行的不稳定性
	Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);

	for(i = 0; i < loops_longMessage; ++i)
	{
		// 测试 1 次 和 9 次的加密所需时钟周期数，相减得到 8 次的加密所需时钟周期数
		cy1 = (volatile double)read_tsc();
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy1 = (volatile double)read_tsc() - cy1;

		cy2 = (volatile double)read_tsc();
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Enc_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy2 = (volatile double)read_tsc() - cy2;

		/** 当循环了 10% 次之后，就比较稳定了 */
		if(i >= (loops_longMessage / 10))
		{
			/** 找到循环中的所需最小时钟周期数 */
			c1 = (c1 < cy1 ? c1 : cy1);
			c2 = (c2 < cy2 ? c2 : cy2);
		}
	}
	delete [] pt;
	/** 返回 1 次加密算法加密指定长度消息所需最小时钟周期数*/
	return ((c2 - c1) + 4.0) / 8.0;
}

double dec_cycles_longMessage(unsigned long long dataLengthInBytes)
{
	volatile double cy1, cy2, c1 = -1, c2 = -1;
	volatile int i;
	int out_len;
	data_t  key[EXTENDED_KEY_BYTE_NUMBER];
	data_t  *pt = new data_t[dataLengthInBytes];

	// 设置随机扩展密钥
	block_rndfill(key, EXTENDED_KEY_BYTE_NUMBER);

	// 设置随机待处理数据
	block_rndfill(pt, dataLengthInBytes);   c1 = c2 = 0xffffffffffffffff;

	// 执行一次解密，去除第一次执行的不稳定性
	Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);

	for(i = 0; i < loops_longMessage; ++i)
	{
		block_rndfill(pt, dataLengthInBytes);

		// 测试 1 次 和 9 次的解密所需时钟周期数，相减得到 8 次的解密所需时钟周期数
		cy1 = (volatile double)read_tsc();
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy1 = (volatile double)read_tsc() - cy1;

		cy2 = (volatile double)read_tsc();
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		Crypt_Dec_Block(pt, dataLengthInBytes, pt, &out_len, key, 80);
		cy2 = (volatile double)read_tsc() - cy2;

		/** 当循环了 10% 次之后，就比较稳定了 */
		if(i >= (loops_longMessage / 10))
		{
			/** 找到循环中的所需最小时钟周期数 */
			c1 = (c1 < cy1 ? c1 : cy1);
			c2 = (c2 < cy2 ? c2 : cy2);
		}
	}
	delete [] pt;
	/** 返回 1 次解密算法解密指定长度消息所需最小时钟周期数*/
	return ((c2 - c1) + 4.0) / 8.0;
}

/** 两种密钥长度（按比特计） */
static unsigned long kl[2] = { 80, 128 };
/** 五种消息长度（按字节计）： 包括128B、1KB、16KB短消息和100MB、1GB长消息 */
static unsigned long tl[5] = {128UL, (1UL<<10), (16UL<<10), (100UL<<20), (1UL<<30)};
/** 存放加密、解密最小时间开销的临时变量 */
static double et, dt;

void timing()
{
	ofstream fout;
	double   a0, av, sig;
	int ki, i, w;

	setCPUaffinity();

	fout.open("timingKey.txt");
	fout << "Rectangle Key_Schedule Timing" << endl;
	fout.setf(ios::fixed);

	/** 测试密钥编排的最小时钟周期数开销  (cycles)*/
	fout << setw(20) << "KeySize"  << setw(40) << "KEY(cycles)" << endl;
	fout << setw(20) << "min( 80)" << setw(40) << setprecision(1) << key_cycles( 80) << endl;
	fout << setw(20) << "min(128)" << setw(40) << setprecision(1) << key_cycles(128) << endl;

	while (timeBase(&a0, &sig)!=TRUE){}

	/** 测试密钥编排的平均时钟周期数和统计偏差 (cycles)*/
	while (time_key8(80, &av, &sig)!=TRUE){}
	sig *= 100.0 / av;
	av = ((av - a0 + 4.0) / 8.0);
	fout << setw(20) << "avg( 80)" << setw(40) << setprecision(1) << av << "(" << setw(6) << sig << "%)" << endl;

	while (time_key8(128, &av, &sig)!=TRUE){}
	sig *= 100.0 / av;
	av = ((av - a0 + 4.0) / 8.0);
	fout << setw(20) << "avg(128)" << setw(40) << setprecision(1) << av << "(" << setw(6) << sig << "%)" << endl;

	fout << endl;
	fout.unsetf(ios::fixed);
	fout.close();

	fout.open("timingEncDecMin.txt");

	fout << setw(40) << "in_len(bytes)" << setw(20) << "ENC(cycles/byte)"<< setw(20) << "DEC(cycles/byte)" << endl;
	unsigned long long di;
	/** 测试加解密短消息最小速率(cycles/byte) */
	for (di = 0; di < 3; di++)
	{
		fout << setw(40) << tl[di];

		et = enc_cycles(tl[di]);
		dt = dec_cycles(tl[di]);
		
		av = et / (tl[di]); w = (int)(10.0 * av + 0.5);
		fout << setw(18) << w / 10 << "." << setw(1) << w % 10;
		
		av = dt / (tl[di]); w = (int)(10.0 * av + 0.5);;
		fout << setw(18) << w / 10 << "." << setw(1) << w % 10;
		fout << endl;
	}
	/** 测试加解密长消息最小速率(cycles/byte) */
	for (di = 3; di < 5; di++)
	{
		fout << setw(40) << tl[di];

		et = enc_cycles_longMessage(tl[di]);
		dt = dec_cycles_longMessage(tl[di]);

		av = et / (tl[di]); w = (int)(10.0 * av + 0.5);
		fout << setw(18) << w / 10 << "." << setw(1) << w % 10;

		av = dt / (tl[di]); w = (int)(10.0 * av + 0.5);;
		fout << setw(18) << w / 10 << "." << setw(1) << w % 10;
		fout << endl;
	}

	fout.close();

	fout.open("timingEncDecAvg.txt");
	fout << setw(40) << "in_len(bytes)" << setw(20) << "ENC(cycles/byte)"<< setw(20) << "DEC(cycles/byte)" << endl;
	timeBase(&a0, &sig);
	fout.setf(ios::fixed); 
	/** 测试加解密短消息平均速率及统计的标准差(cycles/byte) */
	for (di = 0; di < 3; di++)
	{
		fout << setw(40) << tl[di];

		while (time_enc16(&av, &sig, tl[di]) != TRUE) {}
		sig *= 100.0 / av;
		av = (int)(10.0 * (av - a0) / (16.0 * tl[di])) / 10.0;
		sig = (int)(10 * sig) / 10.0;
		fout << setw(10) << setprecision(1) << av << " ("  <<setw(6) << sig << "%)";

		while (time_dec16(&av, &sig, tl[di]) != TRUE) {}
		sig *= 100.0 / av;
		av = (int)(10.0 * (av - a0) / (16.0 * tl[di])) / 10.0;
		sig = (int)(10 * sig) / 10.0;
		fout << setw(10) << setprecision(1) << av << " ("  <<setw(6) << sig << "%)";
		fout << endl;
	}
	fout.unsetf(ios::fixed);
	fout.close();
}

