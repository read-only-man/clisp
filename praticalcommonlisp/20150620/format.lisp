(loop for cons on '(1 2 3 4 5)
      do (format t "~a" (car cons))
      when (cdr cons) do (format t ", "))

(fresh-line)

(format t "~{~a~^, ~}" '(1 2 3 4 5))

(fresh-line)
#| FORMAT関数の指示子
　すべての指示子はチルダ(~)ではじまり、指示子を表す1つの文字で終わる。
この文字は大文字で書いても小文字で書いてもいい。
指示子によっては前置パラメータをとるものがある。
前置パラメータはチルダのすぐ後に書き、複数ある場合にはコンマで区切る。
浮動小数点を印字するときの小数点以下の桁数の制御なんかに使う。
たとえば小数点数を印字す~$指示しは、デフォルトでは小数点以下2桁を印字する。 |#

; 浮動小数点印字 ~$
(format t "~$~%" pi)
(format t "~5$~%" pi)

; vは前置パラメータの値を指定する。
(format t "~v$~%" 3 pi)

; #はパラメータの数が入る変数
(format t "~#$~%" pi)

; 前置パラメータは（,）で区切る。
; たとえば、~Fは前置パラメタを２つとるので、後方のパラメータ（小数点以下）を指定したい場合
(format t "~,5f~%" pi)

#| 指示子によってはコロンやアットマークのような修飾子を使って振る舞いを変えられるものがある。
コロンやアットマークは、すべての前置パラメータを書いた後、指示子を表す文字の前に置く。
修飾子によって指示子の振る舞いが少しだけ変化する。
例えば~D指示子にコロン修飾子をつけると、3桁ごとにコンマで区切った10進表記の整数を印字する。
またアットマーク修飾子を付けると正の整数に対してプラス記号がつくようになる。 |#
(defvar *num* 1000000)
(format t "~d~%" *num*)
(format t "~:d~%" *num*)
(format t "~@d~%" *num*)
(format t "~@:d~%" *num*)

; ~aは人間が読める文字、~sはREAD文字を出力する
(format t "The value is: ~a~%" 10)
(format t "The value is: ~a~%" "foo")
(format t "The value is: ~a~%" (list 1 2 3))
(format t "The value is: ~s~%" 10)
(format t "The value is: ~s~%" "foo")
(format t "The value is: ~s~%" (list 1 2 3))

; ~%は常に改行、~&は行頭でない場合に改行
(format t "~a" 10)
(format t "~&~&")
(format t "~a" 10)
(format t "~%~%")

; ~cは~aと似ているが、前置パラメータでいろいろできる
; コロン修飾子を付けた場合は、スペース、タブ、改行といった本来は印字されない文字を名前で出力する。
; ※char-code 文字のコード値変換
;  code-char コードを文字に変換
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 32))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 9))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 65))
(format t "Sytanx error. Unexpected character : ~:c~%" (code-char 10))

; アットマーク修飾子はLispも文字リテラルシンタックスで表示する。
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 32))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 9))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 65))
(format t "Sytanx error. Unexpected character : ~@c~%" (code-char 10))

; ~d 10進　~x 16進　~o 8進　~b 2進
; 前置パラメータ　4つ　（: @ 以外で）
; 1つめ、最小出力幅　2つ目パディング文字
(format t "~12d~%" 100000)
(format t "~12,'0d~%" 100000)

; 3つ目と4つ目はコロン修飾子と組み合わせる。
; 3つ目は区切り文字の変更
; 4つ目は何桁ずつグループ化するかを変更
(format t "~:d~%" 10000000000)
(format t "~,,'.,4:d~%" 1000000000)

(format t "1000 is ~~x : ~x~%" 1000)
(format t "1000 is ~~o : ~o~%" 1000)
(format t "1000 is ~~b : ~b~%" 1000)

