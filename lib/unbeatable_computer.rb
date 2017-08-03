require_relative 'grid'

class UnbeatableComputer

  attr_reader :possible_moves_and_scores

  def initialize(grid)
    @grid = grid
    @possible_moves_and_scores = {}
  end

  MARKS = {:computer => "O",
           :opponent => "X"
          }

  def add_possible_moves_and_scores
    possible_moves = grid_copies_with_possible_moves(@grid.cells, MARKS[:computer])
    possible_moves.each do |possible_move|
      @possible_moves_and_scores[possible_move] = score(possible_move, MARKS[:computer])
    end
  end

  def score(duplicated_grid, player_mark)
    if duplicated_grid.end_game?
      get_score(duplicated_grid)
    else
      predict_score_with_minimax(duplicated_grid, player_mark)
    end
  end

  def grid_copies_with_possible_moves(cells, player_mark)
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
    grid_copies = grid_copies_with_possible_moves(duplicated_grid.cells, player_mark)
    grid_copies.each {|grid_copy| moves_and_scores[grid_copy] = score(grid_copy, player_mark)}
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

end
