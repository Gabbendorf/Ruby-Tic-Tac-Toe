require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'

RSpec.describe Game do

  let(:grid) {Grid.new(3)}
  let(:output) {StringIO.new}

  def set_up_game(grid, input, output)
    ui = Ui.new(input, output)
    human_player = HumanPlayer.new(ui, grid)
    Game.new(ui, grid, human_player)
  end

  it "uses X as mark for player who moves as first" do
    game = set_up_game(grid, StringIO.new("h\n1"), output)

    game.make_move

    grid_cell = grid.cells[0]
    expect(grid_cell).to eq("X")
  end

  it "uses O as mark for player who moves as second" do
    game = set_up_game(grid, StringIO.new("h\n1\n2"), output)

    2.times {game.make_move}

    grid_cell_for_second_move = grid.cells[1]
    expect(grid_cell_for_second_move).to eq("O")
  end

  it "gets and registers mark corresponding to current player on grid" do
    game = set_up_game(grid, StringIO.new("h\n2\n7\n3\n4"), output)

    4.times {game.make_move}

    grid_status = grid.cells
    expect(grid_status).to eq([nil, "X", "X", "O", nil, nil, "O", nil, nil])
  end

  it "declares winner" do
    grid = double("grid")
    game = set_up_game(grid, StringIO.new("h\n1"), output)

    expect(grid).to receive(:verdict) {:winner}
    expect(grid).to receive(:winning_mark) {"X"}

    game.report_verdict
    expect(output.string).to include("Player X wins!")
  end

  it "declares it's draw" do
    grid = double("grid")
    game = set_up_game(grid, StringIO.new("h\n1"), output)

    expect(grid).to receive(:verdict) {:draw}

    game.report_verdict
    expect(output.string).to include("It's a draw: nobody wins!")
  end

end
