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

    grids_with_moves = computer.duplicated_grids_with_possible_moves(grid.cells, possible_move)
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([possible_move, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, possible_move])
  end

  it "populates hash with copies of grid state with possible moves and score state" do
    computer.add_possible_moves_and_scores

    first_duplicated_grid = computer.possible_moves_and_scores.keys[0]
    first_score = computer.possible_moves_and_scores[computer.possible_moves_and_scores.keys[0]][:score]
    expect(first_duplicated_grid).to have_attributes(:size => 3)
    expect(first_score).to eq(0)
    expect(computer.possible_moves_and_scores.size).to eq(9)
  end

end
