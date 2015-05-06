(defparameter my-stream (socket-connect 4321 "127.0.0.1"))

(print "Yo Server" my-stream)
(print (read my-stream))

(close my-stream)

