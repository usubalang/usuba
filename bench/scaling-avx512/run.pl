#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r] [-l]

To compile and run, `./compile.pl` (or `./compile.pl -c -r -l`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`.
To collect the results only, `./compile -l`.

=cut
    
use strict;
use warnings;
no warnings qw( numeric );
use v5.14;
use autodie qw( open close );

use FindBin;
use File::Path qw(make_path);

chdir "$FindBin::Bin";

my $collect = "@ARGV" =~ /-l/;

if (!$collect) {
    say "Running DES bitslice...";
    system "./des/compile.pl @ARGV";
    
    say "Running AES bitslice...";
    system "./aes-bs/compile.pl @ARGV";
    
    say "Running AES h-slice...";
    system "./aes-hs/compile.pl @ARGV";

    say "Running chacha20 v-slice...";
    system "./chacha20/compile.pl @ARGV";

    say "Running Serpent v-slice...";
    system "./serpent/compile.pl @ARGV";
}


my @ciphers = qw(des aes-bs aes-hs chacha20 serpent rectangle);


if (!@ARGV || $collect) {

    my %results;
    
    for my $cipher (@ciphers) {
        my $res_file = "$cipher/results.txt";
        open my $FP_IN, '<', $res_file;
        while (<$FP_IN>) {
            my ($arch, $perf) = m{bin/(\S+)\s*(\S+)};
            $results{$cipher}->{$arch} = $perf;
        }
    }

    my %formatted;
    for my $cipher (@ciphers) {
        if ($cipher eq 'rectangle') {
            for (keys %{$results{$cipher}}) {
                my ($implem,$arch) = /(.+)-(.+)/;
                my $sse = $results{rectangle}->{"$implem-sse"};
                $formatted{$cipher}->{$_} = $results{$cipher}->{$_} ?
                    $sse / $results{$cipher}->{$_} : 0;
            }
        } else {
            my $sse = $results{$cipher}->{sse};
            for my $arch (keys %{$results{$cipher}}) {
                $formatted{$cipher}->{$arch} = $results{$cipher}->{$arch} != 0 ?
                    $sse / $results{$cipher}->{$arch} : 0;
            }
        }
    }

open my $FP_OUT, '>', 'plot/data-speedup.dat';
printf $FP_OUT
q{archi                              "GP 64-bit"   "SSE 128-bit"     "AVX 128-bit"     "AVX2 256-bit"    "AVX512 512-bit"
"Rectangle    \n        (bitslice)"        %.2f        1         %.2f      %.2f     %.2f
"  DES    \n        (bitslice)"            %.2f        1         %.2f      %.2f     %.2f  
"  AES    \n        (bitslice)"            %.2f        1         %.2f      %.2f     %.2f  
"Rectangle    \n       (hslice)  "          0          1         %.2f      %.2f     %.2f  
"   AES    \n        (hslice)"              0          1         %.2f      %.2f     %.2f 
"Rectangle     \n      (vslice)  "         %.2f        1         %.2f      %.2f     %.2f  
"Serpent      \n     (vslice) "            %.2f        1         %.2f      %.2f     %.2f  
"Chacha20       \n     (vslice)  "         %.2f        1         %.2f      %.2f     %.2f  },
    (map { $formatted{rectangle}->{"bitslice-$_"} }     qw(std avx avx2 avx512)),
    (map { $formatted{des}->{$_} }                      qw(std avx avx2 avx512)),
    (map { $formatted{"aes-bs"}->{$_} }                 qw(std avx avx2 avx512)),
    (map { $formatted{rectangle}->{"hslice-$_"} }       qw(    avx avx2 avx512)),
    (map { $formatted{"aes-hs"}->{$_} }                 qw(    avx avx2 avx512)),
    (map { $formatted{rectangle}->{"vslice-inter-$_"} } qw(std avx avx2 avx512)),
    (map { $formatted{serpent}->{$_} }                  qw(std avx avx2 avx512)),
    (map { $formatted{chacha20}->{$_} }                 qw(std avx avx2 avx512));
        
}

chdir "plot";
#system "gnuplot plot-speedup.txt";
say "Please copy the directory 'bench/schaling-avx512/plot' on your host machine, and run 'gnuplot plot-speedup.txt' in order to generate 'speedup.pdf'.";
