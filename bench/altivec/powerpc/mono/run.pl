#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use File::Copy;
use File::Path;
use FindBin;

chdir $FindBin::Bin;

my $nb_run  = 30;
my $outfile = 'altivec.tex';

system "make";

my %benchs = (
    'bench-vector-no-ortho' => 'Vector no ortho',
    'bench-vector-ortho'    => 'Vector with ortho',
    'bench-u64-no-ortho'  => 'GP-64 no ortho',
    'bench-u64-ortho'  => 'GP-64 with ortho',
    );

my %times;
for (1 .. $nb_run) {
    my %loc_time;
    for my $bench (keys %benchs) {
        my $time = (split ' ',`./$bench`)[0];
        $loc_time{$bench} = $time;
        $times{$bench} += $time / $nb_run;
    }
    open my $FH, '>>', 'data.txt' or die $!;
    for my $bench (keys %loc_time) {
        printf $FH "$bench %.4f\n", $loc_time{$bench};
    }
    close $FH;
}

my ($vector_w, $vector_n, $gp64_w, $gp64_n) =
    @times{qw(bench-vector-ortho bench-vector-no-ortho
              bench-u64-ortho  bench-u64-no-ortho)};

my $vector_speedup_n = $vector_n / $gp64_n;
my $vector_speedup_w = $vector_w / $gp64_w;
    
open my $FH, '>', $outfile or die $!;
printf $FH '
\\begin{table}[ht!]
  \\begin{tabular}{|l K{1.5cm}|K{2cm}|K{2cm}|K{1.5cm}|}
    \\hline
    \\textbf{Ortho} & \\textbf{GP-64} &\\textbf{Vector} & \\textbf{Speedup} \\\\
    \\hline\\hline
    with    & %d & %d & x%.2f\\\\
    \\hline
    without & %d & %d & x%.2f\\\\
    \\hline
  \\end{tabular}
  \\caption{Performances of Usuba\'s DES on Power7 (MiB/s)}
  \\label{tbl:perf-power}
\\end{table}
', $gp64_w, $vector_w, $vector_speedup_w,
    $gp64_n, $vector_n, $vector_speedup_n;

