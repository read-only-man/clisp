(print (funcall #'+ (values 1 2) (values 3 4)))
(print (multiple-value-call #'+ (values 1 2) (values 3 4)))

(multiple-value-bind
  (x y) (values 1 2)
  (print (+ x y)))


