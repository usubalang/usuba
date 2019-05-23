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

my $temp_dir = "tmp_pyjamask";

say "################################ Pyjamask ##############################";

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
say "Compiling Pyjamask from Usuba to C...";
error if system "./usubac -B -o $temp_dir/pyjamask_ua.c -arch std -no-share samples/usuba/pyjamask.ua" ;

chdir $temp_dir;
copy $_, "." for glob "$FindBin::Bin/pyjamask/*";
#rcopy $_, '.' for glob "$FindBin::Bin/chacha20/*";

for my $ARCH (qw(STD)) {
    # Compiling the C files
    say "Compiling the test executable with $ARCH...";
    error if system "clang -O3 -march=native -I../arch -I . -o main main.c pyjamask.c pyjamask_ua.c -Wno-incompatible-pointer-types";

    say "Running the test with $ARCH...";
    error if system './main';
}

chdir '..';
remove_tree $temp_dir;

say "Bitsliced Pyjamask OK.\n\n";
