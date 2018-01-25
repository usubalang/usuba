#!/usr/bin/perl

use strict; use warnings;
use v5.14;

use Algorithm::Permute;

my $target = "BA";

my @rot32 = (0, 1, 2, 3);

my $iter_rot32 = Algorithm::Permute->new( \@rot32 );

while (my @perm32 = $iter_rot32->next) {
    my @rot64 = (0, 1, 2, 3);
    my $iter_rot64 = Algorithm::Permute->new( \@rot64 );
    while (my @perm64 = $iter_rot64->next) {
        {
            push @ARGV, "test.c";
            local $^I = "";
            $" = ",";
            while (<>) {
                s{/\*A\*/\K[^)]+}{@perm32};
                s{/\*B\*/\K[^)]+}{@perm64};
            } continue {
                print
            }

            system "clang -march=native -o test test.c -Wall -Wextra";
            my $res = `./test`;
            print "(@perm32) (@perm64) - $res";
            if ($res =~ /^$target/) {
                say "Found it:\n@perm32 -- @perm64";
                exit;
            }            
        }
    }
}
