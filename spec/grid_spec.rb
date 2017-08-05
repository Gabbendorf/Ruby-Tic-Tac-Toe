require 'spec_helper'
require_relative '../lib/grid'

RSpec.describe Grid do

  let(:grid) {Grid.new(3)}

  def draw_game
    grid.place_mark("3", "X")
    grid.place_mark("2", "O")
    grid.place_mark("5", "X")
    grid.place_mark("1", "O")
    grid.place_mark("4", "X")
    grid.place_mark("7", "O")
    grid.place_mark("8", "X")
    grid.place_mark("6", "O")
    grid.place_mark("9", "X")
  end

  def game_with_winner
    grid.place_mark("3", :X)
    grid.place_mark("5", :X)
    grid.place_mark("7", :X)
  end

  it "is initialized with a size" do
    size = grid.size

    expect(size).to eq(3)
  end

  it "is initialized with cells number corresponding to size by size number initially set as nil" do
    grid_cells = grid.cells

    expect(grid_cells).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it "places mark on grid" do
    mark = "X"
    grid_position = "3"

    grid.place_mark(grid_position, mark)

    grid_cell = grid.cells[2]
    expect(grid_cell).to eq("X")
  end

  it "places second mark on grid" do
    mark = "X"
    grid_position = "3"
    grid.place_mark(grid_position, mark)

    mark2 = "O"
    grid_position = "6"
    grid.place_mark(grid_position, mark2)

    grid_cells = grid.cells
    expect(grid_cells).to eq([nil, nil, "X", nil, nil, "O", nil, nil, nil])
  end

  it "prepares array of arrays of numbers for correspondent empty cells" do
    cells_display = grid.grid_display

    expect(cells_display).to eq([["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]])
  end

  it "prepares array of arrays of numbers for correspondent empty cells and of placed marks if there are any" do
    mark = "X"
    grid_position = "3"
    grid.place_mark(grid_position, mark)

    cells_display = grid.grid_display

    expect(cells_display).to eq([["1", "2", "X"], ["4", "5", "6"], ["7", "8", "9"]])
  end

  it "returns true if cell is empty" do
    position = "3"

    expect(grid.empty_position?(position)).to eq(true)
  end

  it "returns false if cell is occupied" do
    grid.place_mark("3", "X")

    position = "3"

    expect(grid.empty_position?(position)).to eq(false)
  end

  it "returns list of available grid numbers for user" do
    expect(grid.grid_numbers).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
  end

  describe "knows when game finishes" do
    it "returns true if game ends because someone wins" do
      game_with_winner

      expect(grid.end_game?).to eq(true)
    end

    it "returns true if game ends and it's draw" do
      draw_game

      expect(grid.end_game?).to eq(true)
    end

    it "returns false if game is not finished" do
      grid.place_mark("1", "X")
      grid.place_mark("2", "O")
      grid.place_mark("3", "X")

      expect(grid.end_game?).to eq(false)
    end
  end

  describe "knows if it's draw or there's winner" do
    it "returns :winner if someone wins" do
      game_with_winner

      verdict_declaration = grid.verdict

      expect(verdict_declaration).to eq(:winner)
    end

    it "returns :draw if nobody wins" do
      draw_game

      verdict_declaration = grid.verdict

      expect(verdict_declaration).to eq(:draw)
    end
  end

  it "returns winning mark" do
    game_with_winner

    winning_mark = grid.winning_mark

    expect(winning_mark).to eq(:X)
  end

  it "creates new copy of grid with same cells state" do
    duplicated_grid = grid.duplicate_grid

    expect(duplicated_grid.cells).to eq(grid.cells)
  end

  it "compares its cells with other cells and returns index for different cell" do
    grid.place_mark("3", "O")
    grid.place_mark("2", "X")
    grid.place_mark("5", "O")
    grid.place_mark("1", "X")
    grid.place_mark("4", "O")
    grid.place_mark("7", "X")
    grid.place_mark("8", "O")
    new_move = "O"

    different_cell_position = grid.different_cell_position(["X", "X", "O", "O", "O", new_move, "X", "O", nil])

    expect(different_cell_position).to eq(5)
  end

  it "returns count of empty cells" do
    empty_cells_count_for_empty_cell = 9

    empty_cells_count = grid.empty_cells_count

    expect(empty_cells_count).to eq(empty_cells_count_for_empty_cell)
  end

end
