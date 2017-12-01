#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

chdir $FindBin::Bin;

my $nb_run = $ARGV[0] // 30;
my $cc = $ARGV[1] // 'clang';

my $bench   = "DES standard";
my $outfile = 'data.dat';

my %arch = (
    std => 'GP-64',
    sse => 'SSE-128',
    avx => 'AVX-256',
    avx512 => 'AVX-512'
    );

my $opts = "-bench";

sub talk {
    say "Bench $bench: ", @_;
}

my $cflags = "-O3 -Iarch -march=native -std=gnu11  -mavx512bw -mavx512f";

talk "Compiling the C files";
for my $arch (keys %arch) {
    system "$cc $cflags $arch.c -o $arch";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    while (my ($arch,$name) = each %arch) {
        my ($tot,$ortho) = split ' ', `./$arch`;
        $times{tot}{$name} += $tot / $nb_run;
        $times{ortho}{$name} += $ortho / $nb_run;
    }
}

# Printing the results
open my $FH, '>', $outfile or die $!;
for my $arch (sort {$times{tot}{$a} <=> $times{tot}{$b}} keys %{$times{tot}}) {
    printf $FH qq{"$arch" %d %d\n},$times{tot}{$arch}, $times{ortho}{$arch};
}
close $FH;

# Cleaning files
unlink $_ for keys %arch, "output.txt";
