(defvar *number-is-odd* nil)
(when (oddp 5)
  (setf *number-is-odd* t)
  (print "odd number"))
(unless (oddp 4)
  (setf *number-is-odd* nil)
  (print "even number"))
