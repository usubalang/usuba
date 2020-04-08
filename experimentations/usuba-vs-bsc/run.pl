#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use FindBin;

chdir "$FindBin::Bin/../..";
system "make" and die $!;
system "./usubac -gen-bench -no-arr -inline-all -no-precalc-tbl -check-tbl -B -o $FindBin::Bin/des-usuba.c samples/usuba/des.ua" and die $!;;

chdir "$FindBin::Bin/bsc-0.1";
system "make 2>/dev/null" and die $!;
system "./bsc des.b > des.c" and die $!;
open my $FH, '>>', "des.c" or die $!;
print $FH <<END_PRINT;

/* End of generated code; manually added benchmark code */
#include <stdint.h>
#define DATATYPE uint64_t

/* Additional functions */
uint32_t bench_speed() {
  /* Inputs */
  DATATYPE plaintext_key[128] = { 0 };

  /* Preventing inputs from being optimized out */
  asm volatile("" : "+m" (plaintext_key));

  /* Outputs */
  DATATYPE ciphered__[64] = { 0 };
  /* Primitive call */
  bsc_code(plaintext_key,ciphered__);

  /* Preventing outputs from being optimized out */
  asm volatile("" : "+m" (ciphered__));

  /* Returning the number of encrypted bytes */
  return 512;
}

END_PRINT
close $FH; # / # weird comment to fix syntax highlighting

chdir $FindBin::Bin;
system "clang -I ../../arch -O3 -Wall -Wextra -DNB_RUN=1000000 -DWARMING=10000 ../bench_generic/bench.c des-usuba.c -o des-usuba";
system "clang -I ../../arch -O3 -Wall -Wextra -DNB_RUN=1000000 -DWARMING=10000 ../bench_generic/bench.c bsc-0.1/des.c -o des-bsc";

system "../../cmp.pl 15 des-usuba des-bsc";
