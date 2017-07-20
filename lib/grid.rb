class Grid

attr_reader :size, :cells

  def initialize(size)
    @size = size
    @cells = []
  end

  def create_cells
    @cells = (0..grid_dimension-1).map {|cell| cell = nil}
  end

  def place_mark(grid_position, mark)
    cell_number = grid_position.to_i - 1
    if cell_empty?(cell_number)
      @cells[cell_number] = mark
    else
      :already_occupied
    end
  end

  private

  def grid_dimension
    @size * @size
  end

  def cell_empty?(cell_number)
    @cells[cell_number] == nil
  end

end
