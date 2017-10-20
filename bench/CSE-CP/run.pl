#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use List::Util qw( max );
use FindBin;

my $nb_run = 2;
my @cc = qw(clang gcc);

chdir $FindBin::Bin;

make_path 'tmp';

my $opts = "-no-precalc-tbl -no-sched -no-arr -no-share -bench -no-ortho -arch std";

my $self_dir = getcwd();

chdir "../..";

say "Generating the C files";
system "./usubac -no-CSE-CP $opts -o bench/CSE-CP/tmp/des-no-cse-cp.c sample/usuba/des.ua";
system "./usubac $opts -o bench/CSE-CP/tmp/des-cse-cp.c sample/usuba/des.ua";


chdir "$self_dir/tmp";

copy "../../input.txt", ".";

my $cflags = "-O3 -I ../../../arch -march=native -w";

say "Compiling the C files";
for my $cc (@cc) {
    system "$cc $cflags des-no-cse-cp.c -o $cc-no";
    system "$cc $cflags des-cse-cp.c -o $cc-w";
}

say "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $cc (@cc) {
        $times{w}{$cc} += `./$cc-w`;
        $times{n}{$cc} += `./$cc-no`;
    }
}

my $max = 0;
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
        $times{$exp}{$cc} /= $nb_run;
        $max = max($max,$times{$exp}{$cc});
    }
}
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
        $times{$exp}{$cc} = sprintf "%.2f", 1 / ($times{$exp}{$cc}/$max);
    }
}
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
        say "$cc-$exp:", $times{$exp}{$cc};
    }
}


chdir "..";
open my $FH, '>', 'cse-cp.tex' or die $!;

printf $FH '
\\begin{table}[ht!]
  \\begin{tabular}{|l K{1cm}|K{2cm}|K{2cm}|K{1.5cm}|}
    \hline
    & \\textbf{CC} & \\textbf{w/o CSE-CP} &\\textbf{w CSE-CP} & \\textbf{speedup} \\
    \\hline\\hline
    (1) & \\icc & %.2f & %.2f & +%d\\%%\\\\
    \\hline
    (2) & \\clang & %.2f & %.2f & +%d\\%%\\\\
    \\hline
    (3) & \\gcc & %.2f & %.2f & +%d\\%%\\\\
    \\hline
  \\end{tabular}
  \\caption{Normalized performances of CSE and copy propagation}
  \\label{tbl:perf-cse}
\\end{table}
', $times{n}{icc}, $times{w}{icc},
    $times{n}{clang}, $times{w}{clang},
    $times{n}{gcc}, $times{w}{gcc};


remove_tree "tmp";
