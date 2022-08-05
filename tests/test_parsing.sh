#!/bin/sh
exec ocaml unix.cma ./tests/test_parsing.ml "$@"
