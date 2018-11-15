#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

=cut
    
use strict;
use warnings;
no warnings qw( numeric );
use v5.14;

use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

my $AVX512  = 0;

my $NB_LOOP = 20;
my $CC      = 'icc';
my $CFLAGS  = '-O3 -std=gnu11';
my $HEADERS = '-I arch';
$| = 1;


my @arch    = qw(gp sse avx avx2 avx512);
my @slicing = qw(bitslice vslice hslice);


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";



if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";

    for my $arch (@arch) {
        my $arch_flag = '';
        if    ($arch eq 'sse')    { $arch_flag = '-xSSE4.2'      }
        elsif ($arch eq 'avx')    { $arch_flag = '-xAVX'         }
        elsif ($arch eq 'avx2')   { $arch_flag = '-xAVX2'        }
        elsif ($arch eq 'avx512') { $arch_flag = '-march=native' }
        
        for my $slicing (@slicing) {
            my $source = "$slicing/$arch.c";

            if ($arch eq 'avx')     { $source = "$slicing/sse.c" }
            elsif ($arch eq 'avx2') { $source = "$slicing/avx.c" }
            
            next unless -f $source;
            system "$CC $arch_flag $CFLAGS $HEADERS $source -o bin/$slicing-$arch";
        }
    }
    
    say " done.";
}

exit unless $run;

make_path "results" unless -d "results";

print "Running benchs...";
my (%formatted, %res);
for ( 1 .. $NB_LOOP ) {
    for my $arch (@arch) {
        for  my $slicing (@slicing) {
            my $bin = "bin/$slicing-$arch";
            next unless -f $bin;
            my $cycles = sprintf "%03.02f", `./$bin`;
            push @{ $res{$bin}->{details} }, $cycles;
            $res{$bin}->{total} += $cycles;
        }
    }
}
say " done.";

say "Resuts:";
open my $FP_OUT, '>', "results/results.txt";
for  my $slicing (@slicing) {
    say "$slicing:";
    say $FP_OUT "$slicing:";
    for my $arch (@arch) {
        my $bin = "bin/$slicing-$arch";
        next unless -f $bin;
        printf "  %3s: %03.02f  [ %s ]\n", $arch, $res{$bin}->{total} / $NB_LOOP,
           (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "  %3s: %.02f\n", $arch, $res{$bin}->{total} / $NB_LOOP;
    }
}
