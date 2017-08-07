require 'spec_helper'
require_relative '../lib/human_player'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe HumanPlayer do

  let(:output) {StringIO.new}
  let(:grid) {Grid.new(3)}

  it "returns valid move for empty grid position chosen to place mark on" do
    ui = Ui.new(StringIO.new("3"), output)
    human_player = HumanPlayer.new(ui)
    mark = "X"

    player_move = human_player.make_move(mark, grid)

    expect(player_move).to eq("3")
  end

  it "repeats move until grid position is occupied and returns valid move" do
    first_valid_move = "3"
    second_move_attempts = ["3", "4"]
    ui = Ui.new(StringIO.new(second_move_attempts.join("\n")), output)
    human_player = HumanPlayer.new(ui)
    mark = "X"

    grid.place_mark(first_valid_move, mark)
    second_valid_move = human_player.make_move(mark, grid)

    expect(second_valid_move).to eq("4")
  end

end
