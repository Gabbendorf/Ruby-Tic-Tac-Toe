require 'spec_helper'
require_relative '../lib/grid_factory'
require_relative '../lib/ui'

RSpec.describe GridFactory do

  let(:input) {StringIO.new("4")}
  let(:ui) {Ui.new(input, StringIO.new)}
  let(:grid_factory) {GridFactory.new}

  it "creates customised grid for human player as opponent" do
    opponent_choice = "h"

    grid = grid_factory.create_grid(ui, opponent_choice)

    expect(grid).to have_attributes(:size => 4)
  end

  it "creates standard grid 3x3 for computer as opponent" do
    opponent_choice = "c"

    grid = grid_factory.create_grid(ui, opponent_choice)

    expect(grid).to have_attributes(:size => 3)
  end

end
