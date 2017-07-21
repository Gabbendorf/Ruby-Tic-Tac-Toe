class Ui

  def initialize(stdin, stdout)
    @stdin = stdin
    @stdout = stdout
  end

  def print_grid(grid)
    grid.prepare_grid[0..-2].each do |array|
      @stdout.puts array.join("  |  ") << "\n_____________"
    end
    @stdout.puts grid.prepare_grid.last.join("  |  ")
  end

end
