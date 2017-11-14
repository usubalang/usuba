#!/usr/bin/perl

# Note: this script is named "tmp_run.pl" instead of "run.pl" so it is not ran
# automatically by the main benchmark script ("bench/bench.pl").

use strict;
use warnings;
use v5.18;
use FindBin;
use File::Path qw( remove_tree make_path );
use File::Copy;
use Cwd;

my $cc = 'clang';

my $bench   = "Bandwidth";

my $opts = "-no-runtime -arch std -inline-all";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;
make_path 'tmp';

my $self_dir = getcwd();

chdir "../../..";


talk "Generating the C file";
system "./usubac $opts -o $self_dir/tmp/des.c samples/usuba/des.ua";

chdir "$self_dir/tmp";

my $clags = "-O3 -I ../../../../arch -march=native -w -S";
system "$cc $clags -o des.s des.c";


system "../analyze.pl";

