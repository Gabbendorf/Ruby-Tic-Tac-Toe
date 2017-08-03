class Grid

attr_reader :size, :cells

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def place_mark(chosen_position, mark)
    @cells[corresponding_cell_number_for(chosen_position)] = mark
  end
  # find different name for this method
  def grid_display
    filled_cells = @cells.map.with_index { |cell, index| cell.nil? ?
      grid_numbers[index] : cell }
    filled_cells.each_slice(@size).to_a
  end

  def empty_position?(grid_position)
    @cells[corresponding_cell_number_for(grid_position)] == nil
  end

  def grid_numbers
    (1..grid_dimension).map {|number| number.to_s}
  end

  def end_game?
    won? || draw?
  end

  def verdict
    won? ? :winner : :draw
  end

  def draw?
    all_cells_full? && !won?
  end

  def winning_mark
    winning_row.flatten.first
  end

  def reset_cells
    @cells = create_cells
  end
  #Try with not passing cells as argument (see below)
  def duplicated_grid_state(cells)
    empty_cells_number = cells.select {|cell| cell == nil}.size
    duplicated_grids = empty_cells_number.times.map {Grid.new(3)}
    set_cells_state_for(duplicated_grids, cells)
  end

  # def duplicated_grid_state
  #   grid_copy = Grid.new(3)
  #   grid_copy.instance_variable_set(:@cells, @cells.dup)
  # end

  private

  def set_cells_state_for(duplicated_grids, cells)
    duplicated_grids.each do |duplicated_grid|
      duplicated_cells = cells.dup
      duplicated_grid.instance_variable_set(:@cells, duplicated_cells)
    end
  end

  def create_cells
    Array.new(grid_dimension)
  end

  def grid_dimension
    @size * @size
  end

  def all_rows
    [horizontal_rows, vertical_rows, diagonal_rows].flatten(1)
  end

  def horizontal_rows
    @cells.map.each_slice(@size).to_a
  end

  def vertical_rows
    horizontal_rows.transpose
  end

  def diagonal_rows
    [first_diagonal_row, second_diagonal_row]
  end

  def corresponding_cell_number_for(grid_position)
    grid_position.to_i - 1
  end

  def won?
    !winning_row.empty?
  end

  def all_cells_full?
    @cells.all? {|cell| cell != nil}
  end

  def winning_row
    all_rows.select {|row| row.uniq.size == 1 && row.uniq.first != nil}
  end

  def first_diagonal_row
    first_diagonal_row = []
    index = 0
    horizontal_rows.each do |row|
      first_diagonal_row.push(row[index])
      index += 1
    end
    first_diagonal_row
  end

  def second_diagonal_row
    second_diagonal_row = []
    index = @size - 1
    horizontal_rows.each do |row|
      second_diagonal_row.push(row[index])
      index -= 1
    end
    second_diagonal_row
  end
end
