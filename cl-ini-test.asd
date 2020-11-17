;;;; cl-ini-test.asd

(asdf:defsystem #:cl-ini-test
  :description "tests cl-ini"
  :author "ava fox <dev@computerfox.xyz>"
  :serial t
  :depends-on (#:cl-ini #:prove)
  :components ((:module "t"
	        :components
	        ((:file "package")
		 (:file "main")))))
