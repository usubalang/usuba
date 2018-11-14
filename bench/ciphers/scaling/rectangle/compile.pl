#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r]

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

my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../../../arch';
$| = 1;

my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my $cipher   = 'rectangle';
my @archs    = qw( std sse avx );
my @slicings = qw( bitslice vslice hslice vslice-inter );

my @binaries;



if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../../../..";
    for my $arch (@archs) {
        my $add_opt = $arch eq 'std' ? '-bits-per-reg 16' : '';
        system "./usubac -arch $arch -o $FindBin::Bin/hslice/$arch.c samples/usuba/rectangle_nslice.ua" if $arch ne 'std';
        system "./usubac -no-share -no-arr -arch $arch -o $FindBin::Bin/bitslice/$arch.c samples/usuba/rectangle_bitslice.ua";
        system "./usubac $add_opt -lf -arch $arch -o $FindBin::Bin/vslice/$arch.c samples/usuba/rectangle_vector.ua";
        system "./usubac $add_opt -lf -arch $arch -interleave 10 -o $FindBin::Bin/vslice-inter/$arch.c samples/usuba/rectangle_vector.ua";
    }
    chdir "$FindBin::Bin";
    say " done.";
}

print "Compiling the C sources..." if $compile;
make_path "bin" unless -d "bin";
for my $slicing (@slicings) {
    for my $arch (@archs) {
        next if $arch eq 'std' && $slicing eq 'hslice';
        my $bin = "bin/$slicing-$arch";
        my $cmd = "$CC $CFLAGS $HEADERS -I . -D $arch main_speed.c key.c $slicing/stream.c $slicing/$arch.c -o $bin";
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
        my $cycles = sprintf "%03.02f", `./$bin`; 
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
