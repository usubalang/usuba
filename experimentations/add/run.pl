#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use List::Util qw(sum);

my $nb_runs = 10;
my @sizes = qw(8 16 32);

chdir $FindBin::Bin;


# Measuring
my %times;
for my $arch (qw(SSE GP)) {

    system "make clean && make ARCH=$arch";
    print "\n\n";

    for (1 .. $nb_runs) {
        for my $size (@sizes) {
            my $res = `./add_$size`;
            my ($bs_tot, $bs_add) =   $res =~ m{bitslice add:\s*(.*) cycles/loop\s*\((.*) cycles};
            my ($pck_tot, $pck_add) = $res =~ m{packed add:\s*(.*) cycles/loop\s*\((.*) cycles};
            my ($par_tot, $par_add) = $res =~ m{parallel add:\s*(.*) cycles/loop\s*\((.*) cycles};
            push @{$times{$arch}->{$size}->{bitslice}->{tot}}, $bs_tot;
            push @{$times{$arch}->{$size}->{packed_single}->{tot}}, $pck_tot;
            push @{$times{$arch}->{$size}->{packed_parallel}->{tot}}, $par_tot;
            push @{$times{$arch}->{$size}->{bitslice}->{add}}, $bs_add;
            push @{$times{$arch}->{$size}->{packed_single}->{add}}, $pck_add;
            push @{$times{$arch}->{$size}->{packed_parallel}->{add}}, $par_add;
        }
    }
}

# Printing results
print "|    **addition type**   |  **cycles/loop (SSE / GP)** |  **cycles/add  (SSE / GP)** |\n";
print "| ---------------------- | --------------------------- | --------------------------- |\n";
for my $size (@sizes) {
    for my $slicing (qw(bitslice packed_single packed_parallel)) {
        printf "| %2d-bit %15s | ", $size, $slicing;
        for my $type (qw(tot add)) {
            my $data_gp = $times{GP}->{$size}->{$slicing}->{$type};
            my $data_sse = $times{SSE}->{$size}->{$slicing}->{$type};
            my $u_gp = sum(@$data_gp)/@$data_gp; # mean
            my $s_gp = ( sum( map {($_-$u_gp)**2} @$data_gp ) / @$data_gp ) ** 0.5; # standard deviation
            my $u_sse = sum(@$data_sse)/@$data_sse; # mean
            my $s_sse = ( sum( map {($_-$u_sse)**2} @$data_sse ) / @$data_sse ) ** 0.5; # standard deviation
            if ($s_gp * 20 > $u_gp) {
                die "Standard deviation too high ($size/$slicing/GP):  $u_gp +- $s_gp";
            } elsif ($s_sse * 50 > $u_sse) {
                die "Standard deviation too high ($size/$slicing/SSE): $u_sse +- $s_sse";
            }
            printf "    %5.2f    /    %5.2f     | ", $u_sse, $u_gp;
        }
        printf "\n";
    }
    if ($size != 32) {
        print "|         &nbsp;         |          &nbsp;             |             &nbsp;          |\n";
    }
}
