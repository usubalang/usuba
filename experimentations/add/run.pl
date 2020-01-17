#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use List::Util qw(sum);

my $nb_runs = 10;
my @sizes = qw(8 16 32);

chdir $FindBin::Bin;

system "make clean && make";
print "\n\n";

# Measuring
my %times;
for (1 .. $nb_runs) {
    for my $size (@sizes) {
        my $res = `./add_$size`;
        my ($bs_tot, $bs_add) =   $res =~ m{bitslice add:\s*(.*) cycles/loop\s*\((.*) cycles};
        my ($pck_tot, $pck_add) = $res =~ m{packed add:\s*(.*) cycles/loop\s*\((.*) cycles};
        my ($par_tot, $par_add) = $res =~ m{parallel add:\s*(.*) cycles/loop\s*\((.*) cycles};
        push @{$times{$size}->{bitslice}->{tot}}, $bs_tot;
        push @{$times{$size}->{packed_single}->{tot}}, $pck_tot;
        push @{$times{$size}->{packed_parallel}->{tot}}, $par_tot;
        push @{$times{$size}->{bitslice}->{add}}, $bs_add;
        push @{$times{$size}->{packed_single}->{add}}, $pck_add;
        push @{$times{$size}->{packed_parallel}->{add}}, $par_add;
    }
}

# Printing results
print "|    **addition type**   |  **cycles/loop** |  **cycles/add** |\n";
print "| ---------------------- | ---------------- | --------------- |\n";
for my $size (@sizes) {
    for my $slicing (qw(bitslice packed_single packed_parallel)) {
        printf "| %2d-bit %15s | ", $size, $slicing;
        for my $type (qw(tot add)) {
            my $data = $times{$size}->{$slicing}->{$type};
            my $u = sum(@$data)/@$data; # mean
            my $s = ( sum( map {($_-$u)**2} @$data ) / @$data ) ** 0.5; # standard deviation
            printf " %5.2f (+- %.2f) |", $u, $s;
        }
        printf "\n";
    }
    print "| ---------------------- | ---------------- | --------------- |\n";
}
