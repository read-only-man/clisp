(defun my-length (list)
  ( if list
       (+ 1 (my-length(cdr list)))
       0))
(print (my-length '(this is four sentense)))

