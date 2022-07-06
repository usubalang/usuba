(lang dune 2.8)

(implicit_transitive_deps true)

; Menhir options
(using menhir 2.0)

; Since we want to generate opam files we need to provide informations ;
(generate_opam_files true)

(name usuba)
(version dev)
(authors "Usuba developers")
(maintainers "Usuba developers")
(source (github usuba-lang/usuba))
; Not specifying bug_reports since it defaults to the github issue page
(homepage "https://usubalang.github.io/usuba/")
(documentation "https://usubalang.github.io/usuba/")

; Packages

(package
 (name usuba)
 (synopsis "Usuba")
 (description "\
TODO")
 (depends
   ocaml
   dune
   sexplib
  (usuba_lib (= :version))
  (usuba_pp (= :version))
  (odoc :with-doc)
  (ocamlformat (= 0.22.4))
 )
)

(package
 (name usuba_lib)
 (synopsis "Usuba Library")
 (description "\
TODO")
 (depends
   ocaml
   dune
   menhir
   ppx_deriving
   sexplib
   ppx_sexp_conv
  (usuba_pp (= :version))
  (odoc :with-doc)
  (ocamlformat (= 0.22.4))
 )
)

(package
 (name usuba_pp)
 (synopsis "Usuba PP")
 (description "\
Pretty printing for stdlib modules")
 (depends
   ocaml
   dune
  (odoc :with-doc)
  (ocamlformat (= 0.22.4))
 )
)
