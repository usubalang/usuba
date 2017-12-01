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

my $bench   = "DES no ortho";
my $outfile = 'data.dat';

my %arch = (
    std => 'GP-64',
    sse => 'SSE-128',
    avx => 'AVX-256',
    avx512 => 'AVX-512',
    des_kwan => "GP-64\\n(manual)"
    );

sub talk {
    say "Bench $bench: ", @_;
}

my $cflags = "-O3 -Iarch -std=gnu11 -march=native  -mavx512bw -mavx512f";

talk "Compiling the C files";
for my $arch (keys %arch) {
    system "$cc $cflags $arch.c -o $arch";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    while (my ($arch,$name) = each %arch) {
        $times{$name} += (split ' ', `./$arch`)[0] / $nb_run;
    }
}


# Fixing the throughput values
for my $name (values %arch) {
    $times{$name} = sprintf "%d", $times{$name};
}

# Printing the results
open my $FH, '>', $outfile or die $!;
for my $arch (sort {$times{$a} <=> $times{$b}} keys %times) {
    say $FH qq{"$arch" $times{$arch}};
}
close $FH;


# Clean files
unlink $_ for keys %arch, "output.txt";
