require 'spec_helper'
require_relative '../lib/tictactoe'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'
require_relative '../lib/game'

RSpec.describe TicTacToe do

  let(:output) {StringIO.new}
  let(:grid) {Grid.new(3)}

  it "runs a game between two human players that's a draw" do
    input = StringIO.new("h\n3\n2\n5\n1\n4\n7\n8\n6\n9")
    ui = Ui.new(input, output)
    game = Game.new(ui, grid)
    new_game = TicTacToe.new(grid, game)

    new_game.run

    expect(output.string).to include("It's a draw: nobody wins!")
  end

  it "runs a game between two human players and player X wins" do
    input = StringIO.new("h\n1\n4\n2\n5\n3")
    ui = Ui.new(input, output)
    game = Game.new(ui, grid)
    new_game = TicTacToe.new(grid, game)

    new_game.run

    expect(output.string).to include("Player X wins!")
  end

  it "runs a game between two human players and player O wins" do
    input = StringIO.new("h\n1\n4\n2\n5\n8\n6")
    ui = Ui.new(input, output)
    game = Game.new(ui, grid)
    new_game = TicTacToe.new(grid, game)

    new_game.run

    expect(output.string).to include("Player O wins!")
  end

end
