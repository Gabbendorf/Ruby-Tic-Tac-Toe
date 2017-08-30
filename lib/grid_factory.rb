require_relative 'grid'

class GridFactory

  def create_grid(ui, opponent_choice)
    if opponent_choice == "h"
      grid_size = ui.choose_grid_size
      Grid.new(grid_size)
    else
      Grid.new(3)
    end
  end


end
