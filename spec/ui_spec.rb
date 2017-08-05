require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:grid) {Grid.new(3)}

  it "welcomes players" do
    ui.welcome

    expect(output.string).to include("Welcome to...")
  end

  it "prints the game logo" do
    output = double("output")
    ui = Ui.new(input, output)

    expect(output).to receive(:puts).with(Ui::LOGO)

    ui.print_logo
  end

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

    opponent_input = ui.choose_opponent

    expect(output.string).to include("Choose your opponent: h --> human player, c --> computer")
    expect(output.string).to include("Sorry, I didn't understand: h --> human player, c --> computer")
    expect(opponent_input).to eq("h")
  end

  it "asks to make move and returns correct move" do
    ui = Ui.new(StringIO.new("1"), output)
    player_mark = "X"

    move_position = ui.ask_for_move(grid, player_mark)

    expect(output.string).to include("Player X, make your move:")
    expect(move_position).to eq("1")
  end

  it "asks to make move and returns validated move for invalid input" do
    ui = Ui.new(StringIO.new("11\n1"), output)
    player_mark = "X"

    move_position = ui.ask_for_move(grid, player_mark)

    expect(output.string).to include("Move not valid, please repeat your move:")
    expect(move_position).to eq("1")
  end

  it "asks to make move and returns validated move for already chosen move" do
    player_mark = "X"
    grid.place_mark("1", player_mark)
    ui = Ui.new(StringIO.new("1\n2"), output)

    move_position = ui.ask_for_move(grid, player_mark)

    expect(output.string).to include("Position already occupied, please move again:")
    expect(move_position).to eq("2")
  end

  it "announce it's computer's turn" do
    computer_mark = "O"

    ui.announce_computer_moving(computer_mark)

    expect(output.string).to eq("Player O's turn:\n\n")
  end

  it "declares a winner" do
    winning_mark = "X"

    ui.declare_winner(winning_mark)

    expect(output.string).to eq("Player X wins!\n\n")
  end

  it "declares it's draw" do
    ui.declare_draw

    expect(output.string).to eq("It's a draw: nobody wins!\n\n")
  end

  it "asks to start new game" do
    ui = Ui.new(StringIO.new("y"), output)

    answer = ui.ask_to_play_again

    expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
    expect(answer).to eq("y")
  end

  it "asks to answer y or n again if input is wrong" do
    ui = Ui.new(StringIO.new("g\ny"), output)

    answer = ui.ask_to_play_again

    expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
    expect(output.string).to include("Sorry, I didn't understand: y --> yes, n --> quit")

    expect(answer).to eq("y")
  end

  it "says goodbye" do
    ui.say_goodbye

    expect(output.string).to include("See you soon!")
  end

end
