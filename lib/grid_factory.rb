require_relative 'grid'

class GridFactory

  def customised_grid(ui)
    grid_size = ui.choose_grid_size
    Grid.new(grid_size)
  end

  def standard_grid
    Grid.new(3)
  end

end
