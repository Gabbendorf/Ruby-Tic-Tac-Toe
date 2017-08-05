class TicTacToe

  def initialize(ui, grid, game, user)
    @ui = ui
    @grid = grid
    @game = game
    @first_player = user
    @intro = welcome_players
    @players = @game.players_and_marks(@first_player, @ui)
    @current_player = @game.starter(@players)
    @game_starter = @current_player
  end

  def run
    while !@grid.end_game?
      @ui.print_grid(@grid)
      @game.make_move(@current_player, @players)
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

  def report_verdict
    @ui.print_grid(@grid)
    if @grid.verdict == :winner
      @ui.declare_winner(@grid.winning_mark)
    else
      @ui.declare_draw
    end
  end

  #TODO: change way to alternate starter maybe?
  def start_new_game
    @grid.reset_cells
    @players = @game.players_and_marks(@first_player, @ui)
    @current_player = @game.switch_player(@game_starter, @players)
    @game_starter = @current_player
    run
  end

end
