#!/usr/bin/perl

use feature 'say';
use Time::HiRes 'time';

$nb_runs = 30;

for (1 .. $nb_runs) {
    for $prog (glob "*") {
        next unless -d $prog;
        $t = time;
        for $file (glob "$prog/*.z3") {
            `z3 $file`        
        }
        $times{$prog} += (time-$t) / $nb_runs;
    }
}

open local *STDOUT, '>', 'data.dat' or die $!;
for $prog (sort { $times{$a} <=> $times{$b} } keys %times) {
    ($n) = $prog =~ /(\d+)/;
    $n //= 16;
    printf "$n %.1f\n",$times{$prog}
}

system "gnuplot plot.txt"
