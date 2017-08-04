require_relative 'grid'

class UnbeatableComputer

  def initialize(grid)
    @grid = grid
  end

  MARKS = {:computer => "O",
           :opponent => "X"
          }

  def make_move(player_mark)
    best_move_position
  end

  def best_move_position
    max_value = possible_moves_and_scores.values.max
    best_grid = possible_moves_and_scores.key(max_value)
    move_position = best_grid.different_cell_position(@grid.cells)
    grid_position_for(move_position)
  end

  def possible_moves_and_scores
    grids_with_moves = grid_copies_with_possible_moves(@grid, MARKS[:computer])
    @moves_and_scores = {}
    grids_with_moves.each do |grid|
      @moves_and_scores[grid] = score(grid, MARKS[:computer])
    end
    @moves_and_scores
  end

  def score(duplicated_grid, player_mark)
    if duplicated_grid.end_game?
      get_score(duplicated_grid)
    else
      predict_score_with_minimax(duplicated_grid, player_mark)
    end
  end

  def grid_copies_with_possible_moves(grid, player_mark)
    position = 1
    copies_of_grid(grid).each do |duplicated_grid|
      while !duplicated_grid.empty_position?(position)
        position += 1
      end
      duplicated_grid.place_mark(position, player_mark)
      position += 1
    end
  end

  def copies_of_grid(grid)
    grid.empty_cells_count.times.map {grid.duplicate_grid}
  end

  private

  def get_score(duplicated_grid)
    if duplicated_grid.winning_mark == MARKS[:computer]
      10
    elsif duplicated_grid.winning_mark == MARKS[:opponent]
      -10
    elsif duplicated_grid.draw?
      0
    end
  end

  def predict_score_with_minimax(duplicated_grid, player_mark)
    moves_and_scores = {}
    player_mark = switch_mark(player_mark)
    grid_copies = grid_copies_with_possible_moves(duplicated_grid, player_mark)
    grid_copies.each do |grid_copy|
      moves_and_scores[grid_copy] = score(grid_copy, player_mark)
      if moves_and_scores[grid_copy] == 10 && player_mark == MARKS[:computer]
        break
      end
    end
    min_or_max_value(player_mark, moves_and_scores)
  end

  def min_or_max_value(player_mark, moves_and_scores)
    if player_mark == MARKS[:computer]
      moves_and_scores.values.max
    else
      moves_and_scores.values.min
    end
  end

  def switch_mark(player_mark)
    if player_mark == MARKS[:computer]
      MARKS[:opponent]
    else
      MARKS[:computer]
    end
  end

  def grid_position_for(cell_position)
    (cell_position + 1).to_s
  end

end
