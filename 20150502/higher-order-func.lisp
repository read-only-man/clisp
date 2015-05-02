(defparameter *my-list* '(1 3 5 7))
(loop for n below (length *my-list*)
      do (setf (nth n *my-list*) (+ (nth n *my-list*) 2)))
(print *my-list*)

(defun add-two (lst)
  (when lst
    (cons (+ 2 (car lst)) (add-two (cdr lst)))))
(print (add-two '(2 4 6 8)))

(print
  (mapcar (lambda (x)
	    (+ x 2))
	  '(3 6 9 11)))
