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
        $ORTHOGONALIZE = 
"void orthogonalize(unsigned long data[]){
  real_ortho(data);
}";
        $UNORTHOGONALIZE =
"void unorthogonalize(unsigned long data[]){
  real_ortho(data);
}";
    }
    when("__m64") {
        $SIZE_SLICE   = '64';
        $SET_ALL_ONE  = '_mm_cmpeq_pi32(_mm_setzero_si64(),_mm_setzero_si64())';
        $SET_ALL_ZERO = '_mm_setzero_si64()';
        $ORTHOGONALIZE =
"void orthogonalize(unsigned long data[], __m64* out){
  real_ortho(data);
  for (int i = 0; i < 64; i++)
    out[i] = _mm_cvtsi64_m64(data[i]);
}";
        $UNORTHOGONALIZE = 
"void unorthogonalize(__m64* in, unsigned long data[]){
  for (int i = 0; i < 64; i++)
    data[i] = _mm_cvtm64_si64(in[i]);
  real_ortho(data);
}
";
    }
    when("__m128i") {
        $SIZE_SLICE   = '128';
        $SET_ALL_ONE  = '_mm_cmpeq_epi64(key_ortho[i],key_ortho[i])';
        $SET_ALL_ZERO = '_mm_setzero_si128()';
        $ORTHOGONALIZE = 
"void orthogonalize(unsigned long* data, __m128i* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++)
    out[i] = _mm_set_epi64x(data[i], data[64+i]);
}";
        $UNORTHOGONALIZE = 
"void unorthogonalize(__m128i *in, unsigned long* data) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}";
    }
    when("__m256i") {
        $SIZE_SLICE   = '256';
        $SET_ALL_ONE  = '_mm256_cmpeq_epi64(_mm256_setzero_si256(),_mm256_setzero_si256())';
        $SET_ALL_ZERO = '_mm256_setzero_si256()';
        $ORTHOGONALIZE = 
"void orthogonalize(unsigned long* data, __m256i* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
  for (int i = 0; i < 64; i++)
    out[i] = _mm256_set_epi64x(data[i], data[64+i], data[128+i], data[192+i]);
}";
        $UNORTHOGONALIZE = 
"void unorthogonalize(__m256i *in, unsigned long* data) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[4];
    _mm256_store_si256 ((__m256i*)tmp, in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
    data[128+i] = tmp[2];
    data[192+i] = tmp[3];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
}";
    }
    default {
        die "Unknown type '$TYPE'";
    }
}

if ($TYPE eq 'unsigned long') {
    $DECL = qq{unsigned long *plain_std = malloc(64 * sizeof *plain_std);
  unsigned long *cipher_std = malloc(64 * sizeof *cipher_std);};
    $MAIN_CALL = "des__(plain_std, key_ortho, cipher_std);";
    $ORTHO_CALL = "orthogonalize(plain_std);";
    $UNORTHO_CALL = "unorthogonalize(cipher_std);";
} else {
    $DECL = qq{unsigned long *plain_std = aligned_alloc(32,$SIZE_SLICE * sizeof *plain_std);
  $TYPE *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  $TYPE *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = aligned_alloc(32,$SIZE_SLICE * sizeof *cipher_std);};
    $MAIN_CALL = "des__(plain_ortho, key_ortho, cipher_ortho);";
    $ORTHO_CALL = "orthogonalize(plain_std, plain_ortho);";
    $UNORTHO_CALL = "unorthogonalize(cipher_ortho,cipher_std);";
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

static unsigned long mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static unsigned long mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};


void real_ortho(unsigned long data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        unsigned long u = data[j + k] & mask_l[i];
        unsigned long v = data[j + k] & mask_r[i];
        unsigned long x = data[j + n + k] & mask_l[i];
        unsigned long y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

$ORTHOGONALIZE

$UNORTHOGONALIZE

int main() {
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  $DECL
  
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

    for (int i = 0; i < $SIZE_SLICE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    $ORTHO_CALL
    
    $MAIN_CALL
             
    $UNORTHO_CALL
    
    for (int i = 0; i < $SIZE_SLICE; i++)
      cipher_std[i] = __builtin_bswap64(cipher_std[i]);

    fwrite(cipher_std, 8, $SIZE_SLICE, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
END_PRINT

close $FH;

system "clang -o $file_base $out_file -O3 -march=native";
