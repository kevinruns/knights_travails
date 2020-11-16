# chess board
class Board
  attr_accessor :board, :board_size

  def initialize
    @board_size = 8
    @board = Array.new(@board_size){Array.new(@board_size)}
  end

  def square_visited(coord)
    return true if @board[rank, file] == 'x'
    rank = coord[0]
    file = coord[1]
    @board[rank, file] = 'x'
  end

end

# node
class Node

  def initialize
    @root = [0,0]
    @parent = nil
  end

end

# knight piece
class Knight
  attr_accessor :postiion

  def initialize
    @position = [0, 0]
  end

  def all_moves(position = @position)
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

class Game
  
  def initialize
    @knight = Knight.new
    @board = Board.new
  end

  def move_piece
    all_moves = @knight.all_moves
    valid_moves = all_moves.select { |move| onboard(move) }
    p valid_moves
  end

  def onboard(coord)
    coord[0].between?(0, @board.board_size - 1) && coord[1].between?(0, @board.board_size - 1)
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

  def knight_moves(start, target)

    node = Node.new
    moves = move_piece

    moves.each do |move|
      if move == target
        print "Congratulations target found \n"
        str = " #{start} , #{move} \n" 
        print str
      else
        node = Node.new()  # TO CONTINUE
      end
    end
    
  end

end

game = Game.new
game.knight_moves([0,0],[1,2])

