require_relative 'ui'
require_relative 'grid'

class HumanPlayer

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
  end
# while loop inside ui (fix bug)
  def make_move(player_mark)
    @ui.print_grid(@grid)
    move = @ui.ask_for_move(@grid, player_mark)
    while !@grid.empty_position?(move)
      move = @ui.ask_for_empty_position
    end
    move
  end

end
