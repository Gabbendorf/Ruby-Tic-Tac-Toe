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

  def prepare_grid
    grid_numbers = (1..grid_dimension).map {|number| number}
    filled_cells = @cells.map.with_index { |cell, index| cell.nil? ? grid_numbers[index] : cell }
    filled_cells.each_slice(@size).to_a
  end

  def end_game?
    won? || draw?
  end

  private

  def rows
    @cells.map.each_slice(@size).to_a
  end

  def grid_dimension
    @size * @size
  end

  def cell_empty?(cell_number)
    @cells[cell_number] == nil
  end

  def first_diagonal_row
    first_diagonal_row = []
    index = 0
    rows.each do |row|
      first_diagonal_row.push(row[index])
      index += 1
    end
    first_diagonal_row
  end

  def second_diagonal_row
    second_diagonal_row = []
    index = @size-1
    rows.each do |row|
      second_diagonal_row.push(row[index])
      index -= 1
    end
    second_diagonal_row
  end

  def won?
    horizontal_winning_row? || vertical_winning_row? || diagonal_winning_row?
  end

  def draw?
    full? && no_winning_rows?
  end

  def full?
    @cells.all? {|cell| cell != nil}
  end

  def no_winning_rows?
    !horizontal_winning_row? || !vertical_winning_row? || !diagonal_winning_row?
  end

  def horizontal_winning_row?
    winning_rows = rows.select {|row| row.uniq.size == 1 &&
      row.uniq.first != nil}
    !winning_rows.empty?
  end

  def vertical_winning_row?
    winning_rows = rows.transpose.select {|row| row.uniq.size == 1 &&
      row.uniq.first != nil}
    !winning_rows.empty?
  end

  def diagonal_winning_row?
    diagonal_rows = [first_diagonal_row, second_diagonal_row]
    winning_rows = diagonal_rows.select {|row| row.uniq.size == 1 &&
      row.uniq.first != nil}
    !winning_rows.empty?
  end
end
