;;;; cl-ini.asd

(asdf:defsystem #:cl-ini
  :description "INI file parser"
  :author "ava fox <dev@computerfox.xyz>"
  :license  "MIT"
  :version "0.1"
  :serial t
  :depends-on (#:str)
  :components ((:file "package")
               (:file "cl-ini"))
  :in-order-to ((test-op (test-op "cl-ini-test"))))
