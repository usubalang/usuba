#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
use File::Copy::Recursive qw(rcopy dircopy);
$File::Copy::Recursive::CPRFComp = 1;
use FindBin;


sub error {
    say "************ ERROR **************\n\n";
    exit 1;
}

my $temp_dir = "tmp_skinny_bitslice";

say "############################# Skinny Bitslice ############################";

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

# Compiling Usuba Clyde.
say "Compiling Skinny from Usuba to C...";
error if system "./usubac -B -o $temp_dir/skinny_ua_bitslice.c -arch std -no-share samples/usuba/skinny_bitslice.ua";

chdir $temp_dir;
copy $_, "." for glob "$FindBin::Bin/skinny/*";

for my $ARCH (qw(STD)) {
    # Compiling the C files
    say "Compiling the test executable with $ARCH...";
    error if system "clang -D UA_B -O3 -march=native -I../arch -I . -o main main.c";

    say "Running the test with $ARCH...";
    error if system './main';
}

chdir '..';
remove_tree $temp_dir;

say "Bitsliced Skinny OK.\n\n";
