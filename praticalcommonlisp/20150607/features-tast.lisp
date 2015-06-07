(defun featuers ()
  #+allego (print "featuer is Allego")
  #+sbcl (print "featuer is SBCL")
  #+clisp (print "featuer is CLISP")
  #+cmu (print "featuer is CMUCL")
  #- (or allego sbcl clisp cmu) (print "unkown featuer"))

(featuers)

