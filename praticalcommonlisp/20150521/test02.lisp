(defmacro with-gensym ((&rest names) &body body)
  `(let ,(loop for name in names collect `(,name (gensym)))
     ,@body))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~]...~a~%" result form)
  result)

(defmacro combine-result (&body forms)
  (with-gensym (result)
	       `(let ((,result t))
		  ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
		  ,result)))

(defmacro check (&body forms)
  `(combine-result
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))
