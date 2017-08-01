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


  def updated_score(duplicated_grid, score)
    if duplicated_grid.winning_mark == MARKS[:computer]
      score += 1
    elsif duplicated_grid.winning_mark == MARKS[:opponent]
      score -= 1
    elsif duplicated_grid.draw?
      score += 0
    end
  end

  def add_possible_moves_and_scores
    number = 1
    grid_copies_with_possible_moves(@grid.cells, MARKS[:computer]).each do |possible_move|
      @possible_moves_and_scores[number] = {:grid => possible_move, :score => 0}
      number += 1
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

  def current_mark(player_mark)
    if player_mark == MARKS[:computer]
      MARKS[:opponent]
    else
      MARKS[:computer]
    end
  end

end
