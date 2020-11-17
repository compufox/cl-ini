;;;; package.lisp

(defpackage #:cl-ini
  (:use #:cl)
  (:nicknames :ini)
  (:export :parse-ini
           :ini-value))
