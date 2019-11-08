#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

Note that for Serpent and AES, you might have to manually modify the Sbox files
the Usuba uses. (Via index_sbox.ml or by modifying the files directly)

=cut
    
use v5.14;
use strict;
use warnings;

my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my @arch = qw( gp sse avx );
my @slicing = qw( vector );

# Compiling
if ($compile) {
    for my $slicing (@slicing) {
        for my $arch (@arch) {
            my $arch_flag = "USE_" . (uc $arch);
            my $inter = '_inter';

            for my $inline ('_inline', '') {
                
                my $cmd = "clang++ -I ../../arch -D$arch_flag -march=native -Wall -Wextra -O3 -c rect_ua_${arch}_${slicing}${inter}${inline}.cpp crypt.cpp test.cpp timing.cpp key.cpp main.cpp stream_${slicing}${inter}.cpp && clang++ -O3 -march=native -o $arch-$slicing$inter$inline timing.o crypt.o key.o test.o main.o stream_${slicing}${inter}.o rect_ua_${arch}_${slicing}${inter}${inline}.o";
                say $cmd;
                system $cmd;
                if ($arch eq 'sse') {
                    my $cmd = "clang++ -I ../../arch -D$arch_flag -msse4.2 -Wall -Wextra -O3 -c rect_ua_${arch}_${slicing}${inter}${inline}.cpp crypt.cpp test.cpp timing.cpp key.cpp main.cpp stream_${slicing}${inter}.cpp && clang++ -O3 -msse4.2 -o ${arch}SSE-$slicing$inter$inline timing.o crypt.o key.o test.o main.o stream_${slicing}${inter}.o rect_ua_${arch}_${slicing}${inter}${inline}.o";
                    system $cmd;
                }
            }
        }
        
    }
}

exit unless $run;

open my $FP_OUT, '>', 'results.txt';
# Runing benchs
for my $slicing (@slicing) {
    say "********************** $slicing **********************";
    for my $arch (@arch) {
        say "+~+~+~+~+~+ ", uc $arch, " +~+~+~+~+~+";
        my $inter = '_inter';

        for my $inline ('_inline', '') {
            next if $inline eq '_inline' && $inter ne '_inter' && $slicing ne 'vector';
            my $res = `./$arch-$slicing$inter$inline`;
            say $res;
            say $FP_OUT "$slicing-$arch$inter$inline $res";
            if ($arch eq 'sse') {
                my $res = `./${arch}SSE-$slicing$inter$inline`;
                say $res;
                say $FP_OUT "$slicing-${arch}SSE$inter$inline $res";                    
            }
        }
    }
}
