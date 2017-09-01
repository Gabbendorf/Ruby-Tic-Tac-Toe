require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'
require_relative '../lib/ui'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:computer) {UnbeatableComputer.new(ui)}

  MARKS = UnbeatableComputer::MARKS

  it "returns random move for first move if game at initial state" do
    computer = double("computer")
    grid = double("grid")
    expect(grid).to receive(:initial_state?) {true}
    expect(grid).to receive(:grid_numbers) {["1", "1", "1"]}
    computer = UnbeatableComputer.new(ui)

    random_move = computer.make_move(MARKS[:computer], grid)

    expect(random_move).to eq("1")
  end

  it "returns grid position number for best move chosen if game is not at initial state" do
    grid.place_mark("3", MARKS[:computer])
    grid.place_mark("2", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("1", MARKS[:opponent])
    grid.place_mark("4", MARKS[:computer])
    grid.place_mark("7", MARKS[:opponent])
    grid.place_mark("8", MARKS[:computer])
    move_with_highest_score = "6"

    move = computer.make_move(MARKS[:computer], grid)

    expect(move).to eq(move_with_highest_score)
  end

  it "returns standard grid size 3" do
    expect(computer.grid_size).to eq(3)
  end

end
