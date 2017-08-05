require 'spec_helper'
require_relative '../lib/tictactoe'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/game'

RSpec.describe TicTacToe do

  let(:output) {StringIO.new}
  let(:grid) {Grid.new(3)}
  let(:game) {Game.new}

  describe "runs just 1 game" do
    it "runs a draw game between two human players" do
      input_to_quit = "n"
      input = StringIO.new("h\n3\n2\n5\n1\n4\n7\n8\n6\n9\n" + input_to_quit)
      ui = Ui.new(input, output)
      first_player = HumanPlayer.new(ui)
      new_game = TicTacToe.new(ui, grid, game, first_player)

      new_game.run

      expect(grid.verdict).to eq(:draw)
    end

    it "runs a game human player vs. computer, human player starting" do
      input_to_quit = "n"
      input = StringIO.new("c\n" + input_to_quit)
      ui = Ui.new(input, output)
      first_player = FakeHumanPlayer.new(grid)
      new_game = TicTacToe.new(ui, grid, game, first_player)

      new_game.run

      human_player_mark = "X"
      expect(grid.winning_mark).not_to equal(human_player_mark)
    end

  end

  describe "runs 2 games in a row" do
    it "runs 2 games between two human players" do
      input_to_play_again = "y\n"
      input_to_quit = "n"
      first_game_inputs = "h\n1\n4\n2\n5\n3\n"
      second_game_inputs = "h\n3\n2\n5\n1\n4\n7\n8\n6\n9\n"
      input = StringIO.new(first_game_inputs + input_to_play_again + second_game_inputs + input_to_quit)
      ui = Ui.new(input, output)
      first_player = HumanPlayer.new(ui)
      new_game = TicTacToe.new(ui, grid, game, first_player)

      new_game.run

      second_game_verdict = grid.verdict
      expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
      expect(second_game_verdict).to eq(:draw)
    end

    it "runs 2 games human player vs. computer, computer starting at 2nd game" do
      input_to_play_again = "y\n"
      input_to_quit = "n"
      starting_game_input = "c\n"
      input = StringIO.new(starting_game_input + input_to_play_again + starting_game_input + input_to_quit)
      ui = Ui.new(input, output)
      first_player = FakeHumanPlayer.new(grid)
      new_game = TicTacToe.new(ui, grid, game, first_player)

      new_game.run

      human_player_mark = "X"
      second_game_winning_mark = grid.winning_mark
      expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
      expect(second_game_winning_mark).not_to equal(human_player_mark)
    end
  end

  class FakeHumanPlayer

    def initialize(grid)
      @grid = grid
    end

    def make_move(player_mark, grid)
      move = @grid.grid_numbers.sample
      while !@grid.empty_position?(move)
        move = @grid.grid_numbers.sample
      end
      move
    end

  end

end
