#!/usr/bin/perl

$tot = 30;
for ( 0 .. $tot ) {
    $time{$_} += `./$_` for (@ARGV)
}

for (sort { $time{$a} <=> $time{$b} } keys %time) {
    printf "$_ => %.3f\n",$time{$_}/$tot
}
