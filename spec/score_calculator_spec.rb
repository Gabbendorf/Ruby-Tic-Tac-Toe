require 'spec_helper'
require_relative '../lib/score_calculator'
require_relative '../lib/grid'

RSpec.describe ScoreCalculator do

  let(:score_calculator) {ScoreCalculator.new}
  let(:grid) {Grid.new(3)}

  it "returns 10 if possible move is winning move for computer and it's computer turn" do
    grid.place_mark("1", Marks::COMPUTER_MARK)
    grid.place_mark("3", Marks::COMPUTER_MARK)
    possible_moves = grid.create_copies_with_possible_moves(Marks::COMPUTER_MARK)
    computer_winning_move = possible_moves[0]

    score = score_calculator.score_for(computer_winning_move, Marks::COMPUTER_MARK)

    expect(score).to eq(10)
  end

  it "returns 10 if opponent doesn't prevent computer from winning in next game states" do
    grid.place_mark("1", Marks::COMPUTER_MARK)
    grid.place_mark("3", Marks::COMPUTER_MARK)
    possible_moves = grid.create_copies_with_possible_moves(Marks::OPPONENT_MARK)
    opponent_move_different_from_2 = possible_moves[4]

    score = score_calculator.score_for(opponent_move_different_from_2, Marks::COMPUTER_MARK)

    expect(score).to eq(10)
  end

  it "returns -10 if possible move is winning move for opponent and it's opponent turn" do
    grid.place_mark("1", Marks::OPPONENT_MARK)
    grid.place_mark("2", Marks::OPPONENT_MARK)
    possible_moves = grid.create_copies_with_possible_moves(Marks::OPPONENT_MARK)
    opponent_winning_move = possible_moves[1]

    score = score_calculator.score_for(opponent_winning_move, Marks::OPPONENT_MARK)

    expect(score).to eq(-10)
  end

  it "returns -10 if computer doesn't prevent opponent from winning in next game states" do
    grid.place_mark("1", Marks::OPPONENT_MARK)
    grid.place_mark("2", Marks::OPPONENT_MARK)
    possible_moves = grid.create_copies_with_possible_moves(Marks::OPPONENT_MARK)
    computer_move_different_from_3 = possible_moves[2]

    score = score_calculator.score_for(computer_move_different_from_3, Marks::OPPONENT_MARK)

    expect(score).to eq(-10)
  end

  it "returns 0 if possible move leads to end game which is draw" do
    grid.place_mark("3", Marks::COMPUTER_MARK)
    grid.place_mark("2", Marks::OPPONENT_MARK)
    grid.place_mark("5", Marks::COMPUTER_MARK)
    grid.place_mark("1", Marks::OPPONENT_MARK)
    grid.place_mark("4", Marks::COMPUTER_MARK)
    grid.place_mark("7", Marks::OPPONENT_MARK)
    grid.place_mark("8", Marks::COMPUTER_MARK)
    grid.place_mark("6", Marks::OPPONENT_MARK)
    possible_moves = grid.create_copies_with_possible_moves(Marks::COMPUTER_MARK)
    last_move_possible = possible_moves[0]

    score = score_calculator.score_for(last_move_possible, Marks::COMPUTER_MARK)

    expect(score).to eq(0)
  end

  it "returns 0 if in next game state nobody can win" do
    possible_moves = grid.create_copies_with_possible_moves(Marks::COMPUTER_MARK)
    first_move = possible_moves[0]

    score = score_calculator.score_for(first_move, Marks::COMPUTER_MARK)

    expect(score).to eq(0)
  end

end
