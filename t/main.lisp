(in-package :cl-ini-test)

(plan 4)

(defvar *ini*
  (parse-ini (merge-pathnames "t/test.ini"
                              (asdf:system-source-directory :cl-ini-test))))

(is (ini-value *ini* :var1) 1)
(isnt (ini-value *ini* :var1 :section :test) 1)
(is (ini-value *ini* :var1 :section :test) 3)
(is (ini-value *ini* :string-test :section :test2) "four")

(finalize)
