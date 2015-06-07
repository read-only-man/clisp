(defgeneric draw (shape)
	    (:documentation "スクリーン上に指定された図形を描く"))

(defmethod draw ((shape circle))
  ())

(defmethod draw ((shape triangle))
  ())

(defgeneric withdraw (account amount)
	    (:documentation "amount で指定された学を口座から引き落とす
			    現在の残高がamountよりすくなかったらエラーを通知する"))
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

;call-next-methodはajavaのsuperに酷似

(defmethod withdraw ((account (eql *account-of-bank-president*)) amount)
  (let ((overdraft (- amount (balance account))))
    (when (plusp overdraft)
      (incf (balance account) (embezzle *bank* overdraft)))
    (call-next-method)))

