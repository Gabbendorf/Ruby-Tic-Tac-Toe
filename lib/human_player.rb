require_relative 'ui'

class HumanPlayer

  def initialize(ui)
    @ui = ui
  end

  def make_move(player_mark, grid)
    @ui.ask_for_move(grid, player_mark)
  end

  def grid_size
   @ui.choose_grid_size 
  end

end
