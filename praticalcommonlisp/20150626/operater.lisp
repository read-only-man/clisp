; quote 評価を止め、S式をデータとして扱えるようにする。
; if ほかのすべての条件実行の構文要素の基礎になるブール選択操作
; progn いくつかの式を並べられるようにする
; let let* 変数に対してレキシカルな束縛を提供する
; flet labels ローカル関数を定義する
; macrolet ローカルマクロを定義する

(defun count-versions (dir)
  (let (versions (mapcar #'(lambda (x) (cons x 0) '(2 3 4))))
    (flet ((count-version (file)
			  (incf (cdr (assoc (major-version (read-id3 file)) versions)))))
      (walk-directory dir #'count-version :test #'mp3-p))
    versions))

(defun collect-leaves (tree)
  (let ((leaves ()))
    (labels ((walk (tree)
		   (cond
		     ((null tree))
		     ((atom tree) (push tree leaves))
		     (t (walk (car tree))
			(walk (cdr tree))))))
      (walk tree))
    (nreverse leaves)))

; symbol-macrolet シンボルマクロと呼ばれる特殊なマクロを定義する。

(tagbody
  top
  (print 'hello)
  (when (plusp (random 10)) (go top)))

