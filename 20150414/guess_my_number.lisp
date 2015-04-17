(defparameter *small* 1)
(defparameter *big* 100)
(defun guess_my_number()
	(ash (+ *small* *big*) -1))
(defun smaller()
	(setf *big* (1- (guess_my_number)))
	(guess_my_number))
(defun bigger()
	(setf *small* (1+ (guess_my_number)))
	(guess_my_number))
(defun start_over()
	(defparameter *small* 1)
	(defparameter *big* 100))
