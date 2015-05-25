(defmacro with-print (&body data)
  `(progn
     ,@(loop for d in data collect `(print ,d))))

(with-print
  (vector)
  (vector 1)
  (vector 1 2))

(defparameter *x* (make-array 5 :fill-pointer 0))

(defmacro with-print-and-third-arg (&body data)
  `(progn
     ,@(loop for d in data collect `(format t "~a : ~a~%" ,d (symbol-value (caddr ',d))))))

(defmacro with-print-and-second-arg (&body data)
  `(progn
     ,@(loop for d in data collect `(format t "~a : ~a~%" ,d (symbol-value (cadr ',d))))))

#|
(print
  (macroexpand
    '(with-print-and-third-arg
       (vector-push 'a *x*)
       (vector-push 'b *x*)
       (vector-push 'c *x*))))
|#

(fresh-line)

(with-print-and-third-arg
  (vector-push 'a *x*)
  (vector-push 'b *x*)
  (vector-push 'c *x*))

(with-print-and-second-arg
  (vector-pop *x*)
  (vector-pop *x*)
  (vector-pop *x*))

