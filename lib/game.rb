require_relative 'opponent_factory'

class Game

  def initialize(grid)
    @grid = grid
  end

  def players_and_marks(first_player, ui)
    {:first_player => {:player => first_player,
                       :mark => "X"},
    :second_player => {:player => opponent(ui),
                       :mark => "O"}
    }
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

  def make_move(current_player, players)
    mark = mark(current_player, players)
    move = current_player.make_move(mark)
    @grid.place_mark(move, mark)
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
    OpponentFactory.new(ui, @grid).create_opponent(opponent_choice)
  end

  def mark(current_player, players)
    if current_player == first_player(players)
      players[:first_player][:mark]
    else
      players[:second_player][:mark]
    end
  end

end
