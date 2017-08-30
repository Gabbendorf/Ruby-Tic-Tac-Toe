require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe Game do

  let(:grid) {Grid.new(3)}
  let(:output) {StringIO.new}
  let(:input) {StringIO.new("h\n4")}
  let(:ui) {Ui.new(input, output)}
  let(:game) {Game.new}
  let(:human_player) {HumanPlayer.new(ui)}
  let(:computer) {UnbeatableComputer.new(ui)}

  def players
    {:first_player => {:player => human_player, :mark => Marks::USER},
     :second_player => {:player => computer, :mark => Marks::OPPONENT}}
  end

  it "returns players and their marks" do
    player_input_for_computer = "c"
    ui = Ui.new(StringIO.new(player_input_for_computer), output)
    game = Game.new

    players = game.players_and_marks(human_player, ui)
    human_player = players[:first_player][:player]
    first_player_mark = players[:first_player][:mark]
    second_player = players[:second_player][:player]
    second_player_mark = players[:second_player][:mark]

    expect(human_player).to be_kind_of(HumanPlayer)
    expect(first_player_mark).to eq("X")
    expect(second_player).to be_kind_of(UnbeatableComputer)
    expect(second_player_mark).to eq("O")
  end

  it "creates grid" do
    new_grid = game.create_grid(ui)

    expect(new_grid).to have_attributes(:size => 3)
  end

  it "returns starter" do
    starter = game.starter(players)

    expect(starter).to be_kind_of(HumanPlayer)
  end

  it "switches player" do
    starter = game.starter(players)

    switched_player = game.switch_player(starter, players)
    current_player = game.switch_player(switched_player, players)

    expect(switched_player).to be_kind_of(UnbeatableComputer)
    expect(current_player).to be_kind_of(HumanPlayer)
  end

  it "gets move from current player and registers corresponding mark on grid" do
    players = game.players_and_marks(human_player, ui)
    current_player = game.starter(players)

    game.make_move(current_player, players, grid)

    grid_state = grid.cells
    expect(grid_state).to eq([nil, nil, nil, players[:first_player][:mark], nil, nil, nil, nil, nil])
  end

  it "alternates player that starts game" do
    first_starter = players[:first_player][:player]

    next_starter = game.switch_player(first_starter, players)

    expect(next_starter).to be_kind_of(UnbeatableComputer)
  end

  it "takes move and calls method that prints message for move made announcement" do
    ui = double("ui")
    current_player = double("player")
    expect(current_player).to receive(:make_move).with("X", grid) {"3"}
    players = {:first_player => {:player => current_player, :mark => Marks::USER},
     :second_player => {:player => "computer", :mark => Marks::OPPONENT}}
    game.make_move(current_player, players, grid)
    current_player = players[:first_player][:player]
    ui = Ui.new(input, output)

    game.announce_move_made(ui, current_player, players)

    expect(output.string).to include("Player X marked position 3.")
  end

end
