#!/usr/bin/perl

# This scripts computes how many cycles are needed to execute a
# ripple-carry adder in software if we consider a greedy instruction
# scheduler.
#
# This number of cycles can be amortized when multiple adders are
# executing back to back: one can start executing before the previous
# one is done.
#
# The size of the adder, the number of instructions executed per
# cycles, as well as the number of back to back adders can be
# configured by changing the variables $adder_size, $ipc and
# $chain_size.

use strict;
use warnings;
use feature 'say';
use Data::Printer;

my $adder_size = 8;
my $ipc = 3; # Should be 3 for SIMD, and 4 for general purpose
my $chain_size = 10;

# The operations forming a full adder.
#  "X" means that the variable comes from the previous adder
#  "Y" means that the variable is computed by this adder
my %full_adder = (
    t1Y => ["xor", "aX", "bX"],
    t2Y => ["and", "aX", "bX"],
    sY => ["xor", "cX", "t1Y"],
    t3Y => ["and", "cX", "t1Y"],
    cY => ["xor", "t3Y", "t2Y"]);

# The variables available at the begining (the inputs + the first carry)
my %ready;
for my $i (1 .. $chain_size) {
    $ready{"c.$i.1"} = 1;
    for my $j (1 .. $adder_size) {
        $ready{"a.$i.$j"} = $ready{"b.$i.$j"} = 1;
    }
}

# The variables that need to be computed
my %todo;
for my $i (1 .. $chain_size) {
    # Adding first adder (it's simpler because its input carry is 0)
    $todo{($i-1)*$adder_size+1}{"s.$i.2"} = ["xor","a.$i.1","b.$i.1"];
    $todo{($i-1)*$adder_size+1}{"c.$i.2"} = ["and","a.$i.1","b.$i.1"];

    # Adding other adders
    for my $j (2 .. $adder_size) {
        my ($current, $next) = (".$i.$j", ".$i." . ($j+1));
        for my $var (keys %full_adder) {
            my @deps = @{$full_adder{$var}};
            ($var, @deps) = map { s/X/$current/r } map { s/Y/$next/r } $var, @deps;
            $todo{($i-1)*$adder_size+$j}->{$var} = \@deps;
        }
    }
    # Removing the last carry
    delete $todo{($i-1)*$adder_size+$adder_size}{"c.$i.".($adder_size+1)};
    delete $todo{($i-1)*$adder_size+$adder_size}{"t2.$i.".($adder_size+1)};
    delete $todo{($i-1)*$adder_size+$adder_size}{"t3.$i.".($adder_size+1)};
}

# Computing a scheduling
#  This means scheduling the oldest instructions greedily until no
#  variable needs to be computed
my $cycle_count = 0;
while (keys %todo > 0) {
    $cycle_count++;
    my %done_this_cycle;
    for (1 .. $ipc) {
        outer:
        for my $i (sort { $a <=> $b } keys %todo) {
            for my $var (keys %{$todo{$i}}) {
                my ($op, $d1, $d2) = @{$todo{$i}{$var}};
                next unless exists $ready{$d1} && exists $ready{$d2};
                $done_this_cycle{$var} = 1;
                delete $todo{$i}{$var};
                if (keys %{$todo{$i}} == 0) {
                    delete $todo{$i};
                }
                print "$var=$d1 $op $d2    ";
                last outer;
            }
        }
    }
    @ready{keys %done_this_cycle} = values %done_this_cycle;
    say "";
}
say $cycle_count;
