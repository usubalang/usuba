#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use List::Util qw(sum);

my $nb_runs = 10;
my @sizes = qw(8 16 32);

chdir $FindBin::Bin;

system "make";
print "\n\n";

# Measuring
my %times;
for (1 .. $nb_runs) {
    for my $size (@sizes) {
        my $res = `./add_$size`;
        my ($bitslice) = $res =~ /bitslice add: (.*)/;
        my ($packed) = $res =~ /packed add: (.*)/;
        push @{$times{$size}->{bitslice}}, $bitslice;
        push @{$times{$size}->{packed}}, $packed;
    }
}


# Printing results
for my $size (@sizes) {
    printf "%2d-bit addition:\n", $size;
    for my $slicing (qw(bitslice packed)) {
        my $data = $times{$size}->{$slicing};
        my $u = sum(@$data)/@$data; # mean
        my $s = ( sum( map {($_-$u)**2} @$data ) / @$data ) ** 0.5; # standard deviation
        printf "  %9s: %.2f  (+- %.2f)\n", $slicing, $u, $s;
    }
}
