#!/usr/bin/perl -nl

$m+=()=/mov/g;
$a+=()=/and(?!n)/g;
$an+=()=/andn/g;
$x+=()=/xor/g;
$n+=()=/not/g;
$o+=()=/(?<!x)or/g;
$r+=()=/ror|rol/g;
$s+=()=/shr|shl/g;
}{

$,=$/;
print "move:$m",
    "and:$a",
    "andn:$an",
    "not:$n",
    "or:$o",
    "xor:$x",
    "shift:$s",
    "rotate:$r",
    "total:".($m+$a+$an+$n+$o+$x+$r+$s)
