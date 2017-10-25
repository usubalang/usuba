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

my $bench   = "DES no ortho";
my $outfile = 'data-rand.dat';

my %arch = (
    std => 'GP-64',
    sse => 'SSE-128',
    avx => 'AVX-256'
    );

my $opts = "-bench -no-ortho -rand-input";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
for my $arch (keys %arch) {
    system "./usubac $opts -arch $arch -o $self_dir/tmp/$arch.c samples/usuba/des.ua";
}


chdir "$self_dir/tmp";

copy "../../../input.txt", ".";
copy "../des_kwan.c", ".";
$arch{des_kwan} = "GP-64\\n(manual)";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
for my $arch (keys %arch) {
    system "$cc $cflags $arch.c -o $arch";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    while (my ($arch,$name) = each %arch) {
        $times{$name} += `./$arch`;
    }
}


# Fixing the throughput values
my $tot_size = -s 'input.txt';
for my $name (values %arch) {
    $times{$name} = sprintf "%d", $times{$name} / $nb_run;
}

# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;
for my $arch (sort {$times{$a} <=> $times{$b}} keys %times) {
    say $FH qq{"$arch" $times{$arch}};
}
close $FH;

# Cleaning temporary directory
remove_tree "tmp";


# Generating pdf
system 'gnuplot plot-rand.txt'
