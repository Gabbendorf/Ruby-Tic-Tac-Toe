require_relative 'tictactoe'
require_relative 'ui'
require_relative 'human_player'
require_relative 'game'

ui = Ui.new($stdin, $stdout)
game = Game.new
user = HumanPlayer.new(ui)
new_game = TicTacToe.new(ui, game, user)

new_game.run
