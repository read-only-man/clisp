(defparameter *nodes* '((living-room (you are in the living-room. a wizard is snoring loudly on the courch))
			(garden (you are in a beautiful garden. there is awell in front of you.))
			(attic (you are in the attic.  is a giant welding torch in the couner.))))
(defparameter *edges* '((living-room (garden west door)
				     (attic upstairs ladder))
			(garden (living-room east door))
			(attic (living-room downstairs ladder))))
(defparameter *objects* '(whiskey buket frog chain))
(defparameter *object-locations* '((whiskey living-room)
				   (buket living-room)
				   (frog garden)
				   (chain garden)))
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
(print (look))
