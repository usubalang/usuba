#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use List::Util qw(max min sum);
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

my $min = 1 << 63;
for my $core (keys %data) {
    #$data{$core} = median @{$data{$core}};
    $data{$core} = (sum @{$data{$core}}) / @{$data{$core}};
    $min = min($min,$data{$core});
}


open $FH, '>', 'data.dat' or die $!;
printf $FH "0 0\n";
for my $core (sort { $a <=> $b } keys %data) {
    printf $FH "%d %d\n", $core, round($data{$core}/$min);
}
close $FH;


__END__
open my $FH, '<', 'data.txt' or die $!;
my %data;
while (<$FH>) {
    chomp;
    my ($core,$time) = split ' ';
    $data{$core} = $time;
}
close $FH;

my $min = 1 << 63;
for my $core (keys %data) {
    $min = min($min,$data{$core});
}

open $FH, '>', 'data.dat' or die $!;
printf $FH "0 0\n";
for my $core (sort { $a <=> $b } keys %data) {
    printf $FH "%d %d\n", $core, round($data{$core}/$min);
}
close $FH;
