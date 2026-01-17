# LISP_projects
Rediscovering LISP 

## factorial.lisp
Classic textbook example of recursion

## puzzle_color_matching.lisp 
Initial iteration of this script tries to match a target color sequence 
by randomly applying three types of operations:

**Swap**: Swaps two random positions
**Shuffle**: Randomly shuffles the entire list
**Shift**: Shifts the list left or right

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
