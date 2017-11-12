#!/usr/bin/perl -nl

$l+=/ldr/;$s+=/str/;$a+=/and(?!n)/;$on+=/orn/;$x+=/eor/;$o+=/orr/;$m+=/mov|mvn/;}{$,=$/;print"move:$m","load: $l","store:$s","total mem:".($m+$l+$s),"and:$a","ornot:$on","or:$o","xor:$x","total:".($m+$l+$s+$a+$on+$o+$x)
