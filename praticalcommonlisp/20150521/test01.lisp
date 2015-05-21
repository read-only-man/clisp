(defun test-+01 ()
  (and
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))
(defun test-+02 ()
  (format t "~:[FAIL~;pass~]...~a~%" (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (format t "~:[FAIL~;pass~]...~a~%" (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (format t "~:[FAIL~;pass~]...~a~%" (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~]...~a~%" result form))

(defun test-+03 ()
  (report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-result (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (report-result (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(defmacro check (form)
  `(report-result ,form ',form))

(defun test-+04 ()
  (check (= (+ 1 2) 3) )
  (check (= (+ 1 2 3) 6)) 
  (check (= (+ -1 -3) -4)))

(defmacro check (&body from)
  `(progn
     ,@(loop for f in from collect `(report-result ,f ',f))))

(defun test-+05 ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))

