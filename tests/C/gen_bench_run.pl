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
        if (/\((.*?) plaintext/) {
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
        s/int main.*//;
        print;
    }
    pop @ARGV;
}

# Setting the variables to the right values.
my ($ORTHOGONALIZE, $UNORTHOGONALIZE, $SET_ALL_ONE, $SET_ALL_ZERO, $SIZE_SLICE,
    $ORTHO_CALL, $UNORTHO_CALL, $DECL, $MAIN_CALL);
given($TYPE) {
    when("unsigned long") {
        $SIZE_SLICE   = '64';
        $SET_ALL_ONE  = '-1';
        $SET_ALL_ZERO = '0';
        $ORTHOGONALIZE = "";
        $UNORTHOGONALIZE = "";
    }
    when("__m64") {
        $SIZE_SLICE   = '64';
        $SET_ALL_ONE  = '_mm_cmpeq_pi32(_mm_setzero_si64(),_mm_setzero_si64())';
        $SET_ALL_ZERO = '_mm_setzero_si64()';
        $ORTHOGONALIZE =
"void orthogonalize(unsigned long *in, __m64 *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _m_from_int64(in[i]);
}";
        $UNORTHOGONALIZE = 
"void unorthogonalize(__m64 *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm_cvtm64_si64(in[i]);
}";
    }
    when("__m128i") {
        $SIZE_SLICE   = '128';
        $SET_ALL_ONE  = '_mm_cmpeq_epi64(key_ortho[i],key_ortho[i])';
        $SET_ALL_ZERO = '_mm_setzero_si128()';
        $ORTHOGONALIZE = 
"void orthogonalize(unsigned long *in, __m128i *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm_set_epi64x (in[i*2], in[i*2+1]);
}";
        $UNORTHOGONALIZE =
"void unorthogonalize(__m128i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm_store_si128 ((__m128i*)&(out[i*2]), in[i]);
}";
    }
    when("__m256i") {
        $SIZE_SLICE   = '256';
        $SET_ALL_ONE  = '_mm256_cmpeq_epi64(_mm256_setzero_si256(),_mm256_setzero_si256())';
        $SET_ALL_ZERO = '_mm256_setzero_si256()';
        $ORTHOGONALIZE = 
"void orthogonalize(unsigned long *in, __m256i *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm256_set_epi64x (in[i*4], in[i*4+1], in[i*4+2], in[i*4+3]);
}";
        $UNORTHOGONALIZE = 
"void unorthogonalize(__m256i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm256_store_si256 ((__m256i*)&(out[i*4]), in[i]);
}";
    }
    default {
        die "Unknown type '$TYPE'";
    }
}


if ($TYPE eq 'unsigned long') {
    $MAIN_CALL = "des__(loc_std, key_ortho,loc_std);";
    $ORTHO_CALL = "";
    $UNORTHO_CALL = "";
    $DECL = "";
} else {
    $DECL = qq{
  $TYPE *plain_ortho = aligned_alloc(32,$SIZE_SLICE * sizeof *plain_ortho);
  $TYPE *cipher_ortho = aligned_alloc(32,$SIZE_SLICE * sizeof *cipher_ortho);};
    $MAIN_CALL = "des__(plain_ortho, key_ortho, cipher_ortho);";
    $ORTHO_CALL = "orthogonalize(loc_std, plain_ortho);";
    $UNORTHO_CALL = "unorthogonalize(cipher_ortho,loc_std);";
}

my ($file_base) = $file =~ /(.*)\.c/ or die "Not a .c file.";
my $out_file = $file_base . "_run.c";
open my $FH, '>', $out_file or die $!;
print $FH <<"END_PRINT";
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "$file"

$ORTHOGONALIZE

$UNORTHOGONALIZE

int main() {
  
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
  
  
  FILE* fh_in = fopen("input.txt","rb");

  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  unsigned long *plain_std = aligned_alloc(32,size);
  $DECL

  fread(plain_std,size,1,fh_in);
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < 16; u++) {
    for (int x = 0; x < size/8; x += $SIZE_SLICE) {
  
      unsigned long* loc_std = plain_std + x;

      for (int i = 0; i < 256; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      $ORTHO_CALL
    
      $MAIN_CALL
           
      $UNORTHO_CALL

      for (int i = 0; i < 256; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  printf("\%f\\n",((double)clock()-timer)/CLOCKS_PER_SEC);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);
}
END_PRINT

close $FH;

system "clang -o $file_base $out_file -O3 -march=native";
