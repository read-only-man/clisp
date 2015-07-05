(defparameter *obj* (cons nil nil))

(defun foo ()
  (format t "Enterning foo~%")
  (catch *obj*
	 (format t " Enterning CATCH~%")
	 (bar)
	 (format t " Leaving CATCH~%"))
  (format t "Leaving foo~%"))

(defun bar ()
  (format t "  Enterning bar~%")
  (baz)
  (format t "  Leaving bar~%"))

(defun baz ()
  (format t "   Enternign baz~%")
  (throw *obj* nil)
  (format t "   Leaving ba~%"))

