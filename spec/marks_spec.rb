require 'spec_helper'
require_relative '../lib/marks'

RSpec.describe Marks do

  it "returns 'X'" do
    expect(Marks.switch_mark("O")).to eq("X")
  end

  it "returns 'O'" do
    expect(Marks.switch_mark("X")).to eq("O")
  end


end
