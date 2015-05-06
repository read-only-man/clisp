(defparameter *nodes* '((living-room (you are in the living-room. a wizard is snoring loudly on the courch.))
			(garden (you are in a beautiful garden. there is a well in front of you.))
			(attic (you are in the attic.  is a giant welding torch in the couner.))))

(defparameter *edges* '((living-room (garden west door)
				     (attic upstairs ladder))
			(garden (living-room east door))
			(attic (living-room downstairs ladder))))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '((whiskey living-room)
				   (bucket living-room)
				   (frog garden)
				   (chain garden)))

(defparameter *allowed-commands* '(look walk pickup inventory))

(defparameter *location* 'living-room)

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

;(print (describe-paths 'living-room *edges*))

(defun objects-at (location objects object-locations)
  (labels ((at-loc-obj (object)
		       (eq (cadr (assoc object object-locations)) location)))
    (remove-if-not #'at-loc-obj objects)))

;(print (objects-at 'living-room *objects* *object-locations*))

(defun describe-objects (location objects object-locations)
  (labels ((describe-object (object)
			    `(you see a ,object on the floor.)))
    (apply #'append (mapcar #'describe-object (objects-at location objects object-locations)))))

;(print (describe-objects 'living-room *objects* *object-locations*))

(defun look ()
  (append (describe-location *location* *nodes*)
	  (describe-paths *location* *edges*)
	  (describe-objects *location* *objects* *object-locations*)))

;(print (look))

(defun walk (direction)
  (let ((next (find direction
		    (cdr (assoc *location* *edges*))
		    :key #'cadr)))
    (if next
      (progn (setf *location* (car next))
	     (look))
      '(you cannot go that way.))))

;(walk 'west)
;(print (walk 'north))

(defun pickup (object)
  (cond ((member object
		 (objects-at *location* *objects* *object-locations*))
	 (push (list object 'body) *object-locations*)
	 `(you are now carrying the ,object))
	(t '(you cannnot get that.))))

;(walk 'east)
;(pickup 'whiskey)

(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))

;(inventory)

(defun game-read ()
  (let ((cmd (read-from-string
	       (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
		     (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
    (eval sexp)
    '(I do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
	  (rest (cdr lst)))
      (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
	    ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
	    ((eql item #\") (tweak-text rest caps (not lit)))
	    (lit (cons item (tweak-text rest nil lit)))
	    (caps (cons (char-upcase item) (tweak-text rest nil lit)))
	    (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ (coerce (tweak-text (coerce (string-trim "() "
						  (prin1-to-string lst))
				     'list)
			     t
			     nil)
		 'string))
  (fresh-line))

(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))

(defun have (object)
  (member object (cdr (inventory))))

(defparameter *chain-welded* nil)

#|
(defun weld (subject object)
  (if (and (eq *location* 'attic)
	   (eq subject 'chain)
	   (eq object 'bucket)
	   (have 'chain)
	   (have 'bucket)
	   (not *chain-welded*))
    (progn (setf *chain-welded* t)
	   '(the chain is now securely welded to he bucket.))
    '(you cannot weld like that.)))

(pushnew 'weld *allowed-commands*)
|#

(defparameter *bucket-filled* nil)

#|
(defun dunk (subject object)
  (if (and (eq *location* 'garden)
	   (eq subject 'bucket)
	   (eq object 'well)
	   (have 'bucket)
	   *chain-welded*)
    (progn (setf *bucket-filled* 't)
	   '(the bucket is now full of water))
    '(you cannot dunk like that.)))

(pushnew 'dunk *allowed-commands*)
|#

(defmacro game-action (command subj obj place &body body)
  (let ((s (gensym))
	(o (gensym)))
    `(progn (defun ,command (,s ,o)
	      (if (and (eq *location* ',place)
		       (eq ,s ',subj)
		       (eq ,o ',obj)
		       (have ',subj))
		,@body
		'(i cant ,command like that.)))
	    (pushnew ',command *allowed-commands*))))

(game-action weld chain bucket attic
	     (if (and (have 'bucket) (not *chain-welded*))
	       (progn (setf *chain-welded* 't)
		      '(the chain is now securely welded to the bucket))
	       '(you do not have a bucket.)))

(game-action dunk bucket well garden
	     (if *chain-welded*
	       (progn (setf *bucket-filled* 't)
		      '(the bucket is now full of water))
	       '(the water level is too low to reach.)))

(game-action splash bucket wizard living-room
	     (cond ((not *bucket-filled*) '(the bucket has nothing in it.))
		   ((have 'frog) '(the wozard awakens and sees that you stole his frog.
				       he is so upset he banishes you to the netherworlds- you lose!
				       the end.))
		   (t '(the wizard awakens from his slumber and greets you wamly.
			    he hands you the magic low-carb donut- you win!
			    the end.))))

(game-repl)