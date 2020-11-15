# chess board
class Board
  attr_accessor :board

  def initialize
    @board_size = 8
    @board = Array.new(@board_size){Array.new(@board_size)}
    @knight = Knight.new
  end

  def move_piece
    all_moves = @knight.moves
    valid_moves = all_moves.select { |move| onboard(move) }
    p valid_moves
  end

  def onboard(coord)
    coord[0].between?(0, @board_size - 1) && coord[1].between?(0, @board_size - 1)
  end

  def target_square
    good_input = false
    target = ""
    until good_input
      print "Enter target square, rank & file e.g. 3 5 :  "
      target = gets.chomp.split(" ").map(&:to_i)
      good_input = onboard(target)
    end
    target
  end

  def

end

# knight piece
class Knight
  attr_accessor :postiion

  def initialize
    @start = [0, 0]
    @position = [0, 0]
  end

  def moves(position = @start)
    moves = []
    moves[0] = [position[0] + 2,position[1] + 1]
    moves[1] = [position[0] + 2,position[1] - 1]
    moves[2] = [position[0] - 2,position[1] + 1]
    moves[3] = [position[0] - 2,position[1] - 1]
    moves[4] = [position[0] + 1,position[1] + 2]
    moves[5] = [position[0] - 1,position[1] + 2]
    moves[6] = [position[0] + 1,position[1] - 2]
    moves[7] = [position[0] - 1,position[1] - 2]
    moves
  end
end

game = Board.new
game.move_piece
game.target_square

