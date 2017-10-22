#!/usr/bin/perl

system 'make';

$tot = 100;
for (1 .. $tot) {
    $_ = `./run`;
    for (split "\n") {
        s/ //g;
        /=>/;
        $c{$`}+= $';
    }
}

open *FPOUT, '>', 'data.dat' or die $!;
for (sort {$a<=>$b} keys %c) {
    print FPOUT (sprintf "$_ %.2f\n", 1/($c{$_}/$c{1}));
}

system "gnuplot plot.txt"
