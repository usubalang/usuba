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

my $temp_dir = "tmp_serpent";

say "################################ Serpent ##############################";

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
say "Compiling Serpent from Usuba to C...";
error if system "./usubac -o $temp_dir/serpent.c -arch std -bits-per-reg 32 -no-runtime samples/usuba/serpent.ua" ;

chdir $temp_dir;
copy $_, '.' for glob "$FindBin::Bin/serpent/*";

# Compiling the C files
say "Compiling the test executables...";
error if system 'clang -O3 -march=native -I../arch -o serpent_ua main.c';
error if system 'clang -O3 -march=native -I../arch -o serpent_ref ref.c';

say "Running the test...";
error if system 'head -c 8M </dev/urandom > input.txt';
error if system './serpent_ref';
move 'output.txt', 'output_ref.txt';
error if system './serpent_ua';

error if system 'cmp --silent output_ref.txt output.txt';

chdir '..';
remove_tree $temp_dir;

say "n-sliced Serpent OK.\n\n";
