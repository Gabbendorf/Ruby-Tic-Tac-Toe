class Ui

  def initialize(stdin, stdout)
    @stdin = stdin
    @stdout = stdout
  end

  LOGO = %q!
  __  __  _____ ___ ___   _____ _   ___   _____ ___  ___     ___
  \ \/ / |_   _|_ _/ __| |_   _/_\ / __| |_   _/ _ \| __|   / _ \
   >  <    | |  | | (__    | |/ _ \ (__    | || (_) | _|   | (_) |
  /_/\_\   |_| |___\___|   |_/_/ \_\___|   |_| \___/|___|   \___/
  !

  NEW_LINE = "\n"
  CLEAR_SCREEN = "\e[H\e[2J"

  def welcome
    @stdout.puts CLEAR_SCREEN + "Welcome to..."
  end

  def print_logo
    @stdout.puts LOGO
  end

  def print_grid(grid)
    # if grid_size == 3
      @stdout.puts CLEAR_SCREEN + grid.grid_display
    # else
      # @stdout.puts CLEAR_SCREEN + grid.big_grid_display
    # end
    @stdout.puts NEW_LINE
  end

  def choose_opponent
    @stdout.puts "Choose your opponent: h --> human player, c --> computer"
    opponent_choice = @stdin.gets.chomp.downcase
    while opponent_choice != "h" && opponent_choice != "c"
      apologize
      opponent_choice = choose_opponent
    end
    opponent_choice
  end

  def choose_grid_size
    @stdout.puts "Choose grid size: 3 --> 3x3, 4 --> 4x4"
    size_chosen = @stdin.gets.chomp.to_i
    while size_chosen != 3 && size_chosen != 4
      apologize
      size_chosen = choose_grid_size
    end
    size_chosen
  end

  def ask_for_move(grid, player_mark)
    @stdout.puts "Player #{player_mark}, make your move:"
    move = @stdin.gets.chomp
    validated_move(move, grid)
  end

  def confirm_move_position(player_mark, grid_position)
    @stdout.puts "Player #{player_mark} moved at #{grid_position}."
    @stdout.puts NEW_LINE
  end

  def declare_winner(player_mark)
    @stdout.puts "Player #{player_mark} wins!\n"
    @stdout.puts NEW_LINE
  end

  def declare_draw
    @stdout.puts "It's a draw: nobody wins!"
    @stdout.puts NEW_LINE
  end

  def ask_to_play_again
    @stdout.puts "Do you want to play again? y --> yes, n --> quit"
    answer = @stdin.gets.chomp.downcase
    while answer != "y" && answer != "n"
      apologize
      answer = ask_to_play_again
    end
    answer
  end

  def say_goodbye
    @stdout.puts "See you soon!"
  end

  private

  def validated_move(move, grid)
    if !grid.grid_numbers.include?(move)
      move = repeat_move
      validated_move(move, grid)
    elsif !grid.empty_position?(move)
      move = ask_for_empty_position
      validated_move(move, grid)
    else
      move
    end
  end

  def apologize
    @stdout.puts "Sorry, I didn't understand!"
  end

  def repeat_move
    @stdout.puts "Move not valid, please repeat your move:"
    @stdin.gets.chomp
  end

  def ask_for_empty_position
    @stdout.puts "Position already occupied, please move again:"
    @stdin.gets.chomp
  end

end
