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

my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../arch';
$| = 1;

my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my @binaries;



if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";
    for my $arch (qw( std sse avx )) {
        system "./usubac -arch $arch -no-arr -sched-n 0 -o ciphers/des/$arch/des.c samples/usuba/des.ua";
    }
    chdir "$FindBin::Bin";
    say " done.";
}


print "Compiling the C sources..." if $compile;

for my $arch (qw( std sse avx )) {
    for my $implem (qw( ua kwan )) {
        my $bin = "$implem-$arch";
        my $cmd = "$CC $CFLAGS $HEADERS -D $arch -D $implem main.c -o $bin";
        system $cmd if $compile;
        push @binaries, $bin;
    }
}
if (! -f 'input.txt') {
    system 'head -c 8M </dev/urandom > input.txt';
}

say " done." if $compile;

exit unless $run;
print "Running benchs... ";
# Running the benchs
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
