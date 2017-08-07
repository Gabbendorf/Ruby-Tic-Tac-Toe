# Tic-Tac-Toe

Classic game for two players, X and O, who take turns marking the spaces on a grid, played on the command line.

The user can choose to play:
* against another human player
* against the computer.

When choosing the first option, the user can choose to play on a standard grid (3x3) or on a bigger grid (4x4). Rules for the bigger grid are the same as for the standard grid: the first player who places their mark 4 times in a row wins.

The computer is an unbeatable player: it will never lose, and it will win whenever possible. Unintentionally, I created a "playful" computer: it likes to deceive its opponent not to spot the chance to win, but eventually it will win, if it can...

# Minimax

This was my first attempt to implement the minimax algorithm. In order to do so, I have made a lot of research in the internet and watched videos as first step. I had to understand how the algorithm actually worked, and this was the very first challenge to me. I knew the function that would implement minimax had to be a recursive function, and understanding and breaking down each step of the recursion hasn't been a straightforward process.

## Explaining Minimax

Minimax algorithm sees a few steps ahead and keeps playing until it reaches a terminal state of the grid resulting in a draw, a win, or a loss, each of these corresponding to a score 0, +10 and -10 respectively. To reach the terminal grid state and its score - if not immediately in the next player's move, - the algorithm recursively takes into consideration every possible move for each of the next game states and evaluates them based on the player's turn, *maximizing* player's chances to win when it's its turn, and *minimizing* them when it's opponent's turn. Therefore, it will choose the move with the maximum score when it's computer's turn, and the move with the minimum score when it's opponent's turn. This recursion will return a final score for each of computer's possible moves: the highest score corresponds to the best move the computer can play to avoid losing, and to win when possible.

## Speeding up computer's performance

Minimax is perfect to implement an unbeatable computer, still it's performance can be further improved in terms of speed. I had noticed that the computer took a while to make its first move, especially when it was starting. I have looked for some solutions to fix this and have come across concepts like *Memoization* or *Alpha-Beta Pruning*. Although I have tried to understand and implement one of those, I eventually thought to skip this step for this project. It could be interesting to understand the above concepts further, maybe for my next Tic Tac Toe implementation.

For this project, I have just added a *break* code line in my recursive function that stops the recursion once the best possible move has been found without going through each of the options. Furthermore, the computer picks up a random move when it's the starter, as I have noticed that this would not affect its final purpose. All the above solutions are enough to speed up the computer's performance on a 3x3 grid, but it still would take hours for it to move on a 4x4 grid. This is the reason why the user can only play on a 3x3 grid when playing against the computer.

### How to run the game from the command line

`git clone https://github.com/Gabbendorf/Ruby-Tic-Tac-Toe.git`

`cd Ruby-Tic-Tac-Toe`

`bundle install`

`ruby lib/main.rb`

### How to run the tests from the command line:

From main directory:
* `rspec spec` to run all tests inside `spec` directory
* `rspec spec/<FILE NAME_spec.rb >` to run tests just for that single file

### How to include color when running the tests:

Add `--color` after the instructions above
