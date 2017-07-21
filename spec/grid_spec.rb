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

  it "places mark on grid if it's empty" do
    mark = "X"
    grid_position = "3"

    grid.place_mark(grid_position, mark)

    grid_cell = grid.cells[2]
    expect(grid_cell).to eq("X")
  end

  it "places second mark on grid if it's empty" do
    mark = "X"
    grid_position = "3"
    grid.place_mark(grid_position, mark)

    mark2 = "O"
    grid_position = "6"
    grid.place_mark(grid_position, mark2)

    grid_cell = grid.cells[5]
    expect(grid_cell).to eq("O")
  end

  it "returns :already_occupied if cell is already occupied by mark" do
    mark = "X"
    grid_position = "3"
    grid.place_mark(grid_position, mark)

    mark2 = "O"
    grid_position = "3"
    result = grid.place_mark(grid_position, mark2)

    expect(result).to eq(:already_occupied)
  end

  it "prepares array of arrays of numbers for correspondent empty cells" do
    cells_display = grid.prepare_grid

    expect(cells_display).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  end

  it "prepares array of arrays of numbers for correspondent empty cells and of placed marks" do
    mark = "X"
    grid_position = "3"
    grid.place_mark(grid_position, mark)

    cells_display = grid.prepare_grid

    expect(cells_display).to eq([[1, 2, "X"], [4, 5, 6], [7, 8, 9]])
  end

end
