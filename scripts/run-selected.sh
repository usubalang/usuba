#!/bin/sh
exec ocaml unix.cma $(dirname $0)/run-selected.ml "$@"
