class UnbeatableComputer

  def initialize(ui)
    @ui = ui
  end

  MARKS = {:computer => "O",
           :opponent => "X"
          }

  def make_move(player_mark, grid)
    @ui.announce_computer_moving(player_mark)
    if starting_move?(grid)
      random_move_position(grid)
    else
      best_move_position(grid)
    end
  end

  def best_move_position(grid)
    max_value = possible_moves_and_scores(grid).values.max
    best_grid = possible_moves_and_scores(grid).key(max_value)
    move_position = best_grid.different_cell_position(grid.cells)
    grid_position_for(move_position)
  end

  def possible_moves_and_scores(grid)
    grids_with_moves = grid_copies_with_possible_moves(grid, MARKS[:computer])
    moves_and_scores = {}
    grids_with_moves.each do |possible_grid|
      moves_and_scores[possible_grid] = score(possible_grid, MARKS[:computer])
    end
    moves_and_scores
  end

  def score(duplicated_grid, player_mark)
    if duplicated_grid.end_game?
      grid_final_state_score(duplicated_grid)
    else
      calculate_score_with_minimax(duplicated_grid, player_mark)
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

  def grid_final_state_score(duplicated_grid)
    if duplicated_grid.winning_mark == MARKS[:computer]
      10
    elsif duplicated_grid.winning_mark == MARKS[:opponent]
      -10
    elsif duplicated_grid.draw?
      0
    end
  end

  def calculate_score_with_minimax(duplicated_grid, player_mark)
    player_mark = switch_mark(player_mark)
    grid_copies = grid_copies_with_possible_moves(duplicated_grid, player_mark)
    moves_and_scores = get_score_for_moves(grid_copies, duplicated_grid, player_mark)
    min_or_max_value(player_mark, moves_and_scores)
  end

  def min_or_max_value(player_mark, moves_and_scores)
    if player_mark == MARKS[:computer]
      moves_and_scores.values.max
    else
      moves_and_scores.values.min
    end
  end
  #TODO: grids should be shuffled to avoid making always same moves
  def get_score_for_moves(grid_copies, duplicated_grid, player_mark)
    moves_and_scores = {}
    grid_copies.each do |grid_copy|
      moves_and_scores[grid_copy] = score(grid_copy, player_mark)
      break if grid_final_state_found?(moves_and_scores, grid_copy, player_mark)
    end
    moves_and_scores
  end

  def grid_final_state_found?(moves_and_scores, grid_copy, player_mark)
    best_move_found(moves_and_scores, grid_copy, player_mark) ||
    worst_move_found(moves_and_scores, grid_copy, player_mark)
  end

  def best_move_found(moves_and_scores, grid_copy, player_mark)
    moves_and_scores[grid_copy] == 10 && player_mark == MARKS[:computer]
  end

  def worst_move_found(moves_and_scores, grid_copy, player_mark)
    moves_and_scores[grid_copy] == -10 && player_mark == MARKS[:opponent]
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

  def starting_move?(grid)
    grid.empty_cells_count == 9
  end

  def random_move_position(grid)
    random_move_position = grid.grid_numbers.sample
    while !grid.empty_position?(random_move_position)
      random_move_position = grid.grid_numbers.sample
    end
    random_move_position
  end

end
