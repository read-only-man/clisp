(defvar *account-number* 0)

(defclass bank-account ()
  ((customer-name
     :initarg :customer-name
     :initform (error "Must supply a customer name.")
     :accessor customer-name
     :documentation "�ڋq��")
   (balance
     :initarg :balance
     :initform 0
     :reader balance
     :documentation "���݂̎c��")
   (account-number
     :initform (incf *account-number*)
     :reader account-number
     :documentation "�����ԍ��i��s���ƂɈ�Ӂj")
   (account-type
     :reader account-type
     :documentation "�������")))

(defmethod initialize-instance :after ((account bank-account) &key opening-bonus-percentage)
  (progn
    (when opening-bonus-percentage
      (incf (slot-value account 'balance)
	    (* (slot-value account 'balance) (/ opening-bonus-percentage 100))))
    (setf (slot-value account 'account-type)
	  (cond
	    ((>= (slot-value account 'balance) 100000) :gold)
	    ((>= (slot-value account 'balance) 50000) :silver)
	    (t :blonze)))))

(defparameter *account* (make-instance 'bank-account
				       :customer-name "John Doe"
				       :balance 10200
				       :opening-bonus-percentage 10))
