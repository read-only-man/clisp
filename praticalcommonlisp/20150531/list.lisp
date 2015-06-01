(defun upto (max)
  (let ((result nil))
    (dotimes (i max)
      (push i result))
    (nreverse result)))

(print (upto 100))

(print
  (mapcar #'(lambda (x) (* x 2)) (upto 10)))
(print
  (mapcar #'+ '(1 2 3) '(10 11 12)))

