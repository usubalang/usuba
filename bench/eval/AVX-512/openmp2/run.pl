#!/usr/bin/perl

use strict;
use warnings;
use v5.18;


my $nb_run  = $ARGV[0] // 30;
my $cc      = "gcc";

my $bench   = "OpenMP";
my $outfile = "data.dat";

my $opts    = "-std=gnu11 -mavx512bw -mavx512f -march=native -fopenmp -O3 -Iarch";

unlink $outfile;

sub talk {
    say "Bench $bench: ", @_;
}

talk "Compiling benchmarks.";
system "$cc $opts -o des des.c";

talk "Running benchmarks.";
my %times;
for (1 .. $nb_run) {
    for my $line (split "\n", `./des`) {
        my ($nb_cores,$cycles) = split /\s*:\s*/, $line;
        $times{$nb_cores} += $cycles / $nb_run;
    }
    open my $FH, '>>', $outfile or die $!;
    for my $cores (sort keys %times) {
        printf $FH "$cores %.4f\n", $times{$cores} * ($nb_run / $_);
    }
}

unlink $_ for qw( output.txt des );
