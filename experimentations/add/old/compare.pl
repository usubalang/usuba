#!/usr/bin/perl -l

system "make clean && make";

$nb_tests = 20;

for $size (8,16,32) {
    %h = ();
    for (1 .. $nb_tests) {
        for (split "\n", `./add_$size`) {
            / /;
            $h{$`} += $';
        }
        if (-f "add_${size}_wrong") {
            for (split "\n", `./add_${size}_wrong`) {
                /bitslice/i || next;
                / /;
                $h{$`."wrong"} += $';
            }
        }
        if (-f "add_${size}_wrong2") {
            for (split "\n", `./add_${size}_wrong2`) {
                /bitslice/i || next;
                / /;
                $h{$`."wrong2"} += $';
            }
        }
        if (-f "add_${size}_wrong3") {
            for (split "\n", `./add_${size}_wrong3`) {
                /bitslice/i || next;
                / /;
                $h{$`."wrong3"} += $';
            }
        }
        if (-f "add_${size}_wrong4") {
            for (split "\n", `./add_${size}_wrong4`) {
                /bitslice/i || next;
                / /;
                $h{$`."wrong4"} += $';
            }
        }
    }

    print "\n$size bits:";
    undef $min;
    for (sort {$h{$a} <=> $h{$b}} grep {!/_ar/} keys %h) {
        $min //= $h{$_};
        printf "$_ %.3f (x%.2f)\n",$h{$_}/$nb_tests/1_000_000,$h{$_}/$min;
    }
}
print "\n32 bits (array):";
undef $min;
for (sort {$h{$a} <=> $h{$b}} grep {/_ar/} keys %h) {
    $min //= $h{$_};
    printf "$_ %.3f (x%.2f)\n",$h{$_}/$nb_tests/1_000_000,$h{$_}/$min;
}
print "";
