#!/usr/bin/perl


use Benchmark qw(:all);
use feature 'say';


die "Make failed" if system 'make';

say "DES on 130Mo input file, with orthogonalization:";
cmpthese(5, {
    'usuba x 128' => sub { system './test_full_usuba_des' },
    'usuba 64n' => sub { system './test_64' },
    'usuba 64' => sub { system './test_64_simd' },
    'usuba 128' => sub { system './test_kwan_usuba_des' },
    'usuba 256' => sub { system './test_256' },
    'kwan' => sub { system './test_kwan_des' }
         });


say "\nDES on 130Mo input file, without orthogonalization:";
cmpthese(10, {
    'usuba x 128' => sub { system './test_no_ortho_full_usuba' },
    'usuba 64n' => sub { system './test_no_ortho_64' },
    'usuba 64' => sub { system './test_no_ortho_64_simd' },
    'usuba 128' => sub { system './test_no_ortho_kwan_usuba' },
    'usuba 256' => sub { system './test_no_ortho_256' },
    'kwan' => sub { system './test_no_ortho_kwan' }
         });
