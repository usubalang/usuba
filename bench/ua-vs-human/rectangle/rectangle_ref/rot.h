/** @file rot.h
  * @brief 本文件包含RECTANGLE密码算法所使用的循环移位操作的定义。
  *
  * 为了使用处理器本身的循环移位指令，需要使用编译器固有函数
  * - 若使用Intel C/C++ Compiler，需要包含<immintrin.h>头文件，使用相应的intrinsic函数
  * - 若使用微软的编译器，比如Microsoft Vistual Studio，需要包含<intrin.h>头文件，使用相应的intrinsic函数
  * - 若使用GNU的编译器，比如g++，由于可能没有相应的intrinsic函数，需要使用嵌入式汇编编写
  * - 对于其他编译器，没有循环移位函数的接口，又不使用嵌入式汇编，则只能通过左右移位和或操作来实现。
  *
  * 测试结果显示，Intel C/C++ Compiler 和 GNU编译器的效果较使用微软的编译器或通过左右移位实现的方式高效很多。
  * 所以建议使用 Intel C/C++ Compiler 和 GNU编译器。
  */
#ifndef ROT_H__
#define ROT_H__
#include "types.h"

/** 
  * @def ror16(x, n)
  *                  16-比特字@a x 上右循环移@a n 位
  * @def rol16(x, n)
  *                  16-比特字@a x 上左循环移@a n 位
  * @def ror32(x, n)
  *                  32-比特字@a x 上右循环移@a n 位
  * @def rol32(x, n)
  *                  32-比特字@a x 上左循环移@a n 位
  */
#ifdef __INTEL_COMPILER
#  include <immintrin.h>
#  define ror16(x, n) (_rotwr(x,n))
#  define rol16(x, n) (_rotwl(x,n))
#  define ror32(x, n) (_rotr(x,n))
#  define rol32(x, n) (_rotl(x,n))
#else 
#ifdef _MSC_VER 
#  include <intrin.h>
#  pragma intrinsic(_rotr16, _rotl16)
#  define ror16(x, n) (_rotr16(x,n))
#  define rol16(x, n) (_rotl16(x,n))
#  pragma intrinsic(_rotr,_rotl) 
#  define ror32(x, n) (_rotr(x,n))
#  define rol32(x, n) (_rotl(x,n))
#else
#ifdef __GNUC__
#define __INTRIN_INLINE inline
__INTRIN_INLINE unsigned char _rotl8(unsigned char value, unsigned char shift)
{
	unsigned char retval;
	__asm__("rolb %b[shift], %b[retval]" : [retval] "=rm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

__INTRIN_INLINE unsigned short _rotl16(unsigned short value, unsigned char shift)
{
	unsigned short retval;
	__asm__("rolw %b[shift], %w[retval]" : [retval] "=rm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

__INTRIN_INLINE unsigned int _rotl(unsigned int value, int shift)
{
	unsigned long retval;
	__asm__("roll %b[shift], %k[retval]" : [retval] "=rm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

__INTRIN_INLINE unsigned int _rotr(unsigned int value, int shift)
{
	unsigned long retval;
	__asm__("rorl %b[shift], %k[retval]" : [retval] "=rm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

__INTRIN_INLINE unsigned char _rotr8(unsigned char value, unsigned char shift)
{
	unsigned char retval;
	__asm__("rorb %b[shift], %b[retval]" : [retval] "=qm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

__INTRIN_INLINE unsigned short _rotr16(unsigned short value, unsigned char shift)
{
	unsigned short retval;
	__asm__("rorw %b[shift], %w[retval]" : [retval] "=rm" (retval) : "[retval]" (value), [shift] "Nc" (shift));
	return retval;
}

#  define ror16(x, n) (_rotr16(x,n))
#  define rol16(x, n) (_rotl16(x,n))
#  define ror32(x, n) (_rotr(x,n))
#  define rol32(x, n) (_rotl(x,n))

#else 
#define ror16(x, n)   (((x) >> ((int)((n) & 0xf))) | ((x) << ((int)((16 - ((n) & 0xf))))) & 0xffff) 
#define rol16(x, n)   (((x) << ((int)((n) & 0xf))) | ((x) >> ((int)((16 - ((n) & 0xf))))) & 0xffff) 
#define ror32(x, n)   (((x) >> ((int)((n) & 0x1f))) | ((x) << ((int)((32 - ((n) & 0x1f))))) & 0xffffffff) 
#define rol32(x, n)   (((x) << ((int)((n) & 0x1f))) | ((x) >> ((int)((32 - ((n) & 0x1f))))) & 0xffffffff) 
#endif 
#endif 
#endif

#endif //ROT_H__
