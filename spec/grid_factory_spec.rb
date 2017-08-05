require 'spec_helper'
require_relative '../lib/grid_factory'
require_relative '../lib/ui'

RSpec.describe GridFactory do

  let(:output) {StringIO.new}
  let(:ui) {Ui.new(StringIO.new, output)}
  let(:grid_factory) {GridFactory.new}

  it "creates customised grid from user size choice" do
    input = StringIO.new("4")
    ui = Ui.new(input, output)

    grid = grid_factory.customised_grid(ui)

    expect(grid).to have_attributes(:size => 4)
  end

  it "creates standard grid 3x3" do
    grid = grid_factory.standard_grid

    expect(grid).to have_attributes(:size => 3)
  end

end
