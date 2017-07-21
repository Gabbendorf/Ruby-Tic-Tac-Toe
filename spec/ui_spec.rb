require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:grid) {Grid.new(3)}

  it "prints the grid" do
    ui.print_grid(grid)

    expect(output.string).to include("1  |  2  |  3\n_____________\n4  |  5  |  6\n_____________\n7  |  8  |  9\n")
  end

  it "asks to choose opponent" do
    input = StringIO.new("H")
    ui = Ui.new(input, output)

    opponent = ui.choose_opponent

    expect(output.string).to include("Choose your opponent: h --> human player, c --> computer")
    expect(opponent).to eq("h")
  end

  it "asks again to choose opponent if opponent choice input is wrong" do
    input = StringIO.new("human\nh")
    ui = Ui.new(input, output)

    opponent = ui.choose_opponent

    expect(output.string).to include("Choose your opponent: h --> human player, c --> computer\nSorry, I didn't understand: h --> human player, c --> computer")
    expect(opponent).to eq("h")
  end

  it "asks to make move" do
    input = StringIO.new("1")
    ui = Ui.new(input, output)

    opponent = ui.ask_for_move(grid)

    expect(output.string).to include("Make your move:")
    expect(opponent).to eq("1")
  end

  it "asks to make move again if input is wrong" do
    input = StringIO.new("11\n1")
    ui = Ui.new(input, output)

    opponent = ui.ask_for_move(grid)

    expect(output.string).to include("Move not valid, please repeat your move:")
    expect(opponent).to eq("1")
  end

end
