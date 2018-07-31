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

my $temp_dir = "tmp_ti";

say "########################## Threshold Implementation (TI) #######################";

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
dircopy "$FindBin::Bin/ti", $temp_dir;

say "Compiling AES/DES sbox from Usuba to C and running the tests...";
for my $ti (2, 3, 4, 8) {
    for my $sbox (qw(sbox1_des sbox_aes_kasper)) {
        error if system "./usubac -o $temp_dir/$sbox/sbox.c -ti $ti samples/usuba/$sbox.ua";
            
    }
    chdir $temp_dir;
    error if system "TI=$ti make test";
    chdir "..";
}

remove_tree $temp_dir;

say "Threshold Implementation (TI) OK.\n\n";
