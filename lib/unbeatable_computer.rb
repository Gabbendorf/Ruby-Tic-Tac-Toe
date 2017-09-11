require_relative 'marks'
require_relative 'score_calculator'

class UnbeatableComputer

  def initialize(ui)
    @ui = ui
  end

  def make_move(player_mark, grid)
    if grid.initial_state?
      random_move_position(grid)
    else
      best_move_position(grid)
    end
  end

  def grid_size
    3
  end

  private

  def random_move_position(grid)
    grid.grid_numbers.sample
  end

  def best_move_position(grid)
    move_position = best_random_grid(grid).different_cell_position(grid.cells)
    grid_position_for(move_position)
  end

  def grid_position_for(cell_position)
    (cell_position + 1).to_s
  end

  def best_random_grid(grid)
    shuffled_moves = Hash[possible_moves_and_scores(grid).to_a.shuffle]
    shuffled_moves.key(max_value(grid))
  end

  def max_value(grid)
    possible_moves_and_scores(grid).values.max
  end

  def possible_moves_and_scores(grid)
    grids_with_moves = grid.create_copies_with_possible_moves(Marks::COMPUTER_MARK)
    moves_and_scores = {}
    grids_with_moves.each do |possible_grid|
      moves_and_scores[possible_grid] = ScoreCalculator.new.score_for(possible_grid, Marks::COMPUTER_MARK)
    end
    moves_and_scores
  end

end
