#!/bin/bash

# Installing and configuring Opam (OCaml package manager)
if [ ! $(command -v opam) ]; then
    echo "Opam not found. Installing it...";
    sudo apt install -y opam
    opam init -y
    eval `opam config env`
fi

# Installing required packages from opam
opam -y build
