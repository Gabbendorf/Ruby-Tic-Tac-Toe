require_relative 'opponent_factory'
require_relative 'human_player'

class Game

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
  end

  def players_and_marks
    {:first_player => {:type => HumanPlayer.new(@ui, @grid),
                       :mark => "X"},
    :second_player => {:type => opponent,
                       :mark => "O"}
    }
  end

  def starter(players)
    first_player(players)
  end

  def switch_player(current_player, players)
    current_player == first_player(players) ? players[:second_player][:type] : first_player(players)
  end

  def make_move(current_player, players)
    show_grid_state
    move = current_player.make_move
    mark = mark(current_player, players)
    @grid.place_mark(move, mark)
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

  def first_player(players)
    players[:first_player][:type]
  end

  def opponent
    opponent_choice = @ui.choose_opponent
    OpponentFactory.new(@ui, @grid).create_opponent(opponent_choice)
  end

  def mark(current_player, players)
    if current_player == first_player(players)
      players[:first_player][:mark]
    else
      players[:second_player][:mark]
    end
  end

  def show_grid_state
    @ui.print_grid(@grid)
  end

end
