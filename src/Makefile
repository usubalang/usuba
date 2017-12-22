.PHONY: all clean

MENHIR = menhir
MENHIRFLAGS := --infer --explain
PACKAGES := -pkg str -pkg unix -pkg mlbdd
INCLUDES := -I normalization -I optimization -I parsing -I c_gen -I verification -I c_gen/runtimes
OCAMLBUILD  := ocamlbuild -use-ocamlfind $(PACKAGES) $(INCLUDES) -use-menhir -menhir "$(MENHIR) $(MENHIRFLAGS)"

MAIN     := main

COQCFILES = usuba_AST.v

all:
	coqc $(COQCFILES)
	$(OCAMLBUILD) $(MAIN).native
	rm *.vo *.mli *.glob
	cp main.native ../usubac

clean:
	rm -f *~ .*~
	$(OCAMLBUILD) -clean

