require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/grid'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:grid) {Grid.new(3)}

  it "prints the grid" do
    ui.print_grid(grid)

    expect(output.string).to include("1  |  2  |  3\n_____________\n4  |  5  |  6\n_____________\n7  |  8  |  9\n")
  end

end
