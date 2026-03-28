# LISP_projects
Rediscovering LISP 

## factorial.lisp
Classic textbook example of recursion

## puzzle_color_matching.lisp 
Initial iteration of this script tries to match a target color sequence 
by randomly applying three types of operations:

**Swap**: Swaps two random positions
from the list select two atoms, check they're not the same; and if so nudge second position, then swep.

_what if second position is at either first or last in list?_ solution: nudge based on first position

```lisp
(defun swap-random (lst)
  (let* ((len (length lst))
         (pos1 (random len))
         (pos2 (random len))
         (result (copy-list lst)))
   
    (when (= pos1 pos2)
      (setf pos2 (mod (1+ pos1) len)))
    
    (rotatef (nth pos1 result) (nth pos2 result))
    result))
```


**Shuffle**: Randomly shuffles the entire list
```lisp
(defun shuffle-list (lst)
  "Randomly shuffle the entire list"
  (let ((result (copy-list lst)))
    (loop for i from (1- (length result)) downto 1 do
          (let ((j (random (1+ i))))
            (rotatef (nth i result) (nth j result))))
    result))
```

**Shift**: Shifts the list left or right
```lisp
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
```


__Key components:__
Target sequence: (green blue yellow red)
Starting colors: (red green blue yellow)
Maximum iterations: 1000
Each iteration outputs number of matching positions between the starting and target sequences
When all positions match, script completes
Each logged iteration shows log ID, number of matches, current color configuration, and which operation was applied.

```
sbcl --script "...\puzzle_color_matching.lisp"
Target sequence: colour(GREEN,BLUE,YELLOW,RED)

logId, matched, current_colours, method_applied
------------------------------------------------------------
1, 0, colour(RED,GREEN,BLUE,YELLOW), SWAP
2, 1, colour(RED,GREEN,YELLOW,BLUE), SWAP
3, 1, colour(BLUE,YELLOW,GREEN,RED), SHUFFLE
4, 2, colour(RED,BLUE,YELLOW,GREEN), SHIFT-RIGHT
5, 4, colour(GREEN,BLUE,YELLOW,RED), SHUFFLE

Solution found in 5 iterations!
PS C:\Users\Sion\Projects\lisp_learning>


