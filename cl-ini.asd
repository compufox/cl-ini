;;;; cl-ini.asd

(asdf:defsystem #:cl-ini
  :description "Describe cl-ini here"
  :author "ava fox"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:str)
  :components ((:file "package")
               (:file "cl-ini")))
