require_relative 'opponent_factory'
require_relative 'human_player'

class Game

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
    @intro = welcome_players
    @first_player = HumanPlayer.new(@ui, @grid)
  end

  def players_and_marks
    {:first_player => {:player => @first_player,
                       :mark => "X"},
    :second_player => {:player => opponent,
                       :mark => "O"}
    }
  end

  def starter(players)
    first_player(players)
  end

  def switch_player(current_player, players)
    current_player == first_player(players) ? second_player(players) : first_player(players)
  end

  def make_move(current_player, players)
    mark = mark(current_player, players)
    move = current_player.make_move(mark)
    @grid.place_mark(move, mark)
  end

  def end_of_game_actions
    if @grid.verdict == :winner
      @ui.declare_winner(@grid.winning_mark)
      ask_to_play_again
    else
      @ui.declare_draw
      ask_to_play_again
    end
  end

  def change_starter_for_next_game(current_starter, players)
    if current_starter == first_player(players)
      second_player(players)
    else
      first_player(players)
    end
  end

  def exit_game
    @ui.say_goodbye
  end

  private

  def welcome_players
    @ui.welcome
    @ui.print_logo
  end

  def first_player(players)
    players[:first_player][:player]
  end

  def second_player(players)
    players[:second_player][:player]
  end

  def opponent
    opponent_choice = @ui.choose_opponent
    OpponentFactory.new(@ui, @grid).create_opponent(opponent_choice)
  end

  def mark(current_player, players)
    if current_player == first_player(players)
      players[:first_player][:mark]
    else
      players[:second_player][:mark]
    end
  end

  def ask_to_play_again
    @ui.ask_to_play_again
  end

end
