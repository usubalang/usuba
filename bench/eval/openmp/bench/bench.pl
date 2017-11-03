#!/usr/bin/perl

use strict;
use warnings;
use v5.18;


my $nb_run  = 30;
my $bench   = "OpenMP";
my $cc      = "gcc";
my $opts    = "-std=gnu11 -fopenmp -O3 -march=native -Iarch";

sub talk {
    say "Bench $bench: ", @_;
}


system "$cc $opts -o des-bench des-bench.c";

talk "Running benchmarks.";
my %times;
for (1 .. $nb_run) {
    for my $line (split "\n", `./des-bench`) {
        my ($nb_cores,$cycles) = split /\s*:\s*/, $line;
        $times{$nb_cores} += $cycles / $nb_run;
    }
    open my $FH, '>', 'data.dat' or die $!;
    for my $cores (sort keys %times) {
        printf $FH "$cores %.4f\n", $times{$cores} * ($nb_run / $_);
    }
}

open my $FH, '>', 'data.dat' or die $!;
for my $cores (sort keys %times) {
    printf $FH "$cores %.4f\n", $times{$cores};
}
