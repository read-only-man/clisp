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

; 浮動小数点の出力　~f ~g ~e ~$
; ~$はパラメータを付けないと、2桁精度　1つ目のパラメータで小数点以下の出力桁数。2つ目のパラメータで整数部の最小桁数
(format t "~$~%" pi)
(format t "~4$~%" pi)
(format t "~5,4$~%" pi)

; ~r 数字を英単語やローマ数字で出力する。
(format t "~r~%" 1234)
(format t "~{~r ~}~%" '(1 2 3 4))

; ~rにコロンを付けると、序数(first secondとか)で表示する。
(format t "~:r~%" 1234)
(format t "~{~:r ~}~%" '(1 2 3 4))

; ~rにアットマークをつけるとローマ数字になる
; コロンとアットマークを両方つけると古いローマ数字になる。
(format t "~@r~%" 1234)
(format t "~{~@r ~}~%" '(1 2 3 4))
(format t "~:@r~%" 1234)
(format t "~{~:@r ~}~%" '(1 2 3 4))

; ~pを付けると、複数形に対応する。これは単純に対応する引数が1でなければsを出力する。
; ~pにコロン修飾子をつけると前のフォーマット引数を再利用する。
(format t "~r file~p~%" 1 1)
(format t "~r file~p~%" 10 10)
(format t "~r file~p~%" 0 0)

(format t "~r file~:p~%" 1)
(format t "~r file~:p~%" 10)
(format t "~r file~:p~%" 0)

; ~pにアットマーク修飾子を使うと、yかiesを出力する。
(format t "~r famil~:@p~%" 1)
(format t "~r famil~:@p~%" 10)
(format t "~r famil~:@p~%" 0)

; 英単語の制御用、~( ~)で囲んだ間は全部小文字になる。
(format t "~(~a~)~%" "FOO")
(format t "~(~r~)~%" 123)

; ~(にアットマークを付けると分の最初の単語の頭文字が大文字になる。
; コロンと付けるとすべての単語の頭文字が大文字になる。
; アットマークとコロン両方を付けるとすべての文字が大文字になる。
(defvar *str* "tHe QuicK bROWN fOx JUMPS oVER the lAzy dOGS")
(format t "~(~a~)~%" *str*)
(format t "~@(~a~)~%" *str*)
(format t "~:(~a~)~%" *str*)
(format t "~:@(~a~)~%" *str*)

; ~[ ~;
; ~[ ~]の間で、~;で区切る。フォーマット引数に対応したものを取り出せる。
(format t "~[cero~;uno~;dos~]~%" 0)
(format t "~[cero~;uno~;dos~]~%" 1)
(format t "~[cero~;uno~;dos~]~%" 2)
(format t "~[cero~;uno~;dos~]~%" 3)

; 最後の節の区切りが~;でなく、~:;だったら、フォーマット引数が範囲外であっても、最後の節をデフォルトで返す。
(format t "~[cero~;uno~:;dos~]~%" 3)
(format t "~[cero~;uno~:;dos~]~%" 100)

; ~{ ~}で要素を繰り返す。
(format t "~{~a, ~}~%" '(1 2 3))

; ~{指示子の本体の中に~^ｂがあると、リストに要素がなくなった時に制御文字の残りを処理せず、すぐに繰り返しを停止する。
(format t "~{~a~^, ~}~%" '(1 2 3))

; ~{にアットマーク修飾子を付けると、残りのフォーマット引数をリストとして処理する。
(format t "~@{~a~^, ~}~%" 1 2 3)

