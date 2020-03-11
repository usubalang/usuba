#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use List::Util qw(sum);
use feature 'say';

my $nb_runs = 10;
my @sizes = qw(8 16 32);

chdir $FindBin::Bin;


# Measuring
my %times;
for my $arch (qw(AVX SSE GP)) {

    my $arch_flag = $arch eq 'SSE' ? '-msse4.2' : '-march=native';

    system "make clean && make ARCH_FLAG=$arch_flag ARCH=$arch";
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
print "|    **addition type**   |  **cycles/loop (AVX / SSE / GP)** |  **cycles/add  (AVX / SSE / GP)** |\n";
print "| ---------------------- | --------------------------------- | --------------------------------- |\n";
for my $size (@sizes) {
    for my $slicing (qw(bitslice packed_single packed_parallel)) {
        printf "| %2d-bit %15s | ", $size, $slicing;
        for my $type (qw(tot add)) {
            my $data_gp = $times{GP}->{$size}->{$slicing}->{$type};
            my $data_sse = $times{SSE}->{$size}->{$slicing}->{$type};
            my $data_avx = $times{AVX}->{$size}->{$slicing}->{$type};
            my $u_gp = sum(@$data_gp)/@$data_gp; # mean
            my $s_gp = ( sum( map {($_-$u_gp)**2} @$data_gp ) / @$data_gp ) ** 0.5; # standard deviation
            my $u_sse = sum(@$data_sse)/@$data_sse; # mean
            my $s_sse = ( sum( map {($_-$u_sse)**2} @$data_sse ) / @$data_sse ) ** 0.5; # standard deviation
            my $u_avx = sum(@$data_avx)/@$data_avx; # mean
            my $s_avx = ( sum( map {($_-$u_avx)**2} @$data_avx ) / @$data_avx ) ** 0.5; # standard deviation
            if ($s_gp * 20 > $u_gp) {
                say "Standard deviation too high ($size/$slicing/GP):  $u_gp +- $s_gp";
            } elsif ($s_sse * 20 > $u_sse) {
                say "Standard deviation too high ($size/$slicing/SSE): $u_sse +- $s_sse";
            } elsif ($s_avx * 20 > $u_avx) {
                say "Standard deviation too high ($size/$slicing/SSE): $u_avx +- $s_avx";
            }
            printf "   %5.2f   /   %5.2f  /  %5.2f   | ", $u_avx, $u_sse, $u_gp;
        }
        printf "\n";
    }
    if ($size != 32) {
        print "|         &nbsp;         |             &nbsp;                |                &nbsp;             |\n";
    }
}
