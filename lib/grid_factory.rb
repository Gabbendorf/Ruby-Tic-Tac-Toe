require_relative 'grid'

class GridFactory 
  
   def create_grid(opponent_player)
     grid_size = opponent_player.grid_size
     Grid.new(grid_size)
   end

end
