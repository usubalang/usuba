#!/bin/bash

INLINING="-light-inline"
#INLINING="-inline-all -unroll"
COMPACT="-compact"


echo "ACE..."
# ACE bitslice
./usubac -ua-masked $INLINING -gen-bench -bits-per-reg 8 -B $COMPACT -no-sched -o nist/ace/usuba/bench/masked_ace_ua_bitslice.c -arch std -no-share nist/ace/usuba/ua/ace_bitslice.ua
# ACE vslice
./usubac -ua-masked $INLINING -gen-bench -V -no-sched -o nist/ace/usuba/bench/masked_ace_ua_vslice.c -arch std -no-share nist/ace/usuba/ua/ace.ua

echo "Ascon..."
# Ascon bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -B $COMPACT -no-sched -o nist/ascon/usuba/bench/masked_ascon_ua_bitslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua
# Ascon vslice
./usubac -ua-masked -gen-bench $INLINING -V -no-sched -o nist/ascon/usuba/bench/masked_ascon_ua_vslice.c -arch std -no-share nist/ascon/usuba/ua/ascon.ua

echo "Gift..."
# GIFT bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -B $COMPACT -no-sched -o nist/gift/usuba/bench/masked_gift_ua_bitslice.c -arch std -no-share nist/gift/usuba/ua/gift_bitslice.ua
# GIFT bitslice
./usubac -ua-masked -gen-bench $INLINING -V -no-sched -o nist/gift/usuba/bench/masked_gift_ua_vslice.c -arch std -no-share nist/gift/usuba/ua/gift.ua

echo "Gimli..."
# Gimli bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -no-sched -B $COMPACT -o nist/gimli/usuba/bench/masked_gimli_ua_bitslice.c nist/gimli/usuba/ua/gimli_bitslice.ua
# Gimli vslice
./usubac -ua-masked -gen-bench $INLINING -no-sched -V -o nist/gimli/usuba/bench/masked_gimli_ua_vslice.c nist/gimli/usuba/ua/gimli.ua

echo "Photon..."
# Photon bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -B $COMPACT -no-sched -o nist/photon/usuba/bench/masked_photon_ua_bitslice.c -arch std -no-share nist/photon/usuba/ua/photon_bitslice.ua

echo "Pyjamask..."
# Pyjamask bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -no-sched -B $COMPACT -o nist/pyjamask/usuba/bench/masked_pyjamask_ua_bitslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_bitslice.ua
# Pyjamask vslice
./usubac -ua-masked -gen-bench $INLINING -no-sched -V -o nist/pyjamask/usuba/bench/masked_pyjamask_ua_vslice.c -arch std -no-share nist/pyjamask/usuba/ua/pyjamask_vslice.ua

echo "Skinny..."
# Skinny bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -B $COMPACT -no-sched -o nist/skinny/usuba/bench/masked_skinny_ua_bitslice.c -arch std -no-share nist/skinny/usuba/ua/skinny_bitslice.ua

echo "Clyde..."
# Clyde (spook) bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -no-sched -B $COMPACT -o nist/clyde/usuba/bench/masked_clyde_ua_bitslice.c nist/clyde/usuba/ua/clyde_bitslice.ua
# Clyde (spook) vslice
./usubac -ua-masked -gen-bench $INLINING -no-sched -V -o nist/clyde/usuba/bench/masked_clyde_ua_vslice.c nist/clyde/usuba/ua/clyde.ua

echo "Spongent..."
# Spongent bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -check-tbl -B $COMPACT -no-sched -o nist/spongent/usuba/bench/masked_spongent_ua_bitslice.c -arch std -no-share nist/spongent/usuba/ua/spongent.ua

echo "Subterranean..."
# Subterranean bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -no-sched -B $COMPACT -o nist/subterranean/usuba/bench/masked_subterranean_ua_bitslice.c nist/subterranean/usuba/ua/subterranean.ua

echo "Xoodoo..."
# Xoodoo bitslice
./usubac -ua-masked -gen-bench $INLINING -bits-per-reg 8 -no-sched -B $COMPACT -o nist/xoodoo/usuba/bench/masked_xoodoo_ua_bitslice.c nist/xoodoo/usuba/ua/xoodoo.ua
# Xoodoo vslice
./usubac -ua-masked -gen-bench $INLINING -no-sched -V -o nist/xoodoo/usuba/bench/masked_xoodoo_ua_vslice.c nist/xoodoo/usuba/ua/xoodoo.ua
