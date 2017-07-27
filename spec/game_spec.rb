require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'

RSpec.describe Game do

  let(:grid) {Grid.new(3)}
  let(:output) {StringIO.new}
  let(:input) {StringIO.new("h\n3")}
  let(:ui) {Ui.new(input, output)}
  let(:game) {Game.new(ui, grid)}
  let(:human_player) {HumanPlayer.new(ui, grid)}

  def set_up_game_for_different_inputs(grid, input, output)
    ui = Ui.new(input, output)
    Game.new(ui, grid)
  end

  it "creates the players and assigns them mark" do
    player_input_for_computer = "c"
    input = StringIO.new(player_input_for_computer)
    ui = Ui.new(input, output)
    game = Game.new(ui, grid)

    players = game.players_and_marks
    first_player = players[:first_player][:type]
    first_player_mark = players[:first_player][:mark]
    second_player = players[:second_player][:type]
    second_player_mark = players[:second_player][:mark]

    expect(first_player).to be_kind_of(HumanPlayer)
    expect(first_player_mark).to eq("X")
    expect(second_player).to be_kind_of(UnbeatableComputer)
    expect(second_player_mark).to eq("O")
  end

  it "returns starter" do
    players = {:first_player => {:type => "human player", :mark => "X"}, :second_player => {:type => "computer", :mark => "O"}}

    starter = game.starter(players)

    expect(starter).to eq("human player")
  end

  it "switches player" do
    players = {:first_player => {:type => "human player", :mark => "X"}, :second_player => {:type => "computer", :mark => "O"}}
    starter = game.starter(players)

    switched_player = game.switch_player(starter, players)
    current_player = game.switch_player(switched_player, players)

    expect(switched_player).to eq("computer")
    expect(current_player).to eq("human player")
  end

  it "gets move from current player and registers corresponding mark on grid" do
    players = game.players_and_marks
    current_player = game.starter(players)

    game.make_move(current_player, players)

    grid_state = grid.cells
    expect(grid_state).to eq([nil, nil, "X", nil, nil, nil, nil, nil, nil])
  end

  it "declares winner" do
    grid = double("grid")
    game = set_up_game_for_different_inputs(grid, StringIO.new("h\n1"), output)

    expect(grid).to receive(:verdict) {:winner}
    expect(grid).to receive(:winning_mark) { "X" }

    game.report_verdict
    expect(output.string).to include("Player X wins!")
  end

  it "declares it's draw" do
    grid = double("grid")
    game = set_up_game_for_different_inputs(grid, StringIO.new("h\n1"), output)

    expect(grid).to receive(:verdict) {:draw}

    game.report_verdict
    expect(output.string).to include("It's a draw: nobody wins!")
  end

end
