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

  it "returns grid cells" do
    grid.place_mark("3", "X")

    grid_cells = computer.cells

    expect(grid_cells).to eq([nil, nil, "X", nil, nil, nil, nil, nil, nil])
  end

  it "duplicates grid state as many times as number of empty cells in actual grid" do
    grid.place_mark("3", "X")

    possible_grids = computer.grid_state_duplications
    duplicated_grid = possible_grids[0]

    expect(possible_grids.size).to eq(8)
    expect(duplicated_grid.cells).to eq(grid.cells)
  end

end
