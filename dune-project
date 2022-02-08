(lang dune 2.8)

(implicit_transitive_deps false)

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
  (usuba-lib (= :version))
  ; Not needed for now
  ; (usuba-common (= :version))
  (odoc :with-doc)
 )
)

; (package
;  (name usuba-common)
;  (synopsis "Usuba common modules for binaries")
;  (description "\
; TODO")
;  (depends
;    ocaml
;    dune
;    cmdliner
;   (usuba-lib (= :version))
;   (odoc :with-doc)
;  )
; )

(package
 (name usuba-lib)
 (synopsis "Usuba Library")
 (description "\
TODO")
 (depends
   ocaml
   dune
   menhir
  (odoc :with-doc)
 )
)
