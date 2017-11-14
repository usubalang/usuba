#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use List::Util qw( min );
use Math::Round;
use FindBin;

my $nb_run = $ARGV[0] // 30;
my @cc = qw(clang gcc icc);

my $bench   = "Array";
my $outfile = 'array.tex';

my $opts = "-bench -no-ortho -arch std";

my $out_w = 'des-no-arr.c';
my $out_n = 'des-arr.c';


sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
system "./usubac -no-arr -no-share $opts -o $self_dir/tmp/$out_n samples/usuba/des.ua";
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
        $times{w}{$cc} += (split ' ', `./$cc-w`)[0] / $nb_run;
        $times{n}{$cc} += (split ' ', `./$cc-no`)[0] / $nb_run;
    }
}

# Looking for the minimum value
my $min = 1e15;
for my $exp (keys %times) {
    for my $cc (keys %{$times{$exp}}) {
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
\\centering
\\begin{tabular}{|l K{1cm}|K{2cm}|K{2cm}|K{1.5cm}|}
  \\hline
  & \\textbf{CC} & \\textbf{variables} &\\textbf{arrays} & \\textbf{speedup} \\\\
  \\hline\\hline
';

for my $cc (sort {$times{w}{$b} <=> $times{w}{$a}} @cc) {
    my $w = $times{w}{$cc};
    my $n = $times{n}{$cc};
    my $speedup = $w / $n;
    printf $FH "\\%s & %.2f & %.2f & x%.2f\\\\\n    \\hline\n",
    $cc, $n, $w, $speedup;
    
}

print $FH 
'\\end{tabular}
\\caption{Variables \\vs{} arrays}
\\label{tbl:perf-arr}
';


remove_tree "tmp";
