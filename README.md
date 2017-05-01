## Tic Tac Toe
Attempt to build tic tac toe game and understand how to implement minimax algorithm to determine computer's move.

Example:   
Assuming users play first with 'O'.   
What is the next move of computer in this case?
```
x o -
- - o
- - -
```
If the 3x3 board's positions can be represented as an array [0,1,2,3,4,5,6,7,8,9], the possible moves that "x" can make are [2,3,4,6,7,8].

For each possible move, it is tried recursively until a base case where either a win, loss or draw is reached and points are assigned for each state.

In the above example, going in order, positions 2,3,4 results in either a loss or draw. Next position, 6 is possible to win:
```
x o -
- - o
x - -
```
"o" has to pick position 3 to prevent loss. When its "x"'s turn, remaining positions are 2,4,7,8.

Going down the decision tree, position 4 would have higher score and be chosen. After that, "x" wins in one move.

```
x o -
o x o
x - -
```

Credits:   
[ttt-ruby-tdd](https://github.com/chongkim/ttt-ruby-tdd)
