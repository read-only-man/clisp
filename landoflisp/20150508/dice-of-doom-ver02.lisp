(load "dice-of-doom-ver01.lisp")
(load "lazy.lisp")

(defparameter *board-size* 4)
(defparameter *board-hexnum* (* *board-size* *board-size*))

(defun add-passing-move (board player spare-dice first-move moves)
  (if first-move
    moves
    (lazy-cons (list nil
		     (game-tree (add-new-dice board player
					      (1- spare-dice))
				(mod (1+ player) *num-players*)
				0
				t))
	       moves)))

(defun handle-human (tree)
  (fresh-line)
  (princ "choose your move:")
  (let ((moves (caddr tree)))
    (labels ((print-moves (moves n)
			  (unless (lazy-null moves)
			    (let* ((move (lazy-car moves))
				   (action (car move)))
			      (fresh-line)
			      (format t "~a. " n)
			      (if action
				(format t "~a -> ~a" (car action) (cadr action))
				(princ "end turn")))
			    (print-moves (lazy-cdr moves) (1+ n)))))
      (print-moves moves 1))
    (fresh-line)
    (cadr (lazy-nth (1- (read)) moves))))

(defun play-vs-human (tree)
  (print-into tree)
  (if (not (lazy-null (caddr tree)))
    (play-vs-human (handle-human tree))
    (announce-winner (cadr tree))))

;(play-vs-human (game-tree (gen-board) 0 0 t))

(defparameter *ai-level* 4)

(defun play-vs-computer (tree)
  (print-into tree)
  (cond ((lazy-null (caddr tree))
	 (announce-winner (cadr tree)))
	((zerop (car tree))
	 (play-vs-computer (handle-human tree)))
	(t (play-vs-computer (handle-computer tree)))))

(defun score-board (board player)
  (loop for hex across board
	for pos from 0
	sum (if (eq (car hex) player)
	      (if (threatened pos board)
		1
		2)
	      -1)))

(defun threatened (pos board)
  (let* ((hex (aref board pos))
	 (player (car hex))
	 (dice (cadr hex)))
    (loop for n in (neighbors pos)
	  do (let* ((nhex (aref board n))
		    (nplayer (car nhex))
		    (ndice (cadr nhex)))
	       (when (and (not (eq player nplayer)) (> ndice dice))
		 (return t))))))

(defun rate-position (tree player)
  (let ((moves (caddr tree)))
    (if (not (lazy-null moves))
      (apply (if (eq (car tree) player)
	       #'max
	       #'min)
	     (get-ratings tree player))
      (score-board (cadr tree) player))))

;(play-vs-computer (game-tree (gen-board) 0 0 t))

(defun ab-get-ratings-max (tree player upper-limit lower-limit)
  (labels ((f (moves lower-limit)
	      (unless (lazy-null moves)
		(let ((x (ab-rate-position (cadr (lazy-car moves))
					  player
					  upper-limit
					  lower-limit)))
		  (if (>= x upper-limit)
		    (list x)
		    (cons x (f (lazy-cdr moves) (max x lower-limit))))))))
    (f (caddr tree) lower-limit)))

(defun ab-get-ratings-min (tree player upper-limit lower-limit)
  (labels ((f (moves upper-limit)
	      (unless (lazy-null moves)
		(let ((x (ab-rate-position (cadr (lazy-car moves))
					   player
					   upper-limit
					   lower-limit)))
		  (if (<= x lower-limit)
		    (list x)
		    (cons x (f (lazy-cdr moves) (min x upper-limit))))))))
    (f (caddr tree) upper-limit)))

(defun ab-rate-position (tree player upper-limit lower-limit)
  (let ((moves (caddr tree)))
    (if (not (lazy-null moves))
      (if (eq (car tree) player)
	(apply #'max (ab-get-ratings-max tree
					 player
					 upper-limit
					 lower-limit))
	(apply #'min (ab-get-ratings-min tree
					 player
					 upper-limit
					 lower-limit)))
      (score-board (cadr tree) player))))

(defparameter *board-size* 5)
(defparameter *board-hexnum* (* *board-size* *board-size*))

;(play-vs-computer (game-tree (gen-board) 0 0 t))

