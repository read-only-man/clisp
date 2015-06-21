(define-condition makformed-log-entry-error (error)
  ((text :initarg :text :reader text)))

(defun parse-log-entry (text)
  (if (well-formed-log-entry-p text)
    (make-instance 'log-entry :text text)
    (error 'malformed-log-entry-error :text text)))

#|
(defun parse-log-file (file)
  (with-open-file (in file :direction :input)
    (loop for text = (read-line in nil nil) while text
	  for entry = (handle-case (parse-log-entry text)
				   (malformed-log-entry-error () nil))
	  when entry collect it)))
|#
(defun parse-log-file (file)
  (with-open-file (in file :direction :input)
    (loop for text = (read-line in nil nil) while text
	  for entry = (restart-case (parse-log-entry text)
			(skip-log-entry () nil))
	  when entry collect it)))
#|
(defun log-analyzer ()
  (dolist (log (find-all-logs))
    (analyze-log log)))
|#
(defun analize-log (log)
  (dolist (entry (parse-log-file log))
    (analize-entry entry)))

(defun log-anakyzer ()
  (handler-bind ((malformed-log-entry-error
		   #'(lambda (c)
		       (invoke-restart 'skip-log-entry))))
    (do-list (log (find-all-logs))
	     (analyze-log log))))



