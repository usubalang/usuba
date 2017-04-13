#!/usr/bin/perl


use Benchmark qw(:all);
use feature 'say';


die "Make failed" if system 'make';

say "DES on 130Mo input file, with orthogonalization:";
cmpthese(5, {
    'uak-64*'  => sub { system './test_uak_64std' },
    'uak-64'   => sub { system './test_uak_64'    },
    'uak-128'  => sub { system './test_uak_128'   },
    'uak-256'  => sub { system './test_uak_256'   },
    'ua-256'   => sub { system './test_ua_256'    },
    'kwan-64*' => sub { system './test_kwan'      }
         });


say "\nDES on 130Mo input file, without orthogonalization:";
cmpthese(10, {
    'uak-64*'  => sub { system './test_uak_64std_no' },
    'uak-64'   => sub { system './test_uak_64_no'    },
    'uak-128'  => sub { system './test_uak_128_no'   },
    'uak-256'  => sub { system './test_uak_256_no'   },
    'ua-256'   => sub { system './test_ua_256_no'    },
    'kwan-64*' => sub { system './test_kwan_no'      }
         });
