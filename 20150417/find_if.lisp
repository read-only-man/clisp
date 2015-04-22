(print (find-if #'oddp '(2 4 5 6 3)))
(if (find-if #'oddp '(2 4 5 6 3))
  (print 'there-is-odd-number)
  (print 'there-is-not-odd-number))
