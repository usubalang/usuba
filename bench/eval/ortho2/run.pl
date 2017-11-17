#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

my $nb_run = $ARGV[0] // 30;
my $cc = $ARGV[1] // 'clang';

my $bench   = "orthogonalization";
my $outfile = 'data.dat';

sub talk {
    say "Bench $bench: ", @_;
}


my %benchs = (
    #'std8.c' => 'GP-8',
    'std16.c' => 'GP-16',
    'std32.c' => 'GP-32',
    'std.c' => 'GP-64',
    'sse.c' => 'SSE-128',
    'avx.c' => 'AVX-256'
    );

my %bits = (
    'GP-8'    => 8**2,
    'GP-16'   => 16**2,
    'GP-32'   => 32**2,
    'GP-64'   => 64**2,
    'SSE-128' => 128**2,
    'AVX-256' => 256**2
    );

chdir $FindBin::Bin;

make_path 'tmp';
copy $_, 'tmp' for keys %benchs;
chdir 'tmp';

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
for my $file (keys %benchs) {
    system "$cc $cflags $file -o $benchs{$file}";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $file (values %benchs) {
        $times{$file} += `./$file` / $nb_run;
    }
}

# Fixing the throughput values
for my $name (keys %times) {
    $times{$name} = sprintf "%d", $times{$name};
}

# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;
for my $arch (sort {$times{$a} <=> $times{$b}} keys %times) {
    printf $FH qq{"$arch" %.2f\n},$times{$arch}/$bits{$arch};
}
close $FH;

# Cleaning temporary directory
remove_tree "tmp";


# Plotting the data
system "gnuplot plot.txt"
