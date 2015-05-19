(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

#|
(defmacro do-prime ((var start end ) &body body)
  `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var))))
     ((> ,var ,end))
     ,@body))
|#
#|
(defmacro do-prime ((var start end ) &body body)
  (let ((endvar (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var)))
	  (,endvar ,end))
       ((> ,var ,endvar))
       ,@body)))
|#
(defmacro with-gensym ((&rest names) &body body)
  `(let ,(loop for name in names collect `(,name (gensym)))
     ,@body))

(defmacro do-prime ((var start end ) &body body)
  (with-gensym (endvar)
    `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var)))
	  (,endvar ,end))
       ((> ,var ,endvar))
       ,@body)))

(do-prime (p 0 19) (format t "~a~%" p))
(princ (macroexpand-1 '(do-prime (p 0 19) (format t "~a~%" p))))


