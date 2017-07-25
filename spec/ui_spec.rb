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
    ui = Ui.new(StringIO.new("H"), output)

    opponent = ui.choose_opponent

    expect(output.string).to include("Choose your opponent: h --> human player, c --> computer")
    expect(opponent).to eq("h")
  end

  it "asks again to choose opponent if opponent choice input is wrong" do
    ui = Ui.new(StringIO.new("human\nh"), output)

    opponent = ui.choose_opponent

    expect(output.string).to include("Choose your opponent: h --> human player, c --> computer\nSorry, I didn't understand: h --> human player, c --> computer")
    expect(opponent).to eq("h")
  end

  it "asks to make move" do
    ui = Ui.new(StringIO.new("1"), output)

    opponent = ui.ask_for_move(grid)

    expect(output.string).to include("Make your move:")
    expect(opponent).to eq("1")
  end

  it "asks to make move again if input is wrong" do
    ui = Ui.new(StringIO.new("11\n1"), output)

    opponent = ui.ask_for_move(grid)

    expect(output.string).to include("Move not valid, please repeat your move:")
    expect(opponent).to eq("1")
  end

  it "asks to make move again if position is already occupied" do
    ui = Ui.new(StringIO.new("1"), output)

    opponent = ui.ask_for_empty_position

    expect(output.string).to include("Position already occupied, please move again:")
    expect(opponent).to eq("1")
  end

  it "declares a winner" do
    winning_mark = "X"

    ui.declare_winner(winning_mark)

    expect(output.string).to eq("Player X wins!\n")
  end

  it "declares it's draw" do
    ui.declare_draw

    expect(output.string).to eq("It's a draw: nobody wins!\n")
  end

end
