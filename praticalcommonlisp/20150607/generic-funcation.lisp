(defgeneric draw (shape)
	    (:documentation "�X�N���[����Ɏw�肳�ꂽ�}�`��`��"))

(defmethod draw ((shape circle))
  ())

(defmethod draw ((shape triangle))
  ())

(defgeneric withdraw (account amount)
	    (:documentation "amount �Ŏw�肳�ꂽ�w����������������Ƃ�
			    ���݂̎c����amount��肷���Ȃ�������G���[��ʒm����"))
(defmethod withdraw ((account bank-account) amount)
  (when (< (balance account) amount)
    (error "Account overdrawn."))
  (decf (balance account) amount))

(defmethod withdraw ((account checking-account) amount)
  (let ((overdraft (- amount (balance account))))
    (when (plusp overdraft)
      (withdraw (overdraft-account account) overdraft)
      (incf (balance account) overdraft)))
  (call-next-method))

;call-next-method��ajava��super�ɍ���

(defmethod withdraw ((account (eql *account-of-bank-president*)) amount)
  (let ((overdraft (- amount (balance account))))
    (when (plusp overdraft)
      (incf (balance account) (embezzle *bank* overdraft)))
    (call-next-method)))
