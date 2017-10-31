#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use File::Copy;
use File::Path;

my $nb_run  = 30;
my $outfile = 'neon.tex';

my %benchs = (
    'bench-neon-no-ortho' => 'Neon no ortho',
    'bench-neon-ortho'    => 'Neon with ortho',
    'bench-u64-no-ortho'  => 'GP-64 no ortho',
    'bench-u64-ortho'  => 'GP-64 with ortho',
    );

my %times;
for (1 .. $nb_run) {
    for my $bench (keys %benchs) {
        $times{$bench} += (split ' ',`./$bench`)[0] / $nb_run;
    }
}

my ($neon_w, $neon_n, $gp64_w, $gp64_n) =
    @times{qw(bench-neon-ortho bench-neon-no-ortho
              bench-u64-ortho  bench-u64-no-ortho)};

my $neon_speedup_n = - ($gp64_n-$neon_n) / $gp64_n * 100;
my $neon_speedup_w = - ($gp64_w-$neon_w) / $gp64_w * 100;
    
open my $FH, '>', $outfile or die $!;
printf $FH '
\\begin{table}[ht!]
  \\begin{tabular}{|l K{1.5cm}|K{2cm}|K{2cm}|K{1.5cm}|}
    \\hline
    \\textbf{Ortho} & \\textbf{GP-64} &\\textbf{Neon} & \\textbf{Speedup} \\\\
    \\hline\\hline
    with    & %d & %d & +%d\\%%\\\\
    \\hline
    without & %d & %d & +%d\\%%\\\\
    \\hline
  \\end{tabular}
  \\caption{Performances of Usuba\'s DES on ARMv7l (MiB/s)}
  \\label{tbl:perf-arm}
\\end{table}
', $gp64_w, $neon_w, $neon_speedup_w,
    $gp64_n, $neon_n, $neon_speedup_n;

