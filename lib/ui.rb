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

  def choose_opponent
    @stdout.puts "Choose your opponent: h --> human player, c --> computer"
    opponent_choice = @stdin.gets.chomp.downcase
    while opponent_choice != "h" && opponent_choice != "c"
      opponent_choice = repeat_opponent_choice
    end
    opponent_choice
  end

  def ask_for_move(grid)
    @stdout.puts "Make your move:"
    move = @stdin.gets.chomp
    grid_cell_numbers = grid.prepare_grid.flatten
    while !grid_cell_numbers.include?(move)
      move = repeat_move
    end
    move
  end

  private

  def repeat_opponent_choice
    @stdout.puts "Sorry, I didn't understand: h --> human player, c --> computer"
    @stdin.gets.chomp
  end

  def repeat_move
    @stdout.puts "Move not valid, please repeat your move:"
    @stdin.gets.chomp
  end

end
