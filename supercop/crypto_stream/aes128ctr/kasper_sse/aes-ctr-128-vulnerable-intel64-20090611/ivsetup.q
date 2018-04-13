# Author: Peter Schwabe, ported from an assembly implementation by Emilia Käsper
# Date: 2009-03-19
# Public domain

int64 ctxp
int64 iv

input ctxp
input iv

int6464 d

int64 r11_caller
int64 r12_caller
int64 r13_caller
int64 r14_caller
int64 r15_caller
int64 rbx_caller
int64 rbp_caller
caller r11_caller
caller r12_caller
caller r13_caller
caller r14_caller
caller r15_caller
caller rbx_caller
caller rbp_caller

enter ECRYPT_init
leave

enter ECRYPT_ivsetup
  d = *(int128 *) (iv + 0)
  *(int128 *)(ctxp + 1408) = d
leave
    

