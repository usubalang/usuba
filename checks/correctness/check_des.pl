#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
use FindBin;

sub error {
    say "************ ERROR **************";
    exit $?;
}

my $temp_dir = "tmp_des";

say "################################## DES ################################";

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

# Compiling Usuba DES.
say "Regenerating the DES code...";
error if system "./usubac -o $temp_dir/des.c -arch avx -runtime samples/usuba/des.ua" ;
{
    local $^I = "";
    local @ARGV = "$temp_dir/des.c";
    while(<>) {
        s/#include .*//;
    } continue { print }
}

chdir $temp_dir;
copy '../DES/ref_usuba.c', '.';
copy $_, '.' for glob "$FindBin::Bin/des/*";


error if system 'clang -O3 -march=native -o des_ref ref_usuba.c';


for my $ARCH (qw(STD SSE AVX)) {
    # Compiling the C files
    say "Compiling the test executable...";
    error if system "clang -D $ARCH -march=native -I../arch -o des_to_test main.c";

    say "Running the test with $ARCH...";
    error if system 'head -c 8M </dev/urandom > input.txt';
    error if system './des_ref';
    error if system './des_to_test';

    error if system 'cmp --silent output.txt output_to_test.txt';
    unlink "output.txt output_to_test.txt"
}
    
chdir '..';
remove_tree $temp_dir;

say "Bitslice DES OK.\n\n";
