require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe Game do

  let(:grid) {Grid.new(3)}
  let(:output) {StringIO.new}
  let(:input) {StringIO.new("h\n3")}
  let(:ui) {Ui.new(input, output)}
  let(:game) {Game.new(ui, grid)}

  it "creates the players and assigns them mark" do
    player_input_for_computer = "c"
    ui = Ui.new(StringIO.new(player_input_for_computer), output)
    game = Game.new(ui, grid)

    players = game.players_and_marks
    first_player = players[:first_player][:player]
    first_player_mark = players[:first_player][:mark]
    second_player = players[:second_player][:player]
    second_player_mark = players[:second_player][:mark]

    expect(first_player).to be_kind_of(HumanPlayer)
    expect(first_player_mark).to eq("X")
    expect(second_player).to be_kind_of(UnbeatableComputer)
    expect(second_player_mark).to eq("O")
  end

  it "returns starter" do
    players = {:first_player => {:player => "human player", :mark => "X"},
               :second_player => {:player => "computer", :mark => "O"}}

    starter = game.starter(players)

    expect(starter).to eq("human player")
  end

  it "switches player" do
    players = {:first_player => {:player => "human player", :mark => "X"},
               :second_player => {:player => "computer", :mark => "O"}}
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

  it "declares winner and asks to play again" do
    grid = double("grid")
    output = StringIO.new
    ui = Ui.new(StringIO.new("y"), output)
    game = Game.new(ui, grid)
    expect(grid).to receive(:verdict) {:winner}
    expect(grid).to receive(:winning_mark) { "X" }

    game.end_of_game_actions

    expect(output.string).to include("Player X wins!")
    expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
  end

  it "declares it's draw and asks to play again" do
    grid = double("grid")
    output = StringIO.new
    ui = Ui.new(StringIO.new("y"), output)
    game = Game.new(ui, grid)
    expect(grid).to receive(:verdict) {:draw}

    game.end_of_game_actions

    expect(output.string).to include("It's a draw: nobody wins!")
    expect(output.string).to include("Do you want to play again? y --> yes, n --> quit")
  end

  it "alternates mark type to start game" do
    players = {:first_player => {:player => "human player", :mark => "X"},
               :second_player => {:player => "computer", :mark => "O"}}
    first_starter = "human player"

    next_starter = game.change_starter_for_next_game(first_starter, players)

    expect(next_starter).to eq("computer")
  end

  it "says goodbye and exits the program" do
    game.exit_game

    expect(output.string).to include("See you soon!")
  end

end
