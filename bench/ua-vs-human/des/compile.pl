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
use File::Path qw( make_path );

my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../../arch';
$| = 1;

my $gen     = "@ARGV" =~ /--g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my @binaries;



if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";
    for my $arch (qw( std )) {
        system "./usubac -arch $arch -no-arr -o ciphers/des/$arch/des.c samples/usuba/des.ua";
    }
    chdir "$FindBin::Bin";
    say " done.";
}


print "Compiling the C sources..." if $compile;

make_path 'bin' unless -d 'bin';
for my $implem (qw( ua kwan )) {
    my $arch = 'std';
    my $bin = "bin/$implem-$arch";
    my $cmd = "$CC $CFLAGS $HEADERS -D $arch -D $implem main.c -o $bin";
    system $cmd if $compile;
    push @binaries, $bin;
}

say " done." if $compile;

exit unless $run;
print "Running benchs... ";
# Running the benchs
my %res;
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $bin (@binaries) {
        my $bench = $bin =~ s{bin/}{}r;
        my $cycles = sprintf "%03.02f", (`./$bin` || 0); 
        push @{ $res{$bench}->{details} }, $cycles;
        $res{$bench}->{total} += $cycles;
    }
}
say "\rRunning benchs... done.     ";

unlink $_ for glob("*.txt");

open my $FP_OUT, '>', 'results.txt';
say "Results:";
for my $bin (@binaries) {
    my $bench = $bin =~ s{bin/}{}r;
    printf "%8s : %03.02f  [ %s ]\n", $bench, $res{$bench}->{total} / $NB_LOOP,
        (join ", ", @{$res{$bench}->{details}});
    printf $FP_OUT "%8s %03.02f\n", $bench, $res{$bench}->{total} / $NB_LOOP;
}

