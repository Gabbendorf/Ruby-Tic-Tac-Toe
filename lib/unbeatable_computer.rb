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

  def grid_state_duplications
    @duplicated_grids = @grid.empty_cells_number.times.map {Grid.new(3)}
    set_cells_state(@duplicated_grids)
  end

  private

  def set_cells_state(duplicated_grids)
    duplicated_grids.each do |grid|
      duplicated_cells = @grid.cells.dup
      grid.instance_variable_set(:@cells, duplicated_cells)
    end
  end

end
