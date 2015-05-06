(defmacro let1 (var val &body body)
  `(let ((,var ,val))
     ,@body))

(let1 foo (+ 2 3)
      (princ "Lisp is awesome!")
      (princ (* foo foo)))

(print
  (macroexpand
    '(let1 foo (+ 2 3)
	   (princ "Lisp is awesome!")
	   (princ (* foo foo)))))

(defun my-length (lst)
  (labels ((f (lst acc)
	      (if lst
		(f (cdr lst) (1+ acc))
		acc)))
    (f lst 0)))

#|
(defmacro split (val yes no)
  `(if ,val
     (let ((head (car ,val))
	   (tail (cdr ,val)))
       ,yes)
     ,no))
|#
(defmacro split (val yes no)
  (let1 g (gensym)
    `(let1 ,g ,val
	   (if ,g
	     (let ((head (car ,g))
		   (tail (cdr ,g)))
	       ,yes)
	     ,no))))

(defun my-length (lst)
  (labels ((f (lst acc)
	      (split lst
		     (f tail (1+ acc))
		     acc)))
    (f lst 0)))

(print (my-length '(1 2 3 4 5)))
(fresh-line)

(split (progn (princ "Lisp rocks!")
	      '(2 3))
       (format t "This can be split into ~a and ~a." head tail)
       (format t "This can not be split."))

(print
  (macroexpand 
    '(split (progn (princ "Lisp rocks!")
		   '(2 3))
	    (format t "This can be split into ~a and ~a." head tail)
	    (format t "This can not be split."))))

(let1 x 100
      (split '(2 3)
	     (print (+ x head))
	     nil))

(print
  (macroexpand
    (let1 x 100
	  (split '(2 3)
		 (print (+ x head))
		 nil))))

(defun pairs (lst)
  (labels ((f (lst acc)
	      (split lst
		     (if tail
		       (f (cdr tail) (cons (cons head (car tail)) acc))
		       (reverse acc))
		     (reverse acc))))
    (f lst nil)))

(print (pairs '(a b c d e f g)))

(defmacro recurse (vars &body body)
  (let1 p (pairs vars)
	`(labels ((self ,(mapcar #'car p)
			,@body))
	   (self ,@(mapcar #'cdr p)))))

(defun my-length (lst)
  (recurse (lst lst acc 0)
	   (split lst
		  (self tail (1+ acc))
		  acc)))

(print (my-length '(1 2 3 4 5)))
