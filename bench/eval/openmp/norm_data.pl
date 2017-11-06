#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
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
    next if $core < 10 && $core != 1 && $core != 5;
    push @{$data{$core}}, $time;
}
close $FH;

my $max = 0;
for my $core (keys %data) {
    $data{$core} = median @{$data{$core}};
    $max = max($max,$data{$core});
}

delete $data{1};

open $FH, '>', 'data.dat' or die $!;
printf $FH "0 0\n";
for my $core (sort { $a <=> $b } keys %data) {
    printf $FH "%d %d\n", $core, round($max/$data{$core});
}
close $FH;
