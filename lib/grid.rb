class Grid

attr_reader :size, :cells

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def create_cells
    Array.new(grid_dimension)
  end

  def place_mark(grid_position, mark)
    cell_number = grid_position.to_i - 1
    if cell_empty?(cell_number)
      @cells[cell_number] = mark
    else
      :already_occupied
    end
  end

  def grid_display
    grid_numbers = (1..grid_dimension).map {|number| number.to_s}
    @cells.map.with_index { |cell, index| cell.nil? ? grid_numbers[index] : cell }
  end

  private

  def grid_dimension
    @size * @size
  end

  def cell_empty?(cell_number)
    @cells[cell_number] == nil
  end

end
