;; asdf-ghjk - Guix Package Definition
;; Run: guix shell -D -f guix.scm

(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system gnu)
             ((guix licenses) #:prefix license:)
             (gnu packages base))

(define-public asdf_ghjk
  (package
    (name "asdf-ghjk")
    (version "0.1.0")
    (source (local-file "." "asdf-ghjk-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system gnu-build-system)
    (synopsis "Guix channel/infrastructure")
    (description "Guix channel/infrastructure - part of the RSR ecosystem.")
    (home-page "https://github.com/hyperpolymath/asdf-ghjk")
    (license license:agpl3+)))

;; Return package for guix shell
asdf_ghjk
