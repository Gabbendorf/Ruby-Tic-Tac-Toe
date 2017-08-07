class Grid

attr_reader :size, :cells

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def grid_display
    top_lines = prepare_grid[0..-2].map do |line|
                  line.map {|number| number.center(5)}.join("|")
                end
    last_line = prepare_grid[-1].map {|number| number.center(5)}.join("|")
    top_lines.join(underline) + underline + last_line
  end

  def place_mark(chosen_position, mark)
    @cells[corresponding_cell_for(chosen_position)] = mark
  end

  def empty_position?(grid_position)
    @cells[corresponding_cell_for(grid_position)] == nil
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

  def duplicate_grid
    grid_copy = Grid.new(@size)
    grid_copy.instance_variable_set(:@cells, @cells.dup)
    grid_copy
  end

  def different_cell_position(grid_copy_cells)
    @cells.zip(grid_copy_cells).select.find_index do |grid_cell, copy_cell|
       grid_cell != copy_cell
     end
  end

  def empty_cells_count
    @cells.count {|cell| cell == nil}
  end

  def initial_state?
    empty_cells_count == grid_dimension
  end

  private

  def create_cells
    Array.new(grid_dimension)
  end

  def grid_dimension
    @size * @size
  end

  def prepare_grid
    filled_cells = @cells.map.with_index { |cell, index| cell.nil? ?
                      grid_numbers[index] : cell }
    filled_cells.each_slice(@size).to_a
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

  def corresponding_cell_for(grid_position)
    grid_position.to_i - 1
  end

  def won?
    !winning_row.empty?
  end

  def all_cells_full?
    empty_cells_count == 0
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

  def underline
    if @size == 3
      "\n  _____________\n"
    else
      "\n _____________________\n"
    end
  end

end
