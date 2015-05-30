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

(terpri)

(with-print
  (map 'vector #'* #(1 2 3 4 5) #(10 9 8 7 6))
  (map 'list #'* #(1 2 3 4 5) #(10 9 8 7 6))
  (let ((a #(1 2 3))
	(b #(4 5 6))
	(c #(7 8 9)))
    (map-into a #'+ a b c)))

(terpri)

(let ((nums '(1 2 3 4 5 6 7 8 9 10)))
  (with-print
    (reduce #'+ nums)
    (reduce #'+ nums :initial-value 0)
    (reduce #'+ nums :initial-value 100)))

(terpri)

(let ((h (make-hash-table)))
  (with-print
    (gethash 'foo h)
    (setf (gethash 'foo h) 'quux)
    (gethash 'foo h)))

(terpri)

(defun show-value (key hash)
  (multiple-value-bind (value present) (gethash key hash)
    (if present
      (format t "Value ~a actually present.~%" value)
      (format t "Value ~a because key not found.~%" value))))

(defparameter *h* (make-hash-table))
(setf (gethash 'foo *h*) "Fofo")
(setf (gethash 'bar *h*) Nil)

(show-value 'foo *h*)
(show-value 'bar *h*)
(show-value 'baz *h*)

(maphash #'(lambda (k v ) (format t "~a => ~a~%" k v)) *h*)

(defparameter *hh* (make-hash-table))
(loop for i from 1 upto 10 do
      (setf (gethash (code-char (+ i 96)) *hh*) (* i i)))
(print *hh*)

(terpri)

(maphash #'(lambda (k v) (when (< v 10) (remhash k *hh*))) *hh*)
(print *hh*)

