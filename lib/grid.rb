class Grid

attr_reader :size

  def initialize(size)
    @size = size
    @cells = []
  end

  def create_cells
    @cells = (0..grid_dimension-1).map {|cell| cell = nil}
  end

  private

  def grid_dimension
    @size * @size
  end

end
