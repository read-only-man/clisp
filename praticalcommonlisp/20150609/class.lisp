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
; :initformにerrorを設定することで、初期化時にcustomer-nameを設定しないとエラーにする
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

; intialaizeされるオブジェクトの値によって動作を決めるのは、initialize-instance総称メソッド
; standard-objectクラスに定義されているメソッドで、動作を変えないよう、:afterメソッドを定義する。
; 初期値の残高に応じてaccount-typeを設定する。
; パラメータリストに&keyが含まれているのは、このメソッドのパラメータリストが総称関数のパラメータリストと適合できるようにするため。
#|
(defmethod initialize-instance :after ((account bank-account) &key)
  (let (balance (slot-value account 'balance))
    (setf (slot-value account 'account-type)
	  (cond
	    ((>= balance 100000) :gold)
	    ((>= balance 50000) :silver)
	    (t :blonze)))))
|#

; &keyパラメータに指定したものは、make-instanceの引数として扱える
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

