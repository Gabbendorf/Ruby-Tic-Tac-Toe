require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'
require_relative '../lib/ui'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:computer) {UnbeatableComputer.new(ui)}

  it "returns copies of grid state each with computer's mark placed on different empty cell" do
    grid.place_mark("3", "X")
    grid.place_mark("5", "O")
    grid.place_mark("6", "X")
    computer_mark = "X"

    grids_with_moves = computer.grid_copies_with_possible_moves(grid, computer_mark)
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([computer_mark, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, computer_mark])
  end

  it "returns copies of grid for each of grid empty cells" do
    grid.place_mark("3", "X")
    grid.place_mark("5", "O")
    grid.place_mark("6", "X")
    grid_empty_cells_count = grid.empty_cells_count

    grid_copies = computer.copies_of_grid(grid)

    first_grid_copy = grid_copies[0]
    expect(first_grid_copy.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(grid_copies.size).to eq(grid_empty_cells_count)
  end

  describe "returns score for possible move according to game result prediction after minimax application" do
    it "returns 10 if possible move is winning move for computer and it's computer turn" do
      computer_mark = "O"
      grid.place_mark("1", computer_mark)
      grid.place_mark("3", computer_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid, computer_mark)
      computer_winning_move = possible_moves[0]

      score = computer.move_score(computer_winning_move, computer_mark)

      expect(score).to eq(10)
    end

    it "returns 10 if opponent doesn't prevent computer from winning in next game states" do
      computer_mark = "O"
      opponent_mark = "X"
      grid.place_mark("1", computer_mark)
      grid.place_mark("3", computer_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid, opponent_mark)
      opponent_move_different_from_2 = possible_moves[4]

      score = computer.move_score(opponent_move_different_from_2, computer_mark)

      expect(score).to eq(10)
    end

    it "returns -10 if possible move is winning move for opponent and it's opponent turn" do
      opponent_mark = "X"
      grid.place_mark("1", opponent_mark)
      grid.place_mark("2", opponent_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid, opponent_mark)
      opponent_winning_move = possible_moves[1]

      score = computer.move_score(opponent_winning_move, opponent_mark)

      expect(score).to eq(-10)
    end

    it "returns -10 if computer doesn't prevent opponent from winning in next game states" do
      opponent_mark = "X"
      computer_mark = "O"
      grid.place_mark("1", opponent_mark)
      grid.place_mark("2", opponent_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid, computer_mark)
      computer_move_different_from_3 = possible_moves[2]

      score = computer.move_score(computer_move_different_from_3, computer_mark)

      expect(score).to eq(-10)
    end

    it "returns 0 if possible move leads to end game which is draw" do
      computer_mark = "O"
      grid.place_mark("3", "O")
      grid.place_mark("2", "X")
      grid.place_mark("5", "O")
      grid.place_mark("1", "X")
      grid.place_mark("4", "O")
      grid.place_mark("7", "X")
      grid.place_mark("8", "O")
      grid.place_mark("6", "X")
      possible_moves = computer.grid_copies_with_possible_moves(grid, computer_mark)
      last_move_possible = possible_moves[0]

      score = computer.move_score(last_move_possible, computer_mark)

      expect(score).to eq(0)
    end

    it "returns 0 if in next game state nobody can win" do
      computer_mark = "O"
      possible_moves = computer.grid_copies_with_possible_moves(grid, computer_mark)
      first_move = possible_moves[0]

      score = computer.move_score(first_move, computer_mark)

      expect(score).to eq(0)
    end
  end

  it "returns hash with grid copies showing possible moves as key and their score as value" do
    grid.place_mark("3", "O")
    grid.place_mark("2", "X")
    grid.place_mark("5", "O")
    grid.place_mark("1", "X")
    grid.place_mark("4", "O")
    grid.place_mark("7", "X")
    grid.place_mark("8", "O")
    grid.place_mark("6", "X")
    possible_computer_move = "O"
    score_for_draw = 0

    possible_moves_and_scores = computer.possible_moves_and_scores(grid)

    grid_for_last_possible_move = possible_moves_and_scores.keys[0].cells
    expect(grid_for_last_possible_move).to eq(["X", "X", "O", "O", "O", "X", "X", "O", possible_computer_move])
    move_score = possible_moves_and_scores.values[0]
    expect(move_score).to eq(score_for_draw)
  end

  it "returns move with biggest score" do
    grid.place_mark("3", "O")
    grid.place_mark("2", "X")
    grid.place_mark("5", "O")
    grid.place_mark("1", "X")
    grid.place_mark("4", "O")
    grid.place_mark("7", "X")
    grid.place_mark("8", "O")
    ideal_move = "6"

    move_with_highest_score = computer.best_move_position(grid)

    expect(move_with_highest_score).to eq(ideal_move)
  end

  it "returns random move for first move if game at initial state" do
    computer_mark = "O"
    computer = double("computer")
    grid = double("grid")
    expect(grid).to receive(:initial_state?) {true}
    expect(grid).to receive(:grid_numbers) {["1", "1", "1"]}
    computer = UnbeatableComputer.new(ui)

    random_move = computer.make_move(computer_mark, grid)

    expect(random_move).to eq("1")
  end

  it "returns grid position number for best move chosen if game is not at initial state" do
    computer_mark = "O"
    grid.place_mark("3", "O")
    grid.place_mark("2", "X")
    grid.place_mark("5", "O")
    grid.place_mark("1", "X")
    grid.place_mark("4", "O")
    grid.place_mark("7", "X")
    grid.place_mark("8", "O")
    move_with_highest_score = "6"

    move = computer.make_move(computer_mark, grid)

    expect(move).to eq(move_with_highest_score)
  end

end
