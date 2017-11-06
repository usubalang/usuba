#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(max sum);
use POSIX qw(round ceil);

# Sub from http://www.perlmonks.org/?node_id=474564
sub median {
  sum( ( sort { $a <=> $b } @_ )[ int( $#_/2 ), ceil( $#_/2 ) ] )/2;
}

open my $FH, '<', 'data.txt' or die $!;
my %data;
while (<$FH>) {
    chomp;
    my ($core,$time) = split ' ';
    push @{$data{$core}}, $time;
}
close $FH;

my $max = 0;
for my $core (keys %data) {
    $data{$core} = median @{$data{$core}};
    $max = max($max,$data{$core});
}

open $FH, '>', 'data.dat' or die $!;
for my $core (sort { $a <=> $b } keys %data) {
    printf $FH "%d %d\n", $core, round($max/$data{$core});
}
close $FH;
