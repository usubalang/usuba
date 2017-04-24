#!/usr/bin/perl

use feature 'say';

$tot = 10;
for (1 .. $tot) {
    $_ = `./run`;
    for (split "\n") {
        s/ //g;
        /=>/;
        $c{$`}+= $';
    }
}

for (sort keys %c) {
    printf "$_ => %.2f\n", 1/($c{$_}/$c{1});
}
