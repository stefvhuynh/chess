require_relative "sliding_piece"

class Bishop

  def move_dirs
    [
      [ 1,  1], [ 1, -1],
      [-1, -1], [-1,  1]
    ]
  end
  
end


