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

# switching to usuba dir
chdir $FindBin::Bin;

say "###################### Compiling ######################";
error if system 'make';
say "\n";


system "./$_ 1" for glob('checks/*.pl');
