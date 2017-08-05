require_relative 'ui'
require_relative 'grid'

class HumanPlayer

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
  end

  def make_move(player_mark)
    @ui.ask_for_move(@grid, player_mark)
  end

end
