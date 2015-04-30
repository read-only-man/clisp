(with-open-file (my-stream "data.txt" :direction :output)
  (print "my data" my-stream))
(print (with-open-file (my-stream "data.txt" :direction :input)
	 (read my-stream)))
(let ((animal-noise '((dog . wolf) (cat . merow))))
  (with-open-file (my-stream "animal-noise.txt" :direction :output)
    (print animal-noise my-stream)))
(with-open-file (my-stream "animal-noise.txt" :direction :input)
  (print (read my-stream)))
#|
(with-open-file (my-stream "data.txt" :direction :output :if-exists :error)
  (print "my-data2" my-stream))
|#
(with-open-file (my-stream "data.txt" :direction :output :if-exists :supersede)
  (print "my data2" my-stream))
(with-open-file (my-stream "data.txt" :direction :input)
  (print (read my-stream)))

