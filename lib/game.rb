require_relative 'opponent_factory'

class Game

  def initialize(ui, grid, human_player)
    @ui = ui
    @grid = grid
    @players = [human_player, opponent]
    @marks = {@players.first => "X",
              @players.last => "O"
              }
  end

  def make_move
    move = current_player.make_move
    mark = @marks[current_player]
    @grid.place_mark(move, mark)
    switch_players
  end

  def report_verdict
    if @grid.verdict == :winner
      mark = @grid.winning_mark
      @ui.declare_winner(mark)
    else
      @ui.declare_draw
    end
  end

  private

  def opponent
    opponent_choice = @ui.choose_opponent
    OpponentFactory.new(@ui, @grid).create_opponent(opponent_choice)
  end

  def switch_players
    @players[0], @players[1] = @players[1], @players[0]
  end

  def current_player
    @players.first
  end

end
