#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use List::Util qw( max );
use Math::Round;
use FindBin;

my $nb_run = 30;
my $cc = 'clang';

my $bench   = "DES standard";
my $outfile = 'data2.dat';

my %arch = (
    'GP-8'    => ['std', '-bits-per-reg 8'],
    'GP-16'   => ['std', '-bits-per-reg 16'],
    'GP-32'   => ['std', '-bits-per-reg 32'],
    'GP-64'   => ['std', ''],
    'SSE-128' => ['sse', ''],
    'AVX-256' => ['avx', '']
    );

my $opts = "-bench";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
for my $backend (keys %arch) {
    my ($arch,$opt) = @{$arch{$backend}};
    system "./usubac $opts $opt -arch $arch -o $self_dir/tmp/$backend.c samples/usuba/des.ua";
}


chdir "$self_dir/tmp";

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
for my $backend (keys %arch) {
    system "$cc $cflags $backend.c -o $backend";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $backend (keys %arch) {
        $times{$backend} += `./$backend`
    }
}


# Fixing the throughput values
my $tot_size = -s 'input.txt';
for my $backend (keys %times) {
    $times{$backend} = sprintf "%d", ($tot_size*16) * $nb_run / $times{$backend} / 1_000_000;
}

# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;
for my $backend (sort {$times{$a} <=> $times{$b}} keys %times) {
    say $FH qq{"$backend" $times{$backend}};
}
close $FH;


# Cleaning temporary directory
remove_tree "tmp";


# Generating pdf
system 'gnuplot plot2.txt'
