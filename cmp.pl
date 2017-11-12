#!/usr/bin/perl

$tot = 20;
for ( 0 .. $tot ) {
    for (@ARGV) {
        $time{$_} += `./$_`;
    }
}

for (sort { $time{$a} <=> $time{$b} } keys %time) {
    printf "$_ => %.3f\n",$time{$_}/$tot
}


for ( 0 .. $tot ) {
    for (reverse @ARGV) {
        $time{$_} += `./$_`;
    }
}

for (sort { $time{$a} <=> $time{$b} } keys %time) {
    printf "$_ => %.3f\n",$time{$_}/($tot*2)
}

__END__

for ( 0 .. $tot ) {
    for (@ARGV) {
        $time{$_} += `./$_`;
    }
}

for (sort { $time{$a} <=> $time{$b} } keys %time) {
    printf "$_ => %.3f\n",$time{$_}/($tot*3)
}

for ( 0 .. $tot ) {
    for (reverse @ARGV) {
        $time{$_} += `./$_`;
    }
}

for (sort { $time{$a} <=> $time{$b} } keys %time) {
    printf "$_ => %.3f\n",$time{$_}/($tot*4)
}
