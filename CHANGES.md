# Changes

Here are the changes that were added to Usuba. When creating a pull request, contributors should make sure that they edited this file to document their changes since it makes it easier to find them.

## dump_steps [#29](https://github.com/usubalang/usuba/pull/29)

### New command line arguments to dump the Usuba AST between each normalisation/optimisation step:

- `-dump-steps <type>` Dump the modified Usuba files at each step. The `<type>` is:
  - `usuba`: dump the AST to a `.ua` file as an Usuba program
  - `sexp`: dump the AST to a `.ua` file as a s-expression
  - `ast`: dump the AST to a `.ml` file as an `Usuba_AST.prog` value
- `-dump-steps-dir <dir>`: Directory in which each step should be dumped

### New script in `scripts`, `run-selected.sh`.

Example use:

`./run-selected.sh -- -dump-steps ast -dump-steps-dir tests/rsc`

This will compute `usubac` with some user-provided arguments to a selected list of files that are currently:
- `("ace.ua", "-V -interleave 2")`
- `("aes_generic.ua", "-V")`
- `("aes_mslice.ua", "-H")`
- `("ascon.ua", "-V -interleave 2")`
- `("rectangle.ua", "-H -interleave 2")`

## unit_tests [#30](https://github.com/usubalang/usuba/pull/30)

See the [unit_tests repository](https://github.com/usubalang/unit_tests/commit/2cf99de7ea4b3a49841f14f5e0d40ff141885792).

This repository is linked as a submodule in unit_tests and you shouldn't edit it.

This submodule contains alcotest files for each directory in `unit_tests/rsc` allowing to create unit tests and execute them with `dune build @runtest`. These tests are used to check that refactoring passes does not brake their behaviour.
