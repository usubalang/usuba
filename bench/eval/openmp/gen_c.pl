#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use FindBin;


my $nb_cores = 4;

my $bench   = "OpenMP";

my $opts = "-bench -arch avx";

sub talk {
    say "Bench $bench: ", @_;
}

chdir $FindBin::Bin;

make_path 'bench';

my $self_dir = getcwd();

chdir "../../..";

system "./usubac $opts -openmp $nb_cores -o $self_dir/bench/des-bench.c samples/usuba/des.ua";
