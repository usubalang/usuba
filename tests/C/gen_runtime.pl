#!/usr/bin/perl -w

use v5.14;
use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
no warnings 'experimental';


my $file = shift @ARGV or die "No file specified.";
die "Only works on 1 file." if @ARGV;

# switching to src dir
my $path = getcwd() =~ s{usuba\K.*}{}r 
    or die "Can't run this script from outside usuba repo.";
chdir "$path/tests/C";

# Retrieving the type of the bitslicing.
my $TYPE;
{
    open my $FPIN, '<', $file or die $!;
    while (<$FPIN>) {
        if (/\((.*?) input/) {
            $TYPE = $1;
            last;
        }
    }
    close $FPIN;
}

# Updating des.c so it can be run easily.
{
    $^I = "";
    push @ARGV, $file;
    while(<>) {
        s/input\[128\]/input[64], $TYPE key[64]/;
        s/(key__\d+) = input\[(\d+)\]/"$1 = key[".($2-64)."]"/e;
        s/int main.*//;
        print;
    }
    pop @ARGV;
}

# Setting the variables to the right values.
my ($ORTHOGONALIZE, $UNORTHOGONALIZE, $SET_ALL_ONE, $SET_ALL_ZERO, $SIZE_SLICE);
given($TYPE) {
    when("unsigned long") {
        $SIZE_SLICE   = '64';
        $SET_ALL_ONE  = '-1';
        $SET_ALL_ZERO = '0';
        $ORTHOGONALIZE = 
"for (int j = 0; j < 64; j++) {
    out[63-j] = 0;
    for (int i = 0; i < 64; i++)
      out[63-j] |= (in[i]>>j & 1) << i;
  }";
        $UNORTHOGONALIZE =
"for (int i = 0; i < 64; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++)
    for (int i = 0; i < 64; i++)
      out[i] |= (in[63-j]>>i & 1) << j;";
    }
    when("__m64") {
        $SIZE_SLICE   = '64';
        $SET_ALL_ONE  = '_mm_cmpeq_pi32(_mm_setzero_si64(),_mm_setzero_si64())';
        $SET_ALL_ZERO = '_mm_setzero_si64()';
        $ORTHOGONALIZE = 
"for (int j = 0; j < 64; j++) {
    unsigned long tmp = 0;
    for (int i = 0; i < 64; i++)
      tmp |= (in[i]>>j & 1) << i;
    out[63-j] = _mm_cvtsi64_m64(tmp);
  }";
        $UNORTHOGONALIZE = 
"for (int i = 0; i < 64; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++) {
    unsigned long tmp = _mm_cvtm64_si64(in[63-j]);
    for (int i = 0; i < 64; i++)
      out[i] |= (tmp>>i & 1) << j;
  }";
    }
    when("__m128i") {
        $SIZE_SLICE   = '128';
        $SET_ALL_ONE  = '_mm_cmpeq_epi64(key_ortho[i],key_ortho[i])';
        $SET_ALL_ZERO = '_mm_setzero_si128()';
        $ORTHOGONALIZE = 
"for (int j = 0; j < 64; j++) {
    unsigned long tmp[2] = {0,0};
    for (int i = 0; i < 128; i++)
      tmp[i/64] |= (in[i]>>j & 1) << i;
    out[63-j] = _mm_set_epi64x (tmp[0], tmp[1]);
  }";
        $UNORTHOGONALIZE = 
"for (int i = 0; i < 128; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++) {
    unsigned long tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[63-j]);
    for (int i = 0; i < 128; i++)
      out[i] |= (tmp[i/64]>>i%64 & 1) << j;
  }";
    }
    when("__m256i") {
        $SIZE_SLICE   = '256';
        $SET_ALL_ONE  = '_mm256_cmpeq_epi64(_mm256_setzero_si256(),_mm256_setzero_si256())';
        $SET_ALL_ZERO = '_mm256_setzero_si256()';
        $ORTHOGONALIZE = 
"for (int j = 0; j < 64; j++) {
    unsigned long tmp[4] = {0,0,0,0};
    for (int i = 0; i < 256; i++)
      tmp[i/64] |= (in[i]>>j & 1) << i;
    out[63-j] = _mm256_set_epi64x (tmp[0], tmp[1], tmp[2], tmp[3]);
  }";
        $UNORTHOGONALIZE = 
"for (int i = 0; i < 256; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++) {
    unsigned long tmp[4];
    _mm256_store_si256 ((__m256i*)tmp, in[63-j]);
    for (int i = 0; i < 256; i++)
      out[i] |= (tmp[i/64]>>i%64 & 1) << j;
  }";
    }
    default {
        die "Unknown type '$TYPE'";
    }
}

my ($file_base) = $file =~ /(.*)\.c/ or die "Not a .c file.";
my $out_file = $file_base . "_run.c";
open my $FH, '>', $out_file or die $!;
print $FH <<"END_PRINT";
#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "$file"

void orthogonalize(unsigned long *in, $TYPE *out) {
    $ORTHOGONALIZE
}

void unorthogonalize($TYPE *in, unsigned long *out) {
    $UNORTHOGONALIZE
}

int main() {
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = aligned_alloc(32,$SIZE_SLICE * sizeof *plain_std);
  $TYPE *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  $TYPE *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = aligned_alloc(32,$SIZE_SLICE * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std =
    ((unsigned long) key_std_char[0]) << 56 |
    ((unsigned long) key_std_char[1]) << 48  |
    ((unsigned long) key_std_char[2]) << 40 |
    ((unsigned long) key_std_char[3]) << 32 |
    ((unsigned long) key_std_char[4]) << 24 |
    ((unsigned long) key_std_char[5]) << 16 |
    ((unsigned long) key_std_char[6]) << 8 |
    ((unsigned long) key_std_char[7]) << 0;
  $TYPE *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = $SET_ALL_ONE;
    else
      key_ortho[63-i] = $SET_ALL_ZERO;
  
  
  while(fread(plain_std, 8, $SIZE_SLICE, fh_in)) {

    for (int i = 0; i < $SIZE_SLICE; i++) {
      unsigned long l = plain_std[i];
      plain_std[i] = (l >> 56) | (l >> 40 & 0x00FF00) | (l >> 24 & 0x00FF0000)
        | (l >> 8 & 0x00FF000000) | (l << 8 & 0x00FF00000000) | (l << 24 & 0x00FF0000000000)
        | (l << 40 & 0x00FF000000000000) | (l << 56);
    }

    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    for (int i = 0; i < $SIZE_SLICE; i++) {
      unsigned long l = cipher_std[i];
      cipher_std[i] = (l >> 56) | (l >> 40 & 0x00FF00) | (l >> 24 & 0x00FF0000)
        | (l >> 8 & 0x00FF000000) | (l << 8 & 0x00FF00000000) | (l << 24 & 0x00FF0000000000)
        | (l << 40 & 0x00FF000000000000) | (l << 56);
    }

    fwrite(cipher_std, 8, $SIZE_SLICE, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
END_PRINT

close $FH;

system "clang -o $file_base $out_file -O3 -march=native";
