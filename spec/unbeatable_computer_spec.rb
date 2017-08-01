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

  it "adds 1 if current game state shows computer winning" do
    grid.place_mark("1", "O")
    grid.place_mark("2", "O")
    grid.place_mark("3", "O")
    initial_score = 1

    updated_score = computer.updated_score(grid, initial_score)

    expect(updated_score).to eq(2)
  end

  it "subtracts 1 if current game state shows computer losing" do
    grid.place_mark("1", "X")
    grid.place_mark("2", "X")
    grid.place_mark("3", "X")
    initial_score = 1

    updated_score = computer.updated_score(grid, initial_score)

    expect(updated_score).to eq(0)
  end

  it "doesn't add point if current game state shows draw state" do
    grid.place_mark("3", "X")
    grid.place_mark("2", "O")
    grid.place_mark("5", "X")
    grid.place_mark("1", "O")
    grid.place_mark("4", "X")
    grid.place_mark("7", "O")
    grid.place_mark("8", "X")
    grid.place_mark("6", "O")
    grid.place_mark("9", "X")
    initial_score = 1

    updated_score = computer.updated_score(grid, initial_score)

    expect(updated_score).to eq(1)
  end

end
