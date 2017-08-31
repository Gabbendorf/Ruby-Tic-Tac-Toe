require 'spec_helper'
require_relative '../lib/grid_factory'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/human_player'
require_relative '../lib/ui'

RSpec.describe GridFactory do

  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:grid_factory) {GridFactory.new}

  it "creates standard grid size 3x3 if opponent is computer" do
    opponent = UnbeatableComputer.new(ui)
    
    grid = grid_factory.create_grid(opponent)

    expect(grid.size).to eq(3)
  end

  it "creates customised grid size 3x3 if opponent is human and chooses 3 as size" do
    ui = Ui.new(StringIO.new("3"), StringIO.new)
    opponent = HumanPlayer.new(ui)

    grid = grid_factory.create_grid(opponent)

    expect(grid.size).to eq(3)
  end

  it "creates customised grid size 4x4 if opponent is human and chooses 4 as size" do
    ui = Ui.new(StringIO.new("4"), StringIO.new)                         
    opponent = HumanPlayer.new(ui)

    grid = grid_factory.create_grid(opponent)

    expect(grid.size).to eq(4)
  end

end
