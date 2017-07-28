require_relative 'human_player'

class TicTacToe

  def initialize(ui, grid, game)
    @ui = ui
    @grid = grid
    @game = game
    @intro = welcome_players
    @first_player = HumanPlayer.new(@ui, @grid)
    @players = @game.players_and_marks(@first_player, @ui)
    @current_player = @game.starter(@players)
    @first_starter = @current_player
  end

  def run
    while !@grid.end_game?
      @game.make_move(@current_player, @players)
      @current_player = @game.switch_player(@current_player, @players)
    end
    report_verdict
    play_again_or_quit
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

  def play_again_or_quit
    if @ui.ask_to_play_again == "y"
      start_new_game
    else
      @ui.say_goodbye
    end
  end
  #TODO: change way to alternate starter maybe?
  def start_new_game
    @grid.reset_cells
    @players = @game.players_and_marks(@first_player, @ui)
    @current_player = @game.switch_player(@first_starter, @players)
    @first_starter = @current_player
    run
  end

end
