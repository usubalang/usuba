#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

my $tot = 30;
if ($ARGV[0] =~ /^\d+$/) {
    $tot = shift @ARGV;
}
my $signif = int($tot / 2);

my %times;

for ( 1 .. $tot ) {
    for (@ARGV) {
        push @{$times{$_}}, `./$_` =~ s/ .*$//r;
    }
}

for (@ARGV) {
    $times{$_} = sum ((sort { $a <=> $b } @{$times{$_}})[1 .. $signif])
}

for (sort { $times{$a} <=> $times{$b} } keys %times) {
    printf "$_ => %.3f\n",$times{$_}/$signif
}
