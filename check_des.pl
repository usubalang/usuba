#!/usr/bin/perl -w

use v5.14;

sub error {
    exit $?;
}

# say "Checking OCaml DES...";
# error if system './tests/checks/check_ocaml_des.pl';

# say "\n", "-"x40, "\n";

say "Checking C DES...";
error if system './tests/checks/check_c_des.pl';

say "\n\nAll tests OK.";
