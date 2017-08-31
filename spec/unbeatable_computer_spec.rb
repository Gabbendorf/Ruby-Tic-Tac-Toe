require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'
require_relative '../lib/ui'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:ui) {Ui.new(StringIO.new, StringIO.new)}
  let(:computer) {UnbeatableComputer.new(ui)}

  MARKS = UnbeatableComputer::MARKS

  it "returns copies of grid state each with computer's mark placed on different empty cell" do
    grid.place_mark("3", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("6", MARKS[:opponent])

    grids_with_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:computer])
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([MARKS[:computer], nil, MARKS[:opponent], nil, MARKS[:computer], MARKS[:opponent], nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, MARKS[:opponent], nil, MARKS[:computer], MARKS[:opponent], nil, nil, MARKS[:computer]])
  end

  it "returns copies of grid for each of grid empty cells" do
    grid.place_mark("3", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("6", MARKS[:opponent])
    grid_empty_cells_count = grid.empty_cells_count

    grid_copies = computer.copies_of_grid(grid)

    first_grid_copy = grid_copies[0]
    expect(first_grid_copy.cells).to eq([nil, nil, MARKS[:opponent], nil, MARKS[:computer], MARKS[:opponent], nil, nil, nil])
    expect(grid_copies.size).to eq(grid_empty_cells_count)
  end

  describe "returns score for possible move according to game result prediction after minimax application" do
    it "returns 10 if possible move is winning move for computer and it's computer turn" do
      grid.place_mark("1", MARKS[:computer])
      grid.place_mark("3", MARKS[:computer])
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:computer])
      computer_winning_move = possible_moves[0]

      score = computer.move_score(computer_winning_move, MARKS[:computer])

      expect(score).to eq(10)
    end

    it "returns 10 if opponent doesn't prevent computer from winning in next game states" do
      grid.place_mark("1", MARKS[:computer])
      grid.place_mark("3", MARKS[:computer])
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:opponent])
      opponent_move_different_from_2 = possible_moves[4]

      score = computer.move_score(opponent_move_different_from_2, MARKS[:computer])

      expect(score).to eq(10)
    end

    it "returns -10 if possible move is winning move for opponent and it's opponent turn" do
      grid.place_mark("1", MARKS[:opponent])
      grid.place_mark("2", MARKS[:opponent])
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:opponent])
      opponent_winning_move = possible_moves[1]

      score = computer.move_score(opponent_winning_move, MARKS[:opponent])

      expect(score).to eq(-10)
    end

    it "returns -10 if computer doesn't prevent opponent from winning in next game states" do
      grid.place_mark("1", MARKS[:opponent])
      grid.place_mark("2", MARKS[:opponent])
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:computer])
      computer_move_different_from_3 = possible_moves[2]

      score = computer.move_score(computer_move_different_from_3, MARKS[:computer])

      expect(score).to eq(-10)
    end

    it "returns 0 if possible move leads to end game which is draw" do
      grid.place_mark("3", MARKS[:computer])
      grid.place_mark("2", MARKS[:opponent])
      grid.place_mark("5", MARKS[:computer])
      grid.place_mark("1", MARKS[:opponent])
      grid.place_mark("4", MARKS[:computer])
      grid.place_mark("7", MARKS[:opponent])
      grid.place_mark("8", MARKS[:computer])
      grid.place_mark("6", MARKS[:opponent])
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:computer])
      last_move_possible = possible_moves[0]

      score = computer.move_score(last_move_possible, MARKS[:computer])

      expect(score).to eq(0)
    end

    it "returns 0 if in next game state nobody can win" do
      possible_moves = computer.grid_copies_with_possible_moves(grid, MARKS[:computer])
      first_move = possible_moves[0]

      score = computer.move_score(first_move, MARKS[:computer])

      expect(score).to eq(0)
    end
  end

  it "returns hash with grid copies showing possible moves as key and their score as value" do
    grid.place_mark("3", MARKS[:computer])
    grid.place_mark("2", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("1", MARKS[:opponent])
    grid.place_mark("4", MARKS[:computer])
    grid.place_mark("7", MARKS[:opponent])
    grid.place_mark("8", MARKS[:computer])
    grid.place_mark("6", MARKS[:opponent])
    possible_computer_move = MARKS[:computer]
    score_for_draw = 0

    possible_moves_and_scores = computer.possible_moves_and_scores(grid)

    grid_for_last_possible_move = possible_moves_and_scores.keys[0].cells
    expect(grid_for_last_possible_move).to eq([MARKS[:opponent], MARKS[:opponent], MARKS[:computer], MARKS[:computer], MARKS[:computer], MARKS[:opponent],
                                              MARKS[:opponent], MARKS[:computer], possible_computer_move])
    move_score = possible_moves_and_scores.values[0]
    expect(move_score).to eq(score_for_draw)
  end

  it "returns move with biggest score" do
    grid.place_mark("3", MARKS[:computer])
    grid.place_mark("2", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("1", MARKS[:opponent])
    grid.place_mark("4", MARKS[:computer])
    grid.place_mark("7", MARKS[:opponent])
    grid.place_mark("8", MARKS[:computer])
    ideal_move = "6"

    move_with_highest_score = computer.best_move_position(grid)

    expect(move_with_highest_score).to eq(ideal_move)
  end

  it "returns random move for first move if game at initial state" do
    computer = double("computer")
    grid = double("grid")
    expect(grid).to receive(:initial_state?) {true}
    expect(grid).to receive(:grid_numbers) {["1", "1", "1"]}
    computer = UnbeatableComputer.new(ui)

    random_move = computer.make_move(MARKS[:computer], grid)

    expect(random_move).to eq("1")
  end

  it "returns grid position number for best move chosen if game is not at initial state" do
    grid.place_mark("3", MARKS[:computer])
    grid.place_mark("2", MARKS[:opponent])
    grid.place_mark("5", MARKS[:computer])
    grid.place_mark("1", MARKS[:opponent])
    grid.place_mark("4", MARKS[:computer])
    grid.place_mark("7", MARKS[:opponent])
    grid.place_mark("8", MARKS[:computer])
    move_with_highest_score = "6"

    move = computer.make_move(MARKS[:computer], grid)

    expect(move).to eq(move_with_highest_score)
  end
  
  it "returns standard grid size 3" do
    expect(computer.grid_size).to eq(3)
  end

end
