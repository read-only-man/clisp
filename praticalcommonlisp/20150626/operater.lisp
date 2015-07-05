; quote �]�����~�߁AS�����f�[�^�Ƃ��Ĉ�����悤�ɂ���B
; if �ق��̂��ׂĂ̏������s�̍\���v�f�̊�b�ɂȂ�u�[���I�𑀍�
; progn �������̎�����ׂ���悤�ɂ���
; let let* �ϐ��ɑ΂��ă��L�V�J���ȑ�����񋟂���
; flet labels ���[�J���֐����`����
; macrolet ���[�J���}�N�����`����

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

; symbol-macrolet �V���{���}�N���ƌĂ΂�����ȃ}�N�����`����B

(tagbody
  top
  (print 'hello)
  (when (plusp (random 10)) (go top)))
