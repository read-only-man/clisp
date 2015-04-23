(print '3)
(print '3.4)
(print 'foo)
(print '"foo")
(print '#\a)

(princ '3)
(princ '3.4)
(princ 'foo)
(princ '"foo")
(princ '#\a)
(princ #\newline)

(progn (princ "This sentence will be interrupted")
       (princ #\newline)
       (princ "by an annoying newline character."))

