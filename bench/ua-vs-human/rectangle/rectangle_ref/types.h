/** @file types.h
  * @brief 本文件包含数据类型的宏定义、使用的指令集的定义等。
  */
#ifndef TYPES_H__
#define TYPES_H__

/** @cond **/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <map>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>
#include <bitset>
#include <immintrin.h>
#include <nmmintrin.h>
#include <xmmintrin.h>
#include <emmintrin.h>
#include <pmmintrin.h>
#include <tmmintrin.h>
#include <smmintrin.h>
#include <wmmintrin.h>
#include <limits.h>
#include <math.h>
#include <stdint.h>
/** @endcond **/

#ifdef __GNUC__
#include <sched.h>
#endif

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef long long __int64;
typedef uint64_t u64;

/**
  * @def GEN
  *             使用通用指令集，每次处理一个分组
  * @def SSE
  *             使用SSE指令集，每次并行处理8个分组
  * @def AVX
  *             使用AVX指令集，每次并行处理16个分组
  * @def EI
  *             设定使用的指令集，在编译代码之前进行设定
  *               -使用通用指令集时设定 EI 为 GEN
  *               -使用 SSE指令集时设定 EI 为 SSE
  *               -使用 AVX指令集时设定 EI 为 AVX
 */
#define GEN 1
#define SSE 7
#define AVX 8
#ifdef USE_AVX
#define EI AVX
#elif defined(USE_SSE)
#define EI SSE
#elif defined(USE_GP)
#define EI GEN
#else
#warning Supposing USE_AVX
#endif

/**
 * @def RegisterLengthInLog2 定义寄存器长度（以比特计算，且取以2为底的对数）
 */
#if (EI==SSE)
#define RegisterLengthInLog2 7
#elif (EI==AVX)
#define RegisterLengthInLog2 8
#else
#define RegisterLengthInLog2 4
#endif

/**
  * @def RegisterLengthInBits
  *                                 寄存器的长度（按比特计算）
  * @def RegisterLengthInBytes
  *                                 寄存器的长度（按字节计算）
  * @def RegisterLengthInWords
  *                                 寄存器的长度（按字  计算）
  * @def ParallelN
  *                                 并行处理的分组的格式
  */
#define RegisterLengthInBits  (1<<RegisterLengthInLog2)       
#define RegisterLengthInBytes (1<<(RegisterLengthInLog2-3))	  
#define RegisterLengthInWords (1<<(RegisterLengthInLog2-4))
#define ParallelN RegisterLengthInWords 

#if defined(_MSC_VER)
#define ALIGNED_(x) __declspec(align(x))
#else
#if defined(__GNUC__)
#define ALIGNED_(x) __attribute__((aligned(x)))
typedef unsigned long long _ULonglong;
#endif
#endif

#define ALIGNED_TYPE_(t,x) t ALIGNED_(x) // 使用Intel的SSE/AVX指令进行数据装载时，对齐数据读取会更高效

#if (EI==SSE)
#define data_t ALIGNED_TYPE_(u8, 16)
#elif (EI==AVX)
#define data_t ALIGNED_TYPE_(u8, 32)
#else
#define data_t u8
#endif

#endif //TYPES_H__
