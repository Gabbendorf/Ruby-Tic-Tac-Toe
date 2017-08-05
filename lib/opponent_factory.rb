require_relative 'human_player'
require_relative 'unbeatable_computer'

class OpponentFactory

  def initialize(ui)
    @ui = ui
  end

  def create_opponent(opponent_choice)
    if opponent_choice == "h"
      HumanPlayer.new(@ui)
    else
      UnbeatableComputer.new(@ui)
    end
  end

end
