require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'

RSpec.describe Game do

  let(:ui) {Ui.new(StringIO.new("h\n2\n7\n3\n4"), StringIO.new)}
  let(:grid) {Grid.new(3)}
  let(:human_player) {HumanPlayer.new(ui, grid)}
  let(:game) {Game.new(ui, grid, human_player)}

  it "gets and registers mark corresponding to current player on grid" do
    4.times {game.make_move}

    grid_status = grid.cells
    expect(grid_status).to eq([nil, "X", "X", "O", nil, nil, "O", nil, nil])
  end

end
