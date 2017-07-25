class Grid

attr_reader :size, :cells

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def place_mark(chosen_position, mark)
    @cells[corresponding_cell_number_for(chosen_position)] = mark
  end

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

  def winning_mark
    winning_row.flatten.first
  end

  private

  def create_cells
    Array.new(grid_dimension)
  end

  def grid_dimension
    @size * @size
  end

  def all_rows
    [horizontal_rows, vertical_rows, first_diagonal_row, second_diagonal_row]
  end

  def horizontal_rows
    @cells.map.each_slice(@size).to_a
  end

  def vertical_rows
    @cells.map.each_slice(@size).to_a.transpose
  end

  def corresponding_cell_number_for(grid_position)
    grid_position.to_i - 1
  end

  def won?
    !winning_row.empty?
  end

  def draw?
    all_cells_full? && !won?
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
