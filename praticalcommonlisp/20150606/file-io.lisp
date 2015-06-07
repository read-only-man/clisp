(setf *terminal-encoding* charset:utf-16)

(let ((in (open "date.txt")))
  (format t "~a~%" (read-line in))
  (close in))

#|
(with-open-file
  (out
    "date2.txt"
    :direction :output)
  (print "test" out))

(with-open-file
  (in
    "date2.txt"
    :direction :input)
  (print (read in)))
|#

(let ((in (open "/some/hoge/not.txt" :if-does-not-exist nil)))
  (when in
    (format t "~a~~%" (read-line in))
    (close in)))

(let ((in (open "date.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do (format t "~a~%" line))
    (close in)))

(defparameter *s* (open "read-test.lisp"))
(print (read *s*))
(print (read *s*))
(print (read *s*))
(print (read *s*))
(close *s*)

(let ((out (open "output.txt" :direction :output :if-exists :supersede)))
  (write-char #\a out)
  (write-line "the quick brown fox jumps over lazy dogs" out)
  (write-string "thw quick brown fox jumps over lazy dogs" out)
  (terpri out)
  (fresh-line out)
  (print '(+ 1 2))
  (close out))

(with-open-file (in "output.txt")
  (when in
    (loop for line = (read-line in nil)
	  while line do (print line))))

