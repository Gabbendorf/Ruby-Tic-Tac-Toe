class TicTacToe

  def initialize(ui, game, user)
    @ui = ui
    @game = game
    @first_player = user
    @intro = welcome_players
    @players = @game.players_and_marks(@first_player, @ui)
    @grid = @game.create_grid(@ui, @players)
    @current_player = @game.starter(@players)
    @game_starter = @current_player
  end

  def run
    print_grid_state
    while !@grid.end_game?
      @game.make_move(@current_player, @players, @grid)
      print_grid_state
      @current_player = @game.switch_player(@current_player, @players)
    end
    report_verdict
    @ui.ask_to_play_again == "y" ? start_new_game : @ui.say_goodbye
  end

  private

  def welcome_players
    @ui.welcome
    @ui.print_logo
  end

  def print_grid_state
    if @grid.initial_state?
      @ui.print_grid(@grid)
    else
      @ui.print_grid(@grid)
      @game.announce_move_made(@ui, @current_player, @players)
    end
  end

  def report_verdict
    @ui.print_grid(@grid)
    if @grid.verdict == :winner
      @ui.declare_winner(@grid.winning_mark)
    else
      @ui.declare_draw
    end
  end

  def start_new_game
    reset_game
    @current_player = @game.switch_player(@game_starter, @players)
    @game_starter = @current_player
    run
  end

  def reset_game
    @players = @game.players_and_marks(@first_player, @ui)
    @grid = @game.create_grid(@ui, @players)
  end

end
