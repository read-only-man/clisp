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
     :accessor balance
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
���L�X���b�g
�X���b�g�I�v�V�����ɁAallocation������B:allocation�̒l�ɂ�:instance��:class���w��ł��A
�w�肳��Ȃ������Ƃ��̃f�t�H���g��:instance�ł���B
:allocation��:class�̂Ƃ��A���̃X���b�g�����l�͂P�����ɂȂ�B���̒l�̓N���X�Ɋi�[����A
���ׂẴC���X�^���X�ŋ��L�����B
�@�������A:class�X���b�g�ւ̃A�N�Z�X�ɂ��A:instance�Ɠ����悤�ɁASLOT=VALUE��A�N�Z�T�֐����g���B
�܂�A���ۂɂ̓C���X�^���X�Ɋi�[����Ă��Ȃ��l�ł����Ă��A�X���b�g�̒l�ɂ�̓N���X�̃C���X�^���X��ʂ��Ă���
�A�N�Z�X�ӂł��Ȃ��B
:initform�I�v�V������:initarg�I�v�V�����͌����Ƃ��ē������ʂɂȂ邪�A:initform�̎��̓C���X�^���X��
�������ꂽ�Ƃ��ł͂Ȃ��A�N���X����`���ꂽ�Ƃ���1�񂾂��]�������B
����ɑ΂�:initarg��MAKE-INSTANCE�ɓn���ƁA�N���X�̂��ׂẴC���X�^���X���e�����󂯂�B
�@�N���X�Ɋ��蓖�Ă�ꂽ�X���b�g�́A�N���X�̃C���X�^���X�Ȃ��ł͒l���擾�ł��Ȃ��B
���������āA�N���X�Ɋ��蓖�Ă�ꂽ�X���b�g�́AJava��C++��Python�ɂ�����X�^�e�B�b�N�t�B�[���h��
�N���X�t�B�[���h�Ɗ��S�ɓ����Ȃ��̂ł͂Ȃ��B�ނ���N���X�Ɋ��蓖�Ă�ꂽ�X���b�g�̈�Ԃ̖ړI��
�X�y�[�X�̐ߖ�ɂ���B
�N���X�̃C���X�^���X���ʂɐ�������ꍇ�A�N���X�Ɋ��蓖�Ă�ꂽ�X���b�g�����悤�ɂ���΁A
���ׂẴC���X�^���X���������L���\�[�X�̃I�u�W�F�N�g�ւ̎Q�Ƃ����R�X�g���팸�ł���B
|#
