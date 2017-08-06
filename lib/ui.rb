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

  def welcome
    @stdout.puts "Welcome to..."
  end

  def print_logo
    @stdout.puts LOGO
  end

  def print_grid(grid_size, grid)
    if grid_size == 3
      @stdout.puts grid.small_grid_display
    else
      @stdout.puts grid.big_grid_display
    end
    @stdout.puts NEW_LINE
  end

  def choose_opponent
    @stdout.puts "Choose your opponent: h --> human player, c --> computer"
    opponent_choice = @stdin.gets.chomp.downcase
    while opponent_choice != "h" && opponent_choice != "c"
      opponent_choice = repeat_opponent_choice
    end
    opponent_choice
  end

  def choose_grid_size
    @stdout.puts "Choose grid size: 3 --> 3x3, 4 --> 4x4"
    size_chosen = @stdin.gets.chomp.to_i
    while size_chosen != 3 && size_chosen != 4
      size_chosen = repeat_grid_size
    end
    size_chosen
  end

  def ask_for_move(grid, player_mark)
    @stdout.puts "Player #{player_mark}, make your move:"
    move = @stdin.gets.chomp
    validated_move(move, grid)
  end

  def announce_computer_moving(player_mark)
    @stdout.puts "Player #{player_mark}'s turn:"
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
      answer = repeat_answer
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
  #TODO: use same method to say "sorry, bla bla bla"
  def repeat_opponent_choice
    @stdout.puts "Sorry, I didn't understand: h --> human player, c --> computer"
    @stdin.gets.chomp.downcase
  end

  def repeat_move
    @stdout.puts "Move not valid, please repeat your move:"
    @stdin.gets.chomp
  end

  def ask_for_empty_position
    @stdout.puts "Position already occupied, please move again:"
    @stdin.gets.chomp
  end

  def repeat_answer
    @stdout.puts "Sorry, I didn't understand: y --> yes, n --> quit"
    @stdin.gets.chomp.downcase
  end

  def repeat_grid_size
    @stdout.puts "Sorry, I didn't understand: 3 --> 3x3, 4 --> 4x4"
    @stdin.gets.chomp.to_i
  end

end
