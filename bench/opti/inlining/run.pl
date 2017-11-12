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

my $bench   = "Inlining";
my $outfile = 'inlining.tex';

my $opts = "-no-sched -no-arr -no-share -bench -no-ortho -arch std";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'tmp';


my $self_dir = getcwd();

chdir "../../..";

talk "Generating the C files";
system "./usubac -no-inlining $opts -o $self_dir/tmp/no.c  samples/usuba/des.ua";
system "./usubac $opts -o $self_dir/tmp/partial.c  samples/usuba/des.ua";
system "./usubac -inline-all $opts -o $self_dir/tmp/full.c  samples/usuba/des.ua";

chdir "$self_dir/tmp";

copy "../../../input.txt", ".";

my $cflags = "-O3 -I ../../../../arch -march=native -w";

talk "Compiling the C files";
system "clang $cflags -fno-inline -o without no.c";
system "clang $cflags -o clang no.c";
system "clang $cflags -fno-inline -o partial partial.c";
system "clang $cflags -fno-inline -o usuba full.c";
system "clang $cflags -o usuba-clang partial.c";

my %files = (
    without       => 'without',
    clang         => '\\clang',
    partial       => 'partial \\usuba',
    usuba         => '\\usuba',
    'usuba-clang' => '\\usuba \& \\clang' );

talk "Running the benchmarks";
my %times;
for (1 .. $nb_run) {
    for my $file (keys %files) {
        $times{$file}  += (split' ',`./$file`)[0] / $nb_run;
    }
}

# Looking for the minimum value
my $min = 1e15;
for my $file (keys %times) {
    $min = min($min,$times{$file});
}
# Normalizing the results
for my $file (keys %times) {
    $times{$file} = sprintf "%.2f", $times{$file}/$min;
}
my $best = $times{'usuba-clang'};

chdir "..";
open my $FH, '>', $outfile or die $!;

my $tuc = $times{'usuba-clang'};
my $tu  = $times{usuba};
my $tp  = $times{partial};
my $tc  = $times{clang};
my $tw  = $times{without};

print $FH "
\\centering
\\begin{tabular}{|l K{1.2cm}|K{1.5cm}|K{2cm}|K{1.5cm}|}
  \\hline
  & \\textbf{Inlining} &\\textbf{Speed} & \\textbf{Delta to best} & \\textbf{Code size (byte)}\\\\
  \\hline\\hline
  (1) & \\usuba \\& \\clang & $tuc & 0 \\\% & ", (-s 'tmp/usuba-clang'), "\\\\
  \\hline
  (2) & \\usuba & $tu & ",int(($tu-$tuc)/$tu*100), " \\\% & ", (-s 'tmp/usuba'), "\\\\
  \\hline
  (3) & partial \\usuba & $tp & ", int(($tp-$tuc)/$tp*100)," \\\% & ",  (-s 'tmp/partial') ,"\\\\
  \\hline
  (4) & \\clang & $tc & ", int(($tc-$tuc)/$tc*100), " \\\% & ", (-s 'tmp/clang') ,"\\\\
  \\hline
  (5) & without & $tw & ", int(($tw-$tuc)/$tw*100), " \\\% & ", (-s 'tmp/without'), "\\\\
  \\hline
  \\end{tabular}
\\caption{Inlining}
\\label{tbl:perf-inlining}
";


remove_tree "tmp";
