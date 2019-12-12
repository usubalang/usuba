#pragma once

/* Will generate the macros FD_AND_x, FD_OR_x, FD_XOR_x, FD_NOT_x for
    x in 1, 2, 4,

   as well as FD_AND, FD_OR, FD_XOR and FD_NOT, which are the
   specialized versions of those macros for the currently defined FD.

   Uses the macros ANDC16, XORC16, ANDC8 and XORC8.
 */

#define FD_AND_1(r,a,b) (r) = (a) & (b)
#define FD_OR_1(r,a,b)  (r) = (a) | (b)
#define FD_XOR_1(r,a,b) (r) = (a) ^ (b)
#define FD_NOT_1(r,a)   (r) = ~(a)

#define FD_AND_2(r,a,b) ANDC16(r,a,b)
#define FD_OR_2(r,a,b)  { DATATYPE _tmp_or; ANDC16(_tmp_or,~a,~b); r = ~_tmp_or; }
#define FD_XOR_2(r,a,b) XORC16(r,a,b)
#define FD_NOT_2(r,a)   (r) = ~(a)

#define FD_AND_4(r,a,b) ANDC8(r,a,b)
#define FD_OR_4(r,a,b)  { DATATYPE _tmp_or; ANDC8(_tmp_or,~a,~b); r = ~_tmp_or; }
#define FD_XOR_4(r,a,b) XORC8(r,a,b)
#define FD_NOT_4(r,a)   (r) = ~(a)

#ifndef FD
#define FD 1
#endif

#define _BUILD_OP_FD(OP,n) FD_ ## OP ## _ ## n
#define BUILD_OP_FD(OP,n) _BUILD_OP_FD(OP,n)

#define FD_AND BUILD_OP_FD(AND,FD)
#define FD_OR  BUILD_OP_FD(OR, FD)
#define FD_XOR BUILD_OP_FD(XOR,FD)
#define FD_NOT BUILD_OP_FD(NOT,FD)
