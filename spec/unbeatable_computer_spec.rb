require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:computer) {UnbeatableComputer.new(grid)}

  it "returns duplicated grids each with current player mark placed in different empty cell" do
    grid.place_mark("3", "X")
    grid.place_mark("5", "O")
    grid.place_mark("6", "X")
    possible_move = "X"

    grids_with_moves = computer.grid_copies_with_possible_moves(grid.cells, possible_move)
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([possible_move, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, possible_move])
  end

  it "populates hash with ordered list of copies of grid with possible move and score" do
    computer.add_possible_moves_and_scores

    first_duplicated_grid = computer.possible_moves_and_scores.values[0][:grid]
    first_score = computer.possible_moves_and_scores.values[0][:score]

    expect(first_duplicated_grid).to be_kind_of(Grid)
    expect(first_score).to eq(0)
    expect(computer.possible_moves_and_scores.size).to eq(9)
  end

  describe "applies minimax algorithm to grid copy and updates score for each possible move according to result" do
    it "adds 1 to score if hypotethical game ends and computer wins" do
      computer_mark = "O"
      grid.place_mark("1", computer_mark)
      grid.place_mark("2", computer_mark)
      computer.add_possible_moves_and_scores
      ending_grid_state = computer.possible_moves_and_scores[1][:grid]
      list_number = computer.possible_moves_and_scores.keys[0]

      computer.minimax(ending_grid_state, list_number, computer_mark)

      score = computer.possible_moves_and_scores[1][:score]
      expect(score).to eq(1)
    end

    it "subtracts 1 to score if hypotethical game ends and opponent wins" do
      opponent_mark = "X"
      grid.place_mark("1", opponent_mark)
      grid.place_mark("2", opponent_mark)
      grid.place_mark("4", opponent_mark)
      grid.place_mark("5", opponent_mark)
      grid.place_mark("9", opponent_mark)
      computer.add_possible_moves_and_scores
      ending_game_grid_state = computer.possible_moves_and_scores[1][:grid]
      list_number = computer.possible_moves_and_scores.keys[0]

      computer.minimax(ending_game_grid_state, list_number, opponent_mark)

      score = computer.possible_moves_and_scores[1][:score]
      expect(score).to eq(-1)
    end

    it "doesn't change score if hypotethical game ends as draw" do
      grid.place_mark("3", "X")
      grid.place_mark("2", "O")
      grid.place_mark("5", "X")
      grid.place_mark("1", "O")
      grid.place_mark("4", "X")
      grid.place_mark("7", "O")
      grid.place_mark("8", "X")
      grid.place_mark("6", "O")

      computer.add_possible_moves_and_scores
      ending_game_grid_state = computer.possible_moves_and_scores[1][:grid]
      list_number = computer.possible_moves_and_scores.keys[0]

      computer.minimax(ending_game_grid_state, list_number, "X")

      score = computer.possible_moves_and_scores[1][:score]
      expect(score).to eq(0)
    end
  end

end
