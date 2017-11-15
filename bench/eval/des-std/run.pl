#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

my $nb_run = 30;
my $cc = 'clang';

my $bench   = "DES standard";
my $outfile = 'data.dat';

my %arch = (
    std => 'GP-64',
    sse => 'SSE-128',
    avx => 'AVX-256'
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
for my $arch (keys %arch) {
    system "./usubac $opts -arch $arch -o $self_dir/tmp/$arch.c samples/usuba/des.ua";
}

chdir "$self_dir/tmp";

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

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


$times{tot}{Standard} = 75;
$times{ortho}{Standard} = 0;

# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;
for my $arch (sort {$times{tot}{$a} <=> $times{tot}{$b}} keys %{$times{tot}}) {
    printf $FH qq{"$arch" %d %d\n},$times{tot}{$arch}, $times{ortho}{$arch};
}
close $FH;

# Cleaning temporary directory
remove_tree "tmp";


# Generating pdf
system 'gnuplot plot.txt'
