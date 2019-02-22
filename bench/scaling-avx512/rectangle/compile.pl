#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

=cut

use strict;
use warnings;
no warnings qw( numeric );
use v5.14;

use FindBin;
use File::Path qw(make_path);

my $NB_LOOP = 1;
my $CC      = 'icc';
my $CFLAGS  = '-O3 -std=gnu11';
my $HEADERS = '-I ../../../arch';
$| = 1;


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my $cipher   = 'rectangle';
my @archs = qw( std sse avx avx2 avx512 );
my @slicings = qw( bitslice vslice hslice vslice-inter );

my $pwd = $FindBin::Bin;

my @binaries;

if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../../..";

    # Bitslice
    for my $arch (qw(std sse avx avx512)) {
        my $source = "samples/usuba/rectangle_bitslice.ua";
        system "./usubac -B -arch $arch -o $pwd/bitslice/$arch.c $source";
    }
    # Hslice
    for my $arch (qw(sse avx avx512)) {
        my $source = "samples/usuba/rectangle.ua";
        system "./usubac -H -arch $arch -o $pwd/hslice/$arch.c $source";
    }
    # Vslice
    for my $arch (qw(std sse avx avx512)) {
        my $source = "samples/usuba/rectangle.ua";
        system "./usubac -V -lf -arch $arch -o $pwd/vslice/$arch.c $source";
    }
    # Vslice + interleaving
    for my $arch (qw(std sse avx avx512)) {
        my $source = "samples/usuba/rectangle.ua";
        system "./usubac -V -lf -arch $arch -interleave 5 -o $pwd/vslice-inter/$arch.c $source";
    }

    say " done.";
}

chdir $pwd;

print "Compiling the C sources..." if $compile;
make_path "bin" unless -d "bin";
for my $slicing (@slicings) {
    for my $arch (@archs) {
        my $bin = "bin/$slicing-$arch";

        my $arch_flag = '-D $arch';
        if    ($arch eq 'sse')    { $arch_flag = '-xSSE4.2 -D sse'         }
        elsif ($arch eq 'avx')    { $arch_flag = '-xAVX -D sse'            }
        elsif ($arch eq 'avx2')   { $arch_flag = '-xAVX2 -D avx'           }
        elsif ($arch eq 'avx512') { $arch_flag = '-march=native -D avx512' }
        
        my $source_dir = "$slicing/$arch.c";
        if    ($arch eq 'avx')  { $source_dir = "$slicing/sse.c" }
        elsif ($arch eq 'avx2') { $source_dir = "$slicing/avx.c" }
        
        next if $arch eq 'std' && $slicing eq 'hslice';
        my $cmd = "$CC $arch_flag $CFLAGS $HEADERS -I . -D $arch main_speed.c key.c $slicing/stream.c $source_dir -o $bin";
        system $cmd if $compile;
        push @binaries, $bin;
    }
}

say " done." if $compile;

exit unless $run;
print "Running benchs... ";

my %res;
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $bin (@binaries) {
        my $cycles = sprintf "%03.02f", (`./$bin` || 0); 
        push @{ $res{$bin}->{details} }, $cycles;
        $res{$bin}->{total} += $cycles;
    }
}
say "\rRunning benchs... done.     ";

open my $FP_OUT, '>', 'results.txt';
say "Results:";
for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } @binaries) {
    printf "%8s : %03.02f  [ %s ]\n", $bin, $res{$bin}->{total} / $NB_LOOP,
        (join ", ", @{$res{$bin}->{details}});
    printf $FP_OUT "%8s %03.02f\n", $bin, $res{$bin}->{total} / $NB_LOOP;
}
