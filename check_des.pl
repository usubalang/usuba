#!/usr/bin/perl -w

use v5.14;
use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
no warnings 'experimental';

sub error {
    say "************ ERROR **************";
    exit $?;
}

# switching to src dir
my $path = getcwd() =~ s{usuba\K.*}{}r 
    or die "Can't run this script from outside usuba repo.";
chdir "$path/src";

# Compiling the compiler.
say "Compiling...";
error if system 'make';

chdir "..";


# Switching to temporary directory.
say "Preparing the files for the test...";
remove_tree 'tmp_c' if -d 'tmp_c';
mkdir 'tmp_c';

# Compiling Usuba DES.
say "Regenerating the des code...";
error if system './usubac -o tmp_c/des.c -arch avx tests/usuba/des.ua' ;

chdir 'tmp_c';
copy '../des/ref_usuba.c', '.';
copy '../tests/perf_c/make_input.c', '.';


# Compiling the C files
say "Compiling the test executable...";
error if system 'clang -O3 -march=native -I ../arch -o des_to_test des.c';
error if system 'clang -o make_input make_input.c -O3 -march=native';
error if system 'clang -o des_ref ref_usuba.c -O3 -march=native';

say "Running the test...";
error if system './make_input';
error if system './des_ref';
move 'output.txt', 'output_ref.txt';
error if system './des_to_test';

error if system 'cmp --silent output_ref.txt output.txt';

chdir '..';
remove_tree 'tmp_c';

say "C DES OK.";
