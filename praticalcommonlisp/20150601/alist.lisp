(defmacro with-print (&body body)
  `(progn
     ,@(loop for part in body
	     collect `(print ,part))))

(with-print
  (assoc 'a '((a . 1) (b . 2) (c . 3)))
  (assoc 'b '((a . 1) (b . 2) (c . 3)))
  (assoc 'd '((a . 1) (b . 2) (c . 3)))
  (cdr (assoc 'a '((a . 1) (b . 2) (c . 3)))))

(terpri)

(with-print
  (assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)) :test #'string=)
  (assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3))))

(terpri)

(with-print
  (let ((alist '((a . 1) (b . 2) (c .3))))
    (append
      (cons (cons 'new-key 'new-val) alist)
      (acons 'new-key 'new-val alist)
      alist)))

(terpri)

(defparameter *alist*
  '((a . 1) (b . 2) (c .3)))

(setf *alist* (acons 'new-key 'new-value *alist*))
(print *alist*)

(push (cons 'new-key 'new-value2)*alist* )
(print *alist*)

(terpri)

(with-print
  (pairlis '(a b c) '(1 2 3)))

