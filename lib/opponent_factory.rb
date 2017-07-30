require_relative 'human_player'
require_relative 'unbeatable_computer'

class OpponentFactory

  def initialize(ui, grid)
    @ui = ui
    @grid = grid
  end

  def create_opponent(opponent_choice)
    if opponent_choice == "h"
      HumanPlayer.new(@ui, @grid)
    else
      UnbeatableComputer.new(@grid)
    end
  end

end
