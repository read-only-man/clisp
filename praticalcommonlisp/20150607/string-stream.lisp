(let ((s (make-string-input-stream "1.23")))
  (unwind-protect (print (read s))
    (close s)))

(with-input-from-string (s "1.23")
  (print (read s)))

(fresh-line)

(princ
  (with-output-to-string (out)
    (format out "hello world")
    (format out "~s" (list 1 2 3))))

