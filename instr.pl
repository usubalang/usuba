#!/usr/bin/perl -nl

$m+=/mov/;$a+=/and(?!n)/;$an+=/andn/;$x+=/xor/;$n+=/not/;$o+=/(?<!x)or/}{$,=$/;print"move:$m","and:$a","andn:$an","not:$n","or:$o","xor:$x","total:".($m+$a+$an+$n+$o+$x)
