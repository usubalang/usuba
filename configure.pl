#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
$| = 1;

use FindBin;

check_dependencies();

gen_config();


sub check_dependencies {
    check_cmd_version('OCaml', 'ocaml', '4.05.0');
    check_cmd_version('Coq', 'coqc', '8.8.1');
    check_cmd_version('OCamlBuild', 'ocamlbuild', '0.12.0');

}

sub check_cmd_version {
    my ($name, $cmd, $exp_version) = @_;
    print "Checking that $name is installed...... ";
    if (`/bin/sh -c 'type $cmd'` =~ /not found/) {
        say "[error] `$cmd' not found.";
    } else {
        say "[success]";

        print "Checking that $name version >= $exp_version...... ";
        my ($got_version) = `$cmd --version 2>&1` =~ /(\d+\.\d+\.\d+)/;
        if (! $got_version) {
            say "[error] version not recognized.";
        } elsif ($got_version lt $exp_version) {
            say "[error] version $got_version < $exp_version";
        } else {
            say "[success]";
        }
    }
}


sub gen_config {
    my $ua_dir = $FindBin::Bin;
    chdir $ua_dir;

    open my $FH, '>', 'src/config.ml';

    say $FH
"(* This file was automatically generated. Manual edits might be overriten
 whenever the configure script is ran again. *)\n\n";

    say $FH qq{let data_dir = "$ua_dir/data"};
    say $FH qq{let tightprove_cache = "$ua_dir/tightprove_cache"};
}
