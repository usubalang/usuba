#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
$| = 1;

use FindBin;
use JSON::PP;


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

    # Reading config
    my $config = do {
        local $/ = undef;
        open my $FH, '<', 'config.json'
            or die "Cannot read `config.json': $!\nAborting.";
        <$FH>;
    };
    $config = JSON::PP->new->allow_nonref->decode($config);

    # Sanitizing config
    for (keys %$config) {
        $config->{$_} = $config->{$_} =~ s/\{\{HOME\}\}/$ENV{HOME}/gr;
        $config->{$_} = $config->{$_} =~ s/\{\{USUBA\}\}/$ua_dir/gr;
    }

    open my $FH, '>', 'src/config.ml';

    print "Generating Config.ml...... ";
    say $FH
"(* This file was automatically generated. Manual edits might be overriten
 whenever the configure script is ran again. *)\n\n";

    say $FH qq{let data_dir = "$config->{data_dir}"};
    say $FH qq{let tightprove_cache = "$config->{tightprove_cache}"};
    say $FH qq{let sage = "$config->{sage}"};
    say $FH qq{let tightprove = "$config->{tightprove}"};

    say "[done]";
}
