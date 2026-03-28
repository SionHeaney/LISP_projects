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

Loving the `random()` function SBCL has. Acorn LISP needed one to write Gauss or Poisson distribution from machine time stamp, or some such malarky. Demonstrated the 50/50 initial result with class at University Sussex CCPE. Simultaneous runnin script on dozen or so BBC Micros after resetting BIOS clocks

List has to loop around but, hah, didn't really think about this function's need because it would effectively wipe any previously matched items in the list. Really, the shuffle is almost act of desperation; nothing's matching so why not reroll. However, even that's unnecesary as several swaps would accomplish the same thing.

Sticking with just swaps should do. Then, expand length list and build decision logic to determine which 

**Shuffle**: Randomly shuffles the entire list
Flexible for different lengths of lists
```lisp
(defun shuffle-list (lst)
  (let ((result (copy-list lst)))
    (loop for i from (1- (length result)) downto 1 do
          (let ((j (random (1+ i))))
            (rotatef (nth i result) (nth j result))))
    result))
```

**Shift**: Shifts the list left or right
Shifting list to the left: (c1 c2 c3 c4) -> (c2 c3 c4 c1)
Shift list to right: (c1 c2 c3 c4) -> (c4 c1 c2 c3)"
```lisp
(defun shift-left (lst)
  (append (rest lst) (list (first lst))))

(defun shift-right (lst)
  (append (last lst) (butlast lst)))

(defun apply-shift (lst)
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


