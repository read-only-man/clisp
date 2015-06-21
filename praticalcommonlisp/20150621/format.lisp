(loop for cons on '(1 2 3 4 5)
      do (format t "~a" (car cons))
      when (cdr cons) do (format t ", "))

(fresh-line)

(format t "~{~a~^, ~}" '(1 2 3 4 5))

(fresh-line)
#| FORMAT�֐��̎w���q
�@���ׂĂ̎w���q�̓`���_(~)�ł͂��܂�A�w���q��\��1�̕����ŏI���B
���̕����͑啶���ŏ����Ă��������ŏ����Ă������B
�w���q�ɂ���Ă͑O�u�p�����[�^���Ƃ���̂�����B
�O�u�p�����[�^�̓`���_�̂�����ɏ����A��������ꍇ�ɂ̓R���}�ŋ�؂�B
���������_���󎚂���Ƃ��̏����_�ȉ��̌����̐���Ȃ񂩂Ɏg���B
���Ƃ��Ώ����_�����󎚂�~$�w�����́A�f�t�H���g�ł͏����_�ȉ�2�����󎚂���B |#

; ���������_�� ~$
(format t "~$~%" pi)
(format t "~5$~%" pi)

; v�͑O�u�p�����[�^�̒l���w�肷��B
(format t "~v$~%" 3 pi)

; #�̓p�����[�^�̐�������ϐ�
(format t "~#$~%" pi)

; �O�u�p�����[�^�́i,�j�ŋ�؂�B
; ���Ƃ��΁A~F�͑O�u�p�����^���Q�Ƃ�̂ŁA����̃p�����[�^�i�����_�ȉ��j���w�肵�����ꍇ
(format t "~,5f~%" pi)

#| �w���q�ɂ���Ă̓R������A�b�g�}�[�N�̂悤�ȏC���q���g���ĐU�镑����ς�������̂�����B
�R������A�b�g�}�[�N�́A���ׂĂ̑O�u�p�����[�^����������A�w���q��\�������̑O�ɒu���B
�C���q�ɂ���Ďw���q�̐U�镑�������������ω�����B
�Ⴆ��~D�w���q�ɃR�����C���q������ƁA3�����ƂɃR���}�ŋ�؂���10�i�\�L�̐������󎚂���B
�܂��A�b�g�}�[�N�C���q��t����Ɛ��̐����ɑ΂��ăv���X�L�������悤�ɂȂ�B |#
(defvar *num* 1000000)
(format t "~d~%" *num*)
(format t "~:d~%" *num*)
(format t "~@d~%" *num*)
(format t "~@:d~%" *num*)

; ~a�͐l�Ԃ��ǂ߂镶���A~s��READ�������o�͂���
(format t "The value is: ~a~%" 10)
(format t "The value is: ~a~%" "foo")
(format t "The value is: ~a~%" (list 1 2 3))
(format t "The value is: ~s~%" 10)
(format t "The value is: ~s~%" "foo")
(format t "The value is: ~s~%" (list 1 2 3))

; ~%�͏�ɉ��s�A~&�͍s���łȂ��ꍇ�ɉ��s
(format t "~a" 10)
(format t "~&~&")
(format t "~a" 10)
(format t "~%~%")

; ~c��~a�Ǝ��Ă��邪�A�O�u�p�����[�^�ł��낢��ł���
; �R�����C���q��t�����ꍇ�́A�X�y�[�X�A�^�u�A���s�Ƃ������{���͈󎚂���Ȃ������𖼑O�ŏo�͂���B
; ��char-code �����̃R�[�h�l�ϊ�
;  code-char �R�[�h�𕶎��ɕϊ�
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 32))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 9))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 65))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 10))

; �A�b�g�}�[�N�C���q��Lisp���������e�����V���^�b�N�X�ŕ\������B
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 32))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 9))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 65))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 10))

; ~d 10�i�@~x 16�i�@~o 8�i�@~b 2�i
; �O�u�p�����[�^�@4�@�i: @ �ȊO�Łj
; 1�߁A�ŏ��o�͕��@2�ڃp�f�B���O����
(format t "~12d~%" 100000)
(format t "~12,'0d~%" 100000)

; 3�ڂ�4�ڂ̓R�����C���q�Ƒg�ݍ��킹��B
; 3�ڂ͋�؂蕶���̕ύX
; 4�ڂ͉������O���[�v�����邩��ύX
(format t "~:d~%" 10000000000)
(format t "~,,'.,4:d~%" 1000000000)

(format t "1000 is ~~x : ~x~%" 1000)
(format t "1000 is ~~o : ~o~%" 1000)
(format t "1000 is ~~b : ~b~%" 1000)

; ���������_�̏o�́@~f ~g ~e ~$
; ~$�̓p�����[�^��t���Ȃ��ƁA2�����x�@1�ڂ̃p�����[�^�ŏ����_�ȉ��̏o�͌����B2�ڂ̃p�����[�^�Ő������̍ŏ�����
(format t "~$~%" pi)
(format t "~4$~%" pi)
(format t "~5,4$~%" pi)

; ~r �������p�P��⃍�[�}�����ŏo�͂���B
(format t "~r~%" 1234)
(format t "~{~r ~}~%" '(1 2 3 4))

; ~r�ɃR������t����ƁA����(first second�Ƃ�)�ŕ\������B
(format t "~:r~%" 1234)
(format t "~{~:r ~}~%" '(1 2 3 4))

; ~r�ɃA�b�g�}�[�N������ƃ��[�}�����ɂȂ�
; �R�����ƃA�b�g�}�[�N�𗼕�����ƌÂ����[�}�����ɂȂ�B
(format t "~@r~%" 1234)
(format t "~{~@r ~}~%" '(1 2 3 4))
(format t "~:@r~%" 1234)
(format t "~{~:@r ~}~%" '(1 2 3 4))

; ~p��t����ƁA�����`�ɑΉ�����B����͒P���ɑΉ����������1�łȂ����s���o�͂���B
; ~p�ɃR�����C���q������ƑO�̃t�H�[�}�b�g�������ė��p����B
(format t "~r file~p~%" 1 1)
(format t "~r file~p~%" 10 10)
(format t "~r file~p~%" 0 0)

(format t "~r file~:p~%" 1)
(format t "~r file~:p~%" 10)
(format t "~r file~:p~%" 0)

; ~p�ɃA�b�g�}�[�N�C���q���g���ƁAy��ies���o�͂���B
(format t "~r famil~:@p~%" 1)
(format t "~r famil~:@p~%" 10)
(format t "~r famil~:@p~%" 0)

; �p�P��̐���p�A~( ~)�ň͂񂾊Ԃ͑S���������ɂȂ�B
(format t "~(~a~)~%" "FOO")
(format t "~(~r~)~%" 123)

; ~(�ɃA�b�g�}�[�N��t����ƕ��̍ŏ��̒P��̓��������啶���ɂȂ�B
; �R�����ƕt����Ƃ��ׂĂ̒P��̓��������啶���ɂȂ�B
; �A�b�g�}�[�N�ƃR����������t����Ƃ��ׂĂ̕������啶���ɂȂ�B
(defvar *str* "tHe QuicK bROWN fOx JUMPS oVER the lAzy dOGS")
(format t "~(~a~)~%" *str*)
(format t "~@(~a~)~%" *str*)
(format t "~:(~a~)~%" *str*)
(format t "~:@(~a~)~%" *str*)

; ~[ ~;
; ~[ ~]�̊ԂŁA~;�ŋ�؂�B�t�H�[�}�b�g�����ɑΉ��������̂����o����B
(format t "~[cero~;uno~;dos~]~%" 0)
(format t "~[cero~;uno~;dos~]~%" 1)
(format t "~[cero~;uno~;dos~]~%" 2)
(format t "~[cero~;uno~;dos~]~%" 3)

; �Ō�̐߂̋�؂肪~;�łȂ��A~:;��������A�t�H�[�}�b�g�������͈͊O�ł����Ă��A�Ō�̐߂��f�t�H���g�ŕԂ��B
(format t "~[cero~;uno~:;dos~]~%" 3)
(format t "~[cero~;uno~:;dos~]~%" 100)

; ~{ ~}�ŗv�f���J��Ԃ��B
(format t "~{~a, ~}~%" '(1 2 3))

; ~{�w���q�̖{�̂̒���~^��������ƁA���X�g�ɗv�f���Ȃ��Ȃ������ɐ��䕶���̎c������������A�����ɌJ��Ԃ����~����B
(format t "~{~a~^, ~}~%" '(1 2 3))

; ~{�ɃA�b�g�}�[�N�C���q��t����ƁA�c��̃t�H�[�}�b�g���������X�g�Ƃ��ď�������B
(format t "~@{~a~^, ~}~%" 1 2 3)
