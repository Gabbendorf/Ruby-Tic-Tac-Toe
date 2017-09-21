class GridDisplay

  def display(grid)
    top_lines = prepare(grid)[0..-2].map do |line|
                  line.map {|number| number.center(5)}.join("|")
                end
    last_line = prepare(grid)[-1].map {|number| number.center(5)}.join("|")
    top_lines.join(underline(grid)) + underline(grid) + last_line
  end

  private

  def prepare(grid)
    filled_cells = grid.cells.map.with_index { |cell, index| cell.nil? ?
                      grid.grid_numbers[index] : cell }
    filled_cells.each_slice(grid.size).to_a
  end

  def underline(grid)
    if grid.size == 3
      "\n  _____________\n"
    else
      "\n _____________________\n"
    end
  end


end
