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
    say "************ ERROR **************";
    exit $?;
}

my $temp_dir = "tmp_chacha20";

say "################################ Chacha20 ##############################";

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
say "Compiling Chacha20 from Usuba to C...";
error if system "./usubac -o $temp_dir/chacha20.c -arch sse -no-runtime -no-share samples/usuba/chacha20.ua" ;
{
    local $^I = "";
    local @ARGV = "$temp_dir/chacha20.c";
    while(<>) {
        s/#include .*//;
    } continue { print }
}

chdir $temp_dir;
copy $_, "." for glob "$FindBin::Bin/chacha20/{main_verif.c,stream.h,crypto_stream.h}";
#rcopy $_, '.' for glob "$FindBin::Bin/chacha20/*";

for my $ARCH (qw(STD SSE AVX)) {
    dircopy "$FindBin::Bin/chacha20/$ARCH/", ".";
    copy "chacha20.c", "$ARCH/";
    # Compiling the C files
    say "Compiling the test executable with $ARCH...";
    error if system "clang -O3 -march=native -I../arch -I . -o chacha20 main_verif.c $ARCH/stream.c";

    say "Running the test with $ARCH...";
    error if system './chacha20';
}

chdir '..';
remove_tree $temp_dir;

say "n-sliced Serpent OK.\n\n";
