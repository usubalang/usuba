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

my $bench   = "orthogonalization";
my $outfile = 'perf-ortho.tex';

sub talk {
    say "Bench $bench: ", @_;
}


my %benchs = (
    'std.c' => 'GP-64',
    'sse.c' => 'SSE-128',
    'avx.c' => 'AVX-256',
    'avx512.c' => 'AVX-512'
    );

my $cflags = "-O3 -I arch -std=gnu11 -march=native -mavx512bw -mavx512f";

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
open my $FH, '>', $outfile or die $!;

print $FH 
"\\begin{tabular}{|K{2cm}|K{2cm}|K{2cm}|K{2cm}|}
  \\hline
  \\textbf{\\enspace GP (64-bits)} & \\textbf{SSE (128-bits)} & \\textbf{AVX2 (256-bits)} & \\textbf{AVX-512}\\\\
  \\hline
  $times{'GP-64'} & $times{'SSE-128'} & $times{'AVX-256'} & $times{'AVX-512'}\\\\
  \\hline
\\end{tabular}
\\caption{Orthogonalization throughput (MiB/s)}
\\label{tbl:perf-ortho}
";

close $FH;

# Cleaning files
unlink $_ for values %benchs, "output.txt";

