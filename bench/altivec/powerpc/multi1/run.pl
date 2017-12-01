#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use FindBin;

chdir $FindBin::Bin;


my $nb_run  = 30;
my $bench   = "OpenMP 1";

sub talk {
    say "Bench $bench: ", @_;
}


system "make";

unlink "data.txt";

talk "Running benchmarks.";
for (1 .. $nb_run) {
    my %times;
    for my $line (split "\n", `./des-bench`) {
        my ($nb_cores,$cycles,$size) = $line =~ /(\d+)\s*:\s*(\d+.\d+)\s*(\d+)/;
        $times{$nb_cores} += $size/$cycles;
    }
    open my $FH, '>>', 'data.txt' or die $!;
    for my $cores (sort {$a <=> $b} keys %times) {
        printf $FH "$cores %.4f\n", $times{$cores};
    }
    close $FH;
}

