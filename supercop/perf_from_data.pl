#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use autodie qw(open close);

use Sys::Hostname;
use List::Util qw( sum );


for my $path (@ARGV) {
    my $last_line;
    open my $FP, '<', $path;

    my @cycles;
    while (<$FP>) {
        if (/xor_cycles 4096 (.*)/) {
            push @cycles, split ' ', $1;
        }
    }

    if (@cycles) {
        @cycles = (sort { $a <=> $b } @cycles)[0 .. 5];
        my $cycles_avg = (sum @cycles) / @cycles;
        printf "$path: %.02f\n", $cycles_avg / 4096;
    } else {
        say "$path: Invalid data file, something probably went wrong.";
    }
    
    # while (<$FP>) {
    #     $last_line = $_;
    # }
    # chomp($last_line);

    # if (my ($results) = $last_line =~ /xor_cycles (.+)$/) {
    #     my ($bytes,@cycles) = split ' ', $results;
    #     @cycles = (sort { $a <=> $b } @cycles)[0 .. 5];
    #     my $cycles_avg = (sum @cycles) / @cycles;
    #     printf "$path: %.02f\n", $cycles_avg / $bytes;
    # } else {
    #     say "$path: Invalid data file, something probably went wrong.";
    # }
}
