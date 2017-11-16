#!/usr/bin/perl -w

use v5.14;
use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
no warnings 'experimental';
use FindBin;

sub error {
    say "************ ERROR **************";
    exit $?;
}

# switching to usuba dir
chdir $FindBin::Bin;

# Compiling the compiler.
say "Compiling...";
error if system 'make';


# Switching to temporary directory.
say "Preparing the files for the test...";
remove_tree 'tmp_c' if -d 'tmp_c';
mkdir 'tmp_c';

# Compiling Usuba DES.
say "Regenerating the des code...";
error if system './usubac -o tmp_c/des.c -arch avx samples/usuba/des.ua' ;

chdir 'tmp_c';
copy '../DES/ref_usuba.c', '.';


# Compiling the C files
say "Compiling the test executable...";
error if system 'clang -O3 -march=native -I../arch -o des_to_test des.c';
error if system 'clang -O3 -march=native -o des_ref ref_usuba.c';

say "Running the test...";
error if system 'head -c 8M </dev/urandom > input.txt';
error if system './des_ref';
move 'output.txt', 'output_ref.txt';
error if system './des_to_test';

error if system 'cmp --silent output_ref.txt output.txt';

chdir '..';
remove_tree 'tmp_c';

say "C DES OK.";
