require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:computer) {UnbeatableComputer.new(grid)}

  it "adds 1 if game is over and it wins game" do
    game_verdict = :winner

    score = computer.score(game_verdict)

    expect(score).to eq(1)
  end

  it "subtracts 1 if game is over and it loses game" do
    game_verdict = :lost

    score = computer.score(game_verdict)

    expect(score).to eq(-1)
  end

  it "doesn't update score if game is over and is draw" do
    game_verdict = :draws

    score = computer.score(game_verdict)

    expect(score).to eq(0)
  end

  it "returns duplicated grids each with current player mark placed in different empty cell" do
    grid.place_mark("3", "X")
    grid.place_mark("5", "O")
    grid.place_mark("6", "X")
    possible_move = "X"

    grids_with_moves = computer.grids_with_possible_moves(grid.cells, possible_move)
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([possible_move, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, possible_move])
  end

end
