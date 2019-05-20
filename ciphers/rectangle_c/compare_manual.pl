#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use FindBin;
chdir $FindBin::Bin;

my $arch = "@ARGV" =~ /sse/i ? 'sse' : 'std';

my $NB_RUN = 10;

my $compile_line = "clang -D $arch -Wall -Wextra -O3 -march=native -fno-slp-vectorize -fno-tree-vectorize -I. -I ../../arch main.c key.c bitslice/stream.c";
system "$compile_line bitslice/manual_$arch.c -o main_manual";
system "$compile_line bitslice/$arch.c -o main_usuba";

my %time;
for (1 .. $NB_RUN) {
    for my $implem (qw(manual usuba)) {
        my ($t) = `./main_$implem` =~ /Usuba: (\d+(?:\.\d+)?)/;
        $time{$implem} += $t;
    }
}

for my $implem (sort { $time{$b} <=> $time{$a} } keys %time) {
    printf "%6s: %.2f\n", $implem, $time{$implem}/$NB_RUN;
}
