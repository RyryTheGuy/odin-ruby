class Knight
  attr_reader :position, :valid_moves, :previous_position

  def initialize(position, previous_position = nil)
    @position = position
    @valid_moves = create_moves
    @previous_position = previous_position
  end
  
  def level_order_search(end_position)
    queue = [self]
    
    # Loop until the queue is empty
    until queue.size == 0
      # Grab the first knight position in the queue
      current = queue.pop
      
      # If the current knight position is the same as the ending position
      break if current.position == end_position
      
      # Add the current Knight position's valid moves and store them in the queue
      current.valid_moves.map { |pos| queue.unshift(Knight.new(pos, current)) }
    end
    
    # Populate the path array with the path taken to the end position
    path = []
    until current.nil?
      path.unshift(current.position)
      current = current.previous_position
    end

    path
  end
  
  private 
  def create_moves(position = @position)
    return nil if position.nil?

    valid_moves = [
      # Move two to the right, and either up or down
      validate_move(position[0] + 2, position[1] + 1),
      validate_move(position[0] + 2, position[1] - 1),
      # Move two to the left, and either up or down
      validate_move(position[0] - 2, position[1] + 1),
      validate_move(position[0] - 2, position[1] - 1),
      # Move two to up, and either right or left
      validate_move(position[0] + 1, position[1] + 2),
      validate_move(position[0] - 1, position[1] + 2),
      # Move two down, and either right or left
      validate_move(position[0] + 1, position[1] - 2),
      validate_move(position[0] - 1, position[1] - 2)
    ].compact

    valid_moves
  end

  def validate_move(x_coord, y_coord)
    return [x_coord, y_coord] if (0..7).include?(x_coord) && (0..7).include?(y_coord)
  end
end

class ChessBoard
  def self.knight_moves(start, end_position)
    k = Knight.new(start)
    # Find the shortest path from start to end
    path = k.level_order_search(end_position)

    # Print out the path the knight took from start to end
    puts "The Knight can go from #{start} to #{end_position} in #{path.size - 1} moves!"
    path.each { |location| p location }
  end
end

ChessBoard.knight_moves([3,3], [4,3])