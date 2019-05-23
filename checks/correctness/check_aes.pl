#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
use File::Copy::Recursive qw(dircopy fcopy rcopy);
use FindBin;

sub error {
    say "************ ERROR **************\n\n";
    exit 1;
}

my $temp_dir = "tmp_aes";

say "############################## Bitslice AES ###########################";

# switching to usuba dir
chdir "$FindBin::Bin/../..";

# Compiling the compiler.
unless ($ARGV[0]) { 
    say "Compiling...";
    error if system 'make';
}


# Switching to temporary directory.
say "Preparing the files for the test...";
remove_tree $temp_dir if -d $temp_dir;
mkdir $temp_dir;
chdir $temp_dir;

dircopy "$FindBin::Bin/aes/$_", $_ for qw(std sse avx);
copy $_, "." for glob "$FindBin::Bin/aes/{main.c,stream.h,aes_ctr.pl}";

chdir "..";
say "Compiling AES from Usuba to C...";
for my $arch (qw(std sse avx)) {
    error if system "./usubac -B -o $temp_dir/$arch/aes.c -arch $arch -no-share -no-arr -no-sched -no-runtime samples/usuba/aes.ua" ;
}

chdir $temp_dir;


for my $ARCH (qw(std sse avx)) {
    # Compiling the C files
    say "Compiling the test executable with $ARCH...";
    error if system "clang -Wall -Wextra -march=native -I../arch -o aes main.c $ARCH/stream.c";

    say "Running the test with $ARCH...";
    error if system 'head -c 8M </dev/urandom > input.txt';
    error if system 'perl aes_ctr.pl';
    error if system './aes';

    error if system 'cmp --silent out_c.txt out_pl.txt';
    unlink 'out_c.txt', 'out_pl.txt';
}

chdir '..';
remove_tree $temp_dir;

say "Bitsliced AES OK.\n\n";
