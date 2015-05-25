(defmacro with-gensym ((&rest names) &body body)
  `(let ,(loop for name in names collect `(,name (gensym)))
     ,@body))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~]...~a:~a~%" result *test-name* form)
  result)

(defmacro combine-result (&body forms)
  (with-gensym (result)
	       `(let ((,result t))
		  ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
		  ,result)))

(defmacro check (&body forms)
  `(combine-result
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defvar *test-name* nil)

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))
#|
(defun test-+ ()
  (let ((*test-name* 'test-+))
    (check
      (= (+ 1 2) 3)
      (= (+ 1 2 3) 6)
      (= (+ -1 -3) -4))))

(defun test-* ()
  (let ((*test-name* 'test-*))
    (check
      (= (* 2 2) 4)
      (= (* 3 4) 12))))
|#

(deftest test-+ ()
	 (check
	   (= (+ 1 2) 3)
	   (= (+ 1 2 3) 6)
	   (= (+ -1 -3) -4)))

(deftest test-* ()
	 (check
	   (= (* 2 2) 4)
	   (= (* 3 4) 12)))

(deftest test-arithmetric ()
  (combine-result
    (test-+)
    (test-*)))


