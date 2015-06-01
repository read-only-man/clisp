(defparameter *plist* ())

(setf (getf *plist* :a) 1)
(print *plist*)
(setf (getf *plist* :a) 2)
(print *plist*)

(remf *plist* :a)
(print *plist*)


