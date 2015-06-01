(defmacro with-print (&body body)
  `(progn
     ,@(loop for x in body
	     collect `(print ,x))))

(with-print
  (subst 10 1 '(1 2 (3 2 1) ((1 1) (2 2))))
  (substitute 10 1 '(1 2 (3 2 1) ((1 1) (2 2)))))

(terpri)

(defparameter *set* ())


