require 'spec_helper'
require_relative '../lib/opponent_factory'
require_relative '../lib/ui'
require_relative '../lib/grid'
require_relative '../lib/human_player'
require_relative '../lib/unbeatable_computer'

RSpec.describe OpponentFactory do

  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:grid) {Grid.new(3)}
  let(:opponent_factory) {OpponentFactory.new(ui, grid)}

  it "creates human player opponent" do
    opponent_choice = "h"

    opponent = opponent_factory.create_opponent(opponent_choice)

    expect(opponent).to be_kind_of(HumanPlayer)
  end

  it "creates unbeatable computer opponent" do
    opponent_choice = "c"

    opponent = opponent_factory.create_opponent(opponent_choice)

    expect(opponent).to be_kind_of(UnbeatableComputer)
  end

end
