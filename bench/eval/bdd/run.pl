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

my $bench   = "BDD";
my $outfile = 'perf-bdd.tex';

my $opts = "-bench -arch avx";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
system "./usubac -no-precalc-tbl $opts -o $self_dir/tmp/bdd-w.c samples/usuba/des.ua";
system "./usubac -no-precalc-tbl $opts -no-ortho -o $self_dir/tmp/bdd-n.c samples/usuba/des.ua";
system "./usubac $opts -o $self_dir/tmp/kwan-w.c samples/usuba/des.ua";
system "./usubac $opts -no-ortho -o $self_dir/tmp/kwan-n.c samples/usuba/des.ua";


chdir "$self_dir/tmp";

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
my (@files) = qw(bdd-w bdd-n kwan-w kwan-n);
for my $file (@files) {
    system "$cc $cflags $file.c -o $file";
}

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $file (@files) {
        $times{$file} += `./$file`;
    }
}

# Fixing the throughput values
my $tot_size = -s 'input.txt';
for my $name (keys %times) {
    $times{$name} = sprintf "%d", ($tot_size*16) * $nb_run / $times{$name} / 1_000_000;
}

# Printing the results
chdir "..";
open my $FH, '>', $outfile or die $!;

print $FH 
"\\begin{table}[h]
  \\begin{tabular}{|K{2.5cm}|K{2.5cm}|K{2.5cm}|}
    \\hline
    & \\multicolumn{2}{|c|}{ \\textbf{Speed (MiB/s)} } \\\\
    \\hline
    \\textbf{Algorithm} & \\textbf{BDD-generated S-boxes} & \\textbf{Kwan's S-boxes}\\\\
    \\hline\\hline
    DES w/o ortho & $times{'bdd-n'} & $times{'kwan-n'} \\\\
    \\hline
    DES w ortho & $times{'bdd-w'} & $times{'kwan-w'} \\\\
    \\hline
  \\end{tabular}
  \\caption{Comparison of BDD-generated and Kwan's S-boxes}
  \\label{tbl:perf-bdd}
\\end{table}";

close $FH;

# Cleaning temporary directory
remove_tree "tmp";

