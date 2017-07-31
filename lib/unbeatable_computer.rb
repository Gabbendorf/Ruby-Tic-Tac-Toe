require_relative 'grid'

class UnbeatableComputer

  attr_reader :cells

  def initialize(grid)
    @grid = grid
    @game_states = []
    @cells = @grid.cells
  end

  MARKS = {:computer => :X,
           :opponent => :O
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

end
