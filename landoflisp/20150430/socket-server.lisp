(defparameter my-socket (socket-server 4321))
(defparameter my-stream (socket-accept my-socket))

(print (read my-stream))
(print "What up, Client" my-stream)
(close my-stream)
(socket-server-close my-socket)

