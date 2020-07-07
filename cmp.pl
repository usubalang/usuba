#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum max);
use feature 'say';

my $tot = 1;
my $G = 1000000000;
if ($ARGV[0] =~ /^\d+$/) {
    $tot = shift @ARGV;
}

my %times;

for ( 1 .. $tot ) {
    for (@ARGV) {
        push @{$times{$_}}, (`./$_` =~ s/ .*$//r)+0;
    }
}

my %formatted;
for (@ARGV) {
  my $u = sum(@{$times{$_}})/@{$times{$_}}; # mean
  my $s = ( sum( map {($_-$u)**2} @{$times{$_}} ) / @{$times{$_}} ) ** 0.5; # standard deviation
  $formatted{$_} = { mean => $u, stdev => $s };
}

my $padding = max map { length } @ARGV;

say "Details:";
for (sort { $formatted{$a}->{mean} <=> $formatted{$b}->{mean} } keys %formatted) {
  printf "%*s => %.3f +-%.3f [%s]\n", $padding, $_, $formatted{$_}->{mean}, $formatted{$_}->{stdev}, join ", ", @{$times{$_}};
}

say "\nSummary:";
for (sort { $formatted{$a}->{mean} <=> $formatted{$b}->{mean} } keys %formatted) {
    printf "%*s => %.3f +-%.3f\n", $padding, $_, $formatted{$_}->{mean}, $formatted{$_}->{stdev}
}
