#!/usr/bin/perl

use strict;
use warnings;
use autodie qw(open close);

my $data;
my $rb = read STDIN, $data, 15;

print "P5\n600 300\n255\n";
print for <>;
