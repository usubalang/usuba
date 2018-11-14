#!/usr/bin/perl

use strict;
use warnings;
use v5.14;


my ($clang) = `clang --version` =~ /version (\d+\.\d+\.\d+)/;
my ($gcc)   = `gcc --version`   =~ /gcc \(.*?\) (\d+\.\d+\.\d+)/;
my ($icc)   = `icc -v 2>&1`     =~ /version (\d+\.\d+\.\d+)/;
my ($cpu)   = `lscpu`           =~ /Model name:\s*([^\n]+)/;
my $os;
open my $FP_IN, '<', '/etc/os-release' or die $!;
while (<$FP_IN>) {
    if (/^VERSION="(.*)"/) {
        $os = $1;
        last;
    }
}

open my $FP_OUT, '>', 'setup.tex' or die $!;
print $FP_OUT
"\\newcommand{\\BenchArch}{$cpu}
\\newcommand{\\BenchOS}{$os}
\\newcommand{\\BenchClang}{$clang}
\\newcommand{\\BenchGCC}{$gcc}
\\newcommand{\\BenchICC}{$icc}";
