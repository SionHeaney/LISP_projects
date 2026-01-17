(defun factorial (n)
  "Calculate the factorial of n"
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

;; Test it
(print (factorial 14))
(print (factorial 7))
