(defun add-widget (database widget)
  (cons widget database))

(defparameter *database* nil)

(defun main-loop ()
  (loop (princ "Please enter the name of widget:")
	(setf *database* (add-widget *database* (read)))
	(format t "The database constains the following: ~a~%" *database*)))

(main-loop)

