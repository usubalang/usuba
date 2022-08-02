#!/bin/bash

#install benchmarks and samples
git clone --recursive https://github.com/usubalang/benchmarks.git

echo "debian or arch?"

read system


if [ "$system" = "arch" ]; then
    # Installing OCaml
    if [ ! $(command -v ocaml) ]; then
        echo "OCaml not found. Installing it...";
        sudo pacman -S ocaml
    fi
    
    # Installing and configuring Opam (OCaml package manager)
    if [ ! $(command -v opam) ]; then
        sudo pacman -S opam
        opam init -y
        eval `opam config env`
    fi
    
    if [ ! $(command -v opam) ]; then
        sudo pacman -S opam
        opam init -y
        eval `opam config env`
    fi
    
    # Installing required modules for Perl scripts
    if [ ! $(command -v cpanm) ]; then
        yay -S cpanminus
    fi
fi

if [ "$system" == "debian" ]; then
    # Installing OCaml
    if [ ! $(command -v ocaml) ]; then
        echo "OCaml not found. Installing it...";
        sudo apt install -y ocaml
    fi
    
    # Installing and configuring Opam (OCaml package manager)
    if [ ! $(command -v opam) ]; then
        echo "Opam not found. Installing it...";
        sudo apt install -y opam
        opam init -y
        eval `opam config env`
    fi
fi





# Installing required packages from opam
opam install -y dune menhir

cpan App::cpanminus
cpan Crypt::Mode::ECB
cpan Crypt::Mode::CTR
cpan File::Copy::Recursive
cpan JSON
cpan List::MoreUtils
cpan Data::Printer
cpan -fi Statistics::Test::WilcoxonRankSum
cpan require::relative
sudo cpanm Crypt::Mode::ECB

./configure --datadir ./benchmarks/examples/data
