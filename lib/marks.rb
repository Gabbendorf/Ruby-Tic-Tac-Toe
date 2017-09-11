module Marks

  X = "X"

  O = "O"

  def self.switch_mark(player_mark)
    if player_mark == O
      X
    else
      O
    end
  end

end
