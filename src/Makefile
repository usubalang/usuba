.PHONY: all clean

MENHIR = menhir
MENHIRFLAGS := --infer --explain
PACKAGES := -pkg str -pkg unix
INCLUDES := -I normalization -I optimization -I parsing -I c_gen -I verification -I c_gen/runtimes -I tests -I tightprove -I tightprove/parsing -I maskverif
OCAMLBUILD  := ocamlbuild -use-ocamlfind $(PACKAGES) $(INCLUDES) -use-menhir -menhir "$(MENHIR) $(MENHIRFLAGS)"

MAIN     := main

COQCFILES = usuba_AST.v

all:
	coqc $(COQCFILES)
	$(OCAMLBUILD) $(MAIN).native
	rm *.vo *.glob
	./main.native -tests
	cp main.native ../usubac

clean:
	rm -f *~ .*~
	$(OCAMLBUILD) -clean
