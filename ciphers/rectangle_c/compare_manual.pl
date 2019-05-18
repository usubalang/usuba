#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use FindBin;
chdir $FindBin::Bin;

my $NB_RUN = 10;

my $compile_line = 'clang -Dstd -Wall -Wextra -O3 -march=native -I. -I ../../arch main.c key.c bitslice/stream.c';
system "$compile_line bitslice/manual.c -o main_manual";
system "$compile_line bitslice/std.c -o main_usuba";

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
