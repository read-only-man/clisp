(defparameter *num-players* 2)
(defparameter *max-dice* 3)
(defparameter *board-size* 3)
(defparameter *board-hexnum* (* *board-size* *board-size*))

(defun board-array (lst)
  (make-array *board-hexnum* :initial-contents lst))

(defun gen-board ()
  (board-array (loop for n below *board-hexnum*
		     collect (list (random *num-players*)
				   (1+ (random *max-dice*))))))

(defun player-letter (n)
  (code-char (+ 97 n)))

(defun draw-board (board)
  (loop for y below *board-size*
	do (progn (fresh-line)
		  (loop repeat (- *board-size* y)
			do (princ " "))
		  (loop for x below *board-size*
			for hex = (aref board (+ x (* *board-size* y)))
			do (format t "~a-~a " (player-letter (first hex))
				   (second hex))))))

(defun game-tree (board player spare-dice first-move)
  (list player
	board
	(add-passing-move board
			  player
			  spare-dice
			  first-move
			  (attacking-moves board player spare-dice))))

(defun neighbors (pos)
  (let ((up (- pos *board-size*))
	(down (+ pos *board-size*)))
    (loop for p in (append (list up down)
			   (unless (zerop (mod pos *board-size*))
			     (list (1- up) (1- pos)))
			   (unless (zerop (mod (1+ pos) *board-size*))
			     (list (1+ pos) (1+ down))))
	  when (and (>= p 0) (< p *board-hexnum*))
	  collect p)))

(defun board-attack (board player src dst dice)
  (board-array (loop for pos from 0
		     for hex across board
		     collect (cond ((eq pos src) (list player 1))
				   ((eq pos dst) (list player (1- dice)))
				   (t hex)))))

(defun print-into (tree)
  (fresh-line)
  (format t "current player = ~a" (player-letter (car tree)))
  (draw-board (cadr tree)))

(defun winners (board)
  (let* ((tally (loop for hex across board
		      collect (car hex)))
	 (totals (mapcar (lambda (player)
			   (cons player (count player tally)))
			 (remove-duplicates tally)))
	 (best (apply #'max (mapcar #'cdr totals))))
    (mapcar #'car
	    (remove-if (lambda (x)
			 (not (eq (cdr x) best)))
		       totals))))

(defun announce-winner (board)
  (fresh-line)
  (let ((w (winners board)))
    (if (> (length w) 1)
      (format t "The game is a tie between ~a" (mapcar #'player-letter w))
      (format t "The winner is ~a" (player-letter (car w))))))

(let ((old-game-tree (symbol-function 'game-tree))
      (previous (make-hash-table :test #'equalp)))
  (defun game-tree (&rest rest)
    (or (gethash rest previous)
	(setf (gethash rest previous) (apply old-game-tree rest)))))

(defun add-new-dice (board player spare-dice)
  (labels ((f (lst n acc)
	      (cond ((zerop n) (append (reverse acc) lst))
		    ((null lst) (reverse acc))
		    (t (let ((cur-player (caar lst))
			     (cur-dice (cadar lst)))
			 (if (and (eq cur-player player) (< cur-dice *max-dice*))
			   (f (cdr lst)
			      (1- n)
			      (cons (list cur-player (1+ cur-dice)) acc))
			   (f (cdr lst) n (cons (car lst) acc))))))))
    (board-array (f (coerce board 'list) spare-dice()))))

;(play-vs-computer (game-tree (gen-board) 0 0 t))

