#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use List::Util qw( sum );

my $nb_runs = 10;

my %times;
for (1 .. $nb_runs) {
    for my $n (4 .. 64) {
        system "./gen_adder.pl $n > adder_bs.c";
        system "clang -Wall -Wextra -fno-tree-vectorize -fno-tree-slp-vectorize -O3 all_bitslice_adders.c -march=native -D SSE -D VOLATILE -o adder_bs";
        my $res = `./adder_bs`;
        my ($tot, $add) =   $res =~ m{bitslice add:\s*(.*) cycles/loop\s*\((.*) cycles};
        push @{$times{$n}->{tot}}, $tot;
        push @{$times{$n}->{add}}, $add;
    }
}

for my $n (4 .. 64) {
    for my $type (qw(tot)) {
        my $data = $times{$n}->{$type};
        my $u = sum(@$data)/@$data; # mean
        my $s = ( sum( map {($_-$u)**2} @$data ) / @$data ) ** 0.5; # standard deviation
        printf "$n: %5.2f (+- %5.2f)\n", $u, $s;
    }
}
