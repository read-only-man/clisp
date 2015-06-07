(let ((path "/foo/bar/baz.txt"))
  (print (pathname-directory (pathname path)))
  (print (pathname-name (pathname path)))
  (print (pathname-type (pathname path)))
  (print (pathname path)))

(let ((pathn (pathname "/foo/bar/baz.txt")))
  (print (namestring pathn))
  (print (directory-namestring pathn))
  (print (file-namestring pathn)))

(defparameter *input-file* (pathname "data.txt"))

(let ((path (make-pathname :directory '(:relative "backups") :defaults *input-file*)))
  (print path))

