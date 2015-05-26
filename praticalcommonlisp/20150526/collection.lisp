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

(defparameter *xx* (vector 1 2 3))

(with-print
  (length *xx*)
  (elt *xx* 0)
  (elt *xx* 1)
  (elt *xx* 2))
;(elt *xx* 3)

(fresh-line)

(with-print
  (count 1 #(1 2 1 2 3 1 2 3 4))
  (remove 1 #(1 2 1 2 3 1 2 3 4))
  (remove 1 '(1 2 1 2 3 1 2 3 4))
  (remove #\a "foobarbaz")
  (substitute 5 1 #(1 2 1 2 3 1 2 3 4))
  (substitute 5 1 '(1 2 1 2 3 1 2 3 4))
  (find 1 #(1 2 1 2 3 1 2 3 4))
  (find 10 #(1 2 1 2 3 1 2 3 4))
  (position 1 #(1 2 1 2 3 1 2 3 4)))

(fresh-line)

(with-print
  (count "foo" #("foo" "bar" "baz") :test #'string=)
  (find 'c #((a 10) (b 20) (c 30)) :key #'first))

(fresh-line)
(terpri)

(defparameter *v* #((a 10) (b 20) (a 30) (b 40)))
(defun verbose-first (x)
  (format t "verbose-first... ~a~%" x)
  (first x))
(count 'a *v* :key #'verbose-first)

(terpri)

(count 'a *v* :key #'verbose-first :from-end t)

(with-print
  (count-if #'evenp #(1 2 3 4 5 6 7))
  (count-if-not #'evenp #(1 2 3 4 5 6 7))
  (position-if #'digit-char-p "abcd0001")
  (remove-if-not #'(lambda (x) (char= (elt x 0) #\f)) #("foo" " bar " "bax" "fox")))

(terpri)

(with-print
  (count-if #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first)
  (count-if-not #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first)
  (remove-if-not #'alpha-char-p #("foo" "bar" "baz" "1bax" "2box") :key #'(lambda (x) (elt x 0))))

