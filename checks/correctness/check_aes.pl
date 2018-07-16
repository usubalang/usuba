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
    say "************ ERROR **************";
    exit $?;
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

# Compiling Usuba AES.
say "Compiling AES from Usuba to C...";
error if system "./usubac -o $temp_dir/aes.c -arch std -no-share -no-arr -no-sched -no-runtime samples/usuba/aes.ua" ;
{
    local $^I = "";
    local @ARGV = "$temp_dir/aes.c";
    while(<>) {
        s/#include .*//;
    } continue { print }
}


chdir $temp_dir;

dircopy "$FindBin::Bin/aes/std", "std";
copy $_, "." for glob "$FindBin::Bin/aes/{main.c,stream.h,aes_ctr.pl}";


for my $ARCH (qw(std)) {
    # Compiling the C files
    say "Compiling the test executable with $ARCH...";
    error if system "clang -O3 -march=native -I../arch -o aes main.c $ARCH/stream.c";

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
