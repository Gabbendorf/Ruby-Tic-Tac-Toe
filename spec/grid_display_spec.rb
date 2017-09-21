require 'spec_helper'
require_relative '../lib/grid_display'
require_relative '../lib/grid'

RSpec.describe GridDisplay do

  let(:grid_display) {GridDisplay.new}

  it "prepares display of grid size 3x3" do
    grid = Grid.new(3)

    grid_displayed = grid_display.display(grid)

    expect(grid_displayed).to eq("  1  |  2  |  3  \n  _____________\n  4  |  5  |  6  \n  _____________\n  7  |  8  |  9  ")
  end

  it "prepares display of grid size 4x4" do
    grid = Grid.new(4)

    grid_displayed = grid_display.display(grid)

    expect(grid_displayed).to eq("  1  |  2  |  3  |  4  \n _____________________\n  5  |  6  |  7  |  8  \n _____________________\n  9  | 10  | 11  | 12  \n _____________________\n 13  | 14  | 15  | 16  ")
  end


end
