#!/bin/bash

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

if [ ! $(command -v opam) ]; then
    sudo pacman -S opam
    opam init -y
    eval `opam config env`
fi


# Installing required packages from opam
opam install -y dune menhir


# Installing required modules for Perl scripts
if [ ! $(command -v cpanm) ]; then
    yay -S cpanminus
fi
sudo cpanm Crypt::Mode::ECB

# Install samples and benchmarks
git clone https://github.com/usubalang/examples.git && \
git clone https://github.com/usubalang/benchmarks.git
