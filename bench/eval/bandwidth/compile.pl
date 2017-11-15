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

my $cc   = 'clang';
my $arch = 'std';

my %arch_corres = (
    std     => 'STD',
    sse     => 'SSE',
    avx     => 'AVX',
    avx512  => 'AVX512',
    altivec => 'AltiVec',
    neon    => 'Neon'
    );

my $bench   = "Bandwidth";

my $opts = "-no-runtime -arch $arch -inline-all";

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
copy "../main.c", ".";
copy "../input.txt", ".";


{
    local $^I = "";
    local @ARGV = 'main.c';
    while (<>) {
        s/ARCHI/$arch_corres{$arch}/;
        print;
    }
}

my $cflags = "-O3 -I ../../../../arch -march=native";
system "$cc $cflags -S -o des.s des.c";
system "$cc $cflags -o main main.c";


