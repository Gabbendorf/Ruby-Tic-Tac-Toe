require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'

RSpec.describe Game do

  let(:grid) {Grid.new(3)}

  it "uses X as mark for player who moves as first" do
    ui = Ui.new(StringIO.new("h\n1"), StringIO.new)
    human_player = HumanPlayer.new(ui, grid)
    game = Game.new(ui, grid, human_player)

    game.make_move

    grid_cell = grid.cells[0]
    expect(grid_cell).to eq("X")
  end

  it "uses O as mark for player who moves as second" do
    ui = Ui.new(StringIO.new("h\n1\n2"), StringIO.new)
    human_player = HumanPlayer.new(ui, grid)
    game = Game.new(ui, grid, human_player)

    game.make_move
    game.make_move

    grid_cell_for_second_move = grid.cells[1]
    expect(grid_cell_for_second_move).to eq("O")
  end

  it "gets and registers mark corresponding to current player on grid" do
    ui = Ui.new(StringIO.new("h\n2\n7\n3\n4"), StringIO.new)
    human_player = HumanPlayer.new(ui, grid)
    game = Game.new(ui, grid, human_player)

    4.times {game.make_move}

    grid_status = grid.cells
    expect(grid_status).to eq([nil, "X", "X", "O", nil, nil, "O", nil, nil])
  end

end
