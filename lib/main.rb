require_relative 'tictactoe'
require_relative 'ui'
require_relative 'grid'
require_relative 'human_player'
require_relative 'game'

grid = Grid.new(3)
ui = Ui.new($stdin, $stdout)
game = Game.new(grid)
user = HumanPlayer.new(ui, grid)
new_game = TicTacToe.new(ui, grid, game, user)

new_game.run
