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
        my ($tot,$ortho) = split ' ', `./$backend`;
        $times{tot}{$backend} += $tot / $nb_run;
        $times{ortho}{$backend} += $ortho / $nb_run;
    }
}


# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;
for my $backend (sort {$times{tot}{$a} <=> $times{tot}{$b}} keys %{$times{tot}}) {
    printf $FH qq{"$backend" %d %d\n},$times{tot}{$backend}-$times{ortho}{$backend},$times{ortho}{$backend};
}
close $FH;


# Cleaning temporary directory
remove_tree "tmp";


# Generating pdf
system 'Rscript plot.r'
