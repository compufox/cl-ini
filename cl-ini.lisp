;;;; cl-ini.lisp

(in-package #:cl-ini)

(declaim (inline section-header-p parse-section-header
                 to-keyword agetf comment-p))

(defun section-header-p (line)
  (and (str:starts-with-p "[" line)
       (str:ends-with-p "]" line)))

(defun parse-section-header (line)
  (to-keyword (subseq line 1 (1- (length line)))))

(defun to-keyword (s)
  (intern (string-upcase s) :keyword))

(defun agetf (place item &optional default)
  (or (cdr (assoc item place :test #'equal))
      default))

(defun comment-p (line)
  (str:starts-with-p ";" line))

(defun should-remove-p (line)
  (or (str:blankp line)
      (comment-p line)))

(defun read-file (file)
  (remove-if #'should-remove-p
             (mapcar #'str:trim (str:lines (str:from-file file)))))

(defun parse-keypair (keypair)
  (let* ((split (mapcar #'str:trim (str:split "=" keypair)))
         (key (to-keyword (first split)))
         (value (parse-value (cadr split))))
    (cons key value)))

(defun parse-value (value)
  "determines what kind of data VALUE is, and parses it correctly"
  (cond
    ;; parse digit
    ((str:digitp value) (parse-integer value))

    ;; if we are going to parse lists and our value has that separator
    ;;  then we split it up, and trim the results, and parse them
    ((str:containsp "," value)
     (mapcar #'parse-value (mapcar #'str:trim (str:split "," value))))

    ;; if false or blankp, we return nil
    ((or (string= "false" (string-downcase value))
	 (str:blankp value))
     nil)

    ;; if value is like :value then we interpret that as a keyword
    ((str:starts-with-p ":" value)
     (to-keyword (subseq value 1 (length value))))

    ;; if we're here then we just return the straight value
    (t value)))

(defun parse-ini (file)
  "reads FILE in and parses it

if no section is defined then all key-pairs are put into a :GLOBAL section

returns an alist with the same structure of the ini file"
  (loop with current-section = :global
        with lines = (read-file file)
        for i upto (1- (length lines))
        for line = (elt lines i)

        if (section-header-p line) do
          (setf current-section (parse-section-header line))
        else 
          collect (cons current-section
                        (loop for j from i upto (1- (length lines))
                              for line = (elt lines j)
                            
                              until (section-header-p line)
                              collect (parse-keypair line)

                              finally (setf i (1- j))))))

(defun ini-value (ini key &key (section :global))
  "returns the value of KEY for SECTION in INI

returns NIL if key is missing"
  (agetf (cdr (find section ini :key #'car)) key))
