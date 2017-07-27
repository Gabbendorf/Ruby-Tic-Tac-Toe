require 'spec_helper'
require_relative '../lib/tictactoe'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'
require_relative '../lib/game'

RSpec.describe TicTacToe do

  let(:output) {StringIO.new}
  let(:grid) {Grid.new(3)}

  describe "runs just 1 game" do
    it "runs a game between two human players" do
      input = StringIO.new("h\n3\n2\n5\n1\n4\n7\n8\n6\n9\nn")
      ui = Ui.new(input, output)
      game = Game.new(grid)
      new_game = TicTacToe.new(ui, grid, game)

      new_game.run

      expect(output.string).to include("It's a draw: nobody wins!")
    end

  end

  describe "runs 2 games in line" do
    it "runs 2 games between two human players" do
      first_game_inputs = "h\n1\n4\n2\n5\n3\ny\n"
      second_game_inputs = "h\n3\n2\n5\n1\n4\n7\n8\n6\n9\nn"
      input = StringIO.new(first_game_inputs + second_game_inputs)
      ui = Ui.new(input, output)
      game = Game.new(grid)
      new_game = TicTacToe.new(ui, grid, game)

      new_game.run

      expect(output.string).to include("Player X wins!")
      expect(output.string).to include("It's a draw: nobody wins!")
    end

  end

end
