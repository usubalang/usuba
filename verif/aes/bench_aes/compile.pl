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

my $NB_LOOP = 2;
$| = 1;

my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my @binaries;



print "Compiling..." if $compile;

# Compiling with Kivilinna implem
system "clang -O3 -march=native -I ../../../arch -D FULL_KIVI -o full_kivi bench_aes.c kivi_orig.S" if $compile;
push @binaries, 'full_kivi';

# Compile with Usuba implem (KIVI is a single KIVI round inside C code written by me)
for my $implem (qw( KIVI MACRO )) {
    for my $direct (qw( DIRECT INDIRECT )) {
        for my $expanded (qw( EXPANDED NOEXP )) {
            system "clang -O3 -march=native -I ../../../arch -D UA_$implem -D $direct -D $expanded -o ua_${implem}_${direct}_${expanded} bench_aes.c" if $compile;
            push @binaries, "ua_${implem}_${direct}_${expanded}";
        }
    }
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

say "Results:";
for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } @binaries) {
    printf "%26s : %03.02f  [ %s ]\n", $bin, $res{$bin}->{total} / $NB_LOOP,
        (join ", ", @{$res{$bin}->{details}});
}
