;;;; Color Matching Puzzle
;;;; Randomly applies swap, shuffle, or shift operations to match a target sequence

(defparameter *max-iterations* 1000)

;;; Utility functions

(defun random-element (list)
  "Return a random element from a list"
  (nth (random (length list)) list))

(defun count-matches (list1 list2)
  "Count how many positions match between two lists"
  (loop for item1 in list1
        for item2 in list2
        count (eq item1 item2)))

;;; List manipulation methods

(defun swap-random (lst)
  "Swap two randomly selected positions in the list"
  (let* ((len (length lst))
         (pos1 (random len))
         (pos2 (random len))
         (result (copy-list lst)))
    ;; Ensure we swap different positions
    (when (= pos1 pos2)
      (setf pos2 (mod (1+ pos1) len)))
    ;; Perform the swap
    (rotatef (nth pos1 result) (nth pos2 result))
    result))

(defun shuffle-list (lst)
  "Randomly shuffle the entire list"
  (let ((result (copy-list lst)))
    (loop for i from (1- (length result)) downto 1 do
          (let ((j (random (1+ i))))
            (rotatef (nth i result) (nth j result))))
    result))

(defun shift-left (lst)
  "Shift list left: (c1 c2 c3 c4) -> (c2 c3 c4 c1)"
  (append (rest lst) (list (first lst))))

(defun shift-right (lst)
  "Shift list right: (c1 c2 c3 c4) -> (c4 c1 c2 c3)"
  (append (last lst) (butlast lst)))

(defun apply-shift (lst)
  "Randomly shift left or right"
  (if (zerop (random 2))
      (values (shift-left lst) 'shift-left)
      (values (shift-right lst) 'shift-right)))

;;; Method selection and application

(defun random-method ()
  "Select a random method to apply"
  (random-element '(swap shuffle shift)))

(defun apply-method (method lst)
  "Apply the given method to the list and return the result and actual method used"
  (case method
    (swap (values (swap-random lst) 'swap))
    (shuffle (values (shuffle-list lst) 'shuffle))
    (shift (apply-shift lst))
    (otherwise (values lst method))))

;;; Output formatting

(defun format-color-list (lst)
  "Format a list as colour(c1,c2,c3,c4)"
  (format nil "colour(~{~a~^,~})" lst))

(defun print-header (sequence)
  "Print the fixed sequence"
  (format t "Target sequence: ~a~%~%" (format-color-list sequence))
  (format t "logId, matched, current_colours, method_applied~%")
  (format t "~a~%" (make-string 60 :initial-element #\-)))

(defun print-iteration (log-id matches color-list method)
  "Print one iteration of the puzzle"
  (format t "~a, ~a, ~a, ~a~%"
          log-id
          matches
          (format-color-list color-list)
          method))

;;; Main puzzle solver

(defun solve-puzzle (sequence color-list)
  "Solve the color matching puzzle"
  (print-header sequence)

  (loop with current-colors = color-list
        with actual-method = nil
        for iteration from 1 to *max-iterations*
        for matches = (count-matches current-colors sequence)
        for method = (random-method)
        do
        (print-iteration iteration matches current-colors (or actual-method method))

        ;; Check if solved
        (when (= matches (length sequence))
          (format t "~%Solution found in ~a iterations!~%" iteration)
          (return-from solve-puzzle current-colors))

        ;; Apply the method for next iteration
        (multiple-value-bind (new-colors used-method)
            (apply-method method current-colors)
          (setf current-colors new-colors
                actual-method used-method))

        finally
        (format t "~%Maximum iterations (~a) reached without solution.~%" *max-iterations*)
        (return-from solve-puzzle nil)))

;;; Entry point

(defun run-puzzle ()
  "Run the color matching puzzle with example data"
  (let ((sequence '(green blue yellow red))
        (colors '(red green blue yellow)))
    (solve-puzzle sequence colors)))

;; Run the puzzle
(run-puzzle)