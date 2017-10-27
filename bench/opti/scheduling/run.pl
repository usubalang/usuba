#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use List::Util qw( min );
use Math::Round;
use FindBin;

my $nb_run = 30;
my @cc = qw(clang gcc icc);

my $bench   = "Scheduling";
my $outfile = 'scheduling.tex';

my $opts = "-no-arr -no-share -bench -no-ortho -arch std";

my $out_w = 'des-no-sched.c';
my $out_n = 'des-sched.c';


sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
system "./usubac -no-sched $opts -o $self_dir/tmp/$out_n samples/usuba/des.ua";
system "./usubac $opts -o $self_dir/tmp/$out_w samples/usuba/des.ua";


chdir "$self_dir/tmp";

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
for my $cc (@cc) {
    system "$cc $cflags $out_n -o $cc-no";
    system "$cc $cflags $out_w -o $cc-w";
}


talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $cc (@cc) {
        $times{w}{$cc} += (split ' ', `./$cc-w`)[0];
        $times{n}{$cc} += (split ' ', `./$cc-no`)[0];
    }
}

# Looking for the minimum value
my $min = 1e15;
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
        $times{$exp}{$cc} /= $nb_run;
        $min = min($min,$times{$exp}{$cc});
    }
}
# Normalizing the results
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
        $times{$exp}{$cc} = $times{$exp}{$cc}/$min;
    }
}


chdir "..";
open my $FH, '>', $outfile or die $!;

print $FH '
\\begin{table}[ht!]
  \\begin{tabular}{|l K{1cm}|K{2cm}|K{2cm}|K{1.5cm}|}
    \\hline
    & \\textbf{CC} & \\textbf{w/o sched} &\\textbf{w sched} & \\textbf{speedup} \\\\
    \\hline\\hline
';

my $i = 1;
for my $cc (sort {$times{w}{$b} <=> $times{w}{$a}} @cc) {
    my $w = $times{w}{$cc};
    my $n = $times{n}{$cc};
    my $percent = -($n - $w) / $n * 100;
    printf $FH "    (%d) & \\%s & %.2f & %.2f & %s%d\\%%\\\\\n    \\hline\n",
    $i++, $cc, $n, $w, ($percent > 0 ? '+' : ''), round($percent);
    
}

print $FH 
'  \\end{tabular}
  \\caption{Normalized performances of scheduling}
  \\label{tbl:perf-sched}
\\end{table}
';


remove_tree "tmp";
