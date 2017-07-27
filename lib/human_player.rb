require_relative 'ui'
require_relative 'grid'

class HumanPlayer

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
  end
#could print the grid in first line instead of in game.make_move
  def make_move(player_mark)
    move = @ui.ask_for_move(@grid, player_mark)
    while !@grid.empty_position?(move)
      move = @ui.ask_for_empty_position
    end
    move
  end

end
