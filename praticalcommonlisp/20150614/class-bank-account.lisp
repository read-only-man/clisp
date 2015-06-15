(defvar *account-number* 0)

(defclass bank-account ()
  ((customer-name
     :initarg :customer-name
     :initform (error "Must supply a customer name.")
     :accessor customer-name
     :documentation "顧客名")
   (balance
     :initarg :balance
     :initform 0
     :accessor balance
     :documentation "現在の残高")
   (account-number
     :initform (incf *account-number*)
     :reader account-number
     :documentation "口座番号（銀行ごとに一意）")
   (account-type
     :reader account-type
     :documentation "口座種別")))

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

(defparameter *account1* (make-instance 'bank-account
				       :customer-name "John Doe"
				       :balance 10200
				       :opening-bonus-percentage 10))
(defparameter *account2* (make-instance 'bank-account
				       :customer-name "Hou Doe"
				       :balance 10200
				       :opening-bonus-percentage 10))

(defparameter *minimun-balance* 1000)

(defgeneric assess-low-balance-penalty (account))
#|
(defmethod assess-low-bakance-penalty ((account bank-account))
  (with-slots (balance) account
    (when (< balance *minimum-balance*)
      (decf balance (* balance .01)))))

(defmethod assess-low-bakance-penalty ((account bank-account))
  (with-slots ((bal balance)) account
    (when (< bal *minimum-bal*)
      (decf bal (* bal .01)))))
|#
(defmethod assess-low-balance-penalty ((account bank-account))
  (with-accessors ((balance balance)) account
    (when (< balance *minimum-balance*)
      (decf balance (* balance .01)))))

(defgeneric merge-account (account1 account2))

(defmethod merge-account ((account1 bank-account) (account2 bank-account))
  (with-accessors ((balance1 balance)) account1
    (with-accessors ((balance2 balance)) account2
      (incf balance1 balance2)
      (setf balance2 0))))

(merge-account *account1* *account2*)

(with-accessors ((bal1 balance)) *account1*
  (with-accessors ((bal2 balance)) *account2*
    (format t "account1:~a account2:~a~%" bal1 bal2)))

#|
共有スロット
スロットオプションに、allocationがある。:allocationの値には:instanceか:classが指定でき、
指定されなかったときのデフォルトは:instanceである。
:allocationが:classのとき、そのスロットが持つ値は１つだけになる。その値はクラスに格納され、
すべてのインスタンスで共有される。
　ただし、:classスロットへのアクセスにも、:instanceと同じように、SLOT=VALUEやアクセサ関数を使う。
つまり、実際にはインスタンスに格納されていない値であっても、スロットの値にんはクラスのインスタンスを通じてしか
アクセスふできない。
:initformオプションと:initargオプションは原則として同じ効果になるが、:initformの式はインスタンスが
生成されたときではなく、クラスが定義されたときに1回だけ評価される。
これに対し:initargをMAKE-INSTANCEに渡すと、クラスのすべてのインスタンスが影響を受ける。
　クラスに割り当てられたスロットは、クラスのインスタンスなしでは値を取得できない。
したがって、クラスに割り当てられたスロットは、JavaやC++やPythonにおけるスタティックフィールドや
クラスフィールドと完全に等価なものではない。むしろクラスに割り当てられたスロットの一番の目的は
スペースの節約にある。
クラスのインスタンスを大量に生成する場合、クラスに割り当てられたスロットを作るようにすれば、
すべてのインスタンスが同じ共有リソースのオブジェクトへの参照を持つコストを削減できる。
|#

