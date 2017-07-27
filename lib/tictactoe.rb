class TicTacToe

  def initialize(grid, game)
    @grid = grid
    @game = game
    @players = @game.players_and_marks
    @current_player = @game.starter(@players)
    @first_starter_player = @current_player
  end

  def run
    while !@grid.end_game?
      @game.make_move(@current_player, @players)
      @current_player = @game.switch_player(@current_player, @players)
    end
    verdict_and_next_actions
  end

  private

  def verdict_and_next_actions
    answer_for_new_game = @game.end_of_game_actions
    if answer_for_new_game == "y"
      start_new_game
    else
      @game.exit_game
    end
  end

  def start_new_game
    @grid.reset_cells
    @players = @game.players_and_marks
    @current_player = @game.change_starter_for_next_game(@first_starter_player, @players)
    @starter_player = @current_player
    run
  end

end
