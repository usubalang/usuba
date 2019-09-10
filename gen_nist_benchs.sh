#!/bin/bash

# ACE bitslice
./usubac -light-inline -gen-bench -bits-per-reg 32 -B -no-sched -o nist/ace/usuba/bench/ace_ua_bitslice.c -arch std -no-share nist/ace/usuba/ua/ace.ua
# ACE vslice
./usubac -light-inline -gen-bench -V -no-sched -o nist/ace/usuba/bench/ace_ua_vslice.c -arch std -no-share nist/ace/usuba/ua/ace.ua

# Ascon bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -B -no-sched -o nist/ascon/usuba/bench/ascon_ua_bitslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua
# Ascon vslice
./usubac -gen-bench -light-inline -V -no-sched -o nist/ascon/usuba/bench/ascon_ua_vslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua

# GIFT-COFB bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -B -no-sched -o nist/gift-cofb/usuba/bench/gift_ua_bitslice.c -arch std -no-share nist/gift-cofb/usuba/ua/gift_bitslice.ua
# GIFT-COFB bitslice
./usubac -gen-bench -light-inline -V -no-sched -o nist/gift-cofb/usuba/bench/gift_ua_vslice.c -arch std -no-share nist/gift-cofb/usuba/ua/gift.ua

# Gimli bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -no-sched -B -o nist/gimli/usuba/bench/gimli_ua_bitslice.c nist/gimli/usuba/ua/gimli.ua
# Gimli vslice
./usubac -gen-bench -light-inline -no-sched -V -o nist/gimli/usuba/bench/gimli_ua_vslice.c nist/gimli/usuba/ua/gimli.ua

# Photon bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -B -no-linearize-arr -no-sched -o nist/photon-beetle/usuba/bench/photon_ua_bitslice.c -arch std -no-share nist/photon-beetle/usuba/ua/photon_bitslice.ua
# Photon vslice (uses tables)
./usubac -gen-bench -light-inline -V -keep-tables -no-sched -o nist/photon-beetle/usuba/bench/photon_ua_vslice.c -arch std -no-share nist/photon-beetle/usuba/ua/photon_vslice.ua

# Pyjamask bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -no-sched -B -o nist/pyjamask/usuba/bench/pyjamask_ua_bitslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_bitslice.ua
# Pyjamask vslice
./usubac -gen-bench -light-inline -no-sched -V -o nist/pyjamask/usuba/bench/pyjamask_ua_vslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_vslice.ua

# Skinny bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -B -no-sched -o nist/skinny/usuba/bench/skinny_ua_bitslice.c -arch std -no-share nist/skinny/usuba/ua/skinny_bitslice.ua
# Skinny vslice (uses tables)
./usubac -gen-bench -light-inline -keep-tables -V -no-sched -o nist/skinny/usuba/bench/skinny_ua_vslice.c -arch std -no-share nist/skinny/usuba/ua/skinny_vslice.ua

# Spook (clyde) bitslice
./usubac -gen-bench -light-inline -bits-per-reg 32 -no-sched -B -o nist/spook/usuba/bench/clyde_ua_bitslice.c nist/spook/usuba/ua/clyde.ua
# Spook (clyde) vslice
./usubac -gen-bench -light-inline -no-sched -V -o nist/spook/usuba/bench/clyde_ua_vslice.c nist/spook/usuba/ua/clyde.ua
