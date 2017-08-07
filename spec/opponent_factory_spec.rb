require 'spec_helper'
require_relative '../lib/opponent_factory'
require_relative '../lib/ui'

RSpec.describe OpponentFactory do

  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:opponent_factory) {OpponentFactory.new(ui)}

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
