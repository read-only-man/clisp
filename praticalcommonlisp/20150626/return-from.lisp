(defun foo ()
  (format t "Enterning foo~%")
  (block a 
	 (format t "Enterning BLOCK~%")
	 (bar #'(lambda () (return-from a)))
	 (format t  " Leabing BLOCK~%"))
  (format t "Leaving foo~%"))

(defun bar (fn)
  (format t "  Enternung bar ~%")
  (baz fn)
  (format t "  Leaving bar~%"))

(defun baz (fn)
  (format t "    Enterning baz~%")
  (funcall fn)
  (format t "    Leaving baz~%"))

(defun bar (fn)
  (format t "  Enterning bar~%")
  (block a (baz fn))
  (format t "  Leaving bar~%"))

