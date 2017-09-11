require_relative 'marks'

class ScoreCalculator

  COMPUTER_MARK = Marks::O
  OPPONENT_MARK = Marks::X

  def score_for(duplicated_grid, player_mark)
    if duplicated_grid.end_game?
      grid_final_state_score(duplicated_grid)
    else
      minimax_score(duplicated_grid, player_mark)
    end
  end

  private

  def grid_final_state_score(duplicated_grid)
    if duplicated_grid.winning_mark == COMPUTER_MARK
      10
    elsif duplicated_grid.winning_mark == OPPONENT_MARK
      -10
    elsif duplicated_grid.draw?
      0
    end
  end

  def minimax_score(duplicated_grid, player_mark)
    player_mark = Marks.switch_mark(player_mark)
    grid_copies = duplicated_grid.create_copies_with_possible_moves(player_mark)
    moves_and_scores = get_moves_with_score(grid_copies, duplicated_grid, player_mark)
    min_or_max_value(player_mark, moves_and_scores)
  end

  def get_moves_with_score(grid_copies, duplicated_grid, player_mark)
    moves_and_scores = {}
    grid_copies.each do |grid_copy|
      moves_and_scores[grid_copy] = score_for(grid_copy, player_mark)
      break if grid_final_state_found?(moves_and_scores, grid_copy, player_mark)
    end
    moves_and_scores
  end

  def min_or_max_value(player_mark, moves_and_scores)
    if player_mark == COMPUTER_MARK
      moves_and_scores.values.max
    else
      moves_and_scores.values.min
    end
  end

  def grid_final_state_found?(moves_and_scores, grid_copy, player_mark)
    best_move_found(moves_and_scores, grid_copy, player_mark) ||
      worst_move_found(moves_and_scores, grid_copy, player_mark)
  end

  def best_move_found(moves_and_scores, grid_copy, player_mark)
    moves_and_scores[grid_copy] == 10 && player_mark == COMPUTER_MARK
  end

  def worst_move_found(moves_and_scores, grid_copy, player_mark)
    moves_and_scores[grid_copy] == -10 && player_mark == OPPONENT_MARK
  end

end
