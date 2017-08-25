require_relative 'opponent_factory'
require_relative 'grid_factory'
require_relative 'marks'

class Game

  def initialize
    @grid_factory = GridFactory.new
  end

  def players_and_marks(first_player, ui)
    {:first_player => {:player => first_player,
                      :mark => Marks::USER},
    :second_player => {:player => opponent(ui),
                      :mark => Marks::OPPONENT}
    }
  end

  def create_grid(ui, players)
    if second_player(players).is_a?(HumanPlayer)
      @grid_factory.customised_grid(ui)
    else
      @grid_factory.standard_grid
    end
  end

  def starter(players)
    first_player(players)
  end

  def switch_player(current_player, players)
    if current_player == first_player(players)
      second_player(players)
    else
      first_player(players)
    end
  end

  def make_move(current_player, players, grid)
    mark = mark(current_player, players)
    @move = current_player.make_move(mark, grid)
    grid.place_mark(@move, mark)
  end

  def announce_move_made(ui, current_player, players)
    ui.confirm_move_position(mark(current_player, players), @move)
  end

  private

  def first_player(players)
    players[:first_player][:player]
  end

  def second_player(players)
    players[:second_player][:player]
  end

  def opponent(ui)
    opponent_choice = ui.choose_opponent
    OpponentFactory.new(ui).create_opponent(opponent_choice)
  end

  def mark(current_player, players)
    if current_player == first_player(players)
      players[:first_player][:mark]
    else
      players[:second_player][:mark]
    end
  end

end
