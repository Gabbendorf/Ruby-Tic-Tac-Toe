class TicTacToe

  def initialize(grid, game)
    @grid = grid
    @game = game
    @players = @game.players_and_marks
    @current_player = @game.starter(@players)
  end

  def run
    while !@grid.end_game?
      @game.make_move(@current_player, @players)
      @current_player = @game.switch_player(@current_player, @players)
    end
    @game.report_verdict
  end

end
