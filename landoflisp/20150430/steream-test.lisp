(print (output-stream-p *standard-output*))
(write-char #\x *standard-output*)
(print (input-stream-p *standard-input*))
(print (read-char *standard-input*))
(print 'foo *standard-output*)

