#!/bin/bash

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

# Installing required packages from opam
opam install -y dune menhir

# Installing required modules for Perl scripts
sudo cpanm Crypt::Mode::ECB
