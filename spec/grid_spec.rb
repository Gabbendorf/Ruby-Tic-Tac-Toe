require 'spec_helper'
require_relative '../lib/grid'

RSpec.describe Grid do

  let(:grid) {Grid.new(3)}

  it "is initialized with a size" do
    size = grid.size

    expect(size).to eq(3)
  end

  it "creates array of 9 cells for grid of size 3 initially set as nil" do
    grid_cells = grid.create_cells

    expect(grid_cells).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

end
