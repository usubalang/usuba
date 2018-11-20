#!/usr/bin/perl

use strict;
use warnings;
use v5.14;


our $DEBUG = 1;

# Read whole file at once; who even cares about memory?
my @data = <>;


my @registers = qw(i7 i6 i5 i4 i3 i2 i1 i0 l7 l6 l5 l4 l3 l2 l1 l0 
                   o7 o6 o5 o4 o3 o2 o1 o0 g7 g6 g5 g4 g3 g2 g1 g0);
my %reg_encoding = do { my $i = 0; map { $_ => $i++ } reverse @registers };

my %opcodes = ( ANDOR => [ 0b10, 0b101100] );

for (my $i = 0; $i < @data; $i++) {
    local $_ = $data[$i];
    if (/.word 0xa5640011/) { # ANDOR
        my @bits = split //, sprintf "%b",hex "a5640011";
        my ($op1, $op2) = map 
                        { /mov\s*\%(\S+),\s*\%(\S+)/ || die "$i: $_"; $1  } 
                        @data[$i-2, $i-1];
        my ($dst) = $data[$i+1] =~ /mov\s*\%\S+,\s*\%(\S+)/ or die "$i: $_";
        my ($op1_enc, $op2_enc, $dst_enc) = map { $reg_encoding{$_} // die "$i: $_" }
                                            ($op1, $op2, $dst);
        my ($op, $op3) = @{$opcodes{ANDOR}};
        my $instr = emit($op, $op3, $dst_enc, $op1_enc, $op2_enc);
        splice @data, $i-2, 3, $instr;
        $i--;
    }
}

print for @data;



sub emit {
    my ($op, $op3, $dst, $op1, $op2) = @_;
    my $bin_instr = sprintf "%02b%05b%06b%05b000000000%05b", $op, $dst, $op3, $op1, $op2;
    return sprintf "\t.word\t0x%08x\n", oct("0b$bin_instr");
}
