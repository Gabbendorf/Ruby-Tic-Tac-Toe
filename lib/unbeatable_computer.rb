require_relative 'grid'

class UnbeatableComputer

  attr_reader :cells

  def initialize(grid)
    @grid = grid
    @game_states = []
  end

  MARKS = {:computer => "O",
           :opponent => "X"
          }

  def score(game_verdict)
    score = 0
    #if @grid.end_game?
    if game_verdict == :winner
      score += 1
    elsif game_verdict == :lost
      score -= 1
    end
    score
  end

  def grids_with_possible_moves(cells, player_mark)
    index = 0
    @grid.duplicated_grid_state(cells).each do |duplicated_grid|
      while duplicated_grid.cells[index] != nil
        index += 1
      end
      duplicated_grid.cells[index] = player_mark
      index += 1
    end
  end

  private

  def current_player_mark(player_mark)
    if player_mark == MARKS[:computer]
      MARKS[:opponent]
    else
      MARKS[:computer]
    end
  end
  
end
