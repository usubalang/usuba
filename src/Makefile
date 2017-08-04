.PHONY: all clean

MENHIR = menhir

MENHIRFLAGS     := --infer --explain

OCAMLBUILD      := ocamlbuild -use-ocamlfind -pkg str -pkg unix -use-menhir -menhir "$(MENHIR) $(MENHIRFLAGS)"

MAIN            := main

all:
	$(OCAMLBUILD) $(MAIN).native

clean:
	rm -f *~ .*~
	$(OCAMLBUILD) -clean

