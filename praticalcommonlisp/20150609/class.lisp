#|
(defclass bank-account ()
  (customer-name
    balance))

(defparameter *account* (make-instance 'bank-account))
(setf (slot-value *account* 'customer-name) "John Doe")
(setf (slot-value *account* 'balance) 1000)
|#

#|
(defclass bank-account ()
  ((customer-name
     :initarg :customer-name)
   (balance
     :initarg :balance
     :initform 0)))

(defparameter *account* (make-instance 'bank-account :customer-name "John Doe" :balance 1000))
|#

(defvar *account-number* 0)
; :initform��error��ݒ肷�邱�ƂŁA����������customer-name��ݒ肵�Ȃ��ƃG���[�ɂ���
(defclass bank-account ()
  ((customer-name
     :initarg :customer-name
     :initform (error "Must supply a customer-name"))
   (balance
     :initarg :balance
     :initform 0)
   (account-number
     :initform (incf *account-number*))
   account-type))

; intialaize�����I�u�W�F�N�g�̒l�ɂ���ē�������߂�̂́Ainitialize-instance���̃��\�b�h
; standard-object�N���X�ɒ�`����Ă��郁�\�b�h�ŁA�����ς��Ȃ��悤�A:after���\�b�h���`����B
; �����l�̎c���ɉ�����account-type��ݒ肷��B
; �p�����[�^���X�g��&key���܂܂�Ă���̂́A���̃��\�b�h�̃p�����[�^���X�g�����̊֐��̃p�����[�^���X�g�ƓK���ł���悤�ɂ��邽�߁B
#|
(defmethod initialize-instance :after ((account bank-account) &key)
  (let (balance (slot-value account 'balance))
    (setf (slot-value account 'account-type)
	  (cond
	    ((>= balance 100000) :gold)
	    ((>= balance 50000) :silver)
	    (t :blonze)))))
|#

; &key�p�����[�^�Ɏw�肵�����̂́Amake-instance�̈����Ƃ��Ĉ�����
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
				       :balance 102000
				       :opening-bonus-percentage 10))

(defparameter *account2* (make-instance 'bank-account
					:customer-name "Sally Sue"
					:balance 51000))

(print (slot-value *account* 'account-number))
(print (slot-value *account* 'customer-name))
(print (slot-value *account* 'balance))
(print (slot-value *account* 'account-type))

(terpri)


(print (slot-value *account2* 'account-number))
(print (slot-value *account2* 'customer-name))
(print (slot-value *account2* 'balance))
(print (slot-value *account2* 'account-type))
