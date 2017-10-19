#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;

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
for my $cc (qw(clang icc gcc)) {
    system "$cc $cflags des-no-cse-cp.c -o $cc-no";
    system "$cc $cflags des-cse-cp.c -o $cc-w";
}

say "Running the benchmarks";
for my $cc (qw(clang icc gcc)) {
    print "$cc with: "; system "./$cc-w";
    print "$cc no: "; system "./$cc-no";
}


remove_tree "tmp";
