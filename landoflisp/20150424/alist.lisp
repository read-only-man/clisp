(defparameter *drink-order* '((bill . double-espresso)
			      (lisa . small-drip-coffee)
			      (john . medium-latte)))
(print (assoc 'lisa *drink-order*))
(push '(lisa . large-mocha-with-whipped-cream) *drink-order*)
(print *drink-order*)
(print (assoc 'lisa *drink-order*))

