'simple loop
(loop (princ "type something:") (force-output) (read))
' do* :: doing
(loop for i below 5 do (print i))
' with
(loop with x = (+ 1 2) repeat 5 do (print x))
' repaeat
(loop repeat 5 do (print "Printing five times."))
' named,return-from
(loop named outer for i below 10 do
      (progn (print "outer")
	     (loop named inner for x below i do (print "**inner") when (= x 2) do (return-from outer 'kicked-out-all-the-way))))
' being
(defparameter salary (make-hash-table))
(setf (gethash 'bob salary) 80)
(setf (gethash 'alen salary) 90)
(loop for person being each hash-key of salary do (print person))
' using
(defparameter salary (make-hash-table))
(setf (gethash 'bob salary) 80)
(setf (gethash 'alen salary) 90)
(loop for person being each hash-keys of salary using (hash-value amt) do (print (cons person amt)))
' return
(loop for i below 10 when (= i 5) return 'leaving-early do (print i))
' the == each
(defparameter salary (make-hash-table))
(setf (gethash 'bob salary) 80)
(setf (gethash 'alen salary) 90)
(loop for person being the hash-keys of salary do (print person))
' initially
(loop initially (print '(loop begin)) for x below 3 do (print x))
' while
(loop for i in '(0 2 4 555 6) while (evenp i) do (print i))
' finnaly
(loop for x below 3 do (print x) finally (print 'loop-end))
' until
(loop for i from 0 do (print i) until (> i 3))
' hash-key == hash-keys
(defparameter salary (make-hash-table))
(setf (gethash 'bob salary) 80)
(setf (gethash 'alen salary) 90)
(loop for person being each hash-key of salary do (print person))
(loop for person being each hash-keys of salary do (print person))
' hash-value == hash-values
(defparameter salary (make-hash-table))
(setf (gethash 'bob salary) 80)
(setf (gethash 'alen salary) 90)
(loop for amt being each hash-value of salary do (print amt))
(loop for amt being each hash-values of salary do (print amt))
' for == as
(loop for i from 0 do (print i) when (= i 5) return 'zuchini)
(loop as i from 0 do (print i) when (= i 5) return 'zuchini)
' if
(loop for i below 5 if (oddp i) do (print i))
' when
(loop for i below 4 when (oddp i) do (print i) (print "yup"))
(loop for i below 4 when (oddp i) do (print i) do (print "yup"))
' unless
(loop for i below 5 unless (oddp i) do (print i))
' and
(loop for x below 5 when (= x 3) do (print "do this") and do (print "also do this") do (print "always do this"))
' else
(loop for i below 5 if (oddp i) do (print i) else do (print "w00t"))
' end
(loop for i below 4 when (oddp i) do (print i) end do (print "yup"))
' in == on
(loop for i in '(100 20 3) sum i)
(loop for i in '(100 20 3) do(print i))
(loop for i on (list '100 '20 '3) do (print i))
(loop for i on '(100 20 3) do (print i))
' by from to
(loop for i from 6 to 8 by 2 sum i)
(loop for i from 6 to 8 sum i)
' upfrom upto
(loop for i upfrom 6 to 8 sum i)
(loop for i from 6 upto 8 sum i)
' downfrom downto
(loop for i downfrom 10 to 7 sum i)
(loop for i from 10 downto 7 sum i)
' then
(loop repeat 5 for x = 10.0 then (/ x 2) collect x)
(loop repeat 5 for x = 10.0 collect (/ x 2))
' count
(loop for i in '(1 1 1 1) count i)
' sum
(loop for i below 5 sum i)
' minimize
(loop for i in '(4 2 3 5 6 7) minimize i)
'maximize
(loop for i in '(4 2 3 5 6 7) maximize i)
' append
(loop for i below 5 append (list 'Z i))
' nconc
(loop for i below 5 nconc (list 'Z i))
' into
(loop for i in '(3 8 72 4 -5) minimize i into lowest maximize i into biggest finally (return (cons lowest biggest)))
' always
(loop for i in '(0 2 4) always (evenp i))
(loop for i in '(0 3 4) always (evenp i))
' never
(loop for i in '(0 2 4) never (oddp i))
(loop for i in '(0 2 3) never (oddp i))
' thereis
(loop for i in '(0 2 4 6 555) thereis (oddp i)) 
(loop for i in '(0 2 4 6 556) thereis (oddp i))
