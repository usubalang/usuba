#!/usr/bin/perl -l

system "make clean && make";

for (1 .. 100) {
    for (split "\n", `./cmp`) {
        / /;
        $h{$`} += $';
    }
}

for (sort {$h{$a} <=> $h{$b}} keys %h) {
    print $_,$h{$_}/100;
}
