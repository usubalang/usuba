#!/bin/bash

INLINING="-light-inline"
#INLINING="-inline-all -unroll"

# ACE bitslice
./usubac -masked $INLINING -gen-bench -bits-per-reg 32 -B -no-sched -o nist/ace/usuba/bench/masked_ace_ua_bitslice.c -arch std -no-share nist/ace/usuba/ua/ace_bitslice.ua
# ACE vslice
./usubac -masked $INLINING -gen-bench -V -no-sched -o nist/ace/usuba/bench/masked_ace_ua_vslice.c -arch std -no-share nist/ace/usuba/ua/ace.ua

# Ascon bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -B -no-sched -o nist/ascon/usuba/bench/masked_ascon_ua_bitslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua
# Ascon vslice
./usubac -masked -gen-bench $INLINING -V -no-sched -o nist/ascon/usuba/bench/masked_ascon_ua_vslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua

# GIFT bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -B -no-sched -o nist/gift/usuba/bench/masked_gift_ua_bitslice.c -arch std -no-share nist/gift/usuba/ua/gift_bitslice.ua
# GIFT bitslice
./usubac -masked -gen-bench $INLINING -V -no-sched -o nist/gift/usuba/bench/masked_gift_ua_vslice.c -arch std -no-share nist/gift/usuba/ua/gift.ua

# Gimli bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/gimli/usuba/bench/masked_gimli_ua_bitslice.c nist/gimli/usuba/ua/gimli_bitslice.ua
# Gimli vslice
./usubac -masked -gen-bench $INLINING -no-sched -V -o nist/gimli/usuba/bench/masked_gimli_ua_vslice.c nist/gimli/usuba/ua/gimli.ua

# Photon bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -B -no-linearize-arr -no-sched -o nist/photon/usuba/bench/masked_photon_ua_bitslice.c -arch std -no-share nist/photon/usuba/ua/photon_bitslice.ua

# Pyjamask bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/pyjamask/usuba/bench/masked_pyjamask_ua_bitslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_bitslice.ua
# Pyjamask vslice
./usubac -masked -gen-bench $INLINING -no-sched -V -o nist/pyjamask/usuba/bench/masked_pyjamask_ua_vslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_vslice.ua

# Skinny bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -B -no-sched -o nist/skinny/usuba/bench/masked_skinny_ua_bitslice.c -arch std -no-share nist/skinny/usuba/ua/skinny_bitslice.ua

# Clyde (spook) bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/clyde/usuba/bench/masked_clyde_ua_bitslice.c nist/clyde/usuba/ua/clyde.ua
# Clyde (spook) vslice
./usubac -masked -gen-bench $INLINING -no-sched -V -o nist/clyde/usuba/bench/masked_clyde_ua_vslice.c nist/clyde/usuba/ua/clyde.ua

# Spongent bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -check-tbl -B -no-sched -o nist/spongent/usuba/bench/masked_spongent_ua_bitslice.c -arch std -no-share nist/spongent/usuba/ua/spongent.ua

# Drygascon bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/drygascon/usuba/bench/masked_drygascon_ua_bitslice.c nist/drygascon/usuba/ua/drygascon.ua
# Drygascon vslice
./usubac -masked -gen-bench $INLINING -no-sched -V -o nist/drygascon/usuba/bench/masked_drygascon_ua_vslice.c nist/drygascon/usuba/ua/drygascon.ua

# Subterranean bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/subterranean/usuba/bench/masked_subterranean_ua_bitslice.c nist/subterranean/usuba/ua/subterranean.ua

# Xoodoo bitslice
./usubac -masked -gen-bench $INLINING -bits-per-reg 32 -no-sched -B -o nist/xoodoo/usuba/bench/masked_xoodoo_ua_bitslice.c nist/xoodoo/usuba/ua/xoodoo.ua
# Xoodoo vslice
./usubac -masked -gen-bench $INLINING -no-sched -V -o nist/xoodoo/usuba/bench/masked_xoodoo_ua_vslice.c nist/xoodoo/usuba/ua/xoodoo.ua
